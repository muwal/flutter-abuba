import 'dart:async';
import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_abuba/misteri_shop/report/detail_report.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';

import 'package:flutter/material.dart';
import 'package:flutter_abuba/constant.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_abuba/misteri_shop/outlet/grid_data_search.dart';

class CheckboxDua extends StatefulWidget {
  CheckboxDua({
    this.alasan,
    this.selectedAlasan,
    this.selectedValue,
    this.selectedStdValue,
    this.actTime,
    this.stdTime,
    this.onSelectedAlasanListChanged,
    this.valueCheck,
    this.valueStdCheck,
    this.onResult,
    this.onSelectedActTime,
    this.onSelectedStdTime,
  });

  final List<String> alasan;
  final List<String> valueCheck;
  final List<dynamic> valueStdCheck;
  final List<String> selectedAlasan;
  final List<String> selectedValue;
  final List<dynamic> selectedStdValue;
  final List<dynamic> actTime;
  final List<dynamic> stdTime;
  final ValueChanged<List<String>> onSelectedAlasanListChanged;
  final ValueChanged<List<String>> onResult;
  final ValueChanged<List<dynamic>> onSelectedActTime;
  final ValueChanged<List<dynamic>> onSelectedStdTime;

  @override
  _CheckboxDuaState createState() => new _CheckboxDuaState();
}

class _CheckboxDuaState extends State<CheckboxDua> {
  List<String> _tempSelectedAlasan = [];
  List<String> _tempSelectedValueAlasan = [];
  List<dynamic> _tempActTime = [];
  List<dynamic> _tempStdTime = [];
  double height = 300.0;

  @override
  void initState() {
    _tempSelectedAlasan = widget.selectedAlasan;
    _tempSelectedValueAlasan = widget.selectedValue;
    _tempActTime = widget.actTime;
    _tempStdTime = widget.stdTime;
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
                    final StdValue = widget.valueStdCheck[index];

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
                                _tempStdTime.add(StdValue);
                                _tempActTime.add(null);
                                },
                              );
                            }
                          } else {
                            if (_tempSelectedAlasan.contains(AlasanValue)) {
                              setState(() {
                                _tempStdTime.removeAt(_tempSelectedAlasan.indexOf(AlasanValue));
                                _tempSelectedValueAlasan.removeWhere((String city) => city == ValueFinal);
                                _tempSelectedAlasan.removeWhere((String city) => city == AlasanValue);
                                _tempActTime.removeLast();
                                },
                              );
                            }
                          }
                          widget.onSelectedAlasanListChanged(_tempSelectedValueAlasan);
                          widget.onSelectedActTime(_tempActTime);
                          widget.onSelectedStdTime(_tempStdTime);
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
  var index;
  final String aksesStatus;
  FormSuasanaResto({this.outlet, this.imageOutlet, this.alamatOutlet, this.idOutlet, this.idUser, this.idMysteryGuest, this.index, this.aksesStatus});

  @override
  _FormSuasanaRestoState createState() => _FormSuasanaRestoState();
}

class _FormSuasanaRestoState extends State<FormSuasanaResto> with TickerProviderStateMixin{
  AnimationController animationController;

