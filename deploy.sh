#!/bin/sh

echo "Deleting old publication"
# Replace "filename.txt" with the actual name of your file
gh_repository=$(cat reponame.txt)

# Now the variable "file_contents" holds the content of the file


echo "Hint : sudo nano ~/.bashrc and export gh_token= and export gh_token=gh_username should already have been done"
echo GitHub User : $gh_username
echo GitHub Pass : $gh_token
echo GitHub Repo : $gh_repository
git config --global push.autoSetupRemote true
git remote remove origin
git remote add origin https://$gh_username:$gh_token@github.com/klayu/$gh_repository.git
git remote -v


rm -f hugo.toml
rm -rf publicTmp
mkdir publicTmp

echo "Generating site"
npm run build
echo "Copying to gh-pages"
cp -a publicTmp/. ../gh-pages
# cd ../gh-pages
cd ../gh-pages && git add --all && git commit -m "gh-pages branch `date`"
echo "Pushing to github gh-pages branch"
git push origin gh-pages
# HUGO_ENV=production  hugo # -t "ananke"
# echo 'www.mericanrx.com' >> public/CNAME

echo "Updating builder branch"
cd ../builder && rm -rf publicTmp && git add --all && git commit -m "Saving to builder branch"

git push

echo Use : git pull --rebase to check if others have changed before you