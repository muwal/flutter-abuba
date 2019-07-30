import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_abuba/constant.dart';
import 'package:flutter_abuba/isoft/hrd_page/maintenance/maintenance_test.dart';
import 'package:flutter_abuba/isoft/IT_page/maintenance/maintenance_test.dart';
import 'package:flutter_abuba/isoft/operation_page/workinginstruction/beranda_working.dart';
import 'package:flutter_abuba/isoft/operation_page/workinginstruction/list/form_listDetail.dart';
import 'package:flutter_abuba/isoft/operation_page/workinginstruction/review/detail_review.dart';
// import 'detail_listDetail.dart';

import 'package:video_player/video_player.dart';
import 'package:chewie/chewie.dart';

class FormListWorking extends StatefulWidget {
  final int idUser;
  final String namaUser;
  final String departmentUser;
  final String type;
  FormListWorking({this.idUser, this.namaUser, this.departmentUser, this.type});

  @override
  _FormListWorkingState createState() => _FormListWorkingState();
}

class _FormListWorkingState extends State<FormListWorking> with TickerProviderStateMixin {
  AnimationController animationController;

  var _searchEdit = new TextEditingController();

  bool _isSearch = true;
  String _searchText = "";

  List<String> userCreatedList = [];
  List<String> departmentList = [];
  List<Timestamp> dateCreatedList = [];

  List<String> userVerifyList = [];
  List<String> departmentVerifyList = [];
  List<Timestamp> dateVerifyList = [];

  List<String> userApproveList = [];
  List<String> departmentApproveList = [];
  List<Timestamp> dateApproveList = [];

  List<dynamic> statusList= [];
  List<dynamic> judulList= [];
  List<dynamic> noDocList= [];
  List<dynamic> lastRevisiList= [];
  List<dynamic> pJabatanList= [];
  List<dynamic> pDepartmentList= [];
  List<dynamic> pDocTerkaitList= [];
  List<dynamic> pCommentList= [];
  List<dynamic> pCommentStatusList= [];
  List<dynamic> tujuanCommentCreatedList= [];
  List<dynamic> ruangLingkupCommentCreatedList= [];
  List<dynamic> referensiCommentCreatedList= [];
  List<dynamic> istilahCommentCreatedList= [];
  List<dynamic> risikoCommentCreatedList= [];
  List<dynamic> prosedurCommentTglList= [];
  List<String> bantutujuanList= [];
  List<String> banturuanglingkupList= [];
  List<String> bantureferensiList= [];
  List<String> bantuistilahList= [];
  List<String> banturisikoList= [];
  List<dynamic> docIDList = [];

  List<String> userCreated = [];
  List<String> department = [];
  List<Timestamp> dateCreated = [];

  List<String> userVerify = [];
  List<String> departmentVerify = [];
  List<Timestamp> dateVerify = [];

  List<String> userApprove = [];
  List<String> departmentApprove = [];
  List<Timestamp> dateApprove = [];

  List<dynamic> status= [];
  List<dynamic> judul= [];
  List<dynamic> noDoc= [];
  List<dynamic> lastRevisi= [];
  List<dynamic> pJabatan= [];
  List<dynamic> pDepartment= [];
  List<dynamic> pDocTerkait= [];
  List<dynamic> pComment= [];
  List<dynamic> pCommentStatus= [];
  List<dynamic> tujuanCommentCreated= [];
  List<dynamic> ruangLingkupCommentCreated= [];
  List<dynamic> referensiCommentCreated= [];
  List<dynamic> istilahCommentCreated= [];
  List<dynamic> risikoCommentCreated= [];
  List<dynamic> prosedurCommentTgl= [];
  List<String> bantutujuan= [];
  List<String> banturuanglingkup= [];
  List<String> bantureferensi= [];
  List<String> bantuistilah= [];
  List<String> banturisiko= [];

  var docID = [];

  VideoPlayerController _videoPlayerController1;
  ChewieController _chewieController;
  
