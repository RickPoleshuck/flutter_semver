# flutter_semver

A command-line tool which simplifies the task of updating your Flutter app's version.


## :sparkles: What's New


## :book: Guide

#### 1. Setup the config file

Add your Flutter Launcher name configuration to your `pubspec.yaml`.
An example is shown below.

```yaml
dev_dependencies: 
  flutter_semver: "^0.0.1"
```


#### 2. Run the package

After setting up the configuration, all that is left to do is run the package.

```
flutter pub get
flutter pub run flutter_semver:nextBuild
flutter pub run flutter_semver:nextPatch
flutter pub run flutter_semver:nextMinor
flutter pub run flutter_semver:nextMajor
```
# flutter_semver
