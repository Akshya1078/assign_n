

import 'package:assign_n/view/story_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';


class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var imageFile;
  final picker = ImagePicker();



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xffff2911),
        centerTitle:true,
        title:Text("Yoro"),
      ),
      body: const SafeArea(
        child: Center(
          child: Text("Hey! welcome to Yoro"),

        ),
      ),
      floatingActionButton: Row(
        children: [
          GestureDetector(
            onTap: (){
              _showPicker(context);
            },

            child: Container(
              height: 50,
              width: 200,
              decoration: BoxDecoration(
                  color: Color(0xffff2911),
                  borderRadius: BorderRadius.circular(20)
              ),
              child: const Center(child: Text("Create Your Story ",
                style: TextStyle(color: Colors.white,
                fontWeight: FontWeight.w500),)),
            ),
          ),

        ],
      )
    );
  }
  chooseImage(ImageSource source,String SourceName) async {
    final pickedFile = await picker.getImage(source: source,imageQuality: 50);
    setState(() {
      imageFile = File(pickedFile!.path);
    });
    if(pickedFile!=null){
      Get.to(StoryScreen(fileImage: imageFile));
    }else{
      Get.back();
      return 0;
    }
    return imageFile;
  }

  void _showPicker(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Container(
              child:  Wrap(
                children: <Widget>[
                  ListTile(
                      leading: const Icon(Icons.photo_library),
                      title: const  Text('Photo Library'),
                      onTap: () {
                        chooseImage(ImageSource.gallery,"Gallery");
                        Get.back();
                      }),
                ],
              ),
            ),
          );
        }
    );
  }
}
