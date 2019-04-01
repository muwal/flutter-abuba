import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_abuba/constant.dart';
import 'package:flutter_abuba/launcher/homepagePhone.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;

class PageTwo extends StatefulWidget {
  @override
  PageTwoState createState() {
    return PageTwoState();
  }
}

class PageTwoState extends State<PageTwo> {
  // Future<String> _message = Future<String>.value('');
  // TextEditingController _smsCodeController = TextEditingController();
  // String verificationId;
  // final String testSmsCode = '888888';
  // final String testPhoneNumber = '+62 812-1926-5088';

  TapGestureRecognizer _tapRecognizer;
  @override
  void initState() {
    super.initState();
    _tapRecognizer = TapGestureRecognizer()
      ..onTap = _handlePress;
  }

  @override
  void dispose() {
    _tapRecognizer.dispose();
    super.dispose();
  }

  void _handlePress() {
    Navigator.pop(context);
  }

  // Future<void> _testVerifyPhoneNumber() async {
  //   final PhoneVerificationCompleted verificationCompleted =
  //       (FirebaseUser user) {
  //     setState(() {
  //       _message =
  //           Future<String>.value('signInWithPhoneNumber auto succeeded: $user');
  //     });
  //   };

  //   final PhoneVerificationFailed verificationFailed =
  //       (AuthException authException) {
  //     setState(() {
  //       _message = Future<String>.value(
  //           'Phone number verification failed. Code: ${authException.code}. Message: ${authException.message}');
  //     });
  //   };

  //   final PhoneCodeSent codeSent =
  //       (String verificationId, [int forceResendingToken]) async {
  //     this.verificationId = verificationId;
  //     _smsCodeController.text = testSmsCode;
  //   };

  //   final PhoneCodeAutoRetrievalTimeout codeAutoRetrievalTimeout =
  //       (String verificationId) {
  //     this.verificationId = verificationId;
  //     _smsCodeController.text = testSmsCode;
  //   };

  //   await _auth.verifyPhoneNumber(
  //       phoneNumber: testPhoneNumber,
  //       timeout: const Duration(seconds: 5),
  //       verificationCompleted: verificationCompleted,
  //       verificationFailed: verificationFailed,
  //       codeSent: codeSent,
  //       codeAutoRetrievalTimeout: codeAutoRetrievalTimeout);
  // }

  // Future<String> _testSignInWithPhoneNumber(String smsCode) async {
  //   final AuthCredential credential = PhoneAuthProvider.getCredential(
  //     verificationId: verificationId,
  //     smsCode: smsCode,
  //   );
  //   final FirebaseUser user = await _auth.signInWithCredential(credential);
  //   final FirebaseUser currentUser = await _auth.currentUser();
  //   assert(user.uid == currentUser.uid);

  //   _smsCodeController.text = '';
  //   return 'signInWithPhoneNumber succeeded: $user';
  // }

  String phoneNo;
  String smsCode;
  String verificationId;
  TextEditingController _controller = TextEditingController();

