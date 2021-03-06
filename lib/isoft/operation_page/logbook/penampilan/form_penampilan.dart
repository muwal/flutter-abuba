import 'package:flutter/material.dart';

class FormPenampilan extends StatefulWidget {
  @override
  _FormPenampilanState createState() => _FormPenampilanState();
}

class _FormPenampilanState extends State<FormPenampilan> with TickerProviderStateMixin {

  List<Map> _title = [
    {
      'nomor': 1,
      'title': 'Grooming',
      'area': 'Penampilan',
      'save': 'false',
    },
    {
      'nomor': 2,
      'title': 'Seragam',
      'area': 'Penampilan',
      'save': 'false',
    },
    {
      'nomor': 3,
      'title': 'Aksesoris',
      'area': 'Penampilan',
      'save': 'false',
    },
    {
      'nomor': 4,
      'title': 'Operation',
      'area': 'Evaluasi',
      'save': 'false',
    },
    {
      'nomor': 5,
      'title': 'LSM',
      'area': 'Evaluasi',
      'save': 'true',
    },
    {
      'nomor': 6,
      'title': 'Program Kerja',
      'area': 'Evaluasi',
      'save': 'true',
    },
    {
      'nomor': 7,
      'title': 'LSM',
      'area': 'Program Kerja',
      'save': 'true',
    },
    {
      'nomor': 8,
      'title': 'Glassware, silverware, chinaware, cutleries, napkin, container',
      'area': 'Bar Tender',
      'save': 'true',
    },
    {
      'nomor': 9,
      'title': 'Tukar Off',
      'area': 'Schedule',
      'save': 'true',
    },
  ];

  bool _answer0 = false;
  Color _answer0Color = Colors.grey;
  bool _answer1 = false;
  Color _answer1Color = Colors.grey;
  bool _answer2 = false;
  Color _answer2Color = Colors.grey;

  List<String> isiCheckbox = [
    'Rambut menggunakan gel',
    'Rambut laki-laki tidak melibihi telinga',
    'Rambut disisir rapih',
  ];
  List<String> valueCheckbox = ['1', '2', '3'];
  List<String> selectedValue = [];
  List<String> selectedAlasan = [];

  List<Map> _listData = [
    {'nomor': '1'},
    {'nomor': '2'},
    {'nomor': '3'},
    {'nomor': '4'},
    {'nomor': '5'},
    {'nomor': '6'},
    {'nomor': '7'},
    {'nomor': '8'},
    {'nomor': '9'},
  ];

  @override
  void initState() {
    super.initState();
    _cardController = new TabController(vsync: this, length: _listData.length);
  }

  TabController _cardController;

