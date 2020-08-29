import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class Page2 extends StatefulWidget {
  @override
  _Page2State createState() => _Page2State();
}

class _Page2State extends State<Page2> {
  bool selected = false;
  File _image;

  Future getImage(ImageSource imageSource) async {
    var image = await ImagePicker.pickImage(source: imageSource);
    setState(() {
      _image = image;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            child: _image == null
                ? Text('No image selected')
                : Container(
                    child: Image.file(
                      _image,
                      width: 300,
                      height: 300,
                    ),
                  ),
          ),
          SizedBox(
            height: 20,
          ),
          RaisedButton(
            onPressed: () {
              getImage(ImageSource.gallery);
            },
            child: Text('open Photo'),
            textColor: Colors.white,
            color: Colors.pinkAccent,
          ),
          RaisedButton(
            onPressed: () {
              getImage(ImageSource.camera);
            },
            child: Text('open Camera'),
            textColor: Colors.white,
            color: Colors.pinkAccent,
          )
        ],
      ),
    );
  }
}
