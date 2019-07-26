import 'package:flutter/material.dart';
import 'package:flutter_abuba/constant.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_abuba/isoft/operation_page/meeting/beranda_meeting.dart';

import 'form_notulen.dart';

class FormCheckin extends StatefulWidget {
  final int idUser;
  final String namaUser;
  final String departmentUser;
  FormCheckin({this.idUser, this.namaUser, this.departmentUser});

  @override
  _FormCheckinState createState() => _FormCheckinState();
}

class _FormCheckinState extends State<FormCheckin> with TickerProviderStateMixin {
  TabController _tabController;
  AnimationController animationController;

  final List<Tab> internalAuditTabs = <Tab>[
    new Tab(child: Text('Today', style: TextStyle(color: Colors.grey[400]))),
    new Tab(child: Text('All', style: TextStyle(color: Colors.grey[400]))),
  ];

  var checkIn;
  List<dynamic> location = [];
  List<dynamic> userCreated = [];
  List<dynamic> agenda = [];
  List<dynamic> peserta = [];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: internalAuditTabs.length);

    CollectionReference reference = Firestore.instance.collection('minutesMeeting');
    reference.snapshots().listen((querySnapshot) {
      querySnapshot.documentChanges.forEach((change) {
        setState(() {
          agenda.add(change.document.data['agenda']);
          peserta.add(change.document.data['pesertaID']);
          Timestamp dateMeetingBantu = change.document.data['dateMeeting'];
          // if (change.document.data['status'] != 'CLOSE') {
            // if (dateMeetingBantu.toDate().toString().substring(8, 10) + '/' + dateMeetingBantu.toDate().toString().substring(5, 7) + '/' +dateMeetingBantu.toDate().toString().substring(0, 4) == DateTime.now().toString().substring(8, 10) + '/' + DateTime.now().toString().substring(5, 7) + '/' +DateTime.now().toString().substring(0, 4)) {
              Firestore.instance.collection('locationMeeting').where('id', isEqualTo: change.document.data['location']).snapshots().listen((data) {
                location.add(data.documents[0].data['location']);
              });
              Firestore.instance.collection('user').where('id', isEqualTo: change.document.data['userCreated']).snapshots().listen((data2) {
                userCreated.add(data2.documents[0].data['nama']);
              });
            // }
          // }
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
                        ListView(
                          children: <Widget>[
                            Container(
                              child: StreamBuilder(
                                stream: Firestore.instance.collection('minutesMeeting').snapshots(),
                                builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                                  if (!snapshot.hasData)
                                    return Container(
                                      child: Center(
                                        child: CircularProgressIndicator(),
                                      ),
                                    );
                                  
                                  return Column(
                                    children: List.generate(snapshot.data.documents.length, (index) {
                                      Timestamp dateMeeting = snapshot.data.documents[index].data['dateMeeting'];
                                      if (snapshot.data.documents[index].data['status'] == 'CLOSE') {
                                        return Container();  
                                      } else {
                                        if (dateMeeting.toDate().toString().substring(8, 10) + '/' + dateMeeting.toDate().toString().substring(5, 7) + '/' +dateMeeting.toDate().toString().substring(0, 4) == DateTime.now().toString().substring(8, 10) + '/' + DateTime.now().toString().substring(5, 7) + '/' +DateTime.now().toString().substring(0, 4)) {
                                          return Column(
                                            crossAxisAlignment: CrossAxisAlignment.stretch,
                                            verticalDirection: VerticalDirection.down,
                                            children: <Widget>[
                                              Container(
                                                padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
                                                color: Colors.transparent,
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    borderRadius: BorderRadius.circular(30.0),
                                                    border: Border.all(
                                                      width: 1.0,
                                                      color: Colors.black12
                                                    )
                                                  ),
                                                  child: Padding(
                                                    padding: EdgeInsets.all(25.0),
                                                    child: Column(
                                                      children: <Widget>[
                                                        Padding(
                                                          padding: const EdgeInsets.only(left: 5.0, right: 5.0, bottom: 5.0),
                                                          child: Row(
                                                            mainAxisAlignment: MainAxisAlignment.start,
                                                            children: <Widget>[
                                                              Flexible(
                                                                child: Text(
                                                                  dateMeeting.toDate().toString().substring(8, 10) + '/' + dateMeeting.toDate().toString().substring(5, 7) + '/' +dateMeeting.toDate().toString().substring(0, 4) + ' - ' + dateMeeting.toDate().toString().substring(11, 16),
                                                                  style: TextStyle(
                                                                    fontSize: 15.0,
                                                                    fontWeight: FontWeight.w400,
                                                                    color: Colors.black87
                                                                  ),
                                                                ),
                                                              )
                                                            ],
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding: const EdgeInsets.only(left: 5.0, right: 5.0, bottom: 20.0),
                                                          child: Row(
                                                            mainAxisAlignment: MainAxisAlignment.start,
                                                            children: <Widget>[
                                                              Flexible(
                                                                child: Text(
                                                                  snapshot.data.documents[index].data['namaMeeting'],
                                                                  style: TextStyle(
                                                                    fontSize: 20.0,
                                                                    fontWeight: FontWeight.w700,
                                                                    color: AbubaPallate.greenabuba
                                                                  ),
                                                                ),
                                                              )
                                                            ],
                                                          ),
                                                        ),
                                                        Row(
                                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                          children: <Widget>[
                                                            Flexible(
                                                              child: Padding(
                                                                padding: const EdgeInsets.only(left: 5.0, right: 5.0, bottom: 5.0),
                                                                child: Row(
                                                                  mainAxisAlignment: MainAxisAlignment.start,
                                                                  children: <Widget>[
                                                                    Flexible(
                                                                      child: Text(
                                                                        'LOCATION',
                                                                        style: TextStyle(
                                                                          fontSize: 15.0,
                                                                          fontWeight: FontWeight.w800,
                                                                          color: Colors.black54,
                                                                          letterSpacing: 1.0
                                                                        ),
                                                                      ),
                                                                    )
                                                                  ],
                                                                ),
                                                              ),
                                                            ),
                                                            Flexible(
                                                              child: Padding(
                                                                padding: const EdgeInsets.only(left: 5.0, right: 5.0, bottom: 5.0),
                                                                child: Row(
                                                                  mainAxisAlignment: MainAxisAlignment.end,
                                                                  children: <Widget>[
                                                                    Flexible(
                                                                      child: Text(
                                                                        'MEETING LEADER',
                                                                        style: TextStyle(
                                                                          fontSize: 15.0,
                                                                          fontWeight: FontWeight.w800,
                                                                          color: Colors.black54,
                                                                          letterSpacing: 1.0
                                                                        ),
                                                                      ),
                                                                    )
                                                                  ],
                                                                ),
                                                              ),
                                                            )
                                                          ],
                                                        ),
                                                        Row(
                                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                          children: <Widget>[
                                                            Flexible(
                                                              child: Padding(
                                                                padding: const EdgeInsets.only(left: 5.0, right: 5.0, bottom: 5.0, top: 3.0),
                                                                child: Row(
                                                                  mainAxisAlignment: MainAxisAlignment.start,
                                                                  children: <Widget>[
                                                                    Flexible(
                                                                      child: Text(
                                                                        location[index] == null ? '-' : location[index],
                                                                        style: TextStyle(
                                                                          fontSize: 15.0,
                                                                          fontWeight: FontWeight.w400,
                                                                          color: Colors.black87
                                                                        ),
                                                                      ),
                                                                    )
                                                                  ],
                                                                ),
                                                              ),
                                                            ),
                                                            Flexible(
                                                              child: Padding(
                                                                padding: const EdgeInsets.only(left: 5.0, right: 5.0, bottom: 5.0, top: 3.0),
                                                                child: Row(
                                                                  mainAxisAlignment: MainAxisAlignment.end,
                                                                  children: <Widget>[
                                                                    Flexible(
                                                                      child: Text(
                                                                        userCreated[index] == null ? '-' : userCreated[index],
                                                                        style: TextStyle(
                                                                          fontSize: 15.0,
                                                                          fontWeight: FontWeight.w400,
                                                                          color: Colors.black87
                                                                        ),
                                                                        textAlign: TextAlign.end,
                                                                      ),
                                                                    )
                                                                  ],
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                        snapshot.data.documents[index].data['pesertaID'].contains(widget.idUser)
                                                          ? snapshot.data.documents[index].data['checkOutPeserta'][snapshot.data.documents[index].data['pesertaID'].indexWhere((dynamic result) => result.toString().startsWith(widget.idUser.toString()))] != null
                                                              ? Row(
                                                                  mainAxisAlignment: MainAxisAlignment.start,
                                                                  children: <Widget>[
                                                                    ButtonTheme(
                                                                      minWidth: MediaQuery.of(context).size.width * 0.35,
                                                                      height: 30.0,
                                                                      child: OutlineButton(
                                                                        child: Row(
                                                                          children: <Widget>[
                                                                            Container(
                                                                              width: MediaQuery.of(context).size.width * 0.15,
                                                                              alignment: Alignment.centerLeft,
                                                                              child: Text(
                                                                                'VIEW',
                                                                                style: TextStyle(
                                                                                  fontSize: 13.0,
                                                                                  color: AbubaPallate.menuBluebird,
                                                                                  fontWeight: FontWeight.bold
                                                                                ),
                                                                              ),
                                                                            ),
                                                                            Container(
                                                                              width: MediaQuery.of(context).size.width * 0.15,
                                                                              alignment: Alignment.centerRight,
                                                                              child: Icon(Icons.visibility, color: AbubaPallate.menuBluebird, size: 18.0),
                                                                            )
                                                                          ],
                                                                        ),
                                                                        borderSide: BorderSide(color: AbubaPallate.menuBluebird, width: 2.0),
                                                                        highlightedBorderColor: AbubaPallate.menuBluebird,
                                                                        splashColor: Colors.white,
                                                                        onPressed: () {
                                                                          showDialog(
                                                                            barrierDismissible: false,
                                                                            context: context,
                                                                            builder: (context) {
                                                                              return ViewDialog(
                                                                                agenda: snapshot.data.documents[index].data['agenda'],
                                                                                peserta: snapshot.data.documents[index].data['pesertaID'],
                                                                                namaMeeting: snapshot.data.documents[index].data['namaMeeting'],
                                                                              );
                                                                            }
                                                                          );
                                                                        },
                                                                      ),
                                                                    ),
                                                                  ],
                                                                )
                                                              : Row(
                                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                  children: <Widget>[
                                                                    ButtonTheme(
                                                                      minWidth: MediaQuery.of(context).size.width * 0.35,
                                                                      height: 30.0,
                                                                      child: OutlineButton(
                                                                        child: Row(
                                                                          children: <Widget>[
                                                                            Container(
                                                                              width: MediaQuery.of(context).size.width * 0.15,
                                                                              alignment: Alignment.centerLeft,
                                                                              child: Text(
                                                                                'VIEW',
                                                                                style: TextStyle(
                                                                                  fontSize: 13.0,
                                                                                  color: AbubaPallate.menuBluebird,
                                                                                  fontWeight: FontWeight.bold
                                                                                ),
                                                                              ),
                                                                            ),
                                                                            Container(
                                                                              width: MediaQuery.of(context).size.width * 0.15,
                                                                              alignment: Alignment.centerRight,
                                                                              child: Icon(Icons.visibility, color: AbubaPallate.menuBluebird, size: 18.0),
                                                                            )
                                                                          ],
                                                                        ),
                                                                        borderSide: BorderSide(color: AbubaPallate.menuBluebird, width: 2.0),
                                                                        highlightedBorderColor: AbubaPallate.menuBluebird,
                                                                        splashColor: Colors.white,
                                                                        onPressed: () {
                                                                          showDialog(
                                                                            barrierDismissible: false,
                                                                            context: context,
                                                                            builder: (context) {
                                                                              return ViewDialog(
                                                                                agenda: snapshot.data.documents[index].data['agenda'],
                                                                                peserta: snapshot.data.documents[index].data['pesertaID'],
                                                                                namaMeeting: snapshot.data.documents[index].data['namaMeeting'],
                                                                              );
                                                                            }
                                                                          );
                                                                        },
                                                                      ),
                                                                    ),
                                                                    SizedBox(
                                                                      width: 5.0,
                                                                    ),
                                                                    ButtonTheme(
                                                                      minWidth: MediaQuery.of(context).size.width * 0.35,
                                                                      height: 30.0,
                                                                      child: RaisedButton(
                                                                        child: Row(
                                                                          children: <Widget>[
                                                                            Container(
                                                                              width: MediaQuery.of(context).size.width * 0.15,
                                                                              alignment: Alignment.centerLeft,
                                                                              child: Text(
                                                                                snapshot.data.documents[index].data['pesertaHadir'].contains(widget.idUser)
                                                                                  ? 'CONTINUE'
                                                                                  : 'CHECK IN',
                                                                                style: TextStyle(
                                                                                  fontSize: 13.0,
                                                                                  color: Colors.white,
                                                                                  fontWeight: FontWeight.bold
                                                                                ),
                                                                              ),
                                                                            ),
                                                                            Container(
                                                                              width: MediaQuery.of(context).size.width * 0.15,
                                                                              alignment: Alignment.centerRight,
                                                                              child: Icon(Icons.arrow_forward, color: Colors.white, size: 18.0),
                                                                            )
                                                                          ],
                                                                        ),
                                                                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
                                                                        color: AbubaPallate.menuBluebird,
                                                                        splashColor: AbubaPallate.menuBluebird,
                                                                        onPressed: () {
                                                                          if (snapshot.data.documents[index].data['userCreated'] == widget.idUser) {
                                                                            if (snapshot.data.documents[index].data['pesertaHadir'].contains(widget.idUser)) {
                                                                              Navigator.pushReplacement(context,
                                                                                MyCustomRoute(
                                                                                  builder: (context) => MenuNotulen(idUser: widget.idUser, namaUser: widget.namaUser, departmentUser: widget.departmentUser, index: snapshot.data.documents[index].documentID)
                                                                                )
                                                                              );
                                                                            } else {
                                                                              checkIn = List<dynamic>.from(snapshot.data.documents[index].data['checkInPeserta']);
                                                                              checkIn.removeAt(snapshot.data.documents[index].data['pesertaID'].indexWhere((dynamic result) => result.toString().startsWith(widget.idUser.toString())));
                                                                              checkIn.insert(snapshot.data.documents[index].data['pesertaID'].indexWhere((dynamic result) => result.toString().startsWith(widget.idUser.toString())), DateTime.now());

                                                                              DocumentReference docReference = Firestore.instance.collection('minutesMeeting').document(snapshot.data.documents[index].documentID);

                                                                              docReference.updateData({
                                                                                'status': 'ONGOING',
                                                                                'meetingStart': DateTime.now(),
                                                                                'checkInPeserta': checkIn,
                                                                                'pesertaHadir':FieldValue.arrayUnion([widget.idUser]),
                                                                                'issueNotulen': [],
                                                                                'actionPlanNotulen': [],
                                                                                'picIDNotulen': [],
                                                                                'picNameNotulen': [],
                                                                                'dueDateNotulen': [],
                                                                                'useActionPlan': [],
                                                                                'userCreatedNotulen': [],
                                                                                'statusActionPlan': [],
                                                                                'dateDoneActionPlan': [],
                                                                                'noteActionPlan': [],
                                                                              }).then((doc) {
                                                                                Navigator.pushReplacement(context,
                                                                                  MyCustomRoute(
                                                                                    builder: (context) => MenuNotulen(idUser: widget.idUser, namaUser: widget.namaUser, departmentUser: widget.departmentUser, index: snapshot.data.documents[index].documentID)
                                                                                  )
                                                                                );
                                                                              }).catchError((error) {
                                                                                print(error);
                                                                              });
                                                                            }
                                                                          } else {
                                                                            if (snapshot.data.documents[index].data['status'] == 'ONGOING') {
                                                                              if (snapshot.data.documents[index].data['pesertaHadir'].contains(widget.idUser)) {
                                                                                Navigator.pushReplacement(context,
                                                                                  MyCustomRoute(
                                                                                    builder: (context) => MenuNotulen(idUser: widget.idUser, namaUser: widget.namaUser, departmentUser: widget.departmentUser, index: snapshot.data.documents[index].documentID)
                                                                                  )
                                                                                );
                                                                              } else {
                                                                                DocumentReference docReference = Firestore.instance.collection('minutesMeeting').document(snapshot.data.documents[index].documentID);

                                                                                checkIn = List<dynamic>.from(snapshot.data.documents[index].data['checkInPeserta']);
                                                                                checkIn.removeAt(snapshot.data.documents[index].data['pesertaID'].indexWhere((dynamic result) => result.toString().startsWith(widget.idUser.toString())));
                                                                                checkIn.insert(snapshot.data.documents[index].data['pesertaID'].indexWhere((dynamic result) => result.toString().startsWith(widget.idUser.toString())), DateTime.now());

                                                                                docReference.updateData({
                                                                                  'checkInPeserta': checkIn,
                                                                                  'pesertaHadir':FieldValue.arrayUnion([widget.idUser]),
                                                                                  'issueNotulen': [],
                                                                                  'actionPlanNotulen': [],
                                                                                  'picIDNotulen': [],
                                                                                  'picNameNotulen': [],
                                                                                  'dueDateNotulen': [],
                                                                                  'userCreatedNotulen': [],
                                                                                  'useActionPlan': [],
                                                                                  'statusActionPlan': [],
                                                                                  'dateDoneActionPlan': [],
                                                                                  'noteActionPlan': [],
                                                                                }).then((doc) {
                                                                                  Navigator.pushReplacement(context,
                                                                                    MyCustomRoute(
                                                                                      builder: (context) => MenuNotulen(idUser: widget.idUser, namaUser: widget.namaUser, departmentUser: widget.departmentUser, index: snapshot.data.documents[index].documentID)
                                                                                    )
                                                                                  );
                                                                                }).catchError((error) {
                                                                                  print(error);
                                                                                });
                                                                              }
                                                                            } else if (snapshot.data.documents[index].data['status'] == 'OPEN') {
                                                                              showDialog(
                                                                                barrierDismissible: false,
                                                                                context: context,
                                                                                builder: (context) => Dialog(
                                                                                  child: Container(
                                                                                    height: 180.0,
                                                                                    child: Column(
                                                                                      children: <Widget>[
                                                                                        Container(
                                                                                          color: Colors.orangeAccent,
                                                                                          height: 50.0,
                                                                                          child: Center(
                                                                                            child: Text(
                                                                                              'ALERT!',
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
                                                                                            'The meeting has\'t started yet',
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
                                                                                                Navigator.pop(context);
                                                                                              },
                                                                                            ),
                                                                                          ],
                                                                                        )
                                                                                      ],
                                                                                    ),
                                                                                  ),
                                                                                )
                                                                              );
                                                                            }
                                                                          }
                                                                        },
                                                                      ),
                                                                    ),
                                                                  ],
                                                                )
                                                          : Row(
                                                              mainAxisAlignment: MainAxisAlignment.start,
                                                              children: <Widget>[
                                                                ButtonTheme(
                                                                  minWidth: MediaQuery.of(context).size.width * 0.35,
                                                                  height: 30.0,
                                                                  child: OutlineButton(
                                                                    child: Row(
                                                                      children: <Widget>[
                                                                        Container(
                                                                          width: MediaQuery.of(context).size.width * 0.15,
                                                                          alignment: Alignment.centerLeft,
                                                                          child: Text(
                                                                            'VIEW',
                                                                            style: TextStyle(
                                                                              fontSize: 13.0,
                                                                              color: AbubaPallate.menuBluebird,
                                                                              fontWeight: FontWeight.bold
                                                                            ),
                                                                          ),
                                                                        ),
                                                                        Container(
                                                                          width: MediaQuery.of(context).size.width * 0.15,
                                                                          alignment: Alignment.centerRight,
                                                                          child: Icon(Icons.visibility, color: AbubaPallate.menuBluebird, size: 18.0),
                                                                        )
                                                                      ],
                                                                    ),
                                                                    borderSide: BorderSide(color: AbubaPallate.menuBluebird, width: 2.0),
                                                                    highlightedBorderColor: AbubaPallate.menuBluebird,
                                                                    splashColor: Colors.white,
                                                                    onPressed: () {
                                                                      showDialog(
                                                                        barrierDismissible: false,
                                                                        context: context,
                                                                        builder: (context) {
                                                                          return ViewDialog(
                                                                            agenda: snapshot.data.documents[index].data['agenda'],
                                                                            peserta: snapshot.data.documents[index].data['pesertaID'],
                                                                            namaMeeting: snapshot.data.documents[index].data['namaMeeting'],
                                                                          );
                                                                        }
                                                                      );
                                                                    },
                                                                  ),
                                                                ),
                                                              ],
                                                            )
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              )
                                            ],
                                          );
                                        } else {
                                          return Container();
                                        }
                                      }
                                    }).toList()
                                  );
                                }
                              ),
                            )
                          ],
                        ),
                        ListView(
                          children: <Widget>[],
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
      leading: IconButton(
        onPressed: () {
          Navigator.pushReplacement(context,
            MaterialPageRoute(
              builder: (_) => MenuMeeting(idUser: widget.idUser, namaUser: widget.namaUser, departmentUser: widget.departmentUser)
            )
          );
        },
        icon: Icon(Icons.arrow_back),
      ),
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
      bottom: new TabBar(
        controller: _tabController,
        isScrollable: false,
        indicatorColor: AbubaPallate.greenabuba,
        tabs: internalAuditTabs,
      ),
    );
  }
}

class ViewDialog extends StatefulWidget {
  List<dynamic> agenda;
  List<dynamic> peserta;
  String namaMeeting;

  ViewDialog({this.agenda, this.peserta, this.namaMeeting});
  @override
  _ViewDialogState createState() => _ViewDialogState();
}

class _ViewDialogState extends State<ViewDialog> with TickerProviderStateMixin {
  AnimationController animationController;
  
  List<dynamic> agenda = [];
  List<dynamic> peserta = [];

  @override
  void initState() {
    setState(() {
      agenda = widget.agenda;
      for (int i = 0; i < widget.peserta.length; i++) {
        Firestore.instance.collection('user').where('id', isEqualTo: int.tryParse(widget.peserta[i].toString())).snapshots().listen((data) {
          peserta.add(data.documents[0].data['nama']);
        });
      }
    });

    animationController = AnimationController(vsync: this, duration: Duration(seconds: 3));
    animationController.reverse(
      from: animationController.value == 0.0
        ? 1.0
        : animationController.value
    );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        height: MediaQuery.of(context).size.height * 0.7,
        child: Column(
          children: <Widget>[
            Container(
              color: AbubaPallate.greenabuba,
              height: 50.0,
              child: Center(
                child: Text(
                  widget.namaMeeting,
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
            AnimatedBuilder(
              animation: animationController,
              builder: (_, Widget child) {
                return animationController.isAnimating
                  ? Container(
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    )
                  : Column(
                      children: <Widget>[
                        Container(
                          height: MediaQuery.of(context).size.height * 0.25,
                          child: Column(
                            children: <Widget>[
                              Expanded(
                                child: ListView.builder(
                                  physics: ScrollPhysics(),
                                  itemCount: agenda.length,
                                  itemBuilder: (BuildContext context, int index) {
                                    return Column(
                                      children: <Widget>[
                                        index == 0
                                          ? Container(
                                              alignment: Alignment.centerLeft,
                                              padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
                                              child: Text(
                                                'AGENDA',
                                                style: TextStyle(
                                                  fontSize: 16.0,
                                                  color: AbubaPallate.greenabuba,
                                                  fontWeight: FontWeight.w700
                                                ),
                                              ),
                                            )
                                          : Container(),
                                        Container(
                                          alignment: Alignment.centerLeft,
                                          padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 3.0),
                                          child: Text(
                                            '${index +1}. ${agenda[index].toString()}',
                                            style: TextStyle(
                                              fontSize: 14.0,
                                            ),
                                          ),
                                        )
                                      ],
                                    );
                                  }
                                )
                              )
                            ],
                          ),
                        ),
                        Container(
                          height: MediaQuery.of(context).size.height * 0.25,
                          child: Column(
                            children: <Widget>[
                              Expanded(
                                child: ListView.builder(
                                  physics: ScrollPhysics(),
                                  itemCount: peserta.length,
                                  itemBuilder: (BuildContext context, int index) {
                                    return Column(
                                      children: <Widget>[
                                        index == 0
                                          ? Container(
                                              alignment: Alignment.centerLeft,
                                              padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
                                              child: Text(
                                                'PESERTA',
                                                style: TextStyle(
                                                  fontSize: 16.0,
                                                  color: AbubaPallate.greenabuba,
                                                  fontWeight: FontWeight.w700
                                                ),
                                              ),
                                            )
                                          : Container(),
                                        Container(
                                          alignment: Alignment.centerLeft,
                                          padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 3.0),
                                          child: Text(
                                            '${index +1}. ${peserta[index].toString()}',
                                            style: TextStyle(
                                              fontSize: 14.0,
                                            ),
                                          ),
                                        )
                                      ],
                                    );
                                  }
                                )
                              )
                            ],
                          ),
                        )
                      ],
                    );
              },
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                FlatButton(
                  child: Text('OK', style: TextStyle(color: Colors.grey)),
                  onPressed: () {
                    Navigator.pop(context);
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