  String get timerString {
    Duration duration = animationController.duration * animationController.value;
    return '${(duration.inSeconds % 60).toString()}';
  }

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(vsync: this, duration: Duration(seconds: 6));
    animationController.reverse(
      from: animationController.value == 0.0
        ? 1.0
        : animationController.value
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          elevation: 0.25,
          backgroundColor: Colors.white,
          iconTheme: IconThemeData(color: Colors.black),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Image.asset(
                'assets/images/logo2.png',
                height: 150.0,
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
        ),
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
                          AnimatedBuilder(
                            animation: animationController,
                            builder: (_, Widget child) {
                              return animationController.isAnimating
                                ? ButtonTheme(
                                    minWidth: 50.0,
                                    height: 40.0,
                                    child: RaisedButton(
                                      shape: new RoundedRectangleBorder(
                                          borderRadius: new BorderRadius.circular(5.0)),
                                      child: Text(
                                        timerString,
                                        style: TextStyle(
                                          fontSize: 18.0,
                                          color: Colors.black
                                        ),
                                      ),
                                      color: Colors.white,
                                      elevation: 0.0,
                                      onPressed: () {},
                                    ),
                                  )
                                : ButtonTheme(
                                    minWidth: 50.0,
                                    height: 40.0,
                                    child: RaisedButton(
                                      shape: new RoundedRectangleBorder(
                                          borderRadius: new BorderRadius.circular(5.0)),
                                      child: Text(
                                        'PAHAM',
                                        style: TextStyle(
                                          fontSize: 13.0,
                                          color: Colors.white
                                        ),
                                      ),
                                      color: Colors.blueAccent,
                                      onPressed: () {
                                        if (animationController.isAnimating) {

                                        } else {
                                          Navigator.push(context,
                                            MyCustomRoute(
                                              builder: (context) => FormTakingOrder(idOutlet: widget.idOutlet,alamatOutlet: widget.alamatOutlet,outlet: widget.outlet,imageOutlet: widget.imageOutlet,idUser: widget.idUser, idMysteryGuest: widget.idMysteryGuest, index: widget.index, aksesStatus: widget.aksesStatus)
                                            )
                                          );
                                        }
                                      },
                                    ),
                                  );
                            }
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
}

class FormTakingOrder extends StatefulWidget {
  final String outlet;
  final int idOutlet;
  final String imageOutlet;
  final String alamatOutlet;
  final int idUser;
  final int idMysteryGuest;
  var index;
  final String aksesStatus;
  FormTakingOrder(
      {this.outlet, this.imageOutlet, this.alamatOutlet, this.idOutlet, this.idUser, this.idMysteryGuest, this.index, this.aksesStatus});

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

  List<String> isiCheckbox = ['Drink','Juice','Appetizer','Main Course','Dessert', 'Salad'];
  List<String> valueCheckbox = ['Drink','Juice','Appetizer','Main Course','Dessert', 'Salad'];
  List<dynamic> stdCheckbox = [];
  List<String> selectedValue = [];
  List<String> selectedAlasan = [];
  List<String> selectedStd = [];
  List<dynamic> act_time = [];
  List<String> actTimeMinutes = [];
  List<dynamic> std_time = [];
  bool nextButton = false;
  bool nextButton2 = false;
  List<double> bobotPertanyaan = [];
  double hasilServingTime = 0.0;
  double finalServingTime = 0.0;

  TabController _cardController;
  DateTime orderStart = DateTime.now();

  Stopwatch watch = Stopwatch();
  Timer timer;
  String elapsedTime = '';
  List<String> orderTimeDone = [];
  List<int> score = [];

  List<int> menuID = [];
  List<dynamic> menuName = [];

  AnimationController animationController;

  updateTime(Timer timer) {
    setState(() {
      elapsedTime = transformMilliSeconds(watch.elapsedMilliseconds);
    });
  }

  startWatch() {
    watch.start();
    timer = Timer.periodic(Duration(milliseconds: 100), updateTime);
  }

  transformMilliSeconds(int milliseconds) {
    int hundreds = (milliseconds / 10).truncate();
    int seconds = (hundreds / 100).truncate();
    int minutes = (seconds / 60).truncate();
    int hours = (minutes / 60).truncate();

    String hoursStr = (hours % 60).toString().padLeft(2, '0');
    String minutesStr = (minutes % 60).toString().padLeft(2, '0');
    String secondsStr = (seconds % 60).toString().padLeft(2, '0');

    return "$hoursStr:$minutesStr:$secondsStr";
  }

  @override
  void initState() {
    super.initState();
    _cardController = new TabController(vsync: this, length: _listData.length);

    animationController = AnimationController(vsync: this, duration: Duration(seconds: 3));
    animationController.reverse(
      from: animationController.value == 0.0
        ? 1.0
        : animationController.value
    );
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
                        physics: NeverScrollableScrollPhysics(),
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
                                fit: BoxFit.fitHeight,
                                // height: MediaQuery.of(context).size.height - 110.0,
                                height: MediaQuery.of(context).size.height,
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
                                      onPressed: () async {
                                        Firestore.instance.collection('servingTime').snapshots().listen((data) {
                                          setState(() {
                                            stdCheckbox.add(data.documents[0].data['drinks']);
                                            stdCheckbox.add(data.documents[0].data['juice']);
                                            stdCheckbox.add(data.documents[0].data['appetizer']);
                                            stdCheckbox.add(data.documents[0].data['mainCourse']);
                                            stdCheckbox.add(data.documents[0].data['dessert']);
                                            stdCheckbox.add(data.documents[0].data['salad']);
                                          });
                                        });
                                        await new Future.delayed(Duration(
                                          seconds: 2
                                        ));
                                        showDialog(
                                          context: context,
                                          barrierDismissible: false,
                                          builder: (BuildContext context) {
                                            return CheckboxDua(
                                              alasan: isiCheckbox,
                                              valueCheck: valueCheckbox,
                                              valueStdCheck: stdCheckbox,
                                              selectedAlasan: selectedAlasan,
                                              selectedValue: selectedValue,
                                              selectedStdValue: selectedStd,
                                              onSelectedAlasanListChanged: (alasans) {
                                                selectedAlasan = alasans;
                                              },
                                              onSelectedActTime: (actTimes) {
                                                act_time = actTimes;
                                              },
                                              onSelectedStdTime: (stdTimes) {
                                                std_time = stdTimes;
                                              },
                                              stdTime: std_time,
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
                                                    double bobotPertanyaanOrderList = 1 / selectedAlasan.length;
                                                    String bantuBobotPertanyaanOrderList;
                                                    if (selectedAlasan.length == 6) {
                                                      bantuBobotPertanyaanOrderList = '0.16';
                                                    } else {
                                                      bantuBobotPertanyaanOrderList =  bobotPertanyaanOrderList.toString().substring(0, 3);
                                                    }
                                                    for (int a = 0; a < selectedAlasan.length; a++) {
                                                      bobotPertanyaan.add(double.tryParse(bantuBobotPertanyaanOrderList));
                                                      orderTimeDone.add(null);
                                                      score.add(null);
                                                      menuID.add(null);
                                                      menuName.add(null);
                                                    }
                                                    DocumentReference docReference = Firestore.instance.collection('mystery_shopper').document(widget.index);

                                                    docReference.updateData({
                                                      'orderTime_start': orderStart,
                                                      'order': selectedAlasan,
                                                      'actTime': act_time,
                                                      'bobot': 10,
                                                      'stdTime': std_time,
                                                      'bobot_pertanyaan': bobotPertanyaan,
                                                    }).then((doc) {
                                                      _cardController.animateTo(_cardController.index + 1);
                                                    }).catchError((error) {
                                                      print(error);
                                                    });
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
                                              'Taking Order',
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
                          Expanded(
                            child: ListView(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              children: <Widget>[
                                AnimatedBuilder(
                                  animation: animationController,
                                  builder: (_, Widget child) {
                                    return animationController.isAnimating
                                      ? Container(
                                          child: Center(
                                            child: CircularProgressIndicator(),
                                          ),
                                        )
                                      : Container(
                                          padding: EdgeInsets.all(15.0),
                                          width: double.infinity,
                                          child: Column(
                                            children: List.generate(selectedAlasan.length, (index) {
                                              return Column(
                                                children: <Widget>[
                                                  StreamBuilder(
                                                    stream: Firestore.instance.collection('product_complaint-mg').where('category', isEqualTo: selectedAlasan[index]).snapshots(),
                                                    builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                                                      if (!snapshot.hasData)
                                                        return Container(
                                                          child: Center(
                                                            child:CircularProgressIndicator()
                                                          )
                                                        );

                                                      return DropdownButtonFormField<String>(
                                                        decoration: InputDecoration(
                                                          labelText: selectedAlasan[index],
                                                          labelStyle: TextStyle(fontSize: 16.0),
                                                        ),
                                                        validator: (value) {
                                                          if (value == null) {
                                                            return 'Please select product';
                                                          } else {
                                                            return null;
                                                          }
                                                        },
                                                        value: menuID[index] == null ? null : menuID[index].toString(),
                                                        onChanged: (String value) {
                                                          Firestore.instance.collection('product_complaint-mg').where('id', isEqualTo: int.tryParse(value)).snapshots().listen((data) {
                                                            setState(() {
                                                              menuID.removeAt(index);
                                                              menuID.insert(index, data.documents[0].data['id']);
                                                              menuName.removeAt(index);
                                                              menuName.insert(index, data.documents[0].data['product']);

                                                              if (menuID.contains(null) || menuName.contains(null)) {

                                                              } else {
                                                                setState(() {
                                                                  nextButton2 = true;
                                                                });
                                                              }
                                                            });
                                                          });
                                                        },
                                                        items: snapshot.data.documents.map((DocumentSnapshot document) {
                                                          return DropdownMenuItem(
                                                            value: document['id'].toString(),
                                                            child: Padding(
                                                              padding: EdgeInsets.all(10.0),
                                                              child: RichText(
                                                                overflow: TextOverflow.visible,
                                                                text: TextSpan(
                                                                  text: document['product'].toString(),
                                                                  style: TextStyle(
                                                                    color: Colors.black,
                                                                    fontSize: 14.0
                                                                  )
                                                                ),
                                                              ),
                                                            ),
                                                          );
                                                        }).toList()
                                                      );
                                                    },
                                                  )
                                                ],
                                              );
                                            }).toList(),
                                          )
                                        );
                                  },
                                )
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
                                          nextButton2
                                            ? Container()
                                            : Flexible(
                                                child: Text(
                                                  '',
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontStyle: FontStyle.italic,
                                                  ),
                                                ),
                                              ),
                                          nextButton2
                                            ? IconButton(
                                                tooltip: 'Next Step',
                                                icon: Icon(Icons.navigate_next, color: Colors.white, size: 28.0),
                                                onPressed: () {
                                                  if (menuID.contains(null) || menuName.contains(null)) {

                                                  } else {
                                                    DocumentReference docReference = Firestore.instance.collection('mystery_shopper').document(widget.index);

                                                    docReference.updateData({
                                                      'menuID': menuID,
                                                      'menuName': menuName
                                                    }).then((doc) {
                                                      startWatch();
                                                      _cardController.animateTo(_cardController.index + 1);
                                                    }).catchError((error) {
                                                      print(error);
                                                    });
                                                  }
                                                },
                                              )
                                            : Container(),
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
                              physics: NeverScrollableScrollPhysics(),
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.all(20.0),
                                  child: Center(
                                    child: Text(
                                      elapsedTime,
                                      style: TextStyle(
                                        fontSize: 30.0
                                      ),
                                    ),
                                  ),
                                ),
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
                                        stream: Firestore.instance.collection('mystery_shopper').document(widget.index).snapshots(),
                                        builder: (context, snapshot) {
                                          if (!snapshot.hasData && snapshot.data == null)
                                            return Container(
                                              child: Center(
                                                child: CircularProgressIndicator(),
                                              ),
                                            );

                                          var document = snapshot.data;
                                          return Column(
                                            children: List.generate(document['order'].length, (index) {
                                              return Column(
                                                children: <Widget>[
                                                  Row(
                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                    children: <Widget>[
                                                      Container(
                                                        alignment: Alignment.center,
                                                        width: 100.0,
                                                        child: Column(
                                                          children: <Widget>[
                                                            RichText(
                                                              textAlign: TextAlign.start,
                                                              overflow: TextOverflow.ellipsis,
                                                              text: TextSpan(
                                                                text: document['order'][index],
                                                                style: TextStyle(
                                                                  color: Colors.black38,
                                                                  fontWeight: FontWeight.w700,
                                                                  fontSize: 13.0
                                                                )
                                                              ),
                                                            ),
                                                            RichText(
                                                              overflow: TextOverflow.ellipsis,
                                                              text: TextSpan(
                                                                text: menuName[index],
                                                                style: TextStyle(
                                                                  color: Colors.black38,
                                                                  fontSize: 12.0
                                                                )
                                                              ),
                                                            )
                                                          ],
                                                        )
                                                      ),
                                                      Flexible(
                                                        child: Container(
                                                          width: 100.0,
                                                          child: Column(
                                                            children: <Widget>[
                                                              Text(
                                                                'Std ${document['stdTime'][index]}',
                                                                textAlign: TextAlign.center,
                                                                style: TextStyle(
                                                                  color: Colors.black54,
                                                                  fontSize: 14.0),
                                                              ),
                                                              Text(
                                                                document['actTime'][index] == null
                                                                  ? 'Act -'
                                                                  : 'Act ${orderTimeDone[index]}',
                                                                textAlign: TextAlign.center,
                                                                style: TextStyle(
                                                                  color: Colors.black54,
                                                                  fontSize: 14.0),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                      document['actTime'][index] == null
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
                                                                  String standar = document['stdTime'][index];
                                                                  List<String> standarSplit = standar.split(':');
                                                                  int standarSecond = (int.tryParse(standarSplit[0]) * 60) + (int.tryParse(standarSplit[1]));
                                                                  List<String> orderTimeDoneSplit = elapsedTime.split(':');
                                                                  int actualSecond = (int.tryParse(orderTimeDoneSplit[0]) * 60) + (int.tryParse(orderTimeDoneSplit[1]) * 60) + (int.tryParse(orderTimeDoneSplit[2]));

                                                                  setState(() {
                                                                    if (actualSecond > standarSecond && actualSecond <= standarSecond + 120) {
                                                                      score.removeAt(index);
                                                                      score.insert(index, 1);
                                                                    } else if (actualSecond <= standarSecond) {
                                                                      score.removeAt(index);
                                                                      score.insert(index, 2);
                                                                    } else {
                                                                      score.removeAt(index);
                                                                      score.insert(index, 0);
                                                                    }
                                                                  });

                                                                  DateTime done = DateTime.now();
                                                                  setState(() {
                                                                    act_time.removeAt(index);
                                                                    act_time.insert(index, done);

                                                                    orderTimeDone.removeAt(index);
                                                                    orderTimeDone.insert(index, orderTimeDoneSplit[1]+':'+orderTimeDoneSplit[2]);
                                                                  });

                                                                  if (act_time.contains(null)) {

                                                                  } else {
                                                                    setState(() {
                                                                      nextButton = true;
                                                                    });
                                                                  }

                                                                  var initialDataNoTimestamp = <String, dynamic>{
                                                                    'actTime': act_time,
                                                                    'score': score,
                                                                    'orderTimeDone': orderTimeDone
                                                                  };
                                                                  DocumentReference docReference = Firestore.instance.collection('mystery_shopper').document(widget.index);
                                                                  docReference.updateData(initialDataNoTimestamp).then((doc) {
                                                                    print('success');
                                                                  }).catchError((error) {
                                                                    print(error);
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
                                          nextButton
                                            ? Container()
                                            : Flexible(
                                                child: Text(
                                                  '',
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontStyle: FontStyle.italic,
                                                  ),
                                                ),
                                              ),
                                          nextButton
                                            ? IconButton(
                                                tooltip: 'Next Step',
                                                icon: Icon(Icons.navigate_next, color: Colors.white, size: 28.0),
                                                onPressed: () {
                                                  if (score.contains(1) || score.contains(0)) {
                                                    for (int i = 0; i < bobotPertanyaan.length; i++) {
                                                      hasilServingTime += bobotPertanyaan[i] * score[i];
                                                    }
                                                    hasilServingTime = hasilServingTime / 2;
                                                    if (hasilServingTime > 1.0) {
                                                      hasilServingTime = 1.0;
                                                    } else {
                                                      hasilServingTime = hasilServingTime;
                                                    }
                                                  } else {
                                                    hasilServingTime = 1.0;
                                                  }

                                                  DocumentReference docReference = Firestore.instance.collection('mystery_shopper').document(widget.index);

                                                  docReference.updateData({
                                                    'hasilServingTime': hasilServingTime
                                                  }).then((doc) {
                                                    finalServingTime = hasilServingTime * 10.0;
                                                    watch.stop();
                                                    Navigator.push(context,
                                                      MaterialPageRoute(
                                                        builder: (context) => FormEnjoy(idOutlet: widget.idOutlet,alamatOutlet: widget.alamatOutlet,outlet: widget.outlet,imageOutlet: widget.imageOutlet,idUser: widget.idUser, idMysteryGuest: widget.idMysteryGuest, index: widget.index, finalServingTime: finalServingTime, aksesStatus: widget.aksesStatus)
                                                      )
                                                    );
                                                  }).catchError((error) {
                                                    print(error);
                                                  });
                                                },
                                              )
                                            : Container(),
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
}

class FormEnjoy extends StatefulWidget {
  final double finalServingTime;
  final String outlet;
  final int idOutlet;
  final String imageOutlet;
  final String alamatOutlet;
  final int idUser;
  final int idMysteryGuest;
  var index;
  final String aksesStatus;
  FormEnjoy(
      {this.outlet, this.imageOutlet, this.alamatOutlet, this.idOutlet, this.idUser, this.idMysteryGuest, this.index, this.finalServingTime, this.aksesStatus});

  @override
  _FormEnjoyState createState() => _FormEnjoyState();
}

class _FormEnjoyState extends State<FormEnjoy> with TickerProviderStateMixin {
  AnimationController animationController;

  String get timerString {
    Duration duration = animationController.duration * animationController.value;
    return '${(duration.inSeconds % 60).toString()}';
  }

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(vsync: this, duration: Duration(seconds: 6));
    animationController.reverse(
      from: animationController.value == 0.0
        ? 1.0
        : animationController.value
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
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
        body: Scrollbar(
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
                          AnimatedBuilder(
                            animation: animationController,
                            builder: (_, Widget child) {
                              return animationController.isAnimating
                                ? ButtonTheme(
                                    minWidth: 50.0,
                                    height: 40.0,
                                    child: RaisedButton(
                                      shape: new RoundedRectangleBorder(
                                          borderRadius: new BorderRadius.circular(5.0)),
                                      child: Text(
                                        timerString,
                                        style: TextStyle(
                                          fontSize: 18.0,
                                          color: Colors.black
                                        ),
                                      ),
                                      color: Colors.white,
                                      elevation: 0.0,
                                      onPressed: () {},
                                    ),
                                  )
                                : ButtonTheme(
                                    minWidth: 50.0,
                                    height: 40.0,
                                    child: RaisedButton(
                                      shape: new RoundedRectangleBorder(
                                          borderRadius: new BorderRadius.circular(5.0)),
                                      child: Text(
                                        'CONFIRM',
                                        style: TextStyle(
                                          fontSize: 13.0,
                                          color: Colors.white
                                        ),
                                      ),
                                      color: Colors.blueAccent,
                                      onPressed: () {
                                        if (animationController.isAnimating) {

                                        } else {
                                          Navigator.push(context,
                                            MyCustomRoute(
                                              builder: (context) => FormBersiap(idOutlet: widget.idOutlet,alamatOutlet: widget.alamatOutlet,outlet: widget.outlet,imageOutlet: widget.imageOutlet,idUser: widget.idUser, idMysteryGuest: widget.idMysteryGuest, index: widget.index, finalServingTime: widget.finalServingTime, aksesStatus: widget.aksesStatus)
                                            )
                                          );
                                        }
                                      },
                                    ),
                                  );
                            }
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
        ),
      ),
    );
  }
}

class FormBersiap extends StatefulWidget {
  final double finalServingTime;
  final String outlet;
  final int idOutlet;
  final String imageOutlet;
  final String alamatOutlet;
  final int idUser;
  final int idMysteryGuest;
  var index;
  final String aksesStatus;
  FormBersiap(
      {this.outlet, this.imageOutlet, this.alamatOutlet, this.idOutlet, this.idUser, this.idMysteryGuest, this.index, this.finalServingTime, this.aksesStatus});

  @override
  _FormBersiapState createState() => _FormBersiapState();
}

class _FormBersiapState extends State<FormBersiap> with TickerProviderStateMixin {
  AnimationController animationController;

  String get timerString {
    Duration duration = animationController.duration * animationController.value;
    return '${(duration.inSeconds % 60).toString()}';
  }

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(vsync: this, duration: Duration(seconds: 4));
    animationController.reverse(
      from: animationController.value == 0.0
        ? 1.0
        : animationController.value
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
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
        body: Scrollbar(
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
                                  'Lakukan review sampai dengan tahapan billing',
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
                          AnimatedBuilder(
                            animation: animationController,
                            builder: (_, Widget child) {
                              return animationController.isAnimating
                                ? ButtonTheme(
                                    minWidth: 50.0,
                                    height: 40.0,
                                    child: RaisedButton(
                                      shape: new RoundedRectangleBorder(
                                          borderRadius: new BorderRadius.circular(5.0)),
                                      child: Text(
                                        timerString,
                                        style: TextStyle(
                                          fontSize: 18.0,
                                          color: Colors.black
                                        ),
                                      ),
                                      color: Colors.white,
                                      elevation: 0.0,
                                      onPressed: () {},
                                    ),
                                  )
                                : ButtonTheme(
                                    minWidth: 50.0,
                                    height: 40.0,
                                    child: RaisedButton(
                                      shape: new RoundedRectangleBorder(
                                          borderRadius: new BorderRadius.circular(5.0)),
                                      child: Text(
                                        'CONFIRM',
                                        style: TextStyle(
                                          fontSize: 13.0,
                                          color: Colors.white
                                        ),
                                      ),
                                      color: Colors.blueAccent,
                                      onPressed: () {
                                        if (animationController.isAnimating) {

                                        } else {
                                          Navigator.push(context,
                                            MyCustomRoute(
                                              builder: (context) => FormReview(idOutlet: widget.idOutlet,alamatOutlet: widget.alamatOutlet,outlet: widget.outlet,imageOutlet: widget.imageOutlet,idUser: widget.idUser, idMysteryGuest: widget.idMysteryGuest, index: widget.index, finalServingTime: widget.finalServingTime, aksesStatus: widget.aksesStatus)
                                            )
                                          );
                                        }
                                      },
                                    ),
                                  );
                            }
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
        ),
      ),
    );
  }
}

class FormReview extends StatefulWidget {
  final double finalServingTime;
  final String outlet;
  final int idOutlet;
  final String imageOutlet;
  final String alamatOutlet;
  final int idUser;
  final int idMysteryGuest;
  var index;
  final String aksesStatus;
  FormReview(
      {this.outlet, this.imageOutlet, this.alamatOutlet, this.idOutlet, this.idUser, this.idMysteryGuest, this.index, this.finalServingTime, this.aksesStatus});

  @override
  _FormReviewState createState() => _FormReviewState();
}

class _FormReviewState extends State<FormReview> with TickerProviderStateMixin {
  List<Map> _listData = [
    {'nomor': '1'},
    {'nomor': '2'},
    {'nomor': '3'},
    {'nomor': '4'},
  ];

  int indexGreeting = 0;
  int jumlahGreeting = 0;
  List<int> scoreGreeting = [];
  List<String> jawabanSplitGreeting;
  List<String> warnaGreeting = [];
  List<String> noteGreeting = [];
  List<dynamic> bobotGreeting = [];
  double hasilGreeting = 0.0;
  double finalGreeting = 0.0;
  double bobotBantuGreeting = 0.0;
  TextEditingController _controllerGreeting = TextEditingController();

  int indexSeating = 0;
  int jumlahSeating = 0;
  List<int> scoreSeating = [];
  List<String> jawabanSplitSeating;
  List<String> warnaSeating = [];
  List<String> noteSeating = [];
  List<dynamic> bobotSeating = [];
  double hasilSeating = 0.0;
  double finalSeating = 0.0;
  double bobotBantuSeating = 0.0;
  TextEditingController _controllerSeating = TextEditingController();

  int indexTakingOrder = 0;
  int jumlahTakingOrder = 0;
  List<int> scoreTakingOrder = [];
  List<String> jawabanSplitTakingOrder;
  List<String> warnaTakingOrder = [];
  List<String> noteTakingOrder = [];
  List<dynamic> bobotTakingOrder = [];
  double hasilTakingOrder = 0.0;
  double finalTakingOrder = 0.0;
  double bobotBantuTakingOrder = 0.0;
  TextEditingController _controllerTakingOrder = TextEditingController();

  int indexServingProduct = 0;
  int jumlahServingProduct = 0;
  List<int> scoreServingProduct = [];
  List<String> jawabanSplitServingProduct;
  List<String> warnaServingProduct = [];
  List<String> noteServingProduct = [];
  List<dynamic> bobotServingProduct = [];
  double hasilServingProduct = 0.0;
  double finalServingProduct = 0.0;
  double bobotBantuServingProduct = 0.0;

  List<String> imageServingProduct = [];
  List<File> imageServingProductBantu = [];
  File imageServingProduct1;
  File imageServingProduct2;
  String filenameServingProduct1;
  String filenameServingProduct2;
  List<String> imageServingProductSave = [];
  TextEditingController _controllerServingProduct = TextEditingController();

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
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
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
                                            '1. Greeting',
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
                          Container(
                            color: Colors.white,
                            child: StreamBuilder(
                              stream: Firestore.instance.collection('greeting').snapshots(),
                              builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                                jumlahGreeting = snapshot.data.documents[0].data['pertanyaan'].length;
                                jawabanSplitGreeting = snapshot.data.documents[0].data['jawaban'][indexGreeting].split(r"!@#$");

                                if (scoreGreeting.length < jumlahGreeting) {
                                  for (int a = 0; a < jumlahGreeting; a++) {
                                    scoreGreeting.add(null);
                                    warnaGreeting.add('abu');
                                  }
                                }

                                if (!snapshot.hasData && snapshot.data == null)
                                  return Container(
                                    child: Center(
                                      child: CircularProgressIndicator(),
                                    ),
                                  );

                                return Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    Stack(
                                      children: <Widget>[
                                        Image.asset(
                                          'assets/images/Greeting.jpeg',
                                          fit: BoxFit.cover,
                                          height: MediaQuery.of(context).size.height / 1.55777,
                                        ),
                                        Positioned(
                                          bottom: 20.0,
                                          width: MediaQuery.of(context).size.width,
                                          child: Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                            children: <Widget>[
                                              jawabanSplitGreeting[0] == 'null'
                                                ? Container()
                                                : Tooltip(
                                                    message: jawabanSplitGreeting == null ? '' : jawabanSplitGreeting[0],
                                                    preferBelow: false,
                                                    child: Container(
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
                                                          color: warnaGreeting.length == 0 ? Color.fromARGB(170, 192, 192, 192) : warnaGreeting[indexGreeting] == 'merah' ? Color.fromARGB(170, 255, 40, 0) : Color.fromARGB(170, 192, 192, 192),
                                                          onPressed: () {
                                                            setState(() {
                                                              bobotGreeting.add(snapshot.data.documents[0].data['bobot_pertanyaan']);
                                                              bobotBantuGreeting = double.tryParse(snapshot.data.documents[0].data['bobot'].toString());

                                                              scoreGreeting.removeAt(indexGreeting);
                                                              scoreGreeting.insert(indexGreeting, 0);
                                                              warnaGreeting.removeAt(indexGreeting);
                                                              warnaGreeting.insert(indexGreeting, 'merah');
                                                            });
                                                          },
                                                        ),
                                                      ),
                                                      alignment: Alignment(0.0, 0.0),
                                                    ),
                                                  ),
                                              jawabanSplitGreeting[1] == 'null'
                                                ? Container()
                                                : Tooltip(
                                                    message: jawabanSplitGreeting == null ? '' : jawabanSplitGreeting[1],
                                                    preferBelow: false,
                                                    child: Container(
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
                                                          color: warnaGreeting.length == 0 ? Color.fromARGB(170, 192, 192, 192) : warnaGreeting[indexGreeting] == 'kuning' ? Color.fromARGB(170, 247, 202, 24) : Color.fromARGB(170, 192, 192, 192),
                                                          onPressed: () {
                                                            setState(() {
                                                              bobotBantuGreeting = double.tryParse(snapshot.data.documents[0].data['bobot'].toString());
                                                              bobotGreeting.add(snapshot.data.documents[0].data['bobot_pertanyaan']);

                                                              scoreGreeting.removeAt(indexGreeting);
                                                              scoreGreeting.insert(indexGreeting, 1);
                                                              warnaGreeting.removeAt(indexGreeting);
                                                              warnaGreeting.insert(indexGreeting, 'kuning');
                                                            });
                                                          },
                                                        ),
                                                      ),
                                                      alignment: Alignment(0.0, 0.0),
                                                    ),
                                                  ),
                                              jawabanSplitGreeting[2] == 'null'
                                                ? Container()
                                                : Tooltip(
                                                    message: jawabanSplitGreeting == null ? '' : jawabanSplitGreeting[2],
                                                    preferBelow: false,
                                                    child: Container(
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
                                                          color: warnaGreeting.length == 0 ? Color.fromARGB(170, 192, 192, 192) : warnaGreeting[indexGreeting] == 'hijau' ? Color.fromARGB(170, 50, 205, 50) : Color.fromARGB(170, 192, 192, 192),
                                                          onPressed: () {
                                                            setState(() {
                                                              bobotBantuGreeting = double.tryParse(snapshot.data.documents[0].data['bobot'].toString());
                                                              bobotGreeting.add(snapshot.data.documents[0].data['bobot_pertanyaan']);

                                                              scoreGreeting.removeAt(indexGreeting);
                                                              scoreGreeting.insert(indexGreeting, 2);
                                                              warnaGreeting.removeAt(indexGreeting);
                                                              warnaGreeting.insert(indexGreeting, 'hijau');
                                                            });
                                                          },
                                                        ),
                                                      ),
                                                      alignment: Alignment(0.0, 0.0),
                                                    ),
                                                  ),
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                    Container(
                                      height: 65.0,
                                      padding: EdgeInsets.symmetric(horizontal: 25.0, vertical: 10.0),
                                      child: Row(
                                        children: <Widget>[
                                          Flexible(
                                            child: Text(
                                              snapshot.data.documents[0].data['pertanyaan'][indexGreeting]
                                            ),
                                          )
                                        ],
                                      ),
                                    )
                                  ],
                                );
                              },
                            )
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
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: <Widget>[
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
                                                            controller: _controllerGreeting,
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
                                                              'OK',
                                                              style: TextStyle(color: Colors.green),
                                                            ),
                                                            onPressed: () {
                                                              if (_controllerGreeting.text != '') {
                                                                noteGreeting.add(_controllerGreeting.text);
                                                              }
                                                              Navigator.of(context).pop();
                                                            },
                                                          )
                                                        ],
                                                      );
                                                    }
                                                  );
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
                                                  setState(() {
                                                    if (indexGreeting < 1) {
                                                      indexGreeting = 0;
                                                    } else {
                                                      indexGreeting--;
                                                    }
                                                  });
                                                },
                                                tooltip: 'Previous Question',
                                              ),
                                              IconButton(
                                                icon: Icon(Icons.arrow_forward_ios, color: Colors.white),
                                                onPressed: () {
                                                  setState(() {
                                                    if (scoreGreeting[indexGreeting] == null) {
                                                      showDialog(
                                                        barrierDismissible: false,
                                                        context: context,
                                                        builder: (context) => Dialog(
                                                          child: Container(
                                                            height: 180.0,
                                                            child: Column(
                                                              children: <Widget>[
                                                                Container(
                                                                  color: AbubaPallate.greenabuba,
                                                                  height: 50.0,
                                                                  child: Center(
                                                                    child: Text(
                                                                      'OOPS!',
                                                                      style: TextStyle(
                                                                        color: Colors.white,
                                                                        fontSize: 17.0,
                                                                        fontWeight: FontWeight.w700),
                                                                    ),
                                                                  ),
                                                                ),
                                                                SizedBox(
                                                                  height: 20.0,
                                                                ),
                                                                Container(
                                                                  padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
                                                                  child: Text(
                                                                    'Please select the answer!',
                                                                    style: TextStyle(
                                                                      fontSize: 16.0,
                                                                    ),
                                                                  ),
                                                                ),
                                                                Row(
                                                                  mainAxisAlignment: MainAxisAlignment.end,
                                                                  children: <Widget>[
                                                                    FlatButton(
                                                                      child: Text('OK'),
                                                                      onPressed: () {
                                                                        Navigator.pop(context);
                                                                      },
                                                                    )
                                                                  ],
                                                                )
                                                              ],
                                                            ),
                                                          ),
                                                        )
                                                      );
                                                    } else {
                                                      if (indexGreeting + 1 < jumlahGreeting) {
                                                        indexGreeting++;
                                                      } else {
                                                        indexGreeting = jumlahGreeting - 1;

                                                        for (int i = 0; i < scoreGreeting.length; i++) {
                                                          hasilGreeting += double.tryParse(bobotGreeting[0][i].toString()) * double.tryParse(scoreGreeting[i].toString());
                                                        }
                                                        hasilGreeting = hasilGreeting / 2;
                                                        if (hasilGreeting > 1.0) {
                                                          hasilGreeting = 1.0;
                                                        } else {
                                                          hasilGreeting = hasilGreeting;
                                                        }

                                                        DocumentReference docReference = Firestore.instance.collection('mystery_shopper').document(widget.index);
                                                        docReference.updateData({
                                                          'greeting_score': scoreGreeting,
                                                          'greeting_note': noteGreeting,
                                                          'hasilGreeting': hasilGreeting,
                                                        }).then((doc) {
                                                          finalGreeting = hasilGreeting * bobotBantuGreeting;
                                                          _cardController.animateTo(_cardController.index + 1);
                                                        }).catchError((error) {
                                                          print(error);
                                                        });
                                                      }
                                                    }
                                                  });
                                                },
                                                tooltip: 'Next Question',
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                    decoration: BoxDecoration(color: Color(0xFF2F592F))
                                  ),
                                )
                              ],
                            ),
                          ),

                        ],
                      ),
                      ListView(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
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
                                              '2. Seating',
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
                          Container(
                            color: Colors.white,
                            child: StreamBuilder(
                              stream: Firestore.instance
                                  .collection('seating')
                                  .snapshots(),
                              builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                                if (!snapshot.hasData && snapshot.data == null)
                                  return Container(
                                    child: Center(
                                      child: CircularProgressIndicator(),
                                    ),
                                  );
                                jumlahSeating = snapshot.data.documents[0].data['pertanyaan'].length;
                                jawabanSplitSeating = snapshot.data.documents[0].data['jawaban'][indexSeating].split(r"!@#$");

                                if (scoreSeating.length < jumlahSeating) {
                                  for (int a = 0; a < jumlahSeating; a++) {
                                    scoreSeating.add(null);
                                    warnaSeating.add('abu');
                                  }
                                }

                                return Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    Stack(
                                      children: <Widget>[
                                        Image.asset(
                                          'assets/images/Seating.jpeg',
                                          fit: BoxFit.cover,
                                          height: MediaQuery.of(context).size.height / 1.55777,
                                        ),
                                        Positioned(
                                          bottom: 20.0,
                                          width: MediaQuery.of(context).size.width,
                                          child: Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                            children: <Widget>[
                                              jawabanSplitSeating[0] == 'null'
                                                ? Container()
                                                : Tooltip(
                                                    message: jawabanSplitSeating == null ? '' : jawabanSplitSeating[0],
                                                    preferBelow: false,
                                                    child: Container(
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
                                                          color: warnaSeating.length == 0 ? Color.fromARGB(170, 192, 192, 192) : warnaSeating[indexSeating] == 'merah' ? Color.fromARGB(170, 255, 40, 0) : Color.fromARGB(170, 192, 192, 192),
                                                          onPressed: () {
                                                            setState(() {
                                                              bobotBantuSeating = double.tryParse(snapshot.data.documents[0].data['bobot'].toString());
                                                              bobotSeating.add(snapshot.data.documents[0].data['bobot_pertanyaan']);

                                                              scoreSeating.removeAt(indexSeating);
                                                              scoreSeating.insert(indexSeating, 0);
                                                              warnaSeating.removeAt(indexSeating);
                                                              warnaSeating.insert(indexSeating, 'merah');
                                                            });
                                                          },
                                                        ),
                                                      ),
                                                      alignment: Alignment(0.0, 0.0),
                                                    ),
                                                  ),
                                              jawabanSplitSeating[1] == 'null'
                                                ? Container()
                                                : Tooltip(
                                                    message: jawabanSplitSeating == null ? '' : jawabanSplitSeating[1],
                                                    preferBelow: false,
                                                    child: Container(
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
                                                          color: warnaSeating.length == 0 ? Color.fromARGB(170, 192, 192, 192) : warnaSeating[indexSeating] == 'kuning' ? Color.fromARGB(170, 247, 202, 24) : Color.fromARGB(170, 192, 192, 192),
                                                          onPressed: () {
                                                            setState(() {
                                                              bobotBantuSeating = double.tryParse(snapshot.data.documents[0].data['bobot'].toString());
                                                              bobotSeating.add(snapshot.data.documents[0].data['bobot_pertanyaan']);

                                                              scoreSeating.removeAt(indexSeating);
                                                              scoreSeating.insert(indexSeating, 1);
                                                              warnaSeating.removeAt(indexSeating);
                                                              warnaSeating.insert(indexSeating, 'kuning');
                                                            });
                                                          },
                                                        ),
                                                      ),
                                                      alignment: Alignment(0.0, 0.0),
                                                    ),
                                                  ),
                                              jawabanSplitSeating[2] == 'null'
                                                ? Container()
                                                : Tooltip(
                                                    message: jawabanSplitSeating == null ? '' : jawabanSplitSeating[2],
                                                    preferBelow: false,
                                                    child: Container(
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
                                                          color: warnaSeating.length == 0 ? Color.fromARGB(170, 192, 192, 192) : warnaSeating[indexSeating] == 'hijau' ? Color.fromARGB(170, 50, 205, 50) : Color.fromARGB(170, 192, 192, 192),
                                                          onPressed: () {
                                                            setState(() {
                                                              bobotBantuSeating = double.tryParse(snapshot.data.documents[0].data['bobot'].toString());
                                                              bobotSeating.add(snapshot.data.documents[0].data['bobot_pertanyaan']);

                                                              scoreSeating.removeAt(indexSeating);
                                                              scoreSeating.insert(indexSeating, 2);
                                                              warnaSeating.removeAt(indexSeating);
                                                              warnaSeating.insert(indexSeating, 'hijau');
                                                            });
                                                          },
                                                        ),
                                                      ),
                                                      alignment: Alignment(0.0, 0.0),
                                                    ),
                                                  ),
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                    Container(
                                      height: 65.0,
                                      padding: EdgeInsets.symmetric(horizontal: 25.0, vertical: 10.0),
                                      child: Row(
                                        children: <Widget>[
                                          Flexible(
                                            child: Text(
                                              snapshot.data.documents[0].data['pertanyaan'][indexSeating]
                                            ),
                                          )
                                        ],
                                      ),
                                    )
                                  ],
                                );
                              },
                            )
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
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: <Widget>[
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
                                                            controller: _controllerSeating,
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
                                                              'OK',
                                                              style: TextStyle(color: Colors.green),
                                                            ),
                                                            onPressed: () {
                                                              if (_controllerSeating.text != '') {
                                                                noteSeating.add(_controllerSeating.text);
                                                              }
                                                              Navigator.of(context).pop();
                                                            },
                                                          )
                                                        ],
                                                      );
                                                    }
                                                  );
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
                                                  setState(() {
                                                    if (indexSeating < 1) {
                                                      indexSeating = 0;
                                                    } else {
                                                      indexSeating--;
                                                    }
                                                  });
                                                },
                                                tooltip: 'Previous Question',
                                              ),
                                              IconButton(
                                                icon: Icon(Icons.arrow_forward_ios, color: Colors.white),
                                                onPressed: () {
                                                  setState(() {
                                                    if (scoreSeating[indexSeating] == null) {
                                                      showDialog(
                                                        barrierDismissible: false,
                                                        context: context,
                                                        builder: (context) => Dialog(
                                                          child: Container(
                                                            height: 180.0,
                                                            child: Column(
                                                              children: <Widget>[
                                                                Container(
                                                                  color: AbubaPallate.greenabuba,
                                                                  height: 50.0,
                                                                  child: Center(
                                                                    child: Text(
                                                                      'OOPS!',
                                                                      style: TextStyle(
                                                                        color: Colors.white,
                                                                        fontSize: 17.0,
                                                                        fontWeight: FontWeight.w700),
                                                                    ),
                                                                  ),
                                                                ),
                                                                SizedBox(
                                                                  height: 20.0,
                                                                ),
                                                                Container(
                                                                  padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
                                                                  child: Text(
                                                                    'Please select the answer!',
                                                                    style: TextStyle(
                                                                      fontSize: 16.0,
                                                                    ),
                                                                  ),
                                                                ),
                                                                Row(
                                                                  mainAxisAlignment: MainAxisAlignment.end,
                                                                  children: <Widget>[
                                                                    FlatButton(
                                                                      child: Text('OK'),
                                                                      onPressed: () {
                                                                        Navigator.pop(context);
                                                                      },
                                                                    )
                                                                  ],
                                                                )
                                                              ],
                                                            ),
                                                          ),
                                                        )
                                                      );
                                                    } else {
                                                      if (indexSeating + 1 < jumlahSeating) {
                                                        indexSeating++;
                                                      } else {
                                                        indexSeating = jumlahSeating - 1;

                                                        for (int i = 0; i < scoreSeating.length; i++) {
                                                          hasilSeating += double.tryParse(bobotSeating[0][i].toString()) * double.tryParse(scoreSeating[i].toString());
                                                        }
                                                        hasilSeating = hasilSeating / 2;
                                                        if (hasilSeating > 1.0) {
                                                            hasilSeating = 1.0;
                                                        } else {
                                                            hasilSeating = hasilSeating;
                                                        }

                                                        DocumentReference docReference = Firestore.instance.collection('mystery_shopper').document(widget.index);
                                                        docReference.updateData({
                                                          'seating_score': scoreSeating,
                                                          'seating_note': noteSeating,
                                                          'hasilSeating': hasilSeating,
                                                        }).then((doc) {
                                                          finalSeating = hasilSeating * bobotBantuSeating;
                                                          _cardController.animateTo(_cardController.index + 1);
                                                        }).catchError((error) {
                                                          print(error);
                                                        });
                                                      }
                                                    }
                                                  });
                                                },
                                                tooltip: 'Next Question',
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                    decoration: BoxDecoration(color: Color(0xFF2F592F))
                                  ),
                                )
                              ],
                            ),
                          ),

                        ],
                      ),
                      ListView(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
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
                                              '3. Taking Order',
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
                          Container(
                            color: Colors.white,
                            child: StreamBuilder(
                              stream: Firestore.instance
                                  .collection('takingOrder')
                                  .snapshots(),
                              builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                                if (!snapshot.hasData && snapshot.data == null)
                                  return Container(
                                    child: Center(
                                      child: CircularProgressIndicator(),
                                    ),
                                  );
                                jumlahTakingOrder = snapshot.data.documents[0].data['pertanyaan'].length;
                                jawabanSplitTakingOrder = snapshot.data.documents[0].data['jawaban'][indexTakingOrder].split(r"!@#$");

                                if (scoreTakingOrder.length < jumlahTakingOrder) {
                                  for (int a = 0; a < jumlahTakingOrder; a++) {
                                    scoreTakingOrder.add(null);
                                    warnaTakingOrder.add('abu');
                                  }
                                }

                                return Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    Stack(
                                      children: <Widget>[
                                        Image.asset(
                                          'assets/images/Taking Order.jpeg',
                                          fit: BoxFit.cover,
                                          height: MediaQuery.of(context).size.height / 1.55777,
                                        ),
                                        Positioned(
                                          bottom: 20.0,
                                          width: MediaQuery.of(context).size.width,
                                          child: Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                            children: <Widget>[
                                              jawabanSplitTakingOrder[0] == 'null'
                                                ? Container()
                                                : Tooltip(
                                                    message: jawabanSplitTakingOrder == null ? '' : jawabanSplitTakingOrder[0],
                                                    preferBelow: false,
                                                    child: Container(
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
                                                          color: warnaTakingOrder.length == 0 ? Color.fromARGB(170, 192, 192, 192) : warnaTakingOrder[indexTakingOrder] == 'merah' ? Color.fromARGB(170, 255, 40, 0) : Color.fromARGB(170, 192, 192, 192),
                                                          onPressed: () {
                                                            setState(() {
                                                              bobotBantuTakingOrder = double.tryParse(snapshot.data.documents[0].data['bobot'].toString());
                                                              bobotTakingOrder.add(snapshot.data.documents[0].data['bobot_pertanyaan']);

                                                              scoreTakingOrder.removeAt(indexTakingOrder);
                                                              scoreTakingOrder.insert(indexTakingOrder, 0);
                                                              warnaTakingOrder.removeAt(indexTakingOrder);
                                                              warnaTakingOrder.insert(indexTakingOrder, 'merah');
                                                            });
                                                          },
                                                        ),
                                                      ),
                                                      alignment: Alignment(0.0, 0.0),
                                                    ),
                                                  ),
                                              jawabanSplitTakingOrder[1] == 'null'
                                                ? Container()
                                                : Tooltip(
                                                    message: jawabanSplitTakingOrder == null ? '' : jawabanSplitTakingOrder[1],
                                                    preferBelow: false,
                                                    child: Container(
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
                                                          color: warnaTakingOrder.length == 0 ? Color.fromARGB(170, 192, 192, 192) : warnaTakingOrder[indexTakingOrder] == 'kuning' ? Color.fromARGB(170, 247, 202, 24) : Color.fromARGB(170, 192, 192, 192),
                                                          onPressed: () {
                                                            setState(() {
                                                              bobotBantuTakingOrder = double.tryParse(snapshot.data.documents[0].data['bobot'].toString());
                                                              bobotTakingOrder.add(snapshot.data.documents[0].data['bobot_pertanyaan']);

                                                              scoreTakingOrder.removeAt(indexTakingOrder);
                                                              scoreTakingOrder.insert(indexTakingOrder, 1);
                                                              warnaTakingOrder.removeAt(indexTakingOrder);
                                                              warnaTakingOrder.insert(indexTakingOrder, 'kuning');
                                                            });
                                                          },
                                                        ),
                                                      ),
                                                      alignment: Alignment(0.0, 0.0),
                                                    ),
                                                  ),
                                              jawabanSplitTakingOrder[2] == 'null'
                                                ? Container()
                                                : Tooltip(
                                                    message: jawabanSplitTakingOrder == null ? '' : jawabanSplitTakingOrder[2],
                                                    preferBelow: false,
                                                    child: Container(
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
                                                          color: warnaTakingOrder.length == 0 ? Color.fromARGB(170, 192, 192, 192) : warnaTakingOrder[indexTakingOrder] == 'hijau' ? Color.fromARGB(170, 50, 205, 50) : Color.fromARGB(170, 192, 192, 192),
                                                          onPressed: () {
                                                            setState(() {
                                                              bobotBantuTakingOrder = double.tryParse(snapshot.data.documents[0].data['bobot'].toString());
                                                              bobotTakingOrder.add(snapshot.data.documents[0].data['bobot_pertanyaan']);

                                                              scoreTakingOrder.removeAt(indexTakingOrder);
                                                              scoreTakingOrder.insert(indexTakingOrder, 2);
                                                              warnaTakingOrder.removeAt(indexTakingOrder);
                                                              warnaTakingOrder.insert(indexTakingOrder, 'hijau');
                                                            });
                                                          },
                                                        ),
                                                      ),
                                                      alignment: Alignment(0.0, 0.0),
                                                    ),
                                                  ),
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                    Container(
                                      height: 65.0,
                                      padding: EdgeInsets.symmetric(horizontal: 25.0, vertical: 10.0),
                                      child: Row(
                                        children: <Widget>[
                                          Flexible(
                                            child: Text(
                                              snapshot.data.documents[0].data['pertanyaan'][indexTakingOrder]
                                            ),
                                          )
                                        ],
                                      ),
                                    )
                                  ],
                                );
                              },
                            )
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
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: <Widget>[
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
                                                            controller: _controllerTakingOrder,
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
                                                              'OK',
                                                              style: TextStyle(color: Colors.green),
                                                            ),
                                                            onPressed: () {
                                                              if (_controllerTakingOrder.text != '') {
                                                                noteTakingOrder.add(_controllerTakingOrder.text);
                                                              }
                                                              Navigator.of(context).pop();
                                                            },
                                                          )
                                                        ],
                                                      );
                                                    }
                                                  );
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
                                                  setState(() {
                                                    if (indexTakingOrder < 1) {
                                                      indexTakingOrder = 0;
                                                    } else {
                                                      indexTakingOrder--;
                                                    }
                                                  });
                                                },
                                                tooltip: 'Previous Question',
                                              ),
                                              IconButton(
                                                icon: Icon(Icons.arrow_forward_ios, color: Colors.white),
                                                onPressed: () {
                                                  setState(() {
                                                    if (scoreTakingOrder[indexTakingOrder] == null) {
                                                      showDialog(
                                                        barrierDismissible: false,
                                                        context: context,
                                                        builder: (context) => Dialog(
                                                          child: Container(
                                                            height: 180.0,
                                                            child: Column(
                                                              children: <Widget>[
                                                                Container(
                                                                  color: AbubaPallate.greenabuba,
                                                                  height: 50.0,
                                                                  child: Center(
                                                                    child: Text(
                                                                      'OOPS!',
                                                                      style: TextStyle(
                                                                        color: Colors.white,
                                                                        fontSize: 17.0,
                                                                        fontWeight: FontWeight.w700),
                                                                    ),
                                                                  ),
                                                                ),
                                                                SizedBox(
                                                                  height: 20.0,
                                                                ),
                                                                Container(
                                                                  padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
                                                                  child: Text(
                                                                    'Please select the answer!',
                                                                    style: TextStyle(
                                                                      fontSize: 16.0,
                                                                    ),
                                                                  ),
                                                                ),
                                                                Row(
                                                                  mainAxisAlignment: MainAxisAlignment.end,
                                                                  children: <Widget>[
                                                                    FlatButton(
                                                                      child: Text('OK'),
                                                                      onPressed: () {
                                                                        Navigator.pop(context);
                                                                      },
                                                                    )
                                                                  ],
                                                                )
                                                              ],
                                                            ),
                                                          ),
                                                        )
                                                      );
                                                    } else {
                                                      if (indexTakingOrder + 1 < jumlahTakingOrder) {
                                                        indexTakingOrder++;
                                                      } else {
                                                        indexTakingOrder = jumlahTakingOrder - 1;

                                                        for (int i = 0; i < scoreTakingOrder.length; i++) {
                                                            hasilTakingOrder += double.tryParse(bobotTakingOrder[0][i].toString()) * double.tryParse(scoreTakingOrder[i].toString());
                                                        }
                                                        hasilTakingOrder = hasilTakingOrder / 2;

                                                        if (hasilTakingOrder > 1.0) {
                                                            hasilTakingOrder = 1.0;
                                                        } else {
                                                            hasilTakingOrder = hasilTakingOrder;
                                                        }

                                                        DocumentReference docReference = Firestore.instance.collection('mystery_shopper').document(widget.index);
                                                        docReference.updateData({
                                                          'takingOrder_score': scoreTakingOrder,
                                                          'takingOrder_note': noteTakingOrder,
                                                          'hasilTakingOrder': hasilTakingOrder
                                                        }).then((doc) {
                                                          finalTakingOrder =hasilTakingOrder * bobotBantuTakingOrder;
                                                          _cardController.animateTo(_cardController.index + 1);
                                                        }).catchError((error) {
                                                          print(error);
                                                        });
                                                      }
                                                    }
                                                  });
                                                },
                                                tooltip: 'Next Question',
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                    decoration: BoxDecoration(color: Color(0xFF2F592F))
                                  ),
                                )
                              ],
                            ),
                          ),

                        ],
                      ),
                      ListView(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
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
                                              '4. Serving Product',
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
                                          color: Color(0xFF2F592F))),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            color: Colors.white,
                            child: StreamBuilder(
                              stream: Firestore.instance
                                  .collection('servingProduct')
                                  .snapshots(),
                              builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                                if (!snapshot.hasData && snapshot.data == null)
                                  return Container(
                                    child: Center(
                                      child: CircularProgressIndicator(),
                                    ),
                                  );
                                jumlahServingProduct = snapshot.data.documents[0].data['pertanyaan'].length;
                                jawabanSplitServingProduct = snapshot.data.documents[0].data['jawaban'][indexServingProduct].split(r"!@#$");

                                if (scoreServingProduct.length < jumlahServingProduct) {
                                  for (int a = 0; a < jumlahServingProduct; a++) {
                                    scoreServingProduct.add(null);
                                    warnaServingProduct.add('abu');
                                  }
                                }

                                String imageLink;
                                if (indexServingProduct == 0) {
                                  imageLink = 'assets/images/abuba3.jpg';
                                } else if (indexServingProduct == 1) {
                                  imageLink = 'assets/images/slide 13.png';
                                } else if (indexServingProduct == 2) {
                                  imageLink = 'assets/images/slide 16.png';
                                } else if (indexServingProduct == 3) {
                                  imageLink = 'assets/images/slide 19.png';
                                } else if (indexServingProduct == 4) {
                                  imageLink = 'assets/images/slide 13.png';
                                } else if (indexServingProduct == 5) {
                                  imageLink = 'assets/images/slide 16.png';
                                } else if (indexServingProduct == 6) {
                                  imageLink = 'assets/images/slide 13.png';
                                } else if (indexServingProduct == 7) {
                                  imageLink = 'assets/images/slide 13.png';
                                }

                                return Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    Stack(
                                      children: <Widget>[
                                        Image.asset(
                                          imageLink,
                                          fit: BoxFit.cover,
                                          height: MediaQuery.of(context).size.height / 1.55777,
                                        ),
                                        Positioned(
                                          bottom: 20.0,
                                          width: MediaQuery.of(context).size.width,
                                          child: Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                            children: <Widget>[
                                              jawabanSplitServingProduct[0] == 'null'
                                                ? Container()
                                                : Tooltip(
                                                    message: jawabanSplitServingProduct == null ? '' : jawabanSplitServingProduct[0],
                                                    preferBelow: false,
                                                    child: Container(
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
                                                          color: warnaServingProduct.length == 0 ? Color.fromARGB(170, 192, 192, 192) : warnaServingProduct[indexServingProduct] == 'merah' ? Color.fromARGB(170, 255, 40, 0) : Color.fromARGB(170, 192, 192, 192),
                                                          onPressed: () {
                                                            setState(() {
                                                              bobotBantuServingProduct = double.tryParse(snapshot.data.documents[0].data['bobot'].toString());
                                                              bobotServingProduct.add(snapshot.data.documents[0].data['bobot_pertanyaan']);

                                                              scoreServingProduct.removeAt(indexServingProduct);
                                                              scoreServingProduct.insert(indexServingProduct, 0);
                                                              warnaServingProduct.removeAt(indexServingProduct);
                                                              warnaServingProduct.insert(indexServingProduct, 'merah');
                                                            });
                                                          },
                                                        ),
                                                      ),
                                                      alignment: Alignment(0.0, 0.0),
                                                    ),
                                                  ),
                                              jawabanSplitServingProduct[1] == 'null'
                                                ? Container()
                                                : Tooltip(
                                                    message: jawabanSplitServingProduct == null ? '' : jawabanSplitServingProduct[1],
                                                    preferBelow: false,
                                                    child: Container(
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
                                                          color: warnaServingProduct.length == 0 ? Color.fromARGB(170, 192, 192, 192) : warnaServingProduct[indexServingProduct] == 'kuning' ? Color.fromARGB(170, 247, 202, 24) : Color.fromARGB(170, 192, 192, 192),
                                                          onPressed: () {
                                                            setState(() {
                                                              bobotBantuServingProduct = double.tryParse(snapshot.data.documents[0].data['bobot'].toString());
                                                              bobotServingProduct.add(snapshot.data.documents[0].data['bobot_pertanyaan']);

                                                              scoreServingProduct.removeAt(indexServingProduct);
                                                              scoreServingProduct.insert(indexServingProduct, 1);
                                                              warnaServingProduct.removeAt(indexServingProduct);
                                                              warnaServingProduct.insert(indexServingProduct, 'kuning');
                                                            });
                                                          },
                                                        ),
                                                      ),
                                                      alignment: Alignment(0.0, 0.0),
                                                    ),
                                                  ),
                                              jawabanSplitServingProduct[2] == 'null'
                                                ? Container()
                                                : Tooltip(
                                                    message: jawabanSplitServingProduct == null ? '' : jawabanSplitServingProduct[2],
                                                    preferBelow: false,
                                                    child: Container(
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
                                                          color: warnaServingProduct.length == 0 ? Color.fromARGB(170, 192, 192, 192) : warnaServingProduct[indexServingProduct] == 'hijau' ? Color.fromARGB(170, 50, 205, 50) : Color.fromARGB(170, 192, 192, 192),
                                                          onPressed: () {
                                                            setState(() {
                                                              bobotBantuServingProduct = double.tryParse(snapshot.data.documents[0].data['bobot'].toString());
                                                              bobotServingProduct.add(snapshot.data.documents[0].data['bobot_pertanyaan']);

                                                              scoreServingProduct.removeAt(indexServingProduct);
                                                              scoreServingProduct.insert(indexServingProduct, 2);
                                                              warnaServingProduct.removeAt(indexServingProduct);
                                                              warnaServingProduct.insert(indexServingProduct, 'hijau');
                                                            });
                                                          },
                                                        ),
                                                      ),
                                                      alignment: Alignment(0.0, 0.0),
                                                    ),
                                                  ),
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                    Container(
                                      height: 65.0,
                                      padding: EdgeInsets.symmetric(horizontal: 25.0, vertical: 10.0),
                                      child: Row(
                                        children: <Widget>[
                                          Flexible(
                                            child: Text(
                                              snapshot.data.documents[0].data['pertanyaan'][indexServingProduct]
                                            ),
                                          )
                                        ],
                                      ),
                                    )
                                  ],
                                );
                              },
                            )
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
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: <Widget>[
                                              imageServingProduct.length == 2
                                                ? IconButton(
                                                    icon: Icon(Icons.disc_full, color: Colors.white),
                                                    onPressed: () {},
                                                    tooltip: 'Max. 2 images',
                                                  )
                                                : IconButton(
                                                    icon: Icon(Icons.camera_alt, color: Colors.white),
                                                    onPressed: () async {
                                                      var selectedImage = await ImagePicker.pickImage(source: ImageSource.camera);

                                                      if (imageServingProduct.length == 0) {
                                                        imageServingProduct1 = selectedImage;
                                                        filenameServingProduct1 = basename(imageServingProduct1.path);

                                                        StorageReference strRef = FirebaseStorage.instance.ref().child(filenameServingProduct1);
                                                        StorageUploadTask uploadTask = strRef.putFile(imageServingProduct1);

                                                        var downUrl = await (await uploadTask.onComplete).ref.getDownloadURL();
                                                        var url = downUrl.toString();

                                                        setState(() {
                                                          imageServingProduct.add(filenameServingProduct1);
                                                          imageServingProductBantu.add(imageServingProduct1);
                                                          imageServingProductSave.add(url);
                                                        });
                                                      } else if (imageServingProduct.length == 1) {
                                                        imageServingProduct2 = selectedImage;
                                                        filenameServingProduct2 = basename(imageServingProduct2.path);

                                                        StorageReference strRef = FirebaseStorage.instance.ref().child(filenameServingProduct2);
                                                        StorageUploadTask uploadTask = strRef.putFile(imageServingProduct2);

                                                        var downUrl = await (await uploadTask.onComplete).ref.getDownloadURL();
                                                        var url = downUrl.toString();

                                                        setState(() {
                                                          imageServingProduct.add(filenameServingProduct2);
                                                          imageServingProductBantu.add(imageServingProduct2);
                                                          imageServingProductSave.add(url);
                                                        });
                                                      }
                                                    },
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
                                                            controller: _controllerServingProduct,
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
                                                              'OK',
                                                              style: TextStyle(color: Colors.green),
                                                            ),
                                                            onPressed: () {
                                                              if (_controllerServingProduct.text != '') {
                                                                noteServingProduct.add(_controllerServingProduct.text);
                                                              }
                                                              Navigator.of(context).pop();
                                                            },
                                                          )
                                                        ],
                                                      );
                                                    }
                                                  );
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
                                                  setState(() {
                                                    if (indexServingProduct < 1) {
                                                      indexServingProduct = 0;
                                                    } else {
                                                      indexServingProduct--;
                                                    }
                                                  });
                                                },
                                                tooltip: 'Previous Question',
                                              ),
                                              IconButton(
                                                icon: Icon(Icons.arrow_forward_ios, color: Colors.white),
                                                onPressed: () {
                                                  setState(() {
                                                    if (scoreServingProduct[indexServingProduct] == null) {
                                                      showDialog(
                                                        barrierDismissible: false,
                                                        context: context,
                                                        builder: (context) => Dialog(
                                                          child: Container(
                                                            height: 180.0,
                                                            child: Column(
                                                              children: <Widget>[
                                                                Container(
                                                                  color: AbubaPallate.greenabuba,
                                                                  height: 50.0,
                                                                  child: Center(
                                                                    child: Text(
                                                                      'OOPS!',
                                                                      style: TextStyle(
                                                                        color: Colors.white,
                                                                        fontSize: 17.0,
                                                                        fontWeight: FontWeight.w700),
                                                                    ),
                                                                  ),
                                                                ),
                                                                SizedBox(
                                                                  height: 20.0,
                                                                ),
                                                                Container(
                                                                  padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
                                                                  child: Text(
                                                                    'Please select the answer!',
                                                                    style: TextStyle(
                                                                      fontSize: 16.0,
                                                                    ),
                                                                  ),
                                                                ),
                                                                Row(
                                                                  mainAxisAlignment: MainAxisAlignment.end,
                                                                  children: <Widget>[
                                                                    FlatButton(
                                                                      child: Text('OK'),
                                                                      onPressed: () {
                                                                        Navigator.pop(context);
                                                                      },
                                                                    )
                                                                  ],
                                                                )
                                                              ],
                                                            ),
                                                          ),
                                                        )
                                                      );
                                                    } else {
                                                      if (indexServingProduct + 1 < jumlahServingProduct) {
                                                        indexServingProduct++;
                                                      } else {
                                                        indexServingProduct = jumlahServingProduct - 1;

                                                        for (int i = 0; i < scoreServingProduct.length; i++) {
                                                          hasilServingProduct += double.tryParse(bobotServingProduct[0][i].toString()) * double.tryParse(scoreServingProduct[i].toString());
                                                        }
                                                        hasilServingProduct = hasilServingProduct / 2;

                                                        if (hasilServingProduct > 1.0) {
                                                            hasilServingProduct = 1.0;
                                                        } else {
                                                            hasilServingProduct = hasilServingProduct;
                                                        }

                                                        DocumentReference docReference = Firestore.instance.collection('mystery_shopper').document(widget.index);
                                                        docReference.updateData({
                                                          'servingProduct_score': scoreServingProduct,
                                                          'servingProduct_note': noteServingProduct,
                                                          'servingProduct_image': imageServingProductSave,
                                                          'hasilServingProduct': hasilServingProduct
                                                        }).then((doc) {
                                                          finalServingProduct = hasilServingProduct * bobotBantuServingProduct;
                                                          double finalBantu = widget.finalServingTime + finalGreeting + finalSeating + finalTakingOrder + finalServingProduct;
                                                          Navigator.push(context,
                                                            MaterialPageRoute(
                                                              builder: (_) => FormMockComplaint(idOutlet: widget.idOutlet,alamatOutlet: widget.alamatOutlet,outlet: widget.outlet,imageOutlet: widget.imageOutlet,idUser: widget.idUser, idMysteryGuest: widget.idMysteryGuest, index: widget.index, finalBantu: finalBantu, aksesStatus: widget.aksesStatus)
                                                            )
                                                          );
                                                        }).catchError((error) {
                                                          print(error);
                                                        });
                                                      }
                                                    }
                                                  });
                                                },
                                                tooltip: 'Next Question',
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                    decoration: BoxDecoration(color: Color(0xFF2F592F))
                                  ),
                                )
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
}

