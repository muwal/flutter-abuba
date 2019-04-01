import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_abuba/constant.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class PageOne extends StatefulWidget {
  @override
  PageOneState createState() {
    return PageOneState();
  }
}

class PageOneState extends State<PageOne> {
  TextEditingController _controllerNama = TextEditingController();
  TextEditingController _controllerEmail = TextEditingController();
  TextEditingController _controllerPin = TextEditingController();
  final GlobalKey<FormFieldState<String>> _passwordFieldKey = GlobalKey<FormFieldState<String>>();
  bool _obscureText = true;
  TapGestureRecognizer _tapRecognizer;
  DateTime _now = DateTime.now();
  var maxid = 0;
  var index;

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

  void _signUp() {
    Firestore.instance
      .collection('dumper_user')
      .snapshots()
      .listen((data) => data.documents.forEach((doc) {
        setState(() {
          maxid = doc['maxid'] + 1;
          index = data.documents[0].reference;
        });
      }));
    Firestore.instance.runTransaction((Transaction transaction) async {
      CollectionReference reference = Firestore.instance.collection('user');
      await reference.add({
        'email': _controllerEmail.text,
        'nama': _controllerNama.text,
        'pin': _controllerPin.text,
        'created_date': _now.toString().substring(0, 10),
        'id': maxid,
      });

      DocumentSnapshot snapshot = await transaction.get(index);
      await transaction.update(snapshot.reference, {
        'maxid': maxid,
      });
    });
    Navigator.pop(context);
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
                  labelText: 'Nama Lengkap'
                ),
                textCapitalization: TextCapitalization.words,
                controller: _controllerNama,
                style: TextStyle(fontSize: 15.0, color: Colors.black),
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
                controller: _controllerPin,
                obscureText: _obscureText,
                maxLength: 6,
                keyboardType: TextInputType.number,
                onFieldSubmitted: (String value) {},
                decoration: InputDecoration(
                  border: UnderlineInputBorder(),
                  helperText: 'Enter your 6 digits PIN',
                  labelText: 'PIN',
                  hintText: 'PIN',
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
            Container(
              width: width,
              margin: const EdgeInsets.only(left: 30.0, right: 30.0, top: 30.0),
              alignment: Alignment.center,
              child: FlatButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ),
                color: AbubaPallate.greenabuba,
                onPressed: _signUp,
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