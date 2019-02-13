import 'package:flutter/material.dart';
import 'package:flutter_abuba/constant.dart';
import 'package:flutter_abuba/beranda/beranda_appbardua.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

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

class CheckboxDua extends StatefulWidget {
  CheckboxDua({
    this.alasan,
    this.selectedAlasan,
    this.selectedValue,
    this.actTime,
    this.onSelectedAlasanListChanged,
    this.valueCheck,
    this.onResult,
    this.onSelectedActTime,
  });

  final List<String> alasan;
  final List<String> valueCheck;
  final List<String> selectedAlasan;
  final List<String> selectedValue;
  final List<dynamic> actTime;
  final ValueChanged<List<String>> onSelectedAlasanListChanged;
  final ValueChanged<List<String>> onResult;
  final ValueChanged<List<dynamic>> onSelectedActTime;

  @override
  _CheckboxDuaState createState() => new _CheckboxDuaState();
}

class _CheckboxDuaState extends State<CheckboxDua> {
  List<String> _tempSelectedAlasan = [];
  List<String> _tempSelectedValueAlasan = [];
  List<dynamic> _tempActTime = [];

  bool _note = false;
  bool _check = false;
  double height = 300.0;
  TextEditingController _noteController = new TextEditingController();

  @override
  void initState() {
    _tempSelectedAlasan = widget.selectedAlasan;
    _tempSelectedValueAlasan = widget.selectedValue;
    _tempActTime = widget.actTime;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        height: height,
        child: Column(
          children: <Widget>[
            Container(
              color: Color.fromARGB(240, 255, 206, 79),
              height: 50.0,
              child: Center(
                child: Text(
                  'ORDER',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16.0,
                    fontWeight: FontWeight.w700),
                ),
              ),
            ),
            SizedBox(
              height: 20.0,
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
                            if (!_tempSelectedAlasan.contains(AlasanValue)) {
                              setState(() {
                                _tempSelectedValueAlasan.add(ValueFinal);
                                _tempSelectedAlasan.add(AlasanValue);
                                _tempActTime.add(null);
                                },
                              );
                            }
                          } else {
                            if (_tempSelectedAlasan.contains(AlasanValue)) {
                              setState(() {
                                _tempSelectedAlasan.removeWhere((String city) => city == AlasanValue);
                                _tempSelectedValueAlasan.removeWhere((String city) => city == ValueFinal);
                                _tempActTime.removeLast();
                                },
                              );
                            }
                          }
                          widget.onSelectedAlasanListChanged(_tempSelectedValueAlasan);
                          widget.onSelectedActTime(_tempActTime);
                        }
                      ),
                    );
                  }
                ),
              ),
            ),
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
                        'CONFIRM',
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

class FormSuasanaResto extends StatefulWidget {
  final String outlet;
  final int idOutlet;
  final String imageOutlet;
  final String alamatOutlet;
  final int idUser;
  final int idMysteryGuest;
  FormSuasanaResto(
      {this.outlet, this.imageOutlet, this.alamatOutlet, this.idOutlet, this.idUser, this.idMysteryGuest});

  @override
  _FormSuasanaRestoState createState() => _FormSuasanaRestoState();
}

class _FormSuasanaRestoState extends State<FormSuasanaResto> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: _appBar(),
        body: Scrollbar(
          child: ListView(
            children: <Widget>[
              Container(
                height: 400.0,
                width: MediaQuery.of(context).size.width,
                color: Colors.white,
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            'Mystery Shopper',
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
                              'Location',
                              style: TextStyle(
                                  color: AbubaPallate.greenabuba, fontSize: 12.0),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(20.0, 100.0, 20.0, 20.0),
                      child: Column(
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Flexible(
                                child: Text(
                                  'Perhatikan suasana resto',
                                  style: TextStyle(
                                      color: AbubaPallate.greenabuba,
                                      fontWeight: FontWeight.w700,
                                      fontSize: 20.0),
                                ),
                              )
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Flexible(
                                child: Text(
                                  'Pilih tempat duduk yang memudahkan Anda melihat suasana resto secara utuh',
                                  style: TextStyle(
                                      fontSize: 14.0, color: Colors.black54),
                                  textAlign: TextAlign.center,
                                ),
                              )
                            ],
                          ),
                          SizedBox(
                            height: 30.0,
                          ),
                          ButtonTheme(
                            minWidth: 50.0,
                            height: 40.0,
                            child: RaisedButton(
                              shape: new RoundedRectangleBorder(
                                  borderRadius: new BorderRadius.circular(5.0)),
                              child: Text(
                                'PAHAM',
                                style:
                                TextStyle(fontSize: 13.0, color: Colors.white),
                              ),
                              color: Colors.blueAccent,
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MyCustomRoute(
                                        builder: (context) => FormTakingOrder(idOutlet: widget.idOutlet,alamatOutlet: widget.alamatOutlet,outlet: widget.outlet,imageOutlet: widget.imageOutlet,idUser: widget.idUser, idMysteryGuest: widget.idMysteryGuest)));
                              },
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              Container(
                child: Image.asset(
                  'assets/images/slide3.png',
                  fit: BoxFit.fitWidth,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _appBar() {
    return AppBar(
      elevation: 0.25,
      backgroundColor: Colors.white,
      iconTheme: IconThemeData(color: Colors.black),
      leading: IconButton(
        icon: Icon(Icons.arrow_back),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
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
    );
  }
}

class FormTakingOrder extends StatefulWidget {
  final String outlet;
  final int idOutlet;
  final String imageOutlet;
  final String alamatOutlet;
  final int idUser;
  final int idMysteryGuest;
  FormTakingOrder(
      {this.outlet, this.imageOutlet, this.alamatOutlet, this.idOutlet, this.idUser, this.idMysteryGuest});

  @override
  _FormTakingOrderState createState() => _FormTakingOrderState();
}

class _FormTakingOrderState extends State<FormTakingOrder> with TickerProviderStateMixin {
  List<Map> _listData = [
    {'nomor': '1'},
    {'nomor': '2'},
    {'nomor': '3'}
  ];

  GlobalKey<ScaffoldState> _globalKey = GlobalKey<ScaffoldState>();

  List<String> isiCheckbox = ['Drink','Juice','Appetizer','Main Course','Dessert'];
  List<String> valueCheckbox = ['Drink','Juice','Appetizer','Main Course','Dessert'];
  List<String> selectedValue = [];
  List<String> selectedAlasan = [];
  List<dynamic> act_time = [];
  String nextButton = 'blank';

  TabController _cardController;
  DateTime orderStart = DateTime.now();

  @override
  void initState() {
    super.initState();
    _cardController = new TabController(vsync: this, length: _listData.length);
  }

  @override
  void dispose() {
    _cardController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        key: _globalKey,
        backgroundColor: Colors.white,
        appBar: _appBar(),
        body: GestureDetector(
          onTap: () {
            FocusScope.of(context).requestFocus(FocusNode());
          },
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  child: TabBarView(
                    controller: _cardController,
                    physics: NeverScrollableScrollPhysics(),
                    children: <Widget>[
                      ListView(
                        physics: ScrollPhysics(),
                        shrinkWrap: true,
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
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 10.0),
                                        child: Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            Text(
                                              'Taking Order',
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 14.0),
                                              textAlign: TextAlign.start,
                                            ),
                                            Text(
                                              '1 of ${_listData.length.toString()}',
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 14.0),
                                              textAlign: TextAlign.start,
                                            ),
                                          ],
                                        ),
                                      ),
                                      decoration: BoxDecoration(
                                          color: Color(0xFF2F592F))),
                                ),
                              ],
                            ),
                          ),
                          Stack(
                            children: <Widget>[
                              Image.asset(
                                'assets/images/slide 4copy.png',
                                fit: BoxFit.fill,
                                height: MediaQuery.of(context).size.height - 110.0,
                              ),
                              Positioned(
                                width: MediaQuery.of(context).size.width,
                                height: MediaQuery.of(context).size.height - 110.0,
                                child: Container(
                                  child: ButtonTheme(
                                    minWidth: 140.0,
                                    height: 50.0,
                                    child: RaisedButton(
                                      shape: new RoundedRectangleBorder(
                                        borderRadius:
                                        new BorderRadius.circular(5.0),
                                        side: BorderSide(
                                            width: 1.5, color: Colors.white)),
                                      child: Text(
                                        'ORDER',
                                        style: TextStyle(
                                            fontSize: 18.0,
                                            color: Colors.white),
                                        textAlign: TextAlign.center,
                                      ),
                                      color: Colors.blueAccent,
                                      onPressed: () {
                                        showDialog(
                                          context: context,
                                          barrierDismissible: false,
                                          builder: (BuildContext context) {
                                            return CheckboxDua(
                                              alasan: isiCheckbox,
                                              valueCheck: valueCheckbox,
                                              selectedAlasan: selectedAlasan,
                                              selectedValue: selectedValue,
                                              onSelectedAlasanListChanged: (alasans) {
                                                selectedAlasan = alasans;
                                                print(selectedAlasan);
                                              },
                                              onSelectedActTime: (actTimes) {
                                                act_time = actTimes;
                                                print(act_time);
                                              },
                                              actTime: act_time,
                                              onResult: (finalResult) {
                                                if (selectedAlasan.isEmpty) {
                                                  _globalKey.currentState.showSnackBar(
                                                    SnackBar(
                                                      content: Text('Select Order'),
                                                      action: SnackBarAction(
                                                        label: 'OK',
                                                        textColor: Colors.white,
                                                        onPressed: () {
                                                          _globalKey.currentState.removeCurrentSnackBar();
                                                        },
                                                      ),
                                                      duration: Duration(
                                                        milliseconds: 3000
                                                      ),
                                                    )
                                                  );
                                                } else {
                                                  if (finalResult[0] == 'yes') {
                                                    Firestore.instance.runTransaction((Transaction transaction) async {
                                                      CollectionReference reference = Firestore.instance.collection('orderList');
                                                      await reference.add({
                                                        'id_mystery_guest': widget.idMysteryGuest,
                                                        'orderTime_start': orderStart,
                                                        'order': selectedAlasan,
                                                        'actTime': act_time,
                                                      });
                                                    });
                                                    _cardController.animateTo(_cardController.index + 1);
                                                  }
                                                }
                                              },
                                            );
                                          },
                                        );
                                      },
                                    ),
                                  ),
                                  alignment: Alignment(0.0, 0.0),
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                      Column(
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
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 10.0),
                                        child: Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            Text(
                                              'Serving',
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 14.0),
                                              textAlign: TextAlign.start,
                                            ),
                                            Text(
                                              '3 of ${_listData.length.toString()}',
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 14.0),
                                              textAlign: TextAlign.start,
                                            ),
                                          ],
                                        ),
                                      ),
                                      decoration: BoxDecoration(
                                          color: Color(0xFF2F592F))),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: ListView(
                              shrinkWrap: true,
                              physics: ScrollPhysics(),
                              children: <Widget>[
                                widget.idMysteryGuest == null
                                  ? Container(
                                      child: Center(
                                        child: CircularProgressIndicator(),
                                      ),
                                    )
                                  : Container(
                                      padding: EdgeInsets.all(15.0),
                                      width: double.infinity,
                                      child: StreamBuilder(
                                        stream: Firestore.instance
                                            .collection('orderList')
                                            .where('id_mystery_guest', isEqualTo: widget.idMysteryGuest)
                                            .snapshots(),
                                        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                                          if (!snapshot.hasData) 
                                            return Container(
                                              child: Center(
                                                child: CircularProgressIndicator(),
                                              ),
                                            );

                                          return OrderList(document: snapshot.data.documents, array: act_time);
                                        },
                                      ),
                                    ),
                              ],
                            ),
                          ),
                          PreferredSize(
                            preferredSize: Size.fromHeight(MediaQuery.of(context).size.height - 110.0),
                            child: Column(
                              children: <Widget>[
                                SizedBox(
                                  width: MediaQuery.of(context).size.width,
                                  height: 55.0,
                                  child: Container(
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(horizontal: 10.0),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          nextButton == 'nextStep' || nextButton == 'blank'
                                            ? Container()
                                            : Flexible(
                                                child: Text(
                                                  '*ada tugas yang belum selesai',
                                                  style: TextStyle(
                                                    color: Colors.red[400],
                                                    fontStyle: FontStyle.italic,
                                                  ),
                                                ),
                                              ),
                                          IconButton(
                                            tooltip: 'Next Step',
                                            icon: Icon(Icons.navigate_next, color: Colors.white, size: 28.0),
                                            onPressed: () {
                                              Navigator.push(context,
                                                MaterialPageRoute(
                                                  builder: (context) => FormEnjoy(idOutlet: widget.idOutlet,alamatOutlet: widget.alamatOutlet,outlet: widget.outlet,imageOutlet: widget.imageOutlet,idUser: widget.idUser, idMysteryGuest: widget.idMysteryGuest)
                                                )
                                              );
                                            },
                                          )
                                        ],
                                      ),
                                    ),
                                    decoration: BoxDecoration(
                                        color: Color(0xFF2F592F))),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _appBar() {
    return AppBar(
      elevation: 0.25,
      backgroundColor: Colors.white,
      iconTheme: IconThemeData(color: Colors.black),
      title: Image.asset(
        'assets/images/logo.png',
        height: 100.0,
        width: 120.0,
      ),
    );
  }
}

class OrderList extends StatefulWidget {
  OrderList({this.document, this.array});
  final List<DocumentSnapshot> document;
  final List<dynamic> array;

  @override
  _OrderListState createState() => _OrderListState();
}

class _OrderListState extends State<OrderList> {
  String tampil;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(widget.document[0].data['order'].length, (index) {
        if (widget.document[0].data['actTime'][index] != null) {
          final tahun2 = widget.document[0].data['actTime'][index].toString().substring(0, 4);
          final bulan2 = widget.document[0].data['actTime'][index].toString().substring(5, 7);
          final hari2 = widget.document[0].data['actTime'][index].toString().substring(8, 10);
          final jam2 = widget.document[0].data['actTime'][index].toString().substring(11, 13);
          final menit2 = widget.document[0].data['actTime'][index].toString().substring(14, 16);
          final birthday2 = DateTime(int.parse(tahun2), int.parse(bulan2), int.parse(hari2), int.parse(jam2), int.parse(menit2));

          final tahun = widget.document[0].data['orderTime_start'].toString().substring(0, 4);
          final bulan = widget.document[0].data['orderTime_start'].toString().substring(5, 7);
          final hari = widget.document[0].data['orderTime_start'].toString().substring(8, 10);
          final jam = widget.document[0].data['orderTime_start'].toString().substring(11, 13);
          final menit = widget.document[0].data['orderTime_start'].toString().substring(14, 16);
          final birthday = DateTime(int.parse(tahun), int.parse(bulan), int.parse(hari), int.parse(jam), int.parse(menit));
          final selisih = birthday2.difference(birthday).inMinutes;
          if (selisih >= 60) {
            tampil = '1:' + (selisih - 60).toString() + ':00';
          } else {
            tampil = selisih.toString() + ':00';
          }
        } else {
          final tahun = widget.document[0].data['orderTime_start'].toString().substring(0, 4);
          final bulan = widget.document[0].data['orderTime_start'].toString().substring(5, 7);
          final hari = widget.document[0].data['orderTime_start'].toString().substring(8, 10);
          final jam = widget.document[0].data['orderTime_start'].toString().substring(11, 13);
          final menit = widget.document[0].data['orderTime_start'].toString().substring(14, 16);
          final birthday = DateTime(int.parse(tahun), int.parse(bulan), int.parse(hari), int.parse(jam), int.parse(menit));
          final selisih = DateTime.now().difference(birthday).inMinutes;
          if (selisih >= 60) {
            tampil = '1:' + (selisih - 60).toString() + ':00';
          } else {
            tampil = selisih.toString() + ':00';
          }
        }

        return Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Flexible(
                  child: Container(
                    width: 100.0,
                    child: Text(
                      '${widget.document[0].data['order'][index]}',
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        color: Colors.black38),
                    ),
                  ),
                ),
                Flexible(
                  child: Container(
                    width: 100.0,
                    child: Column(
                      children: <Widget>[
                        Text(
                          'Std 10:30',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.black38,
                            fontSize: 12.0),
                        ),
                        Text(
                          widget.document[0].data['actTime'][index] == null
                            ? 'Act -'
                            : 'Act ${tampil.toString()}',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.black38,
                            fontSize: 12.0),
                        ),
                      ],
                    ),
                  ),
                ),
                widget.document[0].data['actTime'][index] == null
                  ? Flexible(
                      child: ButtonTheme(
                        minWidth: 100.0,
                        height: 40.0,
                        child: RaisedButton(
                          shape: new RoundedRectangleBorder(borderRadius:new BorderRadius.circular(5.0)),
                          child: Text(
                            'DONE',
                            style: TextStyle(
                              fontSize: 13.0,
                              color: Colors.white
                            ),
                          ),
                          color: Colors.grey,
                          onPressed: () {
                            DateTime done = DateTime.now();

                            widget.array.removeAt(index);
                            widget.array.insert(index, done);
                            print(widget.array);

                            var initialDataNoTimestamp = <String, dynamic>{
                              'actTime': widget.array,
                            };
                            Firestore.instance.runTransaction((Transaction transaction) async {
                              DocumentSnapshot snapshot = await transaction.get(widget.document[0].reference);
                              await transaction.update(snapshot.reference, initialDataNoTimestamp);
                            });
                          }
                        ),
                      )
                    )
                  : Flexible(
                      child: ButtonTheme(
                        minWidth: 100.0,
                        height: 40.0,
                        child: RaisedButton(
                          shape: new RoundedRectangleBorder(borderRadius:new BorderRadius.circular(5.0)),
                          child: Icon(Icons.check, color: Colors.green),
                          disabledColor: Colors.white,
                          onPressed: null
                        ),
                      )
                    )
              ],
            ),
            SizedBox(
              height: 5.0,
            ),
          ],
        );
      }).toList(),
    );
  }
}

