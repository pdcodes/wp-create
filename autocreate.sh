#!/bin/sh

# First thing's first, let's get some info...
echo "Hey there techy, let's build you a WP site! For starters, we need to get a bit of information."
echo "What is the name of the site you'd like to create? This name should be formatted in all lowercase characters with no spaces."
read sitename

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
echo "Creating a repo in github."

curl -u "$githubusername" https://api.github.com/orgs/BluetextDC/repos -d '{"name":"'$sitename'"}'

echo "Setting up our remotes."

git remote rename origin pantheon

git remote add github https://github.com/BluetextDC/"$sitename".git

echo "Creating our branch for development."

git checkout -b develop

# Removing Pantheon's gitignore, and replacing it with our own...
echo "Removing Pantheon's gitignore, and replacing it with our own."
rm .gitignore

cp ../gitignore/gitignore.txt .

mv gitignore.txt .gitignore

git add .gitignore

git commit -m ''$sitename'-001: Overwriting pantheon gitignore file.'

echo "Adding the html/ directory."

mkdir html

touch html/readme.txt

echo "Add html files here." > html/readme.txt

echo "Cleaning up the git cache."

git rm -r --cached .

# git update-index --assume-unchanged .

git add -A

git commit -am ''$sitename'-002: Pushing only wp-content/ to Pantheon and Github remotes.'

git push pantheon develop

git push github develop



# sed -i '' 's/PROJECTNAME/wflow-test/g' composer.json

# sublime readme.txt

# Updating the WP admin password...
terminus remote:wp "$sitename".dev -- user update "$site_email" --user_pass=Bluetext1 --skip-email

echo "You can now log in to your using the information below:"
echo "https://dev-""$sitename"".pantheonsite.io/wp-login.php"
echo "Password: Bluetext1"

# TODO
# 1) Push commands for migrating changes back up to git repo;
# 2) Approach for adding plugins, creating themes, enabling plugins, and pushing up changes again;
# 3) Local file management + manipulating directory structure;
# 4) Getting plugins from remote destinations;

# wget https://github.com/Automattic/_s/archive/master.zip