  Future<void> verifyPhone() async {
    final PhoneCodeAutoRetrievalTimeout autoRetrieve = (String verId) {
      this.verificationId = verId;
    };

    final PhoneCodeSent smsCodeSent = (String verId, [int forceCodeResend]) {
      this.verificationId = verId;
      smsCodeDialog(context).then((value) {
        print('Signed In');
      });
    };

    final PhoneVerificationCompleted verifiedSuccess = (FirebaseUser user) {
      Firestore.instance.runTransaction((Transaction transaction) async {
        CollectionReference reference = Firestore.instance.collection('user');
        await reference.add({
          'phone_number': user.phoneNumber,
          'uid': user.uid,
          'verified': true,
        });
      });
      _controller.clear();
      print('Verified');
    };

    final PhoneVerificationFailed veriFailed = (AuthException exception) {
      print('${exception.message}');
    };

    await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: this.phoneNo,
        codeAutoRetrievalTimeout: autoRetrieve,
        codeSent: smsCodeSent,
        timeout: const Duration(seconds: 5),
        verificationCompleted: verifiedSuccess,
        verificationFailed: veriFailed);
  }

  Future<bool> smsCodeDialog(BuildContext context) {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return new AlertDialog(
            title: Text('Enter sms Code'),
            content: TextField(
              onChanged: (value) {
                this.smsCode = value;
              },
            ),
            contentPadding: EdgeInsets.all(10.0),
            actions: <Widget>[
              new FlatButton(
                child: Text('Done'),
                onPressed: () {
                  FirebaseAuth.instance.currentUser().then((user) {
                    if (user != null) {
                      Navigator.of(context).pop();
                      Navigator.pushReplacement(context, 
                        MaterialPageRoute(
                          builder: (_) => HomePagePhone()
                        )
                      );
                    } else {
                      Navigator.of(context).pop();
                      signIn();
                    }
                  });
                },
              )
            ],
          );
        });
  }

  Future<String> signIn() async {
    // FirebaseAuth.instance
    //   .signInWithPhoneNumber(verificationId: verificationId, smsCode: smsCode)
    //   .then((user) {
    //   Navigator.pushReplacement(context, 
    //     MaterialPageRoute(
    //       builder: (_) => HomePagePhone()
    //     )
    //   );
    // }).catchError((e) {
    //   print(e);
    // });
    final AuthCredential credential = PhoneAuthProvider.getCredential(
      verificationId: verificationId,
      smsCode: smsCode,
    );
    final FirebaseUser user = await FirebaseAuth.instance.signInWithCredential(credential);
    final FirebaseUser currentUser = await FirebaseAuth.instance.currentUser().then((user) {
      Navigator.pushReplacement(context, 
        MaterialPageRoute(
          builder: (_) => HomePagePhone()
        )
      );
    }).catchError((e) {
      print(e);
    });
    // assert(user.uid == currentUser.uid);

    // smsCode = '';
    // return 'signInWithPhoneNumber succeeded: $user';
  }

  // Future<String> signIn() async {
  //   final AuthCredential credential = PhoneAuthProvider.getCredential(
  //     verificationId: verificationId,
  //     smsCode: smsCode,
  //   );
  //   final FirebaseUser user = await FirebaseAuth.instance.signInWithCredential(credential);
  //   final FirebaseUser currentUser = await FirebaseAuth.instance.currentUser();
  //   assert(user.uid == currentUser.uid);

  //   smsCode = '';
  //   return 'signInWithPhoneNumber succeeded: $user';
  // }

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: ListView(
          children: <Widget>[
            Container(
              padding: EdgeInsets.fromLTRB(120.0, 50.0, 120.0, 25.0),
              child: Center(
                child: Image.asset(
                  'assets/images/logo_splash.png',
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
                  labelText: 'Phone Number'
                ),
                onChanged: (value) {
                  this.phoneNo = value;
                },
                controller: _controller,
                keyboardType: TextInputType.phone,
                style: TextStyle(fontSize: 15.0, color: Colors.black),
              ),
            ),
            Container(
              width: width,
              margin: const EdgeInsets.only(left: 30.0, right: 30.0, top: 30.0),
              alignment: Alignment.center,
              child: FlatButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ),
                color: AbubaPallate.greenabuba,
                onPressed: verifyPhone,
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 20.0,horizontal: 20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Expanded(
                        child: Text(
                          "SIGN UP",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            // Container(
            //   width: width,
            //   margin: const EdgeInsets.only(left: 30.0, right: 30.0, top: 30.0),
            //   alignment: Alignment.center,
            //   child: FlatButton(
            //     shape: RoundedRectangleBorder(
            //       borderRadius: BorderRadius.circular(30.0),
            //     ),
            //     color: AbubaPallate.greenabuba,
            //     onPressed: () {
            //       if (_smsCodeController.text != null) {
            //         setState(() {
            //           _message =
            //               _testSignInWithPhoneNumber(_smsCodeController.text);
            //         });
            //       }
            //     },
            //     child: Container(
            //       padding: const EdgeInsets.symmetric(vertical: 20.0,horizontal: 20.0),
            //       child: Row(
            //         mainAxisAlignment: MainAxisAlignment.center,
            //         children: <Widget>[
            //           Expanded(
            //             child: Text(
            //               "Test signInWithPhoneNumber",
            //               textAlign: TextAlign.center,
            //               style: TextStyle(
            //                 color: Colors.white,
            //                 fontWeight: FontWeight.bold
            //               ),
            //             ),
            //           ),
            //         ],
            //       ),
            //     ),
            //   ),
            // ),
            // FutureBuilder<String>(
            //   future: _message,
            //   builder: (_, AsyncSnapshot<String> snapshot) {
            //     return Text(snapshot.data ?? '',
            //         style:
            //           const TextStyle(color: Color.fromARGB(255, 0, 155, 0)));
            //   }
            // ),
            Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child: Center(
                child: RichText(
                  text: TextSpan(
                    style: TextStyle(
                      color: Colors.black54,
                      fontSize: 14.0,
                    ),
                    children: [
                      TextSpan(text: 'Already have an account ? '),
                      TextSpan(
                        text: 'Sign In',
                        style: TextStyle(color: AbubaPallate.menuBluebird),
                        recognizer: _tapRecognizer
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      )
    );
  }
}