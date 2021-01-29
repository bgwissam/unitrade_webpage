import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:unitrade_website/models/photos.dart';
import 'package:unitrade_website/screens/company/photo_gallery_tiles.dart';
import 'package:unitrade_website/shared/loading.dart';

class PhotoGalleryList extends StatefulWidget {
  @override
  _PhotoGalleryListState createState() => _PhotoGalleryListState();
}

class _PhotoGalleryListState extends State<PhotoGalleryList> {
  List<Photos> photos;
  @override
  Widget build(BuildContext context) {
    photos = Provider.of<List<Photos>>(context) ?? [];
    return photos.length > 0 ? Container(
      width: MediaQuery.of(context).size.width,
      child: GridView.count(
        crossAxisCount: 5,
        children: List.generate(photos.length, (index) {
          return PhotoGalleryTiles(photos: photos[index],);
        })
      ),
    ): Container(
      child: Center(child: Loading(),),
    );
  }
}