class FormEnjoy extends StatefulWidget {
  final String outlet;
  final int idOutlet;
  final String imageOutlet;
  final String alamatOutlet;
  final int idUser;
  final int idMysteryGuest;
  FormEnjoy(
      {this.outlet, this.imageOutlet, this.alamatOutlet, this.idOutlet, this.idUser, this.idMysteryGuest});

  @override
  _FormEnjoyState createState() => _FormEnjoyState();
}

class _FormEnjoyState extends State<FormEnjoy> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AbubaAppBar(),
        body: _buildMenu(),
      ),
    );
  }

  Widget _buildMenu() {
    return Scrollbar(
      child: ListView(
        children: <Widget>[
          Container(
            height: 401.5,
            width: MediaQuery.of(context).size.width,
            color: Colors.white,
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        'Mystery Shopper',
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
                          'Location',
                          style: TextStyle(
                              color: AbubaPallate.greenabuba, fontSize: 12.0),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(20.0, 100.0, 20.0, 20.0),
                  child: Column(
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Flexible(
                            child: Text(
                              'Enjoy Your Steak !',
                              style: TextStyle(
                                  color: AbubaPallate.greenabuba,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 20.0),
                            ),
                          )
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Flexible(
                            child: Text(
                              'Relax… Nikmati makanan dan minuman yang disediakan sebeum Anda memulai review',
                              style: TextStyle(
                                  fontSize: 14.0, color: Colors.black54),
                              textAlign: TextAlign.center,
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 30.0,
                      ),
                      ButtonTheme(
                        minWidth: 50.0,
                        height: 40.0,
                        child: RaisedButton(
                          shape: new RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(5.0)),
                          child: Text(
                            'CONFIRM',
                            style:
                            TextStyle(fontSize: 13.0, color: Colors.white),
                          ),
                          color: Colors.blueAccent,
                          onPressed: () {
                            Navigator.push(context,
                              MyCustomRoute(
                                builder: (context) => FormBersiap(idOutlet: widget.idOutlet,alamatOutlet: widget.alamatOutlet,outlet: widget.outlet,imageOutlet: widget.imageOutlet,idUser: widget.idUser, idMysteryGuest: widget.idMysteryGuest)
                              )
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
          Container(
            child: Image.asset(
              'assets/images/slide 7.png',
              fit: BoxFit.fitWidth,
            ),
          )
        ],
      ),
    );
  }
}

class FormBersiap extends StatefulWidget {
  final String outlet;
  final int idOutlet;
  final String imageOutlet;
  final String alamatOutlet;
  final int idUser;
  final int idMysteryGuest;
  FormBersiap(
      {this.outlet, this.imageOutlet, this.alamatOutlet, this.idOutlet, this.idUser, this.idMysteryGuest});

  @override
  _FormBersiapState createState() => _FormBersiapState();
}

class _FormBersiapState extends State<FormBersiap> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AbubaAppBar(),
        body: _buildMenu(),
      ),
    );
  }

  Widget _buildMenu() {
    return Scrollbar(
      child: ListView(
        children: <Widget>[
          Container(
            height: 409.5,
            width: MediaQuery.of(context).size.width,
            color: Colors.white,
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        'Mystery Shopper',
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
                          'Location',
                          style: TextStyle(
                              color: AbubaPallate.greenabuba, fontSize: 12.0),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(20.0, 100.0, 20.0, 20.0),
                  child: Column(
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Flexible(
                            child: Text(
                              'Bersiaplah untuk Mereview',
                              style: TextStyle(
                                  color: AbubaPallate.greenabuba,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 20.0),
                            ),
                          )
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Flexible(
                            child: Text(
                              'Lakukan review sampai dengan tahapan delivering dessert',
                              style: TextStyle(
                                  fontSize: 14.0, color: Colors.black54),
                              textAlign: TextAlign.center,
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 30.0,
                      ),
                      ButtonTheme(
                        minWidth: 50.0,
                        height: 40.0,
                        child: RaisedButton(
                          shape: new RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(5.0)),
                          child: Text(
                            'CONFIRM',
                            style:
                            TextStyle(fontSize: 13.0, color: Colors.white),
                          ),
                          color: Colors.blueAccent,
                          onPressed: () {
                            Navigator.push(context,
                              MyCustomRoute(
                                builder: (context) => FormReview(idOutlet: widget.idOutlet,alamatOutlet: widget.alamatOutlet,outlet: widget.outlet,imageOutlet: widget.imageOutlet,idUser: widget.idUser, idMysteryGuest: widget.idMysteryGuest)
                              )
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
          Container(
            child: Image.asset(
              'assets/images/slide 8.png',
              fit: BoxFit.fitWidth,
            ),
          )
        ],
      ),
    );
  }
}

class FormReview extends StatefulWidget {
  final String outlet;
  final int idOutlet;
  final String imageOutlet;
  final String alamatOutlet;
  final int idUser;
  final int idMysteryGuest;
  FormReview(
      {this.outlet, this.imageOutlet, this.alamatOutlet, this.idOutlet, this.idUser, this.idMysteryGuest});

  @override
  _FormReviewState createState() => _FormReviewState();
}

class _FormReviewState extends State<FormReview> with TickerProviderStateMixin {
  List<Map> _pertanyaan = [
    {
      'pertanyaan':
      '1. Membukakan pintu dengan senyuman dan eye contact yang ikhlas',
      'score': '1'
    },
    {'pertanyaan': '2. Membukakan pintu dengan sopan santu', 'score': '1'},
    {'pertanyaan': '3. Memberikan salam dengan ramah', 'score': '1'},
  ];

  int _currentIndex = 0;

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
    {'nomor': '10'},
    {'nomor': '11'},
    {'nomor': '12'},
    {'nomor': '13'},
  ];

  List<String> textList = [
    'Menu Baru',
    'Event',
    'Upselling',
    'Hasil Audit',
    'Pengumuman',
  ];

  List<String> isiCheckbox = [
    'Apakah organisasi sudah menetapkan internal dan eksternal isu yang berpengaruh terhadap kelangsungan organisasi?',
    '',
    '',
  ];
  List<String> valueCheckbox = ['1', '2', '3'];
  List<String> selectedValue = [];
  List<String> selectedAlasan = [];

  bool _value1 = false;
  bool _value2 = false;
  bool _value3 = false;
  bool _value4 = false;
  bool _value5 = false;

  //we omitted the brackets '{}' and are using fat arrow '=>' instead, this is dart syntax
  void _value1Changed(bool value) => setState(() => _value1 = value);
  void _value2Changed(bool value) => setState(() => _value2 = value);
  void _value3Changed(bool value) => setState(() => _value3 = value);
  void _value4Changed(bool value) => setState(() => _value4 = value);
  void _value5Changed(bool value) => setState(() => _value5 = value);

  TabController _cardController;
  TextEditingController _controllerNote = new TextEditingController();

  @override
  void initState() {
    super.initState();
    _cardController = new TabController(vsync: this, length: _listData.length);
  }

  @override
  void dispose() {
    _cardController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: _appBar(),
        body: GestureDetector(
          onTap: () {
            FocusScope.of(context).requestFocus(FocusNode());
          },
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  child: TabBarView(
                    controller: _cardController,
                    physics: ScrollPhysics(),
                    children: <Widget>[
                      ListView(
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
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 10.0),
                                      child: Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Text(
                                            '1. Parking',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 14.0),
                                            textAlign: TextAlign.start,
                                          ),
                                          Text(
                                            '1 of ${_listData.length.toString()}',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 14.0),
                                            textAlign: TextAlign.start,
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
                          Stack(
                            children: <Widget>[
                              Image.asset(
                                'assets/images/abuba6.jpg',
                                fit: BoxFit.cover,
                                height: MediaQuery.of(context).size.height /
                                    1.55777,
                              ),
                              Positioned(
                                bottom: 20.0,
                                width: MediaQuery.of(context).size.width,
                                child: Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceEvenly,
                                  children: <Widget>[
                                    Tooltip(
                                      message: 'Banyak sampah kecil berserakan',
                                      preferBelow: false,
                                      child: Container(
                                        child: ButtonTheme(
                                          minWidth: 50.0,
                                          height: 50.0,
                                          child: RaisedButton(
                                            shape: new RoundedRectangleBorder(
                                              borderRadius: new BorderRadius.circular(5.0),
                                              side: BorderSide(width: 1.5, color: Colors.white)),
                                            child: Text(
                                              '0',
                                              style: TextStyle(
                                                fontSize: 18.0,
                                                color: Colors.white),
                                              textAlign: TextAlign.center,
                                            ),
                                            color: Color.fromARGB(170, 255, 40, 0),
                                            onPressed: () {},
                                          ),
                                        ),
                                        alignment: Alignment(0.0, 0.0),
                                      ),
                                    ),
                                    Container(
                                      padding:
                                      EdgeInsets.symmetric(horizontal: 5.0),
                                      child: ButtonTheme(
                                        minWidth: 50.0,
                                        height: 50.0,
                                        child: RaisedButton(
                                          shape: new RoundedRectangleBorder(
                                              borderRadius:
                                              new BorderRadius.circular(
                                                  5.0),
                                              side: BorderSide(
                                                  width: 1.5,
                                                  color: Colors.white)),
                                          child: Text(
                                            '1',
                                            style: TextStyle(
                                                fontSize: 18.0,
                                                color: Colors.white),
                                            textAlign: TextAlign.center,
                                          ),
                                          color: Color.fromARGB(
                                              170, 192, 192, 192),
                                          onPressed: () {},
                                        ),
                                      ),
                                      alignment: Alignment(0.0, 0.0),
                                    ),
                                    Container(
                                      child: ButtonTheme(
                                        minWidth: 50.0,
                                        height: 50.0,
                                        child: RaisedButton(
                                          shape: new RoundedRectangleBorder(
                                              borderRadius:
                                              new BorderRadius.circular(
                                                  5.0),
                                              side: BorderSide(
                                                  width: 1.5,
                                                  color: Colors.white)),
                                          child: Text(
                                            '2',
                                            style: TextStyle(
                                                fontSize: 18.0,
                                                color: Colors.white),
                                            textAlign: TextAlign.center,
                                          ),
                                          color:
                                          Color.fromARGB(170, 50, 205, 50),
                                          onPressed: () {
                                            setState(() {
                                              if (_currentIndex + 1 <
                                                  _pertanyaan.length) {
                                                _pertanyaan[_currentIndex]
                                                ['score'] = '2';
                                                _currentIndex++;
                                              } else {
                                                _cardController.animateTo(
                                                    _cardController.index + 1);
                                              }
                                            });
                                          },
                                        ),
                                      ),
                                      alignment: Alignment(0.0, 0.0),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                          Container(
                            color: Colors.white,
                            padding: EdgeInsets.symmetric(
                                horizontal: 25.0, vertical: 10.0),
                            child: Row(
                              children: <Widget>[
                                Flexible(
                                  child: Text(
                                    _pertanyaan[_currentIndex]['pertanyaan'],
                                    style: TextStyle(
                                        fontSize: 14.0, color: Colors.black87),
                                  ),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                      ListView(
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
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 10.0),
                                      child: Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Text(
                                            '2. Toilet',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 14.0),
                                            textAlign: TextAlign.start,
                                          ),
                                          Text(
                                            '2 of ${_listData.length.toString()}',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 14.0),
                                            textAlign: TextAlign.start,
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
                          Stack(
                            children: <Widget>[
                              Image.asset(
                                'assets/images/abuba5.jpg',
                                fit: BoxFit.cover,
                                height: MediaQuery.of(context).size.height /
                                    1.55777,
                              ),
                              Positioned(
                                bottom: 20.0,
                                width: MediaQuery.of(context).size.width,
                                child: Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceEvenly,
                                  children: <Widget>[
                                    Container(
                                      child: ButtonTheme(
                                        minWidth: 50.0,
                                        height: 50.0,
                                        child: RaisedButton(
                                          shape: new RoundedRectangleBorder(
                                              borderRadius:
                                              new BorderRadius.circular(
                                                  5.0),
                                              side: BorderSide(
                                                  width: 1.5,
                                                  color: Colors.white)),
                                          child: Text(
                                            '0',
                                            style: TextStyle(
                                                fontSize: 18.0,
                                                color: Colors.white),
                                            textAlign: TextAlign.center,
                                          ),
                                          color:
                                          Color.fromARGB(170, 255, 40, 0),
                                          onPressed: () {
                                            showDialog(
                                              barrierDismissible: false,
                                              context: context,
                                              builder: (context) {
                                                return Checkbox(
                                                  alasan: isiCheckbox,
                                                  valueCheck: valueCheckbox,
                                                  selectedAlasan:
                                                  selectedAlasan,
                                                  selectedValue: selectedValue,
                                                  onSelectedAlasanListChanged:
                                                      (alasans) {
                                                    selectedAlasan = alasans;
                                                  },
                                                  onResult: (finalResult) {
                                                    setState(() {
                                                      if (_currentIndex + 1 <
                                                          _pertanyaan.length) {
                                                        _pertanyaan[
                                                        _currentIndex]
                                                        ['score'] = '0';
                                                        _currentIndex++;
                                                      } else {
                                                        _cardController
                                                            .animateTo(
                                                            _cardController
                                                                .index +
                                                                1);
                                                      }
                                                    });
                                                  },
                                                );
                                              },
                                            );
                                          },
                                        ),
                                      ),
                                      alignment: Alignment(0.0, 0.0),
                                    ),
                                    Container(
                                      padding:
                                      EdgeInsets.symmetric(horizontal: 5.0),
                                      child: ButtonTheme(
                                        minWidth: 50.0,
                                        height: 50.0,
                                        child: RaisedButton(
                                          shape: new RoundedRectangleBorder(
                                              borderRadius:
                                              new BorderRadius.circular(
                                                  5.0),
                                              side: BorderSide(
                                                  width: 1.5,
                                                  color: Colors.white)),
                                          child: Text(
                                            '1',
                                            style: TextStyle(
                                                fontSize: 18.0,
                                                color: Colors.white),
                                            textAlign: TextAlign.center,
                                          ),
                                          color: Color.fromARGB(
                                              170, 192, 192, 192),
                                          onPressed: () {
                                            showDialog(
                                              barrierDismissible: false,
                                              context: context,
                                              builder: (context) {
                                                return Checkbox(
                                                  alasan: isiCheckbox,
                                                  valueCheck: valueCheckbox,
                                                  selectedAlasan:
                                                  selectedAlasan,
                                                  selectedValue: selectedValue,
                                                  onSelectedAlasanListChanged:
                                                      (alasans) {
                                                    selectedAlasan = alasans;
                                                  },
                                                  onResult: (finalResult) {
                                                    setState(
                                                          () {
                                                        if (_currentIndex + 1 <
                                                            _pertanyaan
                                                                .length) {
                                                          _pertanyaan[
                                                          _currentIndex]
                                                          ['score'] = '1';
                                                          _currentIndex++;
                                                        } else {
                                                          _cardController
                                                              .animateTo(
                                                              _cardController
                                                                  .index +
                                                                  1);
                                                        }
                                                      },
                                                    );
                                                  },
                                                );
                                              },
                                            );
                                          },
                                        ),
                                      ),
                                      alignment: Alignment(0.0, 0.0),
                                    ),
                                    Container(
                                      child: ButtonTheme(
                                        minWidth: 50.0,
                                        height: 50.0,
                                        child: RaisedButton(
                                          shape: new RoundedRectangleBorder(
                                              borderRadius:
                                              new BorderRadius.circular(
                                                  5.0),
                                              side: BorderSide(
                                                  width: 1.5,
                                                  color: Colors.white)),
                                          child: Text(
                                            '2',
                                            style: TextStyle(
                                                fontSize: 18.0,
                                                color: Colors.white),
                                            textAlign: TextAlign.center,
                                          ),
                                          color:
                                          Color.fromARGB(170, 50, 205, 50),
                                          onPressed: () {
                                            setState(() {
                                              if (_currentIndex + 1 <
                                                  _pertanyaan.length) {
                                                _pertanyaan[_currentIndex]
                                                ['score'] = '2';
                                                _currentIndex++;
                                              } else {
                                                _cardController.animateTo(
                                                    _cardController.index + 1);
                                              }
                                            });
                                          },
                                        ),
                                      ),
                                      alignment: Alignment(0.0, 0.0),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                          Container(
                            color: Colors.white,
                            padding: EdgeInsets.symmetric(
                                horizontal: 25.0, vertical: 10.0),
                            child: Row(
                              children: <Widget>[
                                Flexible(
                                  child: Text(
                                    _pertanyaan[_currentIndex]['pertanyaan'],
                                    style: TextStyle(
                                        fontSize: 14.0, color: Colors.black87),
                                  ),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                      ListView(
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
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 10.0),
                                      child: Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Text(
                                            '3. Washtafel',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 14.0),
                                            textAlign: TextAlign.start,
                                          ),
                                          Text(
                                            '3 of ${_listData.length.toString()}',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 14.0),
                                            textAlign: TextAlign.start,
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
                          Stack(
                            children: <Widget>[
                              Image.asset(
                                'assets/images/abuba4.jpg',
                                fit: BoxFit.cover,
                                height: MediaQuery.of(context).size.height /
                                    1.55777,
                              ),
                              Positioned(
                                bottom: 20.0,
                                width: MediaQuery.of(context).size.width,
                                child: Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceEvenly,
                                  children: <Widget>[
                                    Container(
                                      child: ButtonTheme(
                                        minWidth: 50.0,
                                        height: 50.0,
                                        child: RaisedButton(
                                          shape: new RoundedRectangleBorder(
                                              borderRadius:
                                              new BorderRadius.circular(
                                                  5.0),
                                              side: BorderSide(
                                                  width: 1.5,
                                                  color: Colors.white)),
                                          child: Text(
                                            '0',
                                            style: TextStyle(
                                                fontSize: 18.0,
                                                color: Colors.white),
                                            textAlign: TextAlign.center,
                                          ),
                                          color:
                                          Color.fromARGB(170, 255, 40, 0),
                                          onPressed: () {
                                            showDialog(
                                              barrierDismissible: false,
                                              context: context,
                                              builder: (context) {
                                                return Checkbox(
                                                  alasan: isiCheckbox,
                                                  valueCheck: valueCheckbox,
                                                  selectedAlasan:
                                                  selectedAlasan,
                                                  selectedValue: selectedValue,
                                                  onSelectedAlasanListChanged:
                                                      (alasans) {
                                                    selectedAlasan = alasans;
                                                  },
                                                  onResult: (finalResult) {
                                                    setState(() {
                                                      if (_currentIndex + 1 <
                                                          _pertanyaan.length) {
                                                        _pertanyaan[
                                                        _currentIndex]
                                                        ['score'] = '0';
                                                        _currentIndex++;
                                                      } else {
                                                        _cardController
                                                            .animateTo(
                                                            _cardController
                                                                .index +
                                                                1);
                                                      }
                                                    });
                                                  },
                                                );
                                              },
                                            );
                                          },
                                        ),
                                      ),
                                      alignment: Alignment(0.0, 0.0),
                                    ),
                                    Container(
                                      padding:
                                      EdgeInsets.symmetric(horizontal: 5.0),
                                      child: ButtonTheme(
                                        minWidth: 50.0,
                                        height: 50.0,
                                        child: RaisedButton(
                                          shape: new RoundedRectangleBorder(
                                              borderRadius:
                                              new BorderRadius.circular(
                                                  5.0),
                                              side: BorderSide(
                                                  width: 1.5,
                                                  color: Colors.white)),
                                          child: Text(
                                            '1',
                                            style: TextStyle(
                                                fontSize: 18.0,
                                                color: Colors.white),
                                            textAlign: TextAlign.center,
                                          ),
                                          color: Color.fromARGB(
                                              170, 192, 192, 192),
                                          onPressed: () {
                                            showDialog(
                                              barrierDismissible: false,
                                              context: context,
                                              builder: (context) {
                                                return Checkbox(
                                                  alasan: isiCheckbox,
                                                  valueCheck: valueCheckbox,
                                                  selectedAlasan:
                                                  selectedAlasan,
                                                  selectedValue: selectedValue,
                                                  onSelectedAlasanListChanged:
                                                      (alasans) {
                                                    selectedAlasan = alasans;
                                                  },
                                                  onResult: (finalResult) {
                                                    setState(
                                                          () {
                                                        if (_currentIndex + 1 <
                                                            _pertanyaan
                                                                .length) {
                                                          _pertanyaan[
                                                          _currentIndex]
                                                          ['score'] = '1';
                                                          _currentIndex++;
                                                        } else {
                                                          _cardController
                                                              .animateTo(
                                                              _cardController
                                                                  .index +
                                                                  1);
                                                        }
                                                      },
                                                    );
                                                  },
                                                );
                                              },
                                            );
                                          },
                                        ),
                                      ),
                                      alignment: Alignment(0.0, 0.0),
                                    ),
                                    Container(
                                      child: ButtonTheme(
                                        minWidth: 50.0,
                                        height: 50.0,
                                        child: RaisedButton(
                                          shape: new RoundedRectangleBorder(
                                              borderRadius:
                                              new BorderRadius.circular(
                                                  5.0),
                                              side: BorderSide(
                                                  width: 1.5,
                                                  color: Colors.white)),
                                          child: Text(
                                            '2',
                                            style: TextStyle(
                                                fontSize: 18.0,
                                                color: Colors.white),
                                            textAlign: TextAlign.center,
                                          ),
                                          color:
                                          Color.fromARGB(170, 50, 205, 50),
                                          onPressed: () {
                                            setState(() {
                                              if (_currentIndex + 1 <
                                                  _pertanyaan.length) {
                                                _pertanyaan[_currentIndex]
                                                ['score'] = '2';
                                                _currentIndex++;
                                              } else {
                                                _cardController.animateTo(
                                                    _cardController.index + 1);
                                              }
                                            });
                                          },
                                        ),
                                      ),
                                      alignment: Alignment(0.0, 0.0),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                          Container(
                            color: Colors.white,
                            padding: EdgeInsets.symmetric(
                                horizontal: 25.0, vertical: 10.0),
                            child: Row(
                              children: <Widget>[
                                Flexible(
                                  child: Text(
                                    _pertanyaan[_currentIndex]['pertanyaan'],
                                    style: TextStyle(
                                        fontSize: 14.0, color: Colors.black87),
                                  ),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                      ListView(
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
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 10.0),
                                      child: Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Text(
                                            '4. Greeting',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 14.0),
                                            textAlign: TextAlign.start,
                                          ),
                                          Text(
                                            '4 of ${_listData.length.toString()}',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 14.0),
                                            textAlign: TextAlign.start,
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
                          Stack(
                            children: <Widget>[
                              Image.asset(
                                'assets/images/slide greet.jpg',
                                fit: BoxFit.cover,
                                height: MediaQuery.of(context).size.height /
                                    1.55777,
                              ),
                              Positioned(
                                bottom: 20.0,
                                width: MediaQuery.of(context).size.width,
                                child: Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceEvenly,
                                  children: <Widget>[
                                    Container(
                                      child: ButtonTheme(
                                        minWidth: 50.0,
                                        height: 50.0,
                                        child: RaisedButton(
                                          shape: new RoundedRectangleBorder(
                                              borderRadius:
                                              new BorderRadius.circular(
                                                  5.0),
                                              side: BorderSide(
                                                  width: 1.5,
                                                  color: Colors.white)),
                                          child: Text(
                                            '0',
                                            style: TextStyle(
                                                fontSize: 18.0,
                                                color: Colors.white),
                                            textAlign: TextAlign.center,
                                          ),
                                          color:
                                          Color.fromARGB(170, 255, 40, 0),
                                          onPressed: () {
                                            showDialog(
                                              barrierDismissible: false,
                                              context: context,
                                              builder: (context) {
                                                return Checkbox(
                                                  alasan: isiCheckbox,
                                                  valueCheck: valueCheckbox,
                                                  selectedAlasan:
                                                  selectedAlasan,
                                                  selectedValue: selectedValue,
                                                  onSelectedAlasanListChanged:
                                                      (alasans) {
                                                    selectedAlasan = alasans;
                                                  },
                                                  onResult: (finalResult) {
                                                    setState(() {
                                                      if (_currentIndex + 1 <
                                                          _pertanyaan.length) {
                                                        _pertanyaan[
                                                        _currentIndex]
                                                        ['score'] = '0';
                                                        _currentIndex++;
                                                      } else {
                                                        _cardController
                                                            .animateTo(
                                                            _cardController
                                                                .index +
                                                                1);
                                                      }
                                                    });
                                                  },
                                                );
                                              },
                                            );
                                          },
                                        ),
                                      ),
                                      alignment: Alignment(0.0, 0.0),
                                    ),
                                    Container(
                                      padding:
                                      EdgeInsets.symmetric(horizontal: 5.0),
                                      child: ButtonTheme(
                                        minWidth: 50.0,
                                        height: 50.0,
                                        child: RaisedButton(
                                          shape: new RoundedRectangleBorder(
                                              borderRadius:
                                              new BorderRadius.circular(
                                                  5.0),
                                              side: BorderSide(
                                                  width: 1.5,
                                                  color: Colors.white)),
                                          child: Text(
                                            '1',
                                            style: TextStyle(
                                                fontSize: 18.0,
                                                color: Colors.white),
                                            textAlign: TextAlign.center,
                                          ),
                                          color: Color.fromARGB(
                                              170, 192, 192, 192),
                                          onPressed: () {
                                            showDialog(
                                              barrierDismissible: false,
                                              context: context,
                                              builder: (context) {
                                                return Checkbox(
                                                  alasan: isiCheckbox,
                                                  valueCheck: valueCheckbox,
                                                  selectedAlasan:
                                                  selectedAlasan,
                                                  selectedValue: selectedValue,
                                                  onSelectedAlasanListChanged:
                                                      (alasans) {
                                                    selectedAlasan = alasans;
                                                  },
                                                  onResult: (finalResult) {
                                                    setState(
                                                          () {
                                                        if (_currentIndex + 1 <
                                                            _pertanyaan
                                                                .length) {
                                                          _pertanyaan[
                                                          _currentIndex]
                                                          ['score'] = '1';
                                                          _currentIndex++;
                                                        } else {
                                                          _cardController
                                                              .animateTo(
                                                              _cardController
                                                                  .index +
                                                                  1);
                                                        }
                                                      },
                                                    );
                                                  },
                                                );
                                              },
                                            );
                                          },
                                        ),
                                      ),
                                      alignment: Alignment(0.0, 0.0),
                                    ),
                                    Container(
                                      child: ButtonTheme(
                                        minWidth: 50.0,
                                        height: 50.0,
                                        child: RaisedButton(
                                          shape: new RoundedRectangleBorder(
                                              borderRadius:
                                              new BorderRadius.circular(
                                                  5.0),
                                              side: BorderSide(
                                                  width: 1.5,
                                                  color: Colors.white)),
                                          child: Text(
                                            '2',
                                            style: TextStyle(
                                                fontSize: 18.0,
                                                color: Colors.white),
                                            textAlign: TextAlign.center,
                                          ),
                                          color:
                                          Color.fromARGB(170, 50, 205, 50),
                                          onPressed: () {
                                            setState(() {
                                              if (_currentIndex + 1 <
                                                  _pertanyaan.length) {
                                                _pertanyaan[_currentIndex]
                                                ['score'] = '2';
                                                _currentIndex++;
                                              } else {
                                                _cardController.animateTo(
                                                    _cardController.index + 1);
                                              }
                                            });
                                          },
                                        ),
                                      ),
                                      alignment: Alignment(0.0, 0.0),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                          Container(
                            color: Colors.white,
                            padding: EdgeInsets.symmetric(
                                horizontal: 25.0, vertical: 10.0),
                            child: Row(
                              children: <Widget>[
                                Flexible(
                                  child: Text(
                                    _pertanyaan[_currentIndex]['pertanyaan'],
                                    style: TextStyle(
                                        fontSize: 14.0, color: Colors.black87),
                                  ),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                      ListView(
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
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 10.0),
                                        child: Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            Text(
                                              '5. Seating',
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 14.0),
                                              textAlign: TextAlign.start,
                                            ),
                                            Text(
                                              '5 of ${_listData.length.toString()}',
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 14.0),
                                              textAlign: TextAlign.start,
                                            ),
                                          ],
                                        ),
                                      ),
                                      decoration: BoxDecoration(
                                          color: Color(0xFF2F592F))),
                                ),
                              ],
                            ),
                          ),
                          Stack(
                            children: <Widget>[
                              Image.asset(
                                'assets/images/slide 11.png',
                                fit: BoxFit.cover,
                                height: MediaQuery.of(context).size.height /
                                    1.55777,
                              ),
                              Positioned(
                                bottom: 20.0,
                                width: MediaQuery.of(context).size.width,
                                child: Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceEvenly,
                                  children: <Widget>[
                                    Container(
                                      child: ButtonTheme(
                                        minWidth: 50.0,
                                        height: 50.0,
                                        child: RaisedButton(
                                          shape: new RoundedRectangleBorder(
                                              borderRadius:
                                              new BorderRadius.circular(
                                                  5.0),
                                              side: BorderSide(
                                                  width: 1.5,
                                                  color: Colors.white)),
                                          child: Text(
                                            '0',
                                            style: TextStyle(
                                                fontSize: 18.0,
                                                color: Colors.white),
                                            textAlign: TextAlign.center,
                                          ),
                                          color:
                                          Color.fromARGB(170, 255, 40, 0),
                                          onPressed: () {
                                            showDialog(
                                              barrierDismissible: false,
                                              context: context,
                                              builder: (context) {
                                                return Checkbox(
                                                  alasan: isiCheckbox,
                                                  valueCheck: valueCheckbox,
                                                  selectedAlasan:
                                                  selectedAlasan,
                                                  selectedValue: selectedValue,
                                                  onSelectedAlasanListChanged:
                                                      (alasans) {
                                                    selectedAlasan = alasans;
                                                  },
                                                  onResult: (finalResult) {
                                                    _cardController.animateTo(
                                                        _cardController.index +
                                                            1);
                                                  },
                                                );
                                              },
                                            );
                                          },
                                        ),
                                      ),
                                      alignment: Alignment(0.0, 0.0),
                                    ),
                                    Container(
                                      padding:
                                      EdgeInsets.symmetric(horizontal: 5.0),
                                      child: ButtonTheme(
                                        minWidth: 50.0,
                                        height: 50.0,
                                        child: RaisedButton(
                                          shape: new RoundedRectangleBorder(
                                              borderRadius:
                                              new BorderRadius.circular(
                                                  5.0),
                                              side: BorderSide(
                                                  width: 1.5,
                                                  color: Colors.white)),
                                          child: Text(
                                            '1',
                                            style: TextStyle(
                                                fontSize: 18.0,
                                                color: Colors.white),
                                            textAlign: TextAlign.center,
                                          ),
                                          color: Color.fromARGB(
                                              170, 192, 192, 192),
                                          onPressed: () {
                                            showDialog(
                                              barrierDismissible: false,
                                              context: context,
                                              builder: (context) {
                                                return Checkbox(
                                                  alasan: isiCheckbox,
                                                  valueCheck: valueCheckbox,
                                                  selectedAlasan:
                                                  selectedAlasan,
                                                  selectedValue: selectedValue,
                                                  onSelectedAlasanListChanged:
                                                      (alasans) {
                                                    selectedAlasan = alasans;
                                                  },
                                                  onResult: (finalResult) {
                                                    _cardController.animateTo(
                                                        _cardController.index +
                                                            1);
                                                  },
                                                );
                                              },
                                            );
                                          },
                                        ),
                                      ),
                                      alignment: Alignment(0.0, 0.0),
                                    ),
                                    Container(
                                      child: ButtonTheme(
                                        minWidth: 50.0,
                                        height: 50.0,
                                        child: RaisedButton(
                                          shape: new RoundedRectangleBorder(
                                              borderRadius:
                                              new BorderRadius.circular(
                                                  5.0),
                                              side: BorderSide(
                                                  width: 1.5,
                                                  color: Colors.white)),
                                          child: Text(
                                            '2',
                                            style: TextStyle(
                                                fontSize: 18.0,
                                                color: Colors.white),
                                            textAlign: TextAlign.center,
                                          ),
                                          color:
                                          Color.fromARGB(170, 50, 205, 50),
                                          onPressed: () {
                                            _cardController.animateTo(
                                                _cardController.index + 1);
                                          },
                                        ),
                                      ),
                                      alignment: Alignment(0.0, 0.0),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                          Container(
                            color: Colors.white,
                            padding: EdgeInsets.symmetric(
                                horizontal: 20.0, vertical: 10.0),
                            child: Center(
                              child: Text(
                                  'Bantu menarikan kursi dengan mendahulukan tamu disabilitas, orang tua atau wanita, sebelum tamu duduk.'),
                            ),
                          )
                        ],
                      ),
                      ListView(
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
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 10.0),
                                        child: Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            Text(
                                              '6. Taking Order',
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 14.0),
                                              textAlign: TextAlign.start,
                                            ),
                                            Text(
                                              '6 of ${_listData.length.toString()}',
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 14.0),
                                              textAlign: TextAlign.start,
                                            ),
                                          ],
                                        ),
                                      ),
                                      decoration: BoxDecoration(
                                          color: Color(0xFF2F592F))),
                                ),
                              ],
                            ),
                          ),
                          Stack(
                            children: <Widget>[
                              Image.asset(
                                'assets/images/slide 12.png',
                                fit: BoxFit.fitHeight,
                                height: MediaQuery.of(context).size.height /
                                    1.55777,
                              ),
                              Positioned(
                                bottom: 20.0,
                                width: MediaQuery.of(context).size.width,
                                child: Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceAround,
                                  children: <Widget>[
                                    Container(
                                      child: ButtonTheme(
                                        minWidth: 50.0,
                                        height: 50.0,
                                        child: RaisedButton(
                                          shape: new RoundedRectangleBorder(
                                              borderRadius:
                                              new BorderRadius.circular(
                                                  5.0),
                                              side: BorderSide(
                                                  width: 1.5,
                                                  color: Colors.white)),
                                          child: Text(
                                            '0',
                                            style: TextStyle(
                                                fontSize: 18.0,
                                                color: Colors.white),
                                            textAlign: TextAlign.center,
                                          ),
                                          color:
                                          Color.fromARGB(170, 255, 40, 0),
                                          onPressed: () {
                                            showDialog(
                                              barrierDismissible: false,
                                              context: context,
                                              builder: (context) {
                                                return Checkbox(
                                                  alasan: isiCheckbox,
                                                  valueCheck: valueCheckbox,
                                                  selectedAlasan:
                                                  selectedAlasan,
                                                  selectedValue: selectedValue,
                                                  onSelectedAlasanListChanged:
                                                      (alasans) {
                                                    selectedAlasan = alasans;
                                                  },
                                                  onResult: (finalResult) {
                                                    _cardController.animateTo(
                                                        _cardController.index +
                                                            1);
                                                  },
                                                );
                                              },
                                            );
                                          },
                                        ),
                                      ),
                                      alignment: Alignment(0.0, 0.0),
                                    ),
                                    Container(
                                      padding:
                                      EdgeInsets.symmetric(horizontal: 5.0),
                                      child: ButtonTheme(
                                        minWidth: 50.0,
                                        height: 50.0,
                                        child: RaisedButton(
                                          shape: new RoundedRectangleBorder(
                                              borderRadius:
                                              new BorderRadius.circular(
                                                  5.0),
                                              side: BorderSide(
                                                  width: 1.5,
                                                  color: Colors.white)),
                                          child: Text(
                                            '1',
                                            style: TextStyle(
                                                fontSize: 18.0,
                                                color: Colors.white),
                                            textAlign: TextAlign.center,
                                          ),
                                          color: Color.fromARGB(
                                              170, 192, 192, 192),
                                          onPressed: () {
                                            showDialog(
                                              barrierDismissible: false,
                                              context: context,
                                              builder: (context) {
                                                return Checkbox(
                                                  alasan: isiCheckbox,
                                                  valueCheck: valueCheckbox,
                                                  selectedAlasan:
                                                  selectedAlasan,
                                                  selectedValue: selectedValue,
                                                  onSelectedAlasanListChanged:
                                                      (alasans) {
                                                    selectedAlasan = alasans;
                                                  },
                                                  onResult: (finalResult) {
                                                    _cardController.animateTo(
                                                        _cardController.index +
                                                            1);
                                                  },
                                                );
                                              },
                                            );
                                          },
                                        ),
                                      ),
                                      alignment: Alignment(0.0, 0.0),
                                    ),
                                    Container(
                                      child: ButtonTheme(
                                        minWidth: 50.0,
                                        height: 50.0,
                                        child: RaisedButton(
                                          shape: new RoundedRectangleBorder(
                                              borderRadius:
                                              new BorderRadius.circular(
                                                  5.0),
                                              side: BorderSide(
                                                  width: 1.5,
                                                  color: Colors.white)),
                                          child: Text(
                                            '2',
                                            style: TextStyle(
                                                fontSize: 18.0,
                                                color: Colors.white),
                                            textAlign: TextAlign.center,
                                          ),
                                          color:
                                          Color.fromARGB(170, 50, 205, 50),
                                          onPressed: () {
                                            _cardController.animateTo(
                                                _cardController.index + 1);
                                          },
                                        ),
                                      ),
                                      alignment: Alignment(0.0, 0.0),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                          Container(
                            color: Colors.white,
                            padding: EdgeInsets.symmetric(
                                horizontal: 20.0, vertical: 10.0),
                            child: Center(
                              child: Text(
                                  'Tawarkan menu berurutan dari appetizer, main course, dessert, hingga minuman'),
                            ),
                          )
                        ],
                      ),
                      ListView(
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
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 10.0),
                                        child: Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            Text(
                                              '7. Serving Drinks',
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 14.0),
                                              textAlign: TextAlign.start,
                                            ),
                                            Text(
                                              '7 of ${_listData.length.toString()}',
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 14.0),
                                              textAlign: TextAlign.start,
                                            ),
                                          ],
                                        ),
                                      ),
                                      decoration: BoxDecoration(
                                          color: Color(0xFF2F592F))),
                                ),
                              ],
                            ),
                          ),
                          Stack(
                            children: <Widget>[
                              Image.asset(
                                'assets/images/slide 13.png',
                                fit: BoxFit.cover,
                                height: MediaQuery.of(context).size.height /
                                    1.55777,
                              ),
                              Positioned(
                                bottom: 20.0,
                                width: MediaQuery.of(context).size.width,
                                child: Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceAround,
                                  children: <Widget>[
                                    Container(
                                      child: ButtonTheme(
                                        minWidth: 50.0,
                                        height: 50.0,
                                        child: RaisedButton(
                                          shape: new RoundedRectangleBorder(
                                              borderRadius:
                                              new BorderRadius.circular(
                                                  5.0),
                                              side: BorderSide(
                                                  width: 1.5,
                                                  color: Colors.white)),
                                          child: Text(
                                            '0',
                                            style: TextStyle(
                                                fontSize: 18.0,
                                                color: Colors.white),
                                            textAlign: TextAlign.center,
                                          ),
                                          color:
                                          Color.fromARGB(170, 255, 40, 0),
                                          onPressed: () {
                                            showDialog(
                                              barrierDismissible: false,
                                              context: context,
                                              builder: (context) {
                                                return Checkbox(
                                                  alasan: isiCheckbox,
                                                  valueCheck: valueCheckbox,
                                                  selectedAlasan:
                                                  selectedAlasan,
                                                  selectedValue: selectedValue,
                                                  onSelectedAlasanListChanged:
                                                      (alasans) {
                                                    selectedAlasan = alasans;
                                                  },
                                                  onResult: (finalResult) {
                                                    _cardController.animateTo(
                                                        _cardController.index +
                                                            1);
                                                  },
                                                );
                                              },
                                            );
                                          },
                                        ),
                                      ),
                                      alignment: Alignment(0.0, 0.0),
                                    ),
                                    Container(
                                      padding:
                                      EdgeInsets.symmetric(horizontal: 5.0),
                                      child: ButtonTheme(
                                        minWidth: 50.0,
                                        height: 50.0,
                                        child: RaisedButton(
                                          shape: new RoundedRectangleBorder(
                                              borderRadius:
                                              new BorderRadius.circular(
                                                  5.0),
                                              side: BorderSide(
                                                  width: 1.5,
                                                  color: Colors.white)),
                                          child: Text(
                                            '1',
                                            style: TextStyle(
                                                fontSize: 18.0,
                                                color: Colors.white),
                                            textAlign: TextAlign.center,
                                          ),
                                          color: Color.fromARGB(
                                              170, 192, 192, 192),
                                          onPressed: () {
                                            showDialog(
                                              barrierDismissible: false,
                                              context: context,
                                              builder: (context) {
                                                return Checkbox(
                                                  alasan: isiCheckbox,
                                                  valueCheck: valueCheckbox,
                                                  selectedAlasan:
                                                  selectedAlasan,
                                                  selectedValue: selectedValue,
                                                  onSelectedAlasanListChanged:
                                                      (alasans) {
                                                    selectedAlasan = alasans;
                                                  },
                                                  onResult: (finalResult) {
                                                    _cardController.animateTo(
                                                        _cardController.index +
                                                            1);
                                                  },
                                                );
                                              },
                                            );
                                          },
                                        ),
                                      ),
                                      alignment: Alignment(0.0, 0.0),
                                    ),
                                    Container(
                                      child: ButtonTheme(
                                        minWidth: 50.0,
                                        height: 50.0,
                                        child: RaisedButton(
                                          shape: new RoundedRectangleBorder(
                                              borderRadius:
                                              new BorderRadius.circular(
                                                  5.0),
                                              side: BorderSide(
                                                  width: 1.5,
                                                  color: Colors.white)),
                                          child: Text(
                                            '2',
                                            style: TextStyle(
                                                fontSize: 18.0,
                                                color: Colors.white),
                                            textAlign: TextAlign.center,
                                          ),
                                          color:
                                          Color.fromARGB(170, 50, 205, 50),
                                          onPressed: () {
                                            _cardController.animateTo(
                                                _cardController.index + 1);
                                          },
                                        ),
                                      ),
                                      alignment: Alignment(0.0, 0.0),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                          Container(
                            color: Colors.white,
                            padding: EdgeInsets.symmetric(
                                horizontal: 20.0, vertical: 10.0),
                            child: Center(
                              child: Text(
                                  'Berikan minuman dari sebelah kanan tamu, dengan menyebutkan nama minuman yang di sajikan'),
                            ),
                          )
                        ],
                      ),
                      ListView(
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
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 10.0),
                                        child: Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            Text(
                                              '8. Serving Starter',
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 14.0),
                                              textAlign: TextAlign.start,
                                            ),
                                            Text(
                                              '8 of ${_listData.length.toString()}',
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 14.0),
                                              textAlign: TextAlign.start,
                                            ),
                                          ],
                                        ),
                                      ),
                                      decoration: BoxDecoration(
                                          color: Color(0xFF2F592F))),
                                ),
                              ],
                            ),
                          ),
                          Stack(
                            children: <Widget>[
                              Image.asset(
                                'assets/images/slide 14.png',
                                fit: BoxFit.cover,
                                height: MediaQuery.of(context).size.height /
                                    1.55777,
                              ),
                              Positioned(
                                bottom: 20.0,
                                width: MediaQuery.of(context).size.width,
                                child: Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceAround,
                                  children: <Widget>[
                                    Container(
                                      child: ButtonTheme(
                                        minWidth: 50.0,
                                        height: 50.0,
                                        child: RaisedButton(
                                          shape: new RoundedRectangleBorder(
                                              borderRadius:
                                              new BorderRadius.circular(
                                                  5.0),
                                              side: BorderSide(
                                                  width: 1.5,
                                                  color: Colors.white)),
                                          child: Text(
                                            '0',
                                            style: TextStyle(
                                                fontSize: 18.0,
                                                color: Colors.white),
                                            textAlign: TextAlign.center,
                                          ),
                                          color:
                                          Color.fromARGB(170, 255, 40, 0),
                                          onPressed: () {
                                            showDialog(
                                              barrierDismissible: false,
                                              context: context,
                                              builder: (context) {
                                                return Checkbox(
                                                  alasan: isiCheckbox,
                                                  valueCheck: valueCheckbox,
                                                  selectedAlasan:
                                                  selectedAlasan,
                                                  selectedValue: selectedValue,
                                                  onSelectedAlasanListChanged:
                                                      (alasans) {
                                                    selectedAlasan = alasans;
                                                  },
                                                  onResult: (finalResult) {
                                                    _cardController.animateTo(
                                                        _cardController.index +
                                                            1);
                                                  },
                                                );
                                              },
                                            );
                                          },
                                        ),
                                      ),
                                      alignment: Alignment(0.0, 0.0),
                                    ),
                                    Container(
                                      padding:
                                      EdgeInsets.symmetric(horizontal: 5.0),
                                      child: ButtonTheme(
                                        minWidth: 50.0,
                                        height: 50.0,
                                        child: RaisedButton(
                                          shape: new RoundedRectangleBorder(
                                              borderRadius:
                                              new BorderRadius.circular(
                                                  5.0),
                                              side: BorderSide(
                                                  width: 1.5,
                                                  color: Colors.white)),
                                          child: Text(
                                            '1',
                                            style: TextStyle(
                                                fontSize: 18.0,
                                                color: Colors.white),
                                            textAlign: TextAlign.center,
                                          ),
                                          color: Color.fromARGB(
                                              170, 192, 192, 192),
                                          onPressed: () {
                                            showDialog(
                                              barrierDismissible: false,
                                              context: context,
                                              builder: (context) {
                                                return Checkbox(
                                                  alasan: isiCheckbox,
                                                  valueCheck: valueCheckbox,
                                                  selectedAlasan:
                                                  selectedAlasan,
                                                  selectedValue: selectedValue,
                                                  onSelectedAlasanListChanged:
                                                      (alasans) {
                                                    selectedAlasan = alasans;
                                                  },
                                                  onResult: (finalResult) {
                                                    _cardController.animateTo(
                                                        _cardController.index +
                                                            1);
                                                  },
                                                );
                                              },
                                            );
                                          },
                                        ),
                                      ),
                                      alignment: Alignment(0.0, 0.0),
                                    ),
                                    Container(
                                      child: ButtonTheme(
                                        minWidth: 50.0,
                                        height: 50.0,
                                        child: RaisedButton(
                                          shape: new RoundedRectangleBorder(
                                              borderRadius:
                                              new BorderRadius.circular(
                                                  5.0),
                                              side: BorderSide(
                                                  width: 1.5,
                                                  color: Colors.white)),
                                          child: Text(
                                            '2',
                                            style: TextStyle(
                                                fontSize: 18.0,
                                                color: Colors.white),
                                            textAlign: TextAlign.center,
                                          ),
                                          color:
                                          Color.fromARGB(170, 50, 205, 50),
                                          onPressed: () {
                                            _cardController.animateTo(
                                                _cardController.index + 1);
                                          },
                                        ),
                                      ),
                                      alignment: Alignment(0.0, 0.0),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                          Container(
                            color: Colors.white,
                            padding: EdgeInsets.symmetric(
                                horizontal: 20.0, vertical: 10.0),
                            child: Center(
                              child: Text(
                                  '1. Membukakan pintu dengan seyuman dan eye contact yang ikhlas'),
                            ),
                          )
                        ],
                      ),
                      ListView(
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
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 10.0),
                                        child: Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            Text(
                                              '9. Serving The Main Course',
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 14.0),
                                              textAlign: TextAlign.start,
                                            ),
                                            Text(
                                              '9 of ${_listData.length.toString()}',
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 14.0),
                                              textAlign: TextAlign.start,
                                            ),
                                          ],
                                        ),
                                      ),
                                      decoration: BoxDecoration(
                                          color: Color(0xFF2F592F))),
                                ),
                              ],
                            ),
                          ),
                          Stack(
                            children: <Widget>[
                              Image.asset(
                                'assets/images/slide 15.png',
                                fit: BoxFit.cover,
                                height: MediaQuery.of(context).size.height /
                                    1.55777,
                              ),
                              Positioned(
                                bottom: 20.0,
                                width: MediaQuery.of(context).size.width,
                                child: Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceAround,
                                  children: <Widget>[
                                    Container(
                                      child: ButtonTheme(
                                        minWidth: 50.0,
                                        height: 50.0,
                                        child: RaisedButton(
                                          shape: new RoundedRectangleBorder(
                                              borderRadius:
                                              new BorderRadius.circular(
                                                  5.0),
                                              side: BorderSide(
                                                  width: 1.5,
                                                  color: Colors.white)),
                                          child: Text(
                                            '0',
                                            style: TextStyle(
                                                fontSize: 18.0,
                                                color: Colors.white),
                                            textAlign: TextAlign.center,
                                          ),
                                          color:
                                          Color.fromARGB(170, 255, 40, 0),
                                          onPressed: () {
                                            showDialog(
                                              barrierDismissible: false,
                                              context: context,
                                              builder: (context) {
                                                return Checkbox(
                                                  alasan: isiCheckbox,
                                                  valueCheck: valueCheckbox,
                                                  selectedAlasan:
                                                  selectedAlasan,
                                                  selectedValue: selectedValue,
                                                  onSelectedAlasanListChanged:
                                                      (alasans) {
                                                    selectedAlasan = alasans;
                                                  },
                                                  onResult: (finalResult) {
                                                    _cardController.animateTo(
                                                        _cardController.index +
                                                            1);
                                                  },
                                                );
                                              },
                                            );
                                          },
                                        ),
                                      ),
                                      alignment: Alignment(0.0, 0.0),
                                    ),
                                    Container(
                                      padding:
                                      EdgeInsets.symmetric(horizontal: 5.0),
                                      child: ButtonTheme(
                                        minWidth: 50.0,
                                        height: 50.0,
                                        child: RaisedButton(
                                          shape: new RoundedRectangleBorder(
                                              borderRadius:
                                              new BorderRadius.circular(
                                                  5.0),
                                              side: BorderSide(
                                                  width: 1.5,
                                                  color: Colors.white)),
                                          child: Text(
                                            '1',
                                            style: TextStyle(
                                                fontSize: 18.0,
                                                color: Colors.white),
                                            textAlign: TextAlign.center,
                                          ),
                                          color: Color.fromARGB(
                                              170, 192, 192, 192),
                                          onPressed: () {
                                            showDialog(
                                              barrierDismissible: false,
                                              context: context,
                                              builder: (context) {
                                                return Checkbox(
                                                  alasan: isiCheckbox,
                                                  valueCheck: valueCheckbox,
                                                  selectedAlasan:
                                                  selectedAlasan,
                                                  selectedValue: selectedValue,
                                                  onSelectedAlasanListChanged:
                                                      (alasans) {
                                                    selectedAlasan = alasans;
                                                  },
                                                  onResult: (finalResult) {
                                                    _cardController.animateTo(
                                                        _cardController.index +
                                                            1);
                                                  },
                                                );
                                              },
                                            );
                                          },
                                        ),
                                      ),
                                      alignment: Alignment(0.0, 0.0),
                                    ),
                                    Container(
                                      child: ButtonTheme(
                                        minWidth: 50.0,
                                        height: 50.0,
                                        child: RaisedButton(
                                          shape: new RoundedRectangleBorder(
                                              borderRadius:
                                              new BorderRadius.circular(
                                                  5.0),
                                              side: BorderSide(
                                                  width: 1.5,
                                                  color: Colors.white)),
                                          child: Text(
                                            '2',
                                            style: TextStyle(
                                                fontSize: 18.0,
                                                color: Colors.white),
                                            textAlign: TextAlign.center,
                                          ),
                                          color:
                                          Color.fromARGB(170, 50, 205, 50),
                                          onPressed: () {
                                            _cardController.animateTo(
                                                _cardController.index + 1);
                                          },
                                        ),
                                      ),
                                      alignment: Alignment(0.0, 0.0),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                          Container(
                            color: Colors.white,
                            padding: EdgeInsets.symmetric(
                                horizontal: 20.0, vertical: 10.0),
                            child: Center(
                              child: Text(
                                  'Antarkan makanan ke meja customer menggunakan service tray'),
                            ),
                          )
                        ],
                      ),
                      ListView(
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
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 10.0),
                                        child: Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            Text(
                                              '10. Donenes',
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 14.0),
                                              textAlign: TextAlign.start,
                                            ),
                                            Text(
                                              '10 of ${_listData.length.toString()}',
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 14.0),
                                              textAlign: TextAlign.start,
                                            ),
                                          ],
                                        ),
                                      ),
                                      decoration: BoxDecoration(
                                          color: Color(0xFF2F592F))),
                                ),
                              ],
                            ),
                          ),
                          Stack(
                            children: <Widget>[
                              Image.asset(
                                'assets/images/slide 16.png',
                                fit: BoxFit.cover,
                                height: MediaQuery.of(context).size.height /
                                    1.55777,
                              ),
                              Positioned(
                                bottom: 20.0,
                                width: MediaQuery.of(context).size.width,
                                child: Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceAround,
                                  children: <Widget>[
                                    Container(
                                      child: ButtonTheme(
                                        minWidth: 50.0,
                                        height: 50.0,
                                        child: RaisedButton(
                                          shape: new RoundedRectangleBorder(
                                              borderRadius:
                                              new BorderRadius.circular(
                                                  5.0),
                                              side: BorderSide(
                                                  width: 1.5,
                                                  color: Colors.white)),
                                          child: Text(
                                            '0',
                                            style: TextStyle(
                                                fontSize: 18.0,
                                                color: Colors.white),
                                            textAlign: TextAlign.center,
                                          ),
                                          color:
                                          Color.fromARGB(170, 255, 40, 0),
                                          onPressed: () {
                                            showDialog(
                                              barrierDismissible: false,
                                              context: context,
                                              builder: (context) {
                                                return Checkbox(
                                                  alasan: isiCheckbox,
                                                  valueCheck: valueCheckbox,
                                                  selectedAlasan:
                                                  selectedAlasan,
                                                  selectedValue: selectedValue,
                                                  onSelectedAlasanListChanged:
                                                      (alasans) {
                                                    selectedAlasan = alasans;
                                                  },
                                                  onResult: (finalResult) {
                                                    _cardController.animateTo(
                                                        _cardController.index +
                                                            1);
                                                  },
                                                );
                                              },
                                            );
                                          },
                                        ),
                                      ),
                                      alignment: Alignment(0.0, 0.0),
                                    ),
                                    Container(
                                      padding:
                                      EdgeInsets.symmetric(horizontal: 5.0),
                                      child: ButtonTheme(
                                        minWidth: 50.0,
                                        height: 50.0,
                                        child: RaisedButton(
                                          shape: new RoundedRectangleBorder(
                                              borderRadius:
                                              new BorderRadius.circular(
                                                  5.0),
                                              side: BorderSide(
                                                  width: 1.5,
                                                  color: Colors.white)),
                                          child: Text(
                                            '1',
                                            style: TextStyle(
                                                fontSize: 18.0,
                                                color: Colors.white),
                                            textAlign: TextAlign.center,
                                          ),
                                          color: Color.fromARGB(
                                              170, 192, 192, 192),
                                          onPressed: () {
                                            showDialog(
                                              barrierDismissible: false,
                                              context: context,
                                              builder: (context) {
                                                return Checkbox(
                                                  alasan: isiCheckbox,
                                                  valueCheck: valueCheckbox,
                                                  selectedAlasan:
                                                  selectedAlasan,
                                                  selectedValue: selectedValue,
                                                  onSelectedAlasanListChanged:
                                                      (alasans) {
                                                    selectedAlasan = alasans;
                                                  },
                                                  onResult: (finalResult) {
                                                    _cardController.animateTo(
                                                        _cardController.index +
                                                            1);
                                                  },
                                                );
                                              },
                                            );
                                          },
                                        ),
                                      ),
                                      alignment: Alignment(0.0, 0.0),
                                    ),
                                    Container(
                                      child: ButtonTheme(
                                        minWidth: 50.0,
                                        height: 50.0,
                                        child: RaisedButton(
                                          shape: new RoundedRectangleBorder(
                                              borderRadius:
                                              new BorderRadius.circular(
                                                  5.0),
                                              side: BorderSide(
                                                  width: 1.5,
                                                  color: Colors.white)),
                                          child: Text(
                                            '2',
                                            style: TextStyle(
                                                fontSize: 18.0,
                                                color: Colors.white),
                                            textAlign: TextAlign.center,
                                          ),
                                          color:
                                          Color.fromARGB(170, 50, 205, 50),
                                          onPressed: () {
                                            _cardController.animateTo(
                                                _cardController.index + 1);
                                          },
                                        ),
                                      ),
                                      alignment: Alignment(0.0, 0.0),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                          Container(
                            color: Colors.white,
                            padding: EdgeInsets.symmetric(
                                horizontal: 20.0, vertical: 10.0),
                            child: Center(
                              child: Text(
                                  'Pastikan tingkat kematangan steak sudah sesuai pesanan dengan cara meminta tamu memotong bagian tengah daging.'),
                            ),
                          )
                        ],
                      ),
                      ListView(
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
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 10.0),
                                        child: Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            Text(
                                              '11. Following up after the main course',
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 14.0),
                                              textAlign: TextAlign.start,
                                            ),
                                            Text(
                                              '11 of ${_listData.length.toString()}',
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 14.0),
                                              textAlign: TextAlign.start,
                                            ),
                                          ],
                                        ),
                                      ),
                                      decoration: BoxDecoration(
                                          color: Color(0xFF2F592F))),
                                ),
                              ],
                            ),
                          ),
                          Stack(
                            children: <Widget>[
                              Image.asset(
                                'assets/images/slide 23.png',
                                fit: BoxFit.cover,
                                height: MediaQuery.of(context).size.height /
                                    1.55777,
                              ),
                              Positioned(
                                bottom: 20.0,
                                width: MediaQuery.of(context).size.width,
                                child: Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceAround,
                                  children: <Widget>[
                                    Container(
                                      child: ButtonTheme(
                                        minWidth: 50.0,
                                        height: 50.0,
                                        child: RaisedButton(
                                          shape: new RoundedRectangleBorder(
                                              borderRadius:
                                              new BorderRadius.circular(
                                                  5.0),
                                              side: BorderSide(
                                                  width: 1.5,
                                                  color: Colors.white)),
                                          child: Text(
                                            '0',
                                            style: TextStyle(
                                                fontSize: 18.0,
                                                color: Colors.white),
                                            textAlign: TextAlign.center,
                                          ),
                                          color:
                                          Color.fromARGB(170, 255, 40, 0),
                                          onPressed: () {
                                            showDialog(
                                              barrierDismissible: false,
                                              context: context,
                                              builder: (context) {
                                                return Checkbox(
                                                  alasan: isiCheckbox,
                                                  valueCheck: valueCheckbox,
                                                  selectedAlasan:
                                                  selectedAlasan,
                                                  selectedValue: selectedValue,
                                                  onSelectedAlasanListChanged:
                                                      (alasans) {
                                                    selectedAlasan = alasans;
                                                  },
                                                  onResult: (finalResult) {
                                                    _cardController.animateTo(
                                                        _cardController.index +
                                                            1);
                                                  },
                                                );
                                              },
                                            );
                                          },
                                        ),
                                      ),
                                      alignment: Alignment(0.0, 0.0),
                                    ),
                                    Container(
                                      padding:
                                      EdgeInsets.symmetric(horizontal: 5.0),
                                      child: ButtonTheme(
                                        minWidth: 50.0,
                                        height: 50.0,
                                        child: RaisedButton(
                                          shape: new RoundedRectangleBorder(
                                              borderRadius:
                                              new BorderRadius.circular(
                                                  5.0),
                                              side: BorderSide(
                                                  width: 1.5,
                                                  color: Colors.white)),
                                          child: Text(
                                            '1',
                                            style: TextStyle(
                                                fontSize: 18.0,
                                                color: Colors.white),
                                            textAlign: TextAlign.center,
                                          ),
                                          color: Color.fromARGB(
                                              170, 192, 192, 192),
                                          onPressed: () {
                                            showDialog(
                                              barrierDismissible: false,
                                              context: context,
                                              builder: (context) {
                                                return Checkbox(
                                                  alasan: isiCheckbox,
                                                  valueCheck: valueCheckbox,
                                                  selectedAlasan:
                                                  selectedAlasan,
                                                  selectedValue: selectedValue,
                                                  onSelectedAlasanListChanged:
                                                      (alasans) {
                                                    selectedAlasan = alasans;
                                                  },
                                                  onResult: (finalResult) {
                                                    _cardController.animateTo(
                                                        _cardController.index +
                                                            1);
                                                  },
                                                );
                                              },
                                            );
                                          },
                                        ),
                                      ),
                                      alignment: Alignment(0.0, 0.0),
                                    ),
                                    Container(
                                      child: ButtonTheme(
                                        minWidth: 50.0,
                                        height: 50.0,
                                        child: RaisedButton(
                                          shape: new RoundedRectangleBorder(
                                              borderRadius:
                                              new BorderRadius.circular(
                                                  5.0),
                                              side: BorderSide(
                                                  width: 1.5,
                                                  color: Colors.white)),
                                          child: Text(
                                            '2',
                                            style: TextStyle(
                                                fontSize: 18.0,
                                                color: Colors.white),
                                            textAlign: TextAlign.center,
                                          ),
                                          color:
                                          Color.fromARGB(170, 50, 205, 50),
                                          onPressed: () {
                                            _cardController.animateTo(
                                                _cardController.index + 1);
                                          },
                                        ),
                                      ),
                                      alignment: Alignment(0.0, 0.0),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                          Container(
                            color: Colors.white,
                            padding: EdgeInsets.symmetric(
                                horizontal: 20.0, vertical: 10.0),
                            child: Center(
                              child: Text(
                                  'Lakukan cheklist minuman dalam barcode order yang menempel di meja.'),
                            ),
                          )
                        ],
                      ),
                      ListView(
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
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 10.0),
                                        child: Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            Text(
                                              '12. Offering Dessert',
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 14.0),
                                              textAlign: TextAlign.start,
                                            ),
                                            Text(
                                              '12 of ${_listData.length.toString()}',
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 14.0),
                                              textAlign: TextAlign.start,
                                            ),
                                          ],
                                        ),
                                      ),
                                      decoration: BoxDecoration(
                                          color: Color(0xFF2F592F))),
                                ),
                              ],
                            ),
                          ),
                          Stack(
                            children: <Widget>[
                              Image.asset(
                                'assets/images/slide 18.png',
                                fit: BoxFit.cover,
                                height: MediaQuery.of(context).size.height /
                                    1.55777,
                              ),
                              Positioned(
                                bottom: 20.0,
                                width: MediaQuery.of(context).size.width,
                                child: Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceAround,
                                  children: <Widget>[
                                    Container(
                                      child: ButtonTheme(
                                        minWidth: 50.0,
                                        height: 50.0,
                                        child: RaisedButton(
                                          shape: new RoundedRectangleBorder(
                                              borderRadius:
                                              new BorderRadius.circular(
                                                  5.0),
                                              side: BorderSide(
                                                  width: 1.5,
                                                  color: Colors.white)),
                                          child: Text(
                                            '0',
                                            style: TextStyle(
                                                fontSize: 18.0,
                                                color: Colors.white),
                                            textAlign: TextAlign.center,
                                          ),
                                          color:
                                          Color.fromARGB(170, 255, 40, 0),
                                          onPressed: () {
                                            showDialog(
                                              barrierDismissible: false,
                                              context: context,
                                              builder: (context) {
                                                return Checkbox(
                                                  alasan: isiCheckbox,
                                                  valueCheck: valueCheckbox,
                                                  selectedAlasan:
                                                  selectedAlasan,
                                                  selectedValue: selectedValue,
                                                  onSelectedAlasanListChanged:
                                                      (alasans) {
                                                    selectedAlasan = alasans;
                                                  },
                                                  onResult: (finalResult) {
                                                    _cardController.animateTo(
                                                        _cardController.index +
                                                            1);
                                                  },
                                                );
                                              },
                                            );
                                          },
                                        ),
                                      ),
                                      alignment: Alignment(0.0, 0.0),
                                    ),
                                    Container(
                                      padding:
                                      EdgeInsets.symmetric(horizontal: 5.0),
                                      child: ButtonTheme(
                                        minWidth: 50.0,
                                        height: 50.0,
                                        child: RaisedButton(
                                          shape: new RoundedRectangleBorder(
                                              borderRadius:
                                              new BorderRadius.circular(
                                                  5.0),
                                              side: BorderSide(
                                                  width: 1.5,
                                                  color: Colors.white)),
                                          child: Text(
                                            '1',
                                            style: TextStyle(
                                                fontSize: 18.0,
                                                color: Colors.white),
                                            textAlign: TextAlign.center,
                                          ),
                                          color: Color.fromARGB(
                                              170, 192, 192, 192),
                                          onPressed: () {
                                            showDialog(
                                              barrierDismissible: false,
                                              context: context,
                                              builder: (context) {
                                                return Checkbox(
                                                  alasan: isiCheckbox,
                                                  valueCheck: valueCheckbox,
                                                  selectedAlasan:
                                                  selectedAlasan,
                                                  selectedValue: selectedValue,
                                                  onSelectedAlasanListChanged:
                                                      (alasans) {
                                                    selectedAlasan = alasans;
                                                  },
                                                  onResult: (finalResult) {
                                                    _cardController.animateTo(
                                                        _cardController.index +
                                                            1);
                                                  },
                                                );
                                              },
                                            );
                                          },
                                        ),
                                      ),
                                      alignment: Alignment(0.0, 0.0),
                                    ),
                                    Container(
                                      child: ButtonTheme(
                                        minWidth: 50.0,
                                        height: 50.0,
                                        child: RaisedButton(
                                          shape: new RoundedRectangleBorder(
                                              borderRadius:
                                              new BorderRadius.circular(
                                                  5.0),
                                              side: BorderSide(
                                                  width: 1.5,
                                                  color: Colors.white)),
                                          child: Text(
                                            '2',
                                            style: TextStyle(
                                                fontSize: 18.0,
                                                color: Colors.white),
                                            textAlign: TextAlign.center,
                                          ),
                                          color:
                                          Color.fromARGB(170, 50, 205, 50),
                                          onPressed: () {
                                            _cardController.animateTo(
                                                _cardController.index + 1);
                                          },
                                        ),
                                      ),
                                      alignment: Alignment(0.0, 0.0),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                          Container(
                            color: Colors.white,
                            padding: EdgeInsets.symmetric(
                                horizontal: 20.0, vertical: 10.0),
                            child: Center(
                              child: Text(
                                  '1. Membukakan pintu dengan seyuman dan eye contact yang ikhlas'),
                            ),
                          )
                        ],
                      ),
                      ListView(
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
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 10.0),
                                        child: Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            Text(
                                              '13. Delivering Dessert',
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 14.0),
                                              textAlign: TextAlign.start,
                                            ),
                                            Text(
                                              '13 of ${_listData.length.toString()}',
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 14.0),
                                              textAlign: TextAlign.start,
                                            ),
                                          ],
                                        ),
                                      ),
                                      decoration: BoxDecoration(
                                          color: Color(0xFF2F592F))),
                                ),
                              ],
                            ),
                          ),
                          Stack(
                            children: <Widget>[
                              Image.asset(
                                'assets/images/slide 19.png',
                                fit: BoxFit.cover,
                                height: MediaQuery.of(context).size.height /
                                    1.55777,
                              ),
                              Positioned(
                                bottom: 20.0,
                                width: MediaQuery.of(context).size.width,
                                child: Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceAround,
                                  children: <Widget>[
                                    Container(
                                      child: ButtonTheme(
                                        minWidth: 50.0,
                                        height: 50.0,
                                        child: RaisedButton(
                                          shape: new RoundedRectangleBorder(
                                              borderRadius:
                                              new BorderRadius.circular(
                                                  5.0),
                                              side: BorderSide(
                                                  width: 1.5,
                                                  color: Colors.white)),
                                          child: Text(
                                            '0',
                                            style: TextStyle(
                                                fontSize: 18.0,
                                                color: Colors.white),
                                            textAlign: TextAlign.center,
                                          ),
                                          color:
                                          Color.fromARGB(170, 255, 40, 0),
                                          onPressed: () {
                                            showDialog(
                                              barrierDismissible: false,
                                              context: context,
                                              builder: (context) {
                                                return Checkbox(
                                                  alasan: isiCheckbox,
                                                  valueCheck: valueCheckbox,
                                                  selectedAlasan:
                                                  selectedAlasan,
                                                  selectedValue: selectedValue,
                                                  onSelectedAlasanListChanged:
                                                      (alasans) {
                                                    selectedAlasan = alasans;
                                                  },
                                                  onResult: (finalResult) {
                                                    setState(() {
                                                      Navigator.push(
                                                          context,
                                                          MyCustomRoute(
                                                              builder: (context) =>
                                                                  FormMockComplaint()));
                                                    });
                                                  },
                                                );
                                              },
                                            );
                                          },
                                        ),
                                      ),
                                      alignment: Alignment(0.0, 0.0),
                                    ),
                                    Container(
                                      padding:
                                      EdgeInsets.symmetric(horizontal: 5.0),
                                      child: ButtonTheme(
                                        minWidth: 50.0,
                                        height: 50.0,
                                        child: RaisedButton(
                                          shape: new RoundedRectangleBorder(
                                              borderRadius:
                                              new BorderRadius.circular(
                                                  5.0),
                                              side: BorderSide(
                                                  width: 1.5,
                                                  color: Colors.white)),
                                          child: Text(
                                            '1',
                                            style: TextStyle(
                                                fontSize: 18.0,
                                                color: Colors.white),
                                            textAlign: TextAlign.center,
                                          ),
                                          color: Color.fromARGB(
                                              170, 192, 192, 192),
                                          onPressed: () {
                                            showDialog(
                                              barrierDismissible: false,
                                              context: context,
                                              builder: (context) {
                                                return Checkbox(
                                                  alasan: isiCheckbox,
                                                  valueCheck: valueCheckbox,
                                                  selectedAlasan:
                                                  selectedAlasan,
                                                  selectedValue: selectedValue,
                                                  onSelectedAlasanListChanged:
                                                      (alasans) {
                                                    selectedAlasan = alasans;
                                                  },
                                                  onResult: (finalResult) {
                                                    Navigator.push(
                                                        context,
                                                        MyCustomRoute(
                                                            builder: (context) =>
                                                                FormMockComplaint()));
                                                  },
                                                );
                                              },
                                            );
                                          },
                                        ),
                                      ),
                                      alignment: Alignment(0.0, 0.0),
                                    ),
                                    Container(
                                      child: ButtonTheme(
                                        minWidth: 50.0,
                                        height: 50.0,
                                        child: RaisedButton(
                                          shape: new RoundedRectangleBorder(
                                              borderRadius:
                                              new BorderRadius.circular(
                                                  5.0),
                                              side: BorderSide(
                                                  width: 1.5,
                                                  color: Colors.white)),
                                          child: Text(
                                            '2',
                                            style: TextStyle(
                                                fontSize: 18.0,
                                                color: Colors.white),
                                            textAlign: TextAlign.center,
                                          ),
                                          color:
                                          Color.fromARGB(170, 50, 205, 50),
                                          onPressed: () {
                                            Navigator.push(
                                                context,
                                                MyCustomRoute(
                                                    builder: (context) =>
                                                        FormMockComplaint()));
                                          },
                                        ),
                                      ),
                                      alignment: Alignment(0.0, 0.0),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                          Container(
                            color: Colors.white,
                            padding: EdgeInsets.symmetric(
                                horizontal: 20.0, vertical: 10.0),
                            child: Center(
                              child: Text(
                                  'penampilan produk sesuai dengan standar penyajian.'),
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        bottomNavigationBar: _bottomBar(),
      ),
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
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    IconButton(
                      icon: Icon(Icons.camera_alt, color: Colors.white),
                      onPressed: () {},
                    ),
                    IconButton(
                      icon: Icon(Icons.event_note, color: Colors.white),
                      onPressed: () {
                        showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: Text('NOTE'),
                                content: Container(
                                  width: 300.0,
                                  child: TextField(
                                    controller: _controllerNote,
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(),
                                      hintText: 'Note',
                                      hintStyle: TextStyle(fontSize: 12.0),
                                    ),
                                    maxLines: 3,
                                    style: TextStyle(
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                                actions: <Widget>[
                                  FlatButton(
                                    splashColor: Colors.greenAccent,
                                    child: Text(
                                      'SAVE',
                                      style: TextStyle(color: Colors.green),
                                    ),
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                  )
                                ],
                              );
                            });
                      },
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
        'assets/images/logo.png',
        height: 100.0,
        width: 120.0,
      ),
    );
  }
}

class FormMockComplaint extends StatefulWidget {
  @override
  _FormMockComplaintState createState() => _FormMockComplaintState();
}

class _FormMockComplaintState extends State<FormMockComplaint> {
  String _myCategory;
  String _category;
  List<Map> _categoryJson = [
    {"id": 1, "category": "Service"},
    {"id": 2, "category": "Produk"}
  ];

  String _myProduct;
  String _product;
  List<Map> _productJson = [
    {"id": 1, "product": "Wagyu"},
    {"id": 2, "product": "Sirloin"}
  ];

  String _myService;
  String _service;
  List<Map> _serviceJson = [
    {"id": 1, "service": "Kebersihan"},
    {"id": 2, "service": "Kerapihan"},
    {"id": 3, "service": "Hospitality"},
  ];

  String _myPIC;
  String _pic;
  List<Map> _picJson = [
    {"id": 1, "pic": "Waiters"},
    {"id": 2, "pic": "Cashier"},
    {"id": 3, "pic": "Manager"},
  ];

  bool _note1 = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AbubaAppBar(),
        body: _buildMenu(),
      ),
    );
  }

  Widget _buildMenu() {
    return Scrollbar(
      child: ListView(
        children: <Widget>[
          Container(
            width: MediaQuery.of(context).size.width,
            color: Colors.white,
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        'Mystery Shopper',
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
                          'Mock Complaint',
                          style: TextStyle(
                              color: AbubaPallate.greenabuba, fontSize: 12.0),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 20.0),
                  child: Column(
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Flexible(
                            child: Text(
                              'Bersiaplah untuk Complaint',
                              style: TextStyle(
                                  color: Colors.red,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 20.0),
                            ),
                          )
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Flexible(
                            child: Text(
                              'Lengkapi dulu scenario complaint di bawah ini sebelum melakukan complaint.',
                              style: TextStyle(
                                  fontSize: 14.0, color: Colors.black54),
                              textAlign: TextAlign.center,
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
          Container(
            color: Colors.grey[200],
            width: MediaQuery.of(context).size.width,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
              child: Column(
                children: <Widget>[
                  DropdownButtonFormField(
                    hint: Text('Category', style: TextStyle(fontSize: 14.0)),
                    value: _myCategory,
                    onChanged: (String newValue) {
                      setState(() {
                        switch (int.tryParse(newValue)) {
                          case 1:
                            _category = 'Service';
                            break;
                          case 2:
                            _category = 'Produk';
                            break;
                          default:
                            _category = '-';
                            break;
                        }
                        _myCategory = newValue;
                      });
                    },
                    items: _categoryJson.map((Map map) {
                      return new DropdownMenuItem(
                        value: map['id'].toString(),
                        child: Text(map['category']),
                      );
                    }).toList(),
                  ),
                  DropdownButtonFormField(
                    hint: Text('Product', style: TextStyle(fontSize: 14.0)),
                    value: _myProduct,
                    onChanged: (String newValue) {
                      setState(() {
                        switch (int.tryParse(newValue)) {
                          case 1:
                            _product = 'Wagyu';
                            break;
                          case 2:
                            _product = 'Sirloin';
                            break;
                          default:
                            _product = '-';
                            break;
                        }
                        _myProduct = newValue;
                      });
                    },
                    items: _productJson.map((Map map) {
                      return new DropdownMenuItem(
                        value: map['id'].toString(),
                        child: Text(map['product']),
                      );
                    }).toList(),
                  ),
                  DropdownButtonFormField(
                    hint: Text('Service', style: TextStyle(fontSize: 14.0)),
                    value: _myService,
                    onChanged: (String newValue) {
                      setState(() {
                        switch (int.tryParse(newValue)) {
                          case 1:
                            _service = 'Kebersihan';
                            break;
                          case 2:
                            _service = 'Kerapihan';
                            break;
                          default:
                            _service = 'Hospitality';
                            break;
                        }
                        _myService = newValue;
                      });
                    },
                    items: _serviceJson.map((Map map) {
                      return new DropdownMenuItem(
                        value: map['id'].toString(),
                        child: Text(map['service']),
                      );
                    }).toList(),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      ButtonTheme(
                        minWidth: 50.0,
                        height: 25.0,
                        child: RaisedButton(
                          color: Colors.transparent,
                          elevation: 0.0,
                          child: Text(
                            'Note',
                            style: TextStyle(
                                fontSize: 14.0,
                                color: AbubaPallate.menuBluebird),
                          ),
                          onPressed: () {
                            setState(() {
                              _note1 = !_note1;
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                  _note1
                      ? Container(
                    padding: const EdgeInsets.only(
                      bottom: 10.0,
                    ),
                    width: MediaQuery.of(context).size.width,
                    child: TextField(
                      decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Note',
                          labelStyle: TextStyle(fontSize: 16.0)),
                      maxLines: 3,
                      style:
                      TextStyle(color: Colors.black, fontSize: 16.0),
                    ),
                  )
                      : Container(),
                  DropdownButtonFormField(
                    hint: Text('PIC yang dituju',
                        style: TextStyle(fontSize: 14.0)),
                    value: _myPIC,
                    onChanged: (String newValue) {
                      setState(() {
                        switch (int.tryParse(newValue)) {
                          case 1:
                            _pic = 'Kebersihan';
                            break;
                          case 2:
                            _pic = 'Kerapihan';
                            break;
                          default:
                            _pic = 'Hospitality';
                            break;
                        }
                        _myPIC = newValue;
                      });
                    },
                    items: _picJson.map((Map map) {
                      return new DropdownMenuItem(
                        value: map['id'].toString(),
                        child: Text(map['pic']),
                      );
                    }).toList(),
                  ),
                  Container(
                    padding: const EdgeInsets.only(bottom: 10.0, top: 20.0),
                    width: MediaQuery.of(context).size.width,
                    child: TextField(
                      decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Verbatim complaint',
                          labelStyle: TextStyle(fontSize: 16.0)),
                      maxLines: 3,
                      style: TextStyle(color: Colors.black, fontSize: 16.0),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      ButtonTheme(
                        minWidth: 50.0,
                        height: 40.0,
                        child: RaisedButton(
                          shape: new RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(5.0)),
                          child: Text(
                            'COMPLAINT',
                            style:
                            TextStyle(fontSize: 13.0, color: Colors.white),
                          ),
                          color: Colors.blueAccent,
                          onPressed: () {
                            Navigator.push(
                                context,
                                MyCustomRoute(
                                    builder: (context) => FormClose()));
                          },
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

class FormClose extends StatefulWidget {
  @override
  _FormCloseState createState() => _FormCloseState();
}

class _FormCloseState extends State<FormClose> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AbubaAppBar(),
        body: _buildMenu(),
      ),
    );
  }

  Widget _buildMenu() {
    return ListView(
      children: <Widget>[
        Container(
          height: 400.5,
          width: MediaQuery.of(context).size.width,
          color: Colors.white,
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'Mystery Shopper',
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
                        'Location',
                        style: TextStyle(
                            color: AbubaPallate.greenabuba, fontSize: 12.0),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(20.0, 100.0, 20.0, 20.0),
                child: Column(
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Flexible(
                          child: Text(
                            'Close complaint session',
                            style: TextStyle(
                                color: AbubaPallate.greenabuba,
                                fontWeight: FontWeight.w700,
                                fontSize: 20.0),
                          ),
                        )
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Flexible(
                          child: Text(
                            'Tekan tombol di bawah ini bila Anda merasa complaint Anda sudah ditangani dengan baik',
                            style: TextStyle(
                                fontSize: 14.0, color: Colors.black54),
                            textAlign: TextAlign.center,
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 30.0,
                    ),
                    ButtonTheme(
                      minWidth: 50.0,
                      height: 40.0,
                      child: RaisedButton(
                        shape: new RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(5.0),
                        ),
                        child: Text(
                          'DONE',
                          style: TextStyle(fontSize: 13.0, color: Colors.white),
                        ),
                        color: Colors.blueAccent,
                        onPressed: () {
                          Navigator.push(
                              context,
                              MyCustomRoute(
                                  builder: (context) => FormHandling()));
                        },
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
        Container(
          child: Image.asset(
            'assets/images/slide 21.png',
            fit: BoxFit.fitWidth,
          ),
        )
      ],
    );
  }
}

class FormHandling extends StatefulWidget {
  @override
  _FormHandlingState createState() => _FormHandlingState();
}

class _FormHandlingState extends State<FormHandling> {
  List<String> isiCheckbox = [
    'Apakah organisasi sudah menetapkan internal dan eksternal isu yang berpengaruh terhadap kelangsungan organisasi?',
    '',
    '',
  ];
  List<String> valueCheckbox = ['1', '2', '3'];
  List<String> selectedValue = [];
  List<String> selectedAlasan = [];
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AbubaAppBar(),
        body: _buildMenu(),
      ),
    );
  }

  Widget _buildMenu() {
    return ListView(
      children: <Widget>[
        Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Mystery Shopper',
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
                      'Location',
                      style: TextStyle(
                          color: AbubaPallate.greenabuba, fontSize: 12.0),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(20.0, 80.0, 20.0, 20.0),
              child: Column(
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Flexible(
                        child: Text(
                          'Nilai Complaint Handling',
                          style: TextStyle(
                              color: AbubaPallate.greenabuba,
                              fontWeight: FontWeight.w700,
                              fontSize: 20.0),
                        ),
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Flexible(
                        child: Text(
                          'Beri score kepuasan Anda terhadap ara mereka menangani complaint Anda',
                          style:
                          TextStyle(fontSize: 14.0, color: Colors.black54),
                          textAlign: TextAlign.center,
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 30.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Container(
                        child: ButtonTheme(
                          minWidth: 50.0,
                          height: 50.0,
                          child: RaisedButton(
                            shape: new RoundedRectangleBorder(
                                borderRadius: new BorderRadius.circular(5.0),
                                side: BorderSide(
                                    width: 1.5, color: Colors.white)),
                            child: Text(
                              '0',
                              style: TextStyle(
                                  fontSize: 18.0, color: Colors.white),
                              textAlign: TextAlign.center,
                            ),
                            color: Color.fromARGB(170, 255, 40, 0),
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
                                        Navigator.push(
                                            context,
                                            MyCustomRoute(
                                                builder: (context) =>
                                                    FormSelesaiMakan()));
                                      });
                                    },
                                  );
                                },
                              );
                            },
                          ),
                        ),
                        alignment: Alignment(0.0, 0.0),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 5.0),
                        child: ButtonTheme(
                          minWidth: 50.0,
                          height: 50.0,
                          child: RaisedButton(
                            shape: new RoundedRectangleBorder(
                                borderRadius: new BorderRadius.circular(5.0),
                                side: BorderSide(
                                    width: 1.5, color: Colors.white)),
                            child: Text(
                              '1',
                              style: TextStyle(
                                  fontSize: 18.0, color: Colors.white),
                              textAlign: TextAlign.center,
                            ),
                            color: Color.fromARGB(170, 192, 192, 192),
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
                                        Navigator.push(
                                            context,
                                            MyCustomRoute(
                                                builder: (context) =>
                                                    FormSelesaiMakan()));
                                      });
                                    },
                                  );
                                },
                              );
                            },
                          ),
                        ),
                        alignment: Alignment(0.0, 0.0),
                      ),
                      Container(
                        child: ButtonTheme(
                          minWidth: 50.0,
                          height: 50.0,
                          child: RaisedButton(
                            shape: new RoundedRectangleBorder(
                                borderRadius: new BorderRadius.circular(5.0),
                                side: BorderSide(
                                    width: 1.5, color: Colors.white)),
                            child: Text(
                              '2',
                              style: TextStyle(
                                  fontSize: 18.0, color: Colors.white),
                              textAlign: TextAlign.center,
                            ),
                            color: Color.fromARGB(170, 50, 205, 50),
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MyCustomRoute(
                                      builder: (context) =>
                                          FormSelesaiMakan()));
                            },
                          ),
                        ),
                        alignment: Alignment(0.0, 0.0),
                      ),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
        SizedBox(
          height: 86.0,
        ),
        Container(
          color: AbubaPallate.yellow,
          padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
          child: Center(
            child:
            Text('1. Pihak Outlet mengucapkan maaf atas ketidaknyamanan'),
          ),
        ),
        Container(
          child: Image.asset(
            'assets/images/slide 21.png',
            fit: BoxFit.fitWidth,
          ),
        )
      ],
    );
  }
}

class FormSelesaiMakan extends StatefulWidget {
  @override
  _FormSelesaiMakanState createState() => _FormSelesaiMakanState();
}

class _FormSelesaiMakanState extends State<FormSelesaiMakan> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AbubaAppBar(),
        body: _buildMenu(),
      ),
    );
  }

  Widget _buildMenu() {
    return ListView(
      children: <Widget>[
        Container(
          height: 390.0,
          width: MediaQuery.of(context).size.width,
          color: Colors.white,
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'Mystery Shopper',
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
                        'Location',
                        style: TextStyle(
                            color: AbubaPallate.greenabuba, fontSize: 12.0),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(20.0, 100.0, 20.0, 20.0),
                child: Column(
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Flexible(
                          child: Text(
                            'Selesaikan Makan Anda',
                            style: TextStyle(
                                color: AbubaPallate.greenabuba,
                                fontWeight: FontWeight.w700,
                                fontSize: 20.0),
                          ),
                        )
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Flexible(
                          child: Text(
                            'Bersiaplah meminta bill, mengawasi clearing table dan melakukan pembayaran',
                            style: TextStyle(
                                fontSize: 14.0, color: Colors.black54),
                            textAlign: TextAlign.center,
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 30.0,
                    ),
                    ButtonTheme(
                      minWidth: 50.0,
                      height: 40.0,
                      child: RaisedButton(
                        shape: new RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(5.0),
                        ),
                        child: Text(
                          'CONFIRM',
                          style: TextStyle(fontSize: 13.0, color: Colors.white),
                        ),
                        color: Colors.blue,
                        onPressed: () {
                          Navigator.push(
                              context,
                              MyCustomRoute(
                                  builder: (context) => FormLanjutReview()));
                        },
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
        Container(
          child: Image.asset(
            'assets/images/slide 23.png',
            fit: BoxFit.fitWidth,
          ),
        )
      ],
    );
  }
}

class FormLanjutReview extends StatefulWidget {
  @override
  _FormLanjutReviewState createState() => _FormLanjutReviewState();
}

class _FormLanjutReviewState extends State<FormLanjutReview> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AbubaAppBar(),
        body: _buildMenu(),
      ),
    );
  }

  Widget _buildMenu() {
    return ListView(
      children: <Widget>[
        Container(
          height: 390.0,
          width: MediaQuery.of(context).size.width,
          color: Colors.white,
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'Mystery Shopper',
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
                        'Location',
                        style: TextStyle(
                            color: AbubaPallate.greenabuba, fontSize: 12.0),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(20.0, 100.0, 20.0, 20.0),
                child: Column(
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Flexible(
                          child: Text(
                            'Lanjutkan Review Anda',
                            style: TextStyle(
                                color: AbubaPallate.greenabuba,
                                fontWeight: FontWeight.w700,
                                fontSize: 20.0),
                          ),
                        )
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Flexible(
                          child: Text(
                            'Selesaikan makan Anda bersiaplah meminta bill, mengawasi clearing table dan melakukan pembayaran',
                            style: TextStyle(
                                fontSize: 14.0, color: Colors.black54),
                            textAlign: TextAlign.center,
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 30.0,
                    ),
                    ButtonTheme(
                      minWidth: 50.0,
                      height: 40.0,
                      child: RaisedButton(
                        shape: new RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(5.0),
                        ),
                        child: Text(
                          'CONFIRM',
                          style: TextStyle(fontSize: 13.0, color: Colors.white),
                        ),
                        color: Colors.blue,
                        onPressed: () {
                          Navigator.push(
                              context,
                              MyCustomRoute(
                                  builder: (context) => FormFinishing()));
                        },
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
        Container(
          child: Image.asset(
            'assets/images/slide 23.png',
            fit: BoxFit.fitWidth,
          ),
        )
      ],
    );
  }
}

class FormFinishing extends StatefulWidget {
  @override
  _FormFinishingState createState() => _FormFinishingState();
}

class _FormFinishingState extends State<FormFinishing> with TickerProviderStateMixin {
  List<Map> _listData = [
    {'nomor': '11'},
    {'nomor': '12'},
    {'nomor': '13'}
  ];

  List<String> textList = [
    'Menu Baru',
    'Event',
    'Upselling',
    'Hasil Audit',
    'Pengumuman',
  ];

  List<String> isiCheckbox = [
    'Apakah organisasi sudah menetapkan internal dan eksternal isu yang berpengaruh terhadap kelangsungan organisasi?',
    '',
    '',
  ];
  List<String> valueCheckbox = ['1', '2', '3'];
  List<String> selectedValue = [];
  List<String> selectedAlasan = [];

  bool _value1 = false;
  bool _value2 = false;
  bool _value3 = false;
  bool _value4 = false;
  bool _value5 = false;

  //we omitted the brackets '{}' and are using fat arrow '=>' instead, this is dart syntax
  void _value1Changed(bool value) => setState(() => _value1 = value);
  void _value2Changed(bool value) => setState(() => _value2 = value);
  void _value3Changed(bool value) => setState(() => _value3 = value);
  void _value4Changed(bool value) => setState(() => _value4 = value);
  void _value5Changed(bool value) => setState(() => _value5 = value);

  TabController _cardController;

  @override
  void initState() {
    super.initState();
    _cardController = new TabController(vsync: this, length: _listData.length);
  }

  @override
  void dispose() {
    _cardController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: _appBar(),
        body: GestureDetector(
          onTap: () {
            FocusScope.of(context).requestFocus(FocusNode());
          },
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  child: TabBarView(
                    controller: _cardController,
                    physics: ScrollPhysics(),
                    children: <Widget>[
                      ListView(
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
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 10.0),
                                        child: Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            Text(
                                              '1. Offering the Bills',
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 14.0),
                                              textAlign: TextAlign.start,
                                            ),
                                            Text(
                                              '1 of ${_listData.length.toString()}',
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 14.0),
                                              textAlign: TextAlign.start,
                                            ),
                                          ],
                                        ),
                                      ),
                                      decoration: BoxDecoration(
                                          color: Color(0xFF2F592F))),
                                ),
                              ],
                            ),
                          ),
                          Stack(
                            children: <Widget>[
                              Image.asset(
                                'assets/images/slide 24.png',
                                fit: BoxFit.cover,
                                height: MediaQuery.of(context).size.height /
                                    1.50777,
                              ),
                              Positioned(
                                bottom: 20.0,
                                width: MediaQuery.of(context).size.width,
                                child: Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceAround,
                                  children: <Widget>[
                                    Container(
                                      child: ButtonTheme(
                                        minWidth: 50.0,
                                        height: 50.0,
                                        child: RaisedButton(
                                          shape: new RoundedRectangleBorder(
                                              borderRadius:
                                              new BorderRadius.circular(
                                                  5.0),
                                              side: BorderSide(
                                                  width: 1.5,
                                                  color: Colors.white)),
                                          child: Text(
                                            '0',
                                            style: TextStyle(
                                                fontSize: 18.0,
                                                color: Colors.white),
                                            textAlign: TextAlign.center,
                                          ),
                                          color:
                                          Color.fromARGB(170, 255, 40, 0),
                                          onPressed: () {
                                            showDialog(
                                              barrierDismissible: false,
                                              context: context,
                                              builder: (context) {
                                                return Checkbox(
                                                  alasan: isiCheckbox,
                                                  valueCheck: valueCheckbox,
                                                  selectedAlasan:
                                                  selectedAlasan,
                                                  selectedValue: selectedValue,
                                                  onSelectedAlasanListChanged:
                                                      (alasans) {
                                                    selectedAlasan = alasans;
                                                  },
                                                  onResult: (finalResult) {
                                                    _cardController.animateTo(
                                                        _cardController.index +
                                                            1);
                                                  },
                                                );
                                              },
                                            );
                                          },
                                        ),
                                      ),
                                      alignment: Alignment(0.0, 0.0),
                                    ),
                                    Container(
                                      padding:
                                      EdgeInsets.symmetric(horizontal: 5.0),
                                      child: ButtonTheme(
                                        minWidth: 50.0,
                                        height: 50.0,
                                        child: RaisedButton(
                                          shape: new RoundedRectangleBorder(
                                              borderRadius:
                                              new BorderRadius.circular(
                                                  5.0),
                                              side: BorderSide(
                                                  width: 1.5,
                                                  color: Colors.white)),
                                          child: Text(
                                            '1',
                                            style: TextStyle(
                                                fontSize: 18.0,
                                                color: Colors.white),
                                            textAlign: TextAlign.center,
                                          ),
                                          color: Color.fromARGB(
                                              170, 192, 192, 192),
                                          onPressed: () {
                                            showDialog(
                                              barrierDismissible: false,
                                              context: context,
                                              builder: (context) {
                                                return Checkbox(
                                                  alasan: isiCheckbox,
                                                  valueCheck: valueCheckbox,
                                                  selectedAlasan:
                                                  selectedAlasan,
                                                  selectedValue: selectedValue,
                                                  onSelectedAlasanListChanged:
                                                      (alasans) {
                                                    selectedAlasan = alasans;
                                                  },
                                                  onResult: (finalResult) {
                                                    _cardController.animateTo(
                                                        _cardController.index +
                                                            1);
                                                  },
                                                );
                                              },
                                            );
                                          },
                                        ),
                                      ),
                                      alignment: Alignment(0.0, 0.0),
                                    ),
                                    Container(
                                      child: ButtonTheme(
                                        minWidth: 50.0,
                                        height: 50.0,
                                        child: RaisedButton(
                                          shape: new RoundedRectangleBorder(
                                              borderRadius:
                                              new BorderRadius.circular(
                                                  5.0),
                                              side: BorderSide(
                                                  width: 1.5,
                                                  color: Colors.white)),
                                          child: Text(
                                            '2',
                                            style: TextStyle(
                                                fontSize: 18.0,
                                                color: Colors.white),
                                            textAlign: TextAlign.center,
                                          ),
                                          color:
                                          Color.fromARGB(170, 50, 205, 50),
                                          onPressed: () {
                                            _cardController.animateTo(
                                                _cardController.index + 1);
                                          },
                                        ),
                                      ),
                                      alignment: Alignment(0.0, 0.0),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                          Container(
                            color: Colors.white,
                            padding: EdgeInsets.symmetric(
                                horizontal: 20.0, vertical: 10.0),
                            child: Center(
                              child: Text(
                                  'Persilahkan customer memeriksa bill, bantu membacakan jika dibutuhkan'),
                            ),
                          )
                        ],
                      ),
                      ListView(
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
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 10.0),
                                        child: Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            Text(
                                              '2. Clearing Table',
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 14.0),
                                              textAlign: TextAlign.start,
                                            ),
                                            Text(
                                              '2 of ${_listData.length.toString()}',
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 14.0),
                                              textAlign: TextAlign.start,
                                            ),
                                          ],
                                        ),
                                      ),
                                      decoration: BoxDecoration(
                                          color: Color(0xFF2F592F))),
                                ),
                              ],
                            ),
                          ),
                          Stack(
                            children: <Widget>[
                              Image.asset(
                                'assets/images/slide 25.png',
                                fit: BoxFit.cover,
                                height: MediaQuery.of(context).size.height /
                                    1.50777,
                              ),
                              Positioned(
                                bottom: 20.0,
                                width: MediaQuery.of(context).size.width,
                                child: Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceAround,
                                  children: <Widget>[
                                    Container(
                                      child: ButtonTheme(
                                        minWidth: 50.0,
                                        height: 50.0,
                                        child: RaisedButton(
                                          shape: new RoundedRectangleBorder(
                                              borderRadius:
                                              new BorderRadius.circular(
                                                  5.0),
                                              side: BorderSide(
                                                  width: 1.5,
                                                  color: Colors.white)),
                                          child: Text(
                                            '0',
                                            style: TextStyle(
                                                fontSize: 18.0,
                                                color: Colors.white),
                                            textAlign: TextAlign.center,
                                          ),
                                          color:
                                          Color.fromARGB(170, 255, 40, 0),
                                          onPressed: () {
                                            showDialog(
                                              barrierDismissible: false,
                                              context: context,
                                              builder: (context) {
                                                return Checkbox(
                                                  alasan: isiCheckbox,
                                                  valueCheck: valueCheckbox,
                                                  selectedAlasan:
                                                  selectedAlasan,
                                                  selectedValue: selectedValue,
                                                  onSelectedAlasanListChanged:
                                                      (alasans) {
                                                    selectedAlasan = alasans;
                                                  },
                                                  onResult: (finalResult) {
                                                    _cardController.animateTo(
                                                        _cardController.index +
                                                            1);
                                                  },
                                                );
                                              },
                                            );
                                          },
                                        ),
                                      ),
                                      alignment: Alignment(0.0, 0.0),
                                    ),
                                    Container(
                                      padding:
                                      EdgeInsets.symmetric(horizontal: 5.0),
                                      child: ButtonTheme(
                                        minWidth: 50.0,
                                        height: 50.0,
                                        child: RaisedButton(
                                          shape: new RoundedRectangleBorder(
                                              borderRadius:
                                              new BorderRadius.circular(
                                                  5.0),
                                              side: BorderSide(
                                                  width: 1.5,
                                                  color: Colors.white)),
                                          child: Text(
                                            '1',
                                            style: TextStyle(
                                                fontSize: 18.0,
                                                color: Colors.white),
                                            textAlign: TextAlign.center,
                                          ),
                                          color: Color.fromARGB(
                                              170, 192, 192, 192),
                                          onPressed: () {
                                            showDialog(
                                              barrierDismissible: false,
                                              context: context,
                                              builder: (context) {
                                                return Checkbox(
                                                  alasan: isiCheckbox,
                                                  valueCheck: valueCheckbox,
                                                  selectedAlasan:
                                                  selectedAlasan,
                                                  selectedValue: selectedValue,
                                                  onSelectedAlasanListChanged:
                                                      (alasans) {
                                                    selectedAlasan = alasans;
                                                  },
                                                  onResult: (finalResult) {
                                                    _cardController.animateTo(
                                                        _cardController.index +
                                                            1);
                                                  },
                                                );
                                              },
                                            );
                                          },
                                        ),
                                      ),
                                      alignment: Alignment(0.0, 0.0),
                                    ),
                                    Container(
                                      child: ButtonTheme(
                                        minWidth: 50.0,
                                        height: 50.0,
                                        child: RaisedButton(
                                          shape: new RoundedRectangleBorder(
                                              borderRadius:
                                              new BorderRadius.circular(
                                                  5.0),
                                              side: BorderSide(
                                                  width: 1.5,
                                                  color: Colors.white)),
                                          child: Text(
                                            '2',
                                            style: TextStyle(
                                                fontSize: 18.0,
                                                color: Colors.white),
                                            textAlign: TextAlign.center,
                                          ),
                                          color:
                                          Color.fromARGB(170, 50, 205, 50),
                                          onPressed: () {
                                            _cardController.animateTo(
                                                _cardController.index + 1);
                                          },
                                        ),
                                      ),
                                      alignment: Alignment(0.0, 0.0),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                          Container(
                            color: Colors.white,
                            padding: EdgeInsets.symmetric(
                                horizontal: 20.0, vertical: 10.0),
                            child: Center(
                              child: Text(
                                  'Cleaning/clearing tables harus dilakukan maksimal 1 menit.'),
                            ),
                          )
                        ],
                      ),
                      ListView(
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
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 10.0),
                                        child: Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            Text(
                                              '3. Taking Payment and Thanking',
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 14.0),
                                              textAlign: TextAlign.start,
                                            ),
                                            Text(
                                              '3 of ${_listData.length.toString()}',
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 14.0),
                                              textAlign: TextAlign.start,
                                            ),
                                          ],
                                        ),
                                      ),
                                      decoration: BoxDecoration(
                                          color: Color(0xFF2F592F))),
                                ),
                              ],
                            ),
                          ),
                          Stack(
                            children: <Widget>[
                              Image.asset(
                                'assets/images/slide 26.png',
                                fit: BoxFit.fitHeight,
                                height: MediaQuery.of(context).size.height /
                                    1.50777,
                              ),
                              Positioned(
                                bottom: 20.0,
                                width: MediaQuery.of(context).size.width,
                                child: Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceAround,
                                  children: <Widget>[
                                    Container(
                                      child: ButtonTheme(
                                        minWidth: 50.0,
                                        height: 50.0,
                                        child: RaisedButton(
                                          shape: new RoundedRectangleBorder(
                                              borderRadius:
                                              new BorderRadius.circular(
                                                  5.0),
                                              side: BorderSide(
                                                  width: 1.5,
                                                  color: Colors.white)),
                                          child: Text(
                                            '0',
                                            style: TextStyle(
                                                fontSize: 18.0,
                                                color: Colors.white),
                                            textAlign: TextAlign.center,
                                          ),
                                          color:
                                          Color.fromARGB(170, 255, 40, 0),
                                          onPressed: () {
                                            showDialog(
                                              barrierDismissible: false,
                                              context: context,
                                              builder: (context) {
                                                return Checkbox(
                                                  alasan: isiCheckbox,
                                                  valueCheck: valueCheckbox,
                                                  selectedAlasan:
                                                  selectedAlasan,
                                                  selectedValue: selectedValue,
                                                  onSelectedAlasanListChanged:
                                                      (alasans) {
                                                    selectedAlasan = alasans;
                                                  },
                                                  onResult: (finalResult) {
                                                    Navigator.push(
                                                        context,
                                                        MyCustomRoute(
                                                            builder: (context) =>
                                                                FormSedikitLagi()));
                                                  },
                                                );
                                              },
                                            );
                                          },
                                        ),
                                      ),
                                      alignment: Alignment(0.0, 0.0),
                                    ),
                                    Container(
                                      padding:
                                      EdgeInsets.symmetric(horizontal: 5.0),
                                      child: ButtonTheme(
                                        minWidth: 50.0,
                                        height: 50.0,
                                        child: RaisedButton(
                                          shape: new RoundedRectangleBorder(
                                              borderRadius:
                                              new BorderRadius.circular(
                                                  5.0),
                                              side: BorderSide(
                                                  width: 1.5,
                                                  color: Colors.white)),
                                          child: Text(
                                            '1',
                                            style: TextStyle(
                                                fontSize: 18.0,
                                                color: Colors.white),
                                            textAlign: TextAlign.center,
                                          ),
                                          color: Color.fromARGB(
                                              170, 192, 192, 192),
                                          onPressed: () {
                                            showDialog(
                                              barrierDismissible: false,
                                              context: context,
                                              builder: (context) {
                                                return Checkbox(
                                                  alasan: isiCheckbox,
                                                  valueCheck: valueCheckbox,
                                                  selectedAlasan:
                                                  selectedAlasan,
                                                  selectedValue: selectedValue,
                                                  onSelectedAlasanListChanged:
                                                      (alasans) {
                                                    selectedAlasan = alasans;
                                                  },
                                                  onResult: (finalResult) {
                                                    Navigator.push(
                                                        context,
                                                        MyCustomRoute(
                                                            builder: (context) =>
                                                                FormSedikitLagi()));
                                                  },
                                                );
                                              },
                                            );
                                          },
                                        ),
                                      ),
                                      alignment: Alignment(0.0, 0.0),
                                    ),
                                    Container(
                                      child: ButtonTheme(
                                        minWidth: 50.0,
                                        height: 50.0,
                                        child: RaisedButton(
                                          shape: new RoundedRectangleBorder(
                                              borderRadius:
                                              new BorderRadius.circular(
                                                  5.0),
                                              side: BorderSide(
                                                  width: 1.5,
                                                  color: Colors.white)),
                                          child: Text(
                                            '2',
                                            style: TextStyle(
                                                fontSize: 18.0,
                                                color: Colors.white),
                                            textAlign: TextAlign.center,
                                          ),
                                          color:
                                          Color.fromARGB(170, 50, 205, 50),
                                          onPressed: () {
                                            Navigator.push(
                                                context,
                                                MyCustomRoute(
                                                    builder: (context) =>
                                                        FormSedikitLagi()));
                                          },
                                        ),
                                      ),
                                      alignment: Alignment(0.0, 0.0),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                          Container(
                            color: Colors.white,
                            padding: EdgeInsets.symmetric(
                                horizontal: 20.0, vertical: 10.0),
                            child: Text(
                                'Berikan ucapan undangan kepada customer .'),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        bottomNavigationBar: _bottomBar(),
      ),
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
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
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
        'assets/images/logo.png',
        height: 100.0,
        width: 120.0,
      ),
    );
  }
}

class FormSedikitLagi extends StatefulWidget {
  @override
  _FormSedikitLagiState createState() => _FormSedikitLagiState();
}

class _FormSedikitLagiState extends State<FormSedikitLagi> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AbubaAppBar(),
        body: _buildMenu(),
      ),
    );
  }

  Widget _buildMenu() {
    return ListView(
      children: <Widget>[
        Container(
          height: 390.0,
          width: MediaQuery.of(context).size.width,
          color: Colors.white,
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'Mystery Shopper',
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
                        'Location',
                        style: TextStyle(
                            color: AbubaPallate.greenabuba, fontSize: 12.0),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(20.0, 100.0, 20.0, 20.0),
                child: Column(
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Flexible(
                          child: Text(
                            'Sedikit Lagi',
                            style: TextStyle(
                                color: AbubaPallate.greenabuba,
                                fontWeight: FontWeight.w700,
                                fontSize: 20.0),
                          ),
                        )
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Flexible(
                          child: Text(
                            'Perhatikan suasana outlet, focus pada kerapihan, kebersihan dan kenyamanan',
                            style: TextStyle(
                                fontSize: 14.0, color: Colors.black54),
                            textAlign: TextAlign.center,
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 30.0,
                    ),
                    ButtonTheme(
                      minWidth: 50.0,
                      height: 40.0,
                      child: RaisedButton(
                        shape: new RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(5.0),
                        ),
                        child: Text(
                          'CONFIRM',
                          style: TextStyle(fontSize: 13.0, color: Colors.white),
                        ),
                        color: Colors.blue,
                        onPressed: () {
                          Navigator.push(
                              context,
                              MyCustomRoute(
                                  builder: (context) => FormTableSetting()));
                        },
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
        Container(
          child: Image.asset(
            'assets/images/slide 23.png',
            fit: BoxFit.fitWidth,
          ),
        )
      ],
    );
  }
}

class FormTableSetting extends StatefulWidget {
  @override
  _FormTableSettingState createState() => _FormTableSettingState();
}

class _FormTableSettingState extends State<FormTableSetting> with TickerProviderStateMixin {
  List<Map> _listData = [
    {'nomor': '11'},
    {'nomor': '12'},
    {'nomor': '13'}
  ];

  List<String> textList = [
    'Menu Baru',
    'Event',
    'Upselling',
    'Hasil Audit',
    'Pengumuman',
  ];

  List<String> isiCheckbox = [
    'Apakah organisasi sudah menetapkan internal dan eksternal isu yang berpengaruh terhadap kelangsungan organisasi?',
    '',
    '',
  ];
  List<String> valueCheckbox = ['1', '2', '3'];
  List<String> selectedValue = [];
  List<String> selectedAlasan = [];

  bool _value1 = false;
  bool _value2 = false;
  bool _value3 = false;
  bool _value4 = false;
  bool _value5 = false;

  //we omitted the brackets '{}' and are using fat arrow '=>' instead, this is dart syntax
  void _value1Changed(bool value) => setState(() => _value1 = value);
  void _value2Changed(bool value) => setState(() => _value2 = value);
  void _value3Changed(bool value) => setState(() => _value3 = value);
  void _value4Changed(bool value) => setState(() => _value4 = value);
  void _value5Changed(bool value) => setState(() => _value5 = value);

  TabController _cardController;

  @override
  void initState() {
    super.initState();
    _cardController = new TabController(vsync: this, length: _listData.length);
  }

  @override
  void dispose() {
    _cardController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: _appBar(),
        body: GestureDetector(
          onTap: () {
            FocusScope.of(context).requestFocus(FocusNode());
          },
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  child: TabBarView(
                    controller: _cardController,
                    physics: ScrollPhysics(),
                    children: <Widget>[
                      ListView(
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
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 10.0),
                                        child: Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            Text(
                                              '1. Table Setting',
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 14.0),
                                              textAlign: TextAlign.start,
                                            ),
                                            Text(
                                              '1 of ${_listData.length.toString()}',
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 14.0),
                                              textAlign: TextAlign.start,
                                            ),
                                          ],
                                        ),
                                      ),
                                      decoration: BoxDecoration(
                                          color: Color(0xFF2F592F))),
                                ),
                              ],
                            ),
                          ),
                          Stack(
                            children: <Widget>[
                              Image.asset(
                                'assets/images/abuba3.jpg',
                                fit: BoxFit.cover,
                                height: MediaQuery.of(context).size.height /
                                    1.50777,
                              ),
                              Positioned(
                                bottom: 20.0,
                                width: MediaQuery.of(context).size.width,
                                child: Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceAround,
                                  children: <Widget>[
                                    Container(
                                      child: ButtonTheme(
                                        minWidth: 50.0,
                                        height: 50.0,
                                        child: RaisedButton(
                                          shape: new RoundedRectangleBorder(
                                              borderRadius:
                                              new BorderRadius.circular(
                                                  5.0),
                                              side: BorderSide(
                                                  width: 1.5,
                                                  color: Colors.white)),
                                          child: Text(
                                            '0',
                                            style: TextStyle(
                                                fontSize: 18.0,
                                                color: Colors.white),
                                            textAlign: TextAlign.center,
                                          ),
                                          color:
                                          Color.fromARGB(170, 255, 40, 0),
                                          onPressed: () {
                                            showDialog(
                                              barrierDismissible: false,
                                              context: context,
                                              builder: (context) {
                                                return Checkbox(
                                                  alasan: isiCheckbox,
                                                  valueCheck: valueCheckbox,
                                                  selectedAlasan:
                                                  selectedAlasan,
                                                  selectedValue: selectedValue,
                                                  onSelectedAlasanListChanged:
                                                      (alasans) {
                                                    selectedAlasan = alasans;
                                                  },
                                                  onResult: (finalResult) {
                                                    _cardController.animateTo(
                                                        _cardController.index +
                                                            1);
                                                  },
                                                );
                                              },
                                            );
                                          },
                                        ),
                                      ),
                                      alignment: Alignment(0.0, 0.0),
                                    ),
                                    Container(
                                      padding:
                                      EdgeInsets.symmetric(horizontal: 5.0),
                                      child: ButtonTheme(
                                        minWidth: 50.0,
                                        height: 50.0,
                                        child: RaisedButton(
                                          shape: new RoundedRectangleBorder(
                                              borderRadius:
                                              new BorderRadius.circular(
                                                  5.0),
                                              side: BorderSide(
                                                  width: 1.5,
                                                  color: Colors.white)),
                                          child: Text(
                                            '1',
                                            style: TextStyle(
                                                fontSize: 18.0,
                                                color: Colors.white),
                                            textAlign: TextAlign.center,
                                          ),
                                          color: Color.fromARGB(
                                              170, 192, 192, 192),
                                          onPressed: () {
                                            showDialog(
                                              barrierDismissible: false,
                                              context: context,
                                              builder: (context) {
                                                return Checkbox(
                                                  alasan: isiCheckbox,
                                                  valueCheck: valueCheckbox,
                                                  selectedAlasan:
                                                  selectedAlasan,
                                                  selectedValue: selectedValue,
                                                  onSelectedAlasanListChanged:
                                                      (alasans) {
                                                    selectedAlasan = alasans;
                                                  },
                                                  onResult: (finalResult) {
                                                    _cardController.animateTo(
                                                        _cardController.index +
                                                            1);
                                                  },
                                                );
                                              },
                                            );
                                          },
                                        ),
                                      ),
                                      alignment: Alignment(0.0, 0.0),
                                    ),
                                    Container(
                                      child: ButtonTheme(
                                        minWidth: 50.0,
                                        height: 50.0,
                                        child: RaisedButton(
                                          shape: new RoundedRectangleBorder(
                                              borderRadius:
                                              new BorderRadius.circular(
                                                  5.0),
                                              side: BorderSide(
                                                  width: 1.5,
                                                  color: Colors.white)),
                                          child: Text(
                                            '2',
                                            style: TextStyle(
                                                fontSize: 18.0,
                                                color: Colors.white),
                                            textAlign: TextAlign.center,
                                          ),
                                          color:
                                          Color.fromARGB(170, 50, 205, 50),
                                          onPressed: () {
                                            _cardController.animateTo(
                                                _cardController.index + 1);
                                          },
                                        ),
                                      ),
                                      alignment: Alignment(0.0, 0.0),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                          Container(
                            color: Colors.white,
                            padding: EdgeInsets.symmetric(
                                horizontal: 20.0, vertical: 10.0),
                            child: Center(
                              child: Text(
                                  'Berikan ucapan undangan kepada customer untuk datang kembali'),
                            ),
                          )
                        ],
                      ),
                      ListView(
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
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 10.0),
                                        child: Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            Text(
                                              '2. Kebersihan dan Kerapihan Outlet',
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 14.0),
                                              textAlign: TextAlign.start,
                                            ),
                                            Text(
                                              '2 of ${_listData.length.toString()}',
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 14.0),
                                              textAlign: TextAlign.start,
                                            ),
                                          ],
                                        ),
                                      ),
                                      decoration: BoxDecoration(
                                          color: Color(0xFF2F592F))),
                                ),
                              ],
                            ),
                          ),
                          Stack(
                            children: <Widget>[
                              Image.asset(
                                'assets/images/abuba2.jpg',
                                fit: BoxFit.cover,
                                height: MediaQuery.of(context).size.height /
                                    1.50777,
                              ),
                              Positioned(
                                bottom: 20.0,
                                width: MediaQuery.of(context).size.width,
                                child: Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceAround,
                                  children: <Widget>[
                                    Container(
                                      child: ButtonTheme(
                                        minWidth: 50.0,
                                        height: 50.0,
                                        child: RaisedButton(
                                          shape: new RoundedRectangleBorder(
                                              borderRadius:
                                              new BorderRadius.circular(
                                                  5.0),
                                              side: BorderSide(
                                                  width: 1.5,
                                                  color: Colors.white)),
                                          child: Text(
                                            '0',
                                            style: TextStyle(
                                                fontSize: 18.0,
                                                color: Colors.white),
                                            textAlign: TextAlign.center,
                                          ),
                                          color:
                                          Color.fromARGB(170, 255, 40, 0),
                                          onPressed: () {
                                            showDialog(
                                              barrierDismissible: false,
                                              context: context,
                                              builder: (context) {
                                                return Checkbox(
                                                  alasan: isiCheckbox,
                                                  valueCheck: valueCheckbox,
                                                  selectedAlasan:
                                                  selectedAlasan,
                                                  selectedValue: selectedValue,
                                                  onSelectedAlasanListChanged:
                                                      (alasans) {
                                                    selectedAlasan = alasans;
                                                  },
                                                  onResult: (finalResult) {
                                                    _cardController.animateTo(
                                                        _cardController.index +
                                                            1);
                                                  },
                                                );
                                              },
                                            );
                                          },
                                        ),
                                      ),
                                      alignment: Alignment(0.0, 0.0),
                                    ),
                                    Container(
                                      padding:
                                      EdgeInsets.symmetric(horizontal: 5.0),
                                      child: ButtonTheme(
                                        minWidth: 50.0,
                                        height: 50.0,
                                        child: RaisedButton(
                                          shape: new RoundedRectangleBorder(
                                              borderRadius:
                                              new BorderRadius.circular(
                                                  5.0),
                                              side: BorderSide(
                                                  width: 1.5,
                                                  color: Colors.white)),
                                          child: Text(
                                            '1',
                                            style: TextStyle(
                                                fontSize: 18.0,
                                                color: Colors.white),
                                            textAlign: TextAlign.center,
                                          ),
                                          color: Color.fromARGB(
                                              170, 192, 192, 192),
                                          onPressed: () {
                                            showDialog(
                                              barrierDismissible: false,
                                              context: context,
                                              builder: (context) {
                                                return Checkbox(
                                                  alasan: isiCheckbox,
                                                  valueCheck: valueCheckbox,
                                                  selectedAlasan:
                                                  selectedAlasan,
                                                  selectedValue: selectedValue,
                                                  onSelectedAlasanListChanged:
                                                      (alasans) {
                                                    selectedAlasan = alasans;
                                                  },
                                                  onResult: (finalResult) {
                                                    _cardController.animateTo(
                                                        _cardController.index +
                                                            1);
                                                  },
                                                );
                                              },
                                            );
                                          },
                                        ),
                                      ),
                                      alignment: Alignment(0.0, 0.0),
                                    ),
                                    Container(
                                      child: ButtonTheme(
                                        minWidth: 50.0,
                                        height: 50.0,
                                        child: RaisedButton(
                                          shape: new RoundedRectangleBorder(
                                              borderRadius:
                                              new BorderRadius.circular(
                                                  5.0),
                                              side: BorderSide(
                                                  width: 1.5,
                                                  color: Colors.white)),
                                          child: Text(
                                            '2',
                                            style: TextStyle(
                                                fontSize: 18.0,
                                                color: Colors.white),
                                            textAlign: TextAlign.center,
                                          ),
                                          color:
                                          Color.fromARGB(170, 50, 205, 50),
                                          onPressed: () {
                                            _cardController.animateTo(
                                                _cardController.index + 1);
                                          },
                                        ),
                                      ),
                                      alignment: Alignment(0.0, 0.0),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                          Container(
                            color: Colors.white,
                            padding: EdgeInsets.symmetric(
                                horizontal: 20.0, vertical: 10.0),
                            child: Center(
                              child: Text(
                                  'Cleaning/clearing tables harus dilakukan maksimal 1 menit.'),
                            ),
                          )
                        ],
                      ),
                      ListView(
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
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 10.0),
                                        child: Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            Text(
                                              '3. Kenyamanan suasana outlet',
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 14.0),
                                              textAlign: TextAlign.start,
                                            ),
                                            Text(
                                              '3 of ${_listData.length.toString()}',
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 14.0),
                                              textAlign: TextAlign.start,
                                            ),
                                          ],
                                        ),
                                      ),
                                      decoration: BoxDecoration(
                                          color: Color(0xFF2F592F))),
                                ),
                              ],
                            ),
                          ),
                          Stack(
                            children: <Widget>[
                              Image.asset(
                                'assets/images/abuba1.jpg',
                                fit: BoxFit.fitHeight,
                                height: MediaQuery.of(context).size.height /
                                    1.50777,
                              ),
                              Positioned(
                                bottom: 20.0,
                                width: MediaQuery.of(context).size.width,
                                child: Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceAround,
                                  children: <Widget>[
                                    Container(
                                      child: ButtonTheme(
                                        minWidth: 50.0,
                                        height: 50.0,
                                        child: RaisedButton(
                                          shape: new RoundedRectangleBorder(
                                              borderRadius:
                                              new BorderRadius.circular(
                                                  5.0),
                                              side: BorderSide(
                                                  width: 1.5,
                                                  color: Colors.white)),
                                          child: Text(
                                            '0',
                                            style: TextStyle(
                                                fontSize: 18.0,
                                                color: Colors.white),
                                            textAlign: TextAlign.center,
                                          ),
                                          color:
                                          Color.fromARGB(170, 255, 40, 0),
                                          onPressed: () {
                                            showDialog(
                                              barrierDismissible: false,
                                              context: context,
                                              builder: (context) {
                                                return Checkbox(
                                                  alasan: isiCheckbox,
                                                  valueCheck: valueCheckbox,
                                                  selectedAlasan:
                                                  selectedAlasan,
                                                  selectedValue: selectedValue,
                                                  onSelectedAlasanListChanged:
                                                      (alasans) {
                                                    selectedAlasan = alasans;
                                                  },
                                                  onResult: (finalResult) {
                                                    Navigator.push(
                                                        context,
                                                        MyCustomRoute(
                                                            builder: (context) =>
                                                                FormCheckOut()));
                                                  },
                                                );
                                              },
                                            );
                                          },
                                        ),
                                      ),
                                      alignment: Alignment(0.0, 0.0),
                                    ),
                                    Container(
                                      padding:
                                      EdgeInsets.symmetric(horizontal: 5.0),
                                      child: ButtonTheme(
                                        minWidth: 50.0,
                                        height: 50.0,
                                        child: RaisedButton(
                                          shape: new RoundedRectangleBorder(
                                              borderRadius:
                                              new BorderRadius.circular(
                                                  5.0),
                                              side: BorderSide(
                                                  width: 1.5,
                                                  color: Colors.white)),
                                          child: Text(
                                            '1',
                                            style: TextStyle(
                                                fontSize: 18.0,
                                                color: Colors.white),
                                            textAlign: TextAlign.center,
                                          ),
                                          color: Color.fromARGB(
                                              170, 192, 192, 192),
                                          onPressed: () {
                                            showDialog(
                                              barrierDismissible: false,
                                              context: context,
                                              builder: (context) {
                                                return Checkbox(
                                                  alasan: isiCheckbox,
                                                  valueCheck: valueCheckbox,
                                                  selectedAlasan:
                                                  selectedAlasan,
                                                  selectedValue: selectedValue,
                                                  onSelectedAlasanListChanged:
                                                      (alasans) {
                                                    selectedAlasan = alasans;
                                                  },
                                                  onResult: (finalResult) {
                                                    Navigator.push(
                                                        context,
                                                        MyCustomRoute(
                                                            builder: (context) =>
                                                                FormCheckOut()));
                                                  },
                                                );
                                              },
                                            );
                                          },
                                        ),
                                      ),
                                      alignment: Alignment(0.0, 0.0),
                                    ),
                                    Container(
                                      child: ButtonTheme(
                                        minWidth: 50.0,
                                        height: 50.0,
                                        child: RaisedButton(
                                          shape: new RoundedRectangleBorder(
                                              borderRadius:
                                              new BorderRadius.circular(
                                                  5.0),
                                              side: BorderSide(
                                                  width: 1.5,
                                                  color: Colors.white)),
                                          child: Text(
                                            '2',
                                            style: TextStyle(
                                                fontSize: 18.0,
                                                color: Colors.white),
                                            textAlign: TextAlign.center,
                                          ),
                                          color:
                                          Color.fromARGB(170, 50, 205, 50),
                                          onPressed: () {
                                            Navigator.push(
                                                context,
                                                MyCustomRoute(
                                                    builder: (context) =>
                                                        FormCheckOut()));
                                          },
                                        ),
                                      ),
                                      alignment: Alignment(0.0, 0.0),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                          Container(
                            color: Colors.white,
                            padding: EdgeInsets.symmetric(
                                horizontal: 20.0, vertical: 10.0),
                            child: Text(
                                'Berikan ucapan undangan kepada customer .'),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        bottomNavigationBar: _bottomBar(),
      ),
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
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
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
        'assets/images/logo.png',
        height: 100.0,
        width: 120.0,
      ),
    );
  }
}

class FormCheckOut extends StatefulWidget {
  @override
  _FormCheckOutState createState() => _FormCheckOutState();
}

class _FormCheckOutState extends State<FormCheckOut> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AbubaAppBar(),
        body: _buildMenu(context),
      ),
    );
  }

  Widget _buildMenu(context) {
    return Scrollbar(
      child: ListView(
        children: <Widget>[
          Container(
            height: 400.0,
            width: MediaQuery.of(context).size.width,
            color: Colors.white,
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        'Mystery Shopper',
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
                          'Location',
                          style: TextStyle(
                              color: AbubaPallate.greenabuba, fontSize: 12.0),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(20.0, 100.0, 20.0, 20.0),
                  child: Column(
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Flexible(
                            child: Text(
                              'Terima Kasih',
                              style: TextStyle(
                                  color: AbubaPallate.greenabuba,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 20.0),
                            ),
                          )
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Flexible(
                            child: Text(
                              'Review Anda akan secara otomatis diolah oleh system kami untuk bahan masukan management Abuba. Hati Hati di jalan !',
                              style: TextStyle(
                                  fontSize: 14.0, color: Colors.black54),
                              textAlign: TextAlign.center,
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 30.0,
                      ),
                      ButtonTheme(
                        minWidth: 50.0,
                        height: 40.0,
                        child: RaisedButton(
                          shape: new RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(5.0)),
                          child: Text(
                            'CHECK OUT',
                            style:
                            TextStyle(fontSize: 13.0, color: Colors.white),
                          ),
                          color: Colors.red,
                          onPressed: () {},
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
          Container(
            child: Image.asset(
              'assets/images/slide2.png',
              fit: BoxFit.fitWidth,
            ),
          )
        ],
      ),
    );
  }
}
