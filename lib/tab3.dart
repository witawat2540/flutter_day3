import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:video_player/video_player.dart';

class Tab3 extends StatefulWidget {
  @override
  _Tab3State createState() => _Tab3State();
}

class _Tab3State extends State<Tab3> {
  File _video;
  bool status = false;
  VideoPlayerController _playerController;

  _pickVideo(ImageSource imageSource) async {
    try {
      File video = await ImagePicker.pickVideo(source: imageSource);
      _video = video;
      _playerController = VideoPlayerController.file(_video)
        ..initialize().then((_) {
          setState(() {
            _playerController.setLooping(true);
            //_playerController.play();
          });
        });
    } catch (err) {}
  }

  _player_Video() async {
    try {
      //File video = await ImagePicker.(source:imageSource);
      //_video = video;
      _playerController = VideoPlayerController.asset('video/catoon.mp4')
        ..initialize().then((_) {
          setState(() {
            status = true;
            _playerController.setLooping(true);
          });
        });
    } catch (err) {}
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: SingleChildScrollView(
        child: Column(
          children: [
            if (_video != null || status)
              _playerController.value.initialized
                  ? Container(
                      height: 500,
                      width: 400,
                      child: AspectRatio(
                        aspectRatio: _playerController.value.aspectRatio,
                        child: VideoPlayer(_playerController),
                      ),
                    )
                  : Container()
            else
              Text("Click on Pick Video to select video"),
            RaisedButton(
              onPressed: () {
                _pickVideo(ImageSource.gallery);
              },
              child: Text('เปิดจาก gallery'),
              color: Colors.pinkAccent,
              textColor: Colors.white,
            ),
            SizedBox(
              height: 20,
            ),
            RaisedButton(
              onPressed: () {
                _pickVideo(ImageSource.camera);
              },
              child: Text('เปิดจาก Camera'),
              color: Colors.pinkAccent,
              textColor: Colors.white,
            ),
            SizedBox(
              height: 20,
            ),
            RaisedButton(
              onPressed: () {
                _player_Video();
              },
              child: Text('เปิดจาก asset'),
              color: Colors.pinkAccent,
              textColor: Colors.white,
            ),
            SizedBox(
              height: 20,
            ),
            RaisedButton(
              onPressed: () {
                setState(() {
                  _playerController.value.isPlaying
                      ? _playerController.pause()
                      : _playerController.play();
                });
              },
              child: Text('เล่น/หยุด'),
              color: Colors.pinkAccent,
              textColor: Colors.white,
            )
          ],
        ),
      ),
    );
  }
}
