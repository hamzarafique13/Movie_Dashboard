// import 'dart:io';

// import 'package:file_picker/file_picker.dart';
// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:flutter/services.dart';
// import 'package:get/get.dart';
// import 'package:image_picker/image_picker.dart';

// class FireStorageUpload {
//   final FirebaseStorage _storage = FirebaseStorage.instance;
//   Future<void> pickImages() async {
//     try {
//       FilePickerResult? result = await FilePicker.platform.pickFiles(
//         type: FileType.custom,
//         allowMultiple: true,
//         allowedExtensions: ['png', 'jpg', 'jpeg', 'heic'],
//       );

//       if (result != null && result.count > 0) {
//         for (var file in result.files) {
//           var storagerf = FirebaseStorage.instance.ref('File/h/${file.name}');
//           File a = File(file.path!);
//           UploadTask uploadTask = storagerf.putFile(a);

//           uploadTask.whenComplete(() {
//             print('Upload completed for: ${file.name}');
//           });
//         }
//       }
//     } on PlatformException catch (e) {
//       print("Error: $e");
//     }
//   }
// }
