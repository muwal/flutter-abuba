import 'dart:async';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_abuba/constant.dart';
import 'package:flutter_abuba/launcher/launcher_view.dart';
import 'package:flutter/services.dart';
import 'package:get_version/get_version.dart';


class AccountPage extends StatefulWidget {
  final idUser;
  var index;
  AccountPage({this.idUser, this.index});

  @override
  _AccountPageState createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> with TickerProviderStateMixin {
  AnimationController animationController;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  
  File image;
  String filename;
  String userNama = 'User Name';
  String userGrade = 'User Grade';

  Future<FirebaseUser> getUser() async {
    return await _auth.currentUser();
  }

  String _projectVersion = '';
  String _projectName = '';

  @override
  void initState() {
    super.initState();
    initPlatformState();

    getUser().then((user) {
      if (user != null) {
        Firestore.instance.collection('user').where('email', isEqualTo: user.email).snapshots().listen((data) {
          setState(() {
            userNama = data.documents[0].data['nama'];
            userGrade = data.documents[0].data['grade'];
          });
        });
      }
    });

    animationController = AnimationController(vsync: this, duration: Duration(seconds: 3));
    animationController.reverse(
        from: animationController.value == 0.0
            ? 1.0
            : animationController.value
    );
  }

  initPlatformState() async {
    String projectVersion;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      projectVersion = await GetVersion.projectVersion;
    } on PlatformException {
      projectVersion = 'Failed to get project version.';
    }
    
    String projectName;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      projectName = await GetVersion.appName;
    } on PlatformException {
      projectName = 'Failed to get app name.';
    }
    if (!mounted) return;

    setState(() {
      _projectVersion = projectVersion;
      _projectName = projectName;
    });
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        title: Text(
          'Profile',
          style: TextStyle(
            fontWeight: FontWeight.bold
          ),
        ),
        actions: <Widget>[
          PopupMenuButton(
            itemBuilder: (context) {
              return [
                PopupMenuItem(
                  child: GestureDetector(
                    onTap: () {
                      showDialog(
                        barrierDismissible: false,
                        context: context,
                        builder: (context) => AlertDialog(
                          title: Text('Are you sure?'),
                          content: Text('Do you want to sign out ?'),
                          actions: <Widget>[
                            FlatButton(
                              onPressed: () => Navigator.of(context).pop(false),
                              child: Text('No'),
                            ),
                            FlatButton(
                              onPressed: () async {
                                await _auth.signOut().then((_) {
                                  Navigator.pushReplacement(context,
                                    MaterialPageRoute(
                                      builder: (_) => LoginPage()
                                    )
                                  );
                                });
                              },
                              child: Text('Yes'),
                            )
                          ],
                        )
                      );
                    },
                    child: Text(
                      'Sign Out'
                    ),
                  ),
                )
              ];
            },
          )
        ],
      ),
      body: SingleChildScrollView(
        child: AnimatedBuilder(
          animation: animationController,
          builder: (_, Widget child) {
            return animationController.isAnimating
              ? Container(
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                )
              : Column(
                  children: <Widget>[
                    Container(
                      padding: const EdgeInsets.only(bottom: 20.0, top: 40.0),
                      height: MediaQuery.of(context).size.height * 0.4,
                      color: AbubaPallate.greenabuba,
                      child: Column(
                        children: <Widget>[
                          GestureDetector(
                            onTap: () async {
                              // var selectedImage = await ImagePicker.pickImage(source:ImageSource.camera, maxHeight: 400.0, maxWidth: 400.0);
                              // image = selectedImage;
                              // filename = basename(image.path);

                              // StorageReference strRef = FirebaseStorage.instance.ref().child(filename);
                              // StorageUploadTask uploadTask = strRef.putFile(image);

                              // var downUrl = await (await uploadTask.onComplete).ref.getDownloadURL();
                              // var url = downUrl.toString();
                              // print(url);
                            },
                            child: Container(
                              width: 100.0,
                              height: 100.0,
                              decoration: new BoxDecoration(
                                color: AbubaPallate.greenabuba,
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: Colors.white,
                                  width: 3.0,
                                ),
                                image: DecorationImage(
                                  image: image == null
                                      ? NetworkImage( 'https://image.flaticon.com/icons/png/512/149/149071.png')
                                      : FileImage(image),  
                                    fit: BoxFit.cover
                                )
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 25.0,
                          ),
                          Padding(  
                            padding: const EdgeInsets.only(left: 50.0, right: 50.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Flexible(
                                  child: Text(
                                    userNama == null ? 'User Name' : userNama,
                                    style: TextStyle(color: Colors.white, fontSize: 18.0, fontWeight: FontWeight.bold),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 10.0,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 50.0, right: 50.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Flexible(
                                  child: Text(
                                    userGrade == null ? 'User Grade' : userGrade,
                                    style: TextStyle(color: Colors.white, fontSize: 16.5),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.only(bottom: 20.0, top: 40.0),
                      height: MediaQuery.of(context).size.height * 0.5,
                      color: Colors.transparent,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(left: 50.0, right: 50.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Flexible(
                                  child: Text(
                                    _projectName,
                                    style: TextStyle(color: Colors.black54, fontSize: 18, fontWeight: FontWeight.w400),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 50.0, right: 50.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Flexible(
                                  child: Text(
                                    'v' + _projectVersion,
                                    style: TextStyle(color: Colors.black54, fontSize: 16, fontWeight: FontWeight.w400),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                );
          },
        )
      ),
    );
  }
}