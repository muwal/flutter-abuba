import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_abuba/beranda/berandaview.dart';
import 'dart:async';
import 'package:flutter_abuba/constant.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_abuba/launcher/loginEmail.dart';
import 'package:flutter_abuba/misteri_shop/outlet/grid_data_search.dart';

class LauncherPage extends StatefulWidget {
  @override
  _LauncherPageState createState() => _LauncherPageState();
}

class _LauncherPageState extends State<LauncherPage> {
  @override
  void initState() {
    super.initState();
    startLaunching();
  }

  startLaunching() async {
    var durasi = const Duration(seconds: 3);
    return Timer(durasi, () {
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) {
        return LoginPage();
      }));
    });
  }

  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.dark.copyWith(
        statusBarColor: Color(0xfff9f9f9),),
      child: Scaffold(
          body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Expanded(
                flex: 3,
                child: Container(
                  padding: EdgeInsets.only(top: 50.0),
                  child: Center(
                    child: Image.asset(
                      'assets/images/logo_splash2.png',
                      height: 190.0,
                      width: 390.0,
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    CircularProgressIndicator(),
                  ],
                ),
              )
            ],
          )
        ],
      )),
    );
  }
}

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController _controllerEmail = TextEditingController();
  TextEditingController _controllerPassword = TextEditingController();
  final GlobalKey<FormFieldState<String>> _passwordFieldKey = GlobalKey<FormFieldState<String>>();

  double width = double.infinity;
  GlobalKey globalKey = GlobalKey();
  bool _obscureText = true;
  bool _isPressed = false;

  Future<bool> onWillPop() {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Are you sure?'),
        content: Text('Do you want to exit Abuba Steak App ?'),
        actions: <Widget>[
          FlatButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: Text('No'),
          ),
          FlatButton(
            onPressed: () => SystemChannels.platform.invokeMethod('SystemNavigator.pop'),
            child: Text('Yes'),
          )
        ],
      )
    ) ?? false;
  }

  final FirebaseAuth _auth = FirebaseAuth.instance;
  Future<FirebaseUser> getUser() async {
    return await _auth.currentUser();
  }

  @override
  void initState() {
    super.initState();
    getUser().then((user) {
      if (user != null) {
        Firestore.instance.collection('user').where('email', isEqualTo: user.email).snapshots().listen((data) {
          if (data.documents[0].data['aksesStatus'] == 'mg') {
            Navigator.pushReplacement(context,
              MyCustomRoute(
                builder: (context) => new FormCariLokasi(idUser: data.documents[0].data['id'], aksesStatus: data.documents[0].data['aksesStatus'])
              )
            );
          } else if (data.documents[0].data['aksesStatus'] == 'owner') {
            Navigator.pushReplacement(context,
              MyCustomRoute(
                builder: (context) => new BerandaPage(idUser: data.documents[0].data['id'], aksesStatus: data.documents[0].data['aksesStatus'], departmentUser: data.documents[0].data['department'], namaUser: data.documents[0].data['nama'], index: data.documents[0].documentID),
              )
            );
          }
        });
      }
    });
  }

  void signInWithEmail() async {
    FirebaseUser user;
    try {
      user = await _auth.signInWithEmailAndPassword(
        email: _controllerEmail.text,
        password: _controllerPassword.text
      );
    } catch(e) {
      print(e.toString());
    } finally {
      if (user != null) {
        setState(() {
          _isPressed = false;
        });
        Firestore.instance.collection('user').where('email', isEqualTo: _controllerEmail.text).snapshots().listen((data) {
          if (data.documents[0].data['aksesStatus'] == 'mg') {
            Navigator.pushReplacement(context,
              MyCustomRoute(
                builder: (context) => new FormCariLokasi(idUser: data.documents[0].data['id'], aksesStatus: data.documents[0].data['aksesStatus'])
              )
            );
          } else if (data.documents[0].data['aksesStatus'] == 'owner') {
            Navigator.pushReplacement(context,
              MyCustomRoute(
                builder: (context) => new BerandaPage(idUser: data.documents[0].data['id'], aksesStatus: data.documents[0].data['aksesStatus'], departmentUser: data.documents[0].data['departmentID'].toString(), namaUser: data.documents[0].data['nama'], index: data.documents[0].documentID),
              )
            );
          } else {
            showDialog(
              context: context,
              builder: (context) => AlertDialog(
                title: Text('Alert'),
                content: Text('Login Unsuccessful! Email or password not found'),
                actions: <Widget>[
                  FlatButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: Text('OK'),
                  ),
                ],
              ) 
            );
          }
        });
      } else {
        setState(() {
          _isPressed = false;
        });
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Alert'),
            content: Text('Login Unsuccessful! Email or password not found'),
            actions: <Widget>[
              FlatButton(
                onPressed: () => Navigator.of(context).pop(),
                child: Text('OK'),
              ),
            ],
          ) 
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.dark.copyWith(
        statusBarColor: Color(0xfff9f9f9),),
      child: WillPopScope(
        onWillPop: onWillPop,
        child: Scaffold(
          body: GestureDetector(
            onTap: () {
              FocusScope.of(context).requestFocus(FocusNode());
            },
            child: ListView(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.fromLTRB(120.0, 120.0, 120.0, 50.0),
                  child: Center(
                    child: Image.asset(
                      'assets/images/logo_splash2.png',
                      width: 390.0,
                    ),
                  ),
                ),
                Container(
                  width: width,
                  margin: const EdgeInsets.only(left: 40.0, right: 40.0, top: 10.0),
                  alignment: Alignment.center,
                  padding: const EdgeInsets.only(left: 20.0, right: 30.0),
                  child: TextField(
                    decoration: InputDecoration(
                      border: UnderlineInputBorder(),
                      hintStyle: TextStyle(fontSize: 14.0),
                      hintText: 'example@gmail.com',
                      prefixIcon: Icon(Icons.email)
                    ),
                    keyboardType: TextInputType.emailAddress,
                    controller: _controllerEmail,
                    style: TextStyle(fontSize: 15.0, color: Colors.black),
                  ),
                ),
                Container(
                  width: width,
                  margin: const EdgeInsets.only(left: 40.0, right: 40.0, top: 10.0),
                  alignment: Alignment.center,
                  padding: const EdgeInsets.only(left: 20.0, right: 30.0),
                  child: TextFormField(
                    style: TextStyle(fontSize: 15.0, color: Colors.black),
                    key: _passwordFieldKey,
                    controller: _controllerPassword,
                    obscureText: _obscureText,
                    keyboardType: TextInputType.text,
                    onFieldSubmitted: (String value) {},
                    decoration: InputDecoration(
                      border: UnderlineInputBorder(),
                      hintText: 'Password',
                      hintStyle: TextStyle(fontSize: 14.0),
                      hasFloatingPlaceholder: true,
                      prefixIcon: GestureDetector(
                        onTap: () {
                          setState(() {
                            _obscureText = !_obscureText;
                          });
                        },
                        child: Icon(_obscureText ? Icons.lock_outline : Icons.lock_open),
                      )
                    ),
                  )
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  margin: const EdgeInsets.only(left: 50.0, right: 50.0, top: 30.0),
                  alignment: Alignment.center,
                  child: PhysicalModel(
                    color: AbubaPallate.greenabuba,
                    elevation: 4.0,
                    borderRadius: BorderRadius.circular(25.0),
                    child: Container(
                      key: globalKey,
                      height: 55.0,
                      width: width,
                      child: RaisedButton(
                        padding: EdgeInsets.all(0.0),
                        shape: new RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(25.0),
                        ),
                        color: AbubaPallate.greenabuba,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            _isPressed
                              ? SizedBox(
                                  height: 15.0,
                                  width: 15.0,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 1.5,
                                    value: null, valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                                  ),
                                )
                              : Container(),
                            _isPressed
                              ? SizedBox(
                                  width: 10.0,
                                )
                              : Container(),
                            Text('Sign In', style: TextStyle(color: Colors.white, fontSize: 16.0)),
                          ],
                        ),
                        onPressed: () {
                          setState(() {
                            _isPressed = true;
                          });
                          signInWithEmail();
                        },
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        'Forgot your password?',
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          color: Colors.grey,
                          fontSize: 15.0,
                        ),
                        textAlign: TextAlign.end,
                      ),
                      FlatButton(
                        child: Text(
                          'Reset Password',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: AbubaPallate.greenabuba,
                            fontSize: 15.0,
                          ),
                          textAlign: TextAlign.end,
                        ),
                        onPressed: () {
                          setState(() {
                            _isPressed = false;
                          });
                          Navigator.push(context,
                            MaterialPageRoute(
                              builder: (context) => ForgotPassword()
                            )
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )
        ),
      ),
    );
  }
}