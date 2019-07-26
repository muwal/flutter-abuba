import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_abuba/constant.dart';
import 'package:flutter_abuba/isoft/operation_page/workinginstruction/list/form_listDetail.dart';

class FormDetailWorking extends StatefulWidget {
  final int idUser;
  final String namaUser;
  final String departmentUser;
  var index;
  List<dynamic> pJabatan;
  List<dynamic> pDepartment;
  List<dynamic> pDocTerkait;
  List<dynamic> pComment;
  List<dynamic> pCommentStatus;
  List<dynamic> tujuanCommentCreated;
  List<dynamic> ruangLingkupCommentCreated;
  List<dynamic> referensiCommentCreated;
  List<dynamic> istilahCommentCreated;
  List<dynamic> risikoCommentCreated;
  List<dynamic> prosedurCommentTgl;
  String bantutujuan;
  String banturuanglingkup;
  String bantureferensi;
  String bantuinstruksi;
  String banturisiko;
  FormDetailWorking({this.idUser, this.namaUser, this.departmentUser, this.index, this.pJabatan, this.pDocTerkait, this.pDepartment, this.pComment, this.pCommentStatus, this.tujuanCommentCreated, this.istilahCommentCreated, this.referensiCommentCreated, this.ruangLingkupCommentCreated, this.prosedurCommentTgl, this.bantuinstruksi, this.bantureferensi, this.banturisiko, this.banturuanglingkup, this.bantutujuan, this.risikoCommentCreated});

  @override
  _FormDetailWorkingState createState() => _FormDetailWorkingState();
}

class _FormDetailWorkingState extends State<FormDetailWorking> with TickerProviderStateMixin {
  AnimationController animationController;

  String noDoc;
  int revisi = 0;
  String judulDoc;
  String tujuanDeskripsi;
  String rLingkupDeskripsi;
  String referensiDeskripsi;
  List<dynamic> instruksiDeskripsi = [];
  List<dynamic> risikoDeskripsi = [];
  List<dynamic> revisiNo = [];
  List<dynamic> revisiDeskripsi = [];
  List<dynamic> revisiTgl = [];
  List<dynamic> pTugas = [];
  List<dynamic> pJabatan = [];
  List<dynamic> pDepartment = [];
  List<dynamic> pDocTerkaitType = [];
  List<dynamic> pDocTerkait = [];
  List<dynamic> pKeterangan = [];
  List<dynamic> pAction = [];
  List<dynamic> pActionTo = [];

  TextEditingController controllerTujuan = TextEditingController();
  TextEditingController controllerRuangLingkup = TextEditingController();
  TextEditingController controllerReferensi = TextEditingController();
  TextEditingController controllerInstruksi = TextEditingController();
  TextEditingController controllerRisiko = TextEditingController();

  bool isProcessReject = false;
  bool isProcessApprove = false; 

  var textEditingControllers = <TextEditingController>[];

  var tujuanComment = [];
  var ruangLingkupComment = [];
  var referensiComment = [];
  var instruksiComment = [];
  var risikoComment = [];
  var prosedurComment = [];

  var tujuanCommentView = [];
  var ruangLingkupCommentView = [];
  var referensiCommentView = [];
  var instruksiCommentView = [];
  var risikoCommentView = [];
  var prosedurCommentView = [];

  String bantuTujuan = '';
  String bantuRuangLingkup = '';
  String bantuReferensi = '';
  String bantuInstruksi = '';
  String bantuIstilah = '';
  String bantuRisiko = '';

  List<dynamic> tujuanComment2 = [];
  List<dynamic> ruangLingkupComment2 = [];
  List<dynamic> referensiComment2 = [];
  List<dynamic> instruksiComment2 = [];
  List<dynamic> risikoComment2 = [];
  List<dynamic> prosedurComment2 = [];
  
  var tujuanCommentStatus = [];
  var ruangLingkupCommentStatus = [];
  var referensiCommentStatus = [];
  var instruksiCommentStatus = [];
  var risikoCommentStatus = [];
  var prosedurCommentStatus = [];

  var tujuanCommentStatusView = [];
  var ruangLingkupCommentStatusView = [];
  var referensiCommentStatusView = [];
  var instruksiCommentStatusView = [];
  var risikoCommentStatusView = [];
  var prosedurCommentStatusView = [];

  List<dynamic> tujuanCommentStatus2 = [];
  List<dynamic> ruangLingkupCommentStatus2 = [];
  List<dynamic> referensiCommentStatus2 = [];
  List<dynamic> instruksiCommentStatus2 = [];
  List<dynamic> risikoCommentStatus2 = [];
  List<dynamic> prosedurCommentStatus2 = [];

  List<dynamic> tujuanCommentTgl2 = [];
  List<String> tujuanCommentCreated2 = [];
  List<dynamic> ruangLingkupCommentTgl2 = [];
  List<String> ruangLingkupCommentCreated2 = [];
  List<dynamic> referensiCommentTgl2 = [];
  List<String> referensiCommentCreated2 = [];
  List<dynamic> instruksiCommentTgl2 = [];
  List<String> instruksiCommentCreated2 = [];
  List<dynamic> risikoCommentTgl2 = [];
  List<String> risikoCommentCreated2 = [];
  List<dynamic> prosedurCommentCreated2 = [];

