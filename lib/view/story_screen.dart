
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'homepage.dart';



class StoryScreen extends StatefulWidget {
  File fileImage;
  StoryScreen({required this.fileImage}) ;

  @override
  _StoryScreenState createState() => _StoryScreenState();
}

class _StoryScreenState extends State<StoryScreen> {

  bool textEnable=false;
  double size=20;
  bool zoomEnable=false;
  final FocusNode _focusNode = FocusNode();
  var _x = 20.8;
  var _y = 30.8;
  final GlobalKey stackKey = GlobalKey();
  bool tagEnable=false;
  late int index;
  int sear=0;
  var Tags=[
    'Awesome',
    'Love',
    'Cool',
    'Hey',
    'Life',
    'Location',
    'Thankyou',
    'Great',
    'Sunday'
  ];
  // TextEditingController _controller = new TextEditingController();
  TextEditingController _searchcontroller=new TextEditingController();
  TextEditingController _textCO =new TextEditingController();
  var textwidth=0;
  final List<Map<String, dynamic>> _alltags = [
    {"id": 0, "name": "Awesome",},
    {"id": 1, "name": "Love", },
    {"id": 2, "name": "Cool",},
    {"id": 3, "name": "Hey",},
    {"id": 4, "name": "Life", },
    {"id": 5, "name": "Location", },
    {"id": 6, "name": "Thankyou", },
    {"id": 7, "name": "Great", },
    {"id": 8, "name": "Sunday", },

  ];


  List<Map<String, dynamic>> _foundtags = [];



  TextStyle textStyle = TextStyle(color: Colors.grey[600]);
  Color _color=Colors.white;
  Color _txtCol=Colors.black;


  @override
  void initState() {
    _foundtags = _alltags;
    super.initState();
  }



