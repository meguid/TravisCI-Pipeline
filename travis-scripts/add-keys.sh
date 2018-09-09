# file: $SCRIPT_FOLDER/add-keys.sh
#!/bin/sh

# Print Software Version
echo "***************************"
echo "*        Software         *"
echo "***************************"
echo "Cocoapods version is"
pods --version
echo "XCTool version is"
xctool -v

# Create custom Keychains
echo "***************************"
echo "*        Adding Keys       *"
echo "***************************"

if [ "$CERT_FOLDER" == "" ]; then
# Get the right certificate from GitHub
git clone git@github.com:User/repo.git ./ios-distribution
CERT_FOLDER = "ios-distribution"
fi

# Create a custom keychain
security create-keychain -p travis ios-build.keychain

# Make the custom keychain default, so xcodebuild will use it for signing
security default-keychain -s ios-build.keychain

# Unlock the keychain
security unlock-keychain -p travis ios-build.keychain

# Set keychain timeout to 1 hour for long builds
# see http://www.egeek.me/2013/02/23/jenkins-and-xcode-user-interaction-is-not-allowed/
security set-keychain-settings -t 3600 -l ~/Library/Keychains/ios-build.keychain

# Add certificates to keychain and allow codesign to access them
security import ./$CERT_FOLDER/AppleWorldwide.cer -k ~/Library/Keychains/ios-build.keychain -T /usr/bin/codesign
security import ./$CERT_FOLDER/iOS_Distribution_Certificate.cer -k ~/Library/Keychains/ios-build.keychain -T /usr/bin/codesign
security import ./$CERT_FOLDER/private_key.p12 -k ~/Library/Keychains/ios-build.keychain -P "$PRIVATE_KEY_PASSWORD" -T /usr/bin/codesign

# Put the provisioning profile in place
mkdir -p ~/Library/MobileDevice/Provisioning\ Profiles
cp ./$CERT_FOLDER/Provisioning_Profile.mobileprovision ~/Library/MobileDevice/Provisioning\ Profiles/
