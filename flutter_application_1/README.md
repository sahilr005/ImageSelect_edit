How use GalleryCamerImage Widget

```
  Kotlin version Should Be :'1.6.10'
     ext.kotlin_version = '1.6.10' or leter...
```

```dart
 await Get.to(() => GalleryCamareImage(
                              fromEditProfile: true,
      ))!
      .then((value) {
    if (value != null) selectedCropImage = value;
   });
```