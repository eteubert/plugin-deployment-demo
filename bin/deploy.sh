echo "Starting Build"
echo "Tag: $TRAVIS_TAG"
BRANCH_FOR_TAG=`git branch --contains $TRAVIS_TAG | grep -v "detached" | head -n 1 | xargs`
echo "Branch: $TRAVIS_BRANCH / $BRANCH_FOR_TAG"
make build
# add build number to version
sed -i.bak "s/\(Version:.*\)/\1.build$TRAVIS_BUILD_NUMBER/" dist/plugin-deployment-demo.php
rm -f dist/plugin-deployment-demo.php.bak
zip -r latest.zip dist
curl --ftp-create-dirs -T latest.zip -u $FTP_USER:$FTP_PASSWORD ftp://eric.co.de/files/$TRAVIS_REPO_SLUG/$TRAVIS_BRANCH/
echo "Finishing Build"