  var tujuanCommentTgl = [];
  var ruangLingkupCommentTgl = [];
  var referensiCommentTgl = [];
  var instruksiCommentTgl = [];
  var risikoCommentTgl = [];
  var prosedurCommentTgl = [];

  var tujuanCommentTglView = [];
  var ruangLingkupCommentTglView = [];
  var referensiCommentTglView = [];
  var instruksiCommentTglView = [];
  var risikoCommentTglView = [];
  var prosedurCommentTglView = [];

  var tujuanCommentCreated = [];
  var ruangLingkupCommentCreated = [];
  var referensiCommentCreated = [];
  var instruksiCommentCreated = [];
  var risikoCommentCreated = [];
  var prosedurCommentCreated = [];

  var tujuanCommentCreatedView = [];
  var ruangLingkupCommentCreatedView = [];
  var referensiCommentCreatedView = [];
  var instruksiCommentCreatedView = [];
  var risikoCommentCreatedView = [];
  var prosedurCommentCreatedView = [];

  List<dynamic> docTerkaitJudul = [];
  List<dynamic> docTerkaitID = [];
  bool isProcessTerkait = false;

  var p_Comment = [];
  var p_CommentCreated = [];
  var p_CommentTgl = [];
  var p_CommentStatus = [];

  var bantua = [];
  var bantuc = [];
  var bantug = [];

  List<dynamic> option = [];

  List<dynamic> tujuanCommentTerkait = [];
  List<dynamic> ruangLingkupCommentTerkait = [];
  List<dynamic> referensiCommentTerkait = [];
  List<dynamic> instruksiCommentTerkait = [];
  List<dynamic> risikoCommentTerkait = [];
  List<dynamic> prosedurCommentTerkait = [];

  var tujuanCommentStatusTerkait = [];
  var ruangLingkupCommentStatusTerkait = [];
  var referensiCommentStatusTerkait = [];
  var instruksiCommentStatusTerkait = [];
  var risikoCommentStatusTerkait = [];
  var prosedurCommentStatusTerkait = [];

  String bantuTujuanTerkait = '';
  String bantuRuangLingkupTerkait = '';
  String bantuReferensiTerkait = '';
  String bantuIstilahTerkait = '';
  String bantuRisikoTerkait = '';
  String catatanRevisi;

  List<dynamic> imageInstruksi = [];
  List<bool> _gambarInstruksi = [];

