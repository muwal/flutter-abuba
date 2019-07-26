import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_abuba/constant.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter_abuba/isoft/operation_page/meeting/form_checkin.dart';
import 'package:intl/intl.dart';

import 'package:smooth_star_rating/smooth_star_rating.dart';

class MenuNotulen extends StatefulWidget {
  final int idUser;
  final String namaUser;
  final String departmentUser;
  var index;
  MenuNotulen({this.idUser, this.namaUser, this.departmentUser, this.index});

  @override
  _MenuNotulenState createState() => _MenuNotulenState();
}

class _MenuNotulenState extends State<MenuNotulen> with TickerProviderStateMixin {
  final dateFormat = DateFormat("MMMM d, yyyy");
  bool _isProccess = false;
  DateTime dueDate;
  TextEditingController controllerIssue =TextEditingController();
  TextEditingController controllerActionPlan =TextEditingController();
  String _pic;
  String _picName;
  TextEditingController controllerDueDate =TextEditingController();

  TabController _tabController;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _autoValidate = false;

  var issueArray;
  var actionPlanArray;
  var picID;
  var picName;
  var picIDForActionPlan;
  var picNameForActionPlan;
  var dueDateArray;
  List<dynamic> dueDateArrayView = [];
  var userCreatedNotulen;
  var useActionPlan;
  var statusActionPlan;
  var dateDoneActionPlan;
  var noteActionPlan;

  String name;
  String date;
  String time;
  AnimationController animationController;

  var pesertaHadir;
  var checkOut;
  List<DateTime> checkOutSave = [];
  int userCreated;
  String statusMeeting;
  bool addNotulen = false;
  int _value1 = 0;
  bool showActionPlan = false;
  bool showError = false;

  final List<Tab> internalAuditTabs = <Tab>[
    new Tab(child: Text('Notulen', style: TextStyle(color: Colors.grey[400]))),
    new Tab(child: Text('Report', style: TextStyle(color: Colors.grey[400]))),
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: internalAuditTabs.length);

    Firestore.instance.collection('minutesMeeting').document(widget.index).snapshots().listen((data) {
      setState(() {
        date = data.data['checkInPeserta'][data.data['pesertaHadir'].indexWhere((dynamic result) => result.toString().startsWith(widget.idUser.toString()))].toString().substring(8, 10) + '/' + data.data['checkInPeserta'][data.data['pesertaHadir'].indexWhere((dynamic result) => result.toString().startsWith(widget.idUser.toString()))].toString().substring(5, 7) + '/' +data.data['checkInPeserta'][data.data['pesertaHadir'].indexWhere((dynamic result) => result.toString().startsWith(widget.idUser.toString()))].toString().substring(0, 4) + ' - ' + data.data['checkInPeserta'][data.data['pesertaHadir'].indexWhere((dynamic result) => result.toString().startsWith(widget.idUser.toString()))].toString().substring(11, 16);
        issueArray = List<dynamic>.from(data.data['issueNotulen']);
        actionPlanArray = List<dynamic>.from(data.data['actionPlanNotulen']);
        picID = List<dynamic>.from(data.data['picIDNotulen']);
        picName = List<dynamic>.from(data.data['picNameNotulen']);
        picIDForActionPlan = List<dynamic>.from(data.data['pesertaID']);
        picNameForActionPlan = List<dynamic>.from(data.data['pesertaName']);
        dueDateArray = List<dynamic>.from(data.data['dueDateNotulen']);
        for (int a = 0; a < data.data['dueDateNotulen'].length; a++) {
          if (data.data['dueDateNotulen'][a] == null) {
            dueDateArrayView.add(null);
          } else {
            dueDateArrayView.add(data.data['dueDateNotulen'][a].toDate());
          }
        }
        noteActionPlan = List<dynamic>.from(data.data['noteActionPlan']);
        statusActionPlan = List<dynamic>.from(data.data['statusActionPlan']);
        dateDoneActionPlan = List<dynamic>.from(data.data['dateDoneActionPlan']);
        userCreatedNotulen = List<dynamic>.from(data.data['userCreatedNotulen']);
        useActionPlan = List<dynamic>.from(data.data['useActionPlan']);
        pesertaHadir = List<dynamic>.from(data.data['pesertaHadir']);
        userCreated = data.data['userCreated'];

        Firestore.instance.collection('user').where('id', isEqualTo: widget.idUser).snapshots().listen((data2) {
          name = data2.documents[0].data['nama'];
        });
      });
    });

