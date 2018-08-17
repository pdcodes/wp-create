#!/bin/sh

set timeout -1

# First thing's first, let's get some info...
echo "Hey there techy, let's build you a WP site! For starters, we need to get a bit of information."
echo "What is the machine-readable name of the site you'd like to create? This name should be formatted in all lowercase characters with no spaces."
read sitename

echo "Enter the friendly name of the site below:"
read friendlyname

# Get the site admin's email address...
echo "Enter the site's desired admin email address:"
read site_email

echo "Enter your github username:"
read githubusername

# Create the site in Pantheon...
terminus site:create --org Bluetext "$sitename" "$sitename" e8fe8550-1ab9-4964-8838-2b9abdccf4bf

# Setting connection mode to git...
terminus connection:set "$sitename".dev git

# Running through install process...
terminus remote:wp "$sitename".dev core install -- --title="$sitename" --admin_user=admin --admin_email="$site_email"

# Getting the site ID of the newly created site...
UUID=$(terminus site:lookup "$sitename")

# Cloning the site down locally...
git clone ssh://codeserver.dev."$UUID"@codeserver.dev."$UUID".drush.in:2222/~/repository.git "$sitename"

# Moving into the new directory
echo "Moving into the new directory."
cd "$sitename"

# Creating a repo in github...
echo "Creating a repo in github and setting up our remotes."
curl -u "$githubusername" https://api.github.com/orgs/BluetextDC/repos -d '{"name":"'$sitename'"}'
git remote rename origin pantheon
git remote add github https://github.com/BluetextDC/"$sitename".git

# Installing plugins via composer...
echo "Copying composer.default.json and running composer install."
cp ../composer/composer.default.json .
mv composer.default.json composer.json
eval "sed -i '' s/PROJECTNAME/$sitename/g composer.json"
composer install
cp -r ../acf/plugin/ wp-content/plugins/

echo "Pushing changes to github."
git add -A
git commit -am ''$sitename'-001: Installing default plugins.'
git push pantheon master
git push github master 

# Installing base theme...
echo "Moving into the wp-content/themes directory."
cd wp-content/themes
echo "Generating _s base theme and removing everything else."
underscores -n "$friendlyname" -d "Custom theme for $friendlyname website." -g "$friendlyname" -a "Bluetext <technology@bluetext.com>" -u "https://bluetext.com" -s -k
shopt -s extglob
rm -rf !("$friendlyname" | index.php)