  @override
  void dispose() {
    _cardController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: _appBar(),
        backgroundColor: Colors.white,
        body: GestureDetector(
            onTap: () {
              FocusScope.of(context).requestFocus(FocusNode());
            },
            child: _buildFormMenu()),
        bottomNavigationBar: _bottomBar(),
      ),
    );
  }

  Widget _buildFormMenu() {
    return Column(
      children: <Widget>[
        Expanded(
          child: TabBarView(
            controller: _cardController,
            physics: ScrollPhysics(),
            children: _title.map((Map map) {
              return ListView(
                shrinkWrap: true,
                physics: ScrollPhysics(),
                children: <Widget>[
                  PreferredSize(
                    preferredSize: Size.fromHeight(55.0),
                    child: Column(
                      children: <Widget>[
                        SizedBox(
                          width: MediaQuery.of(context).size.width,
                          height: 55.0,
                          child: Container(
                              child: Padding(
                                padding: EdgeInsets.symmetric(horizontal: 10.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: <Widget>[
                                        Text(
                                          'Score',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 12.0),
                                          textAlign: TextAlign.start,
                                        ),
                                        Text(
                                          '80%',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 20.0),
                                          textAlign: TextAlign.start,
                                        )
                                      ],
                                    ),
                                    Text(
                                      '${map['nomor'].toString()} of ${_title.length.toString()}',
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 14.0),
                                      textAlign: TextAlign.start,
                                    ),
                                  ],
                                ),
                              ),
                              decoration:
                                  BoxDecoration(color: Color(0xFF2F592F))),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width,
                          height: 55.0,
                          child: Container(
                            child: Padding(
                                padding: EdgeInsets.symmetric(horizontal: 10.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Text(
                                          'Penampilan',
                                          style: TextStyle(
                                              color: Colors.black54,
                                              fontSize: 16.0),
                                          textAlign: TextAlign.start,
                                        ),
                                        Text(
                                          'Operation',
                                          style: TextStyle(
                                              color: Colors.black54,
                                              fontSize: 16.0),
                                          textAlign: TextAlign.start,
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Text(
                                          'Log Book MOD',
                                          style: TextStyle(
                                              color: Colors.black54,
                                              fontSize: 12.0),
                                          textAlign: TextAlign.start,
                                        ),
                                        Text(
                                          'Department',
                                          style: TextStyle(
                                              color: Colors.black54,
                                              fontSize: 12.0),
                                          textAlign: TextAlign.start,
                                        ),
                                      ],
                                    ),
                                  ],
                                )),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 8.0),
                          child: Divider(
                            height: 1.0,
                          ),
                        )
                      ],
                    ),
                  ),
                  Row(
                    children: <Widget>[
                      Flexible(
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 15.0),
                          child: Text(
                            map['title'],
                            style: TextStyle(
                                color: Color(0xFF2F592F),
                                fontSize: 24.0,
                                fontWeight: FontWeight.bold),
                            textAlign: TextAlign.start,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Flexible(
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 15.0, vertical: 5.0),
                          child: Text(
                            map['area'],
                            style: TextStyle(
                                color: Colors.black54, fontSize: 18.0),
                            textAlign: TextAlign.start,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Flexible(
                        child: ListView.builder(
                          shrinkWrap: true,
                          physics: ScrollPhysics(),
                          itemCount: isiCheckbox.length,
                          itemBuilder: (BuildContext context, int index) {
                            double top;
                            double bottom;
                            if (index == 0) {
                              top = 30.0;
                              bottom = 0.0;
                            } else if (index == isiCheckbox.length - 1) {
                              top = 5.0;
                              bottom = 40.0;
                            } else {
                              top = 5.0;
                              bottom = 0.0;
                            }

                            return Row(
                              children: <Widget>[
                                Flexible(
                                  child: Padding(
                                    padding: EdgeInsets.only(
                                        left: 15.0,
                                        right: 15.0,
                                        top: top,
                                        bottom: bottom),
                                    child: Text(
                                      '${index + 1}. ${isiCheckbox[index]}',
                                      style: TextStyle(
                                          color: Colors.black54,
                                          fontSize: 22.0),
                                      textAlign: TextAlign.start,
                                    ),
                                  ),
                                ),
                              ],
                            );
                          },
                        ),
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      ButtonTheme(
                        height: 60.0,
                        minWidth: 70.0,
                        child: OutlineButton(
                          child: Text(
                            '0',
                            style:
                                TextStyle(fontSize: 26.0, color: _answer0Color),
                          ),
                          borderSide:
                              BorderSide(color: _answer0Color, width: 1.0),
                          highlightedBorderColor: _answer0Color,
                          onPressed: () {
                            showDialog(
                                barrierDismissible: false,
                                context: context,
                                builder: (context) {
                                  return Checkbox(
                                    alasan: isiCheckbox,
                                    valueCheck: valueCheckbox,
                                    selectedAlasan: selectedAlasan,
                                    selectedValue: selectedValue,
                                    onSelectedAlasanListChanged: (alasans) {
                                      selectedAlasan = alasans;
                                    },
                                    onResult: (finalResult) {
                                      setState(() {
                                        if (finalResult[0] == 'yes') {
                                          _answer0 = true;
                                          _answer1 = false;
                                          _answer2 = false;
                                          _answer0Color = Colors.green;
                                          _answer1Color = Colors.grey;
                                          _answer2Color = Colors.grey;
                                        } else {
                                          _answer0 = false;
                                          _answer1 = false;
                                          _answer2 = false;
                                          _answer0Color = Colors.grey;
                                          _answer1Color = Colors.grey;
                                          _answer2Color = Colors.grey;
                                        }
                                      });
                                    },
                                  );
                                });
                          },
                        ),
                      ),
                      ButtonTheme(
                        height: 60.0,
                        minWidth: 70.0,
                        child: OutlineButton(
                          child: Text(
                            '1',
                            style:
                                TextStyle(fontSize: 26.0, color: _answer1Color),
                          ),
                          borderSide:
                              BorderSide(color: _answer1Color, width: 1.0),
                          highlightedBorderColor: _answer1Color,
                          onPressed: () {
                            showDialog(
                                barrierDismissible: false,
                                context: context,
                                builder: (context) {
                                  return Checkbox(
                                    alasan: isiCheckbox,
                                    valueCheck: valueCheckbox,
                                    selectedAlasan: selectedAlasan,
                                    selectedValue: selectedValue,
                                    onSelectedAlasanListChanged: (alasans) {
                                      selectedAlasan = alasans;
                                    },
                                    onResult: (finalResult) {
                                      setState(() {
                                        if (finalResult[0] == 'yes') {
                                          _answer0 = false;
                                          _answer1 = true;
                                          _answer2 = false;
                                          _answer1Color = Colors.green;
                                          _answer0Color = Colors.grey;
                                          _answer2Color = Colors.grey;
                                        } else {
                                          _answer0 = false;
                                          _answer1 = false;
                                          _answer2 = false;
                                          _answer0Color = Colors.grey;
                                          _answer1Color = Colors.grey;
                                          _answer2Color = Colors.grey;
                                        }
                                      });
                                    },
                                  );
                                });
                          },
                        ),
                      ),
                      ButtonTheme(
                        height: 60.0,
                        minWidth: 70.0,
                        child: OutlineButton(
                          child: Text(
                            '2',
                            style:
                                TextStyle(fontSize: 26.0, color: _answer2Color),
                          ),
                          borderSide:
                              BorderSide(color: _answer2Color, width: 1.0),
                          highlightedBorderColor: _answer2Color,
                          onPressed: () {
                            setState(() {
                              _answer0 = false;
                              _answer1 = false;
                              _answer2 = true;
                              _answer0Color = Colors.grey;
                              _answer1Color = Colors.grey;
                              _answer2Color = Colors.green;
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              );
            }).toList(),
          ),
        )
      ],
    );
  }

  Widget _bottomBar() {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: 55.0,
      child: Container(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    ButtonTheme(
                      minWidth: 50.0,
                      height: 30.0,
                      child: RaisedButton(
                        child: Text(
                          'SEARCH',
                          style: TextStyle(fontSize: 13.0),
                        ),
                        textColor: Colors.black45,
                        color: Colors.green[200],
                        onPressed: () {},
                      ),
                    ),
                    SizedBox(
                      width: 5.0,
                    ),
                    ButtonTheme(
                      minWidth: 50.0,
                      height: 30.0,
                      child: RaisedButton(
                        child: Text(
                          'CAR',
                          style: TextStyle(fontSize: 13.0),
                        ),
                        textColor: Colors.white,
                        color: Colors.green,
                        onPressed: () {},
                      ),
                    ),
                    _listData == 9
                        ? ButtonTheme(
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
                          )
                        : ButtonTheme(
                            minWidth: 50.0,
                            height: 30.0,
                            child: RaisedButton(
                              elevation: 0.0,
                              child: Text(
                                'SAVE',
                                style: TextStyle(fontSize: 13.0),
                              ),
                              textColor: Color(0xFF2F592F),
                              color: Color(0xFF2F592F),
                              onPressed: () {},
                            ),
                          ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    IconButton(
                      icon: Icon(Icons.arrow_back_ios, color: Colors.white),
                      onPressed: () {
                        _cardController.animateTo(_cardController.index - 1);
                      },
                      tooltip: 'Previous',
                    ),
                    IconButton(
                      icon: Icon(Icons.arrow_forward_ios, color: Colors.white),
                      onPressed: () {
                        /*_cardController.index != 10
                            ?*/
                        _cardController.animateTo(_cardController.index + 1);
                        /*: Navigator.push(
                                context,
                                MyCustomRoute(
                                    builder: (context) => FormMockComplaint()));*/
                      },
                      tooltip: 'Next',
                    ),
                  ],
                )
              ],
            ),
          ),
          decoration: BoxDecoration(color: Color(0xFF2F592F))),
    );
  }

  Widget _appBar() {
    return AppBar(
      elevation: 0.25,
      backgroundColor: Colors.white,
      iconTheme: IconThemeData(color: Colors.black),
      title: Image.asset(
        'assets/images/logo2.png',
        height: 150.0,
        width: 120.0,
      ),
    );
  }
}

