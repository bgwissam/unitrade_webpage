import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:unitrade_website/models/photos.dart';
import 'package:unitrade_website/screens/company/photo_gallery_list.dart';
import 'package:unitrade_website/services/database.dart';


class PhotoGalleryGrid extends StatefulWidget {
  @override
  _PhotoGalleryGridState createState() => _PhotoGalleryGridState();
}

class _PhotoGalleryGridState extends State<PhotoGalleryGrid> {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<List<Photos>>(
      create: (_) => DatabaseService().photoList(),
      child: _buildPhotoGallery(),
      catchError: (_, error) {
        print('We could not get data due to: $error');
        return error;
      },
    );
  }

  Widget _buildPhotoGallery() {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Container(
        child: PhotoGalleryList(),
      ),
    );
  }
}