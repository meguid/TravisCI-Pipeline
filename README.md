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
#### Notes:
- Replace **`WORKSPACEPATH`**, **`SCHEME`** and **`BUILDPATH`** with your values.
- It's better to set **`osx_image`** to the same xcode version installed on your local machine for compatibility.
- I prefer to set custom **`derivedDataPath`** so I can access it later for getting coverage percentage.
- Set simulator **`OS`** version mathcing with your **`osx_image`** value (for example xcode10 and 12.0)
- You can change **`Swift`** to **`objective-c`**.

- [x] Add the **`.travis.yml`** file to git, commit and push, to trigger a Travis CI build.
- [x] Check the build status page to see if your build passes or fails.
- [x] Eureka!!, You have built your first baby CI Pipeline.