  @override
  void initState() {
    super.initState();

    _videoPlayerController1 = VideoPlayerController.network('https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4');
    _chewieController = ChewieController(
      videoPlayerController: _videoPlayerController1,
      aspectRatio: 3 / 2,
      autoPlay: false,
      looping: false,
      allowFullScreen: false,
      allowMuting: true,
    );

    CollectionReference reference = Firestore.instance.collection('docInstruksi');
    reference.where('status', isEqualTo: 'PUBLISH').snapshots().listen((querySnapshot) {
      querySnapshot.documentChanges.forEach((change) {
        setState(() {
          docID.add(change.document.documentID);
          status.add(change.document.data['status']);
          judul.add(change.document.data['judul']);
          noDoc.add(change.document.data['noDoc']);
          lastRevisi.add(change.document.data['lastRevisi']);
          dateCreated.add(change.document.data['createdDate']);
          dateVerify.add(change.document.data['verifyDate']);
          dateApprove.add(change.document.data['approvedDate']);

          pJabatan.add(change.document.data['p_jabatan']);
          pDocTerkait.add(change.document.data['p_docTerkait']);
          pDepartment.add(change.document.data['p_department']);
          pComment.add(change.document.data['p_Comment']);
          pCommentStatus.add(change.document.data['p_CommentStatus']);
          tujuanCommentCreated.add(change.document.data['tujuanCommentCreated']);
          ruangLingkupCommentCreated.add(change.document.data['rLingkupCommentCreated']);
          referensiCommentCreated.add(change.document.data['referensiCommentCreated']);
          istilahCommentCreated.add(change.document.data['istilahCommentCreated']);
          prosedurCommentTgl.add(change.document.data['p_CommentTgl']);
          risikoCommentCreated.add(change.document.data['risikoCommentCreated']);
          bantuistilah.add(change.document.data.containsKey('istilahComment') ? 'YES' : 'NO');
          bantureferensi.add(change.document.data.containsKey('referensiComment') ? 'YES' : 'NO');
          banturisiko.add(change.document.data.containsKey('risikoComment') ? 'YES' : 'NO');
          banturuanglingkup.add(change.document.data.containsKey('rLingkupComment') ? 'YES' : 'NO');
          bantutujuan.add(change.document.data.containsKey('tujuanComment') ? 'YES' : 'NO');

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
    _videoPlayerController1.dispose();
    _chewieController.dispose();
    super.dispose();
  }

  _FormListWorkingState() {
    _searchEdit.addListener(() {
      if (_searchEdit.text.isEmpty) {
        setState(() {
          _isSearch = true;
          _searchText = "";
        });
      } else {
        setState(() {
          _isSearch = false;
          _searchText = _searchEdit.text;
        });
      }
    });
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
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              if (widget.type == 'maintenanceIT') {
                Navigator.pushReplacement(context,
                  MaterialPageRoute(
                    builder: (_) => FormMaintenanceTest(departmentUser: widget.departmentUser, namaUser: widget.namaUser, idUser: widget.idUser)
                  )
                );
              } else if (widget.type == 'maintenanceHRD') {
                Navigator.pushReplacement(context,
                  MaterialPageRoute(
                    builder: (_) => FormMaintenanceTestHRD(departmentUser: widget.departmentUser, namaUser: widget.namaUser, idUser: widget.idUser)
                  )
                );
              } else if (widget.type == 'WI') {
                Navigator.pushReplacement(context,
                  MaterialPageRoute(
                    builder: (_) => BerandaWorking(departmentUser: widget.departmentUser, namaUser: widget.namaUser, idUser: widget.idUser)
                  )
                );
              }
            },
          ),
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
            child: AnimatedBuilder(animation: animationController, builder: (_, Widget child){
              return animationController.isAnimating
                  ? Container (
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              ) :
              Column(
                children: <Widget>[
                  Container(
                    margin: const EdgeInsets.only(bottom: 10.0, right: 15.0, left: 15.0, top: 10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Flexible(
                          child: Text(
                            'Document Control',
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
                            'List',
                            style: TextStyle(
                                color: AbubaPallate.greenabuba, fontSize: 12.0),
                          ),
                        ),
                      ],
                    ),
                  ),
                  _searchBox(),
                    _isSearch ? _listView(width) : _searchListView()
                ],
              );
            })
        ),
      ),
    );
  }

