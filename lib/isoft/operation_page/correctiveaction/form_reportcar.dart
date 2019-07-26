import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_abuba/constant.dart';

class ReportCar extends StatefulWidget {
  ReportCar({this.idUser, this.namaUser, this.departmentUser, this.index});

  final int idUser;
  final String namaUser;
  final String departmentUser;
  var index;

  @override
  _ReportCarState createState() => _ReportCarState();
}

class _ReportCarState extends State<ReportCar> with TickerProviderStateMixin {
  AnimationController animationController;

  int carNo;
  String department;
  String auditor;
  String auditee;
  String createdDate;
  String doneDate;
  String verifikasiDate;
  String problem;
  String problemDate;
  String remarksProblem;
  String rootCause;
  String remarksRootCause;
  String immediateAction;
  String immediateDate;
  String actionPlan;
  String dueDate;
  String status;
  String category;
  String howSevere;
  String departmentWhere;
  String divisiWhere;
  String areaWhere;
  bool showNote = false;
  bool showNote2 = false;
  String rekomendasiFS;

  var val2;
  var val3;
  bool showImageIA = false;
  List<dynamic> imageSplit = [];

  bool showImageDone = false;
  List<dynamic> imageDoneSplit = [];

  @override
  void initState() {
    super.initState();
    Firestore.instance.collection('correctiveAction').document(widget.index).snapshots().listen((data) {
      setState(() {
        carNo = data.data['carNo'];
        if (data.data.containsKey('imageDone')) {
          imageDoneSplit = data.data['imageDone'].toString().split('###');
        } else {
          imageDoneSplit = [];
        }
        if (data.data.containsKey('rekomendasiFS')) {
          rekomendasiFS = data.data['rekomendasiFS']; 
        } else {
          rekomendasiFS = '-';
        }
        problem = data.data['problem'];
        if (data.data['remarksProblem'] == "" || data.data['remarksProblem'] == null) {
          remarksProblem = '-';
        } else {
          remarksProblem = data.data['remarksProblem'];
        }
        departmentWhere = data.data['departmentWhere'];
        divisiWhere = data.data['divisiWhere'];
        areaWhere = data.data['areaWhere'];
        howSevere = data.data['howSevere'];
        status = data.data['status'];
        Timestamp dateCreated = data.data['dateCreated'];
        // Timestamp dateDone = data.data['dateDone'];
        Timestamp when = data.data['when'];
        if (data.data.containsKey('dateVerifikasi')) {
          Timestamp dateVerifikasi = data.data['dateVerifikasi'];
          verifikasiDate= dateVerifikasi.toDate().toString().substring(8, 10) + '/' + dateVerifikasi.toDate().toString().substring(5, 7) + '/' + dateVerifikasi.toDate().toString().substring(0, 4);
        } else {
          verifikasiDate = '-';
        }
        createdDate= dateCreated.toDate().toString().substring(8, 10) + '/' + dateCreated.toDate().toString().substring(5, 7) + '/' + dateCreated.toDate().toString().substring(0, 4);
        // doneDate= dateDone.toDate().toString().substring(8, 10) + '/' + dateDone.toDate().toString().substring(5, 7) + '/' + dateDone.toDate().toString().substring(0, 4);
        problemDate= when.toDate().toString().substring(8, 10) + '/' + when.toDate().toString().substring(5, 7) + '/' + when.toDate().toString().substring(0, 4);

        if (data.data['remarksRootCause'] == "") {
          remarksRootCause = '-';
        } else {
          remarksRootCause = data.data['remarksRootCause'];
        }
        if (data.data.containsKey('immediateAction')) {
          immediateAction = data.data['immediateAction'];
        } else {
          immediateAction = '-';
        }
        if (data.data.containsKey('immediateDate')) {
          Timestamp immediateDateBantu = data.data['immediateDate'];
          immediateDate = immediateDateBantu.toDate().toString().substring(8, 10) + '/' + immediateDateBantu.toDate().toString().substring(5, 7) + '/' + immediateDateBantu.toDate().toString().substring(0, 4);
        } immediateDate = '-';
        if (data.data.containsKey('recommendationAction')) {
          actionPlan = data.data['recommendationAction'];
        } else {
          actionPlan = '-';
        }
        if (data.data.containsKey('dueDate')) {
          Timestamp dueDateBantu = data.data['dueDate'];
          dueDate = dueDateBantu.toDate().toString().substring(8, 10) + '/' + dueDateBantu.toDate().toString().substring(5, 7) + '/' + dueDateBantu.toDate().toString().substring(0, 4);
        } else {
          dueDate = '-';
        }

        Firestore.instance.collection('correctiveAction_rootCause').where('id', isEqualTo: data.data['rootCause']).snapshots().listen((data4) {
          rootCause = data4.documents[0].data['root_cause'];
        });

        Firestore.instance.collection('correctiveAction_category').where('id', isEqualTo: data.data['category']).snapshots().listen((data2) {
          category = data2.documents[0].data['category'];
        });

        Firestore.instance.collection('user').where('id', isEqualTo: data.data['userDituju']).snapshots().listen((data3) {
          auditee = data3.documents[0].data['nama'];
          department = data3.documents[0].data['department'];
        });

        Firestore.instance.collection('user').where('id', isEqualTo: data.data['userCreated']).snapshots().listen((data5) {
          auditor = data5.documents[0].data['nama'];
        });
      });
    });

    CollectionReference reference2 = Firestore.instance.collection('audit_internal');
    reference2.snapshots().listen((data3) {
      data3.documentChanges.forEach((change2) {
        if (change2.document.data['FSCarNo'].contains(carNo)) {
          val2 = change2.document.data['FSCarNo'].indexWhere((test) => test == carNo);
          
          if (change2.document.data['FSArea'][val2] == 'Area Luar') {
            val3 = change2.document.data['iamgeAreaLuar'][change2.document.data['pertanyaanAreaLuar'].indexWhere((test) => test == change2.document.data['FSProblem'][val2])];
          } else if (change2.document.data['FSArea'][val2] == 'Dinning Area') {
            val3 = change2.document.data['imageDinningArea'][change2.document.data['pertanyaanDinningArea'].indexWhere((test) => test == change2.document.data['FSProblem'][val2])];
          } else if (change2.document.data['FSArea'][val2] == 'Service') {
            val3 = change2.document.data['imageService'][change2.document.data['pertanyaanService'].indexWhere((test) => test == change2.document.data['FSProblem'][val2])];
          } else if (change2.document.data['FSArea'][val2] == 'Cashier') {
            val3 = change2.document.data['imageCashier'][change2.document.data['pertanyaanCashier'].indexWhere((test) => test == change2.document.data['FSProblem'][val2])];
          } else if (change2.document.data['FSArea'][val2] == 'Administrasi Keuangan') {
            val3 = change2.document.data['imageCashierAccuracy'][change2.document.data['pertanyaanCashierAccuracy'].indexWhere((test) => test == change2.document.data['FSProblem'][val2])];
          } else if (change2.document.data['FSArea'][val2] == 'Back of The House (BOH)') {
            val3 = change2.document.data['imageBoh'][change2.document.data['pertanyaanBoh'].indexWhere((test) => test == change2.document.data['FSProblem'][val2])];
          } else if (change2.document.data['FSArea'][val2] == 'Warehouse') {
            val3 = change2.document.data['imageWarehouse'][change2.document.data['pertanyaanWarehouse'].indexWhere((test) => test == change2.document.data['FSProblem'][val2])];
          } else if (change2.document.data['FSArea'][val2] == 'Social Block') {
            val3 = change2.document.data['imageSocialBlock'][change2.document.data['pertanyaanSocialBlock'].indexWhere((test) => test == change2.document.data['FSProblem'][val2])];
          } else if (change2.document.data['FSArea'][val2] == 'Personal Hygiene') {
            val3 = change2.document.data['imagePersonal'][change2.document.data['pertanyaanPersonal'].indexWhere((test) => test == change2.document.data['FSProblem'][val2])];
          } else if (change2.document.data['FSArea'][val2] == 'Food Completely Cooked') {
            val3 = change2.document.data['imageFoodCooked'][change2.document.data['pertanyaanFoodCooked'].indexWhere((test) => test == change2.document.data['FSProblem'][val2])];
          }
        }
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
    final double size = MediaQuery.of(context).size.width;

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
          child: _bodyForm(size),
        ),
      ),
    );
  }

  Widget _bodyForm(double size) {
    return Scrollbar(
      child: ListView(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Text(
                  'Corrective Action',
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
                      child:CircularProgressIndicator()
                    ),
                  )
                : Column(
                    children: <Widget>[
                      Container(
                        color: Colors.grey[200],
                        height: 50.0,
                        child: Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Flexible(
                                child: Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: Text(
                                    'CAR# ${carNo.toString().padLeft(4, '0')}',
                                    style: TextStyle(
                                        fontSize: 16.0,
                                        color: Colors.black38,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(right: 12.0),
                                child: ButtonTheme(
                                  minWidth: 50.0,
                                  height: 30.0,
                                  splashColor: status == 'OPEN' ? Colors.redAccent : status == 'ONGOING' ? Colors.orangeAccent : status == 'DONE' ? AbubaPallate.menuBluebird : AbubaPallate.greenabuba,
                                  child: FlatButton(
                                    color: status == 'OPEN' ? Colors.redAccent : status == 'ONGOING' ? Colors.orangeAccent : status == 'DONE' ? AbubaPallate.menuBluebird : AbubaPallate.greenabuba,
                                    textColor: Colors.white,
                                    onPressed: () {},
                                    child: Text(
                                      status == 'CLOSED' ? 'VERIFIED' : status
                                    ),
                                  )
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 12.0, right: 12.0, bottom: 10.0, top: 20.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              width: MediaQuery.of(context).size.width * 0.5,
                              child: Row(
                                children: <Widget>[
                                  Flexible(
                                    child: Text(
                                      'Data Umum',
                                      style: TextStyle(
                                        fontSize: 15.0, color: Colors.black87, fontWeight: FontWeight.bold
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 20.0, right: 20.0, bottom: 5.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Container(
                              width: MediaQuery.of(context).size.width * 0.35,
                              child: Row(
                                children: <Widget>[
                                  Flexible(
                                    child: Text(
                                      'Kategori',
                                      style: TextStyle(
                                        fontSize: 14.0, color: Colors.black87, fontWeight: FontWeight.w500
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width * 0.35,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: <Widget>[
                                  Flexible(
                                    child: Text(
                                      category ?? '-',
                                      style: TextStyle(
                                        fontSize: 13.0,
                                        color: Colors.black38,
                                        fontWeight: FontWeight.w700
                                      ),
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
                              width: MediaQuery.of(context).size.width * 0.35,
                              child: Row(
                                children: <Widget>[
                                  Flexible(
                                    child: Text(
                                      'Department',
                                      style: TextStyle(
                                        fontSize: 14.0, color: Colors.black87, fontWeight: FontWeight.w500
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width * 0.35,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: <Widget>[
                                  Flexible(
                                    child: Text(
                                      department ?? '-',
                                      style: TextStyle(
                                        fontSize: 13.0,
                                        color: Colors.black38,
                                        fontWeight: FontWeight.w700
                                      ),
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
                              width: MediaQuery.of(context).size.width * 0.35,
                              child: Row(
                                children: <Widget>[
                                  Flexible(
                                    child: Text(
                                      'Tgl Dibuat',
                                      style: TextStyle(
                                        fontSize: 14.0, color: Colors.black87, fontWeight: FontWeight.w500
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width * 0.35,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: <Widget>[
                                  Flexible(
                                    child: Text(
                                      createdDate ?? '-',
                                      style: TextStyle(
                                        fontSize: 13.0,
                                        color: Colors.black38,
                                        fontWeight: FontWeight.w700
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 10.0, right: 10.0, bottom: 10.0, top: 5.0),
                        child: Divider(
                          height: 5.0,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 12.0, right: 12.0, bottom: 10.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              width: MediaQuery.of(context).size.width * 0.5,
                              child: Row(
                                children: <Widget>[
                                  Flexible(
                                    child: Text(
                                      'Data Audit',
                                      style: TextStyle(
                                        fontSize: 15.0, color: Colors.black87, fontWeight: FontWeight.bold
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 20.0, right: 20.0, bottom: 5.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Container(
                              width: MediaQuery.of(context).size.width * 0.35,
                              child: Row(
                                children: <Widget>[
                                  Flexible(
                                    child: Text(
                                      'Auditor',
                                      style: TextStyle(
                                        fontSize: 14.0, color: Colors.black87, fontWeight: FontWeight.w500
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width * 0.35,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: <Widget>[
                                  Flexible(
                                    child: Text(
                                      auditor,
                                      style: TextStyle(
                                        fontSize: 13.0,
                                        color: Colors.black38,
                                        fontWeight: FontWeight.w700
                                      ),
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
                              width: MediaQuery.of(context).size.width * 0.35,
                              child: Row(
                                children: <Widget>[
                                  Flexible(
                                    child: Text(
                                      'Auditee',
                                      style: TextStyle(
                                        fontSize: 14.0, color: Colors.black87, fontWeight: FontWeight.w500
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width * 0.35,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: <Widget>[
                                  Flexible(
                                    child: Text(
                                      auditee,
                                      style: TextStyle(
                                        fontSize: 13.0,
                                        color: Colors.black38,
                                        fontWeight: FontWeight.w700
                                      ),
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
                              width: MediaQuery.of(context).size.width * 0.35,
                              child: Row(
                                children: <Widget>[
                                  Flexible(
                                    child: Text(
                                      'Tgl Audit',
                                      style: TextStyle(
                                        fontSize: 14.0, color: Colors.black87, fontWeight: FontWeight.w500
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width * 0.35,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: <Widget>[
                                  Flexible(
                                    child: Text(
                                      createdDate,
                                      style: TextStyle(
                                        fontSize: 13.0,
                                        color: Colors.black38,
                                        fontWeight: FontWeight.w700
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 10.0, right: 10.0, bottom: 10.0, top: 5.0),
                        child: Divider(
                          height: 5.0,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 12.0, right: 12.0, bottom: 10.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              width: MediaQuery.of(context).size.width * 0.5,
                              child: Row(
                                children: <Widget>[
                                  Flexible(
                                    child: Text(
                                      'Data Location',
                                      style: TextStyle(
                                          fontSize: 15.0, color: Colors.black87, fontWeight: FontWeight.bold
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 20.0, right: 20.0, bottom: 5.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Container(
                              width: MediaQuery.of(context).size.width * 0.35,
                              child: Row(
                                children: <Widget>[
                                  Flexible(
                                    child: Text(
                                      'Department',
                                      style: TextStyle(
                                          fontSize: 14.0, color: Colors.black87, fontWeight: FontWeight.w500
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width * 0.35,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: <Widget>[
                                  Flexible(
                                    child: Text(
                                      departmentWhere,
                                      style: TextStyle(
                                          fontSize: 13.0,
                                          color: Colors.black38,
                                          fontWeight: FontWeight.w700
                                      ),
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
                              width: MediaQuery.of(context).size.width * 0.35,
                              child: Row(
                                children: <Widget>[
                                  Flexible(
                                    child: Text(
                                      'Divisi',
                                      style: TextStyle(
                                          fontSize: 14.0, color: Colors.black87, fontWeight: FontWeight.w500
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width * 0.35,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: <Widget>[
                                  Flexible(
                                    child: Text(
                                      divisiWhere,
                                      style: TextStyle(
                                          fontSize: 13.0,
                                          color: Colors.black38,
                                          fontWeight: FontWeight.w700
                                      ),
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
                              width: MediaQuery.of(context).size.width * 0.35,
                              child: Row(
                                children: <Widget>[
                                  Flexible(
                                    child: Text(
                                      'Area',
                                      style: TextStyle(
                                          fontSize: 14.0, color: Colors.black87, fontWeight: FontWeight.w500
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width * 0.35,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: <Widget>[
                                  Flexible(
                                    child: Text(
                                      areaWhere,
                                      style: TextStyle(
                                          fontSize: 13.0,
                                          color: Colors.black38,
                                          fontWeight: FontWeight.w700
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
                        padding: EdgeInsets.only(left: 10.0, right: 10.0, bottom: 10.0, top: 5.0),
                        child: Divider(
                          height: 5.0,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 12.0, right: 12.0, bottom: 10.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              width: MediaQuery.of(context).size.width * 0.5,
                              child: Row(
                                children: <Widget>[
                                  Flexible(
                                    child: Text(
                                      'Data Masalah',
                                      style: TextStyle(
                                        fontSize: 15.0, color: Colors.black87, fontWeight: FontWeight.bold
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 20.0, right: 20.0, bottom: 5.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Container(
                              width: MediaQuery.of(context).size.width * 0.35,
                              child: Row(
                                children: <Widget>[
                                  Flexible(
                                    child: Text(
                                      'Masalah',
                                      style: TextStyle(
                                        fontSize: 14.0, color: Colors.black87, fontWeight: FontWeight.w500
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width * 0.35,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: <Widget>[
                                  Flexible(
                                    child: Text(
                                      problem,
                                      style: TextStyle(
                                        fontSize: 13.0,
                                        color: Colors.black38,
                                        fontWeight: FontWeight.w700
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
                              width: MediaQuery.of(context).size.width * 0.35,
                              child: Row(
                                children: <Widget>[
                                  Flexible(
                                    child: Text(
                                      'Tgl Masalah',
                                      style: TextStyle(
                                        fontSize: 14.0, color: Colors.black87, fontWeight: FontWeight.w500
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width * 0.35,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: <Widget>[
                                  Flexible(
                                    child: Text(
                                      problemDate,
                                      style: TextStyle(
                                        fontSize: 13.0,
                                        color: Colors.black38,
                                        fontWeight: FontWeight.w700
                                      ),
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
                              width: MediaQuery.of(context).size.width * 0.35,
                              child: Row(
                                children: <Widget>[
                                  Flexible(
                                    child: Text(
                                      'Tingkat Keparahan',
                                      style: TextStyle(
                                        fontSize: 14.0, color: Colors.black87, fontWeight: FontWeight.w500
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width * 0.35,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: <Widget>[
                                  Flexible(
                                    child: Text(
                                      howSevere,
                                      style: TextStyle(
                                        fontSize: 13.0,
                                        color: Colors.black38,
                                        fontWeight: FontWeight.w700
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10.0, right: 10.0, bottom: 15.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            val3 == null
                              ? Container()
                              : Container(
                                  padding: EdgeInsets.only(left: 15.0),
                                  child: GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        showImageIA = !showImageIA;
                                        showNote = false;
                                        imageSplit = val3.toString().split('###');
                                      });
                                    },
                                    child: Icon(Icons.image, color: AbubaPallate.menuBluebird),
                                  ),
                                ),
                            Container(
                              padding: EdgeInsets.only(right: 15.0),
                              alignment: Alignment.centerRight,
                              child: ButtonTheme(
                                height: 20.0,
                                splashColor: AbubaPallate.menuBluebird,
                                child: OutlineButton(
                                  borderSide: BorderSide(color: AbubaPallate.menuBluebird, width: 1.0),
                                  highlightedBorderColor: AbubaPallate.menuBluebird,
                                  onPressed: () {
                                    setState(() {
                                      showNote = !showNote;
                                    });
                                  },
                                  child: Text(
                                    'NOTE',
                                    style: TextStyle(color: AbubaPallate.menuBluebird, fontSize: 12.0),
                                  ),
                                ),
                              )
                            ),
                          ],
                        ),
                      ),
                      showNote
                        ? Padding(
                            padding: EdgeInsets.only(left: 17.0, right: 17.0),
                            child: Container(
                              decoration: const BoxDecoration(
                                border: Border(
                                  top: BorderSide(width: 1.0, color: Color(0xFFFF000000)),
                                  left: BorderSide(width: 1.0, color: Color(0xFFFF000000)),
                                  right: BorderSide(width: 1.0, color: Color(0xFFFF000000)),
                                  bottom: BorderSide(width: 1.0, color: Color(0xFFFF000000)),
                                ),
                              ),
                              padding: EdgeInsets.all(10.0),
                              child: Column(
                                children: <Widget>[
                                  Row(
                                    children: <Widget>[
                                      Flexible(
                                        child: Text(
                                          'Note',
                                          style: TextStyle(
                                            color: Colors.black54,
                                            fontWeight: FontWeight.w700),
                                        ),
                                      )
                                    ],
                                  ),
                                  SizedBox(
                                    height: 5.0,
                                  ),
                                  Row(
                                    children: <Widget>[
                                      Flexible(
                                        child: Text(
                                          remarksProblem == null ? '-' : remarksProblem,
                                          style: TextStyle(
                                            color: Colors.black38,
                                          ),
                                        ),
                                      )
                                    ],
                                  )
                                ],
                              ),
                            ),
                          )
                        : Container(),
                      showImageIA
                        ? Container(
                            child: GridView.count(
                              padding: const EdgeInsets.only(right: 17.0, left: 17.0, bottom: 10.0),
                              crossAxisCount: 5,
                              childAspectRatio: 1.0,
                              mainAxisSpacing: 4.0,
                              crossAxisSpacing: 4.0,
                              shrinkWrap: true,
                              children: List.generate(imageSplit.length, (index2) {
                                return GridTile(
                                  child: GestureDetector(
                                    onTap: () {
                                      Navigator.push(context,
                                        MyCustomRoute(builder: (context) => DetailScreen(image: imageSplit[index2].toString(), indexx: index2))
                                      );
                                    },
                                    child: Hero(
                                      tag: 'imageHero${index2.toString()}',
                                      child: Image.network(
                                        imageSplit[index2].toString(),
                                        fit: BoxFit.cover,
                                      ),
                                      transitionOnUserGestures: true,
                                    )
                                  )
                                );
                              }).toList()
                            ),
                          )
                        : Container(),
                      Padding(
                        padding: EdgeInsets.only(left: 10.0, right: 10.0, bottom: 10.0, top: 5.0),
                        child: Divider(
                          height: 5.0,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 12.0, right: 12.0, bottom: 10.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              width: MediaQuery.of(context).size.width * 0.5,
                              child: Row(
                                children: <Widget>[
                                  Flexible(
                                    child: Text(
                                      'Analisa',
                                      style: TextStyle(
                                        fontSize: 15.0, color: Colors.black87, fontWeight: FontWeight.bold
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 20.0, right: 20.0, bottom: 5.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Container(
                              width: MediaQuery.of(context).size.width * 0.35,
                              child: Row(
                                children: <Widget>[
                                  Flexible(
                                    child: Text(
                                      'Akar Masalah',
                                      style: TextStyle(
                                        fontSize: 14.0, color: Colors.black87, fontWeight: FontWeight.w500
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width * 0.35,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: <Widget>[
                                  Flexible(
                                    child: Text(
                                      rootCause,
                                      style: TextStyle(
                                        fontSize: 13.0,
                                        color: Colors.black38,
                                        fontWeight: FontWeight.w700
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10.0, right: 10.0, bottom: 15.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            Container(
                              padding: EdgeInsets.only(right: 15.0),
                              alignment: Alignment.centerRight,
                              child: ButtonTheme(
                                height: 20.0,
                                splashColor: AbubaPallate.menuBluebird,
                                child: OutlineButton(
                                  borderSide: BorderSide(color: AbubaPallate.menuBluebird, width: 1.0),
                                  highlightedBorderColor: AbubaPallate.menuBluebird,
                                  onPressed: () {
                                    setState(() {
                                      showNote2 = !showNote2;
                                    });
                                  },
                                  child: Text(
                                    'NOTE',
                                    style: TextStyle(color: AbubaPallate.menuBluebird, fontSize: 12.0),
                                  ),
                                ),
                              )
                            ),
                          ],
                        ),
                      ),
                      showNote2
                        ? Padding(
                            padding: EdgeInsets.only(left: 17.0, right: 17.0),
                            child: Container(
                              decoration: const BoxDecoration(
                                border: Border(
                                  top: BorderSide(width: 1.0, color: Color(0xFFFF000000)),
                                  left: BorderSide(width: 1.0, color: Color(0xFFFF000000)),
                                  right: BorderSide(width: 1.0, color: Color(0xFFFF000000)),
                                  bottom: BorderSide(width: 1.0, color: Color(0xFFFF000000)),
                                ),
                              ),
                              padding: EdgeInsets.all(10.0),
                              child: Column(
                                children: <Widget>[
                                  Row(
                                    children: <Widget>[
                                      Flexible(
                                        child: Text(
                                          'Note',
                                          style: TextStyle(
                                            color: Colors.black54,
                                            fontWeight: FontWeight.w700),
                                        ),
                                      )
                                    ],
                                  ),
                                  SizedBox(
                                    height: 5.0,
                                  ),
                                  Row(
                                    children: <Widget>[
                                      Flexible(
                                        child: Text(
                                          remarksRootCause == null ? '-' : remarksRootCause,
                                          style: TextStyle(
                                            color: Colors.black38,
                                          ),
                                        ),
                                      )
                                    ],
                                  )
                                ],
                              ),
                            ),
                          )
                        : Container(),
                      Padding(
                        padding: EdgeInsets.only(left: 10.0, right: 10.0, bottom: 10.0, top: 5.0),
                        child: Divider(
                          height: 5.0,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 12.0, right: 12.0, bottom: 10.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              width: MediaQuery.of(context).size.width * 0.5,
                              child: Row(
                                children: <Widget>[
                                  Flexible(
                                    child: Text(
                                      'Perbaikan Sementara',
                                      style: TextStyle(
                                        fontSize: 15.0, color: Colors.black87, fontWeight: FontWeight.bold
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 20.0, right: 20.0, bottom: 5.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Container(
                              width: MediaQuery.of(context).size.width * 0.35,
                              child: Row(
                                children: <Widget>[
                                  Flexible(
                                    child: Text(
                                      'Action',
                                      style: TextStyle(
                                        fontSize: 14.0, color: Colors.black87, fontWeight: FontWeight.w500
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width * 0.35,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: <Widget>[
                                  Flexible(
                                    child: Text(
                                      immediateAction,
                                      style: TextStyle(
                                        fontSize: 13.0,
                                        color: Colors.black38,
                                        fontWeight: FontWeight.w700
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
                              width: MediaQuery.of(context).size.width * 0.35,
                              child: Row(
                                children: <Widget>[
                                  Flexible(
                                    child: Text(
                                      'Tgl Realisasi',
                                      style: TextStyle(
                                        fontSize: 14.0, color: Colors.black87, fontWeight: FontWeight.w500
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width * 0.35,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: <Widget>[
                                  Flexible(
                                    child: Text(
                                      immediateDate,
                                      style: TextStyle(
                                        fontSize: 13.0,
                                        color: Colors.black38,
                                        fontWeight: FontWeight.w700
                                      ),
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
                              width: MediaQuery.of(context).size.width * 0.35,
                              child: Row(
                                children: <Widget>[
                                  Flexible(
                                    child: Text(
                                      'Pelaksana',
                                      style: TextStyle(
                                        fontSize: 14.0, color: Colors.black87, fontWeight: FontWeight.w500
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width * 0.35,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: <Widget>[
                                  Flexible(
                                    child: Text(
                                      auditee,
                                      style: TextStyle(
                                        fontSize: 13.0,
                                        color: Colors.black38,
                                        fontWeight: FontWeight.w700
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 10.0, right: 10.0, bottom: 10.0, top: 5.0),
                        child: Divider(
                          height: 5.0,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 12.0, right: 12.0, bottom: 10.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              width: MediaQuery.of(context).size.width * 0.5,
                              child: Row(
                                children: <Widget>[
                                  Flexible(
                                    child: Text(
                                      'Tindakan Perbaikan',
                                      style: TextStyle(
                                        fontSize: 15.0, color: Colors.black87, fontWeight: FontWeight.bold
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 20.0, right: 20.0, bottom: 5.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Container(
                              width: MediaQuery.of(context).size.width * 0.35,
                              child: Row(
                                children: <Widget>[
                                  Flexible(
                                    child: Text(
                                      'Rekomendasi',
                                      style: TextStyle(
                                        fontSize: 14.0, color: Colors.black87, fontWeight: FontWeight.w500
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width * 0.35,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: <Widget>[
                                  Flexible(
                                    child: Text(
                                      category == 'Internal Audit'
                                        ? rekomendasiFS
                                        : '-',
                                      style: TextStyle(
                                        fontSize: 13.0,
                                        color: Colors.black38,
                                        fontWeight: FontWeight.w700
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
                              width: MediaQuery.of(context).size.width * 0.35,
                              child: Row(
                                children: <Widget>[
                                  Flexible(
                                    child: Text(
                                      'Action',
                                      style: TextStyle(
                                        fontSize: 14.0, color: Colors.black87, fontWeight: FontWeight.w500
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width * 0.35,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: <Widget>[
                                  Flexible(
                                    child: Text(
                                      actionPlan,
                                      style: TextStyle(
                                        fontSize: 13.0,
                                        color: Colors.black38,
                                        fontWeight: FontWeight.w700
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
                              width: MediaQuery.of(context).size.width * 0.35,
                              child: Row(
                                children: <Widget>[
                                  Flexible(
                                    child: Text(
                                      'Tgl Realisasi',
                                      style: TextStyle(
                                        fontSize: 14.0, color: Colors.black87, fontWeight: FontWeight.w500
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width * 0.35,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: <Widget>[
                                  Flexible(
                                    child: Text(
                                      dueDate,
                                      style: TextStyle(
                                        fontSize: 13.0,
                                        color: Colors.black38,
                                        fontWeight: FontWeight.w700
                                      ),
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
                              width: MediaQuery.of(context).size.width * 0.35,
                              child: Row(
                                children: <Widget>[
                                  Flexible(
                                    child: Text(
                                      'Pelaksana',
                                      style: TextStyle(
                                        fontSize: 14.0, color: Colors.black87, fontWeight: FontWeight.w500
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width * 0.35,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: <Widget>[
                                  Flexible(
                                    child: Text(
                                      auditee,
                                      style: TextStyle(
                                        fontSize: 13.0,
                                        color: Colors.black38,
                                        fontWeight: FontWeight.w700
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10.0, right: 10.0, bottom: 15.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            imageDoneSplit.length == 0
                              ? Container()
                              : Container(
                                  padding: EdgeInsets.only(left: 15.0),
                                  child: GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        showImageDone = !showImageDone;
                                      });
                                    },
                                    child: Icon(Icons.image, color: AbubaPallate.menuBluebird),
                                  ),
                                ),
                          ],
                        ),
                      ),
                      showImageDone
                        ? Container(
                            child: GridView.count(
                              padding: const EdgeInsets.only(right: 17.0, left: 17.0, bottom: 10.0),
                              crossAxisCount: 3,
                              childAspectRatio: 1.0,
                              mainAxisSpacing: 4.0,
                              crossAxisSpacing: 4.0,
                              shrinkWrap: true,
                              children: List.generate(imageDoneSplit.length, (index3) {
                                return GridTile(
                                  child: GestureDetector(
                                    onTap: () {
                                      Navigator.push(context,
                                        MyCustomRoute(builder: (context) => DetailScreenDone(image: imageDoneSplit[index3].toString(), indexx: index3))
                                      );
                                    },
                                    child: Hero(
                                      tag: 'imageHero${index3.toString()}',
                                      child: Image.network(
                                        imageDoneSplit[index3].toString(),
                                        fit: BoxFit.cover,
                                      ),
                                      transitionOnUserGestures: true,
                                    )
                                  )
                                );
                              }).toList()
                            ),
                          )
                        : Container(),
                      Padding(
                        padding: EdgeInsets.only(left: 10.0, right: 10.0, bottom: 10.0, top: 5.0),
                        child: Divider(
                          height: 5.0,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 12.0, right: 12.0, bottom: 10.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              width: MediaQuery.of(context).size.width * 0.5,
                              child: Row(
                                children: <Widget>[
                                  Flexible(
                                    child: Text(
                                      'Verifikasi',
                                      style: TextStyle(
                                        fontSize: 15.0, color: Colors.black87, fontWeight: FontWeight.bold
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 20.0, right: 20.0, bottom: 5.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Container(
                              width: MediaQuery.of(context).size.width * 0.35,
                              child: Row(
                                children: <Widget>[
                                  Flexible(
                                    child: Text(
                                      'Tgl Realisasi',
                                      style: TextStyle(
                                        fontSize: 14.0, color: Colors.black87, fontWeight: FontWeight.w500
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width * 0.35,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: <Widget>[
                                  Flexible(
                                    child: Text(
                                      verifikasiDate,
                                      style: TextStyle(
                                        fontSize: 13.0,
                                        color: Colors.black38,
                                        fontWeight: FontWeight.w700
                                      ),
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
                              width: MediaQuery.of(context).size.width * 0.35,
                              child: Row(
                                children: <Widget>[
                                  Flexible(
                                    child: Text(
                                      'Pelaksana',
                                      style: TextStyle(
                                        fontSize: 14.0, color: Colors.black87, fontWeight: FontWeight.w500
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width * 0.35,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: <Widget>[
                                  Flexible(
                                    child: Text(
                                      auditor,
                                      style: TextStyle(
                                        fontSize: 13.0,
                                        color: Colors.black38,
                                        fontWeight: FontWeight.w700
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  );
            },
          ),
          SizedBox(
            height: 20.0,
          ),
        ],
      ),
    );
  }
}

class DetailScreen extends StatefulWidget {
  final String image;
  final int indexx;
  DetailScreen({this.image, this.indexx});

  @override
  _DetailScreenState createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        child: Center(
          child: Hero(
            tag: 'imageHero${widget.indexx.toString()}',
            child: Image.network(
              widget.image.toString(),
            ),
            transitionOnUserGestures: true,
          ),
        ),
        onTap: () {
          Navigator.pop(context);
        },
      ),
    );
  }
}

class DetailScreenDone extends StatefulWidget {
  final String image;
  final int indexx;
  DetailScreenDone({this.image, this.indexx});

  @override
  _DetailScreenDoneState createState() => _DetailScreenDoneState();
}

class _DetailScreenDoneState extends State<DetailScreenDone>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        child: Center(
          child: Hero(
            tag: 'imageHero${widget.indexx.toString()}',
            child: Image.network(
              widget.image.toString(),
            ),
            transitionOnUserGestures: true,
          ),
        ),
        onTap: () {
          Navigator.pop(context);
        },
      ),
    );
  }
}