class FormMockComplaint extends StatefulWidget {
  final double finalBantu;
  final String outlet;
  final int idOutlet;
  final String imageOutlet;
  final String alamatOutlet;
  final int idUser;
  final int idMysteryGuest;
  var index;
  final String aksesStatus;
  FormMockComplaint(
      {this.outlet, this.imageOutlet, this.alamatOutlet, this.idOutlet, this.idUser, this.idMysteryGuest, this.index, this.finalBantu, this.aksesStatus});

  @override
  _FormMockComplaintState createState() => _FormMockComplaintState();
}

class _FormMockComplaintState extends State<FormMockComplaint> with TickerProviderStateMixin {
  String _myCategory;
  String _myProduct;
  int _product = 0;
  String _myService;
  int _service = 0;
  String _myCoba;
  int coba;
  DateTime complaintStart = DateTime.now();
  bool _note1 = false;
  TextEditingController _controller = TextEditingController();
  TextEditingController _controllerComplaint = TextEditingController();
  String showCat = 'kosong';
  bool showProduct = false;
  bool showService = false;

  int _value1 = 0;

  bool _autoValidate = false;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool showError = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
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
          child: Scrollbar(
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
                  color: Colors.white,
                  width: MediaQuery.of(context).size.width,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                    child: Column(
                      children: <Widget>[
                        Form(
                          autovalidate: _autoValidate,
                          key: _formKey,
                          child: Column(
                            children: <Widget>[
                              StreamBuilder(
                                stream: Firestore.instance.collection('complaint_handling').orderBy('category', descending: false).snapshots(),
                                builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                                  if (!snapshot.hasData)
                                    return Container(
                                      child: Center(
                                        child: CircularProgressIndicator(),
                                      ),
                                    );

                                  return DropdownButtonFormField<String>(
                                    decoration: InputDecoration(
                                      labelText: 'Category',
                                      labelStyle: TextStyle(fontSize: 16.0),
                                      border: _myCategory == null ? null : InputBorder.none,
                                    ),
                                    validator: (value) {
                                      if (value == null) {
                                        return 'Please select category';
                                      } else {
                                        return null;
                                      }
                                    },
                                    value: _myCategory,
                                    onChanged: (String newValue) {
                                      setState(() {
                                        _myCategory = newValue;
                                      });
                                    },
                                    items: snapshot.data.documents.map((DocumentSnapshot document) {
                                      return DropdownMenuItem(
                                        value: document['category'].toString(),
                                        child: Container(
                                          width: MediaQuery.of(context).size.width * 0.8,
                                          padding: EdgeInsets.all(15.0),
                                          child: RichText(
                                            overflow: TextOverflow.visible,
                                            text: TextSpan(
                                              text: document['category'].toString(),
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 14.0
                                              )
                                            ),
                                          )
                                        ),
                                      );
                                    }).toList()
                                  );
                                },
                              ),
                              SizedBox(
                                height: 20.0,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Container(
                                    width: MediaQuery.of(context).size.width / 2.3,
                                    child: RadioListTile(
                                      value: 1,
                                      groupValue: _value1,
                                      onChanged: (int newValue) {
                                        setState(() {
                                          _value1 = newValue;
                                          showProduct = true;
                                          showService = false;
                                          _service = null;
                                          _controller.text = '';
                                          showError = false;
                                        });
                                      },
                                      activeColor: Colors.green,
                                      controlAffinity: ListTileControlAffinity.leading,
                                      title: Text('Product'),
                                    ),
                                  ),
                                  Container(
                                    width: MediaQuery.of(context).size.width / 2.3,
                                    child: RadioListTile(
                                      value: 2,
                                      groupValue: _value1,
                                      onChanged: (int newValue) {
                                        setState(() {
                                          _value1 = newValue;
                                          showProduct = false;
                                          showService = true;
                                          _product = null;
                                          showError = false;
                                        });
                                      },
                                      activeColor: Colors.green,
                                      controlAffinity: ListTileControlAffinity.leading,
                                      title: Text('Service'),
                                    ),
                                  )
                                ],
                              ),
                              showError
                                ? Container(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      'Please select product or service',
                                      style: TextStyle(
                                        color: Colors.red,
                                        fontSize: 12.0
                                      ),
                                    ),
                                  )
                                : Container(),
                              showProduct
                                ? StreamBuilder(
                                    stream: Firestore.instance.collection('product_complaint-mg').orderBy('product', descending: false).snapshots(),
                                    builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                                      if (!snapshot.hasData && snapshot.data == null)
                                        return Container(
                                          child: Center(
                                            child: CircularProgressIndicator(),
                                          ),
                                        );

                                      return DropdownButtonFormField<String>(
                                        decoration: InputDecoration(
                                          labelText: 'Product',
                                          labelStyle: TextStyle(fontSize: 14.0),
                                        ),
                                        validator: (value) {
                                          if (showProduct) {
                                            if (value == null) {
                                              return 'Please select product';
                                            } else {
                                              return null;
                                            }
                                          } else {
                                            return null;
                                          }
                                        },
                                        value: _myProduct,
                                        onChanged: (String newValue) {
                                          setState(() {
                                            _myProduct = newValue;
                                            _product = int.tryParse(newValue);
                                          });
                                        },
                                        items: snapshot.data.documents.map((DocumentSnapshot document) {
                                          return new DropdownMenuItem(
                                            value: document['id'].toString(),
                                            child: RichText(
                                              overflow: TextOverflow.ellipsis,
                                              text: TextSpan(
                                                text: document['product'].toString(),
                                                style: TextStyle(
                                                  color: Colors.black
                                                )
                                              ),
                                            )
                                          );
                                        }).toList()
                                      );
                                    },
                                  )
                                : Container(),
                              showService
                                ? StreamBuilder(
                                    stream: Firestore.instance.collection('service_complaint-mg').orderBy('service', descending: false).snapshots(),
                                    builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                                      if (!snapshot.hasData && snapshot.data == null)
                                        return Container(
                                          child: Center(
                                            child: CircularProgressIndicator(),
                                          ),
                                        );

                                      return DropdownButtonFormField<String>(
                                        decoration: InputDecoration(
                                          labelText: 'Service',
                                          labelStyle: TextStyle(fontSize: 14.0),
                                        ),
                                        validator: (value) {
                                          if (showService) {
                                            if (value == null) {
                                              return 'Please select service';
                                            } else {
                                              return null;
                                            }
                                          } else {
                                            return null;
                                          }
                                        },
                                        value: _myService,
                                        onChanged: (String newValue) {
                                          setState(() {
                                            _myService = newValue;
                                            _service = int.tryParse(newValue);
                                          });
                                        },
                                        items: snapshot.data.documents.map((DocumentSnapshot document) {
                                          return new DropdownMenuItem(
                                            value: document['id'].toString(),
                                            child: RichText(
                                              overflow: TextOverflow.ellipsis,
                                              text: TextSpan(
                                                text: document['service'].toString(),
                                                style: TextStyle(
                                                  color: Colors.black
                                                )
                                              ),
                                            )
                                          );
                                        }).toList()
                                      );
                                    },
                                  )
                                : Container(),
                              showService
                                ? Row(
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
                                  )
                                : Container(),
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
                                      textCapitalization: TextCapitalization.sentences,
                                      controller: _controller,
                                      style: TextStyle(color: Colors.black, fontSize: 16.0),
                                    ),
                                  )
                                : Container(),
                              StreamBuilder(
                                stream: Firestore.instance.collection('pic_complaint-mg').orderBy('pic', descending: false).snapshots(),
                                builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                                  if (!snapshot.hasData && snapshot.data == null)
                                    return Container(
                                      child: Center(
                                        child: CircularProgressIndicator(),
                                      ),
                                    );

                                  return DropdownButtonFormField<String>(
                                    decoration: InputDecoration(
                                      labelText: 'PIC',
                                      labelStyle: TextStyle(fontSize: 16.0),
                                    ),
                                    validator: (value) {
                                      if (value == null) {
                                        return 'Please select PIC';
                                      } else {
                                        return null;
                                      }
                                    },
                                    value: _myCoba,
                                    onChanged: (String newValue) {
                                      setState(() {
                                        _myCoba = newValue;
                                        coba = int.tryParse(newValue);
                                      });
                                    },
                                    items: snapshot.data.documents.map((DocumentSnapshot document) {
                                      return new DropdownMenuItem(
                                        value: document['id'].toString(),
                                        child: RichText(
                                          overflow: TextOverflow.ellipsis,
                                          text: TextSpan(
                                            text: document['pic'].toString(),
                                            style: TextStyle(
                                              color: Colors.black
                                            )
                                          ),
                                        ),
                                      );
                                    }).toList()
                                  );
                                },
                              ),
                              Container(
                                padding: const EdgeInsets.only(bottom: 10.0, top: 20.0),
                                width: MediaQuery.of(context).size.width,
                                child: TextFormField(
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                    labelText: 'Verbatim complaint',
                                    labelStyle: TextStyle(fontSize: 16.0)),
                                  maxLines: 3,
                                  maxLength: 250,
                                  validator: (value) {
                                    if (value.length < 5) {
                                      return 'Verbatim complaint must be more than 5 character';
                                    } else if (value.length > 250) {
                                      return 'Verbatim complaint must be less than 250 character';
                                    } else {
                                      return null;
                                    }
                                  },
                                  textCapitalization: TextCapitalization.sentences,
                                  controller: _controllerComplaint,
                                  style: TextStyle(color: Colors.black, fontSize: 16.0),
                                ),
                              ),
                            ],
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
                                  if (_formKey.currentState.validate() && showError == false) {
                                    setState(() {
                                      _autoValidate = false;
                                    });
                                    _formKey.currentState.save();

                                    DocumentReference docReference = Firestore.instance.collection('mystery_shopper').document(widget.index);
                                    docReference.updateData({
                                      'category': _myCategory,
                                      'product': _product,
                                      'service': _service,
                                      'note_service': _controller.text,
                                      'pic': coba,
                                      'complaint_detail': _controllerComplaint.text,
                                      'complaint_start': complaintStart
                                    }).then((doc) {
                                      Navigator.push(context,
                                        MyCustomRoute(
                                          builder: (context) => FormClose(idOutlet: widget.idOutlet,alamatOutlet: widget.alamatOutlet,outlet: widget.outlet,imageOutlet: widget.imageOutlet,idUser: widget.idUser, idMysteryGuest: widget.idMysteryGuest, index: widget.index, finalBantu: widget.finalBantu, complaintCategory: _myCategory, aksesStatus: widget.aksesStatus),
                                        )
                                      );
                                    }).catchError((error) {
                                      print(error);
                                    });
                                  } else {
                                    setState(() {
                                      if (showProduct) {
                                        showError = false;
                                      } else if (showService) {
                                        showError = false;
                                      } else {
                                        showError = true;
                                      }
                                      _autoValidate = true;
                                    });
                                  }
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
          )
        ),
      ),
    );
  }
}

