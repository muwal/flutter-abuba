import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_abuba/beranda/beranda_view.dart';
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
    return Scaffold(
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
    ));
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
                builder: (context) => new BerandaPage(idUser: data.documents[0].data['id'], aksesStatus: data.documents[0].data['aksesStatus'], departmentUser: data.documents[0].data['department'], namaUser: data.documents[0].data['nama'])
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
                builder: (context) => new BerandaPage(idUser: data.documents[0].data['id'], aksesStatus: data.documents[0].data['aksesStatus'], departmentUser: data.documents[0].data['department'], namaUser: data.documents[0].data['nama'])
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
    return WillPopScope(
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
                padding: const EdgeInsets.only(left: 0.0, right: 10.0),
                child: TextField(
                  decoration: InputDecoration(
                    border: UnderlineInputBorder(),
                    labelStyle: TextStyle(fontSize: 14.0),
                    labelText: 'Email'
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
                padding: const EdgeInsets.only(left: 0.0, right: 10.0),
                child: TextFormField(
                  style: TextStyle(fontSize: 15.0, color: Colors.black),
                  key: _passwordFieldKey,
                  controller: _controllerPassword,
                  obscureText: _obscureText,
                  keyboardType: TextInputType.text,
                  onFieldSubmitted: (String value) {},
                  decoration: InputDecoration(
                    border: UnderlineInputBorder(),
                    labelText: 'Password',
                    hintText: 'Password',
                    suffixIcon: GestureDetector(
                      onTap: () {
                        setState(() {
                          _obscureText = !_obscureText;              
                        });
                      },
                      child: Icon(_obscureText ? Icons.visibility : Icons.visibility_off),
                    )
                  ),
                )
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(right: 20.0),
                    child: new FlatButton(
                      child: new Text(
                        "Forgot Password?",
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
                  ),
                ],
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                margin: const EdgeInsets.only(left: 30.0, right: 30.0, top: 20.0),
                alignment: Alignment.center,
                child: PhysicalModel(
                  color: AbubaPallate.greenabuba,
                  elevation: 4.0,
                  borderRadius: BorderRadius.circular(25.0),
                  child: Container(
                    key: globalKey,
                    height: 48.0,
                    width: width,
                    child: RaisedButton(
                      padding: EdgeInsets.all(0.0),
                      shape: new RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(25.0),
                      ),
                      color: AbubaPallate.greenabuba,
                      child: _isPressed
                        ? SizedBox(
                            height: 36.0,
                            width: 36.0,
                            child: CircularProgressIndicator(
                              value: null, valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                            ),
                          )
                        : Text('Sign In', style: TextStyle(color: Colors.white, fontSize: 16.0)),
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
            ],
          ),
        )
      ),
    );
  }
}