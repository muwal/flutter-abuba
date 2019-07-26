import 'package:flutter/material.dart';
import 'package:flutter_abuba/constant.dart';

class FormAbsensi extends StatefulWidget {
  @override
  _FormAbsensiState createState() => _FormAbsensiState();
}

class _FormAbsensiState extends State<FormAbsensi> {
  bool _note = false;
  TextEditingController controllerNoteSatu = new TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final _scaffoldKey = new GlobalKey<ScaffoldState>();

    return SafeArea(
      child: Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          elevation: 0.25,
          backgroundColor: Colors.white,
          iconTheme: IconThemeData(color: Colors.black),
          title: Image.asset(
            'assets/images/logo2.png',
            height: 150.0,
            width: 120.0,
          ),
        ),
        body: GestureDetector(
            onTap: () {
              FocusScope.of(context).requestFocus(FocusNode());
            },
            child: _buildFormMenu()),
      ),
    );
  }

  Widget _buildFormMenu() {
    return ListView(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Text(
                'Log Book MOD',
                style: TextStyle(color: Colors.black12, fontSize: 12.0),
              ),
              Padding(
                padding: EdgeInsets.only(left: 15.0),
                child: Text(
                  '|',
                  style:
                      TextStyle(color: AbubaPallate.greenabuba, fontSize: 12.0),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 15.0),
                child: Text(
                  'Absensi',
                  style:
                      TextStyle(color: AbubaPallate.greenabuba, fontSize: 12.0),
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 0.0),
          child: Wrap(
            children: <Widget>[
              Container(
                width: 100.0,
                padding: EdgeInsets.only(right: 5.0),
                child: GestureDetector(
                  onTap: () {
                    showModalBottomSheet(
                        context: context,
                        builder: (context) {
                          return MyDialog();
                        });
                  },
                  child: Column(
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.only(bottom: 5.0),
                        width: 70.0,
                        height: 70.0,
                        decoration: new BoxDecoration(
                          shape: BoxShape.circle,
                          image: new DecorationImage(
                            fit: BoxFit.fill,
                            image: NetworkImage(
                                "https://www.biography.com/.image/ar_1:1%2Cc_fill%2Ccs_srgb%2Cg_face%2Cq_auto:good%2Cw_300/MTE5NTU2MzE2NDE4MzExNjkx/jackie-chan-9542080-1-402.jpg"),
                          ),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Flexible(
                            child: Text(
                              'Jessica Sunaryo',
                              style: TextStyle(
                                  fontSize: 13.0, color: AbubaPallate.green),
                            ),
                          )
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Flexible(
                            child: Text(
                              'Cipete',
                              style: TextStyle(
                                  fontSize: 10.0, color: Colors.black54),
                            ),
                          ),
                          Flexible(
                            child: Text(
                              'Kasir',
                              style: TextStyle(
                                  fontSize: 10.0, color: Colors.black54),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                width: 10.0,
              ),
              Container(
                width: 100.0,
                padding: EdgeInsets.only(right: 5.0),
                child: GestureDetector(
                  onTap: () {
                    showModalBottomSheet(
                        context: context,
                        builder: (context) {
                          return MyDialog();
                        });
                  },
                  child: Column(
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.only(bottom: 5.0),
                        width: 70.0,
                        height: 70.0,
                        decoration: new BoxDecoration(
                          shape: BoxShape.circle,
                          image: new DecorationImage(
                            fit: BoxFit.fill,
                            image: NetworkImage(
                                "https://www.biography.com/.image/ar_1:1%2Cc_fill%2Ccs_srgb%2Cg_face%2Cq_auto:good%2Cw_300/MTE5NTU2MzE2NDE4MzExNjkx/jackie-chan-9542080-1-402.jpg"),
                          ),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Flexible(
                            child: Text(
                              'Jessica Sunaryo',
                              style: TextStyle(
                                  fontSize: 13.0, color: AbubaPallate.green),
                              textAlign: TextAlign.center,
                            ),
                          )
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Flexible(
                            child: Text(
                              'Cipete',
                              style: TextStyle(
                                  fontSize: 10.0, color: Colors.black54),
                            ),
                          ),
                          Flexible(
                            child: Text(
                              'Kasir',
                              style: TextStyle(
                                  fontSize: 10.0, color: Colors.black54),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                width: 10.0,
              ),
              Container(
                width: 100.0,
                padding: EdgeInsets.only(right: 5.0),
                child: GestureDetector(
                  onTap: () {
                    showModalBottomSheet(
                        context: context,
                        builder: (context) {
                          return MyDialog();
                        });
                  },
                  child: Column(
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.only(bottom: 5.0),
                        width: 70.0,
                        height: 70.0,
                        decoration: new BoxDecoration(
                          shape: BoxShape.circle,
                          image: new DecorationImage(
                            fit: BoxFit.fill,
                            image: NetworkImage(
                                "https://www.biography.com/.image/ar_1:1%2Cc_fill%2Ccs_srgb%2Cg_face%2Cq_auto:good%2Cw_300/MTE5NTU2MzE2NDE4MzExNjkx/jackie-chan-9542080-1-402.jpg"),
                          ),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Flexible(
                            child: Text(
                              'Jessica Sunaryo',
                              style: TextStyle(
                                  fontSize: 13.0, color: AbubaPallate.green),
                              textAlign: TextAlign.center,
                            ),
                          )
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Flexible(
                            child: Text(
                              'Cipete',
                              style: TextStyle(
                                  fontSize: 10.0, color: Colors.black54),
                            ),
                          ),
                          Flexible(
                            child: Text(
                              'Kasir',
                              style: TextStyle(
                                  fontSize: 10.0, color: Colors.black54),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        )
      ],
    );
  }
}

class MyDialog extends StatefulWidget {
  @override
  _MyDialogState createState() => _MyDialogState();
}

class _MyDialogState extends State<MyDialog> {
  bool _note = false;
  TextEditingController controllerNoteSatu = new TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xFF737373),
      height: 230.0,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topRight: const Radius.circular(20.0),
            topLeft: const Radius.circular(20.0),
          ),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 20.0),
          child: Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Flexible(
                    child: Text(
                      'Jessica Sunaryo',
                      style: TextStyle(
                          color: Colors.black54, fontWeight: FontWeight.w700),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(
                    width: 50.0,
                    child: ButtonTheme(
                      padding: EdgeInsets.all(0.0),
                      height: 30.0,
                      child: OutlineButton(
                        child: Text(
                          'L',
                          style: TextStyle(fontSize: 13.0, color: Colors.grey),
                        ),
                        borderSide: BorderSide(color: Colors.grey, width: 1.0),
                        highlightedBorderColor: Colors.grey,
                        onPressed: () {
                          setState(() {
                            _note = !_note;
                          });
                        },
                      ),
                    ),
                  ),
                  Container(
                    width: 50.0,
                    child: ButtonTheme(
                      padding: EdgeInsets.all(0.0),
                      height: 30.0,
                      child: OutlineButton(
                        child: Text(
                          'I',
                          style: TextStyle(fontSize: 13.0, color: Colors.grey),
                        ),
                        borderSide: BorderSide(color: Colors.grey, width: 1.0),
                        highlightedBorderColor: Colors.grey,
                        onPressed: () {
                          setState(() {
                            _note = !_note;
                          });
                        },
                      ),
                    ),
                  ),
                  Container(
                    width: 50.0,
                    child: ButtonTheme(
                      padding: EdgeInsets.all(0.0),
                      height: 30.0,
                      child: OutlineButton(
                        child: Text(
                          'S',
                          style: TextStyle(fontSize: 13.0, color: Colors.grey),
                        ),
                        borderSide: BorderSide(color: Colors.grey, width: 1.0),
                        highlightedBorderColor: Colors.grey,
                        onPressed: () {
                          setState(() {
                            _note = !_note;
                          });
                        },
                      ),
                    ),
                  ),
                  Container(
                    width: 50.0,
                    child: ButtonTheme(
                      padding: EdgeInsets.all(0.0),
                      height: 30.0,
                      child: OutlineButton(
                        child: Text(
                          'A',
                          style: TextStyle(fontSize: 13.0, color: Colors.grey),
                        ),
                        borderSide: BorderSide(color: Colors.grey, width: 1.0),
                        highlightedBorderColor: Colors.grey,
                        onPressed: () {
                          setState(() {
                            _note = !_note;
                          });
                        },
                      ),
                    ),
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  _note
                      ? Container(
                          width: 320.0,
                          child: TextField(
                            decoration: InputDecoration(
                              hintText: 'Keterangan',
                              hintStyle: TextStyle(fontSize: 12.0),
                              border: OutlineInputBorder(),
                            ),
                            controller: controllerNoteSatu,
                            maxLines: 3,
                            style: TextStyle(
                              color: Colors.black,
                            ),
                          ),
                        )
                      : Container(),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  ButtonTheme(
                    minWidth: 40.0,
                    height: 20.0,
                    child: RaisedButton(
                      color: AbubaPallate.greenabuba,
                      splashColor: AbubaPallate.greensatu,
                      child: Text(
                        'Kirim',
                        style: TextStyle(fontSize: 12.0, color: Colors.white),
                      ),
                      onPressed: () {},
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
