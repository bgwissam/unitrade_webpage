// ignore: avoid_web_libraries_in_flutter
import 'dart:html';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:firebase/firebase.dart' as webFireStorage;

class FireStorageService extends ChangeNotifier {
  FireStorageService();

  Future<dynamic> loadFromStorage(BuildContext context, String image) async {
    try {
      var ref = await FirebaseStorage.instance
          .ref()
          .child(image)
          .getDownloadURL()
          .then((value) {
        if (value != null) {
          print('Downloaded image: $value');
        }
      });
      return ref;
    } catch (e) {
      print('Failed to get image: $e');
      return null;
    }
  }

  Future<List<String>> uploadToStorage(List<File> imagesList) async {
    List<String> downloadedUrls = [];
    webFireStorage.StorageReference storageReference;
    if (imagesList.isNotEmpty) {
      for (var image in imagesList) {
        if (image != null) {
          storageReference = webFireStorage
              .storage()
              .ref()
              .child('photo_gallery/${image.name}');

          webFireStorage.UploadTaskSnapshot uploadTaskSnapshot =
              await storageReference.put(image).future;

          Uri imageUrl = await uploadTaskSnapshot.ref.getDownloadURL();
          downloadedUrls.add(imageUrl.toString());
        }
      }
    }

    return downloadedUrls;
  }
}
