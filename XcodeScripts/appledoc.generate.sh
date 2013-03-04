#! /bin/sh

# Input arguments: 
# $1 -> project name
# $2 -> project path
# $3 -> company name

# dynamic variables
docsURL="http://www.$3.com/docs";
projectsPath="$2/../";
docsPath="${2}/docs/build";

#say "project is: $1";
#say "path is: $2";
#say "company is: $3";
#say "project path is: ${projectsPath}";

# create AppleDocOutput folder if not exists
if [ ! -d $docsPath ];
then
    #say "create output folder";
    mkdir "${docsPath}";
fi

#say "run appledoc";

#invoke appledoc passing computed arguments
/usr/local/bin/appledoc \
--project-name "$1" \
--output "${docsPath}/$1/" \
--ignore "$1Tests" \
--keep-undocumented-objects \
--keep-undocumented-members \
--search-undocumented-doc \
"$2" > "${docsPath}/AppleDoc.log"

# Unused switched
#--docset-feed-url "${docsURL}/%DOCSETATOMFILENAME" \                                                                                                                                                      
#--docset-package-url "${docsURL}/%DOCSETPACKAGEFILENAME" \                                                                                                                                                
#--docset-fallback-url "${docsURL}/$1Doc/" \  
#--no-create-docset \