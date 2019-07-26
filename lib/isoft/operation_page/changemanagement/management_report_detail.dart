import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_abuba/constant.dart';

class ManagementReportDetail extends StatefulWidget {
  final int idUser;
  final String namaUser;
  final String departmentUser;
  var index;
  final List<dynamic> personReview;
  final List<dynamic> personReviewDate;
  ManagementReportDetail({this.idUser, this.namaUser, this.departmentUser, this.index, this.personReview, this.personReviewDate});

  @override
  _ManagementReportDetailState createState() => _ManagementReportDetailState();
}

class _ManagementReportDetailState extends State<ManagementReportDetail> with TickerProviderStateMixin {
  AnimationController animationController;
  int no;
  String nama;
  String department;
  Timestamp tglUsul;
  
  Timestamp tglImplementasi;
  String prioritas;
  String category;
  String alasan;
  String deskripsi;

  List<String> departmentReview = [];
  List<String> namaReview = [];
  List<dynamic> statusReview = [];
  List<dynamic> noteReview = [];

  String approvedBy;
  String approvedDepartment;
  Timestamp approvedDate;
  String finalStatus;
  String approvedNote;

  @override
  void initState() {
    super.initState();
    Firestore.instance.collection('changeMgmt').document(widget.index).snapshots().listen((data) {
      setState(() {
        no = data.data['changeNo'];
        tglUsul = data.data['dateCreated'];
        tglImplementasi = data.data['tglImplementasi'];
        prioritas = data.data['prioritas'];
        alasan = data.data['alasan'];
        deskripsi = data.data['deskripsi'];
        statusReview = data.data['personReviewStatus'];
        noteReview = data.data['personReviewNote'];
        approvedDate = data.data['approveDate'];
        finalStatus = data.data['finalStatus'];
        approvedNote = data.data['approveNote'];

        Firestore.instance.collection('user').where('id', isEqualTo: data.data['approveBy']).snapshots().listen((data7) {
          approvedBy = data7.documents[0].data['nama'];

          Firestore.instance.collection('department').where('id', isEqualTo: data7.documents[0].data['departmentID']).snapshots().listen((data8) {
            approvedDepartment = data8.documents[0].data['department'];
          });
        });

        Firestore.instance.collection('user').where('id', isEqualTo: data.data['userCreated']).snapshots().listen((data2) {
          nama = data2.documents[0].data['nama'];

          Firestore.instance.collection('department').where('id', isEqualTo: data2.documents[0].data['departmentID']).snapshots().listen((data3) {
            department = data3.documents[0].data['department'];
          });
        });

        Firestore.instance.collection('changeMgmt_Category').where('id', isEqualTo: data.data['category']).snapshots().listen((data4) {
          category = data4.documents[0].data['category'];
        });
      });
    });

    for (int i = 0; i < widget.personReview.length; i++) {
      Firestore.instance.collection('user').where('id', isEqualTo: widget.personReview[i]).snapshots().listen((data5) {
        setState(() {
          namaReview.add(data5.documents[0].data['nama']);

          Firestore.instance.collection('department').where('id', isEqualTo: data5.documents[0].data['departmentID']).snapshots().listen((data6) {
            departmentReview.add(data6.documents[0].data['department']);
          });
        });
      });
    }

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
          child: _bodyForm(),
        ),
      ),
    );
  }

  Widget _bodyForm() {
    return Scrollbar(
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
                    'Report',
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
                : Column(
                  children: <Widget>[
                    Container(
                      color: Colors.white,
                      width: MediaQuery.of(context).size.width,
                      child: Column(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.fromLTRB(12.0, 12.0, 12.0, 6.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                Flexible(
                                  child: Text(
                                    'Informasi Umum',
                                    style: TextStyle(
                                        fontSize: 15.0,
                                        fontWeight: FontWeight.w600,
                                        color: AbubaPallate.green),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(12.0, 6.0, 12.0, 6.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Flexible(
                                  child: Text(
                                    'Change #',
                                    style: TextStyle(fontWeight: FontWeight.w400),
                                  ),
                                ),
                                Flexible(
                                  child: Text(
                                    no.toString().padLeft(4, '0'),
                                    style: TextStyle(color: Colors.black54, fontSize: 12.0),
                                  ),
                                )
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(12.0, 6.0, 12.0, 6.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Flexible(
                                  child: Text(
                                    'Nama Pengusul',
                                    style: TextStyle(fontWeight: FontWeight.w400),
                                  ),
                                ),
                                Flexible(
                                  child: Text(
                                    '$nama - $department',
                                    style: TextStyle(color: Colors.black54, fontSize: 12.0),
                                  ),
                                )
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(12.0, 6.0, 12.0, 6.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Flexible(
                                  child: Text(
                                    'Tanggal Usulan',
                                    style: TextStyle(fontWeight: FontWeight.w400),
                                  ),
                                ),
                                Flexible(
                                  child: Text(
                                    tglUsul.toDate().toString().substring(8, 10) + '/' + tglUsul.toDate().toString().substring(5, 7) + '/' +tglUsul.toDate().toString().substring(0, 4),
                                    style: TextStyle(color: Colors.black54, fontSize: 12.0),
                                    textAlign: TextAlign.right,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(top: 5.0),
                      color: Colors.white,
                      child: Divider(
                        height: 3.0,
                      ),
                    ),
                    Container(
                      color: Colors.white,
                      width: MediaQuery.of(context).size.width,
                      child: Column(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.fromLTRB(12.0, 12.0, 12.0, 6.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                Flexible(
                                  child: Text(
                                    'Informasi Perubahan',
                                    style: TextStyle(
                                        fontSize: 15.0,
                                        fontWeight: FontWeight.w600,
                                        color: AbubaPallate.green),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(12.0, 6.0, 12.0, 6.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Flexible(
                                  child: Text(
                                    'Tanggal Implementasi',
                                    style: TextStyle(fontWeight: FontWeight.w400),
                                  ),
                                ),
                                Flexible(
                                  child: Text(
                                    tglImplementasi.toDate().toString().substring(8, 10) + '/' + tglImplementasi.toDate().toString().substring(5, 7) + '/' +tglImplementasi.toDate().toString().substring(0, 4),
                                    style: TextStyle(color: AbubaPallate.menuBluebird, fontSize: 12.0),
                                  ),
                                )
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(12.0, 6.0, 12.0, 6.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Flexible(
                                  child: Text(
                                    'Prioritas',
                                    style: TextStyle(fontWeight: FontWeight.w400),
                                  ),
                                ),
                                Flexible(
                                  child: Text(
                                    prioritas,
                                    style: TextStyle(color: Colors.black54, fontSize: 12.0),
                                  ),
                                )
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(12.0, 6.0, 12.0, 6.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Flexible(
                                  child: Text(
                                    'Kategori',
                                    style: TextStyle(fontWeight: FontWeight.w400),
                                  ),
                                ),
                                Flexible(
                                  child: Text(
                                    category,
                                    style: TextStyle(color: Colors.black54, fontSize: 12.0),
                                  ),
                                )
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(12.0, 6.0, 12.0, 6.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Flexible(
                                  child: Text(
                                    'Alasan Perubahan',
                                    style: TextStyle(fontWeight: FontWeight.w400),
                                  ),
                                ),
                                Flexible(
                                  child: Text(
                                    alasan,
                                    style: TextStyle(color: Colors.black54, fontSize: 12.0),
                                    textAlign: TextAlign.right,
                                  ),
                                )
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(12.0, 6.0, 12.0, 6.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Flexible(
                                  child: Text(
                                    'Deskripsi Perubahan',
                                    style: TextStyle(fontWeight: FontWeight.w400),
                                  ),
                                ),
                                Flexible(
                                  child: Text(
                                    deskripsi,
                                    style: TextStyle(color: Colors.black54, fontSize: 12.0),
                                    textAlign: TextAlign.right,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(top: 5.0),
                      color: Colors.white,
                      child: Divider(
                        height: 3.0,
                      ),
                    ),
                    Container(
                      color: Colors.white,
                      width: MediaQuery.of(context).size.width,
                      child: Column(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.fromLTRB(12.0, 12.0, 12.0, 6.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                Flexible(
                                  child: Text(
                                    'Review',
                                    style: TextStyle(
                                        fontSize: 15.0,
                                        fontWeight: FontWeight.w600,
                                        color: AbubaPallate.green),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            color: Colors.white,
                            child: Column(
                              children: List.generate(namaReview.length, (index) {
                                return Column(
                                  children: <Widget>[
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(12.0, 6.0, 12.0, 6.0),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Flexible(
                                            child: Text(
                                              departmentReview[index],
                                              style: TextStyle(fontWeight: FontWeight.w400),
                                            ),
                                          ),
                                          Flexible(
                                            child: Text(
                                              statusReview[index].toString() == 'OPEN' ? '-' : statusReview[index].toString(),
                                              // 'status',
                                              style: TextStyle(color: statusReview[index].toString() == 'OPEN' || statusReview[index].toString() == 'NA' ? Colors.black45 : statusReview[index].toString() == 'REJECTED' ? Colors.redAccent : statusReview[index].toString() == 'APPROVED' ? AbubaPallate.greenabuba : Colors.black45, fontSize: 12.0),
                                              // style: TextStyle(color: Colors.black45, fontSize: 12.0),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(12.0, 0.0, 12.0, 6.0),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Flexible(
                                            child: Text(
                                              '${namaReview[index]} - ${widget.personReviewDate[index]}',
                                              style: TextStyle(fontWeight: FontWeight.w300, fontSize: 12.0),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    widget.personReviewDate[index] == ' ' || noteReview[index] == null || noteReview[index] == ''
                                      ? Container()
                                      : Padding(
                                          padding: const EdgeInsets.fromLTRB(12.0, 6.0, 12.0, 6.0),
                                          child: Stack(
                                            alignment: AlignmentDirectional.centerStart,
                                            children: <Widget>[
                                              Container(
                                                color: Colors.grey[300],
                                                height: 40.0,
                                              ),
                                              Container(
                                                padding: EdgeInsets.only(left: 10.0),
                                                child: Text(
                                                  noteReview[index] == null || noteReview[index] == '' ? '-' : noteReview[index],
                                                  style: TextStyle(
                                                      color: Colors.black54,
                                                      fontSize: 12.0),
                                                ),
                                                alignment: Alignment.centerLeft,
                                              )
                                            ],
                                          ),
                                        )
                                  ],
                                );
                              }).toList()
                            )
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(top: 5.0),
                      color: Colors.white,
                      child: Divider(
                        height: 3.0,
                      ),
                    ),
                    Container(
                      color: Colors.white,
                      width: MediaQuery.of(context).size.width,
                      child: Column(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.fromLTRB(12.0, 12.0, 12.0, 6.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Flexible(
                                  child: Text(
                                    approvedDepartment,
                                    style: TextStyle(
                                        fontSize: 15.0,
                                        fontWeight: FontWeight.w600,
                                        color: AbubaPallate.green),
                                  ),
                                ),
                                Flexible(
                                  child: Text(
                                    finalStatus,
                                    style: TextStyle(color: finalStatus == 'OPEN' ? Colors.black45 : finalStatus == 'APPROVED' ? AbubaPallate.greenabuba : finalStatus == 'REJECTED' ? Colors.redAccent : Colors.black45, fontSize: 12.0),
                                  ),
                                )
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(12.0, 0.0, 12.0, 6.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                Flexible(
                                  child: Text(
                                    '$approvedBy - ',
                                    style: TextStyle(fontWeight: FontWeight.w300, fontSize: 12.0),
                                  ),
                                ),
                                Flexible(
                                  child: Text(
                                    approvedDate == null ? ' ' : approvedDate.toDate().toString().substring(8, 10) + '/' + approvedDate.toDate().toString().substring(5, 7) + '/' +approvedDate.toDate().toString().substring(0, 4),
                                    style: TextStyle(fontWeight: FontWeight.w300, fontSize: 12.0),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          approvedNote == null || approvedNote == ''
                            ? Container()
                            : Padding(
                                padding: const EdgeInsets.fromLTRB(12.0, 6.0, 12.0, 12.0),
                                child: Stack(
                                  alignment: AlignmentDirectional.centerStart,
                                  children: <Widget>[
                                    Container(
                                      color: Colors.grey[300],
                                      height: 40.0,
                                    ),
                                    Container(
                                      padding: EdgeInsets.only(left: 10.0),
                                      child: Text(
                                        approvedNote,
                                        style: TextStyle(
                                          fontSize: 15.0,
                                          fontWeight: FontWeight.w600,
                                          color: AbubaPallate.green),
                                      ),
                                      alignment: Alignment.centerLeft,
                                    )
                                  ],
                                ),
                              ),
                        ],
                      ),
                    )
                  ],
                );
            },
          )
        ],
      ),
    );
  }
}