  Widget _searchBox() {
    return new Container(
      margin: const EdgeInsets.only(bottom: 10.0, right: 15.0, left: 15.0),
      decoration: BoxDecoration(border: Border.all(width: 1.0, color: Colors.white), borderRadius: BorderRadius.circular(25.0), color: Colors.white  ),
      child: new TextField(
        controller: _searchEdit,
        decoration: InputDecoration(
            hintText: "Search",
            hintStyle: new TextStyle(color: Colors.black54),
            prefixIcon: Icon(Icons.search),
            prefixStyle: TextStyle(color: Colors.green),
            border: InputBorder.none
        ),
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget _listView(width) {
    return new Flexible(
      child: ListView.builder(
          itemCount: dateCreated.length,
          itemBuilder: (BuildContext context, int index) {
            Timestamp date = dateCreated[index];
            DateTime dateBantu = DateTime.tryParse(date.toDate().toString());

            if (status[index] == 'PUBLISH') {
              // if (index == 0) {
                return Container(
                  width: width,
                  color: Colors.white,
                  child: Column(
                    children: <Widget>[
                      ExpansionTile(
                        title: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Flexible(
                                  child: Text(
                                    judul[index],
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
                                    noDoc[index],
                                    style: TextStyle(fontSize: 14.0, color: Colors.black38),
                                  ),
                                ),
                                SizedBox(
                                  width: 15.0,
                                ),
                                Flexible(
                                  child: Text(
                                    'Rev ${lastRevisi[index].toString().padLeft(2, '0')}',
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
                                                'Disetujui',
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
                                                userApprove[index],
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
                                                departmentApprove[index],
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
                                                dateApprove[index].toDate().toString().substring(8, 10) + '/' + dateApprove[index].toDate().toString().substring(5, 7) + '/' +dateApprove[index].toDate().toString().substring(0, 4),
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
                                              'View',
                                              style: TextStyle(fontSize: 13.0, color: AbubaPallate.menuBluebird),
                                            ),
                                            borderSide: BorderSide(color: AbubaPallate.menuBluebird, width: 1.0),
                                            highlightedBorderColor: AbubaPallate.menuBluebird,
                                            onPressed: () {
                                              Navigator.push(context,
                                                  MyCustomRoute(
                                                      builder: (context) => new FormDetailListWorking(idUser: widget.idUser, namaUser: widget.namaUser, departmentUser: widget.departmentUser, index: docID[index], pJabatan: pJabatan[index], pDocTerkait: pDocTerkait[index], pDepartment: pDepartment[index], pComment: pComment[index], pCommentStatus: pCommentStatus[index], tujuanCommentCreated: tujuanCommentCreated[index], ruangLingkupCommentCreated: ruangLingkupCommentCreated[index], referensiCommentCreated: referensiCommentCreated[index], istilahCommentCreated: istilahCommentCreated[index], prosedurCommentTgl: prosedurCommentTgl[index], risikoCommentCreated: risikoCommentCreated[index], bantureferensi: bantureferensi[index], banturisiko: banturisiko[index], banturuanglingkup: banturuanglingkup[index], bantutujuan: bantutujuan[index])
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
                    ],
                  ),
                );
              // }
            } else {
              return Container();
            }
          }
      ),
    );
  }

  Widget _searchListView() {
    final double width = MediaQuery.of(context).size.width;

    userCreatedList = List<String> ();
    departmentList = List<String> ();
    dateCreatedList = List<Timestamp> ();

    userVerifyList = List<String> ();
    departmentVerifyList = List<String> ();
    dateVerifyList = List<Timestamp> ();

    userApproveList = List<String> ();
    departmentApproveList = List<String> ();
    dateApproveList = List<Timestamp> ();

    statusList= List<dynamic> ();
    judulList= List<dynamic> ();
    noDocList= List<dynamic> ();
    lastRevisiList= List<dynamic> ();
    pJabatanList= List<dynamic> ();
    pDepartmentList= List<dynamic> ();
    pDocTerkaitList= List<dynamic> ();
    pCommentList= List<dynamic> ();
    pCommentStatusList= List<dynamic> ();
    tujuanCommentCreatedList= List<dynamic> ();
    ruangLingkupCommentCreatedList= List<dynamic> ();
    referensiCommentCreatedList= List<dynamic> ();
    istilahCommentCreatedList= List<dynamic> ();
    risikoCommentCreatedList= List<dynamic> ();
    prosedurCommentTglList= List<dynamic> ();
    bantutujuanList= List<String> ();
    banturuanglingkupList= List<String> ();
    bantureferensiList= List<String> ();
    bantuistilahList= List<String> ();
    banturisikoList= List<String> ();
    docIDList = List<dynamic> ();

    for (int i = 0; i < dateCreated.length; i++) {
      var userCreatedDua = userCreated[i];
      var departmentDua = department[i];
      var dateCreatedDua = dateCreated [i];

      var userVerifyDua = userVerify [i];
      var departmentVerifyDua = departmentVerify [i];
      var dateVerifyDua = dateVerify [i];

      var userApproveDua = userApprove [i];
      var departmentApproveDua = departmentApprove [i];
      var dateApproveDua = dateApprove [i];

      var statusDua= status[i];
      var judulDua= judul[i];
      var noDocDua= noDoc[i];
      var lastRevisiDua= lastRevisi[i];
      var pJabatanDua= pJabatan[i];
      var pDepartmentDua= pDepartment[i];
      var pDocTerkaitDua= pDocTerkait[i];
      var pCommentDua= pComment[i];
      var pCommentStatusDua= pCommentStatus[i];
      var tujuanCommentCreatedDua= tujuanCommentCreated[i];
      var ruangLingkupCommentCreatedDua= ruangLingkupCommentCreated[i];
      var referensiCommentCreatedDua= referensiCommentCreated[i];
      var istilahCommentCreatedDua= istilahCommentCreated[i];
      var risikoCommentCreatedDua= risikoCommentCreated[i];
      var prosedurCommentTglDua= prosedurCommentTgl[i];
      var bantutujuanDua= bantutujuan[i];
      var banturuanglingkupDua= banturuanglingkup[i];
      var bantureferensiDua= bantureferensi[i];
      var bantuistilahDua= bantuistilah[i];
      var banturisikoDua= banturisiko[i];

      var docIDDua = docID[i];

      if (judulDua.toLowerCase().contains(_searchText.toLowerCase())) {
        userCreatedList.add(userCreatedDua);
        departmentList.add(departmentDua);
        dateCreatedList.add(dateCreatedDua);

        userVerifyList.add(userVerifyDua);
        departmentVerifyList.add(departmentVerifyDua);
        dateVerifyList.add(dateVerifyDua);

        userApproveList.add(userApproveDua);
        departmentApproveList.add(departmentApproveDua);
        dateApproveList.add(dateApproveDua);

        statusList.add(statusDua);
        judulList.add(judulDua);
        noDocList.add(noDocDua);
        lastRevisiList.add(lastRevisiDua);
        pJabatanList.add(pJabatanDua);
        pDepartmentList.add(pDepartmentDua);
        pDocTerkaitList.add(pDocTerkaitDua);
        pCommentList.add(pCommentDua);
        pCommentStatusList.add(pCommentStatusDua);
        tujuanCommentCreatedList.add(tujuanCommentCreatedDua);
        ruangLingkupCommentCreatedList.add(ruangLingkupCommentCreatedDua);
        referensiCommentCreatedList.add(referensiCommentCreatedDua);
        istilahCommentCreatedList.add(istilahCommentCreatedDua);
        risikoCommentCreatedList.add(risikoCommentCreatedDua);
        prosedurCommentTglList.add(prosedurCommentTglDua);
        bantutujuanList.add(bantutujuanDua);
        banturuanglingkupList.add(banturuanglingkupDua);
        bantureferensiList.add(bantureferensiDua);
        bantuistilahList.add(bantuistilahDua);
        banturisikoList.add(banturisikoDua);
        docIDList.add(docIDDua);
      } else if (noDocDua.toLowerCase().contains(_searchText.toLowerCase())) {
        userCreatedList.add(userCreatedDua);
        departmentList.add(departmentDua);
        dateCreatedList.add(dateCreatedDua);

        userVerifyList.add(userVerifyDua);
        departmentVerifyList.add(departmentVerifyDua);
        dateVerifyList.add(dateVerifyDua);

        userApproveList.add(userApproveDua);
        departmentApproveList.add(departmentApproveDua);
        dateApproveList.add(dateApproveDua);

        statusList.add(statusDua);
        judulList.add(judulDua);
        noDocList.add(noDocDua);
        lastRevisiList.add(lastRevisiDua);
        pJabatanList.add(pJabatanDua);
        pDepartmentList.add(pDepartmentDua);
        pDocTerkaitList.add(pDocTerkaitDua);
        pCommentList.add(pCommentDua);
        pCommentStatusList.add(pCommentStatusDua);
        tujuanCommentCreatedList.add(tujuanCommentCreatedDua);
        ruangLingkupCommentCreatedList.add(ruangLingkupCommentCreatedDua);
        referensiCommentCreatedList.add(referensiCommentCreatedDua);
        istilahCommentCreatedList.add(istilahCommentCreatedDua);
        risikoCommentCreatedList.add(risikoCommentCreatedDua);
        prosedurCommentTglList.add(prosedurCommentTglDua);
        bantutujuanList.add(bantutujuanDua);
        banturuanglingkupList.add(banturuanglingkupDua);
        bantureferensiList.add(bantureferensiDua);
        bantuistilahList.add(bantuistilahDua);
        banturisikoList.add(banturisikoDua);
        docIDList.add(docIDDua);
      }
    }
    return _searchAddList(width);
  }

  Widget _searchAddList(width) {
    return new Flexible(
      child: ListView.builder(
          itemCount: dateCreatedList.length,
          itemBuilder: (BuildContext context, int index) {
            Timestamp date = dateCreatedList[index];
            DateTime dateBantu = date.toDate();

            // if (statusList[index] == 'PUBLISH') {
              return Container(
                width: width,
                color: Colors.white,
                child: Column(
                  children: <Widget>[
                    ExpansionTile(
                      title: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Flexible(
                                child: Text(
                                  judulList[index],
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
                                  noDocList[index],
                                  style: TextStyle(fontSize: 14.0, color: Colors.black38),
                                ),
                              ),
                              SizedBox(
                                width: 15.0,
                              ),
                              Flexible(
                                child: Text(
                                  'Rev ${lastRevisiList[index].toString().padLeft(2, '0')}',
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
                                              'Disetujui',
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
                                              userCreatedList[index],
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
                                              userVerifyList[index],
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
                                              userApproveList[index],
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
                                              departmentList[index],
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
                                              departmentVerifyList[index],
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
                                              departmentApproveList[index],
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
                                              dateCreatedList[index].toDate().toString().substring(8, 10) + '/' + dateCreatedList[index].toDate().toString().substring(5, 7) + '/' +dateCreatedList[index].toDate().toString().substring(0, 4),
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
                                              dateVerifyList[index].toDate().toString().substring(8, 10) + '/' + dateVerifyList[index].toDate().toString().substring(5, 7) + '/' +dateVerifyList[index].toDate().toString().substring(0, 4),
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
                                              dateApproveList[index].toDate().toString().substring(8, 10) + '/' + dateApproveList[index].toDate().toString().substring(5, 7) + '/' +dateApproveList[index].toDate().toString().substring(0, 4),
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
                                            'View',
                                            style: TextStyle(fontSize: 13.0, color: AbubaPallate.menuBluebird),
                                          ),
                                          borderSide: BorderSide(color: AbubaPallate.menuBluebird, width: 1.0),
                                          highlightedBorderColor: AbubaPallate.menuBluebird,
                                          onPressed: () {
                                            Navigator.push(context,
                                              MyCustomRoute(
                                                builder: (context) => new FormDetailListWorking(idUser: widget.idUser, namaUser: widget.namaUser, departmentUser: widget.departmentUser, index: docIDList[index], pJabatan: pJabatanList[index], pDocTerkait: pDocTerkaitList[index], pDepartment: pDepartmentList[index], pComment: pCommentList[index], pCommentStatus: pCommentStatusList[index], tujuanCommentCreated: tujuanCommentCreatedList[index], ruangLingkupCommentCreated: ruangLingkupCommentCreatedList[index], referensiCommentCreated: referensiCommentCreatedList[index], istilahCommentCreated: istilahCommentCreatedList[index], prosedurCommentTgl: prosedurCommentTglList[index], risikoCommentCreated: risikoCommentCreatedList[index], bantureferensi: bantureferensiList[index], banturisiko: banturisikoList[index], banturuanglingkup: banturuanglingkupList[index], bantutujuan: bantutujuanList[index])
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
                  ],
                ),
              );
            // } else {
            //   return Container();
            // }
          }
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
                    'Document Control',
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
                    'List',
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
                      stream: Firestore.instance.collection('docInstruksi').snapshots(),
                      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                        if (!snapshot.hasData)
                          return Container(
                            child: Center(
                              child: CircularProgressIndicator(),
                            )
                          );
                        
                        return Column(
                          children: List.generate(snapshot.data.documents.length, (index) {
                            if (snapshot.data.documents[index].data['status'] == 'PUBLISH') {
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
                                                        'Disetujui',
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
                                                        userApprove[index],
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
                                                        departmentApprove[index],
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
                                                          dateApprove[index].toDate().toString().substring(8, 10) + '/' + dateApprove[index].toDate().toString().substring(5, 7) + '/' +dateApprove[index].toDate().toString().substring(0, 4),
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
                                                      'View',
                                                      style: TextStyle(fontSize: 13.0, color: AbubaPallate.menuBluebird),
                                                    ),
                                                    borderSide: BorderSide(color: AbubaPallate.menuBluebird, width: 1.0),
                                                    highlightedBorderColor: AbubaPallate.menuBluebird,
                                                    onPressed: () {
                                                      Navigator.push(context,
                                                        MyCustomRoute(
                                                          builder: (context) => new FormDetailListWorking(idUser: widget.idUser, namaUser: widget.namaUser, departmentUser: widget.departmentUser, index: snapshot.data.documents[index].documentID, pJabatan: snapshot.data.documents[index].data['p_jabatan'], pDocTerkait: snapshot.data.documents[index].data['p_docTerkait'], pDepartment: snapshot.data.documents[index].data['p_department'], pComment: snapshot.data.documents[index].data['p_Comment'], pCommentStatus: snapshot.data.documents[index].data['p_CommentStatus'], tujuanCommentCreated: snapshot.data.documents[index].data['tujuanCommentCreated'], ruangLingkupCommentCreated: snapshot.data.documents[index].data['rLingkupCommentCreated'], referensiCommentCreated: snapshot.data.documents[index].data['referensiCommentCreated'], istilahCommentCreated: snapshot.data.documents[index].data['istilahCommentCreated'], prosedurCommentTgl: snapshot.data.documents[index].data['p_CommentTgl'], risikoCommentCreated: snapshot.data.documents[index].data['risikoCommentCreated'], bantureferensi: snapshot.data.documents[index].data.containsKey('referensiComment') ? 'YES' : 'NO', banturisiko: snapshot.data.documents[index].data.containsKey('risikoComment') ? 'YES' : 'NO', banturuanglingkup: snapshot.data.documents[index].data.containsKey('rLingkupComment') ? 'YES' : 'NO', bantutujuan: snapshot.data.documents[index].data.containsKey('tujuanComment') ? 'YES' : 'NO')
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
