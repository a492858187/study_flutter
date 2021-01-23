import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:dio/dio.dart';
import 'dart:io';

class ImagePickerPage extends StatefulWidget{

  @override
  State<StatefulWidget> createState() {
    return ImagePickerPageState();
  }

}

class ImagePickerPageState extends State<ImagePickerPage>{

  File _imgPath;

  @override
  void initState() {
    super.initState();
  }

  Widget _getImageFile(){
    if(_imgPath == null)
      return Text("请按指示操作");
    else
      return Image.file(_imgPath);
  }

  //上传图片到服务器
  _uploadImage() async {
    FormData formData = FormData.fromMap({
      //"": "", //这里写其他需要传递的参数
      "file": await MultipartFile.fromFile(_imgPath.path, filename:"imageName.png"),
    });
    var response =
    await Dio().post("http://jd.itying.com/imgupload", data: formData);
    print(response);
    if (response.statusCode == 200) {
      Map responseMap = response.data;
      print("http://jd.itying.com${responseMap["path"]}");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("调用相机拍照和相册选取"),
      ),
      body: Column(
        children: [
          _getImageFile(),
          RaisedButton(
              child:Text("调用相机"),
              onPressed: () async {
                var image = await ImagePicker.pickImage(source: ImageSource.camera);
                setState(() {
                  _imgPath = image;
                });
              }
          ),
          RaisedButton(
              child:Text("相册选取"),
              onPressed: () async {
                var image = await ImagePicker.pickImage(source: ImageSource.gallery);
                setState(() {
                  _imgPath = image;
                });
              }
          ),
          RaisedButton(
              child:Text("上传图片"),
              onPressed: () async {
                _uploadImage();
              }
          ),
        ],
      )
      // ListView(
      //   children: [
      //     Html(
      //       data: "${_html.length > 0 ? _html[0]["content"] : 1}"
      //     )
      //   ],
      // ),
    );
  }

}