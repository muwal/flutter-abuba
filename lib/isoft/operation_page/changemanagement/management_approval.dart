import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_abuba/constant.dart';
import 'package:flutter_abuba/isoft/operation_page/changemanagement/management_approval_detail.dart';

class ManagementApproval extends StatefulWidget {
  final int idUser;
  final String namaUser;
  final String departmentUser;
  ManagementApproval({this.idUser, this.namaUser, this.departmentUser});

  @override
  _ManagementApprovalState createState() => _ManagementApprovalState();
}

class _ManagementApprovalState extends State<ManagementApproval> with TickerProviderStateMixin {
  AnimationController animationController;

  List<dynamic> category = [];
  List<dynamic> personReview = [];
  List<String> personReviewDate = [];

  @override
  void initState() {
    super.initState();

    CollectionReference reference = Firestore.instance.collection('changeMgmt');
    reference.snapshots().listen((querySnapshot) {
      querySnapshot.documentChanges.forEach((change) {
        setState(() {
          Firestore.instance.collection('changeMgmt_Category').where('id', isEqualTo: change.document.data['category']).snapshots().listen((data) {
            category.add(data.documents[0].data['category']);
          });
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
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          elevation: 0.25,
          backgroundColor: Colors.white,
          iconTheme: IconThemeData(color: Colors.black),
          // actions: <Widget>[
          //   IconButton(
          //     tooltip: 'Search',
          //     icon: Icon(Icons.search),
          //     onPressed: () {}
          //   )
          // ],
          title: Image.asset(
            'assets/images/logo2.png',
            height: 150.0,
            width: 120.0,
          ),
        ),
        body: Scrollbar(
          child: ListView(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'Change Management',
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
                        'Approval',
                        style: TextStyle(
                            color: AbubaPallate.greenabuba, fontSize: 12.0),
                      ),
                    ),
                  ],
                ),
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
                    : Container(
                        color: Colors.white,
                        width: width,
                        height: MediaQuery.of(context).size.height / 1.2,
                        child: Container(
                          child: StreamBuilder(
                            stream: Firestore.instance.collection('changeMgmt').snapshots(),
                            builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                              if (!snapshot.hasData)
                                return Container(
                                  child: Center(
                                    child: CircularProgressIndicator(),
                                  ),
                                );
                              
                              return Column(
                                children: List.generate(snapshot.data.documents.length, (index) {
                                  Timestamp tanggal = snapshot.data.documents[index].data['tglImplementasi'];

                                  return Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      index == 0
                                        ? Padding(
                                            padding: const EdgeInsets.fromLTRB(12.0, 12.0, 12.0, 0.0),
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: <Widget>[
                                                Container(
                                                  width: width / 5,
                                                  child: Row(
                                                    children: <Widget>[
                                                      Flexible(
                                                        child: Text(
                                                          'Tanggal',
                                                          style: TextStyle(color: Colors.green),
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                                Container(
                                                  width: width / 5,
                                                  child: Row(
                                                    mainAxisAlignment: MainAxisAlignment.start,
                                                    children: <Widget>[
                                                      Flexible(
                                                        child: Text(
                                                          'Kategori',
                                                          style: TextStyle(color: Colors.green),
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                                Container(
                                                  width: width / 5,
                                                  child: Row(
                                                    mainAxisAlignment: MainAxisAlignment.start,
                                                    children: <Widget>[
                                                      Flexible(
                                                        child: Text(
                                                          'Change #',
                                                          style: TextStyle(color: Colors.green),
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                                Container(
                                                  width: width / 5,
                                                  child: Row(
                                                    mainAxisAlignment: MainAxisAlignment.end,
                                                    children: <Widget>[
                                                      Flexible(
                                                        child: Text(
                                                          '',
                                                          style: TextStyle(color: Colors.green),
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          )
                                        : Container(),
                                      snapshot.data.documents[index].data['approveBy'] == widget.idUser
                                        ? snapshot.data.documents[index].data['finalStatus'] == 'OPEN'
                                            ? snapshot.data.documents[index].data['personReviewStatus'].contains('OPEN')
                                                ? Container()
                                                : Padding(
                                                    padding: const EdgeInsets.fromLTRB(12.0, 6.0, 12.0, 0.0),
                                                    child: Row(
                                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                      children: <Widget>[
                                                        Container(
                                                          width: width / 5,
                                                          child: Row(
                                                            children: <Widget>[
                                                              Flexible(
                                                                child: Text(
                                                                  tanggal.toDate().toString().substring(8, 10) + '/' + tanggal.toDate().toString().substring(5, 7) + '/' +tanggal.toDate().toString().substring(0, 4),
                                                                  style: TextStyle(
                                                                      fontSize: 12.0, color: Colors.black38),
                                                                ),
                                                              )
                                                            ],
                                                          ),
                                                        ),
                                                        Container(
                                                          width: width / 5,
                                                          child: Row(
                                                            mainAxisAlignment: MainAxisAlignment.start,
                                                            children: <Widget>[
                                                              Flexible(
                                                                child: Text(
                                                                  category[index],
                                                                  style: TextStyle(
                                                                      fontSize: 12.0, color: Colors.black38),
                                                                ),
                                                              )
                                                            ],
                                                          ),
                                                        ),
                                                        Container(
                                                          width: width / 5,
                                                          child: Row(
                                                            mainAxisAlignment: MainAxisAlignment.start,
                                                            children: <Widget>[
                                                              Flexible(
                                                                child: Text(
                                                                  snapshot.data.documents[index].data['changeNo'].toString().padLeft(4, '0'),
                                                                  style: TextStyle(
                                                                      fontSize: 12.0, color: Colors.black38),
                                                                ),
                                                              )
                                                            ],
                                                          ),
                                                        ),
                                                        Container(
                                                          width: width / 5,
                                                          child: Row(
                                                            mainAxisAlignment: MainAxisAlignment.start,
                                                            children: <Widget>[
                                                              Flexible(
                                                                child: ButtonTheme(
                                                                  minWidth: 50.0,
                                                                  height: 30.0,
                                                                  splashColor: AbubaPallate.menuBluebird,
                                                                  child: OutlineButton(
                                                                    borderSide: BorderSide(
                                                                        color: AbubaPallate.menuBluebird),
                                                                    child: Text(
                                                                      'Approval',
                                                                      style: TextStyle(
                                                                          fontSize: 12.0,
                                                                          color: AbubaPallate.menuBluebird),
                                                                      textAlign: TextAlign.center,
                                                                    ),
                                                                    onPressed: () {
                                                                      setState(() {
                                                                        personReview.clear();
                                                                        personReviewDate.clear();
                                                                        personReview = [];
                                                                        personReviewDate = [];

                                                                        personReview = snapshot.data.documents[index].data['personReview'];
                                                                        
                                                                        for (int a = 0; a < snapshot.data.documents[index].data['personReviewDate'].length; a++) {
                                                                          if (personReviewDate.length > snapshot.data.documents[index].data['personReviewDate'].length) {

                                                                          } else {
                                                                            if (snapshot.data.documents[index].data['personReviewDate'][a] == null) {
                                                                              personReviewDate.add(' ');
                                                                            } else {
                                                                              Timestamp bantu = snapshot.data.documents[index].data['personReviewDate'][a];
                                                                              personReviewDate.add(bantu.toDate().toString().substring(8, 10) + '/' + bantu.toDate().toString().substring(5, 7) + '/' +bantu.toDate().toString().substring(0, 4));
                                                                            }
                                                                          }
                                                                        }
                                                                      });
                                                                      Navigator.pushReplacement(context,
                                                                        MyCustomRoute(
                                                                          builder: (context) => ManagementApprovalDetail(idUser: widget.idUser, namaUser: widget.namaUser, departmentUser: widget.departmentUser, index: snapshot.data.documents[index].documentID, personReview: personReview, personReviewDate: personReviewDate)
                                                                        )
                                                                      );
                                                                    },
                                                                  ),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                  )
                                              : Container()
                                        : Container()
                                    ],
                                  );
                                }).toList(),
                              );
                            },
                          ),
                        )
                      );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}