class FormClose extends StatefulWidget {
  final String complaintCategory;
  final double finalBantu;
  final String outlet;
  final int idOutlet;
  final String imageOutlet;
  final String alamatOutlet;
  final int idUser;
  final int idMysteryGuest;
  var index;
  final String aksesStatus;
  FormClose({this.outlet, this.imageOutlet, this.alamatOutlet, this.idOutlet, this.idUser, this.idMysteryGuest, this.index, this.finalBantu, this.complaintCategory, this.aksesStatus});

  @override
  _FormCloseState createState() => _FormCloseState();
}

class _FormCloseState extends State<FormClose> {
  DateTime complaintEnd = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
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
        body: ListView(
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
                            'Complaint',
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
                              DocumentReference docReference = Firestore.instance.collection('mystery_shopper').document(widget.index);
                              docReference.updateData({
                                'complaint_end': complaintEnd
                              }).then((doc) {
                                Navigator.push(context,
                                  MyCustomRoute(
                                    builder: (context) => FormHandling(idOutlet: widget.idOutlet,alamatOutlet: widget.alamatOutlet,outlet: widget.outlet,imageOutlet: widget.imageOutlet,idUser: widget.idUser, idMysteryGuest: widget.idMysteryGuest, index: widget.index, finalBantu: widget.finalBantu, complaintCategory: widget.complaintCategory, aksesStatus: widget.aksesStatus)
                                  )
                                );
                              }).catchError((error) {
                                print(error);
                              });
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
        ),
      ),
    );
  }
}

class FormHandling extends StatefulWidget {
  final String complaintCategory;
  final double finalBantu;
  final String outlet;
  final int idOutlet;
  final String imageOutlet;
  final String alamatOutlet;
  final int idUser;
  final int idMysteryGuest;
  var index;
  final String aksesStatus;
  FormHandling({this.outlet, this.imageOutlet, this.alamatOutlet, this.idOutlet, this.idUser, this.idMysteryGuest, this.index, this.finalBantu, this.complaintCategory, this.aksesStatus});

  @override
  _FormHandlingState createState() => _FormHandlingState();
}

class _FormHandlingState extends State<FormHandling> {
  int indexComplaint = 0;
  int jumlahComplaint = 0;
  List<int> scoreComplaint = [];
  List<String> jawabanSplitComplaint;
  List<String> warnaComplaint = [];
  List<String> noteComplaint = [];

  List<dynamic> bobotComplaint = [];
  double hasilComplaint = 0.0;
  double bobotBantuComplaint = 0.0;
  double finalComplaint = 0.0;

  List<String> imageComplaint = [];
  List<File> imageComplaintBantu = [];
  File imageComplaint1;
  File imageComplaint2;
  String filenameComplaint1;
  String filenameComplaint2;
  List<String> imageComplaintSave = [];