  @override
  void initState() {
    super.initState();

    Firestore.instance.collection('docInstruksi').document(widget.index).snapshots().listen((data) {
      setState(() {

        print(data.data['noDoc']);
        print(data.data['judul']);

        noDoc = data.data['noDoc'];
        judulDoc = data.data['judul'];
        referensiDeskripsi = data.data['referensiDeskripsi'];
        instruksiDeskripsi = data.data['instruksiDeskripsi'];
        catatanRevisi = data.data['catatanRevisiDeskripsi'];
        imageInstruksi = data.data['instruksiImage'];

        if (data.data.containsKey('referensiComment')) {
          referensiComment = List<dynamic>.from(data.data['referensiComment']);
          referensiCommentCreated = List<dynamic>.from(data.data['referensiCommentCreated']);
          referensiCommentTgl = List<dynamic>.from(data.data['referensiCommentTgl']);
          referensiCommentStatus = List<dynamic>.from(data.data['referensiCommentStatus']);

          referensiCommentView = List<dynamic>.from(data.data['referensiComment']);
          referensiCommentStatusView = List<dynamic>.from(data.data['referensiCommentStatus']);
          referensiCommentCreatedView = List<dynamic>.from(data.data['referensiCommentCreated']);

          referensiComment2 = data.data['referensiComment'];
          referensiCommentTgl2 = data.data['referensiCommentTgl'];
          referensiCommentStatus2 = List<dynamic>.from(data.data['referensiCommentStatus']);
          bantuReferensi = 'YES';
        } else {
          bantuReferensi = 'NO';
        }

        if (data.data.containsKey('instruksiComment')) {
          instruksiComment = List<dynamic>.from(data.data['instruksiComment']);
          instruksiCommentCreated = List<dynamic>.from(data.data['instruksiCommentCreated']);
          instruksiCommentTgl = List<dynamic>.from(data.data['instruksiCommentTgl']);
          instruksiCommentStatus = List<dynamic>.from(data.data['instruksiCommentStatus']);

          instruksiCommentView = List<dynamic>.from(data.data['instruksiComment']);
          instruksiCommentStatusView = List<dynamic>.from(data.data['instruksiCommentStatus']);
          instruksiCommentCreatedView = List<dynamic>.from(data.data['instruksiCommentCreated']);

          instruksiComment2 = data.data['instruksiComment'];
          instruksiCommentTgl2 = data.data['instruksiCommentTgl'];
          instruksiCommentStatus2 = List<dynamic>.from(data.data['instruksiCommentStatus']);
          bantuInstruksi = 'YES';
        } else {
          bantuInstruksi = 'NO';
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
    return Scaffold(
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
      backgroundColor: Colors.white,
      body: GestureDetector(
          onTap: () {
            FocusScope.of(context).requestFocus(FocusNode());
          },
          child: ListView(
            shrinkWrap: true,
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
                  : Column(
                    children: <Widget>[
                      Container(
                        color: Colors.grey[200],
                        height: 50.0,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Flexible(
                              child: Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: Text(
                                  noDoc + ' REV ' + revisi.toString().padLeft(2, '0'),
                                  style: TextStyle(
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black38
                                  ),
                                ),
                              ),
                            ),
                            Flexible(
                              child: Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: RichText(
                                  softWrap: true,
                                  overflow: TextOverflow.visible,
                                  text: TextSpan(
                                    children: <TextSpan>[
                                      TextSpan(
                                        text: judulDoc.toUpperCase(),
                                        style: TextStyle(
                                          fontSize: 14.0,
                                          color: Colors.black87,
                                          fontWeight: FontWeight.bold
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                          padding: EdgeInsets.only(top: 10.0, left: 10.0, right: 10.0),
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
                                        'I. REFERENSI',
                                        style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold, color: Colors.black87)
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.only(bottom: 10.0, left: 20, right: 20),
                                child: Row(
                                  children: <Widget>[
                                    Flexible(
                                      child: Text(
                                        referensiDeskripsi,
                                        style: TextStyle(
                                          fontSize: 14.0,
                                          color: Colors.black38,
                                          fontWeight: FontWeight.w500
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: 20.0, right: 20.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: <Widget>[
                                    ButtonTheme(
                                      minWidth: 50.0,
                                      height: 30.0,
                                      child: OutlineButton(
                                        child: Text(
                                          'History',
                                          style: TextStyle(fontSize: 13.0, color: AbubaPallate.menuBluebird),
                                        ),
                                        borderSide: BorderSide(color: AbubaPallate.menuBluebird, width: 1.0),
                                        highlightedBorderColor: AbubaPallate.menuBluebird,
                                        onPressed: () {
                                          print(referensiCommentView);
                                          print(referensiCommentStatusView);
                                          print(referensiCommentCreatedView);
                                          print(referensiCommentTgl2);
                                          showModalBottomSheet(
                                            context: context,
                                            builder: (builder) {
                                              print(bantuTujuan);
                                              return DialogBottomReferensi(
                                                referensiComment: referensiCommentView,
                                                referensiCommentStatus: referensiCommentStatusView,
                                                referensiCommentCreated: referensiCommentCreatedView,
                                                referensiCommentTgl: referensiCommentTgl2,
                                                bantu: bantuReferensi,
                                              );
                                            }
                                          ).then((value) {
                                            print('berhasil');
                                          });
                                        }
                                      ),
                                    ),
                                    SizedBox(
                                      width: 10.0,
                                    ),
                                    ButtonTheme(
                                      minWidth: 50.0,
                                      height: 30.0,
                                      child: RaisedButton(
                                        splashColor: AbubaPallate.menuBluebird,
                                        highlightColor: AbubaPallate.menuBluebird,
                                        disabledColor: AbubaPallate.menuBluebird,
                                        color: AbubaPallate.menuBluebird,
                                        child: Text(
                                          'Comment',
                                          style: TextStyle(fontSize: 13.0, color: Colors.white),
                                        ),
                                        onPressed: () {
                                          showModalBottomSheet(
                                            context: context,
                                            builder: (builder) {
                                              return Container(
                                                color: Color(0xFF737373),
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    borderRadius: BorderRadius.only(
                                                      topRight: const Radius.circular(20.0),
                                                      topLeft: const Radius.circular(20.0),
                                                    ),
                                                  ),
                                                  padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom, top: 20.0, left: 12.0, right: 12.0),
                                                  child: TextField(
                                                    autofocus: false,
                                                    keyboardType: TextInputType.text,
                                                    decoration: InputDecoration(
                                                      hintText: 'Comment - Referensi',
                                                      hintStyle: TextStyle(fontSize: 14.0),
                                                    ),
                                                    controller: controllerReferensi,
                                                    maxLength: 250,
                                                    textCapitalization: TextCapitalization.sentences,
                                                    style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 14.0
                                                    ),
                                                  ),
                                                ),
                                              );
                                            },
                                          ).then((value) {
                                            setState(() {
                                               if (controllerReferensi.text == null || controllerReferensi.text == '') {

                                              } else {
                                                referensiComment.add(controllerReferensi.text);
                                                referensiCommentCreated.add(widget.idUser);
                                                referensiCommentStatus.add('OPEN');
                                                referensiCommentTgl.add(DateTime.now());
                                              }
                                              controllerReferensi.clear();
                                            });
                                          });
                                        },
                                      )
                                    ),
                                  ],
                                )
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.only(left: 10.0, right: 10.0),
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
                                        'II. INSTRUKSI',
                                        style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold, color: Colors.black87)
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            children: <Widget>[
                              Padding(
                                  padding: const EdgeInsets.only(bottom: 10.0, left: 20, right: 20),
                                  child: instruksiDeskripsi.length == 0
                                      ? Row(
                                    children: <Widget>[
                                      Flexible(
                                        child: Text(
                                          '-',
                                          style: TextStyle(
                                              fontSize: 14.0,
                                              color: Colors.black38,
                                              fontWeight: FontWeight.w500
                                          ),
                                        ),
                                      )
                                    ],
                                  )
                                      : Column(
                                      children: List.generate(instruksiDeskripsi.length, (index) {

                                        _gambarInstruksi.add(false);

                                        return Padding(
                                          padding: const EdgeInsets.only(top: 5.0, bottom: 5.0),
                                          child: Column(
                                            children: <Widget>[
                                              Row(
                                                children: <Widget>[
                                                  Flexible(
                                                    child: Text(
                                                      '${index + 1}. ${instruksiDeskripsi[index].toString()}',
                                                      style: TextStyle(
                                                          fontSize: 14.0,
                                                          color: Colors.black38,
                                                          fontWeight: FontWeight.w500
                                                      ),
                                                    ),
                                                  ),

                                                ],
                                              ),
                                              Padding(
                                                  padding: EdgeInsets.only(top:5.0 ,left: 0.0, right: 15.0, bottom: 10.0),
                                                  child: Container(
                                                    width: 270.0,
                                                    child: Row(
                                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                        children: <Widget>[
                                                          imageInstruksi[index] == null
                                                              ? Container()
                                                              : GestureDetector(
                                                            onTap: () {
                                                              setState(() {
                                                                var bantuGambarInstruksi = _gambarInstruksi[index];
                                                                _gambarInstruksi.removeAt(index);
                                                                _gambarInstruksi.insert(index, !bantuGambarInstruksi);
                                                              });
                                                            },
                                                            child: Icon(Icons.image, color: AbubaPallate.menuBluebird),
                                                          ),
                                                        ]
                                                    ),
                                                  )
                                              ),
                                              _gambarInstruksi[index]
                                                  ? imageInstruksi[index] == null
                                                  ? Padding(
                                                padding: EdgeInsets.only(left: 17.0, right: 17.0, bottom: 10.0),
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
                                                              'No Image',
                                                              style: TextStyle(
                                                                  color: Colors.black54,
                                                                  fontWeight: FontWeight.w700),
                                                            ),
                                                          )
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              )
                                                  : Container(
                                                child: GridView.count(
                                                    padding: const EdgeInsets.only(right: 17.0, left: 17.0, bottom: 10.0),
                                                    crossAxisCount: 2,
                                                    childAspectRatio: 1.0,
                                                    mainAxisSpacing: 4.0,
                                                    crossAxisSpacing: 4.0,
                                                    shrinkWrap: true,
                                                    children: <Widget>[
                                                      GridTile(
                                                          child: GestureDetector(
                                                            onTap: () {
                                                              Navigator.push(context, MyCustomRoute(builder: (context) => DetailScreenAreaLuar(image: imageInstruksi[index])));
                                                            },
                                                            child: Image.network(
                                                              imageInstruksi[index].toString(),
                                                              fit: BoxFit.cover,
                                                            ),
                                                          )
                                                      ),
                                                    ]
                                                ),
                                              )
                                                  : Container(),
                                            ],
                                          ),
                                        );
                                      }).toList()
                                  )
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: 20.0, right: 20.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: <Widget>[
                                    ButtonTheme(
                                      minWidth: 50.0,
                                      height: 30.0,
                                      child: OutlineButton(
                                        child: Text(
                                          'History',
                                          style: TextStyle(fontSize: 13.0, color: AbubaPallate.menuBluebird),
                                        ),
                                        borderSide: BorderSide(color: AbubaPallate.menuBluebird, width: 1.0),
                                        highlightedBorderColor: AbubaPallate.menuBluebird,
                                        onPressed: () {
                                          showModalBottomSheet(
                                            context: context,
                                            builder: (builder) {
                                              return DialogBottomInstruksi(
                                                instruksiComment: instruksiCommentView,
                                                instruksiCommentStatus: instruksiCommentStatusView,
                                                instruksiCommentCreated: instruksiCommentCreatedView,
                                                instruksiCommentTgl: instruksiCommentTgl2,
                                                bantu: bantuInstruksi,
                                              );
                                            }
                                          ).then((value) {
                                            print('berhasil');
                                          });
                                        }
                                      ),
                                    ),
                                    SizedBox(
                                      width: 10.0,
                                    ),
                                    ButtonTheme(
                                      minWidth: 50.0,
                                      height: 30.0,
                                      child: RaisedButton(
                                        child: Text(
                                          'Comment',
                                          style: TextStyle(fontSize: 13.0, color: Colors.white),
                                        ),
                                        splashColor: AbubaPallate.menuBluebird,
                                        highlightColor: AbubaPallate.menuBluebird,
                                        disabledColor: AbubaPallate.menuBluebird,
                                        color: AbubaPallate.menuBluebird,
                                        onPressed: () {
                                          showModalBottomSheet(
                                            context: context,
                                            builder: (builder) {
                                              return Container(
                                                color: Color(0xFF737373),
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    borderRadius: BorderRadius.only(
                                                      topRight: const Radius.circular(20.0),
                                                      topLeft: const Radius.circular(20.0),
                                                    ),
                                                  ),
                                                  padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom, top: 20.0, left: 12.0, right: 12.0),
                                                  child: TextField(
                                                    autofocus: false,
                                                    keyboardType: TextInputType.text,
                                                    decoration: InputDecoration(
                                                      hintText: 'Comment - Instruksi',
                                                      hintStyle: TextStyle(fontSize: 14.0),
                                                    ),
                                                    controller: controllerInstruksi,
                                                    maxLength: 250,
                                                    textCapitalization: TextCapitalization.sentences,
                                                    style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 14.0
                                                    ),
                                                  ),
                                                ),
                                              );
                                            },
                                          ).then((value) {
                                            setState(() {
                                              if (controllerInstruksi.text == null || controllerInstruksi.text == '') {

                                              } else {
                                                instruksiComment.add(controllerInstruksi.text);
                                                instruksiCommentCreated.add(widget.idUser);
                                                instruksiCommentStatus.add('OPEN');
                                                instruksiCommentTgl.add(DateTime.now());
                                              }
                                              controllerInstruksi.clear();
                                            });
                                          });
                                        }
                                      ),
                                    )
                                  ],
                                )
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.only(left: 10.0, right: 10.0),
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
                                        'III. CATATAN REVISI',
                                        style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold, color: Colors.black87)
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.only(bottom: 10.0, left: 20, right: 20),
                                child: Column(
                                  children: revisiNo.length == 0
                                    ? <Widget>[
                                        Container(
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                            'No Data',
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold
                                            ),
                                          ),
                                        )
                                      ]
                                    : List.generate(revisiNo.length, (index2) {
                                        Timestamp tglBantu = revisiTgl[index2];
                                        return Column(
                                          children: <Widget>[
                                            index2 == 0
                                              ? Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  children: <Widget>[
                                                    Flexible(
                                                      child: Text(
                                                        'Nomor Revisi',
                                                        style: TextStyle(
                                                          fontSize: 15.0,
                                                          color: Colors.black54,
                                                          fontWeight: FontWeight.bold
                                                        ),
                                                      ),
                                                    ),
                                                    Flexible(
                                                      child: Text(
                                                        'Tanggal Efektif',
                                                        style: TextStyle(
                                                          fontSize: 15.0,
                                                          color: Colors.black54,
                                                          fontWeight: FontWeight.bold
                                                        ),
                                                      ),
                                                    )
                                                  ],
                                                )
                                              : Container(),
                                            index2 == 0
                                              ? SizedBox(
                                                  height: 10.0,
                                                )
                                              : Container(),
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: <Widget>[
                                                Flexible(
                                                  child: Text(
                                                    'REV ${revisiNo[index2].toString().padLeft(2, '0')}',
                                                    style: TextStyle(
                                                      fontSize: 14.0,
                                                      color: Colors.black38,
                                                      fontWeight: FontWeight.w500
                                                    ),
                                                  ),
                                                ),
                                                Flexible(
                                                  child: GestureDetector(
                                                    onTap: () {
                                                      var bantuDetail = revisiDeskripsi[index2].toString().split('!@##');

                                                      showModalBottomSheet(
                                                        context: context,
                                                        builder: (builder) {
                                                          return Container(
                                                            color: Color(0xFF737373),
                                                            height: MediaQuery.of(context).size.height * 0.3,
                                                            child: Container(
                                                              decoration: BoxDecoration(
                                                                color: AbubaPallate.greenabuba,
                                                                borderRadius: BorderRadius.only(
                                                                  topRight: const Radius.circular(20.0),
                                                                  topLeft: const Radius.circular(20.0),
                                                                ),
                                                              ),
                                                              child: Column(
                                                                children: <Widget>[
                                                                  Padding(
                                                                    padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 20.0),
                                                                    child: Row(
                                                                      mainAxisAlignment: MainAxisAlignment.center,
                                                                      children: <Widget>[
                                                                        Flexible(
                                                                          child: Text(
                                                                            'ALASAN PERUBAHAN',
                                                                            style: TextStyle(
                                                                              fontSize: 16.0,
                                                                              color: Colors.white,
                                                                              fontWeight: FontWeight.bold
                                                                            ),
                                                                          ),
                                                                        )
                                                                      ],
                                                                    ),
                                                                  ),
                                                                  SizedBox(
                                                                    height: 6.0,
                                                                  ),
                                                                  Container(
                                                                    color: Colors.white,
                                                                    height: MediaQuery.of(context).size.height * 0.3 - 46.0,
                                                                    padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 20.0),
                                                                    child: Column(
                                                                      children: <Widget>[
                                                                        Expanded(
                                                                          child: ListView(
                                                                            physics: ScrollPhysics(),
                                                                            children: List.generate(bantuDetail.length, (index3) {
                                                                              return Row(
                                                                                children: <Widget>[
                                                                                  Flexible(
                                                                                    child: Text(
                                                                                      '${index3 + 1}. ${bantuDetail[index3]}',
                                                                                      style: TextStyle(
                                                                                        fontSize: 15.0,
                                                                                        color: Colors.black38,
                                                                                        fontWeight: FontWeight.w500
                                                                                      ),
                                                                                    ),
                                                                                  )
                                                                                ],
                                                                              );
                                                                            }).toList()
                                                                          ),
                                                                        )
                                                                      ],
                                                                    ),
                                                                  )
                                                                ],
                                                              )
                                                            ),
                                                          );
                                                        },
                                                      );
                                                    },
                                                    child: Text(
                                                      tglBantu.toDate().toString().substring(8, 10) + '/' + tglBantu.toDate().toString().substring(5, 7) + '/' +tglBantu.toDate().toString().substring(0, 4),
                                                      style: TextStyle(
                                                        fontSize: 14.0,
                                                        color: AbubaPallate.menuBluebird,
                                                        fontWeight: FontWeight.w500
                                                      ),
                                                    ),
                                                  ),
                                                )
                                              ],
                                            )
                                          ],
                                        );
                                      }).toList()
                                )
                              ),
                            ],
                          ),
                        ),
                         Padding(
                          padding: EdgeInsets.only(bottom: 10.0, left: 20.0, right: 20.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: <Widget>[
                              ButtonTheme(
                                minWidth: 50.0,
                                height: 30.0,
                                child: OutlineButton(
                                  child: isProcessReject
                                    ? SizedBox(
                                        child: CircularProgressIndicator(
                                          valueColor: AlwaysStoppedAnimation(Colors.redAccent),
                                          strokeWidth: 2.0
                                        ),
                                        height: 20.0,
                                        width: 20.0
                                      )
                                    : Text(
                                        'REJECT',
                                        style: TextStyle(fontSize: 13.0, color: Colors.redAccent),
                                      ),
                                  borderSide: BorderSide(color: Colors.redAccent, width: 1.0),
                                  highlightedBorderColor: Colors.redAccent,
                                  onPressed: () {
                                    setState(() {
                                      isProcessReject = true;
                                      isProcessApprove = false;
                                    });

                                    if (isProcessReject) {
                                      DocumentReference docReference = Firestore.instance.collection('docInstruksi').document(widget.index);

                                      docReference.updateData({
                                        'rejector': widget.namaUser,
                                        'status': 'REJECTED',
                                        'verifyDate': DateTime.now(),
                                        'referensiComment': referensiComment,
                                        'referensiCommentCreated': referensiCommentCreated,
                                        'referensiCommentStatus': referensiCommentStatus,
                                        'referensiCommentTgl': referensiCommentTgl,
                                        'instruksiComment': instruksiComment,
                                        'instruksiCommentCreated': instruksiCommentCreated,
                                        'instruksiCommentStatus': instruksiCommentStatus,
                                        'instruksiCommentTgl': instruksiCommentTgl,
                                        'lastRevisi': int.tryParse(revisi.toString()) + 1
                                      }).then((doc) {
                                        setState(() {
                                          isProcessReject = false;
                                          isProcessApprove = false;
                                        });
                                        showDialog(
                                          barrierDismissible: false,
                                          context: context,
                                          builder: (context) => Dialog(
                                            child: Container(
                                              height: 180.0,
                                              child: Column(
                                                children: <Widget>[
                                                  Container(
                                                    color: Colors.redAccent,
                                                    height: 50.0,
                                                    child: Center(
                                                      child: Text(
                                                        'Rejected!',
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
                                                      noDoc,
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
                                      print('no process');
                                    }
                                  }
                                ),
                              ),
                              SizedBox(
                                width: 5.0,
                              ),
                              ButtonTheme(
                                minWidth: 50.0,
                                height: 30.0,
                                child: RaisedButton(
                                  child: isProcessApprove
                                    ? SizedBox(
                                        child: CircularProgressIndicator(
                                          valueColor: AlwaysStoppedAnimation(Colors.white),
                                          strokeWidth: 2.0
                                        ),
                                        height: 20.0,
                                        width: 20.0
                                      )
                                    : Text(
                                        'APPROVE',
                                        style: TextStyle(fontSize: 13.0, color: Colors.white),
                                      ),
                                  splashColor: AbubaPallate.greenabuba,
                                  highlightColor: AbubaPallate.greenabuba,
                                  disabledColor: AbubaPallate.greenabuba,
                                  color: AbubaPallate.greenabuba,
                                  onPressed: () {
                                    setState(() {
                                      isProcessReject = false;
                                      isProcessApprove = true;
                                    });

                                    if (isProcessApprove) {
                                      DocumentReference docReference = Firestore.instance.collection('docInstruksi').document(widget.index);

                                      docReference.updateData({
                                        'status': 'REVIEWED',
                                        'verifyDate': DateTime.now(),
                                        'referensiComment': referensiComment,
                                        'referensiCommentCreated': referensiCommentCreated,
                                        'referensiCommentStatus': referensiCommentStatus,
                                        'referensiCommentTgl': referensiCommentTgl,
                                        'instruksiComment': instruksiComment,
                                        'instruksiCommentCreated': instruksiCommentCreated,
                                        'instruksiCommentStatus': instruksiCommentStatus,
                                        'instruksiCommentTgl': instruksiCommentTgl,
                                        'lastRevisi': revisi
                                      }).then((doc) {
                                        setState(() {
                                          isProcessReject = false;
                                          isProcessApprove = false;
                                        });
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
                                                        'REVIEWED!',
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
                                                      noDoc,
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
                                      print('no process');
                                    }
                                  },
                                )
                              )
                            ],
                          )
                        )
                    ],
                  );
                },
              )
            ],
          ),
      ),
    );
  }
}

 // history referensi
  class DialogBottomReferensi extends StatefulWidget {
    List<dynamic> referensiComment;
    List<dynamic> referensiCommentTgl;
    List<dynamic> referensiCommentStatus;
    List<dynamic> referensiCommentCreated;
    String bantu;

    DialogBottomReferensi({this.referensiComment, this.referensiCommentStatus, this.bantu, this.referensiCommentCreated, this.referensiCommentTgl});
    @override
    _DialogBottomReferensiState createState() => _DialogBottomReferensiState();
  }

  class _DialogBottomReferensiState extends State<DialogBottomReferensi> {
    List<dynamic> referensiComment = [];
    List<dynamic> referensiCommentTgl = [];
    List<dynamic> referensiCommentCreated = [];
    List<dynamic> referensiCommentStatus = [];

    @override
    void initState() {
      setState(() {
        referensiComment = widget.referensiComment;
        referensiCommentTgl = widget.referensiCommentTgl;
        for (int a = 0; a < widget.referensiCommentCreated.length; a++) {
          Firestore.instance.collection('user').where('id', isEqualTo: widget.referensiCommentCreated[a]).snapshots().listen((data) {
            referensiCommentCreated.add(data.documents[0].data['nama']);
          });
        }
        referensiCommentStatus = widget.referensiCommentStatus;
      });

      super.initState();
    }

    @override
    Widget build(BuildContext context) {
      return Container(
        color: Color(0xFF737373),
        height: MediaQuery.of(context).size.height * 0.5,
        child: Container(
          decoration: BoxDecoration(
            color: AbubaPallate.menuBluebird,
            borderRadius: BorderRadius.only(
              topRight: const Radius.circular(20.0),
              topLeft: const Radius.circular(20.0),
            ),
          ),
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Flexible(
                      child: Text(
                        'Comment History',
                        style: TextStyle(
                          fontSize: 16.0,
                          color: Colors.white,
                          fontWeight: FontWeight.bold
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Container(
                height: MediaQuery.of(context).size.height * 0.5 - 40.0,
                color: Colors.white,
                child: referensiComment.length == 0
                  ? Center(
                      child: Text(
                        'No Data',
                        style: TextStyle(
                          fontSize: 15.0,
                          color: Colors.black87,
                          fontWeight: FontWeight.bold
                        ),
                      ),
                    )
                  : widget.bantu == 'NO'
                      ? Center(
                          child: Text(
                            'No Data',
                            style: TextStyle(
                              fontSize: 15.0,
                              color: Colors.black87,
                              fontWeight: FontWeight.bold
                            ),
                          ),
                        )
                : Column(
                  children: <Widget>[
                    Expanded(
                      child: ListView.builder(
                        physics: ScrollPhysics(),
                        itemCount: referensiComment.length,
                        itemBuilder: (BuildContext context, int index) {
                          Timestamp tglBantu = referensiCommentTgl[index];

                          return ListTile(
                            title: Container(
                              width: MediaQuery.of(context).size.width * 0.6,
                              child: Row(
                                children: <Widget>[
                                  Flexible(
                                    child: Text(
                                      '${index + 1}. ${referensiComment[index]}',
                                      style: TextStyle(
                                        fontSize: 14.0,
                                        color: AbubaPallate.menuBluebird,
                                        fontWeight: FontWeight.w700
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            subtitle: Container(
                              width: MediaQuery.of(context).size.width * 0.6,
                              child: Row(
                                children: <Widget>[
                                  Flexible(
                                    child: Text(
                                      '${referensiCommentCreated[index]} - ${tglBantu.toDate().toString().substring(8, 10)}/${tglBantu.toDate().toString().substring(5, 7)}/${tglBantu.toDate().toString().substring(0, 4)}',
                                      style: TextStyle(
                                        fontSize: 13.0,
                                        color: Colors.black54,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            trailing: Container(
                              width: MediaQuery.of(context).size.width * 0.3,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: <Widget>[
                                  Flexible(
                                    child: Text(
                                      referensiCommentStatus[index],
                                      style: TextStyle(
                                        fontSize: 14.0,
                                        color: referensiCommentStatus[index] == 'NO' ? Colors.redAccent : AbubaPallate.greenabuba,
                                        fontWeight: FontWeight.w500
                                      ),
                                    ),
                                  )
                                ],
                              )
                            ),
                          );
                        }
                      )
                    ),
                  ],
                ),
              )
            ],
          )
        ),
      );
    }
  }

  //history instruksi
   class DialogBottomInstruksi extends StatefulWidget {
    List<dynamic> instruksiComment;
    List<dynamic> instruksiCommentTgl;
    List<dynamic> instruksiCommentStatus;
    List<dynamic> instruksiCommentCreated;
    String bantu;

    DialogBottomInstruksi({this.instruksiComment, this.instruksiCommentStatus, this.bantu, this.instruksiCommentCreated, this.instruksiCommentTgl});
    @override
    _DialogBottomInstruksiState createState() => _DialogBottomInstruksiState();
  }

  class _DialogBottomInstruksiState extends State<DialogBottomInstruksi> {
    List<dynamic> instruksiComment = [];
    List<dynamic> instruksiCommentTgl = [];
    List<dynamic> instruksiCommentCreated = [];
    List<dynamic> instruksiCommentStatus = [];

    @override
    void initState() {
      setState(() {
        instruksiComment = widget.instruksiComment;
        instruksiCommentTgl = widget.instruksiCommentTgl;
        for (int a = 0; a < widget.instruksiCommentCreated.length; a++) {
          Firestore.instance.collection('user').where('id', isEqualTo: widget.instruksiCommentCreated[a]).snapshots().listen((data) {
            instruksiCommentCreated.add(data.documents[0].data['nama']);
          });
        }
        // instruksiCommentCreated = widget.instruksiCommentCreated;
        instruksiCommentStatus = widget.instruksiCommentStatus;
      });

      super.initState();
    }

    @override
    Widget build(BuildContext context) {
      return Container(
        color: Color(0xFF737373),
        height: MediaQuery.of(context).size.height * 0.5,
        child: Container(
          decoration: BoxDecoration(
            color: AbubaPallate.menuBluebird,
            borderRadius: BorderRadius.only(
              topRight: const Radius.circular(20.0),
              topLeft: const Radius.circular(20.0),
            ),
          ),
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Flexible(
                      child: Text(
                        'Comment History',
                        style: TextStyle(
                          fontSize: 16.0,
                          color: Colors.white,
                          fontWeight: FontWeight.bold
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Container(
                height: MediaQuery.of(context).size.height * 0.5 - 40.0,
                color: Colors.white,
                child: instruksiComment.length == 0
                  ? Center(
                      child: Text(
                        'No Data',
                        style: TextStyle(
                          fontSize: 15.0,
                          color: Colors.black87,
                          fontWeight: FontWeight.bold
                        ),
                      ),
                    )
                  : widget.bantu == 'NO'
                      ? Center(
                          child: Text(
                            'No Data',
                            style: TextStyle(
                              fontSize: 15.0,
                              color: Colors.black87,
                              fontWeight: FontWeight.bold
                            ),
                          ),
                        )
                : Column(
                  children: <Widget>[
                    Expanded(
                      child: ListView.builder(
                        physics: ScrollPhysics(),
                        itemCount: instruksiComment.length,
                        itemBuilder: (BuildContext context, int index) {
                          Timestamp tglBantu = instruksiCommentTgl[index];

                          return ListTile(
                            title: Container(
                              width: MediaQuery.of(context).size.width * 0.6,
                              child: Row(
                                children: <Widget>[
                                  Flexible(
                                    child: Text(
                                      '${index + 1}. ${instruksiComment[index]}',
                                      style: TextStyle(
                                        fontSize: 14.0,
                                        color: AbubaPallate.menuBluebird,
                                        fontWeight: FontWeight.w700
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            subtitle: Container(
                              width: MediaQuery.of(context).size.width * 0.6,
                              child: Row(
                                children: <Widget>[
                                  Flexible(
                                    child: Text(
                                      '${instruksiCommentCreated[index]} - ${tglBantu.toDate().toString().substring(8, 10)}/${tglBantu.toDate().toString().substring(5, 7)}/${tglBantu.toDate().toString().substring(0, 4)}',
                                      style: TextStyle(
                                        fontSize: 13.0,
                                        color: Colors.black54,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            trailing: Container(
                              width: MediaQuery.of(context).size.width * 0.3,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: <Widget>[
                                  Flexible(
                                    child: Text(
                                      instruksiCommentStatus[index],
                                      style: TextStyle(
                                        fontSize: 14.0,
                                        color: instruksiCommentStatus[index] == 'NO' ? Colors.redAccent : AbubaPallate.greenabuba,
                                        fontWeight: FontWeight.w500
                                      ),
                                    ),
                                  )
                                ],
                              )
                            ),
                          );
                        }
                      )
                    ),
                  ],
                ),
              )
            ],
          )
        ),
      );
    }
  }

class DetailScreenAreaLuar extends StatefulWidget {
  @override
  _DetailScreenAreaLuarState createState() => _DetailScreenAreaLuarState();
  final String image;

  DetailScreenAreaLuar({this.image});




}

class _DetailScreenAreaLuarState extends State<DetailScreenAreaLuar>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        child: Center(
          child: Hero(
            tag: 'imageHero',
            child: Image.network(
              widget.image.toString(),
            ),
          ),
        ),
        onTap: () {
          Navigator.pop(context);
        },
      ),
    );
  }
}