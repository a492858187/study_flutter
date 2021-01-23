import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:video_player/video_player.dart';
import 'package:webview_flutter/webview_flutter.dart';

class VideoPlayerPage extends StatefulWidget{

  @override
  State<StatefulWidget> createState() {
    return VideoPlayerPageState();
  }

}

class VideoPlayerPageState extends State<VideoPlayerPage>{

  VideoPlayerController _playerController;

  @override
  void initState() {
    super.initState();
    _playerController = VideoPlayerController.network("http://vjs.zencdn.net/v/oceans.mp4")
                        ..initialize().then((value) => this.setState(() {}));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("视频播放"),
      ),
      body: Center(
        child: VideoPlayer(_playerController)
        // _playerController.value.initialized
        //     ? AspectRatio(
        //         aspectRatio: _playerController.value.aspectRatio,
        //         child:VideoPlayer(_playerController)
        //       )
        //     : Container(),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(_playerController.value.isPlaying ? Icons.pause : Icons.play_arrow),
        onPressed: (){
          setState(() {
            _playerController.value.isPlaying ? _playerController.pause() : _playerController.play();
          });
        },
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _playerController.dispose();
  }

}