How to install #
Android 
1. Add UCropActivity into your AndroidManifest.xml
```xml
<activity
    android:name="com.yalantis.ucrop.UCropActivity"
    android:screenOrientation="portrait"
    android:theme="@style/Theme.AppCompat.Light.NoActionBar"/>
```
2. Change the minimum Android sdk version to 21 (or higher) in your android/app/build.gradle file.

```java
minSdkVersion 21
```
Change kotlin version :- android/build.gradle
```java
     ext.kotlin_version = '1.6.10' 
```

How use GalleryCamerImage Widget

```dart
 await Get.to(() => GalleryCamareImage(
                              fromEditProfile: true,
      ))!
      .then((value) {
    if (value != null) selectedCropImage = value;
   });
```
