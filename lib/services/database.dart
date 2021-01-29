import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:unitrade_website/models/photos.dart';
import 'package:unitrade_website/models/users.dart';

class DatabaseService {
  final String uid;
  DatabaseService({this.uid});
  final CollectionReference photoGalleryCollection =
      FirebaseFirestore.instance.collection('photoGallery');
  final CollectionReference usersCollection =
      FirebaseFirestore.instance.collection('users');

  //Register a new User
  Future<String> setUserData(
      {String uid,
      String emailAddress,
      List<dynamic> roles,
      String fullName}) async {
    try {
      return await usersCollection.doc(uid).set({
        'fullName': fullName,
        'emailAddress': emailAddress,
        'roles': roles,
      }).then((value) {
        return 'your data has been updated successfully';
      });
    } catch (e) {
      return ' $e';
    }
  }

  //Get current user details
  List<Users> _userDataFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((snapshot) {
      return Users(
          uid: uid,
          fullName: snapshot.data()['fullName'],
          emailAddress: snapshot.data()['emailAddress'],
          roles: snapshot.data()['roles']);
    });
  }

  Future<Users> getCurrentUserRoles(String userId) async {
    return await usersCollection.doc(userId).get().then((value) {});
  }

  //Add a new image to the photo gallery album
  Future<String> addNewPhoto(
      {String photoName,
      List<String> photoUrl,
      String photoCaption,
      String photoCategory}) async {
    try {
      return await photoGalleryCollection.add({
        'photoName': photoName,
        'photoUrl': photoUrl,
        'photoCaption': photoCaption,
        'photoCategory': photoCategory
      }).then((value) {
        if (value != null) {
          return 'Youre photo has been added successfully';
        }
        return 'Failed to add your image';
      });
    } catch (e) {
      return 'Failed to upload image: $e';
    }
  }

  //Update a current image
  Future<String> updateCurrentPhoto(
      {String uid,
      String photoName,
      List<String> photoUrl,
      String photoCaption,
      String photoCategory}) async {
    try {
      return await photoGalleryCollection.doc(uid).set({
        'photoName': photoName,
        'photoUrl': photoUrl,
        'photoCaption': photoCaption,
        'photoCategory': photoCategory
      }).then((value) {
        return 'Youre photo has been updatd successfully';
      });
    } catch (e) {
      return 'Failed to update image: $e';
    }
  }

  //Read current photos from the database
  List<Photos> _photoDataFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((snapshot) {
      return Photos(
          uid: uid,
          photoName: snapshot.data()['photoName'] ?? '',
          photoUrl: snapshot.data()['photoUrl'] ?? '',
          photoCaption: snapshot.data()['photoCaption'] ?? '',
          category: snapshot.data()['category'] ?? '');
    }).toList();
  }

  //get all photos
  Stream<List<Photos>> photoList() {
    return photoGalleryCollection.snapshots().map(_photoDataFromSnapshot);
  }
}