  TextEditingController _controllerComplaint = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
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
          child: ListView(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
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
                                  'Complaint Handling',
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
              Container(
                color: Colors.white,
                child: StreamBuilder(
                  stream: Firestore.instance
                      .collection('complaint_handling')
                      .where('category', isEqualTo: widget.complaintCategory)
                      .snapshots(),
                  builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (!snapshot.hasData && snapshot.data == null)
                      return Container(
                        child: Center(
                          child: CircularProgressIndicator(),
                        ),
                      );
                    jumlahComplaint = snapshot.data.documents[0].data['pertanyaan'].length;
                    jawabanSplitComplaint = snapshot.data.documents[0].data['jawaban'][indexComplaint].split(r"!@#$");

                    if (scoreComplaint.length < jumlahComplaint) {
                      for (int a = 0; a < jumlahComplaint; a++) {
                        scoreComplaint.add(null);
                        warnaComplaint.add('abu');
                      }
                    }

                    return Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Stack(
                          children: <Widget>[
                            Image.asset(
                              'assets/images/slide 21.png',
                              fit: BoxFit.cover,
                              height: MediaQuery.of(context).size.height / 1.55777,
                            ),
                            Positioned(
                              bottom: 20.0,
                              width: MediaQuery.of(context).size.width,
                              child: Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceEvenly,
                                children: <Widget>[
                                  jawabanSplitComplaint[0] == 'null'
                                    ? Container()
                                    : Tooltip(
                                        message: jawabanSplitComplaint == null ? '' : jawabanSplitComplaint[0],
                                        preferBelow: false,
                                        child: Container(
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
                                              color: warnaComplaint.length == 0 ? Color.fromARGB(170, 192, 192, 192) : warnaComplaint[indexComplaint] == 'merah' ? Color.fromARGB(170, 255, 40, 0) : Color.fromARGB(170, 192, 192, 192),
                                              onPressed: () {
                                                setState(() {
                                                  bobotBantuComplaint = double.tryParse(snapshot.data.documents[0].data['bobot'].toString());
                                                  bobotComplaint.add(snapshot.data.documents[0].data['bobot_pertanyaan']);

                                                  scoreComplaint.removeAt(indexComplaint);
                                                  scoreComplaint.insert(indexComplaint, 0);
                                                  warnaComplaint.removeAt(indexComplaint);
                                                  warnaComplaint.insert(indexComplaint, 'merah');
                                                });
                                              },
                                            ),
                                          ),
                                          alignment: Alignment(0.0, 0.0),
                                        ),
                                      ),
                                  jawabanSplitComplaint[1] == 'null'
                                    ? Container()
                                    : Tooltip(
                                        message: jawabanSplitComplaint == null ? '' : jawabanSplitComplaint[1],
                                        preferBelow: false,
                                        child: Container(
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
                                              color: warnaComplaint.length == 0 ? Color.fromARGB(170, 192, 192, 192) : warnaComplaint[indexComplaint] == 'kuning' ? Color.fromARGB(170, 247, 202, 24) : Color.fromARGB(170, 192, 192, 192),
                                              onPressed: () {
                                                setState(() {
                                                  bobotBantuComplaint = double.tryParse(snapshot.data.documents[0].data['bobot'].toString());
                                                  bobotComplaint.add(snapshot.data.documents[0].data['bobot_pertanyaan']);

                                                  scoreComplaint.removeAt(indexComplaint);
                                                  scoreComplaint.insert(indexComplaint, 1);
                                                  warnaComplaint.removeAt(indexComplaint);
                                                  warnaComplaint.insert(indexComplaint, 'kuning');
                                                });
                                              },
                                            ),
                                          ),
                                          alignment: Alignment(0.0, 0.0),
                                        ),
                                      ),
                                  jawabanSplitComplaint[2] == 'null'
                                    ? Container()
                                    : Tooltip(
                                        message: jawabanSplitComplaint == null ? '' : jawabanSplitComplaint[2],
                                        preferBelow: false,
                                        child: Container(
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
                                              color: warnaComplaint.length == 0 ? Color.fromARGB(170, 192, 192, 192) : warnaComplaint[indexComplaint] == 'hijau' ? Color.fromARGB(170, 50, 205, 50) : Color.fromARGB(170, 192, 192, 192),
                                              onPressed: () {
                                                setState(() {
                                                  bobotBantuComplaint = double.tryParse(snapshot.data.documents[0].data['bobot'].toString());
                                                  bobotComplaint.add(snapshot.data.documents[0].data['bobot_pertanyaan']);

                                                  scoreComplaint.removeAt(indexComplaint);
                                                  scoreComplaint.insert(indexComplaint, 2);
                                                  warnaComplaint.removeAt(indexComplaint);
                                                  warnaComplaint.insert(indexComplaint, 'hijau');
                                                });
                                              },
                                            ),
                                          ),
                                          alignment: Alignment(0.0, 0.0),
                                        ),
                                      ),
                                ],
                              ),
                            )
                          ],
                        ),
                        Container(
                          height: 65.0,
                          padding: EdgeInsets.symmetric(horizontal: 25.0, vertical: 10.0),
                          child: Row(
                            children: <Widget>[
                              Flexible(
                                child: Text(
                                  snapshot.data.documents[0].data['pertanyaan'][indexComplaint]
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    );
                  },
                )
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
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  imageComplaint.length == 2
                                    ? IconButton(
                                        icon: Icon(Icons.disc_full, color: Colors.white),
                                        onPressed: () {},
                                        tooltip: 'Max. 2 images',
                                      )
                                    : IconButton(
                                        icon: Icon(Icons.camera_alt, color: Colors.white),
                                        onPressed: () async {
                                          var selectedImage = await ImagePicker.pickImage(source: ImageSource.camera);

                                          if (imageComplaint.length == 0) {
                                            imageComplaint1 = selectedImage;
                                            filenameComplaint1 = basename(imageComplaint1.path);

                                            StorageReference strRef = FirebaseStorage.instance.ref().child(filenameComplaint1);
                                            StorageUploadTask uploadTask = strRef.putFile(imageComplaint1);

                                            var downUrl = await (await uploadTask.onComplete).ref.getDownloadURL();
                                            var url = downUrl.toString();

                                            setState(() {
                                              imageComplaint.add(filenameComplaint1);
                                              imageComplaintBantu.add(imageComplaint1);
                                              imageComplaintSave.add(url);
                                            });
                                          } else if (imageComplaint.length == 1) {
                                            imageComplaint2 = selectedImage;
                                            filenameComplaint2 = basename(imageComplaint2.path);

                                            StorageReference strRef = FirebaseStorage.instance.ref().child(filenameComplaint2);
                                            StorageUploadTask uploadTask = strRef.putFile(imageComplaint2);

                                            var downUrl = await (await uploadTask.onComplete).ref.getDownloadURL();
                                            var url = downUrl.toString();

                                            setState(() {
                                              imageComplaint.add(filenameComplaint2);
                                              imageComplaintBantu.add(imageComplaint2);
                                              imageComplaintSave.add(url);
                                            });
                                          }
                                        },
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
                                                controller: _controllerComplaint,
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
                                                  'OK',
                                                  style: TextStyle(color: Colors.green),
                                                ),
                                                onPressed: () {
                                                  if (_controllerComplaint.text != '') {
                                                    noteComplaint.add(_controllerComplaint.text);
                                                  }
                                                  Navigator.of(context).pop();
                                                },
                                              )
                                            ],
                                          );
                                        }
                                      );
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
                                      setState(() {
                                        if (indexComplaint < 1) {
                                          indexComplaint = 0;
                                        } else {
                                          indexComplaint--;
                                        }
                                      });
                                    },
                                    tooltip: 'Previous Question',
                                  ),
                                  IconButton(
                                    icon: Icon(Icons.arrow_forward_ios, color: Colors.white),
                                    onPressed: () {
                                      setState(() {
                                        if (scoreComplaint[indexComplaint] == null) {
                                          showDialog(
                                            barrierDismissible: false,
                                            context: context,
                                            builder: (context) => Dialog(
                                              child: Container(
                                                height: 180.0,
                                                child: Column(
                                                  children: <Widget>[
                                                    Container(
                                                      color: AbubaPallate.greenabuba,
                                                      height: 50.0,
                                                      child: Center(
                                                        child: Text(
                                                          'OOPS!',
                                                          style: TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 17.0,
                                                            fontWeight: FontWeight.w700),
                                                        ),
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height: 20.0,
                                                    ),
                                                    Container(
                                                      padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
                                                      child: Text(
                                                        'Please select the answer!',
                                                        style: TextStyle(
                                                          fontSize: 16.0,
                                                        ),
                                                      ),
                                                    ),
                                                    Row(
                                                      mainAxisAlignment: MainAxisAlignment.end,
                                                      children: <Widget>[
                                                        FlatButton(
                                                          child: Text('OK'),
                                                          onPressed: () {
                                                            Navigator.pop(context);
                                                          },
                                                        )
                                                      ],
                                                    )
                                                  ],
                                                ),
                                              ),
                                            )
                                          );
                                        } else {
                                          if (indexComplaint + 1 < jumlahComplaint) {
                                            indexComplaint++;
                                          } else {
                                            indexComplaint = jumlahComplaint - 1;

                                            for (int i = 0; i < scoreComplaint.length; i++) {
                                              hasilComplaint += double.tryParse(bobotComplaint[0][i].toString()) * double.tryParse(scoreComplaint[i].toString());
                                            }
                                            hasilComplaint = hasilComplaint / 2;

                                            if (hasilComplaint > 1.0) {
                                                hasilComplaint = 1.0;
                                            } else {
                                                hasilComplaint = hasilComplaint;
                                            }

                                            DocumentReference docReference = Firestore.instance.collection('mystery_shopper').document(widget.index);
                                            docReference.updateData({
                                              'complaint_score': scoreComplaint,
                                              'complaint_note': noteComplaint,
                                              'complaint_image': imageComplaintSave,
                                              'hasilComplaint': hasilComplaint,
                                            }).then((doc) {
                                              finalComplaint =hasilComplaint * bobotBantuComplaint;
                                              double finalBantu = widget.finalBantu + finalComplaint;
                                              Navigator.push(context,
                                                MyCustomRoute(
                                                  builder: (context) => FormSelesaiMakan(idOutlet: widget.idOutlet,alamatOutlet: widget.alamatOutlet,outlet: widget.outlet,imageOutlet: widget.imageOutlet,idUser: widget.idUser, idMysteryGuest: widget.idMysteryGuest, index: widget.index, finalBantu: finalBantu, aksesStatus: widget.aksesStatus)
                                                )
                                              );
                                            }).catchError((error) {
                                              print(error);
                                            });
                                          }
                                        }
                                      });
                                    },
                                    tooltip: 'Next Question',
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                        decoration: BoxDecoration(color: Color(0xFF2F592F))
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),

        ),
      ),
    );
  }
}

class FormSelesaiMakan extends StatefulWidget {
  final double finalBantu;
  final String outlet;
  final int idOutlet;
  final String imageOutlet;
  final String alamatOutlet;
  final int idUser;
  final int idMysteryGuest;
  var index;
  final String aksesStatus;
  FormSelesaiMakan(
      {this.outlet, this.imageOutlet, this.alamatOutlet, this.idOutlet, this.idUser, this.idMysteryGuest, this.index, this.finalBantu, this.aksesStatus});

  @override
  _FormSelesaiMakanState createState() => _FormSelesaiMakanState();
}

class _FormSelesaiMakanState extends State<FormSelesaiMakan> with TickerProviderStateMixin {
  AnimationController animationController;

  String get timerString {
    Duration duration = animationController.duration * animationController.value;
    return '${(duration.inSeconds % 60).toString()}';
  }

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(vsync: this, duration: Duration(seconds: 4));
    animationController.reverse(
      from: animationController.value == 0.0
        ? 1.0
        : animationController.value
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
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
        body: ListView(
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
                            'Continue',
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
                                'Bersiaplah untuk menilai proses Pre-Bushing',
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
                        AnimatedBuilder(
                          animation: animationController,
                          builder: (_, Widget child) {
                            return animationController.isAnimating
                              ? ButtonTheme(
                                  minWidth: 50.0,
                                  height: 40.0,
                                  child: RaisedButton(
                                    shape: new RoundedRectangleBorder(
                                        borderRadius: new BorderRadius.circular(5.0)),
                                    child: Text(
                                      timerString,
                                      style: TextStyle(
                                        fontSize: 18.0,
                                        color: Colors.black
                                      ),
                                    ),
                                    color: Colors.white,
                                    elevation: 0.0,
                                    onPressed: () {},
                                  ),
                                )
                              : ButtonTheme(
                                  minWidth: 50.0,
                                  height: 40.0,
                                  child: RaisedButton(
                                    shape: new RoundedRectangleBorder(
                                        borderRadius: new BorderRadius.circular(5.0)),
                                    child: Text(
                                      'CONFIRM',
                                      style: TextStyle(
                                        fontSize: 13.0,
                                        color: Colors.white
                                      ),
                                    ),
                                    color: Colors.blueAccent,
                                    onPressed: () {
                                      if (animationController.isAnimating) {

                                      } else {
                                        Navigator.push(context,
                                          MyCustomRoute(
                                            builder: (context) => FormPreBushing(idOutlet: widget.idOutlet,alamatOutlet: widget.alamatOutlet,outlet: widget.outlet,imageOutlet: widget.imageOutlet,idUser: widget.idUser, idMysteryGuest: widget.idMysteryGuest, index: widget.index, finalBantu: widget.finalBantu, aksesStatus: widget.aksesStatus)
                                          )
                                        );
                                      }
                                    },
                                  ),
                                );
                          }
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
        ),
      ),
    );
  }
}

class FormPreBushing extends StatefulWidget {
  final double finalBantu;
  final String outlet;
  final int idOutlet;
  final String imageOutlet;
  final String alamatOutlet;
  final int idUser;
  final int idMysteryGuest;
  var index;
  final String aksesStatus;
  FormPreBushing({this.outlet, this.imageOutlet, this.alamatOutlet, this.idOutlet, this.idUser, this.idMysteryGuest, this.index, this.finalBantu, this.aksesStatus});

  @override
  _FormPreBushingState createState() => _FormPreBushingState();
}

class _FormPreBushingState extends State<FormPreBushing> with TickerProviderStateMixin {
  List<Map> _listData = [
    {'nomor': '11'}
  ];

  int indexPreBushing = 0;
  int jumlahPreBushing = 0;
  List<int> scorePreBushing = [];
  List<String> jawabanSplitPreBushing;
  List<String> warnaPreBushing = [];
  List<String> notePreBushing = [];
  List<dynamic> bobotPreBushing = [];
  double hasilPreBushing = 0.0;
  double bobotBantuPreBushing = 0.0;
  double finalPreBushing = 0.0;
  List<String> imagePreBushing = [];
  List<File> imagePreBushingBantu = [];
  File imagePreBushing1;
  File imagePreBushing2;
  String filenamePreBushing1;
  String filenamePreBushing2;
  List<String> imagePreBushingSave = [];
  TextEditingController _controllerPreBushing = TextEditingController();

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
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
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
                                              '1. Pre-Bushing',
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
                          Container(
                            color: Colors.white,
                            child: StreamBuilder(
                              stream: Firestore.instance
                                  .collection('pre-bushing')
                                  .snapshots(),
                              builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                                if (!snapshot.hasData && snapshot.data == null)
                                  return Container(
                                    child: Center(
                                      child: CircularProgressIndicator(),
                                    ),
                                  );
                                jumlahPreBushing = snapshot.data.documents[0].data['pertanyaan'].length;
                                jawabanSplitPreBushing = snapshot.data.documents[0].data['jawaban'][indexPreBushing].split(r"!@#$");

                                if (scorePreBushing.length < jumlahPreBushing) {
                                  for (int a = 0; a < jumlahPreBushing; a++) {
                                    scorePreBushing.add(null);
                                    warnaPreBushing.add('abu');
                                  }
                                }

                                return Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    Stack(
                                      children: <Widget>[
                                        Image.asset(
                                          'assets/images/Pre Bushing.jpeg',
                                          fit: BoxFit.cover,
                                          height: MediaQuery.of(context).size.height / 1.55777,
                                        ),
                                        Positioned(
                                          bottom: 20.0,
                                          width: MediaQuery.of(context).size.width,
                                          child: Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                            children: <Widget>[
                                              jawabanSplitPreBushing[0] == 'null'
                                                ? Container()
                                                : Tooltip(
                                                    message: jawabanSplitPreBushing == null ? '' : jawabanSplitPreBushing[0],
                                                    preferBelow: false,
                                                    child: Container(
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
                                                          color: warnaPreBushing.length == 0 ? Color.fromARGB(170, 192, 192, 192) : warnaPreBushing[indexPreBushing] == 'merah' ? Color.fromARGB(170, 255, 40, 0) : Color.fromARGB(170, 192, 192, 192),
                                                          onPressed: () {
                                                            setState(() {
                                                              bobotBantuPreBushing = double.tryParse(snapshot.data.documents[0].data['bobot'].toString());
                                                              bobotPreBushing.add(snapshot.data.documents[0].data['bobot_pertanyaan']);

                                                              scorePreBushing.removeAt(indexPreBushing);
                                                              scorePreBushing.insert(indexPreBushing, 0);
                                                              warnaPreBushing.removeAt(indexPreBushing);
                                                              warnaPreBushing.insert(indexPreBushing, 'merah');
                                                            });
                                                          },
                                                        ),
                                                      ),
                                                      alignment: Alignment(0.0, 0.0),
                                                    ),
                                                  ),
                                              jawabanSplitPreBushing[1] == 'null'
                                                ? Container()
                                                : Tooltip(
                                                    message: jawabanSplitPreBushing == null ? '' : jawabanSplitPreBushing[1],
                                                    preferBelow: false,
                                                    child: Container(
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
                                                          color: warnaPreBushing.length == 0 ? Color.fromARGB(170, 192, 192, 192) : warnaPreBushing[indexPreBushing] == 'kuning' ? Color.fromARGB(170, 247, 202, 24) : Color.fromARGB(170, 192, 192, 192),
                                                          onPressed: () {
                                                            setState(() {
                                                              bobotBantuPreBushing = double.tryParse(snapshot.data.documents[0].data['bobot'].toString());
                                                              bobotPreBushing.add(snapshot.data.documents[0].data['bobot_pertanyaan']);

                                                              scorePreBushing.removeAt(indexPreBushing);
                                                              scorePreBushing.insert(indexPreBushing, 1);
                                                              warnaPreBushing.removeAt(indexPreBushing);
                                                              warnaPreBushing.insert(indexPreBushing, 'kuning');
                                                            });
                                                          },
                                                        ),
                                                      ),
                                                      alignment: Alignment(0.0, 0.0),
                                                    ),
                                                  ),
                                              jawabanSplitPreBushing[2] == 'null'
                                                ? Container()
                                                : Tooltip(
                                                    message: jawabanSplitPreBushing == null ? '' : jawabanSplitPreBushing[2],
                                                    preferBelow: false,
                                                    child: Container(
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
                                                          color: warnaPreBushing.length == 0 ? Color.fromARGB(170, 192, 192, 192) : warnaPreBushing[indexPreBushing] == 'hijau' ? Color.fromARGB(170, 50, 205, 50) : Color.fromARGB(170, 192, 192, 192),
                                                          onPressed: () {
                                                            setState(() {
                                                              bobotBantuPreBushing = double.tryParse(snapshot.data.documents[0].data['bobot'].toString());
                                                              bobotPreBushing.add(snapshot.data.documents[0].data['bobot_pertanyaan']);

                                                              scorePreBushing.removeAt(indexPreBushing);
                                                              scorePreBushing.insert(indexPreBushing, 2);
                                                              warnaPreBushing.removeAt(indexPreBushing);
                                                              warnaPreBushing.insert(indexPreBushing, 'hijau');
                                                            });
                                                          },
                                                        ),
                                                      ),
                                                      alignment: Alignment(0.0, 0.0),
                                                    ),
                                                  ),
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                    Container(
                                      height: 65.0,
                                      padding: EdgeInsets.symmetric(horizontal: 25.0, vertical: 10.0),
                                      child: Row(
                                        children: <Widget>[
                                          Flexible(
                                            child: Text(
                                              snapshot.data.documents[0].data['pertanyaan'][indexPreBushing]
                                            ),
                                          )
                                        ],
                                      ),
                                    )
                                  ],
                                );
                              },
                            )
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
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: <Widget>[
                                              imagePreBushing.length == 2
                                                ? IconButton(
                                                    icon: Icon(Icons.disc_full, color: Colors.white),
                                                    onPressed: () {},
                                                    tooltip: 'Max. 2 images',
                                                  )
                                                : IconButton(
                                                    icon: Icon(Icons.camera_alt, color: Colors.white),
                                                    onPressed: () async {
                                                      var selectedImage = await ImagePicker.pickImage(source: ImageSource.camera);

                                                      if (imagePreBushing.length == 0) {
                                                        imagePreBushing1 = selectedImage;
                                                        filenamePreBushing1 = basename(imagePreBushing1.path);

                                                        StorageReference strRef = FirebaseStorage.instance.ref().child(filenamePreBushing1);
                                                        StorageUploadTask uploadTask = strRef.putFile(imagePreBushing1);

                                                        var downUrl = await (await uploadTask.onComplete).ref.getDownloadURL();
                                                        var url = downUrl.toString();

                                                        setState(() {
                                                          imagePreBushing.add(filenamePreBushing1);
                                                          imagePreBushingBantu.add(imagePreBushing1);
                                                          imagePreBushingSave.add(url);
                                                        });
                                                      } else if (imagePreBushing.length == 1) {
                                                        imagePreBushing2 = selectedImage;
                                                        filenamePreBushing2 = basename(imagePreBushing2.path);

                                                        StorageReference strRef = FirebaseStorage.instance.ref().child(filenamePreBushing2);
                                                        StorageUploadTask uploadTask = strRef.putFile(imagePreBushing2);

                                                        var downUrl = await (await uploadTask.onComplete).ref.getDownloadURL();
                                                        var url = downUrl.toString();

                                                        setState(() {
                                                          imagePreBushing.add(filenamePreBushing2);
                                                          imagePreBushingBantu.add(imagePreBushing2);
                                                          imagePreBushingSave.add(url);
                                                        });
                                                      }
                                                    },
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
                                                            controller: _controllerPreBushing,
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
                                                              'OK',
                                                              style: TextStyle(color: Colors.green),
                                                            ),
                                                            onPressed: () {
                                                              if (_controllerPreBushing.text != '') {
                                                                notePreBushing.add(_controllerPreBushing.text);
                                                              }
                                                              Navigator.of(context).pop();
                                                            },
                                                          )
                                                        ],
                                                      );
                                                    }
                                                  );
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
                                                  setState(() {
                                                    if (indexPreBushing < 1) {
                                                      indexPreBushing = 0;
                                                    } else {
                                                      indexPreBushing--;
                                                    }
                                                  });
                                                },
                                                tooltip: 'Previous Question',
                                              ),
                                              IconButton(
                                                icon: Icon(Icons.arrow_forward_ios, color: Colors.white),
                                                onPressed: () {
                                                  setState(() {
                                                    if (scorePreBushing[indexPreBushing] == null) {
                                                      showDialog(
                                                        barrierDismissible: false,
                                                        context: context,
                                                        builder: (context) => Dialog(
                                                          child: Container(
                                                            height: 180.0,
                                                            child: Column(
                                                              children: <Widget>[
                                                                Container(
                                                                  color: AbubaPallate.greenabuba,
                                                                  height: 50.0,
                                                                  child: Center(
                                                                    child: Text(
                                                                      'OOPS!',
                                                                      style: TextStyle(
                                                                        color: Colors.white,
                                                                        fontSize: 17.0,
                                                                        fontWeight: FontWeight.w700),
                                                                    ),
                                                                  ),
                                                                ),
                                                                SizedBox(
                                                                  height: 20.0,
                                                                ),
                                                                Container(
                                                                  padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
                                                                  child: Text(
                                                                    'Please select the answer!',
                                                                    style: TextStyle(
                                                                      fontSize: 16.0,
                                                                    ),
                                                                  ),
                                                                ),
                                                                Row(
                                                                  mainAxisAlignment: MainAxisAlignment.end,
                                                                  children: <Widget>[
                                                                    FlatButton(
                                                                      child: Text('OK'),
                                                                      onPressed: () {
                                                                        Navigator.pop(context);
                                                                      },
                                                                    )
                                                                  ],
                                                                )
                                                              ],
                                                            ),
                                                          ),
                                                        )
                                                      );
                                                    } else {
                                                      if (indexPreBushing + 1 < jumlahPreBushing) {
                                                        indexPreBushing++;
                                                      } else {
                                                        indexPreBushing = jumlahPreBushing - 1;

                                                        for (int i = 0; i < scorePreBushing.length; i++) {
                                                          hasilPreBushing += double.tryParse(bobotPreBushing[0][i].toString()) * double.tryParse(scorePreBushing[i].toString());
                                                        }
                                                        hasilPreBushing = hasilPreBushing / 2;

                                                        if (hasilPreBushing > 1.0) {
                                                            hasilPreBushing = 1.0;
                                                        } else {
                                                            hasilPreBushing = hasilPreBushing;
                                                        }

                                                        DocumentReference docReference = Firestore.instance.collection('mystery_shopper').document(widget.index);
                                                        docReference.updateData({
                                                          'preBushing_score': scorePreBushing,
                                                          'preBushing_note': notePreBushing,
                                                          'preBushing_image': imagePreBushingSave,
                                                          'hasilPreBushing': hasilPreBushing
                                                        }).then((doc) {
                                                          finalPreBushing =hasilPreBushing * bobotBantuPreBushing;
                                                          double finalBantu = widget.finalBantu + finalPreBushing;
                                                          Navigator.push(context,
                                                            MaterialPageRoute(
                                                              builder: (_) => FormLanjutReview(index: widget.index, idUser: widget.idUser, finalBantu: finalBantu, imageOutlet: widget.imageOutlet, aksesStatus: widget.aksesStatus),
                                                            )
                                                          );
                                                        }).catchError((error) {
                                                          print(error);
                                                        });
                                                      }
                                                    }
                                                  });
                                                },
                                                tooltip: 'Next Question',
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                    decoration: BoxDecoration(color: Color(0xFF2F592F))
                                  ),
                                )
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
}