class Checkbox extends StatefulWidget {
  Checkbox({
    this.alasan,
    this.selectedAlasan,
    this.selectedValue,
    this.onSelectedAlasanListChanged,
    this.valueCheck,
    this.onResult,
  });

  final List<String> alasan;
  final List<String> valueCheck;
  final List<String> selectedAlasan;
  final List<String> selectedValue;
  final ValueChanged<List<String>> onSelectedAlasanListChanged;
  final ValueChanged<List<String>> onResult;

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
                      style: TextStyle(
                          fontSize: 16.0,
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
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
                child: ListView.builder(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    physics: ScrollPhysics(),
                    itemCount: widget.alasan.length,
                    itemBuilder: (BuildContext context, int index) {
                      final AlasanValue = widget.alasan[index];
                      final ValueFinal = widget.valueCheck[index];

                      return Container(
                        child: CheckboxListTile(
                            title: Text(AlasanValue),
                            controlAffinity: ListTileControlAffinity.leading,
                            activeColor: Colors.green,
                            value: _tempSelectedAlasan.contains(AlasanValue),
                            onChanged: (bool value) {
                              if (value) {
                                if (!_tempSelectedAlasan
                                    .contains(AlasanValue)) {
                                  setState(
                                    () {
                                      _tempSelectedValueAlasan.add(ValueFinal);
                                      _tempSelectedAlasan.add(AlasanValue);
                                    },
                                  );
                                }
                              } else {
                                if (_tempSelectedAlasan.contains(AlasanValue)) {
                                  setState(
                                    () {
                                      _tempSelectedAlasan.removeWhere(
                                          (String city) => city == AlasanValue);
                                      _tempSelectedValueAlasan.removeWhere(
                                          (String city) => city == ValueFinal);
                                    },
                                  );
                                }
                              }
                              widget.onSelectedAlasanListChanged(
                                  _tempSelectedValueAlasan);
                            }),
                      );
                    }),
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
                        widget.onResult(['no']);
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
                        widget.onResult(['yes']);
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