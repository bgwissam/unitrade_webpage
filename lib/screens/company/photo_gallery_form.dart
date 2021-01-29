// ignore: avoid_web_libraries_in_flutter
import 'dart:html';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:unitrade_website/models/photos.dart';
import 'package:unitrade_website/services/database.dart';
import 'package:unitrade_website/services/storage.dart';
import 'package:unitrade_website/shared/constants.dart';
import 'package:unitrade_website/shared/string.dart';
import 'package:flutter/painting.dart' as painting;
import 'package:image_whisperer/image_whisperer.dart' as whisperer;

class PhotoGalleryForm extends StatefulWidget {
  final Photos photo;
  PhotoGalleryForm({this.photo});
  @override
  _PhotoGalleryFormState createState() => _PhotoGalleryFormState();
}

class _PhotoGalleryFormState extends State<PhotoGalleryForm> {
  final _formKey = new GlobalKey<FormState>();

  String photoName, photoCaption, photoCategory, photoUrl;
  double columnSizedBox = 15.0;
  //Image file
  List<painting.NetworkImage> image = []..length = 5;
  painting.NetworkImage tempImage;
  List<File> images;
  Uint8List imageUpload;
  String errorText;
  List<dynamic> imageListUrls = [];

  void initState() {
    super.initState();
    images = []..length = 5 - imageListUrls.length;
  }

  //get Images for local strage
  Future<painting.NetworkImage> _startImagesPicker(int index) async {
    InputElement uploadInput = FileUploadInputElement();
    uploadInput.click();
    uploadInput.onChange.listen((event) {
      //Read file content as dataUrl
      final files = uploadInput.files;
      if (files.length == 1) {
        images[index] = files[0];

        FileReader reader = FileReader();
        reader.onLoadEnd.listen((event) {
          setState(() {
            imageUpload = reader.result;
          });
        });
        reader.onError.listen((event) {
          setState(() {
            errorText = 'The following error occured: $event';
          });
        });
        reader.readAsArrayBuffer(images[index]);
        whisperer.BlobImage blobImage =
            new whisperer.BlobImage(images[index], name: images[index].name);

        setState(() {
          tempImage = painting.NetworkImage(blobImage.url);
          if (index < imageListUrls.length) {
            imageListUrls.removeAt(index);
            image[index] = tempImage;
          } else {
            print('New image was added: $tempImage at index $index');
            image[index] = tempImage;
          }
        });
      }
    });
    return tempImage;
  }

  //Image upload widget
  Widget showSelectedImage(int index) {
    if (image[index] != null)
      return Container(
          child: Image.network(
        image[index].url,
        height: 200.0,
        width: 200.0,
      ));
    else
      return Container(
        child: Text(CANNOT_READ_IMAGE, textAlign: TextAlign.center),
        height: 200.0,
        width: 200.0,
      );
  }

  //Just for testing
  Widget _buildImageAvailable(int index) {
    return Image.network(
      imageListUrls[index],
      fit: BoxFit.contain,
      width: 200.0,
      height: 200.0,
    );
  }

  //Upload Image to firebase storage
  Future<List<String>> uploadPhotoGalleryImages(List<File> imagesList) async {
    FireStorageService fireStorageService = new FireStorageService();
    if(images.isNotEmpty){
      return fireStorageService.uploadToStorage(imagesList);
    } else {
      print('your image File List is empty!');
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(TITLE_PHOTO_FORM),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: new Form(
          key: _formKey,
          child: Container(
              width: 800.0,
              child: _photoGalleryForm()),
        ),
      ),
    );
  }

  Widget _photoGalleryForm() {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            child: TextFormField(
              initialValue: '',
              decoration: textInputDecoration.copyWith(labelText: PHOTO_NAME),
              validator: (val) => val.isEmpty ? PHOTO_NAME_VALIDATION : null,
              onChanged: (val) {
                if (val != null) {
                  photoName = val;
                }
              },
            ),
          ),
          SizedBox(
            height: columnSizedBox,
          ),
          Container(
            child: TextFormField(
              initialValue: '',
              decoration:
                  textInputDecoration.copyWith(labelText: PHOTO_CAPTION),
              validator: (val) => val.isEmpty ? PHOTO_CAPTION_VALIDATION : null,
              onChanged: (val) {
                if (val != null) {
                  photoCaption = val;
                }
              },
            ),
          ),
          SizedBox(
            height: columnSizedBox,
          ),
          Container(
            child: TextFormField(
              initialValue: '',
              decoration:
                  textInputDecoration.copyWith(labelText: PHOTO_CATEGORY),
              validator: (val) =>
                  val.isEmpty ? PHOTO_CATEGORY_VALIDATION : null,
              onChanged: (val) {
                if (val != null) {
                  photoCategory = val;
                }
              },
            ),
          ),
          SizedBox(
            height: columnSizedBox,
          ),
          Container(
            padding: EdgeInsets.all(8.0),
            height: 200,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: 5,
              itemBuilder: (context, index) {
                return index < imageListUrls.length
                    ? Container(
                        margin: const EdgeInsets.all(4.0),
                        width: 150,
                        height: 200,
                        decoration: BoxDecoration(border: Border.all()),
                        child: InkWell(
                          child: _buildImageAvailable(index),
                          onTap: () async {
                            _startImagesPicker(index);
                          },
                        ),
                      )
                    : Container(
                        margin: const EdgeInsets.all(4.0),
                        width: 150,
                        height: 200,
                        decoration: BoxDecoration(border: Border.all()),
                        child: InkWell(
                          child: image[index] == null
                              ? new Icon(Icons.add,
                                  size: 72, color: Colors.grey)
                              : showSelectedImage(index),
                          onTap: () async {
                            _startImagesPicker(index);
                          },
                        ),
                      );
              },
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            child: RaisedButton(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0)),
              color: Colors.blue,
              child:
                  widget.photo == null ? Text(ADD_PHOTO) : Text(UPDATE_PHOTO),
              onPressed: () async {
                if (_formKey.currentState.validate()) {
                  var result;

                  List<String> imageUrls = await uploadPhotoGalleryImages(images);

                  if (widget.photo == null && imageUrls.isNotEmpty)
                    result = DatabaseService().addNewPhoto(
                        photoName: photoName,
                        photoUrl: imageUrls,
                        photoCaption: photoCaption,
                        photoCategory: photoCategory);
                  else
                    result = DatabaseService().updateCurrentPhoto(
                      photoName: photoName,
                      photoUrl: imageUrls,
                      photoCaption: photoCaption,
                      photoCategory: photoCategory,
                    );
                  if (result != null) {
                    print('The photo was added successfully: $result');
                    Navigator.pop(context);
                  }
                }
              },
            ),
          )
        ],
      ),
    );
  }
}
