import 'dart:io';
import 'dart:typed_data';
import 'package:image/image.dart' as img;
import 'package:flutter/material.dart';
import 'package:tflite/tflite.dart';
import 'package:image_picker/image_picker.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool _loading = true;
  late List output;
  late File image;
  //late File img;

  final picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    loadMode().then((value) {
      setState(() {});
    });
  }




  detectImage(File image) async {

    var res = await Tflite.runModelOnImage(
      path: image.path,
      numResults: 2,
      threshold: 0.3,
      imageMean: 127.5,
      imageStd: 127.5,
    );
    setState(() {
      output = res!;
      print(output);
      _loading = false;
    });
  }

  loadMode() async {
    await Tflite.loadModel(
        model: 'assets/model_fp16.tflite', labels: 'assets/tomatolabel.txt');
  }


  pickGalleryImage() async {
    var img = await picker.pickImage(source: ImageSource.gallery);
    if (img == null) return null;

    setState(() {
      image = File(img.path);

    });

    detectImage(image);
  }




  pickImage() async {
    var img = await picker.pickImage(source: ImageSource.camera);
    if (img == null) return null;

    setState(() {
      image = File(img.path);
    });

    detectImage(image);
  }


  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(''),
        elevation: 0.0,
        backgroundColor: Colors.black45,
      ),
      backgroundColor: Colors.blueGrey,
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 20.0,
            ),

            SizedBox(
              height: 5.0,
            ),
            Text(
              'Classifier',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0),
            ),
            SizedBox(
              height: 30.0,
            ),
            Center(
              child: _loading
                  ? Container(
                      width: MediaQuery.of(context).size.width - 100,
                      child: Column(
                        children: [

                          SizedBox(
                            height: 50.0,
                          )
                        ],
                      ),
                    )
                  : Container(
                      child: Column(
                        children: [
                          Container(
                            height: 250.0,
                            child: Image.file(image),
                          ),
                          SizedBox(
                            height: 20.0,
                          ),
                          output != null
                              ? Text(
                                  '${output[0]['label']}',

                              style: TextStyle(
                                      color: Colors.white, fontSize: 15.0),
                                )
                              : Container(),
                          SizedBox(
                            height: 10.0,
                          ),
                          output != null
                              ? Text(
                            '${output[0]['index']}',

                            style: TextStyle(
                                color: Colors.white, fontSize: 15.0),
                          )
                              : Container(),
                          output != null
                              ? Text(
                            '${output[0]['confidence']}',

                            style: TextStyle(
                                color: Colors.white, fontSize: 15.0),
                          )
                              : Container(),
                        ],
                      ),
                    ),
            ),

            Container(
              width: MediaQuery.of(context).size.width,
              child: Column(
                children: [
                  GestureDetector(
                    onTap: () {
                      pickImage();
                    },
                    child: Container(
                      child: Text(
                        'Camera',
                        style: TextStyle(color: Colors.white, fontSize: 10.0),
                      ),
                      width: MediaQuery.of(context).size.width,
                      alignment: Alignment.center,
                      padding: EdgeInsets.symmetric(
                          horizontal: 25.0, vertical: 18.0),
                      decoration: BoxDecoration(
                          color: Colors.deepOrange,
                          borderRadius: BorderRadius.circular(10.0)),
                    ),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  GestureDetector(
                    onTap: () {
                      pickGalleryImage();
                    },
                    child: Container(
                      child: Text(
                        'Gallery',
                        style: TextStyle(color: Colors.white, fontSize: 10.0),
                      ),
                      width: MediaQuery.of(context).size.width,
                      alignment: Alignment.center,
                      padding: EdgeInsets.symmetric(
                          horizontal: 25.0, vertical: 18.0),
                      decoration: BoxDecoration(
                          color: Colors.deepOrange,
                          borderRadius: BorderRadius.circular(10.0)),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