class FormLanjutReview extends StatefulWidget {
  final double finalBantu;
  final String outlet;
  final int idOutlet;
  final String imageOutlet;
  final String alamatOutlet;
  final int idUser;
  final int idMysteryGuest;
  var index;
  final String aksesStatus;
  FormLanjutReview(
      {this.outlet, this.imageOutlet, this.alamatOutlet, this.idOutlet, this.idUser, this.idMysteryGuest, this.index, this.finalBantu, this.aksesStatus});

  @override
  _FormLanjutReviewState createState() => _FormLanjutReviewState();
}

class _FormLanjutReviewState extends State<FormLanjutReview> with TickerProviderStateMixin {
  AnimationController animationController;

  String get timerString {
    Duration duration = animationController.duration * animationController.value;
    return '${(duration.inSeconds % 60).toString()}';
  }

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(vsync: this, duration: Duration(seconds: 4));
    animationController.reverse(
      from: animationController.value == 0.0
        ? 1.0
        : animationController.value
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
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
        body: ListView(
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
                            'Continue',
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
                                'Saatnya Periksa Kebersihan',
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
                                'Pergilah ke mushola, toilet, dan washtafel lalu kembali duduk di kursi Anda',
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
                        AnimatedBuilder(
                          animation: animationController,
                          builder: (_, Widget child) {
                            return animationController.isAnimating
                              ? ButtonTheme(
                                  minWidth: 50.0,
                                  height: 40.0,
                                  child: RaisedButton(
                                    shape: new RoundedRectangleBorder(
                                        borderRadius: new BorderRadius.circular(5.0)),
                                    child: Text(
                                      timerString,
                                      style: TextStyle(
                                        fontSize: 18.0,
                                        color: Colors.black
                                      ),
                                    ),
                                    color: Colors.white,
                                    elevation: 0.0,
                                    onPressed: () {},
                                  ),
                                )
                              : ButtonTheme(
                                  minWidth: 50.0,
                                  height: 40.0,
                                  child: RaisedButton(
                                    shape: new RoundedRectangleBorder(
                                        borderRadius: new BorderRadius.circular(5.0)),
                                    child: Text(
                                      'CONFIRM',
                                      style: TextStyle(
                                        fontSize: 13.0,
                                        color: Colors.white
                                      ),
                                    ),
                                    color: Colors.blueAccent,
                                    onPressed: () {
                                      if (animationController.isAnimating) {

                                      } else {
                                        Navigator.push(context,
                                          MyCustomRoute(
                                            builder: (context) => FormCleanliness(idOutlet: widget.idOutlet,alamatOutlet: widget.alamatOutlet,outlet: widget.outlet,imageOutlet: widget.imageOutlet,idUser: widget.idUser, idMysteryGuest: widget.idMysteryGuest, index: widget.index, finalBantu: widget.finalBantu, aksesStatus: widget.aksesStatus)
                                          )
                                        );
                                      }
                                    },
                                  ),
                                );
                          }
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
        ),
      ),
    );
  }
}

class FormCleanliness extends StatefulWidget {
  final double finalBantu;
  final String outlet;
  final int idOutlet;
  final String imageOutlet;
  final String alamatOutlet;
  final int idUser;
  final int idMysteryGuest;
  var index;
  final String aksesStatus;
  FormCleanliness(
      {this.outlet, this.imageOutlet, this.alamatOutlet, this.idOutlet, this.idUser, this.idMysteryGuest, this.index, this.finalBantu, this.aksesStatus});

  @override
  _FormCleanlinessState createState() => _FormCleanlinessState();
}

class _FormCleanlinessState extends State<FormCleanliness> with TickerProviderStateMixin {
  List<Map> _listData = [
    {'nomor': '12'},
  ];

  int indexCleanliness = 0;
  int jumlahCleanliness = 0;
  List<int> scoreCleanliness = [];
  List<String> jawabanSplitCleanliness;
  List<String> warnaCleanliness = [];
  List<String> noteCleanliness = [];
  List<dynamic> bobotCleanliness = [];
  double hasilCleanliness = 0.0;
  double bobotBantuCleanliness = 0.0;
  double finalCleanliness = 0.0;

  List<String> imageCleanliness = [];
  List<File> imageCleanlinessBantu = [];
  File imageCleanliness1;
  File imageCleanliness2;
  String filenameCleanliness1;
  String filenameCleanliness2;
  List<String> imageCleanlinessSave = [];

  TextEditingController _controllerCleanliness = TextEditingController();

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
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
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
                                              '1. Cleanliness',
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
                          Container(
                            color: Colors.white,
                            child: StreamBuilder(
                              stream: Firestore.instance
                                  .collection('cleaniness')
                                  .snapshots(),
                              builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                                if (!snapshot.hasData && snapshot.data == null)
                                  return Container(
                                    child: Center(
                                      child: CircularProgressIndicator(),
                                    ),
                                  );
                                jumlahCleanliness = snapshot.data.documents[0].data['pertanyaan'].length;
                                jawabanSplitCleanliness = snapshot.data.documents[0].data['jawaban'][indexCleanliness].split(r"!@#$");

                                if (scoreCleanliness.length < jumlahCleanliness) {
                                  for (int a = 0; a < jumlahCleanliness; a++) {
                                    scoreCleanliness.add(null);
                                    warnaCleanliness.add('abu');
                                  }
                                }

                                String imageFile;
                                if (indexCleanliness == 2) {
                                  imageFile = 'assets/images/abuba4.jpg';
                                } else if (indexCleanliness == 3) {
                                  imageFile = 'assets/images/abuba5.jpg';
                                } else if (indexCleanliness == 4) {
                                  imageFile = 'assets/images/abuba4.jpg';
                                } else {
                                  imageFile = 'assets/images/slide 25.png';
                                }

                                return Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    Stack(
                                      children: <Widget>[
                                        Image.asset(
                                          imageFile,
                                          fit: BoxFit.cover,
                                          height: MediaQuery.of(context).size.height / 1.55777,
                                        ),
                                        Positioned(
                                          bottom: 20.0,
                                          width: MediaQuery.of(context).size.width,
                                          child: Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                            children: <Widget>[
                                              jawabanSplitCleanliness[0] == 'null'
                                                ? Container()
                                                : Tooltip(
                                                    message: jawabanSplitCleanliness == null ? '' : jawabanSplitCleanliness[0],
                                                    preferBelow: false,
                                                    child: Container(
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
                                                          color: warnaCleanliness.length == 0 ? Color.fromARGB(170, 192, 192, 192) : warnaCleanliness[indexCleanliness] == 'merah' ? Color.fromARGB(170, 255, 40, 0) : Color.fromARGB(170, 192, 192, 192),
                                                          onPressed: () {
                                                            setState(() {
                                                              bobotBantuCleanliness = double.tryParse(snapshot.data.documents[0].data['bobot'].toString());
                                                              bobotCleanliness.add(snapshot.data.documents[0].data['bobot_pertanyaan']);

                                                              scoreCleanliness.removeAt(indexCleanliness);
                                                              scoreCleanliness.insert(indexCleanliness, 0);
                                                              warnaCleanliness.removeAt(indexCleanliness);
                                                              warnaCleanliness.insert(indexCleanliness, 'merah');
                                                            });
                                                          },
                                                        ),
                                                      ),
                                                      alignment: Alignment(0.0, 0.0),
                                                    ),
                                                  ),
                                              jawabanSplitCleanliness[1] == 'null'
                                                ? Container()
                                                : Tooltip(
                                                    message: jawabanSplitCleanliness == null ? '' : jawabanSplitCleanliness[1],
                                                    preferBelow: false,
                                                    child: Container(
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
                                                          color: warnaCleanliness.length == 0 ? Color.fromARGB(170, 192, 192, 192) : warnaCleanliness[indexCleanliness] == 'kuning' ? Color.fromARGB(170, 247, 202, 24) : Color.fromARGB(170, 192, 192, 192),
                                                          onPressed: () {
                                                            setState(() {
                                                              bobotBantuCleanliness = double.tryParse(snapshot.data.documents[0].data['bobot'].toString());
                                                              bobotCleanliness.add(snapshot.data.documents[0].data['bobot_pertanyaan']);

                                                              scoreCleanliness.removeAt(indexCleanliness);
                                                              scoreCleanliness.insert(indexCleanliness, 1);
                                                              warnaCleanliness.removeAt(indexCleanliness);
                                                              warnaCleanliness.insert(indexCleanliness, 'kuning');
                                                            });
                                                          },
                                                        ),
                                                      ),
                                                      alignment: Alignment(0.0, 0.0),
                                                    ),
                                                  ),
                                              jawabanSplitCleanliness[2] == 'null'
                                                ? Container()
                                                : Tooltip(
                                                    message: jawabanSplitCleanliness == null ? '' : jawabanSplitCleanliness[2],
                                                    preferBelow: false,
                                                    child: Container(
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
                                                          color: warnaCleanliness.length == 0 ? Color.fromARGB(170, 192, 192, 192) : warnaCleanliness[indexCleanliness] == 'hijau' ? Color.fromARGB(170, 50, 205, 50) : Color.fromARGB(170, 192, 192, 192),
                                                          onPressed: () {
                                                            setState(() {
                                                              bobotBantuCleanliness = double.tryParse(snapshot.data.documents[0].data['bobot'].toString());
                                                              bobotCleanliness.add(snapshot.data.documents[0].data['bobot_pertanyaan']);

                                                              scoreCleanliness.removeAt(indexCleanliness);
                                                              scoreCleanliness.insert(indexCleanliness, 2);
                                                              warnaCleanliness.removeAt(indexCleanliness);
                                                              warnaCleanliness.insert(indexCleanliness, 'hijau');
                                                            });
                                                          },
                                                        ),
                                                      ),
                                                      alignment: Alignment(0.0, 0.0),
                                                    ),
                                                  ),
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                    Container(
                                      height: 65.0,
                                      padding: EdgeInsets.symmetric(horizontal: 25.0, vertical: 10.0),
                                      child: Row(
                                        children: <Widget>[
                                          Flexible(
                                            child: Text(
                                              snapshot.data.documents[0].data['pertanyaan'][indexCleanliness]
                                            ),
                                          )
                                        ],
                                      ),
                                    )
                                  ],
                                );
                              },
                            )
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
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: <Widget>[
                                              imageCleanliness.length == 2
                                                ? IconButton(
                                                    icon: Icon(Icons.disc_full, color: Colors.white),
                                                    onPressed: () {},
                                                    tooltip: 'Max. 2 images',
                                                  )
                                                : IconButton(
                                                    icon: Icon(Icons.camera_alt, color: Colors.white),
                                                    onPressed: () async {
                                                      var selectedImage = await ImagePicker.pickImage(source: ImageSource.camera);

                                                      if (imageCleanliness.length == 0) {
                                                        imageCleanliness1 = selectedImage;
                                                        filenameCleanliness1 = basename(imageCleanliness1.path);

                                                        StorageReference strRef = FirebaseStorage.instance.ref().child(filenameCleanliness1);
                                                        StorageUploadTask uploadTask = strRef.putFile(imageCleanliness1);

                                                        var downUrl = await (await uploadTask.onComplete).ref.getDownloadURL();
                                                        var url = downUrl.toString();

                                                        setState(() {
                                                          imageCleanliness.add(filenameCleanliness1);
                                                          imageCleanlinessBantu.add(imageCleanliness1);
                                                          imageCleanlinessSave.add(url);
                                                        });
                                                      } else if (imageCleanliness.length == 1) {
                                                        imageCleanliness2 = selectedImage;
                                                        filenameCleanliness2 = basename(imageCleanliness2.path);

                                                        StorageReference strRef = FirebaseStorage.instance.ref().child(filenameCleanliness2);
                                                        StorageUploadTask uploadTask = strRef.putFile(imageCleanliness2);

                                                        var downUrl = await (await uploadTask.onComplete).ref.getDownloadURL();
                                                        var url = downUrl.toString();

                                                        setState(() {
                                                          imageCleanliness.add(filenameCleanliness2);
                                                          imageCleanlinessBantu.add(imageCleanliness2);
                                                          imageCleanlinessSave.add(url);
                                                        });
                                                      }
                                                    },
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
                                                            controller: _controllerCleanliness,
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
                                                              'OK',
                                                              style: TextStyle(color: Colors.green),
                                                            ),
                                                            onPressed: () {
                                                              if (_controllerCleanliness.text != '') {
                                                                noteCleanliness.add(_controllerCleanliness.text);
                                                              }
                                                              Navigator.of(context).pop();
                                                            },
                                                          )
                                                        ],
                                                      );
                                                    }
                                                  );
                                                },
                                              ),
                                            ],
                                          ),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: <Widget>[
                                              IconButton(
                                                icon: Icon(Icons.arrow_forward_ios, color: Colors.white),
                                                onPressed: () {
                                                  setState(() {
                                                    if (scoreCleanliness[indexCleanliness] == null) {
                                                      showDialog(
                                                        barrierDismissible: false,
                                                        context: context,
                                                        builder: (context) => Dialog(
                                                          child: Container(
                                                            height: 180.0,
                                                            child: Column(
                                                              children: <Widget>[
                                                                Container(
                                                                  color: AbubaPallate.greenabuba,
                                                                  height: 50.0,
                                                                  child: Center(
                                                                    child: Text(
                                                                      'OOPS!',
                                                                      style: TextStyle(
                                                                        color: Colors.white,
                                                                        fontSize: 17.0,
                                                                        fontWeight: FontWeight.w700),
                                                                    ),
                                                                  ),
                                                                ),
                                                                SizedBox(
                                                                  height: 20.0,
                                                                ),
                                                                Container(
                                                                  padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
                                                                  child: Text(
                                                                    'Please select the answer!',
                                                                    style: TextStyle(
                                                                      fontSize: 16.0,
                                                                    ),
                                                                  ),
                                                                ),
                                                                Row(
                                                                  mainAxisAlignment: MainAxisAlignment.end,
                                                                  children: <Widget>[
                                                                    FlatButton(
                                                                      child: Text('OK'),
                                                                      onPressed: () {
                                                                        Navigator.pop(context);
                                                                      },
                                                                    )
                                                                  ],
                                                                )
                                                              ],
                                                            ),
                                                          ),
                                                        )
                                                      );
                                                    } else {
                                                      if (indexCleanliness + 1 < jumlahCleanliness) {
                                                        indexCleanliness++;
                                                      } else {
                                                        indexCleanliness = jumlahCleanliness - 1;

                                                        for (int i = 0; i < scoreCleanliness.length; i++) {
                                                          hasilCleanliness += double.tryParse(bobotCleanliness[0][i].toString()) * double.tryParse(scoreCleanliness[i].toString());
                                                        }
                                                        hasilCleanliness = hasilCleanliness / 2;

                                                        if (hasilCleanliness > 1.0) {
                                                            hasilCleanliness = 1.0;
                                                        } else {
                                                            hasilCleanliness = hasilCleanliness;
                                                        }

                                                        DocumentReference docReference = Firestore.instance.collection('mystery_shopper').document(widget.index);
                                                        docReference.updateData({
                                                          'cleanliness_score': scoreCleanliness,
                                                          'cleanliness_note': noteCleanliness,
                                                          'cleanliness_image': imageCleanlinessSave,
                                                          'hasilCleanliness': hasilCleanliness
                                                        }).then((doc) {
                                                          finalCleanliness =hasilCleanliness * bobotBantuCleanliness;
                                                          double finalBantu = widget.finalBantu + finalCleanliness;
                                                          Navigator.push(context,
                                                            MaterialPageRoute(
                                                              builder: (_) => FormSedikitLagiAfterClean(index: widget.index, idUser: widget.idUser, finalBantu: finalBantu, imageOutlet: widget.imageOutlet, aksesStatus: widget.aksesStatus),
                                                            )
                                                          );
                                                        }).catchError((error) {
                                                          print(error);
                                                        });
                                                      }
                                                    }
                                                  });
                                                },
                                                tooltip: 'Next Question',
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                    decoration: BoxDecoration(color: Color(0xFF2F592F))
                                  ),
                                )
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
}

class FormSedikitLagiAfterClean extends StatefulWidget {
  final double finalBantu;
  final String outlet;
  final int idOutlet;
  final String imageOutlet;
  final String alamatOutlet;
  final int idUser;
  final int idMysteryGuest;
  var index;
  final String aksesStatus;
  FormSedikitLagiAfterClean(
      {this.outlet, this.imageOutlet, this.alamatOutlet, this.idOutlet, this.idUser, this.idMysteryGuest, this.index, this.finalBantu, this.aksesStatus});

  @override
  _FormSedikitLagiAfterCleanState createState() => _FormSedikitLagiAfterCleanState();
}

class _FormSedikitLagiAfterCleanState extends State<FormSedikitLagiAfterClean> with TickerProviderStateMixin {
  AnimationController animationController;

  String get timerString {
    Duration duration = animationController.duration * animationController.value;
    return '${(duration.inSeconds % 60).toString()}';
  }

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(vsync: this, duration: Duration(seconds: 4));
    animationController.reverse(
      from: animationController.value == 0.0
        ? 1.0
        : animationController.value
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
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
        body: ListView(
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
                            'Continue',
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
                                'Lakukan pembayaran, amati pelayanan saat meninggalkan resto. Lanjutkan penilaian di mobil Anda',
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
                        AnimatedBuilder(
                          animation: animationController,
                          builder: (_, Widget child) {
                            return animationController.isAnimating
                              ? ButtonTheme(
                                  minWidth: 50.0,
                                  height: 40.0,
                                  child: RaisedButton(
                                    shape: new RoundedRectangleBorder(
                                        borderRadius: new BorderRadius.circular(5.0)),
                                    child: Text(
                                      timerString,
                                      style: TextStyle(
                                        fontSize: 18.0,
                                        color: Colors.black
                                      ),
                                    ),
                                    color: Colors.white,
                                    elevation: 0.0,
                                    onPressed: () {},
                                  ),
                                )
                              : ButtonTheme(
                                  minWidth: 50.0,
                                  height: 40.0,
                                  child: RaisedButton(
                                    shape: new RoundedRectangleBorder(
                                        borderRadius: new BorderRadius.circular(5.0)),
                                    child: Text(
                                      'CONFIRM',
                                      style: TextStyle(
                                        fontSize: 13.0,
                                        color: Colors.white
                                      ),
                                    ),
                                    color: Colors.blueAccent,
                                    onPressed: () {
                                      if (animationController.isAnimating) {

                                      } else {
                                        Navigator.push(context,
                                          MyCustomRoute(
                                            builder: (context) => FormTableSetting(idOutlet: widget.idOutlet,alamatOutlet: widget.alamatOutlet,outlet: widget.outlet,imageOutlet: widget.imageOutlet,idUser: widget.idUser, idMysteryGuest: widget.idMysteryGuest, index: widget.index, finalBantu: widget.finalBantu, aksesStatus: widget.aksesStatus)
                                          )
                                        );
                                      }
                                    },
                                  ),
                                );
                          }
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
        ),
      ),
    );
  }
}

class FormTableSetting extends StatefulWidget {
  final double finalBantu;
  final String outlet;
  final int idOutlet;
  final String imageOutlet;
  final String alamatOutlet;
  final int idUser;
  final int idMysteryGuest;
  var index;
  final String aksesStatus;
  FormTableSetting(
      {this.outlet, this.imageOutlet, this.alamatOutlet, this.idOutlet, this.idUser, this.idMysteryGuest, this.index, this.finalBantu, this.aksesStatus});

  @override
  _FormTableSettingState createState() => _FormTableSettingState();
}

class _FormTableSettingState extends State<FormTableSetting> with TickerProviderStateMixin {
  List<Map> _listData = [
    {'nomor': '11'},
    {'nomor': '12'},
    {'nomor': '13'}
  ];

  int indexBilling = 0;
  int jumlahBilling = 0;
  List<int> scoreBilling = [];
  List<String> jawabanSplitBilling;
  List<String> warnaBilling = [];
  List<String> noteBilling = [];
  List<dynamic> bobotBilling = [];
  double hasilBilling = 0.0;
  double bobotBantuBilling = 0.0;
  double finalBilling = 0.0;
  TextEditingController _controllerBilling = TextEditingController();

  List<String> imageBilling = [];
  List<File> imageBillingBantu = [];
  File imageBilling1;
  String filenameBilling1;
  List<String> imageBillingSave = [];

  int indexThanking = 0;
  int jumlahThanking = 0;
  List<int> scoreThanking = [];
  List<String> jawabanSplitThanking;
  List<String> warnaThanking = [];
  List<String> noteThanking = [];
  List<dynamic> bobotThanking = [];
  double hasilThanking = 0.0;
  double bobotBantuThanking = 0.0;
  double finalThanking = 0.0;
  TextEditingController _controllerThanking = TextEditingController();

  int indexParking = 0;
  int jumlahParking = 0;
  List<int> scoreParking = [];
  List<String> jawabanSplitParking;
  List<String> warnaParking = [];
  List<String> noteParking = [];
  List<dynamic> bobotParking = [];
  double hasilParking = 0.0;
  double bobotBantuParking = 0.0;
  double finalParking = 0.0;

