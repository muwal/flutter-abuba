import 'package:flutter/material.dart';
import 'package:flutter_abuba/constant.dart';
import 'package:flutter/cupertino.dart';
import 'dart:async';

class ModalBottomSheet extends StatefulWidget {
  _ModalBottomSheetState createState() => _ModalBottomSheetState();
}

class _ModalBottomSheetState extends State<ModalBottomSheet> {
  bool _value = false;
  bool _value2 = false;

  TextEditingController controller = new TextEditingController();
  List<String> textList = [
    "Alasan 1",
    "Alasan 2",
    "Alasan 3",
    "Alasan 4",
    "Alasan 5"
  ];
  List<bool> checkboxList = [false, false, false, false, false];
  String listck = '';
  List<String> selectedck = new List();

  setText() {
    if (selectedck.length == 0) {
      listck = '';
    } else {
      listck = selectedck.join(', ');
    }

    print(listck);
  }

  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          ListTile(
            dense: true,
            title: Text(
              'DONE',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.green),
            ),
          ),
          contentwrap(),
          ButtonTheme.bar(
            child: ButtonBar(
              children: <Widget>[
                FlatButton(
                  child: Text('SAVE'),
                  onPressed: () {},
                ),
                FlatButton(
                  child: Text(
                    'CANCEL',
                    style: TextStyle(color: Colors.black54),
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget contentwrap() {
    return Wrap(
      spacing: 0.0,
      runSpacing: 0.0,
      direction: Axis.horizontal,
      children: <Widget>[
        Container(
            height: 150.0,
            child: Column(
              children: <Widget>[
                Flexible(
                  child: Scrollbar(
                    child: ListView.builder(
                      scrollDirection: Axis.vertical,
                      itemCount: textList.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Row(
                          children: <Widget>[
                            Checkbox(
                              value: checkboxList[index],
                              activeColor: Colors.green,
                              onChanged: (bool newVal) {
                                checkboxList[index] = newVal;
                                setState(() {
                                  if (checkboxList[index]) {
                                    selectedck.add(textList[index]);
                                    setText();
                                  } else {
                                    selectedck.remove(textList[index]);
                                    setText();
                                  }
                                });
                              },
                            ),
                            Text(textList[index])
                          ],
                        );
                      },
                    ),
                  ),
                ),
              ],
            )),
      ],
    );
  }
}

class ModalBottomSheetSkip extends StatefulWidget {
  _ModalBottomSheetSkipState createState() => _ModalBottomSheetSkipState();
}

class _ModalBottomSheetSkipState extends State<ModalBottomSheetSkip> {
  bool _value = false;
  bool _value2 = false;

  TextEditingController controller = new TextEditingController();
  List<String> textList = [
    "Alasan 1",
    "Alasan 2",
    "Alasan 3",
    "Alasan 4",
    "Alasan 5"
  ];
  List<bool> checkboxList = [false, false, false, false, false];
  String listck = '';
  List<String> selectedck = new List();

  setText() {
    if (selectedck.length == 0) {
      listck = '';
    } else {
      listck = selectedck.join(', ');
    }

    print(listck);
  }

  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          ListTile(
            dense: true,
            title: Text(
              'DONE',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.green),
            ),
          ),
          contentwrap(),
          ButtonTheme.bar(
            child: ButtonBar(
              children: <Widget>[
                FlatButton(
                  child: Text('SAVE'),
                  onPressed: () {},
                ),
                FlatButton(
                  child: Text(
                    'CANCEL',
                    style: TextStyle(color: Colors.black54),
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget contentwrap() {
    return Wrap(
      spacing: 0.0,
      runSpacing: 0.0,
      direction: Axis.horizontal,
      children: <Widget>[
        Container(
            height: 150.0,
            child: Column(
              children: <Widget>[
                Flexible(
                  child: Scrollbar(
                    child: ListView.builder(
                      scrollDirection: Axis.vertical,
                      itemCount: textList.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Row(
                          children: <Widget>[
                            Checkbox(
                              value: checkboxList[index],
                              activeColor: Colors.green,
                              onChanged: (bool newVal) {
                                checkboxList[index] = newVal;
                                setState(() {
                                  if (checkboxList[index]) {
                                    selectedck.add(textList[index]);
                                    setText();
                                  } else {
                                    selectedck.remove(textList[index]);
                                    setText();
                                  }
                                });
                              },
                            ),
                            Text(textList[index])
                          ],
                        );
                      },
                    ),
                  ),
                ),
              ],
            )),
      ],
    );
  }
}

class FormMaintenance extends StatefulWidget {
  FormMaintenance({Key key}) : super(key: key);

  _FormMaintenanceState createState() => _FormMaintenanceState();
}

class _FormMaintenanceState extends State<FormMaintenance> {
  bool _note = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: DefaultTabController(
        length: 2,
        child: Scaffold(
          resizeToAvoidBottomPadding: false,
          appBar: _appBar(),
          body: TabBarView(
            children: <Widget>[
              _buildApprovalForm(),
              _buildReportForm(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildApprovalForm() {
    return ListView(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              SizedBox(
                width: 100.0,
                height: 35.0,
                child: Container(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Flexible(
                          child: Text(
                            'Lokasi',
                            style:
                            TextStyle(color: Colors.white, fontSize: 12.0),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    ),
                  ),
                  decoration: BoxDecoration(
                    color: Color(0xFF2F592F),
                  ),
                ),
              ),
              SizedBox(
                width: 100.0,
                height: 35.0,
                child: Container(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Flexible(
                          child: Text(
                            'Item',
                            style:
                            TextStyle(color: Colors.white, fontSize: 12.0),
                            textAlign: TextAlign.start,
                          ),
                        ),
                      ],
                    ),
                  ),
                  decoration: BoxDecoration(
                    color: Color(0xFF2F592F),
                  ),
                ),
              ),
              SizedBox(
                width: 100.0,
                height: 35.0,
                child: Container(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Flexible(
                          child: Text(
                            'Merek',
                            style:
                            TextStyle(color: Colors.white, fontSize: 12.0),
                            textAlign: TextAlign.start,
                          ),
                        ),
                      ],
                    ),
                  ),
                  decoration: BoxDecoration(
                    color: Color(0xFF2F592F),
                  ),
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(right: 20.0, left: 20.0, bottom: 10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                width: 100.0,
                child: Row(
                  children: <Widget>[
                    Flexible(
                      child: Text(
                        'Outlet A',
                        style: TextStyle(color: Colors.grey[500]),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                width: 100.0,
                child: Row(
                  children: <Widget>[
                    Flexible(
                      child: Text(
                        'Computer',
                        style: TextStyle(color: Colors.grey[500]),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                width: 100.0,
                child: Row(
                  children: <Widget>[
                    Flexible(
                      child: Text(
                        'Lenovo',
                        style: TextStyle(color: Colors.grey[500]),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              ButtonTheme(
                minWidth: 50.0,
                height: 20.0,
                child: OutlineButton(
                  child: Text(
                    'Detail',
                    style: TextStyle(fontSize: 13.0),
                  ),
                  borderSide: BorderSide(color: Colors.green, width: 1.0),
                  highlightedBorderColor: Colors.green,
                  onPressed: () {},
                ),
              ),
              ButtonTheme(
                minWidth: 50.0,
                height: 20.0,
                child: OutlineButton(
                  child: Text(
                    'Note',
                    style: TextStyle(fontSize: 13.0),
                  ),
                  borderSide: BorderSide(color: Colors.green, width: 1.0),
                  highlightedBorderColor: Colors.green,
                  onPressed: () {
                    setState(() {
                      _note = !_note;
                    });
                  },
                ),
              ),
              ButtonTheme(
                minWidth: 50.0,
                height: 20.0,
                child: OutlineButton(
                  child: Text(
                    'Skip',
                    style: TextStyle(fontSize: 13.0),
                  ),
                  borderSide: BorderSide(color: Colors.green, width: 1.0),
                  highlightedBorderColor: Colors.green,
                  onPressed: () {
                    showModalBottomSheet(
                      context: context,
                      builder: (context) {
                        return ModalBottomSheetSkip();
                      },
                    );
                  },
                ),
              ),
              ButtonTheme(
                minWidth: 50.0,
                height: 20.0,
                child: OutlineButton(
                  child: Text(
                    'Done',
                    style: TextStyle(fontSize: 13.0),
                  ),
                  borderSide: BorderSide(color: Colors.green, width: 1.0),
                  highlightedBorderColor: Colors.green,
                  onPressed: () {
                    showModalBottomSheet(
                      context: context,
                      builder: (context) {
                        return ModalBottomSheet();
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
        _note
            ? Container(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          width: 300.0,
          child: TextField(
            decoration: InputDecoration(border: OutlineInputBorder()),
            maxLines: 3,
            style: TextStyle(
              color: Colors.black,
            ),
          ),
        )
            : Container(),
        Divider(
          height: 15.0,
        ),
      ],
    );
  }

  void containerForSheet<T>({BuildContext context, Widget child}) {
    showCupertinoModalPopup<T>(
      context: context,
      builder: (BuildContext context) => child,
    ).then<void>((T value) {
      Scaffold.of(context).showSnackBar(SnackBar(
        content: Text('You clicked $value'),
        duration: Duration(milliseconds: 800),
      ));
    });
  }
}

Widget _buildReportForm() {
  return ListView(
    children: <Widget>[
      Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            SizedBox(
              width: 100.0,
              height: 35.0,
              child: Container(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Flexible(
                        child: Text(
                          'Dept / Process',
                          style: TextStyle(color: Colors.white, fontSize: 12.0),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                ),
                decoration: BoxDecoration(
                  color: Color(0xFF2F592F),
                ),
              ),
            ),
            SizedBox(
              width: 100.0,
              height: 35.0,
              child: Container(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Flexible(
                        child: Text(
                          'Score / CAR',
                          style: TextStyle(color: Colors.white, fontSize: 12.0),
                          textAlign: TextAlign.start,
                        ),
                      ),
                    ],
                  ),
                ),
                decoration: BoxDecoration(
                  color: Color(0xFF2F592F),
                ),
              ),
            ),
            SizedBox(
              width: 100.0,
              height: 35.0,
              child: Container(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Flexible(
                        child: Text(
                          'Date',
                          style: TextStyle(color: Colors.white, fontSize: 12.0),
                          textAlign: TextAlign.start,
                        ),
                      ),
                    ],
                  ),
                ),
                decoration: BoxDecoration(
                  color: Color(0xFF2F592F),
                ),
              ),
            ),
          ],
        ),
      ),
      Padding(
        padding: const EdgeInsets.only(right: 20.0, left: 20.0, bottom: 10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Container(
              width: 100.0,
              child: Row(
                children: <Widget>[
                  Flexible(
                    child: Text(
                      'HRD',
                      style: TextStyle(color: Colors.grey[500]),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              width: 100.0,
              child: Row(
                children: <Widget>[
                  Flexible(
                    child: Text(
                      '80',
                      style: TextStyle(color: Colors.grey[500]),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              width: 100.0,
              child: Row(
                children: <Widget>[
                  Flexible(
                    child: Text(
                      '17/09/2018',
                      style: TextStyle(color: Colors.grey[500]),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      Padding(
        padding: const EdgeInsets.only(right: 20.0, left: 20.0, bottom: 10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Container(
              width: 100.0,
              child: Row(
                children: <Widget>[
                  Flexible(
                    child: Text(
                      'Yani',
                      style: TextStyle(color: Colors.grey[500]),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              width: 100.0,
              child: Row(
                children: <Widget>[
                  Flexible(
                    child: Text(
                      '',
                      style: TextStyle(color: Colors.grey[500]),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              width: 100.0,
              child: Row(
                children: <Widget>[
                  Flexible(
                    child: Text(
                      '18/09/2018',
                      style: TextStyle(color: Colors.grey[500]),
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
}

Widget _appBar() {
  return AppBar(
    elevation: 0.25,
    backgroundColor: Colors.white,
    iconTheme: IconThemeData(color: Colors.black),
    title: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Image.asset(
          'assets/images/logo.png',
          height: 100.0,
          width: 120.0,
        ),
        new Container(
          child: new Row(
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(right: 15.0),
                child: Row(
                  children: [
                    Icon(
                      Icons.favorite,
                      color: Colors.red[500],
                      size: 20.0,
                    ),
                    SizedBox(
                      width: 5.0,
                    ),
                    Text(
                      '41 pts',
                      style: TextStyle(fontSize: 12.0, color: Colors.grey),
                    ),
                  ],
                ),
              )
            ],
          ),
        )
      ],
    ),
    bottom: new TabBar(
      isScrollable: false,
      indicatorColor: AbubaPallate.greenabuba,
      tabs: <Widget>[
        new Tab(
          child: Text(
            'Hardware',
            style: TextStyle(color: Colors.grey[400]),
          ),
        ), // 1st Tab
        new Tab(
          child: Text(
            'Software',
            style: TextStyle(color: Colors.grey[400]),
          ),
        ), // 1st Tab
      ],
    ),
  );
}
