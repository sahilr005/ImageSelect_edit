import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'dart:io';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

imagePickEdit(context) async {
  return await Navigator.push(
      context, MaterialPageRoute(builder: (a) => const GalleryCamareImage()));
}

class GalleryCamareImage extends StatefulWidget {
  const GalleryCamareImage({Key? key}) : super(key: key);

  @override
  _GalleryCamareImageState createState() => _GalleryCamareImageState();
}

class _GalleryCamareImageState extends State<GalleryCamareImage> {
  CameraController? controller;
  // ignore: unused_field
  XFile? pictureFile;
  dynamic val;
  XFile? video;
  File? selectedCropImage;
  bool isrecording = false;
  bool redy = false;
  @override
  void initState() {
    super.initState();
    availableCameras().then((value) {
      val = value;
    }).then((value) {
      controller = CameraController(
        val[0],
        ResolutionPreset.max,
      );
      controller!.initialize().then((_) {
        if (!mounted) {
          return;
        }
        redy = true;
        setState(() {});
      });
    });
  }

  _cropImage(filePath) async {
    var croppedImage = await ImageCropper()
        .cropImage(sourcePath: filePath, maxWidth: 1080, maxHeight: 1080);
    if (croppedImage != null) {
      selectedCropImage = File(croppedImage.path);
      Navigator.pop(context, croppedImage);
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: redy
          ? Column(
              mainAxisAlignment: MainAxisAlignment.end,
              mainAxisSize: MainAxisSize.max,
              children: [
                selectedCropImage != null
                    ? Expanded(
                        // height: Get.height,
                        child: Image.file(
                          File(selectedCropImage!.path),
                          fit: BoxFit.fill,
                        ),
                      )
                    : Expanded(
                        // flex: 4,
                        // height: Get.height / 1.2,
                        // width: Get.width,
                        child: CameraPreview(controller!)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(width: 60),
                    InkWell(
                      onTap: () async {
                        pictureFile = await controller!.takePicture();
                        if (pictureFile != null) {
                          //  Get.back();
                          _cropImage(pictureFile!.path);
                        }
                        setState(() {});
                      },
                      child: Container(
                        height: 100,
                        child: pictureFile != null
                            ? Icon(
                                Icons.check,
                                size: 35,
                              )
                            : Icon(Icons.camera_alt_outlined, size: 45),
                      ),
                    ),
                    InkWell(
                      onTap: () async {
                        var status = await Permission.camera.status;
                        if (status.isDenied) {
                          await [
                            Permission.camera,
                            Permission.storage,
                          ].request().then((value) async {
                            final ImagePicker _picker = ImagePicker();
                            pictureFile = (await _picker.pickImage(
                                source: ImageSource.gallery))!;
                            if (pictureFile != null) {
                              _cropImage(pictureFile!.path);
                            }
                            setState(() {});
                          });
                          setState(() {});
                        }
                        if (await Permission.storage.isPermanentlyDenied) {
                          openAppSettings();
                        }
                        if (status.isGranted) {
                          final ImagePicker _picker = ImagePicker();
                          pictureFile = (await _picker.pickImage(
                              source: ImageSource.gallery))!;
                          print(pictureFile!.name);
                          if (pictureFile != null) {
                            _cropImage(pictureFile!.path);
                          }
                          setState(() {});
                        }
                      },
                      child: Container(
                        height: 100,
                        padding: EdgeInsets.only(right: 25),
                        child: Icon(Icons.photo, size: 35),
                      ),
                    ),
                  ],
                )
              ],
            )
          : const Center(
              child: CircularProgressIndicator(),
            ),
    );
  }
}