  List<String> imageParking = [];
  List<File> imageParkingBantu = [];
  File imageParking1;
  File imageParking2;
  String filenameParking1;
  String filenameParking2;
  List<String> imageParkingSave = [];

  TextEditingController _controllerParking = TextEditingController();

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
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
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
                                            '1. Billing',
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
                          Container(
                            color: Colors.white,
                            child: StreamBuilder(
                              stream: Firestore.instance
                                  .collection('billing')
                                  .snapshots(),
                              builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                                if (!snapshot.hasData && snapshot.data == null)
                                  return Container(
                                    child: Center(
                                      child: CircularProgressIndicator(),
                                    ),
                                  );
                                jumlahBilling = snapshot.data.documents[0].data['pertanyaan'].length;
                                jawabanSplitBilling = snapshot.data.documents[0].data['jawaban'][indexBilling].split(r"!@#$");

                                if (scoreBilling.length < jumlahBilling) {
                                  for (int a = 0; a < jumlahBilling; a++) {
                                    scoreBilling.add(null);
                                    warnaBilling.add('abu');
                                  }
                                }

                                return Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    Stack(
                                      children: <Widget>[
                                        Image.asset(
                                          'assets/images/Billing.jpeg',
                                          fit: BoxFit.cover,
                                          height: MediaQuery.of(context).size.height / 1.55777,
                                        ),
                                        Positioned(
                                          bottom: 20.0,
                                          width: MediaQuery.of(context).size.width,
                                          child: Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                            children: <Widget>[
                                              jawabanSplitBilling[0] == 'null'
                                                ? Container()
                                                : Tooltip(
                                                    message: jawabanSplitBilling == null ? '' : jawabanSplitBilling[0],
                                                    preferBelow: false,
                                                    child: Container(
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
                                                          color: warnaBilling.length == 0 ? Color.fromARGB(170, 192, 192, 192) : warnaBilling[indexBilling] == 'merah' ? Color.fromARGB(170, 255, 40, 0) : Color.fromARGB(170, 192, 192, 192),
                                                          onPressed: () {
                                                            setState(() {
                                                              bobotBantuBilling = double.tryParse(snapshot.data.documents[0].data['bobot'].toString());
                                                              bobotBilling.add(snapshot.data.documents[0].data['bobot_pertanyaan']);

                                                              scoreBilling.removeAt(indexBilling);
                                                              scoreBilling.insert(indexBilling, 0);
                                                              warnaBilling.removeAt(indexBilling);
                                                              warnaBilling.insert(indexBilling, 'merah');
                                                            });
                                                          },
                                                        ),
                                                      ),
                                                      alignment: Alignment(0.0, 0.0),
                                                    ),
                                                  ),
                                              jawabanSplitBilling[1] == 'null'
                                                ? Container()
                                                : Tooltip(
                                                    message: jawabanSplitBilling == null ? '' : jawabanSplitBilling[1],
                                                    preferBelow: false,
                                                    child: Container(
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
                                                          color: warnaBilling.length == 0 ? Color.fromARGB(170, 192, 192, 192) : warnaBilling[indexBilling] == 'kuning' ? Color.fromARGB(170, 247, 202, 24) : Color.fromARGB(170, 192, 192, 192),
                                                          onPressed: () {
                                                            setState(() {
                                                              bobotBantuBilling = double.tryParse(snapshot.data.documents[0].data['bobot'].toString());
                                                              bobotBilling.add(snapshot.data.documents[0].data['bobot_pertanyaan']);

                                                              scoreBilling.removeAt(indexBilling);
                                                              scoreBilling.insert(indexBilling, 1);
                                                              warnaBilling.removeAt(indexBilling);
                                                              warnaBilling.insert(indexBilling, 'kuning');
                                                            });
                                                          },
                                                        ),
                                                      ),
                                                      alignment: Alignment(0.0, 0.0),
                                                    ),
                                                  ),
                                              jawabanSplitBilling[2] == 'null'
                                                ? Container()
                                                : Tooltip(
                                                    message: jawabanSplitBilling == null ? '' : jawabanSplitBilling[2],
                                                    preferBelow: false,
                                                    child: Container(
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
                                                          color: warnaBilling.length == 0 ? Color.fromARGB(170, 192, 192, 192) : warnaBilling[indexBilling] == 'hijau' ? Color.fromARGB(170, 50, 205, 50) : Color.fromARGB(170, 192, 192, 192),
                                                          onPressed: () {
                                                            setState(() {
                                                              bobotBantuBilling = double.tryParse(snapshot.data.documents[0].data['bobot'].toString());
                                                              bobotBilling.add(snapshot.data.documents[0].data['bobot_pertanyaan']);

                                                              scoreBilling.removeAt(indexBilling);
                                                              scoreBilling.insert(indexBilling, 2);
                                                              warnaBilling.removeAt(indexBilling);
                                                              warnaBilling.insert(indexBilling, 'hijau');
                                                            });
                                                          },
                                                        ),
                                                      ),
                                                      alignment: Alignment(0.0, 0.0),
                                                    ),
                                                  ),
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                    Container(
                                      height: 65.0,
                                      padding: EdgeInsets.symmetric(horizontal: 25.0, vertical: 10.0),
                                      child: Row(
                                        children: <Widget>[
                                          Flexible(
                                            child: Text(
                                              snapshot.data.documents[0].data['pertanyaan'][indexBilling]
                                            ),
                                          )
                                        ],
                                      ),
                                    )
                                  ],
                                );
                              },
                            )
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
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: <Widget>[
                                              imageBilling.length == 1
                                                ? IconButton(
                                                    icon: Icon(Icons.disc_full, color: Colors.white),
                                                    onPressed: () {},
                                                    tooltip: 'Max. 1 images',
                                                  )
                                                : IconButton(
                                                    icon: Icon(Icons.camera_alt, color: Colors.white),
                                                    onPressed: () async {
                                                      var selectedImage = await ImagePicker.pickImage(source: ImageSource.camera);

                                                      if (imageBilling.length == 0) {
                                                        imageBilling1 = selectedImage;
                                                        filenameBilling1 = basename(imageBilling1.path);

                                                        StorageReference strRef = FirebaseStorage.instance.ref().child(filenameBilling1);
                                                        StorageUploadTask uploadTask = strRef.putFile(imageBilling1);

                                                        var downUrl = await (await uploadTask.onComplete).ref.getDownloadURL();
                                                        var url = downUrl.toString();

                                                        setState(() {
                                                          imageBilling.add(filenameBilling1);
                                                          imageBillingBantu.add(imageBilling1);
                                                          imageBillingSave.add(url);
                                                        });
                                                      }
                                                    },
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
                                                            controller: _controllerBilling,
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
                                                              'OK',
                                                              style: TextStyle(color: Colors.green),
                                                            ),
                                                            onPressed: () {
                                                              if (_controllerBilling.text != '') {
                                                                noteBilling.add(_controllerBilling.text);
                                                              }
                                                              Navigator.of(context).pop();
                                                            },
                                                          )
                                                        ],
                                                      );
                                                    }
                                                  );
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
                                                  setState(() {
                                                    if (indexBilling < 1) {
                                                      indexBilling = 0;
                                                    } else {
                                                      indexBilling--;
                                                    }
                                                  });
                                                },
                                                tooltip: 'Previous Question',
                                              ),
                                              IconButton(
                                                icon: Icon(Icons.arrow_forward_ios, color: Colors.white),
                                                onPressed: () {
                                                  setState(() {
                                                    if (scoreBilling[indexBilling] == null) {
                                                      showDialog(
                                                        barrierDismissible: false,
                                                        context: context,
                                                        builder: (context) => Dialog(
                                                          child: Container(
                                                            height: 180.0,
                                                            child: Column(
                                                              children: <Widget>[
                                                                Container(
                                                                  color: AbubaPallate.greenabuba,
                                                                  height: 50.0,
                                                                  child: Center(
                                                                    child: Text(
                                                                      'OOPS!',
                                                                      style: TextStyle(
                                                                        color: Colors.white,
                                                                        fontSize: 17.0,
                                                                        fontWeight: FontWeight.w700),
                                                                    ),
                                                                  ),
                                                                ),
                                                                SizedBox(
                                                                  height: 20.0,
                                                                ),
                                                                Container(
                                                                  padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
                                                                  child: Text(
                                                                    'Please select the answer!',
                                                                    style: TextStyle(
                                                                      fontSize: 16.0,
                                                                    ),
                                                                  ),
                                                                ),
                                                                Row(
                                                                  mainAxisAlignment: MainAxisAlignment.end,
                                                                  children: <Widget>[
                                                                    FlatButton(
                                                                      child: Text('OK'),
                                                                      onPressed: () {
                                                                        Navigator.pop(context);
                                                                      },
                                                                    )
                                                                  ],
                                                                )
                                                              ],
                                                            ),
                                                          ),
                                                        )
                                                      );
                                                    } else {
                                                      if (indexBilling + 1 < jumlahBilling) {
                                                        indexBilling++;
                                                      } else {
                                                        indexBilling = jumlahBilling - 1;

                                                        for (int i = 0; i < scoreBilling.length; i++) {
                                                          hasilBilling += double.tryParse(bobotBilling[0][i].toString()) * double.tryParse(scoreBilling[i].toString());
                                                        }
                                                        hasilBilling = hasilBilling / 2;

                                                        if (hasilBilling > 1.0) {
                                                            hasilBilling = 1.0;
                                                        } else {
                                                            hasilBilling = hasilBilling;
                                                        }

                                                        DocumentReference docReference = Firestore.instance.collection('mystery_shopper').document(widget.index);
                                                        docReference.updateData({
                                                          'billing_score': scoreBilling,
                                                          'billing_note': noteBilling,
                                                          'hasilBilling': hasilBilling,
                                                          'billing_image': imageBillingSave
                                                        }).then((doc) {
                                                          finalBilling = hasilBilling * bobotBantuBilling;
                                                          _cardController.animateTo(_cardController.index + 1);
                                                        }).catchError((error) {
                                                          print(error);
                                                        });
                                                      }
                                                    }
                                                  });
                                                },
                                                tooltip: 'Next Question',
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                    decoration: BoxDecoration(color: Color(0xFF2F592F))
                                  ),
                                )
                              ],
                            ),
                          ),

                        ],
                      ),
                      ListView(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
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
                                            '2. Thanking',
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
                          Container(
                            color: Colors.white,
                            child: StreamBuilder(
                              stream: Firestore.instance
                                  .collection('thanking')
                                  .snapshots(),
                              builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                                if (!snapshot.hasData && snapshot.data == null)
                                  return Container(
                                    child: Center(
                                      child: CircularProgressIndicator(),
                                    ),
                                  );
                                jumlahThanking = snapshot.data.documents[0].data['pertanyaan'].length;
                                jawabanSplitThanking = snapshot.data.documents[0].data['jawaban'][indexThanking].split(r"!@#$");

                                if (scoreThanking.length < jumlahThanking) {
                                  for (int a = 0; a < jumlahThanking; a++) {
                                    scoreThanking.add(null);
                                    warnaThanking.add('abu');
                                  }
                                }

                                return Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    Stack(
                                      children: <Widget>[
                                        Image.asset(
                                          'assets/images/slide 26.png',
                                          fit: BoxFit.cover,
                                          height: MediaQuery.of(context).size.height / 1.55777,
                                        ),
                                        Positioned(
                                          bottom: 20.0,
                                          width: MediaQuery.of(context).size.width,
                                          child: Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                            children: <Widget>[
                                              jawabanSplitThanking[0] == 'null'
                                                ? Container()
                                                : Tooltip(
                                                    message: jawabanSplitThanking == null ? '' : jawabanSplitThanking[0],
                                                    preferBelow: false,
                                                    child: Container(
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
                                                          color: warnaThanking.length == 0 ? Color.fromARGB(170, 192, 192, 192) : warnaThanking[indexThanking] == 'merah' ? Color.fromARGB(170, 255, 40, 0) : Color.fromARGB(170, 192, 192, 192),
                                                          onPressed: () {
                                                            setState(() {
                                                              bobotBantuThanking = double.tryParse(snapshot.data.documents[0].data['bobot'].toString());
                                                              bobotThanking.add(snapshot.data.documents[0].data['bobot_pertanyaan']);

                                                              scoreThanking.removeAt(indexThanking);
                                                              scoreThanking.insert(indexThanking, 0);
                                                              warnaThanking.removeAt(indexThanking);
                                                              warnaThanking.insert(indexThanking, 'merah');
                                                            });
                                                          },
                                                        ),
                                                      ),
                                                      alignment: Alignment(0.0, 0.0),
                                                    ),
                                                  ),
                                              jawabanSplitThanking[1] == 'null'
                                                ? Container()
                                                : Tooltip(
                                                    message: jawabanSplitThanking == null ? '' : jawabanSplitThanking[1],
                                                    preferBelow: false,
                                                    child: Container(
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
                                                          color: warnaThanking.length == 0 ? Color.fromARGB(170, 192, 192, 192) : warnaThanking[indexThanking] == 'kuning' ? Color.fromARGB(170, 247, 202, 24) : Color.fromARGB(170, 192, 192, 192),
                                                          onPressed: () {
                                                            setState(() {
                                                              bobotBantuThanking = double.tryParse(snapshot.data.documents[0].data['bobot'].toString());
                                                              bobotThanking.add(snapshot.data.documents[0].data['bobot_pertanyaan']);

                                                              scoreThanking.removeAt(indexThanking);
                                                              scoreThanking.insert(indexThanking, 1);
                                                              warnaThanking.removeAt(indexThanking);
                                                              warnaThanking.insert(indexThanking, 'kuning');
                                                            });
                                                          },
                                                        ),
                                                      ),
                                                      alignment: Alignment(0.0, 0.0),
                                                    ),
                                                  ),
                                              jawabanSplitThanking[2] == 'null'
                                                ? Container()
                                                : Tooltip(
                                                    message: jawabanSplitThanking == null ? '' : jawabanSplitThanking[2],
                                                    preferBelow: false,
                                                    child: Container(
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
                                                          color: warnaThanking.length == 0 ? Color.fromARGB(170, 192, 192, 192) : warnaThanking[indexThanking] == 'hijau' ? Color.fromARGB(170, 50, 205, 50) : Color.fromARGB(170, 192, 192, 192),
                                                          onPressed: () {
                                                            setState(() {
                                                              bobotBantuThanking = double.tryParse(snapshot.data.documents[0].data['bobot'].toString());
                                                              bobotThanking.add(snapshot.data.documents[0].data['bobot_pertanyaan']);

                                                              scoreThanking.removeAt(indexThanking);
                                                              scoreThanking.insert(indexThanking, 2);
                                                              warnaThanking.removeAt(indexThanking);
                                                              warnaThanking.insert(indexThanking, 'hijau');
                                                            });
                                                          },
                                                        ),
                                                      ),
                                                      alignment: Alignment(0.0, 0.0),
                                                    ),
                                                  ),
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                    Container(
                                      height: 65.0,
                                      padding: EdgeInsets.symmetric(horizontal: 25.0, vertical: 10.0),
                                      child: Row(
                                        children: <Widget>[
                                          Flexible(
                                            child: Text(
                                              snapshot.data.documents[0].data['pertanyaan'][indexThanking]
                                            ),
                                          )
                                        ],
                                      ),
                                    )
                                  ],
                                );
                              },
                            )
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
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: <Widget>[
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
                                                            controller: _controllerThanking,
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
                                                              'OK',
                                                              style: TextStyle(color: Colors.green),
                                                            ),
                                                            onPressed: () {
                                                              if (_controllerThanking.text != '') {
                                                                noteThanking.add(_controllerThanking.text);
                                                              }
                                                              Navigator.of(context).pop();
                                                            },
                                                          )
                                                        ],
                                                      );
                                                    }
                                                  );
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
                                                  setState(() {
                                                    if (indexThanking < 1) {
                                                      indexThanking = 0;
                                                    } else {
                                                      indexThanking--;
                                                    }
                                                  });
                                                },
                                                tooltip: 'Previous Question',
                                              ),
                                              IconButton(
                                                icon: Icon(Icons.arrow_forward_ios, color: Colors.white),
                                                onPressed: () {
                                                  setState(() {
                                                    if (scoreThanking[indexThanking] == null) {
                                                      showDialog(
                                                        barrierDismissible: false,
                                                        context: context,
                                                        builder: (context) => Dialog(
                                                          child: Container(
                                                            height: 180.0,
                                                            child: Column(
                                                              children: <Widget>[
                                                                Container(
                                                                  color: AbubaPallate.greenabuba,
                                                                  height: 50.0,
                                                                  child: Center(
                                                                    child: Text(
                                                                      'OOPS!',
                                                                      style: TextStyle(
                                                                        color: Colors.white,
                                                                        fontSize: 17.0,
                                                                        fontWeight: FontWeight.w700),
                                                                    ),
                                                                  ),
                                                                ),
                                                                SizedBox(
                                                                  height: 20.0,
                                                                ),
                                                                Container(
                                                                  padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
                                                                  child: Text(
                                                                    'Please select the answer!',
                                                                    style: TextStyle(
                                                                      fontSize: 16.0,
                                                                    ),
                                                                  ),
                                                                ),
                                                                Row(
                                                                  mainAxisAlignment: MainAxisAlignment.end,
                                                                  children: <Widget>[
                                                                    FlatButton(
                                                                      child: Text('OK'),
                                                                      onPressed: () {
                                                                        Navigator.pop(context);
                                                                      },
                                                                    )
                                                                  ],
                                                                )
                                                              ],
                                                            ),
                                                          ),
                                                        )
                                                      );
                                                    } else {
                                                      if (indexThanking + 1 < jumlahThanking) {
                                                        indexThanking++;
                                                      } else {
                                                        indexThanking = jumlahThanking - 1;

                                                        for (int i = 0; i < scoreThanking.length; i++) {
                                                          hasilThanking += double.tryParse(bobotThanking[0][i].toString()) * double.tryParse(scoreThanking[i].toString());
                                                        }
                                                        hasilThanking = hasilThanking / 2;

                                                        if (hasilThanking > 1.0) {
                                                            hasilThanking = 1.0;
                                                        } else {
                                                            hasilThanking = hasilThanking;
                                                        }

                                                        DocumentReference docReference = Firestore.instance.collection('mystery_shopper').document(widget.index);
                                                        docReference.updateData({
                                                          'thanking_score': scoreThanking,
                                                          'thanking_note': noteThanking,
                                                          'hasilThanking': hasilThanking
                                                        }).then((doc) {
                                                          finalThanking = hasilThanking * bobotBantuThanking;
                                                          _cardController.animateTo(_cardController.index + 1);
                                                        }).catchError((error) {
                                                          print(error);
                                                        });
                                                      }
                                                    }
                                                  });
                                                },
                                                tooltip: 'Next Question',
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                    decoration: BoxDecoration(color: Color(0xFF2F592F))
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                      ListView(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
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
                                              '3. Parking',
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
                          Container(
                            color: Colors.white,
                            child: StreamBuilder(
                              stream: Firestore.instance
                                  .collection('parking')
                                  .snapshots(),
                              builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                                if (!snapshot.hasData && snapshot.data == null)
                                  return Container(
                                    child: Center(
                                      child: CircularProgressIndicator(),
                                    ),
                                  );
                                jumlahParking = snapshot.data.documents[0].data['pertanyaan'].length;
                                jawabanSplitParking = snapshot.data.documents[0].data['jawaban'][indexParking].split(r"!@#$");

                                if (scoreParking.length < jumlahParking) {
                                  for (int a = 0; a < jumlahParking; a++) {
                                    scoreParking.add(null);
                                    warnaParking.add('abu');
                                  }
                                }

                                return Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    Stack(
                                      children: <Widget>[
                                        Image.asset(
                                          'assets/images/abuba6.jpg',
                                          fit: BoxFit.cover,
                                          height: MediaQuery.of(context).size.height / 1.55777,
                                        ),
                                        Positioned(
                                          bottom: 20.0,
                                          width: MediaQuery.of(context).size.width,
                                          child: Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                            children: <Widget>[
                                              jawabanSplitParking[0] == 'null'
                                                ? Container()
                                                : Tooltip(
                                                    message: jawabanSplitParking == null ? '' : jawabanSplitParking[0],
                                                    preferBelow: false,
                                                    child: Container(
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
                                                          color: warnaParking.length == 0 ? Color.fromARGB(170, 192, 192, 192) : warnaParking[indexParking] == 'merah' ? Color.fromARGB(170, 255, 40, 0) : Color.fromARGB(170, 192, 192, 192),
                                                          onPressed: () {
                                                            setState(() {
                                                              bobotBantuParking = double.tryParse(snapshot.data.documents[0].data['bobot'].toString());
                                                              bobotParking.add(snapshot.data.documents[0].data['bobot_pertanyaan']);

                                                              scoreParking.removeAt(indexParking);
                                                              scoreParking.insert(indexParking, 0);
                                                              warnaParking.removeAt(indexParking);
                                                              warnaParking.insert(indexParking, 'merah');
                                                            });
                                                          },
                                                        ),
                                                      ),
                                                      alignment: Alignment(0.0, 0.0),
                                                    ),
                                                  ),
                                              jawabanSplitParking[1] == 'null'
                                                ? Container()
                                                : Tooltip(
                                                    message: jawabanSplitParking == null ? '' : jawabanSplitParking[1],
                                                    preferBelow: false,
                                                    child: Container(
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
                                                          color: warnaParking.length == 0 ? Color.fromARGB(170, 192, 192, 192) : warnaParking[indexParking] == 'kuning' ? Color.fromARGB(170, 247, 202, 24) : Color.fromARGB(170, 192, 192, 192),
                                                          onPressed: () {
                                                            setState(() {
                                                              bobotBantuParking = double.tryParse(snapshot.data.documents[0].data['bobot'].toString());
                                                              bobotParking.add(snapshot.data.documents[0].data['bobot_pertanyaan']);

                                                              scoreParking.removeAt(indexParking);
                                                              scoreParking.insert(indexParking, 1);
                                                              warnaParking.removeAt(indexParking);
                                                              warnaParking.insert(indexParking, 'kuning');
                                                            });
                                                          },
                                                        ),
                                                      ),
                                                      alignment: Alignment(0.0, 0.0),
                                                    ),
                                                  ),
                                              jawabanSplitParking[2] == 'null'
                                                ? Container()
                                                : Tooltip(
                                                    message: jawabanSplitParking == null ? '' : jawabanSplitParking[2],
                                                    preferBelow: false,
                                                    child: Container(
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
                                                          color: warnaParking.length == 0 ? Color.fromARGB(170, 192, 192, 192) : warnaParking[indexParking] == 'hijau' ? Color.fromARGB(170, 50, 205, 50) : Color.fromARGB(170, 192, 192, 192),
                                                          onPressed: () {
                                                            setState(() {
                                                              bobotBantuParking = double.tryParse(snapshot.data.documents[0].data['bobot'].toString());
                                                              bobotParking.add(snapshot.data.documents[0].data['bobot_pertanyaan']);

                                                              scoreParking.removeAt(indexParking);
                                                              scoreParking.insert(indexParking, 2);
                                                              warnaParking.removeAt(indexParking);
                                                              warnaParking.insert(indexParking, 'hijau');
                                                            });
                                                          },
                                                        ),
                                                      ),
                                                      alignment: Alignment(0.0, 0.0),
                                                    ),
                                                  ),
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                    Container(
                                      height: 65.0,
                                      padding: EdgeInsets.symmetric(horizontal: 25.0, vertical: 10.0),
                                      child: Row(
                                        children: <Widget>[
                                          Flexible(
                                            child: Text(
                                              snapshot.data.documents[0].data['pertanyaan'][indexParking]
                                            ),
                                          )
                                        ],
                                      ),
                                    )
                                  ],
                                );
                              },
                            )
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
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: <Widget>[
                                              imageParking.length == 2
                                                ? IconButton(
                                                    icon: Icon(Icons.disc_full, color: Colors.white),
                                                    onPressed: () {},
                                                    tooltip: 'Max. 2 images',
                                                  )
                                                : IconButton(
                                                    icon: Icon(Icons.camera_alt, color: Colors.white),
                                                    onPressed: () async {
                                                      var selectedImage = await ImagePicker.pickImage(source: ImageSource.camera);

                                                      if (imageParking.length == 0) {
                                                        imageParking1 = selectedImage;
                                                        filenameParking1 = basename(imageParking1.path);

                                                        StorageReference strRef = FirebaseStorage.instance.ref().child(filenameParking1);
                                                        StorageUploadTask uploadTask = strRef.putFile(imageParking1);

                                                        var downUrl = await (await uploadTask.onComplete).ref.getDownloadURL();
                                                        var url = downUrl.toString();

                                                        setState(() {
                                                          imageParking.add(filenameParking1);
                                                          imageParkingBantu.add(imageParking1);
                                                          imageParkingSave.add(url);
                                                        });
                                                      } else if (imageParking.length == 1) {
                                                        imageParking2 = selectedImage;
                                                        filenameParking2 = basename(imageParking2.path);

                                                        StorageReference strRef = FirebaseStorage.instance.ref().child(filenameParking2);
                                                        StorageUploadTask uploadTask = strRef.putFile(imageParking2);

                                                        var downUrl = await (await uploadTask.onComplete).ref.getDownloadURL();
                                                        var url = downUrl.toString();

                                                        setState(() {
                                                          imageParking.add(filenameParking2);
                                                          imageParkingBantu.add(imageParking2);
                                                          imageParkingSave.add(url);
                                                        });
                                                      }
                                                    },
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
                                                            controller: _controllerParking,
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
                                                              'OK',
                                                              style: TextStyle(color: Colors.green),
                                                            ),
                                                            onPressed: () {
                                                              if (_controllerParking.text != '') {
                                                                noteParking.add(_controllerParking.text);
                                                              }
                                                              Navigator.of(context).pop();
                                                            },
                                                          )
                                                        ],
                                                      );
                                                    }
                                                  );
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
                                                  setState(() {
                                                    if (indexParking < 1) {
                                                      indexParking = 0;
                                                    } else {
                                                      indexParking--;
                                                    }
                                                  });
                                                },
                                                tooltip: 'Previous Question',
                                              ),
                                              IconButton(
                                                icon: Icon(Icons.arrow_forward_ios, color: Colors.white),
                                                onPressed: () {
                                                  setState(() {
                                                    if (scoreParking[indexParking] == null) {
                                                      showDialog(
                                                        barrierDismissible: false,
                                                        context: context,
                                                        builder: (context) => Dialog(
                                                          child: Container(
                                                            height: 180.0,
                                                            child: Column(
                                                              children: <Widget>[
                                                                Container(
                                                                  color: AbubaPallate.greenabuba,
                                                                  height: 50.0,
                                                                  child: Center(
                                                                    child: Text(
                                                                      'OOPS!',
                                                                      style: TextStyle(
                                                                        color: Colors.white,
                                                                        fontSize: 17.0,
                                                                        fontWeight: FontWeight.w700),
                                                                    ),
                                                                  ),
                                                                ),
                                                                SizedBox(
                                                                  height: 20.0,
                                                                ),
                                                                Container(
                                                                  padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
                                                                  child: Text(
                                                                    'Please select the answer!',
                                                                    style: TextStyle(
                                                                      fontSize: 16.0,
                                                                    ),
                                                                  ),
                                                                ),
                                                                Row(
                                                                  mainAxisAlignment: MainAxisAlignment.end,
                                                                  children: <Widget>[
                                                                    FlatButton(
                                                                      child: Text('OK'),
                                                                      onPressed: () {
                                                                        Navigator.pop(context);
                                                                      },
                                                                    )
                                                                  ],
                                                                )
                                                              ],
                                                            ),
                                                          ),
                                                        )
                                                      );
                                                    } else {
                                                      if (indexParking + 1 < jumlahParking) {
                                                        indexParking++;
                                                      } else {
                                                        indexParking = jumlahParking - 1;

                                                        for (int i = 0; i < scoreParking.length; i++) {
                                                          hasilParking += double.tryParse(bobotParking[0][i].toString()) * double.tryParse(scoreParking[i].toString());
                                                        }
                                                        hasilParking = hasilParking / 2;

                                                        if (hasilParking > 1.0) {
                                                            hasilParking = 1.0;
                                                        } else {
                                                            hasilParking = hasilParking;
                                                        }

                                                        DocumentReference docReference = Firestore.instance.collection('mystery_shopper').document(widget.index);
                                                        docReference.updateData({
                                                          'parking_score': scoreParking,
                                                          'parking_note': noteParking,
                                                          'parking_image': imageParkingSave,
                                                          'hasilParking': hasilParking
                                                        }).then((doc) {
                                                          finalParking = hasilParking * bobotBantuParking;
                                                          double finalBantu = widget.finalBantu + finalParking + finalBilling + finalThanking;
                                                          double hasilGrafik = finalBantu - (finalBantu * 2 / 100);
                                                          Navigator.push(context,
                                                            MaterialPageRoute(
                                                              builder: (_) => FormCheckOut(index: widget.index, idUser: widget.idUser, finalBantu: hasilGrafik, imageOutlet: widget.imageOutlet, aksesStatus: widget.aksesStatus),
                                                            )
                                                          );
                                                        }).catchError((error) {
                                                          print(error);
                                                        });
                                                      }
                                                    }
                                                  });
                                                },
                                                tooltip: 'Next Question',
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                    decoration: BoxDecoration(color: Color(0xFF2F592F))
                                  ),
                                )
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
}