  @override
  Widget build(BuildContext context) {
  return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.black,
      body: GestureDetector(
        onTap: (){
          _focusNode.unfocus();
        },
        child: SafeArea(
          child: Stack(
            key: stackKey,
            // alignment: Alignment.topRight,
            children: [
              _image(context),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 20),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap:(){
                        Navigator.pop(context);
                      },
                      child: Container(
                        height: 35,
                        width: 35,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.grey.withOpacity(0.5),
                        ),
                        child: Center(child: Icon(Icons.arrow_back_ios_outlined,color: Colors.white,size: 20,),),
                      ),
                    ),
                    Spacer(),
                    GestureDetector(
                      onTap: (){
                        setState(() {
                          textEnable=true;
                          _focusNode.requestFocus();
                        });
                      },
                      child: Container(
                        height: 35,
                        width: 35,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.grey.withOpacity(0.5),
                        ),
                        child: Center(child: Text("Aa",style: TextStyle(fontSize: 20,color: Colors.white,
                        fontWeight: FontWeight.w600),)),
                      ),
                    ),
                    SizedBox(width: 20,),
                    GestureDetector(
                      onTap: (){
                        setState(() {
                          if(_color==Colors.white){
                            setState(() {
                              _color=Colors.black;
                              _txtCol=Colors.white;
                            });
                          }else{
                            setState(() {
                              _color=Colors.white;
                              _txtCol=Colors.black;
                            });
                          }
                        });
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.grey.withOpacity(0.5),
                        ),
                        height: 35,width: 35,
                        child: Icon(Icons.color_lens,
                        color: Colors.white,),
                      ),
                    ),
                    SizedBox(width: 20,),
                    GestureDetector(
                      onTap: (){
                        _showTags(context);

                      },
                      child: Container(
                        height: 35,
                        width: 55,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.grey.withOpacity(0.5),
                        ),
                        child: Center(child: Text("tags",style: TextStyle(fontSize: 20,color: Colors.white,
                            fontWeight: FontWeight.w600),)),
                      ),
                    ),

                    SizedBox(width: 30,)

                  ],
                ),
              ),
              zoomEnable?Padding(
                padding: const EdgeInsets.only(top: 50,),
                child: Container(
                  height: 300,width: 20,
                  child: RotatedBox(
                    quarterTurns: 3,
                    child: Slider(
                      value:size ,
                      min: 10,
                      max: 80,
                      onChanged:(double newValue){
                        setState(() {
                         size=newValue;
                        });
                      } ,
                    ),
                  ),
                ),
              ):Container(),
              textEnable?Positioned(
                left: _x,
                top: _y,
                child: Draggable(
                  feedback: Scaffold(
                      body: Container()) ,
                  child: Container(
                    // height: size+100,
                    //   width:  10,
                    decoration: BoxDecoration(
                      color: _color,
                      borderRadius: BorderRadius.circular(10)
                    ),
                    // width: MediaQuery.of(context).size.width,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10,),
                      child: IntrinsicWidth(
                        child: TextField(

                          controller: _textCO,
                          focusNode: _focusNode,
                          cursorColor: _txtCol,
                          style: TextStyle(color: _txtCol,fontSize: size),
                          // minLines: 1,
                          // maxLines: 5,
                          // maxLength: 20,
                          decoration: InputDecoration(
                              border: InputBorder.none,
                          ),
                          /*onEditingComplete: (){
                            setState(() {
                              zoomEnable=true;
                              _focusNode.unfocus();
                            });
                          },*/
                          onChanged: (value){
                            setState(() {
                              zoomEnable=true;
                            });
                          },

                          onTap: (){
                            setState(() {
                              zoomEnable=true;
                              _focusNode.requestFocus();
                            });
                          },
                        ),
                      ),
                    ),
                  ),
                  onDragEnd: (dragDetails){
                    setState(() {
                      final parent=stackKey.globalPaintBounds;
                      if(parent==null)return;
                      _x=dragDetails.offset.dx -parent.left;
                      _y=dragDetails.offset.dy -parent.top;
                    });
                  },
                ),
              ):Container(),
              tagEnable?Positioned(
                top: 80,
               left: 40,
               child: Container(
                 decoration: BoxDecoration(
                   borderRadius: BorderRadius.circular(10),
                   color: Colors.grey.withOpacity(0.5)
                 ),

                 child: Padding(
                   padding: const EdgeInsets.all(8.0),
                   child: Text("#"+Tags[index].toUpperCase(),
                   style: TextStyle(
                     color: Colors.white,fontSize: 30
                   ),),
                 ),

           ),
             ):Container()




            ],
          ),
        ),
      ),
      floatingActionButton: GestureDetector(
        onTap: (){
          final snackBar =const SnackBar(
            duration: Duration(milliseconds: 1000),
            backgroundColor:  Color(0xffff2911),
            content: const Text('story successfully created',
            style: TextStyle(color: Colors.white),),

          );


          _onDone();
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
          // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>MyHomePage()));
        },
        child: Container(
          height: 30,
          width: 80,
          decoration: BoxDecoration(
            color: Colors.grey,
            borderRadius: BorderRadius.circular(10)
          ),
          child: Center(child: Text("Done")),
        ),
      ),
    );
  }

  _onDone()async{
    await Future.delayed(Duration(milliseconds: 1500));
    Get.offAll(const MyHomePage());
  }
  void _showTags(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Container(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 10),
                    child: Container(
                      height: 50,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          border: Border.all(
                              color: Colors.grey
                          )
                      ),
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextFormField(
                            controller: _searchcontroller,
                            onChanged: (value){
                              setState(() {
                                _runFilter(value);
                              });
                            },
                            onFieldSubmitted: (value){
                              setState(() {
                                _runFilter(value);
                              });
                            },
                            cursorColor: Colors.black,
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: "search your tag",
                                suffixIcon: GestureDetector(
                                    onTap: (){
                                      setState(() {
                                        _runFilter(_searchcontroller.text);
                                      });
                                    },
                                    child: Icon(Icons.search))
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                      child:_foundtags.isNotEmpty
                          ? Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 50),
                        child: ListView.builder(
                          itemCount: _foundtags.length,
                          itemBuilder: (context, _index) => GestureDetector(
                            onTap: (){
                              if(_foundtags.length==1){
                                setState(() {
                                  sear=_foundtags[_index]['id'];
                                  index=sear;
                                });
                              }else{
                                setState(() {
                                  index=_index;
                                });
                              }

                              Navigator.pop(context);
                              tagEnable=true;
                            },
                            child: Card(
                              key: ValueKey(_foundtags[_index]["id"]),
                              color: Colors.grey,
                              elevation: 4,
                              margin: const EdgeInsets.symmetric(vertical: 10),
                              child: ListTile(
                                title: Text(_foundtags[_index]['name'],
                                  style: TextStyle(color: Colors.white),),

                              ),
                            ),
                          ),
                        ),
                      )
                          :const Text('No results found')
                  )

                ],
              ),
            ),
          );
        }
    );
  }

  Widget _image(BuildContext context){
  return Container(
    child: Image.file(
      widget.fileImage,
    fit: BoxFit.cover,
    height: MediaQuery.of(context).size.height,
    width: MediaQuery.of(context).size.width,),);
  }

  void _runFilter(String enteredKeyword) {
    List<Map<String, dynamic>> results = [];
    if (enteredKeyword.isEmpty) {
      results = _alltags;
    } else {
      results = _alltags
          .where((user) =>
          user["name"].toLowerCase().contains(enteredKeyword.toLowerCase()))
          .toList();

    }
    setState(() {
      _foundtags = results;
    });
  }

}


extension GlobalKeyExtension on GlobalKey {
  Rect? get globalPaintBounds {
    final renderObject = currentContext?.findRenderObject();
    var translation = renderObject?.getTransformTo(null).getTranslation();
    if (translation != null && renderObject?.paintBounds != null) {
      return renderObject!.paintBounds
          .shift(Offset(translation.x, translation.y));
    } else {
      return null;
    }
  }
}

