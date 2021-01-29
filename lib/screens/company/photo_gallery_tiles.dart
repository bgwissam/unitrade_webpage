import 'package:flutter/material.dart';
import 'package:unitrade_website/models/photos.dart';
import 'package:unitrade_website/shared/constants.dart';
import 'package:unitrade_website/shared/loading.dart';

class PhotoGalleryTiles extends StatefulWidget {
  final Photos photos;
  PhotoGalleryTiles({this.photos});
  @override
  _PhotoGalleryTilesState createState() => _PhotoGalleryTilesState();
}

class _PhotoGalleryTilesState extends State<PhotoGalleryTiles> {
  String imageUrl;
  //Future to the the Future Builder
  Future<Widget> _getImage(BuildContext context, String imageUrl) async {
    Image photoImage;
    return photoImage;
  }

  //Return the stack of images for the dialog box
  _contentBox(BuildContext context, String imageUrl) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
          child: FadeInImage(
        fit: BoxFit.contain,
        image: NetworkImage(
          imageUrl,
        ),
        placeholder: AssetImage('assets/images/placeholder.jpg'),
      )),
    );
  }

  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: FutureBuilder(
        future: _getImage(context, widget.photos.photoUrl[0]),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Container(
              child: Loading(),
            );
          }
          if (snapshot.connectionState == ConnectionState.done) {
            if (widget.photos.photoUrl[0] != null)
              return _buildPhotoList(widget.photos.photoUrl[0]);
          } else {
            return Loading();
          }
          return Container(child: Text('Failed to load data'));
        },
      ),
    );
  }

  Widget _buildPhotoList(String imageUrl) {
    double _photoWidth = MediaQuery.of(context).size.width;
    if (imageUrl != null)
      return Padding(
        padding: const EdgeInsets.all(12.0),
        child: InkWell(
          onTap: () {
            showDialog(
                context: context,
                builder: (BuildContext context) {
                  return Container(
                    width: _photoWidth/5,
                    child: AlertDialog(
                      shape: RoundedRectangleBorder(
                          side: BorderSide(width: 2.0),
                          borderRadius: BorderRadius.circular(12.0)),
                      elevation: 1.0,
                      backgroundColor: Colors.transparent,
                      content: Center(
                        child: Container(
                            width: 500.0,
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: widget.photos.photoUrl.length,
                              itemBuilder: (context, index) {
                                return _contentBox(context,
                                    widget.photos.photoUrl[index].toString());
                              },
                            )),
                      ),
                    ),
                  );
                });
          },
          child: Stack(
            alignment: Alignment.topCenter,
            fit: StackFit.expand,
            children: [
              Container(
                height: 150.0,
                width: 75.0,
                child: FadeInImage(
                  fit: BoxFit.contain,
                  image: NetworkImage(
                    widget.photos.photoUrl[0] ?? '',
                  ),
                  placeholder: AssetImage('assets/images/placeholder.jpg'),
                ),
              ),
               Container(
                child: Center(child: Text(widget.photos.photoName, style: textStyleParagraph7,)),
              ),
             
            ],
          ),
        ),
      );
    return Container(
      child: Text(
        'Sorry, image could not be loaded',
        style: textStyleParagraph6,
      ),
    );
  }
}
