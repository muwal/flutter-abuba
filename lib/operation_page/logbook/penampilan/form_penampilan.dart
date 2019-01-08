import 'package:flutter/material.dart';
import 'package:flutter_abuba/constant.dart';
import 'package:flutter_abuba/beranda/beranda_appbardua.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

class FormPenampilan extends StatefulWidget {
  @override
  _FormPenampilanState createState() => _FormPenampilanState();
}

class _FormPenampilanState extends State<FormPenampilan> {
  var ratingGrooming = 0.0;
  var ratingSeragam = 0.0;
  var ratingAksesoris = 0.0;

  var ratingOperation = 0.0;
  var ratingLSM = 0.0;
  var ratingProgramKerja = 0.0;

  var ratingTukerShift = 0.0;
  var ratingTukarOff = 0.0;

  Color _opening = Colors.green;
  Color _closing = Colors.grey;

  List<String> isiCheckbox = [
    'Alasan 1',
    'Alasan 2',
    'Alasan 3',
    'Alasan 4',
    'Alasan 5'
  ];
  List<String> valueCheckbox = ['1', '2', '3', '4', '5'];
  List<String> selectedValue = [];
  List<String> selectedAlasan = [];

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;

    return SafeArea(
      child: Scaffold(
        appBar: AbubaAppBar(),
        body: GestureDetector(
            onTap: () {
              FocusScope.of(context).requestFocus(FocusNode());
            },
            child: _buildFormMenu(width)),
      ),
    );
  }

  Widget _buildFormMenu(double width) {
    return Scrollbar(
      child: ListView(
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
                    style: TextStyle(
                        color: AbubaPallate.greenabuba, fontSize: 12.0),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 15.0),
                  child: Text(
                    'Penampilan',
                    style: TextStyle(
                        color: AbubaPallate.greenabuba, fontSize: 12.0),
                  ),
                ),
              ],
            ),
          ),
          Container(
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.only(
                right: 20.0, left: 20.0, bottom: 5.0, top: 20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                GestureDetector(
                  onTap: () {
                    setState(() {
                      _opening = Colors.green;
                      _closing = Colors.grey;
                    });
                  },
                  child: Container(
                    width: width / 4,
                    child: Column(
                      children: <Widget>[
                        Text(
                          'OPENING',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, color: _opening),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 5.0),
                          child: Divider(
                            height: 10.0,
                            color: _opening,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      _opening = Colors.grey;
                      _closing = Colors.green;
                    });
                  },
                  child: Container(
                    width: width / 4,
                    child: Column(
                      children: <Widget>[
                        Text(
                          'CLOSING',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, color: _closing),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 5.0),
                          child: Divider(
                            height: 10.0,
                            color: _closing,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              children: <Widget>[
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: 42.0,
                  child: Container(
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              'Penampilan',
                              style: TextStyle(
                                  color: Colors.white, fontSize: 14.0),
                              textAlign: TextAlign.start,
                            ),
                          ],
                        ),
                      ),
                      decoration: BoxDecoration(color: Color(0xFF2F592F))),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    GestureDetector(
                      onTap: () {
                        _showDialog();
                      },
                      child: Container(
                        width: 150.0,
                        child: Row(
                          children: <Widget>[
                            Flexible(
                              child: Text('Grooming'),
                            ),
                            IconButton(
                              icon: Icon(Icons.arrow_right),
                              onPressed: null,
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      width: 150.0,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          ButtonTheme(
                            minWidth: 20.0,
                            height: 30.0,
                            child: OutlineButton(
                              child: Text(
                                '0',
                                style: TextStyle(fontSize: 13.0),
                              ),
                              borderSide: BorderSide(color: Colors.grey),
                              textColor: Colors.grey,
                              onPressed: () {
                                showDialog(
                                  context: context,
                                  builder: (context) {
                                    return Checkbox();
                                  },
                                );
                              },
                            ),
                          ),
                          ButtonTheme(
                            minWidth: 20.0,
                            height: 30.0,
                            child: OutlineButton(
                              child: Text(
                                '1',
                                style: TextStyle(fontSize: 13.0),
                              ),
                              borderSide: BorderSide(color: Colors.grey),
                              textColor: Colors.grey,
                              onPressed: () {
                                showDialog(
                                  context: context,
                                  builder: (context) {
                                    return Checkbox();
                                  },
                                );
                              },
                            ),
                          ),
                          ButtonTheme(
                            minWidth: 20.0,
                            height: 30.0,
                            child: OutlineButton(
                              child: Text(
                                '2',
                                style: TextStyle(fontSize: 13.0),
                              ),
                              borderSide: BorderSide(color: Colors.grey),
                              textColor: Colors.grey,
                              onPressed: () {},
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Container(
                      width: 150.0,
                      child: Row(
                        children: <Widget>[
                          Flexible(
                            child: Text('Seragam'),
                          ),
                          IconButton(
                            icon: Icon(Icons.arrow_right),
                            onPressed: null,
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: 150.0,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          ButtonTheme(
                            minWidth: 20.0,
                            height: 30.0,
                            child: OutlineButton(
                              child: Text(
                                '0',
                                style: TextStyle(fontSize: 13.0),
                              ),
                              borderSide: BorderSide(color: Colors.grey),
                              textColor: Colors.grey,
                              onPressed: () {},
                            ),
                          ),
                          ButtonTheme(
                            minWidth: 20.0,
                            height: 30.0,
                            child: OutlineButton(
                              child: Text(
                                '1',
                                style: TextStyle(fontSize: 13.0),
                              ),
                              borderSide: BorderSide(color: Colors.grey),
                              textColor: Colors.grey,
                              onPressed: () {},
                            ),
                          ),
                          ButtonTheme(
                            minWidth: 20.0,
                            height: 30.0,
                            child: OutlineButton(
                              child: Text(
                                '2',
                                style: TextStyle(fontSize: 13.0),
                              ),
                              borderSide: BorderSide(color: Colors.grey),
                              textColor: Colors.grey,
                              onPressed: () {},
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Container(
                      width: 150.0,
                      child: Row(
                        children: <Widget>[
                          Flexible(
                            child: Text('Aksesoris'),
                          ),
                          IconButton(
                            icon: Icon(Icons.arrow_right),
                            onPressed: null,
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: 150.0,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          ButtonTheme(
                            minWidth: 20.0,
                            height: 30.0,
                            child: OutlineButton(
                              child: Text(
                                '0',
                                style: TextStyle(fontSize: 13.0),
                              ),
                              borderSide: BorderSide(color: Colors.grey),
                              textColor: Colors.grey,
                              onPressed: () {},
                            ),
                          ),
                          ButtonTheme(
                            minWidth: 20.0,
                            height: 30.0,
                            child: OutlineButton(
                              child: Text(
                                '1',
                                style: TextStyle(fontSize: 13.0),
                              ),
                              borderSide: BorderSide(color: Colors.grey),
                              textColor: Colors.grey,
                              onPressed: () {},
                            ),
                          ),
                          ButtonTheme(
                            minWidth: 20.0,
                            height: 30.0,
                            child: OutlineButton(
                              child: Text(
                                '2',
                                style: TextStyle(fontSize: 13.0),
                              ),
                              borderSide: BorderSide(color: Colors.grey),
                              textColor: Colors.grey,
                              onPressed: () {},
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: 42.0,
                  child: Container(
                      child: Padding(
                        padding: EdgeInsets.only(left: 10.0, right: 10.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              'Evaluasi',
                              style: TextStyle(
                                  color: Colors.white, fontSize: 14.0),
                              textAlign: TextAlign.start,
                            ),
                          ],
                        ),
                      ),
                      decoration: BoxDecoration(color: Color(0xFF2F592F))),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Container(
                      width: 150.0,
                      child: Row(
                        children: <Widget>[
                          Flexible(
                            child: Text('Operation'),
                          ),
                          IconButton(
                            icon: Icon(Icons.arrow_right),
                            onPressed: null,
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: 150.0,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          ButtonTheme(
                            minWidth: 20.0,
                            height: 30.0,
                            child: OutlineButton(
                              child: Text(
                                '0',
                                style: TextStyle(fontSize: 13.0),
                              ),
                              borderSide: BorderSide(color: Colors.grey),
                              textColor: Colors.grey,
                              onPressed: () {},
                            ),
                          ),
                          ButtonTheme(
                            minWidth: 20.0,
                            height: 30.0,
                            child: OutlineButton(
                              child: Text(
                                '1',
                                style: TextStyle(fontSize: 13.0),
                              ),
                              borderSide: BorderSide(color: Colors.grey),
                              textColor: Colors.grey,
                              onPressed: () {},
                            ),
                          ),
                          ButtonTheme(
                            minWidth: 20.0,
                            height: 30.0,
                            child: OutlineButton(
                              child: Text(
                                '2',
                                style: TextStyle(fontSize: 13.0),
                              ),
                              borderSide: BorderSide(color: Colors.grey),
                              textColor: Colors.grey,
                              onPressed: () {},
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Container(
                      width: 150.0,
                      child: Row(
                        children: <Widget>[
                          Flexible(
                            child: Text('LSM'),
                          ),
                          IconButton(
                            icon: Icon(Icons.arrow_right),
                            onPressed: null,
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: 150.0,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          ButtonTheme(
                            minWidth: 20.0,
                            height: 30.0,
                            child: OutlineButton(
                              child: Text(
                                '0',
                                style: TextStyle(fontSize: 13.0),
                              ),
                              borderSide: BorderSide(color: Colors.grey),
                              textColor: Colors.grey,
                              onPressed: () {},
                            ),
                          ),
                          ButtonTheme(
                            minWidth: 20.0,
                            height: 30.0,
                            child: OutlineButton(
                              child: Text(
                                '1',
                                style: TextStyle(fontSize: 13.0),
                              ),
                              borderSide: BorderSide(color: Colors.grey),
                              textColor: Colors.grey,
                              onPressed: () {},
                            ),
                          ),
                          ButtonTheme(
                            minWidth: 20.0,
                            height: 30.0,
                            child: OutlineButton(
                              child: Text(
                                '2',
                                style: TextStyle(fontSize: 13.0),
                              ),
                              borderSide: BorderSide(color: Colors.grey),
                              textColor: Colors.grey,
                              onPressed: () {},
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Container(
                      width: 150.0,
                      child: Row(
                        children: <Widget>[
                          Flexible(
                            child: Text('Program Kerja'),
                          ),
                          IconButton(
                            icon: Icon(Icons.arrow_right),
                            onPressed: null,
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: 150.0,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          ButtonTheme(
                            minWidth: 20.0,
                            height: 30.0,
                            child: OutlineButton(
                              child: Text(
                                '0',
                                style: TextStyle(fontSize: 13.0),
                              ),
                              borderSide: BorderSide(color: Colors.grey),
                              textColor: Colors.grey,
                              onPressed: () {},
                            ),
                          ),
                          ButtonTheme(
                            minWidth: 20.0,
                            height: 30.0,
                            child: OutlineButton(
                              child: Text(
                                '1',
                                style: TextStyle(fontSize: 13.0),
                              ),
                              borderSide: BorderSide(color: Colors.grey),
                              textColor: Colors.grey,
                              onPressed: () {},
                            ),
                          ),
                          ButtonTheme(
                            minWidth: 20.0,
                            height: 30.0,
                            child: OutlineButton(
                              child: Text(
                                '2',
                                style: TextStyle(fontSize: 13.0),
                              ),
                              borderSide: BorderSide(color: Colors.grey),
                              textColor: Colors.grey,
                              onPressed: () {},
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: 42.0,
                  child: Container(
                      child: Padding(
                        padding: EdgeInsets.only(left: 10.0, right: 10.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              'Schedule',
                              style: TextStyle(
                                  color: Colors.white, fontSize: 14.0),
                              textAlign: TextAlign.start,
                            ),
                          ],
                        ),
                      ),
                      decoration: BoxDecoration(color: Color(0xFF2F592F))),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Container(
                      width: 150.0,
                      child: Row(
                        children: <Widget>[
                          Flexible(
                            child: Text('Tukar Shift'),
                          ),
                          IconButton(
                            icon: Icon(Icons.arrow_right),
                            onPressed: null,
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: 150.0,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          ButtonTheme(
                            minWidth: 20.0,
                            height: 30.0,
                            child: OutlineButton(
                              child: Text(
                                '0',
                                style: TextStyle(fontSize: 13.0),
                              ),
                              borderSide: BorderSide(color: Colors.grey),
                              textColor: Colors.grey,
                              onPressed: () {},
                            ),
                          ),
                          ButtonTheme(
                            minWidth: 20.0,
                            height: 30.0,
                            child: OutlineButton(
                              child: Text(
                                '1',
                                style: TextStyle(fontSize: 13.0),
                              ),
                              borderSide: BorderSide(color: Colors.grey),
                              textColor: Colors.grey,
                              onPressed: () {},
                            ),
                          ),
                          ButtonTheme(
                            minWidth: 20.0,
                            height: 30.0,
                            child: OutlineButton(
                              child: Text(
                                '2',
                                style: TextStyle(fontSize: 13.0),
                              ),
                              borderSide: BorderSide(color: Colors.grey),
                              textColor: Colors.grey,
                              onPressed: () {},
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Container(
                      width: 150.0,
                      child: Row(
                        children: <Widget>[
                          Flexible(
                            child: Text('Tukar Off'),
                          ),
                          IconButton(
                            icon: Icon(Icons.arrow_right),
                            onPressed: null,
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: 150.0,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          ButtonTheme(
                            minWidth: 20.0,
                            height: 30.0,
                            child: OutlineButton(
                              child: Text(
                                '0',
                                style: TextStyle(fontSize: 13.0),
                              ),
                              borderSide: BorderSide(color: Colors.grey),
                              textColor: Colors.grey,
                              onPressed: () {},
                            ),
                          ),
                          ButtonTheme(
                            minWidth: 20.0,
                            height: 30.0,
                            child: OutlineButton(
                              child: Text(
                                '1',
                                style: TextStyle(fontSize: 13.0),
                              ),
                              borderSide: BorderSide(color: Colors.grey),
                              textColor: Colors.grey,
                              onPressed: () {},
                            ),
                          ),
                          ButtonTheme(
                            minWidth: 20.0,
                            height: 30.0,
                            child: OutlineButton(
                              child: Text(
                                '2',
                                style: TextStyle(fontSize: 13.0),
                              ),
                              borderSide: BorderSide(color: Colors.grey),
                              textColor: Colors.grey,
                              onPressed: () {},
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
                ButtonTheme(
                  minWidth: 50.0,
                  height: 30.0,
                  child: RaisedButton(
                    child: Text(
                      'SAVE',
                      style: TextStyle(fontSize: 13.0),
                    ),
                    textColor: Colors.white,
                    color: Colors.green,
                    onPressed: () {},
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _showDialog() {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("Critical to Quality"),
          content: Container(
            height: 150.0,
            child: Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Flexible(
                      child: new Text(
                        "1. Rambut menggunakan jel",
                        style: TextStyle(fontSize: 12.0),
                      ),
                    )
                  ],
                ),
                Row(
                  children: <Widget>[
                    Flexible(
                      child: new Text(
                        "2. Rambut laki-laki tidak melibihi kuping",
                        style: TextStyle(fontSize: 12.0),
                      ),
                    )
                  ],
                ),
                Row(
                  children: <Widget>[
                    Flexible(
                      child: new Text(
                        "3. Rambut disisir rapih",
                        style: TextStyle(fontSize: 12.0),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text("Close"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}

class Checkbox extends StatefulWidget {
  Checkbox({
    this.alasan,
    this.selectedAlasan,
    this.selectedValue,
    this.onSelectedAlasanListChanged,
    this.onCancelResult,
    this.valueCheck,
    this.lokasi,
    this.item,
    this.merek,
  });

  final List<String> alasan;
  final List<String> valueCheck;
  final List<String> selectedAlasan;
  final List<String> selectedValue;
  final ValueChanged<List<String>> onSelectedAlasanListChanged;
  final ValueChanged<List<String>> onCancelResult;
  final String lokasi;
  final String item;
  final String merek;

  @override
  _CheckboxState createState() => new _CheckboxState();
}

class _CheckboxState extends State<Checkbox> {
  List<String> _tempSelectedAlasan = [];
  List<String> _tempSelectedValueAlasan = [];

  bool _note = false;
  bool _check = false;
  double height = 300.0;
  TextEditingController _noteController = new TextEditingController();

  @override
  void initState() {
    _tempSelectedAlasan = widget.selectedAlasan;
    _tempSelectedValueAlasan = widget.selectedValue;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        height: height,
        child: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(15.0),
              child: Center(
                  child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Flexible(
                    child: Text(
                      'Alasan',
                      style: TextStyle(fontSize: 16.0, color: Colors.black),
                      textAlign: TextAlign.left,
                    ),
                  ),
                  FlatButton(
                    child: Text(
                      'Add Note',
                      style: TextStyle(color: Colors.green, fontSize: 12.0),
                    ),
                    onPressed: () {
                      setState(
                        () {
                          if (_note == true) {
                            height = 300.0;
                          } else {
                            height = height + 100.0;
                          }

                          _note = !_note;
                        },
                      );
                    },
                  ),
                ],
              )),
            ),
            Expanded(
              child: Scrollbar(
                child: ListView(
                  scrollDirection: Axis.vertical,
                  children: <Widget>[
                    Container(
                      child: CheckboxListTile(
                          title: Text('1'),
                          controlAffinity: ListTileControlAffinity.leading,
                          activeColor: Colors.green,
                          value: _check,
                          onChanged: (bool value) {
                            setState(() {
                              _check = value;
                            });
                          }),
                    )
                  ],
                ),
              ),
            ),
            _note
                ? Padding(
                    padding:
                        EdgeInsets.only(top: 20.0, right: 10.0, left: 10.0),
                    child: Container(
                      width: MediaQuery.of(context).size.width / 1.1,
                      child: TextField(
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: 'Note',
                        ),
                        maxLines: 3,
                        controller: _noteController,
                        style: TextStyle(
                          color: Colors.black,
                        ),
                      ),
                    ),
                  )
                : Container(),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(right: 10.0),
                    child: RaisedButton(
                      color: Colors.red[300],
                      child: Text(
                        'CANCEL',
                        style: TextStyle(color: Colors.white, fontSize: 12.0),
                      ),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      splashColor: Colors.red[300],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(right: 10.0),
                    child: RaisedButton(
                      color: Colors.green[300],
                      child: Text(
                        'OK',
                        style: TextStyle(color: Colors.white, fontSize: 12.0),
                      ),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      splashColor: Colors.green[300],
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
