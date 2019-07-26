import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_abuba/constant.dart';
import 'package:flutter_abuba/launcher/launcher_view.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server/gmail.dart';

class ForgotPassword extends StatefulWidget {
  @override
  ForgotPasswordState createState() {
    return ForgotPasswordState();
  }
}

class ForgotPasswordState extends State<ForgotPassword> {
  TextEditingController _controllerEmail =TextEditingController();
  bool isLoading = false;
  
  email(String email) async {
    String username = 'doojrdie@gmail.com';
    String password = 'doojrdie123';

    final smtpServer = gmail(username, password);

    final message = Envelope()
        ..from = Address(username, 'noreply')
        ..recipients.add(email)
        ..subject = 'Reset your password for Abuba Steak'
        ..html = "<p>Hello,</p>\n<p>Follow this link to reset your Abuba Steak password for your $email account.</p>\n<p><a href='https://abubasteak.id'>Abuba Steak</a></p>\n<p>If you didn’t ask to reset your password, you can ignore this email.<p>\n<p>Thanks.</p>\n<p>Your Abuba Steak team</p>";

    await send(message, smtpServer).then((_) {
      setState(() {
        isLoading = false;
        _controllerEmail.clear();
      });
      showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) => AlertDialog(
          content: Padding(
            padding: const EdgeInsets.only(top: 10.0),
            child: Text('Email Sent!', textAlign: TextAlign.center,),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.pushReplacement(context,
                  MaterialPageRoute(
                    builder: (_) => LoginPage()
                  )
                );
              },
            )
          ],
        )
      );
    }).catchError((e) => print('Error : $e'));

  }

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
                  labelText: 'Enter Email Address'
                ),
                keyboardType: TextInputType.emailAddress,
                controller: _controllerEmail,
                style: TextStyle(fontSize: 15.0, color: Colors.black),
              ),
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
                  height: 48.0,
                  width: width,
                  child: RaisedButton(
                    padding: EdgeInsets.all(0.0),
                    shape: new RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(25.0),
                    ),
                    color: AbubaPallate.greenabuba,
                    child: isLoading
                      ? SizedBox(
                          height: 36.0,
                          width: 36.0,
                          child: CircularProgressIndicator(
                            value: null, valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                          ),
                        )
                      : Text('Send', style: TextStyle(color: Colors.white, fontSize: 16.0)),
                    onPressed: () {
                      // if (_controllerEmail.text.isEmpty) {
                      //   showDialog(
                      //     barrierDismissible: false,
                      //     context: context,
                      //     builder: (context) => AlertDialog(
                      //       content: Padding(
                      //         padding: const EdgeInsets.only(top: 10.0),
                      //         child: Text('Email field is empty!', textAlign: TextAlign.center,),
                      //       ),
                      //       actions: <Widget>[
                      //         FlatButton(
                      //           child: Text('OK'),
                      //           onPressed: () {
                      //             Navigator.pop(context);
                      //           },
                      //         )
                      //       ],
                      //     )
                      //   );
                      // } else {
                      //   if (isLoading == false) {
                      //     setState(() {
                      //       isLoading = true;
                      //     });
                      //     email(_controllerEmail.text);
                      //   } else {

                      //   }
                      // }
                    },
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