# Travis CI Pipelint for iOS
Building a Continues Integration pipeline using Travis CI for iOS Applications.

## Requirements
- [x] A [GitHub](https://github.com) account.
- [x] Owner permissions for a project [hosted on GitHub](https://help.github.com/categories/importing-your-projects-to-github).

## Steps:

- [x] Go to Travis and [Sign up with GitHub](https://travis-ci.com/signin)
- [x] Accept the Authorization of Travis CI. You’ll be redirected to GitHub.
- [x] Click the green Activate button, and select the repositories you want to use with Travis CI.

- [x] Add a **`.travis.yml`**  file to your repository to tell Travis CI what to do. 

  ```bash
  language: swift
  osx_image: xcode10  
  script:
  - xcodebuild -workspace WORKSPACEPATH -scheme SCHEME -derivedDataPath BUILDPATH -destination 'platform=iOS Simulator,OS=12.0,name=iPhone 7' -enableCodeCoverage YES clean build test
  ```
- [x] Add the **`.travis.yml`** file to git, commit and push, to trigger a Travis CI build.
- [x] Check the build status page to see if your build passes or fails.
- [x] YOU MADE IT!! You have built your first baby CI Pipeline.

#### Notes:
- Replace **`WORKSPACEPATH`**, **`SCHEME`** and **`BUILDPATH`** with your values.
- It's better to set **`osx_image`** to the same xcode version installed on your local machine for compatibility.
- I prefer to set custom **`derivedDataPath`** so I can access it later for getting coverage percentage.
- Set simulator **`OS`** version mathcing with your **`osx_image`** value (for example xcode10 and 12.0)
- You can change **`Swift`** to **`objective-c`**.

## Running your Tests and break the build in case of failure in Tests:

- [x] Open up the Manage Schemes sheet by selecting the Product → Schemes → Manage Schemes… menu option.
- [x] Locate the target you want to use for testing in the list. 
- [x] Ensure that the Shared checkbox in the far right hand column of the sheet is checked.
- [x] If your target include cross-project dependencies such as CocoaPods, then you will need to ensure that they have been configured as explicit dependencies. 

     To do so:
     - Highlight your application target and hit the Edit… button to open the Scheme editing sheet.
     - Click the Build tab in the left-hand panel of the Scheme editor.
     - Click the + button and add each dependency to the project. CocoaPods will appear as a static library named Pods.
     - Drag the dependency above your test target so it is built first.

- [x] You will now have a new file in the xcshareddata/xcschemes directory underneath your Xcode project. This is the shared Scheme that you just configured. Check this file into your repository and xcodebuild will be able to find and execute your tests.
