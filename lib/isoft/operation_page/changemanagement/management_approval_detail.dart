import 'package:flutter/material.dart';
import 'package:flutter_abuba/constant.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_abuba/isoft/operation_page/changemanagement/beranda_management.dart';

class ManagementApprovalDetail extends StatefulWidget {
  final int idUser;
  final String namaUser;
  final String departmentUser;
  var index;
  final List<dynamic> personReview;
  final List<dynamic> personReviewDate;
  ManagementApprovalDetail({this.idUser, this.namaUser, this.departmentUser, this.index, this.personReview, this.personReviewDate});

  @override
  _ManagementApprovalDetailState createState() => _ManagementApprovalDetailState();
}

class _ManagementApprovalDetailState extends State<ManagementApprovalDetail> with TickerProviderStateMixin {
  bool _note = false;
  AnimationController animationController;

  bool isProcessApprove = false;
  bool isProcessReject = false;

  int no;
  String nama;
  String department;
  Timestamp tglUsul;
  
  Timestamp tglImplementasi;
  String prioritas;
  String category;
  String alasan;
  String deskripsi;
  TextEditingController controller = TextEditingController();

  List<String> departmentReview = [];
  List<String> namaReview = [];
  var dateReview;
  List<dynamic> statusReview = [];
  List<dynamic> noteReview = [];

  String approvedBy;
  String approvedDepartment;

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
        noteReview = data.data['personReviewNote'];
        statusReview = data.data['personReviewStatus'];

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
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pushReplacement(context,
                MaterialPageRoute(
                  builder: (_) => BerandaManagement(idUser: widget.idUser, namaUser: widget.namaUser, departmentUser: widget.departmentUser)
                )
              );
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
          child: Scrollbar(
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
                                                      style: TextStyle(color: statusReview[index].toString() == 'OPEN' || statusReview[index].toString() == 'NA' ? Colors.black45 : statusReview[index].toString() == 'REJECTED' ? Colors.redAccent : statusReview[index].toString() == 'APPROVED' ? AbubaPallate.greenabuba : Colors.black45, fontSize: 12.0),
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
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Expanded(
                                        child: Column(
                                          children: <Widget>[
                                            Padding(
                                              padding: const EdgeInsets.fromLTRB(12.0, 12.0, 12.0, 6.0),
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.start,
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
                                                      '$approvedBy',
                                                      style: TextStyle(fontWeight: FontWeight.w300, fontSize: 12.0),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Expanded(
                                        child: Padding(
                                          padding: const EdgeInsets.fromLTRB(12.0, 12.0, 12.0, 6.0),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.end,
                                            children: <Widget>[
                                              Flexible(
                                                child: ButtonTheme(
                                                  minWidth: 50.0,
                                                  height: 25.0,
                                                  child: OutlineButton(
                                                    child: Text(
                                                      'NOTE',
                                                      style:
                                                          TextStyle(fontSize: 13.0, color: Colors.blue),
                                                    ),
                                                    borderSide: BorderSide(color: Colors.blue, width: 1.0),
                                                    highlightedBorderColor: Colors.blue,
                                                    onPressed: () {
                                                      setState(() {
                                                        _note = !_note;                            
                                                      });
                                                    },
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                  _note
                                    ? Padding(
                                        padding: const EdgeInsets.fromLTRB(12.0, 0.0, 12.0, 12.0),
                                        child: Container(
                                          color: Colors.white,
                                          child: TextFormField(
                                            controller: controller,
                                            maxLength: 250,
                                            decoration: InputDecoration(
                                              border: OutlineInputBorder(),
                                              hintText: 'Note',
                                              hintStyle: TextStyle(fontSize: 12.0),
                                            ),
                                            maxLines: 3,
                                            textCapitalization: TextCapitalization.sentences,
                                            style: TextStyle(
                                              color: Colors.black,
                                            ),
                                          ),
                                        ),
                                      )
                                    : Container()
                                ],
                              ),
                            ),
                            Container(
                                padding: const EdgeInsets.fromLTRB(12.0, 12.0, 12.0, 6.0),
                                color: Colors.white,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Padding(
                                      padding: const EdgeInsets.only(right: 5.0, left: 5.0),
                                      child: ButtonTheme(
                                        minWidth: 50.0,
                                        height: 30.0,
                                        child: OutlineButton(
                                          child: isProcessReject
                                            ? Container(
                                                padding: EdgeInsets.symmetric(vertical: 5.0),
                                                child: Center(
                                                  child: SizedBox(
                                                    height: 15.0,
                                                    width: 15.0,
                                                    child: CircularProgressIndicator(
                                                      valueColor: AlwaysStoppedAnimation(Colors.redAccent),
                                                      strokeWidth: 2.0,
                                                    ),
                                                  ),
                                                ),
                                              )
                                            : Text(
                                                'REJECT',
                                                style: TextStyle(
                                                    fontSize: 13.0, color: Colors.redAccent),
                                              ),
                                          borderSide:
                                              BorderSide(color: Colors.redAccent, width: 1.0),
                                          highlightedBorderColor: Colors.redAccent,
                                          onPressed: () {
                                            setState(() {
                                              isProcessApprove = false;
                                              isProcessReject = true;
                                            });

                                            if (isProcessApprove == false && isProcessReject == true) {
                                              DocumentReference documentReference = Firestore.instance.collection('changeMgmt').document(widget.index);

                                              documentReference.updateData({
                                                'approveDate': DateTime.now(),
                                                'approveNote': controller.text,
                                                'finalStatus': 'REJECTED',
                                                'statusApprove': true
                                              }).then((doc) {
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
                                                                'SUCCESSFUL!',
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
                                                              'Data Rejected',
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
                                                ).whenComplete(() {
                                                  Navigator.pop(context);
                                                });
                                              }).catchError((error) {
                                                print(error);
                                              });
                                            } else {

                                            }
                                          },
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 5.0),
                                      child: ButtonTheme(
                                        minWidth: 50.0,
                                        height: 30.0,
                                        child: OutlineButton(
                                          child: isProcessApprove
                                            ? Container(
                                                padding: EdgeInsets.symmetric(vertical: 5.0),
                                                child: Center(
                                                  child: SizedBox(
                                                    height: 15.0,
                                                    width: 15.0,
                                                    child: CircularProgressIndicator(
                                                      valueColor: AlwaysStoppedAnimation(Colors.blue),
                                                      strokeWidth: 2.0,
                                                    ),
                                                  ),
                                                ),
                                              )
                                            : Text(
                                                'APPROVE',
                                                style: TextStyle(
                                                    fontSize: 13.0, color: Colors.blue),
                                              ),
                                          borderSide: BorderSide(color: Colors.blue, width: 1.0),
                                          highlightedBorderColor: Colors.blue,
                                          onPressed: () {
                                            setState(() {
                                              isProcessApprove = true;
                                              isProcessReject = false;
                                            });

                                            if (isProcessApprove == true && isProcessReject == false) {
                                              DocumentReference documentReference = Firestore.instance.collection('changeMgmt').document(widget.index);

                                              documentReference.updateData({
                                                'approveDate': DateTime.now(),
                                                'approveNote': controller.text,
                                                'finalStatus': 'APPROVED',
                                                'statusApprove': true
                                              }).then((doc) {
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
                                                                'SUCCESSFUL!',
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
                                                              'Data Approved',
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
                                                ).whenComplete(() {
                                                  Navigator.pop(context);
                                                });
                                              }).catchError((error) {
                                                print(error);
                                              });
                                            } else {

                                            }
                                          },
                                        ),
                                      ),
                                    )
                                  ],
                                )
                              ),
                          ],
                        );
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
