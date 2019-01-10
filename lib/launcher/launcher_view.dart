import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter_abuba/constant.dart';
import 'package:flutter_abuba/landing/landingpage_view.dart';

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
                    'assets/images/logo_splash.png',
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

class _LoginPageState extends State<LoginPage> with TickerProviderStateMixin {
  final GlobalKey<FormFieldState<String>> _passwordFieldKey = new GlobalKey<FormFieldState<String>>();

  bool _isPressed = false;
  int state = 0;
  double width = double.infinity;
  Animation _animation;
  Animation _animation2;
  GlobalKey globalKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: SingleChildScrollView(
          child: _LoginPage(),
        ),
      ),
    );
  }

  Widget _LoginPage() {
    return new Container(
      height: MediaQuery.of(context).size.height,
      decoration: BoxDecoration(
        color: Colors.white,
      ),
      child: new Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.fromLTRB(120.0, 120.0, 120.0, 50.0),
            child: Center(
              child: Image.asset(
                'assets/images/logo_splash.png',
                width: 390.0,
              ),
            ),
          ),
          new Container(
            width: MediaQuery.of(context).size.width,
            margin: const EdgeInsets.only(left: 40.0, right: 40.0, top: 10.0),
            alignment: Alignment.center,
            padding: const EdgeInsets.only(left: 0.0, right: 10.0),
            child: new Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                new Expanded(
                  child: PasswordField(
                    fieldKey: _passwordFieldKey,
                    helperText: 'Enter your 6 digits PIN',
                    labelText: 'PIN',
                    hintText: 'PIN',
                    onFieldSubmitted: (String value) {},
                  )
                ),
              ],
            ),
          ),
          new Row(
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
                      state = 0;
                      width = double.infinity;
                    });
                  },
                ),
              ),
            ],
          ),
          new Container(
            width: MediaQuery.of(context).size.width,
            margin: const EdgeInsets.only(left: 30.0, right: 30.0, top: 20.0),
            alignment: Alignment.center,
            child: PhysicalModel(
              color: AbubaPallate.greenabuba,
              elevation: _isPressed ? 6.0 : 4.0,
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
                  child: buildButtonChild(),
                  onPressed: () {},
                  onHighlightChanged: (isPressed) {
                    setState(() {
                      _isPressed = isPressed;
                      if (state == 0) {
                        animateButton();
                      }
                    });
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
    //   FlatButton(
    //     shape: new RoundedRectangleBorder(
    //       borderRadius: new BorderRadius.circular(30.0),
    //     ),
    //     color: AbubaPallate.greenabuba,
    //     onPressed: () => Navigator.pushReplacement(context,
    //         MyCustomRoute(builder: (context) => LandingPage())),
    //     child: new Container(
    //       padding: const EdgeInsets.symmetric(
    //         vertical: 20.0,
    //         horizontal: 20.0,
    //       ),
    //       child: new Row(
    //         mainAxisAlignment: MainAxisAlignment.center,
    //         children: <Widget>[
    //           new Expanded(
    //             child: Text(
    //               "LOGIN",
    //               textAlign: TextAlign.center,
    //               style: TextStyle(
    //                   color: Colors.white,
    //                   fontWeight: FontWeight.bold),
    //             ),
    //           ),
    //         ],
    //       ),
    //     ),
    //   ),
  }

  void animateButton() {
    double initialWidth = globalKey.currentContext.size.width;

    var controller = AnimationController(duration: Duration(milliseconds: 300), vsync: this);
    _animation = Tween(begin: 0.0, end: 1.0)
      .animate(controller)
      ..addListener(() {
        setState(() {
          width = initialWidth - ((initialWidth - 48.0) * _animation.value);
        });
      });
    controller.forward();

    setState(() {
      state = 1;
    });

    Timer(Duration(milliseconds: 3300), () {
      // double initialWidth = globalKey.currentContext.size.width;

      // var controller2 = AnimationController(duration: Duration(milliseconds: 300), vsync: this);
      // _animation2 = Tween(begin: 0.0, end: 1.0)
      //   .animate(controller2)
      //   ..addListener(() {
      //     setState(() {
      //       width = initialWidth + ((initialWidth) * _animation2.value);
      //     });
      //   });
      // controller2.forward();
      Navigator.pushReplacement(context,
        MyCustomRoute(
          builder: (context) => new LandingPage()
        )
      );
    });
  }

  Widget buildButtonChild() {
    if (state == 0) {
      return Text('Login', style: TextStyle(color: Colors.white, fontSize: 16.0));
    } else if (state == 1) {
      return SizedBox(
        height: 36.0,
        width: 36.0,
        child: CircularProgressIndicator(
          value: null, valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
        ),
      );
    }
  }
}

class PasswordField extends StatefulWidget {
  const PasswordField({
    this.fieldKey,
    this.hintText,
    this.labelText,
    this.helperText,
    this.onSaved,
    this.validator,
    this.onFieldSubmitted,  
  });

  final Key fieldKey;
  final String hintText;
  final String labelText;
  final String helperText;
  final FormFieldSetter<String> onSaved;
  final FormFieldValidator<String> validator;
  final ValueChanged<String> onFieldSubmitted;

  @override
  _PasswordFieldState createState() => new _PasswordFieldState();
}

class _PasswordFieldState extends State<PasswordField> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return new TextFormField(
      key: widget.fieldKey,
      obscureText: _obscureText,
      maxLength: 6,
      onSaved: widget.onSaved,
      validator: widget.validator,
      keyboardType: TextInputType.number,
      onFieldSubmitted: widget.onFieldSubmitted,
      decoration: InputDecoration(
        border: UnderlineInputBorder(),
        hintText: widget.hintText,
        labelText: widget.labelText,
        helperText: widget.helperText,
        suffixIcon: GestureDetector(
          onTap: () {
            setState(() {
              _obscureText = !_obscureText;              
            });
          },
          child: Icon(_obscureText ? Icons.visibility : Icons.visibility_off),
        )
      ),
    );
  }
}