# file: $SCRIPT_FOLDER/ipa-upload.sh
#!/bin/sh
#if [[ "$TRAVIS_PULL_REQUEST" != "false" ]]; then
#echo "This is a pull request. No deployment will be done."
#exit 0
#fi
#if [[ "$TRAVIS_BRANCH" != "master" ]]; then
#echo "Testing on a branch other than master. No deployment will be done."
#exit 0
#fi

OUTPUTDIR="IPA"
RELEASE_DATE=`date '+%Y-%m-%d %H:%M:%S'`
RELEASE_NOTES="Build: $TRAVIS_BUILD_NUMBER Uploaded: $RELEASE_DATE"

HOCKEY_ID="2e7ea129f2964dfd99fed6d2b1449d5d"
HOCKEY_TOKEN="8ae40bc6e6d09aa8e7acc7ff4d8733a4"

if [ ! -z "$HOCKEY_ID" ] && [ ! -z "$HOCKEY_TOKEN" ]; then

echo ""
echo "***************************"
echo "* Uploading to Hockeyapp  *"
echo "***************************"

curl https://rink.hockeyapp.net/api/2/apps/$HOCKEY_ID/app_versions \
-F status="2" \
-F notify="0" \
-F notes="$RELEASE_NOTES" \
-F notes_type="0" \
-F tags="beta" \
-F ipa="@$OUTPUTDIR/travis-ci-ex.ipa" \
-H "X-HockeyAppToken: $HOCKEY_TOKEN"
fi

if [[ "$TRAVIS_TAG" == "production" ]]; then

echo ""
echo "***************************"
echo "* Uploading to Hockeyapp  *"
echo "***************************"

curl https://rink.hockeyapp.net/api/2/apps/$HOCKEY_APP_ID/app_versions \
-F status="2" \
-F notify="0" \
-F notes="$RELEASE_NOTES" \
-F notes_type="0" \
-F tags="production" \
-F ipa="@$OUTPUTDIR/travis-ci-ex.ipa" \
-F dsym="@$OUTPUTDIR/travis-ci-ex.app.dSYM.zip" \
-H "X-HockeyAppToken: $HOCKEY_APP_TOKEN"
fi
