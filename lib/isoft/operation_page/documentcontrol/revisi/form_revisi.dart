import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_abuba/constant.dart';
import 'detail_revisi.dart';

class FormRevisi extends StatefulWidget {
  final int idUser;
  final String namaUser;
  final String departmentUser;
  FormRevisi({this.idUser, this.namaUser, this.departmentUser});

  @override
  _FormRevisiState createState() => _FormRevisiState();
}

class _FormRevisiState extends State<FormRevisi> with TickerProviderStateMixin {
  AnimationController animationController;

  List<String> userCreated = [];
  List<String> department = [];
  List<Timestamp> dateCreated = [];

  List<String> userVerify = [];
  List<String> departmentVerify = [];
  List<Timestamp> dateVerify = [];

  List<String> userApprove = [];
  List<String> departmentApprove = [];
  List<Timestamp> dateApprove = [];

  List<dynamic> typeDoc = [];
  
  @override
  void initState() {
    super.initState();

    CollectionReference reference = Firestore.instance.collection('docControl');
    reference.snapshots().listen((querySnapshot) {
      querySnapshot.documentChanges.forEach((change) {
        setState(() {
          dateCreated.add(change.document.data['createdDate']);
          dateVerify.add(change.document.data['verifyDate']);

          typeDoc.add(change.document.data['type']);

          Firestore.instance.collection('user').where('id', isEqualTo: change.document.data['createdBy']).snapshots().listen((data6) {
            userCreated.add(data6.documents[0].data['nama']);

            Firestore.instance.collection('department').where('id', isEqualTo: data6.documents[0].data['departmentID']).snapshots().listen((data3) {
              department.add(data3.documents[0].data['department']);
            });
          });

          Firestore.instance.collection('user').where('id', isEqualTo: change.document.data['verifyBy']).snapshots().listen((data4) {
            userVerify.add(data4.documents[0].data['nama']);

            Firestore.instance.collection('department').where('id', isEqualTo: data4.documents[0].data['departmentID']).snapshots().listen((data5) {
              departmentVerify.add(data5.documents[0].data['department']);
            });
          });

          Firestore.instance.collection('user').where('id', isEqualTo: change.document.data['approvedBy']).snapshots().listen((data7) {
            userApprove.add(data7.documents[0].data['nama']);

            Firestore.instance.collection('department').where('id', isEqualTo: data7.documents[0].data['departmentID']).snapshots().listen((data8) {
              departmentApprove.add(data8.documents[0].data['department']);
            });
          });

          dateApprove.add(change.document.data['approvedDate']);
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
          child: _buildDetail(),
        ),
      ),
    );
  }

  Widget _buildDetail() {
    return Scrollbar(
      child: ListView(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Flexible(
                  child: Text(
                    'SOP',
                    style: TextStyle(color: Colors.black12, fontSize: 12.0),
                  ),
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
                    'Revisi',
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
                    child: StreamBuilder(
                      stream: Firestore.instance.collection('docControl').snapshots(),
                      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                        if (!snapshot.hasData)
                          return Container(
                            child: Center(
                              child: CircularProgressIndicator(),
                            )
                          );
                        
                        return Column(
                          children: List.generate(snapshot.data.documents.length, (index) {
                            if (snapshot.data.documents[index].data['createdBy'] == widget.idUser) {
                              if (snapshot.data.documents[index].data['status'] == 'REJECTED') {
                                return Container(
                                  color: Colors.white,
                                  child: ExpansionTile(
                                    title: Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: <Widget>[
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            Flexible(
                                              child: Text(
                                                snapshot.data.documents[index].data['judul'],
                                                style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w600),
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 3.0
                                        ),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          children: <Widget>[
                                            Flexible(
                                              child: Text(
                                                snapshot.data.documents[index].data['noDoc'],
                                                style: TextStyle(fontSize: 14.0, color: Colors.black38),
                                              ),
                                            ),
                                            SizedBox(
                                              width: 15.0,
                                            ),
                                            Flexible(
                                              child: Text(
                                                'Rev ${snapshot.data.documents[index].data['lastRevisi'].toString().padLeft(2, '0')}',
                                                style: TextStyle(fontSize: 14.0, color: Colors.black38),
                                              ),
                                            )
                                          ],
                                        )
                                      ],
                                    ),
                                    children: <Widget>[
                                      Padding(
                                        padding: const EdgeInsets.only(bottom: 10.0),
                                        child: Column(
                                          children: <Widget>[
                                            Padding(
                                              padding: const EdgeInsets.only(left: 15.0, right: 15.0, bottom: 6.0),
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: <Widget>[
                                                  Container(
                                                    width: MediaQuery.of(context).size.width * 0.3,
                                                    child: Row(
                                                      children: <Widget>[
                                                        Flexible(
                                                          child: Text(
                                                            'Dibuat',
                                                            style: TextStyle(
                                                                fontSize: 14.0,
                                                                color: Colors.black54,
                                                                fontWeight: FontWeight.w700),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  Container(
                                                    width: MediaQuery.of(context).size.width * 0.3,
                                                    child: Row(
                                                      children: <Widget>[
                                                        Flexible(
                                                          child: Text(
                                                            'Diperiksa',
                                                            style: TextStyle(
                                                                fontSize: 14.0,
                                                                color: Colors.black54,
                                                                fontWeight: FontWeight.w700),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  Container(
                                                    width: MediaQuery.of(context).size.width * 0.3,
                                                    child: Row(
                                                      children: <Widget>[
                                                        Flexible(
                                                          child: Text(
                                                            dateApprove[index] == null
                                                              ? ' '
                                                              : 'Diperiksa',
                                                            style: TextStyle(
                                                                fontSize: 14.0,
                                                                color: Colors.black54,
                                                                fontWeight: FontWeight.w700),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(left: 15.0, right: 15.0, bottom: 0.0),
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: <Widget>[
                                                  Container(
                                                    width: MediaQuery.of(context).size.width * 0.3,
                                                    child: Row(
                                                      children: <Widget>[
                                                        Flexible(
                                                          child: Text(
                                                            userCreated[index],
                                                            style: TextStyle(
                                                                fontSize: 14.0,
                                                                color: Colors.black54,
                                                                fontWeight: FontWeight.w500),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  Container(
                                                    width: MediaQuery.of(context).size.width * 0.3,
                                                    child: Row(
                                                      mainAxisAlignment: MainAxisAlignment.start,
                                                      children: <Widget>[
                                                        Flexible(
                                                          child: Text(
                                                            userVerify[index],
                                                            style: TextStyle(
                                                                fontSize: 14.0,
                                                                color: Colors.black54,
                                                                fontWeight: FontWeight.w500),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  Container(
                                                    width: MediaQuery.of(context).size.width * 0.3,
                                                    child: Row(
                                                      mainAxisAlignment: MainAxisAlignment.start,
                                                      children: <Widget>[
                                                        Flexible(
                                                          child: Text(
                                                            dateApprove[index] == null
                                                              ? ' '
                                                              : userApprove[index],
                                                            style: TextStyle(
                                                                fontSize: 14.0,
                                                                color: Colors.black54,
                                                                fontWeight: FontWeight.w500),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(left: 15.0, right: 15.0, bottom: 0.0),
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: <Widget>[
                                                  Container(
                                                    width: MediaQuery.of(context).size.width * 0.3,
                                                    child: Row(
                                                      children: <Widget>[
                                                        Flexible(
                                                          child: Text(
                                                            department[index],
                                                            style: TextStyle(
                                                                fontSize: 14.0,
                                                                color: Colors.black54),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  Container(
                                                    width: MediaQuery.of(context).size.width * 0.3,
                                                    child: Row(
                                                      mainAxisAlignment: MainAxisAlignment.start,
                                                      children: <Widget>[
                                                        Flexible(
                                                          child: Text(
                                                            departmentVerify[index],
                                                            style: TextStyle(
                                                                fontSize: 14.0,
                                                                color: Colors.black54),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  Container(
                                                    width: MediaQuery.of(context).size.width * 0.3,
                                                    child: Row(
                                                      mainAxisAlignment: MainAxisAlignment.start,
                                                      children: <Widget>[
                                                        Flexible(
                                                          child: Text(
                                                            dateApprove[index] == null
                                                              ? ' '
                                                              : departmentApprove[index],
                                                            style: TextStyle(
                                                                fontSize: 14.0,
                                                                color: Colors.black54),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(left: 15.0, right: 15.0, bottom: 0.0),
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: <Widget>[
                                                  Container(
                                                    width: MediaQuery.of(context).size.width * 0.3,
                                                    child: Row(
                                                      children: <Widget>[
                                                        Flexible(
                                                          child: Text(
                                                            dateCreated[index].toDate().toString().substring(8, 10) + '/' + dateCreated[index].toDate().toString().substring(5, 7) + '/' +dateCreated[index].toDate().toString().substring(0, 4),
                                                            style: TextStyle(
                                                                fontSize: 14.0,
                                                                color: Colors.black54),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  Container(
                                                    width: MediaQuery.of(context).size.width * 0.3,
                                                    child: Row(
                                                      mainAxisAlignment: MainAxisAlignment.start,
                                                      children: <Widget>[
                                                        Flexible(
                                                          child: Text(
                                                            dateVerify[index].toDate().toString().substring(8, 10) + '/' + dateVerify[index].toDate().toString().substring(5, 7) + '/' +dateVerify[index].toDate().toString().substring(0, 4),
                                                            style: TextStyle(
                                                                fontSize: 14.0,
                                                                color: Colors.black54),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  Container(
                                                    width: MediaQuery.of(context).size.width * 0.3,
                                                    child: Row(
                                                      mainAxisAlignment: MainAxisAlignment.start,
                                                      children: <Widget>[
                                                        Flexible(
                                                          child: Text(
                                                            dateApprove[index] == null
                                                              ? ' '
                                                              : dateApprove[index].toDate().toString().substring(8, 10) + '/' + dateApprove[index].toDate().toString().substring(5, 7) + '/' +dateApprove[index].toDate().toString().substring(0, 4),
                                                            style: TextStyle(
                                                                fontSize: 14.0,
                                                                color: Colors.black54),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(left: 15.0, right: 15.0, bottom: 0.0),
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.end,
                                                children: <Widget>[
                                                  ButtonTheme(
                                                    minWidth: 50.0,
                                                    height: 20.0,
                                                    child: OutlineButton(
                                                      child: Text(
                                                        'Revisi',
                                                        style: TextStyle(fontSize: 13.0, color: AbubaPallate.menuBluebird),
                                                      ),
                                                      borderSide: BorderSide(color: AbubaPallate.menuBluebird, width: 1.0),
                                                      highlightedBorderColor: AbubaPallate.menuBluebird,
                                                      onPressed: () {
                                                        Navigator.pushReplacement(context,
                                                          MyCustomRoute(
                                                            builder: (context) => new FormDetail(idUser: widget.idUser, namaUser: widget.namaUser, departmentUser: widget.departmentUser, index: snapshot.data.documents[index].documentID, pJabatan: typeDoc[index] == 'video' ? [] : snapshot.data.documents[index].data['p_jabatan'], pDocTerkait: typeDoc[index] == 'video' ? [] : snapshot.data.documents[index].data['p_docTerkait'], pDepartment: typeDoc[index] == 'video' ? [] : snapshot.data.documents[index].data['p_department'], pComment: typeDoc[index] == 'video' ? [] : snapshot.data.documents[index].data['p_Comment'], pCommentStatus: typeDoc[index] == 'video' ? [] : snapshot.data.documents[index].data['p_CommentStatus'], tujuanCommentCreated: snapshot.data.documents[index].data['tujuanCommentCreated'], ruangLingkupCommentCreated: snapshot.data.documents[index].data['rLingkupCommentCreated'], referensiCommentCreated: snapshot.data.documents[index].data['referensiCommentCreated'], istilahCommentCreated: snapshot.data.documents[index].data['istilahCommentCreated'], prosedurCommentTgl: snapshot.data.documents[index].data['p_CommentTgl'], risikoCommentCreated: snapshot.data.documents[index].data['risikoCommentCreated'], bantuistilah: snapshot.data.documents[index].data.containsKey('istilahComment') ? 'YES' : 'NO', bantureferensi: snapshot.data.documents[index].data.containsKey('referensiComment') ? 'YES' : 'NO', banturisiko: snapshot.data.documents[index].data.containsKey('risikoComment') ? 'YES' : 'NO', banturuanglingkup: snapshot.data.documents[index].data.containsKey('rLingkupComment') ? 'YES' : 'NO', bantutujuan: snapshot.data.documents[index].data.containsKey('tujuanComment') ? 'YES' : 'NO', type: typeDoc[index]),
                                                          )
                                                        );
                                                      }
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              } else {
                                return Container();
                              }
                            } else {
                              return Container();
                            }
                          }).toList()
                        );
                      },
                    )
                  );
            },
          )
        ],
      ),
    );
  }
}
