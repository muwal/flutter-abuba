import 'package:flutter/material.dart';
import 'package:flutter_abuba/constant.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_abuba/isoft/operation_page/meeting/beranda_meeting.dart';
import 'package:flutter_abuba/isoft/operation_page/meeting/detail_task.dart';

class DoneTask extends StatefulWidget {
  final int idUser;
  final String namaUser;
  final String departmentUser;
  DoneTask({this.idUser, this.namaUser, this.departmentUser});

  @override
  _DoneTaskState createState() => _DoneTaskState();
}

class _DoneTaskState extends State<DoneTask> with TickerProviderStateMixin {
  TabController _tabController;
  AnimationController animationController;

  final List<Tab> internalAuditTabs = <Tab>[
    new Tab(child: Text('Today', style: TextStyle(color: Colors.grey[400]))),
    new Tab(child: Text('All', style: TextStyle(color: Colors.grey[400]))),
  ];

  var checkIn;
  List<dynamic> location = [];
  List<dynamic> userCreated = [];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: internalAuditTabs.length);

    CollectionReference reference = Firestore.instance.collection('minutesMeeting');
    reference.snapshots().listen((querySnapshot) {
      querySnapshot.documentChanges.forEach((change) {
        setState(() {
          // if (change.document.data['status'] == 'CLOSE') {
            // if (change.document.data['picIDNotulen'].contains(widget.idUser)) {
              // if (change.document.data['statusActionPlan'].contains('OPEN')) {
                Firestore.instance.collection('locationMeeting').where('id', isEqualTo: change.document.data['location']).snapshots().listen((data) {
                  location.add(data.documents[0].data['location']);
                });
                Firestore.instance.collection('user').where('id', isEqualTo: change.document.data['userCreated']).snapshots().listen((data2) {
                  userCreated.add(data2.documents[0].data['nama']);
                });
              // }
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
                                      if (snapshot.data.documents[index].data['status'] != 'CLOSE') {
                                        return Container();  
                                      } else {
                                        if (snapshot.data.documents[index].data['picIDNotulen'].contains(widget.idUser)) {
                                          if (snapshot.data.documents[index].data['statusActionPlan'][snapshot.data.documents[index].data['picIDNotulen'].indexWhere((dynamic result) => result.toString().startsWith(widget.idUser.toString()))] == 'OPEN') {
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
                                                          Row(
                                                            mainAxisAlignment: MainAxisAlignment.end,
                                                            children: <Widget>[
                                                              Tooltip(
                                                                message: snapshot.data.documents[index].data['statusActionPlan'].contains('OPEN') ? 'There is an unfinished task' : 'All tasks have been completed',
                                                                child: ButtonTheme(
                                                                  minWidth: MediaQuery.of(context).size.width * 0.35,
                                                                  height: 30.0,
                                                                  child: OutlineButton(
                                                                    child: Row(
                                                                      children: <Widget>[
                                                                        Container(
                                                                          width: MediaQuery.of(context).size.width * 0.15,
                                                                          alignment: Alignment.centerLeft,
                                                                          child: Text(
                                                                            'FOLLOW UP',
                                                                            style: TextStyle(
                                                                              fontSize: 13.0,
                                                                              color: snapshot.data.documents[index].data['statusActionPlan'].contains('OPEN') ? Colors.redAccent : AbubaPallate.menuBluebird,
                                                                              fontWeight: FontWeight.bold
                                                                            ),
                                                                          ),
                                                                        ),
                                                                        Container(
                                                                          width: MediaQuery.of(context).size.width * 0.15,
                                                                          alignment: Alignment.centerRight,
                                                                          child: Icon(Icons.arrow_forward, color: snapshot.data.documents[index].data['statusActionPlan'].contains('OPEN') ? Colors.redAccent : AbubaPallate.menuBluebird, size: 18.0),
                                                                        )
                                                                      ],
                                                                    ),
                                                                    borderSide: BorderSide(color: snapshot.data.documents[index].data['statusActionPlan'].contains('OPEN') ? Colors.redAccent : AbubaPallate.menuBluebird, width: 1.0),
                                                                    highlightedBorderColor: snapshot.data.documents[index].data['statusActionPlan'].contains('OPEN') ? Colors.redAccent : AbubaPallate.menuBluebird,
                                                                    onPressed: () {
                                                                      Navigator.push(context,
                                                                        MaterialPageRoute(
                                                                          builder: (_) => DetailTask(idUser: widget.idUser, namaUser: widget.namaUser, departmentUser: widget.departmentUser, index: snapshot.data.documents[index].documentID, pic: snapshot.data.documents[index].data['picIDNotulen'], createdNotulen: snapshot.data.documents[index].data['userCreatedNotulen'], noteActionPlan: snapshot.data.documents[index].data['noteActionPlan'])
                                                                        )
                                                                      );
                                                                    },
                                                                  ),
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
