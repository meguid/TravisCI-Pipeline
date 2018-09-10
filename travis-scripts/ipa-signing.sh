# file: $SCRIPT_FOLDER/ipa-signing.sh
#!/bin/sh
if [[ "$TRAVIS_PULL_REQUEST" != "false" ]]; then
echo "This is a pull request. No deployment will be done."
exit 0
fi
if [[ "$TRAVIS_BRANCH" != "master" ]]; then
echo "Testing on a branch other than master. No deployment will be done."
exit 0
fi

PROVISIONING_PROFILE="$HOME/Library/MobileDevice/Provisioning Profiles/dist.mobileprovision"
OUTPUTDIR="$PROJECT_DIRECTORY/build/Release-iphoneos"

echo "***************************"
echo "*        Signing          *"
echo "***************************"
xcodebuild -exportArchive -sdk iphoneos -archivePath ArchiveFolder/travis-ci-ex.xcarchive -exportPath "$OUTPUTDIR" -exportOptionsPlist "ipa.plist"