    animationController = AnimationController(vsync: this, duration: Duration(seconds: 3));
    animationController.reverse(
      from: animationController.value == 0.0
        ? 1.0
        : animationController.value
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: _appBar(),
          body: GestureDetector(
            onTap: () {
              FocusScope.of(context).requestFocus(FocusNode());
            },
            child: AnimatedBuilder(
              animation: animationController,
              builder: (_, Widget child) {
                return animationController.isAnimating
                  ? Container(
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    )
                  : TabBarView(
                      controller: _tabController,
                      children: <Widget>[
                        Form(
                          autovalidate: _autoValidate,
                          key: _formKey,
                          child: ListView(
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 0.0),
                                child: TextFormField(
                                  keyboardType: TextInputType.text,
                                  decoration: InputDecoration(
                                    labelText: 'Issue / Note',
                                    labelStyle: TextStyle(fontSize: 12.0),
                                  ),
                                  controller: controllerIssue,
                                  maxLength: 250,
                                  maxLines: 3,
                                  validator: (value) {
                                    if (value.length < 10) {
                                      return 'Issue or note must be more than 10 character';
                                    } else if (value.length > 250) {
                                      return 'Issue or note must be less than 250 Character';
                                    } else {
                                      return null;
                                    }
                                  },
                                  textCapitalization: TextCapitalization.sentences,
                                  style: TextStyle(
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 0.0),
                                child: Text('Action Plan', style: TextStyle(fontSize: 12.0, color: Colors.black54)),
                              ),
                              Padding(
                                padding: const EdgeInsets.fromLTRB(30.0, 0.0, 10.0, 0.0),
                                child: Row(
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
                                            showActionPlan = false;
                                            showError = false;
                                          });
                                        },
                                        activeColor: Colors.green,
                                        controlAffinity: ListTileControlAffinity.leading,
                                        title: Text('NO', style: TextStyle(fontSize: 14.0)),
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
                                            showActionPlan = true;
                                            showError = false;
                                          });
                                        },
                                        activeColor: Colors.green,
                                        controlAffinity: ListTileControlAffinity.leading,
                                        title: Text('YES', style: TextStyle(fontSize: 14.0)),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              showActionPlan
                                ? Column(
                                    children: <Widget>[
                                      Padding(
                                        padding: const EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 0.0),
                                        child: TextFormField(
                                          keyboardType: TextInputType.text,
                                          decoration: InputDecoration(
                                            labelText: 'Action Plan',
                                            labelStyle: TextStyle(fontSize: 12.0),
                                          ),
                                          controller: controllerActionPlan,
                                          maxLength: 250,
                                          maxLines: 3,
                                          validator: (value) {
                                            if (showActionPlan == true) {
                                              if (value.length < 10) {
                                                return 'Action plan must be more than 10 character';
                                              } else if (value.length > 250) {
                                                return 'Action plan must be less than 250 Character';
                                              } else {
                                                return null;
                                              }
                                            } else {
                                              return null;
                                            }
                                          },
                                          textCapitalization: TextCapitalization.sentences,
                                          style: TextStyle(
                                            color: Colors.black,
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.fromLTRB(20.0, 5.0, 20.0, 0.0),
                                        child: Container(
                                          width: MediaQuery.of(context).size.width,
                                          child: DropdownButtonFormField<String>(
                                            decoration: InputDecoration(
                                              labelText: 'PIC',
                                              labelStyle: TextStyle(fontSize: 12.0),
                                            ),
                                            validator: (value) {
                                              if (showActionPlan == true) {
                                                if (value == null) {
                                                  return 'Please select person';
                                                } else {
                                                  return null;
                                                }
                                              } else {
                                                return null;
                                              }
                                            },
                                            value: _pic,
                                            onChanged: (String value) {
                                              setState(() {
                                                Firestore.instance.collection('user').where('id', isEqualTo: int.tryParse(value)).snapshots().listen((data) {
                                                  _pic = value;
                                                  _picName = data.documents[0].data['nama'];
                                                });
                                              });
                                            },
                                            items: List.generate(picIDForActionPlan.length, (index2) {
                                              return DropdownMenuItem(
                                                value: picIDForActionPlan[index2].toString(),
                                                child: Padding(
                                                  padding: EdgeInsets.all(10.0),
                                                  child: RichText(
                                                    overflow: TextOverflow.visible,
                                                    text: TextSpan(
                                                      text: picNameForActionPlan[index2].toString(),
                                                      style: TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 12.0
                                                      )
                                                    ),
                                                  ),
                                                ),
                                              );
                                            }).toList()
                                          )
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 0.0),
                                        child: DateTimePickerFormField(
                                          format: dateFormat,
                                          onChanged: (dt) => setState(() => dueDate = dt),
                                          dateOnly: true,
                                          editable: false,
                                          resetIcon: null,
                                          controller: controllerDueDate,
                                          validator: (value) {
                                            if (showActionPlan == true) {
                                              if (value == null) {
                                                return 'Please select due date';
                                              } else {
                                                return null;
                                              }
                                            } else {
                                              return null;
                                            }
                                          },
                                          style: TextStyle(fontSize: 14.0, color: Colors.black),
                                          decoration: InputDecoration(
                                              border: UnderlineInputBorder(),
                                              labelStyle: TextStyle(fontSize: 12.0),
                                              labelText: 'Due Date'),
                                        ),
                                      ),
                                    ],
                                  )
                                : Container(),
                              showError
                                ? Container(
                                    padding: const EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 0.0),
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      'Please select option use action plan or not',
                                      style: TextStyle(
                                        color: Colors.red,
                                        fontSize: 12.0
                                      ),
                                    ),
                                  )
                                : Container(),
                              Padding(
                                padding: EdgeInsets.all(10.0),
                                child: ButtonTheme(
                                  minWidth: 50.0,
                                  height: 40.0,
                                  child: RaisedButton(
                                    elevation: 0.0,
                                    shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(5.0)),
                                    child: addNotulen
                                      ? Container(
                                          padding: EdgeInsets.symmetric(vertical: 5.0),
                                          child: Center(
                                            child: SizedBox(
                                              height: 20.0,
                                              width: 20.0,
                                              child: CircularProgressIndicator(
                                                valueColor: AlwaysStoppedAnimation(Colors.white),
                                                strokeWidth: 2.0,
                                              ),
                                            ),
                                          ),
                                        )
                                      : Text(
                                          'ADD',
                                          style:
                                          TextStyle(fontSize: 13.0, color: Colors.white),
                                        ),
                                    color: AbubaPallate.greenabuba,
                                    onPressed: () async {
                                      if (_formKey.currentState.validate()) {
                                        setState(() {
                                          _autoValidate = false;
                                          addNotulen = true;
                                          showError = false;
                                        });
                                        _formKey.currentState.save();

                                        Firestore.instance.collection('minutesMeeting').document(widget.index).snapshots().listen((getData) {
                                          setState(() {
                                            statusMeeting = getData.data['status'];
                                          });
                                        });

                                        await new Future.delayed(Duration(
                                          seconds: 3
                                        ));

                                        if (statusMeeting == 'CLOSE') {
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
                                                          'THANK YOU!',
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
                                                        'Sorry, you can\'t add more notulen because the meeting is over',
                                                        style: TextStyle(
                                                          fontSize: 16.0,
                                                        ),
                                                      ),
                                                    ),
                                                    Row(
                                                      mainAxisAlignment: MainAxisAlignment.end,
                                                      children: <Widget>[
                                                        FlatButton(
                                                          child: Text('OK', style: TextStyle(color: Colors.grey)),
                                                          onPressed: () {
                                                            Navigator.pushReplacement(context,
                                                              MaterialPageRoute(
                                                                builder: (context) => FormCheckin(idUser: widget.idUser, namaUser: widget.namaUser, departmentUser: widget.departmentUser)
                                                              )
                                                            );
                                                          },
                                                        ),
                                                      ],
                                                    )
                                                  ],
                                                ),
                                              ),
                                            )
                                          );
                                        } else {
                                          DocumentReference docReference = Firestore.instance.collection('minutesMeeting').document(widget.index);

                                          setState(() {
                                            userCreatedNotulen.add(widget.idUser);
                                            issueArray.add(controllerIssue.text);
                                            if (showActionPlan == true) {
                                              dueDateArray.add(dueDate);
                                              dueDateArrayView.add(dueDate);
                                              actionPlanArray.add(controllerActionPlan.text);
                                              picID.add(int.tryParse(_pic));
                                              picName.add(_picName);
                                              useActionPlan.add(true);
                                              statusActionPlan.add('OPEN');
                                              dateDoneActionPlan.add(null);
                                              noteActionPlan.add(null);
                                            } else {
                                              dueDateArray.add(null);
                                              dueDateArrayView.add(null);
                                              actionPlanArray.add(null);
                                              picID.add(null);
                                              picName.add(null);
                                              statusActionPlan.add(null);
                                              dateDoneActionPlan.add(null);
                                              useActionPlan.add(false);
                                              noteActionPlan.add(null);
                                            }
                                          });

                                          docReference.updateData({
                                            'issueNotulen': issueArray,
                                            'actionPlanNotulen': actionPlanArray,
                                            'picIDNotulen': picID,
                                            'picNameNotulen': picName,
                                            'dueDateNotulen': dueDateArray,
                                            'userCreatedNotulen': userCreatedNotulen,
                                            'useActionPlan': useActionPlan,
                                            'statusActionPlan': statusActionPlan,
                                            'dateDoneActionPlan': dateDoneActionPlan,
                                            'noteActionPlan': noteActionPlan
                                          }).then((doc) async {
                                            await new Future.delayed(Duration(
                                              seconds: 1
                                            ));
                                            setState(() {
                                              controllerIssue.clear();
                                              controllerActionPlan.clear();
                                              controllerDueDate.clear();
                                              
                                              addNotulen = false;
                                              showError = false;
                                              showActionPlan = false;
                                              _value1 = 1;
                                            });
                                          }).catchError((error) {
                                            print(error);
                                          });
                                        }
                                      } else {
                                        setState(() {
                                          _autoValidate = true;
                                          if (_value1 == 1 || _value1 == 2) {
                                            showError = false;
                                          } else {
                                            showError = true;
                                          }
                                          addNotulen = false;
                                        });
                                      }
                                    },
                                  )
                                ),
                              )
                            ],
                          ),
                        ),
                        ListView(
                          children: <Widget>[
                            Container(
                              color: Colors.white,
                              child: Column(
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.fromLTRB(20.0, 8.0, 20.0, 10.0),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: <Widget>[
                                        Flexible(
                                          child: Text(
                                            'Notulen Data',
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.only(bottom: 10.0),
                                    child: Column(
                                      children: issueArray.length == 0
                                        ? <Widget>[
                                            Container(
                                              child: Center(
                                                child: Text(
                                                  'No Data',
                                                  style: TextStyle(
                                                    fontSize: 16.0,
                                                    fontWeight: FontWeight.bold
                                                  ),
                                                ),
                                              ),
                                            )
                                          ]
                                        : List.generate(issueArray.length, (index) {
                                        // Timestamp dueDate2 = dueDateArray[index];
                                        // if (userCreatedNotulen[index] == widget.idUser) {
                                          return Column(
                                            children: <Widget>[
                                              Padding(
                                                padding: const EdgeInsets.only(left: 20.0, right: 20.0, bottom: 5.0),
                                                child: Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  children: <Widget>[
                                                    Container(
                                                      width: MediaQuery.of(context).size.width * 0.2,
                                                      child: Row(
                                                        children: <Widget>[
                                                          Flexible(
                                                            child: Text(
                                                              'Issue / Note',
                                                              style: TextStyle(
                                                                fontSize: 13.0, color: Colors.black38, fontWeight: FontWeight.w500
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    Container(
                                                      width: MediaQuery.of(context).size.width * 0.5,
                                                      child: Row(
                                                        mainAxisAlignment: MainAxisAlignment.end,
                                                        children: <Widget>[
                                                          Flexible(
                                                            child: Text(
                                                              issueArray[index],
                                                              style: TextStyle(
                                                                fontSize: 13.0,
                                                                color: Colors.black38,
                                                                fontWeight: FontWeight.w500
                                                              ),
                                                              textAlign: TextAlign.end,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(left: 20.0, right: 20.0, bottom: 5.0),
                                                child: Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  children: <Widget>[
                                                    Container(
                                                      width: MediaQuery.of(context).size.width * 0.2,
                                                      child: Row(
                                                        children: <Widget>[
                                                          Flexible(
                                                            child: Text(
                                                              'Action Plan',
                                                              style: TextStyle(
                                                                fontSize: 13.0, color: Colors.black38, fontWeight: FontWeight.w500
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    Container(
                                                      width: MediaQuery.of(context).size.width * 0.5,
                                                      child: Row(
                                                        mainAxisAlignment: MainAxisAlignment.end,
                                                        children: <Widget>[
                                                          Flexible(
                                                            child: Text(
                                                              actionPlanArray[index] == null ? '-' : actionPlanArray[index],
                                                              style: TextStyle(
                                                                fontSize: 13.0,
                                                                color: Colors.black38,
                                                                fontWeight: FontWeight.w500
                                                              ),
                                                              textAlign: TextAlign.end,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(left: 20.0, right: 20.0, bottom: 5.0),
                                                child: Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  children: <Widget>[
                                                    Container(
                                                      width: MediaQuery.of(context).size.width * 0.2,
                                                      child: Row(
                                                        children: <Widget>[
                                                          Flexible(
                                                            child: Text(
                                                              'PIC',
                                                              style: TextStyle(
                                                                fontSize: 13.0, color: Colors.black38, fontWeight: FontWeight.w500
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    Container(
                                                      width: MediaQuery.of(context).size.width * 0.5,
                                                      child: Row(
                                                        mainAxisAlignment: MainAxisAlignment.end,
                                                        children: <Widget>[
                                                          Flexible(
                                                            child: Text(
                                                              picName[index] == null ? '-' : picName[index],
                                                              style: TextStyle(
                                                                fontSize: 13.0,
                                                                color: Colors.black38,
                                                                fontWeight: FontWeight.w500
                                                              ),
                                                              textAlign: TextAlign.end,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(left: 20.0, right: 20.0, bottom: 5.0),
                                                child: Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  children: <Widget>[
                                                    Container(
                                                      width: MediaQuery.of(context).size.width * 0.2,
                                                      child: Row(
                                                        children: <Widget>[
                                                          Flexible(
                                                            child: Text(
                                                              'Due Date',
                                                              style: TextStyle(
                                                                fontSize: 13.0, color: Colors.black38, fontWeight: FontWeight.w500
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    Container(
                                                      width: MediaQuery.of(context).size.width * 0.5,
                                                      child: Row(
                                                        mainAxisAlignment: MainAxisAlignment.end,
                                                        children: <Widget>[
                                                          Flexible(
                                                            child: Text(
                                                              dueDateArrayView[index] == null ? '-' : dueDateArrayView[index].toString().substring(8, 10) + '/' + dueDateArrayView[index].toString().substring(5, 7) + '/' + dueDateArrayView[index].toString().substring(0, 4),
                                                              // '-',
                                                              style: TextStyle(
                                                                fontSize: 13.0,
                                                                color: Colors.black38,
                                                                fontWeight: FontWeight.w500
                                                              ),
                                                              textAlign: TextAlign.end,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ),
                                              Divider(height: 8.0),
                                            ],
                                          );
                                        // } else {
                                        //   return Container();
                                        // }
                                      }).toList(),
                                    ),
                                  )
                                ],
                              ),
                            )
                          ],
                        )
                      ],
                    );
              },
            )
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
        'assets/images/logo2.png',
        height: 150.0,
        width: 120.0,
      ),
      actions: <Widget>[
        AnimatedBuilder(
          animation: animationController,
          builder: (_, Widget child) {
            return animationController.isAnimating
              ? Container()
              : _isProccess
                  ? Container(
                      padding: EdgeInsets.only(right: 20.0),
                      child: Center(
                        child: SizedBox(
                          child: CircularProgressIndicator(),
                          height: 30.0,
                          width: 30.0,
                        ),
                      ),
                    )
                  : Padding(
                      padding: EdgeInsets.all(10.0),
                      child: ButtonTheme(
                        minWidth: 50.0,
                        height: 40.0,
                        child: RaisedButton(
                          elevation: 0.0,
                          shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(5.0)),
                          child: Text(
                            userCreated == widget.idUser
                              ? 'CLOSE MEETING'
                              : 'CHECKOUT',
                            style:
                            TextStyle(fontSize: 13.0, color: Colors.black54),
                          ),
                          color: Colors.grey[300],
                          onPressed: () async {
                            if (userCreated == widget.idUser) {
                              showDialog(
                                barrierDismissible: false,
                                context: context,
                                builder: (context) {
                                  return MeetingEvaluation(
                                    indexx: widget.index,
                                    idUser: widget.idUser,
                                    departmentUser: widget.departmentUser,
                                    namaUser: widget.namaUser,
                                  );
                                }
                              );
                            } else {
                              setState(() {
                                _isProccess = true;
                              });
                              Firestore.instance.collection('minutesMeeting').document(widget.index).snapshots().listen((data) {
                                setState(() {
                                  checkOut = List<dynamic>.from(data.data['checkOutPeserta']);
                                  checkOut.removeAt(data.data['pesertaID'].indexWhere((dynamic result) => result.toString().startsWith(widget.idUser.toString())));
                                  checkOut.insert(data.data['pesertaID'].indexWhere((dynamic result) => result.toString().startsWith(widget.idUser.toString())), DateTime.now());
                                });
                              });

                              await new Future.delayed(Duration(
                                seconds: 3
                              ));
                              
                              DocumentReference docReference = Firestore.instance.collection('minutesMeeting').document(widget.index);

                              docReference.updateData({
                                'checkOutPeserta':checkOut
                              }).then((doc) {
                                Navigator.pushReplacement(context,
                                  MaterialPageRoute(
                                    builder: (context) => FormCheckin(idUser: widget.idUser, namaUser: widget.namaUser, departmentUser: widget.departmentUser)
                                  )
                                );
                              }).catchError((error) {
                                print(error);
                              });
                            }
                          },
                        )
                      ),
                    );
          },
        )
      ],
      bottom: new TabBar(
        controller: _tabController,
        isScrollable: false,
        indicatorColor: AbubaPallate.greenabuba,
        tabs: internalAuditTabs,
      ),
    );
  }
}

class MeetingEvaluation extends StatefulWidget {
  var indexx;
  final int idUser;
  final String namaUser;
  final String departmentUser;

  MeetingEvaluation({this.indexx, this.idUser, this.departmentUser, this.namaUser});
  @override
  _MeetingEvaluationState createState() => _MeetingEvaluationState();
}

class _MeetingEvaluationState extends State<MeetingEvaluation> with TickerProviderStateMixin {
  var checkOut;
  List<DateTime> checkOutSave = [];

  var stickToTheAgenda = 0.0;
  var manageTime = 0.0;
  var followGroundRules = 0.0;
  var balanceOfParticipants = 0.0;
  var listenToEachOthers = 0.0;
  var makingProgress = 0.0;

  bool isProses = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        height: MediaQuery.of(context).size.height * 0.6,
        child: Column(
          children: <Widget>[
            Container(
              color: AbubaPallate.greenabuba,
              height: 50.0,
              child: Center(
                child: Text(
                  'Meeting Evaluation',
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
            Column(
              children: <Widget>[
                Container(
                  height: MediaQuery.of(context).size.height * 0.38,
                  child: Column(
                    children: <Widget>[
                      Expanded(
                        child: ListView(
                          physics: ScrollPhysics(),
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.only(left: 12.0, right: 12.0, bottom: 5.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Flexible(
                                    child: Text(
                                      'Stick to the agenda',
                                      style: TextStyle(
                                        color: AbubaPallate.greenabuba,
                                        fontSize: 15.0
                                      ),
                                    ),
                                  ),
                                  Flexible(
                                    child: Padding(
                                      padding: const EdgeInsets.fromLTRB(12.0, 0.0, 6.0, 12.0),
                                      child: SmoothStarRating(
                                        allowHalfRating: false,
                                        onRatingChanged: (v) {
                                          stickToTheAgenda= v;
                                          setState(() {});
                                        },
                                        starCount: 5,
                                        rating: stickToTheAgenda,
                                        size: 26.0,
                                        color: Colors.orangeAccent,
                                        borderColor: Colors.grey,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 12.0, right: 12.0, bottom: 5.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Flexible(
                                    child: Text(
                                      'Manage time',
                                      style: TextStyle(
                                        color: AbubaPallate.greenabuba,
                                        fontSize: 15.0
                                      ),
                                    ),
                                  ),
                                  Flexible(
                                    child: Padding(
                                      padding: const EdgeInsets.fromLTRB(12.0, 0.0, 6.0, 12.0),
                                      child: SmoothStarRating(
                                        allowHalfRating: false,
                                        onRatingChanged: (v) {
                                          manageTime= v;
                                          setState(() {});
                                        },
                                        starCount: 5,
                                        rating: manageTime,
                                        size: 26.0,
                                        color: Colors.orangeAccent,
                                        borderColor: Colors.grey,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 12.0, right: 12.0, bottom: 5.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Flexible(
                                    child: Text(
                                      'Follow ground rules',
                                      style: TextStyle(
                                        color: AbubaPallate.greenabuba,
                                        fontSize: 15.0
                                      ),
                                    ),
                                  ),
                                  Flexible(
                                    child: Padding(
                                      padding: const EdgeInsets.fromLTRB(12.0, 0.0, 6.0, 12.0),
                                      child: SmoothStarRating(
                                        allowHalfRating: false,
                                        onRatingChanged: (v) {
                                          followGroundRules= v;
                                          setState(() {});
                                        },
                                        starCount: 5,
                                        rating: followGroundRules,
                                        size: 26.0,
                                        color: Colors.orangeAccent,
                                        borderColor: Colors.grey,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 12.0, right: 12.0, bottom: 5.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Flexible(
                                    child: Text(
                                      'Balance of participants',
                                      style: TextStyle(
                                        color: AbubaPallate.greenabuba,
                                        fontSize: 15.0
                                      ),
                                    ),
                                  ),
                                  Flexible(
                                    child: Padding(
                                      padding: const EdgeInsets.fromLTRB(12.0, 0.0, 6.0, 12.0),
                                      child: SmoothStarRating(
                                        allowHalfRating: false,
                                        onRatingChanged: (v) {
                                          balanceOfParticipants= v;
                                          setState(() {});
                                        },
                                        starCount: 5,
                                        rating: balanceOfParticipants,
                                        size: 26.0,
                                        color: Colors.orangeAccent,
                                        borderColor: Colors.grey,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 12.0, right: 12.0, bottom: 5.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Flexible(
                                    child: Text(
                                      'Listen to each others',
                                      style: TextStyle(
                                        color: AbubaPallate.greenabuba,
                                        fontSize: 15.0
                                      ),
                                    ),
                                  ),
                                  Flexible(
                                    child: Padding(
                                      padding: const EdgeInsets.fromLTRB(12.0, 0.0, 6.0, 12.0),
                                      child: SmoothStarRating(
                                        allowHalfRating: false,
                                        onRatingChanged: (v) {
                                          listenToEachOthers= v;
                                          setState(() {});
                                        },
                                        starCount: 5,
                                        rating: listenToEachOthers,
                                        size: 26.0,
                                        color: Colors.orangeAccent,
                                        borderColor: Colors.grey,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 12.0, right: 12.0, bottom: 5.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Flexible(
                                    child: Text(
                                      'Making progress',
                                      style: TextStyle(
                                        color: AbubaPallate.greenabuba,
                                        fontSize: 15.0
                                      ),
                                    ),
                                  ),
                                  Flexible(
                                    child: Padding(
                                      padding: const EdgeInsets.fromLTRB(12.0, 0.0, 6.0, 12.0),
                                      child: SmoothStarRating(
                                        allowHalfRating: false,
                                        onRatingChanged: (v) {
                                          makingProgress= v;
                                          setState(() {});
                                        },
                                        starCount: 5,
                                        rating: makingProgress,
                                        size: 26.0,
                                        color: Colors.orangeAccent,
                                        borderColor: Colors.grey,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        )
                      )
                    ],
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                FlatButton(
                  child: Text('CANCEL', style: TextStyle(color: Colors.grey)),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                isProses
                  ? Container(
                      padding: EdgeInsets.only(right: 20.0),
                      child: Center(
                        child: SizedBox(
                          child: CircularProgressIndicator(
                            strokeWidth: 2.0,
                          ),
                          height: 20.0,
                          width: 20.0,
                        ),
                      ),
                    )
                  : FlatButton(
                      child: Text('OK', style: TextStyle(color: Colors.grey)),
                      onPressed: () async {
                        setState(() {
                          isProses = true;
                        });
                        Firestore.instance.collection('minutesMeeting').document(widget.indexx).snapshots().listen((data) {
                          setState(() {
                            checkOut = List<dynamic>.from(data.data['checkOutPeserta']);
                          });
                        });

                        await new Future.delayed(Duration(
                          seconds: 3
                        ));

                        for (int c = 0; c < checkOut.length; c++) {
                          checkOutSave.add(DateTime.now());
                        }

                        await new Future.delayed(Duration(
                          seconds: 3
                        ));

                        DocumentReference docReference = Firestore.instance.collection('minutesMeeting').document(widget.indexx);

                        docReference.updateData({
                          'status': 'CLOSE',
                          'checkOutPeserta':checkOutSave,
                          'meetingEnd': DateTime.now(),
                          'stickToTheAgenda': stickToTheAgenda,
                          'manageTime': manageTime,
                          'followGroundRules': followGroundRules,
                          'balanceOfParticipants': balanceOfParticipants,
                          'listenToEachOthers': listenToEachOthers,
                          'makingProgress': makingProgress,
                        }).then((doc) {
                          setState(() {
                            isProses = false;
                          });
                          Navigator.pushReplacement(context,
                            MaterialPageRoute(
                              builder: (context) => FormCheckin(idUser: widget.idUser, namaUser: widget.namaUser, departmentUser: widget.departmentUser)
                            )
                          );
                        }).catchError((error) {
                          print(error);
                        });
                      },
                    ),
              ],
            )
          ],
        ),
      ),
    );
  }
}