class FormCheckOut extends StatefulWidget {
  final double finalBantu;
  var index;
  final int idUser;
  final String imageOutlet;
  final String aksesStatus;
  FormCheckOut({this.index, this.idUser, this.finalBantu, this.imageOutlet, this.aksesStatus});

  @override
  _FormCheckOutState createState() => _FormCheckOutState();
}

class _FormCheckOutState extends State<FormCheckOut> {
  DateTime checkout = DateTime.now();
  bool mgDone = false;

  double hasilParking = 0;
  double hasilGreeting = 0;
  double hasilSeating = 0;
  double hasilTakingOrder = 0;
  double hasilServingProduct = 0;
  double hasilCleanliness = 0;
  double hasilPreBushing = 0;
  double hasilBilling = 0;
  double hasilThanking = 0;
  double hasilComplaint = 0;
  double hasilServingTime = 0;
  double hasilGrafik = 0;
  double bobot1 = 0;
  double bobot2 = 0;
  double bobot3 = 0;
  double bobot4 = 0;
  double bobot5 = 0;
  double bobot6 = 0;
  double bobot7 = 0;
  double bobot8 = 0;
  double bobot9 = 0;
  double bobot10 = 0;
  double bobot11 = 0;

  String userName = '';
  String tanggal = '';
  String waktuStart = '';
  String waktuEnd = '';
  List<dynamic> complaintNote = [];
  String category = '';
  String product = '';
  String service = '';
  String serviceNote = '';
  String pic = '';
  String complaint;

  List<dynamic> parkingScore = [];
  List<dynamic> parkingNote = [];
  List<dynamic> greetingScore = [];
  List<dynamic> greetingNote = [];
  List<dynamic> seatingScore = [];
  List<dynamic> seatingNote = [];
  List<dynamic> takingOrderScore = [];
  List<dynamic> takingOrderNote = [];
  List<dynamic> servingProductScore = [];
  List<dynamic> servingProductNote = [];
  List<dynamic> complaintScore = [];
  List<dynamic> bobotServingTime = [];
  List<dynamic> servingTimeScore = [];
  List<dynamic> billingScore = [];
  List<dynamic> billingNote = [];
  List<dynamic> thankingScore = [];
  List<dynamic> thankingNote = [];
  List<dynamic> preBushingScore = [];
  List<dynamic> preBushingNote = [];
  List<dynamic> cleanlinessScore = [];
  List<dynamic> cleanlinessNote = [];

  List<dynamic> imageServingProduct = [];
  List<dynamic> imageComplaint = [];
  List<dynamic> imagePreBushing = [];
  List<dynamic> imageCleanliness = [];
  List<dynamic> imageParking = [];
  List<dynamic> imageBilling = [];

  List<dynamic> orderTimeDone = [];

  String namaOutlet;
  int namaUser;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
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
                              elevation: 0.0,
                              shape: new RoundedRectangleBorder(
                                  borderRadius: new BorderRadius.circular(5.0)),
                              child: Text(
                                mgDone ? 'Finishing data ...' : 'CHECK OUT',
                                style:
                                TextStyle(fontSize: mgDone ? 18.0 : 13.0, color: mgDone ? Colors.black : Colors.white),
                              ),
                              color: mgDone ? Colors.white : Colors.red,
                              onPressed: () {
                                DocumentReference docReference = Firestore.instance.collection('mystery_shopper').document(widget.index);
                                docReference.updateData({
                                  'checkOut': checkout,
                                  'hasilGrafik': widget.finalBantu
                                }).then((doc) async {
                                  if (widget.aksesStatus == 'mg') {
                                    setState(() {
                                      mgDone = true;
                                    });
                                    setState(() {
                                      imageServingProduct.clear();
                                      imageComplaint.clear();
                                      imagePreBushing.clear();
                                      imageCleanliness.clear();
                                      imageParking.clear();
                                      imageBilling.clear();

                                      complaintNote.clear();
                                      parkingNote.clear();
                                      greetingNote.clear();
                                      seatingNote.clear();
                                      takingOrderNote.clear();
                                      servingProductNote.clear();
                                      billingNote.clear();
                                      thankingNote.clear();
                                      preBushingNote.clear();
                                      cleanlinessNote.clear();

                                      parkingScore.clear();
                                      greetingScore.clear();
                                      seatingScore.clear();
                                      takingOrderScore.clear();
                                      servingProductScore.clear();
                                      complaintScore.clear();
                                      servingTimeScore.clear();
                                      billingScore.clear();
                                      thankingScore.clear();
                                      preBushingScore.clear();
                                      cleanlinessScore.clear();
                                    });
                                    Firestore.instance.collection('mystery_shopper')
                                      .document(widget.index)
                                      .snapshots()
                                      .listen((data) {
                                        setState(() {
                                          parkingScore.add(data['parking_score']);
                                          parkingNote.add(data['parking_note']);
                                          greetingScore.add(data['greeting_score']);
                                          greetingNote.add(data['greeting_note']);
                                          seatingScore.add(data['seating_score']);
                                          seatingNote.add(data['seating_note']);
                                          takingOrderScore.add(data['takingOrder_score']);
                                          takingOrderNote.add(data['takingOrder_note']);
                                          servingProductScore.add(data['servingProduct_score']);
                                          servingProductNote.add(data['servingProduct_note']);
                                          complaintScore.add(data['complaint_score']);
                                          complaintNote.add(data['complaint_note']);
                                          billingScore.add(data['billing_score']);
                                          billingNote.add(data['billing_note']);
                                          thankingScore.add(data['thanking_score']);
                                          thankingNote.add(data['thanking_note']);
                                          preBushingScore.add(data['preBushing_score']);
                                          preBushingNote.add(data['preBushing_note']);
                                          cleanlinessScore.add(data['cleanliness_score']);
                                          cleanlinessNote.add(data['cleanliness_note']);
                                          complaint = data['complaint_detail'];
                                          category = data['category'];
                                          serviceNote = data['note_service'];
                                          servingTimeScore.add(data['score']);
                                          bobotServingTime.add(data['bobot_pertanyaan']);
                                          bobot11 = double.tryParse(data['bobot'].toString());
                                          orderTimeDone.add(data['orderTimeDone']);

                                          hasilParking = data['hasilParking'];
                                          hasilGreeting = data['hasilGreeting'];
                                          hasilSeating = data['hasilSeating'];
                                          hasilTakingOrder = data['hasilTakingOrder'];
                                          hasilServingProduct = data['hasilServingProduct'];
                                          hasilPreBushing = data['hasilPreBushing'];
                                          hasilCleanliness = data['hasilCleanliness'];
                                          hasilServingTime = data['hasilServingTime'];
                                          hasilComplaint = data['hasilComplaint'];
                                          hasilBilling = data['hasilBilling'];
                                          hasilThanking = data['hasilThanking'];
                                          hasilGrafik = data['hasilGrafik'];

                                          imageServingProduct.add(data['servingProduct_image']);
                                          imageComplaint.add(data['complaint_image']);
                                          imagePreBushing.add(data['preBushing_image']);
                                          imageCleanliness.add(data['cleanliness_image']);
                                          imageParking.add(data['parking_image']);
                                          imageBilling.add(data['billing_image']);

                                          namaOutlet = data['outlet'];
                                          namaUser = data['user'];

                                          if (data['product'] == null) {
                                            product = '';
                                          } else {
                                            Firestore.instance.collection('product_complaint-mg').where('id', isEqualTo: data['product']).snapshots()
                                              .listen((data2) => data2.documents.forEach((doc2) {
                                                product = doc2['product'];
                                              }));
                                          }

                                          if (data['service'] == null) {
                                            service = '';
                                          } else {
                                            Firestore.instance.collection('service_complaint-mg').where('id', isEqualTo: data['service']).snapshots()
                                              .listen((data2) => data2.documents.forEach((doc2) {
                                                service = doc2['service'];
                                              }));
                                          }

                                          Firestore.instance.collection('pic_complaint-mg').where('id', isEqualTo: data['pic']).snapshots()
                                            .listen((data2) => data2.documents.forEach((doc2) {
                                              pic = doc2['pic'];
                                            }));

                                          Firestore.instance.collection('user').where('id', isEqualTo: data['user']).snapshots()
                                            .listen((data) => data.documents.forEach((doc) {
                                              setState(() {
                                                userName = doc['nama'];
                                              });
                                            }));

                                          tanggal = data['checkIn'].toString().substring(8, 10) + '/' + data['checkIn'].toString().substring(5, 7) + '/' + data['checkIn'].toString().substring(0, 4);
                                          waktuStart = data['checkIn'].toString().substring(11, 16);
                                          if (data['checkOut'] == null) {
                                            waktuEnd = '00.00';
                                          } else {
                                            waktuEnd = data['checkOut'].toString().substring(11, 16);
                                          }
                                        });
                                      });

                                    Firestore.instance.collection('parking').snapshots()
                                      .listen((data5) => data5.documents.forEach((doc5) {
                                        bobot1 = double.tryParse(doc5['bobot'].toString());
                                      }));

                                    Firestore.instance.collection('greeting').snapshots()
                                      .listen((data5) => data5.documents.forEach((doc5) {
                                        bobot2 = double.tryParse(doc5['bobot'].toString());
                                      }));

                                    Firestore.instance.collection('seating').snapshots()
                                      .listen((data5) => data5.documents.forEach((doc5) {
                                        bobot3 = double.tryParse(doc5['bobot'].toString());
                                      }));

                                    Firestore.instance.collection('takingOrder').snapshots()
                                      .listen((data5) => data5.documents.forEach((doc5) {
                                        bobot4 = double.tryParse(doc5['bobot'].toString());
                                      }));

                                    Firestore.instance.collection('servingProduct').snapshots()
                                      .listen((data5) => data5.documents.forEach((doc5) {
                                        bobot5 = double.tryParse(doc5['bobot'].toString());
                                      }));

                                    Firestore.instance.collection('cleaniness').snapshots()
                                      .listen((data5) => data5.documents.forEach((doc5) {
                                        bobot6 = double.tryParse(doc5['bobot'].toString());
                                      }));

                                    Firestore.instance.collection('pre-bushing').snapshots()
                                      .listen((data5) => data5.documents.forEach((doc5) {
                                        bobot7 = double.tryParse(doc5['bobot'].toString());
                                      }));

                                    Firestore.instance.collection('billing').snapshots()
                                      .listen((data5) => data5.documents.forEach((doc5) {
                                        bobot8 = double.tryParse(doc5['bobot'].toString());
                                      }));

                                    Firestore.instance.collection('thanking').snapshots()
                                      .listen((data5) => data5.documents.forEach((doc5) {
                                        bobot9 = double.tryParse(doc5['bobot'].toString());
                                      }));

                                    Firestore.instance.collection('complaint_handling').snapshots()
                                      .listen((data5) => data5.documents.forEach((doc5) {
                                        bobot10 = double.tryParse(doc5['bobot'].toString());
                                      }));

                                    await new Future.delayed(Duration(
                                      seconds: 3
                                    ));
                                    setState(() {
                                      mgDone = false;
                                    });
                                    Navigator.push(context,
                                      MyCustomRoute(
                                        builder: (context) => DetailReport(user: namaUser, outlet: namaOutlet, bobotServingTime: bobot11, servingTimeGrafik: hasilServingTime, servingTimeNilai: servingTimeScore, parkingGrafik: hasilParking, parkingNilai: parkingScore, parkingNote: parkingNote, bobotParking: bobot1, greetingGrafik: hasilGreeting, greetingNilai: greetingScore, greetingNote: greetingNote, bobotGreeting: bobot2, seatingGrafik: hasilSeating, seatingNilai: seatingScore, seatingNote: seatingNote, bobotSeating: bobot3, takingOrderGrafik: hasilTakingOrder, takingOrderNilai: takingOrderScore, takingOrderNote: takingOrderNote, bobotTakingOrder: bobot4, servingProductGrafik: hasilServingProduct, servingProductNilai: servingProductScore, servingProductNote: servingProductNote, bobotServingProduct: bobot5, cleanlinessGrafik: hasilCleanliness, cleanlinessNilai: cleanlinessScore, cleanlinessNote: cleanlinessNote, bobotCleanliness: bobot6, preBushingGrafik: hasilPreBushing, preBushingNilai: preBushingScore, preBushingNote: preBushingNote, bobotPreBushing: bobot7, billingGrafik: hasilBilling, billingNilai: billingScore, billingNote: billingNote, bobotBilling: bobot8, thankingGrafik: hasilThanking, thankingNilai: thankingScore, thankingNote: thankingNote, bobotThanking: bobot9, complaintGrafik: hasilComplaint, complaintNilai: complaintScore, complaintNote: complaintNote, bobotComplaint: bobot10, userName: userName, tanggal: tanggal, waktuStart: waktuStart, waktuEnd: waktuEnd, category: category, product: product, service: service, serviceNote: serviceNote, pic: pic, complaint: complaint, index: widget.index, idUser: widget.idUser, imageServingProduct: imageServingProduct, imageComplaint: imageComplaint, imageCleanliness: imageCleanliness, imageParking: imageParking, imagePreBushing: imagePreBushing, imageBilling: imageBilling, orderTimeDone: orderTimeDone, hasilGrafik: hasilGrafik, aksesStatus: widget.aksesStatus)
                                      )
                                    );
                                  } else {
                                    Navigator.pushReplacement(context,
                                      MaterialPageRoute(
                                        builder: (_) => FormCariLokasi(idUser: widget.idUser)
                                      )
                                    );
                                  }
                                }).catchError((error) {
                                  print(error);
                                });
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
                child: Image.network(
                  widget.imageOutlet,
                  fit: BoxFit.fitWidth,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
