#!/bin/sh

# First, name the site...
echo "What is the name of the site you'd like to create? This name should be formatted in all lowercase characters with no spaces."
read sitename

# Get the site admin's email address...
echo "What should we set the site email address to be?"
read site_email

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

echo "You can now log in to your new website at the URL below:"
echo "https://dev-"."$sitename"."pantheonsite.io/wp-login.php"

# TODO
# 1) Push commands for migrating changes back up to git repo;
# 2) Approach for adding plugins, creating themes, enabling plugins, and pushing up changes again;
# 3) Local file management + manipulating directory structure;
# 4) Getting plugins from remote destinations;

# wget https://github.com/Automattic/_s/archive/master.zip


