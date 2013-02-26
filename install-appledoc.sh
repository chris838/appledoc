#!/usr/bin/env bash

# Enable errexit: Exit if any "simple command" fails
set -e

BINARY_DIR=/usr/local/bin/
TEMPLATES_DIR=~/.appledoc

usage() {
cat <<EOF
Usage: $0 [-b binary_path] [-t templates_path]

Builds and installs appledoc

OPTIONS:
    -b  Path where binary will be installed. Default is $BINARY_DIR
    -t  Path where templates will be installed. Default is $TEMPLATES_DIR
    
EOF
}

while getopts "hb:t:" OPTION
do
	case $OPTION in
		h) usage
		   exit 0;;
		b)
		   BINARY_DIR=$OPTARG;;
		t)
		   INSTALL_TEMPLATES="YES"
           echo "arg is = $OPTARG"
		   if [ $OPTARG != "default" ]; then
		      TEMPLATES_DIR=$OPTARG
		   fi
		   ;;
		[?])
			usage
			exit 1;;
	esac
done

echo "Building..."
xcodebuild -target appledoc -configuration Release install

echo "Installing binary to $BINARY_DIR"
cp /tmp/appledoc.dst/usr/local/bin/appledoc "$BINARY_DIR"

echo "Installing Xcode generate script to $BINARY_DIR"
cp XcodeScripts/appledoc.generate.sh "$BINARY_DIR"

echo "Installing AppleScript to /Library/Scripts/"
cp XcodeScripts/appledoc.scpt /Library/Scripts/

if [ "$INSTALL_TEMPLATES" == "YES" ]; then
    echo "Copying templates to $TEMPLATES_DIR"
    cp -R Templates/ "$TEMPLATES_DIR"
fi