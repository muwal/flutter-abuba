import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_abuba/constant.dart';
import 'package:flutter_abuba/isoft/operation_page/documentcontrol/beranda_document.dart';
import 'package:video_player/video_player.dart';

class FormDetail extends StatefulWidget {
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
  String bantuistilah;
  String banturisiko;
  String type;
  FormDetail({this.idUser, this.namaUser, this.departmentUser, this.index, this.pJabatan, this.pDocTerkait, this.pDepartment, this.pComment, this.pCommentStatus, this.tujuanCommentCreated, this.istilahCommentCreated, this.referensiCommentCreated, this.ruangLingkupCommentCreated, this.prosedurCommentTgl, this.bantuistilah, this.bantureferensi, this.banturisiko, this.banturuanglingkup, this.bantutujuan, this.risikoCommentCreated, this.type});

  @override
  _FormDetailState createState() => _FormDetailState();
}

class _FormDetailState extends State<FormDetail> with TickerProviderStateMixin {
  AnimationController animationController;

  String noDoc;
  int revisi = 0;
  String judulDoc;
  String tujuanDeskripsi;
  String rLingkupDeskripsi;
  String referensiDeskripsi;
  List<dynamic> istilahDeskripsi = [];
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

  bool isProcess = false;

  List<dynamic> tujuanComment = [];
  List<dynamic> tujuanCommentTgl = [];
  List<String> tujuanCommentCreated = [];

  List<dynamic> ruangLingkupComment = [];
  List<dynamic> ruangLingkupCommentTgl = [];
  List<String> ruangLingkupCommentCreated = [];

  List<dynamic> referensiComment = [];
  List<dynamic> referensiCommentTgl = [];
  List<String> referensiCommentCreated = [];

  List<dynamic> istilahComment = [];
  List<dynamic> istilahCommentTgl = [];
  List<String> istilahCommentCreated = [];

  List<dynamic> risikoComment = [];
  List<dynamic> risikoCommentTgl = [];
  List<String> risikoCommentCreated = [];

  List<dynamic> prosedurComment = [];
  List<dynamic> prosedurCommentCreated = [];
  
  var tujuanCommentStatus = [];
  var ruangLingkupCommentStatus = [];
  var referensiCommentStatus = [];
  var istilahCommentStatus = [];
  var risikoCommentStatus = [];
  var prosedurCommentStatus = [];

  var catatanRevisiNo = [];
  var catatanRevisiTgl = [];
  var catatanRevisiDeskripsi = [];

  var bantua = [];
  var bantuc = [];
  var bantug = [];

  List<String> option = [];

  VideoPlayerController _controller;
  Future<void> _initializeVideoPlayerFuture;

  @override
  void initState() {
    super.initState();

    Firestore.instance.collection('docControl').document(widget.index).snapshots().listen((data) {
      setState(() {
        noDoc = data.data['noDoc'];
        judulDoc = data.data['judul'];
        revisi = data.data['lastRevisi'];

        tujuanComment = data.data['tujuanComment'];
        tujuanCommentTgl = data.data['tujuanCommentTgl'];
        tujuanCommentStatus = List<dynamic>.from(data.data['tujuanCommentStatus']);

        ruangLingkupComment = data.data['rLingkupComment'];
        ruangLingkupCommentTgl = data.data['rLingkupCommentTgl'];
        ruangLingkupCommentStatus = List<dynamic>.from(data.data['rLingkupCommentStatus']);
        
        referensiComment = data.data['referensiComment'];
        referensiCommentTgl = data.data['referensiCommentTgl'];
        referensiCommentStatus = List<dynamic>.from(data.data['referensiCommentStatus']);

        istilahComment = data.data['istilahComment'];
        istilahCommentTgl = data.data['istilahCommentTgl'];
        istilahCommentStatus = List<dynamic>.from(data.data['istilahCommentStatus']);

        risikoComment = data.data['risikoComment'];
        risikoCommentTgl = data.data['risikoCommentTgl'];
        risikoCommentStatus = List<dynamic>.from(data.data['risikoCommentStatus']);

        tujuanDeskripsi = data.data['tujuanDeskripsi'];
        rLingkupDeskripsi = data.data['rLingkupDeskripsi'];
        referensiDeskripsi = data.data['referensiDeskripsi'];
        istilahDeskripsi = data.data['istilahDeskripsi'];
        risikoDeskripsi = data.data['risikoDeskripsi'];
        revisiNo = List<dynamic>.from(data.data['revisiNo']);
        revisiTgl = List<dynamic>.from(data.data['revisiTgl']);
        revisiDeskripsi = List<dynamic>.from(data.data['revisiDetail']);

        catatanRevisiNo = List<dynamic>.from(data.data['revisiNo']);
        Timestamp bantuTglPre = data.data['revisiTgl'][0];
        catatanRevisiTgl.add(bantuTglPre.toDate());
        catatanRevisiDeskripsi = List<dynamic>.from(data.data['revisiDetail']);

        if (data.data['type'] == 'doc') {
          prosedurComment = data.data['p_Comment'];
          prosedurCommentCreated = data.data['p_CommentCreated'];
          prosedurCommentStatus = List<dynamic>.from(data.data['p_CommentStatus']);

          pTugas = data.data['p_tugas'];
          pDocTerkaitType = data.data['p_docTerkaitType'];
          pDocTerkait = data.data['p_docTerkait'];
          pKeterangan = data.data['p_keterangan'];
          pAction = data.data['p_action'];
          pActionTo = data.data['p_actionTo'];

          pDepartment = data.data['p_department'];
          pJabatan = data.data['p_jabatan'];
          
          _controller = null;
          _initializeVideoPlayerFuture = _controller.initialize();
          _controller.setLooping(false);
        } else {
          _controller = VideoPlayerController.network(data.data['urlVideo']);
          _initializeVideoPlayerFuture = _controller.initialize();
          _controller.setLooping(true);
          
          prosedurComment = [];
          prosedurCommentStatus = [];
          prosedurCommentCreated = [];

          pTugas = [];
          pDocTerkaitType = [];
          pDocTerkait = [];
          pKeterangan = [];
          pAction = [];
          pActionTo = [];

          pDepartment = [];
          pJabatan = [];
        }
      });
    });

    if (widget.bantutujuan == 'YES') {
    for (int z = 0; z < widget.tujuanCommentCreated.length; z++) {
      Firestore.instance.collection('user').where('id', isEqualTo: widget.tujuanCommentCreated[z]).snapshots().listen((data14) {
        setState(() {
          tujuanCommentCreated.add(data14.documents[0].data['nama']);
        });
      });
    }
    }

    if (widget.banturuanglingkup == 'YES') {
    for (int x = 0; x < widget.ruangLingkupCommentCreated.length; x++) {
      Firestore.instance.collection('user').where('id', isEqualTo: widget.ruangLingkupCommentCreated[x]).snapshots().listen((data14) {
        setState(() {
          ruangLingkupCommentCreated.add(data14.documents[0].data['nama']);
        });
      });
    }
    }

    if (widget.bantureferensi == 'YES') {
    for (int y = 0; y < widget.referensiCommentCreated.length; y++) {
      Firestore.instance.collection('user').where('id', isEqualTo: widget.referensiCommentCreated[y]).snapshots().listen((data14) {
        setState(() {
          referensiCommentCreated.add(data14.documents[0].data['nama']);
        });
      });
    }
    }

    if (widget.bantuistilah == 'YES') {
    for (int w = 0; w < widget.istilahCommentCreated.length; w++) {
      Firestore.instance.collection('user').where('id', isEqualTo: widget.istilahCommentCreated[w]).snapshots().listen((data14) {
        setState(() {
          istilahCommentCreated.add(data14.documents[0].data['nama']);
        });
      });
    }
    }

    if (widget.banturisiko == 'YES') {
    for (int w = 0; w < widget.risikoCommentCreated.length; w++) {
      Firestore.instance.collection('user').where('id', isEqualTo: widget.risikoCommentCreated[w]).snapshots().listen((data14) {
        setState(() {
          risikoCommentCreated.add(data14.documents[0].data['nama']);
        });
      });
    }
    }

    if (widget.type == 'doc') {
      for (int i = 0; i < widget.pJabatan.length; i++) {
        option.add('kosong');
      };
    } else {
      option.add('kosong');
    }

    if (widget.type == 'doc') {
      for (int a = 0; a < widget.pComment.length; a++) {
        bantua.add([]);
        bantuc.add([]);
        bantug.add([]);
        var bantub = widget.pComment[a].toString().split('!@##');
        var bantud = widget.pCommentStatus[a].toString().split('!@##');
        List<dynamic> bantuh = widget.prosedurCommentTgl[a].toString().split('!@##');
        bantua[bantua.length - 1] = bantub;
        bantuc[bantuc.length - 1] = bantud;
        bantug[bantug.length - 1] = bantuh;
      }
    } else {
      bantua.add([]);
      bantuc.add([]);
      bantug.add([]);
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
                          child: Center(
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
                                        color: Colors.black38,
                                        fontWeight: FontWeight.bold
                                      ),
                                    ),
                                  ),
                                ),
                                Flexible(
                                  child: Padding(
                                    padding: const EdgeInsets.all(12.0),
                                    child: Tooltip(
                                      message: judulDoc.toUpperCase(),
                                      child: RichText(
                                        softWrap: true,
                                        overflow: TextOverflow.ellipsis,
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
                                          ]
                                        )
                                      ),
                                    )
                                  ),
                                ),
                              ],
                            ),
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
                                        'I. TUJUAN',
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
                                        tujuanDeskripsi,
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
                                          showModalBottomSheet(
                                            context: context,
                                            builder: (builder) {
                                              return DialogBottomTujuan(
                                                tujuanComment: tujuanComment,
                                                tujuanCommentStatus: tujuanCommentStatus,
                                                tujuanCommentCreated: tujuanCommentCreated,
                                                tujuanCommentTgl: tujuanCommentTgl,
                                                onResult: (value) {
                                                  setState(() {
                                                    if (value[0] == 'YES') {
                                                      if (catatanRevisiNo.length == 0) {
                                                        catatanRevisiNo.add(1);
                                                        catatanRevisiTgl.add(DateTime.now());
                                                        catatanRevisiDeskripsi.add(value[1]);
                                                      } else {
                                                        var bantu10 = catatanRevisiDeskripsi[0].toString().split('!@##');
                                                        bantu10.add(value[1]);
                                                        var bantu = bantu10.join('!@##');
                                                        catatanRevisiDeskripsi.clear();
                                                        catatanRevisiDeskripsi.add(bantu);
                                                      }
                                                    }

                                                    print(catatanRevisiNo);
                                                    print(catatanRevisiDeskripsi);
                                                    print(catatanRevisiTgl);
                                                  });
                                                },
                                              );
                                            }
                                          ).then((value) {
                                            print('berhasil');
                                          });
                                        }
                                      ),
                                    ),
                                  ],
                                )
                              ),
                              // Padding(
                              //   padding: const EdgeInsets.only(bottom: 10.0, left: 20, right: 20),
                              //   child: Column(
                              //     children: List.generate(tujuanComment.length, (index) {
                              //       return ListTile(
                              //         title: Container(
                              //           width: MediaQuery.of(context).size.width * 0.6,
                              //           child: Row(
                              //             children: <Widget>[
                              //               Flexible(
                              //                 child: Text(
                              //                   '${index + 1}. ${tujuanComment[index]}',
                              //                   style: TextStyle(
                              //                     fontSize: 14.0,
                              //                     color: AbubaPallate.menuBluebird,
                              //                     fontWeight: FontWeight.w500
                              //                   ),
                              //                 ),
                              //               )
                              //             ],
                              //           ),
                              //         ),
                              //         trailing: Container(
                              //           width: MediaQuery.of(context).size.width * 0.3,
                              //           child: tujuanCommentStatus[index] == 'OPEN'
                              //             ? Row(
                              //                 children: <Widget>[
                              //                   ButtonTheme(
                              //                     minWidth: 50.0,
                              //                     height: 30.0,
                              //                     child: OutlineButton(
                              //                       child: Text(
                              //                         'NO',
                              //                         style: TextStyle(fontSize: 13.0, color: Colors.redAccent),
                              //                       ),
                              //                       borderSide: BorderSide(color: Colors.redAccent, width: 1.0),
                              //                       highlightedBorderColor: Colors.redAccent,
                              //                       onPressed: () {
                              //                         setState(() {
                              //                           tujuanCommentStatus[index] = 'NO';
                              //                         });
                              //                       }
                              //                     ),
                              //                   ),
                              //                   SizedBox(
                              //                     width: 5.0,
                              //                   ),
                              //                   ButtonTheme(
                              //                     minWidth: 50.0,
                              //                     height: 30.0,
                              //                     child: OutlineButton(
                              //                       child: Text(
                              //                         'YES',
                              //                         style: TextStyle(fontSize: 13.0, color: AbubaPallate.greenabuba),
                              //                       ),
                              //                       borderSide: BorderSide(color: AbubaPallate.greenabuba, width: 1.0),
                              //                       highlightedBorderColor: AbubaPallate.greenabuba,
                              //                       onPressed: () {
                              //                         setState(() {
                              //                           tujuanCommentStatus[index] = 'YES';
                              //                           if (catatanRevisiNo.length == 0) {
                              //                             catatanRevisiNo.add(1);
                              //                             catatanRevisiTgl.add(DateTime.now());
                              //                             catatanRevisiDeskripsi.add(tujuanComment[index]);
                              //                           } else {
                              //                             var bantu10 = catatanRevisiDeskripsi[0].toString().split('!@##');
                              //                             bantu10.add(tujuanComment[index]);
                              //                             var bantu = bantu10.join('!@##');
                              //                             catatanRevisiDeskripsi.clear();
                              //                             catatanRevisiDeskripsi.add(bantu);
                              //                           }

                              //                           print(catatanRevisiNo);
                              //                           print(catatanRevisiDeskripsi);
                              //                           print(catatanRevisiTgl);
                              //                         });
                              //                       }
                              //                     ),
                              //                   )
                              //                 ],
                              //               )
                              //             : Row(
                              //                 mainAxisAlignment: MainAxisAlignment.end,
                              //                 children: <Widget>[
                              //                   Flexible(
                              //                     child: Text(
                              //                       tujuanCommentStatus[index],
                              //                       style: TextStyle(
                              //                         fontSize: 14.0,
                              //                         color: tujuanCommentStatus[index] == 'NO' ? Colors.redAccent : AbubaPallate.greenabuba,
                              //                         fontWeight: FontWeight.w500
                              //                       ),
                              //                     ),
                              //                   )
                              //                 ],
                              //               )
                              //         ),
                              //       );
                              //     }).toList()
                              //   )
                              // )
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
                                        'II. RUANG LINGKUP',
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
                                        rLingkupDeskripsi,
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
                                          showModalBottomSheet(
                                            context: context,
                                            builder: (builder) {
                                              return DialogBottomRuangLingkup(
                                                ruangLingkupComment: ruangLingkupComment,
                                                ruangLingkupCommentStatus: ruangLingkupCommentStatus,
                                                ruangLingkupCommentCreated: ruangLingkupCommentCreated,
                                                ruangLingkupCommentTgl: ruangLingkupCommentTgl,
                                                onResult: (value) {
                                                  setState(() {
                                                    if (value[0] == 'YES') {
                                                      if (catatanRevisiNo.length == 0) {
                                                        catatanRevisiNo.add(1);
                                                        catatanRevisiTgl.add(DateTime.now());
                                                        catatanRevisiDeskripsi.add(value[1]);
                                                      } else {
                                                        var bantu10 = catatanRevisiDeskripsi[0].toString().split('!@##');
                                                        bantu10.add(value[1]);
                                                        var bantu = bantu10.join('!@##');
                                                        catatanRevisiDeskripsi.clear();
                                                        catatanRevisiDeskripsi.add(bantu);
                                                      }
                                                    }

                                                    print(catatanRevisiNo);
                                                    print(catatanRevisiDeskripsi);
                                                    print(catatanRevisiTgl);
                                                  });
                                                },
                                              );
                                            }
                                          ).then((value) {
                                            print('berhasil');
                                          });
                                        }
                                      ),
                                    ),
                                  ],
                                )
                              ),
                              // Padding(
                              //   padding: EdgeInsets.only(bottom: 10.0, left: 20.0, right: 20.0),
                              //   child: Column(
                              //     children: List.generate(ruangLingkupComment.length, (index) {
                              //       return ListTile(
                              //         title: Container(
                              //           width: MediaQuery.of(context).size.width * 0.6,
                              //           child: Row(
                              //             children: <Widget>[
                              //               Flexible(
                              //                 child: Text(
                              //                   '${index + 1}. ${ruangLingkupComment[index]}',
                              //                   style: TextStyle(
                              //                     fontSize: 14.0,
                              //                     color: AbubaPallate.menuBluebird,
                              //                     fontWeight: FontWeight.w500
                              //                   ),
                              //                 ),
                              //               )
                              //             ],
                              //           ),
                              //         ),
                              //         trailing: Container(
                              //           width: MediaQuery.of(context).size.width * 0.3,
                              //           child: ruangLingkupCommentStatus[index] == 'OPEN'
                              //             ? Row(
                              //                 children: <Widget>[
                              //                   ButtonTheme(
                              //                     minWidth: 50.0,
                              //                     height: 30.0,
                              //                     child: OutlineButton(
                              //                       child: Text(
                              //                         'NO',
                              //                         style: TextStyle(fontSize: 13.0, color: Colors.redAccent),
                              //                       ),
                              //                       borderSide: BorderSide(color: Colors.redAccent, width: 1.0),
                              //                       highlightedBorderColor: Colors.redAccent,
                              //                       onPressed: () {
                              //                         setState(() {
                              //                           ruangLingkupCommentStatus[index] = 'NO';
                              //                         });
                              //                       }
                              //                     ),
                              //                   ),
                              //                   SizedBox(
                              //                     width: 5.0,
                              //                   ),
                              //                   ButtonTheme(
                              //                     minWidth: 50.0,
                              //                     height: 30.0,
                              //                     child: OutlineButton(
                              //                       child: Text(
                              //                         'YES',
                              //                         style: TextStyle(fontSize: 13.0, color: AbubaPallate.greenabuba),
                              //                       ),
                              //                       borderSide: BorderSide(color: AbubaPallate.greenabuba, width: 1.0),
                              //                       highlightedBorderColor: AbubaPallate.greenabuba,
                              //                       onPressed: () {
                              //                         setState(() {
                              //                           ruangLingkupCommentStatus[index] = 'YES';
                              //                           if (catatanRevisiNo.length == 0) {
                              //                             catatanRevisiNo.add(1);
                              //                             catatanRevisiTgl.add(DateTime.now());
                              //                             catatanRevisiDeskripsi.add(ruangLingkupComment[index]);
                              //                           } else {
                              //                             var bantu10 = catatanRevisiDeskripsi[0].toString().split('!@##');
                              //                             bantu10.add(ruangLingkupComment[index]);
                              //                             var bantu = bantu10.join('!@##');
                              //                             catatanRevisiDeskripsi.clear();
                              //                             catatanRevisiDeskripsi.add(bantu);
                              //                           }

                              //                           print(catatanRevisiNo);
                              //                           print(catatanRevisiDeskripsi);
                              //                           print(catatanRevisiTgl);
                              //                         });
                              //                       }
                              //                     ),
                              //                   )
                              //                 ],
                              //               )
                              //             : Row(
                              //                 mainAxisAlignment: MainAxisAlignment.end,
                              //                 children: <Widget>[
                              //                   Flexible(
                              //                     child: Text(
                              //                       ruangLingkupCommentStatus[index],
                              //                       style: TextStyle(
                              //                         fontSize: 14.0,
                              //                         color: ruangLingkupCommentStatus[index] == 'NO' ? Colors.redAccent : AbubaPallate.greenabuba,
                              //                         fontWeight: FontWeight.w500
                              //                       ),
                              //                     ),
                              //                   )
                              //                 ],
                              //               )
                              //         ),
                              //       );
                              //     }).toList()
                              //   )
                              // )
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
                                        'III. REFERENSI',
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
                                          showModalBottomSheet(
                                            context: context,
                                            builder: (builder) {
                                              return DialogBottomReferensi(
                                                referensiComment: referensiComment,
                                                referensiCommentStatus: referensiCommentStatus,
                                                referensiCommentCreated: referensiCommentCreated,
                                                referensiCommentTgl: referensiCommentTgl,
                                                onResult: (value) {
                                                  setState(() {
                                                    if (value[0] == 'YES') {
                                                      if (catatanRevisiNo.length == 0) {
                                                        catatanRevisiNo.add(1);
                                                        catatanRevisiTgl.add(DateTime.now());
                                                        catatanRevisiDeskripsi.add(value[1]);
                                                      } else {
                                                        var bantu10 = catatanRevisiDeskripsi[0].toString().split('!@##');
                                                        bantu10.add(value[1]);
                                                        var bantu = bantu10.join('!@##');
                                                        catatanRevisiDeskripsi.clear();
                                                        catatanRevisiDeskripsi.add(bantu);
                                                      }
                                                    }

                                                    print(catatanRevisiNo);
                                                    print(catatanRevisiDeskripsi);
                                                    print(catatanRevisiTgl);
                                                  });
                                                },
                                              );
                                            }
                                          ).then((value) {
                                            print('berhasil');
                                          });
                                        }
                                      ),
                                    ),
                                  ],
                                )
                              ),
                              // Padding(
                              //   padding: EdgeInsets.only(bottom: 10.0, left: 20.0, right: 20.0),
                              //   child: Column(
                              //     children: List.generate(referensiComment.length, (index) {
                              //       return ListTile(
                              //         title: Container(
                              //           width: MediaQuery.of(context).size.width * 0.6,
                              //           child: Row(
                              //             children: <Widget>[
                              //               Flexible(
                              //                 child: Text(
                              //                   '${index + 1}. ${referensiComment[index]}',
                              //                   style: TextStyle(
                              //                     fontSize: 14.0,
                              //                     color: AbubaPallate.menuBluebird,
                              //                     fontWeight: FontWeight.w500
                              //                   ),
                              //                 ),
                              //               )
                              //             ],
                              //           ),
                              //         ),
                              //         trailing: Container(
                              //           width: MediaQuery.of(context).size.width * 0.3,
                              //           child: referensiCommentStatus[index] == 'OPEN'
                              //             ? Row(
                              //                 children: <Widget>[
                              //                   ButtonTheme(
                              //                     minWidth: 50.0,
                              //                     height: 30.0,
                              //                     child: OutlineButton(
                              //                       child: Text(
                              //                         'NO',
                              //                         style: TextStyle(fontSize: 13.0, color: Colors.redAccent),
                              //                       ),
                              //                       borderSide: BorderSide(color: Colors.redAccent, width: 1.0),
                              //                       highlightedBorderColor: Colors.redAccent,
                              //                       onPressed: () {
                              //                         setState(() {
                              //                           referensiCommentStatus[index] = 'NO';
                              //                         });
                              //                       }
                              //                     ),
                              //                   ),
                              //                   SizedBox(
                              //                     width: 5.0,
                              //                   ),
                              //                   ButtonTheme(
                              //                     minWidth: 50.0,
                              //                     height: 30.0,
                              //                     child: OutlineButton(
                              //                       child: Text(
                              //                         'YES',
                              //                         style: TextStyle(fontSize: 13.0, color: AbubaPallate.greenabuba),
                              //                       ),
                              //                       borderSide: BorderSide(color: AbubaPallate.greenabuba, width: 1.0),
                              //                       highlightedBorderColor: AbubaPallate.greenabuba,
                              //                       onPressed: () {
                              //                         setState(() {
                              //                           referensiCommentStatus[index] = 'YES';
                              //                           if (catatanRevisiNo.length == 0) {
                              //                             catatanRevisiNo.add(1);
                              //                             catatanRevisiTgl.add(DateTime.now());
                              //                             catatanRevisiDeskripsi.add(referensiComment[index]);
                              //                           } else {
                              //                             var bantu10 = catatanRevisiDeskripsi[0].toString().split('!@##');
                              //                             bantu10.add(referensiComment[index]);
                              //                             var bantu = bantu10.join('!@##');
                              //                             catatanRevisiDeskripsi.clear();
                              //                             catatanRevisiDeskripsi.add(bantu);
                              //                           }

                              //                           print(catatanRevisiNo);
                              //                           print(catatanRevisiDeskripsi);
                              //                           print(catatanRevisiTgl);
                              //                         });
                              //                       }
                              //                     ),
                              //                   )
                              //                 ],
                              //               )
                              //             : Row(
                              //                 mainAxisAlignment: MainAxisAlignment.end,
                              //                 children: <Widget>[
                              //                   Flexible(
                              //                     child: Text(
                              //                       referensiCommentStatus[index],
                              //                       style: TextStyle(
                              //                         fontSize: 14.0,
                              //                         color: referensiCommentStatus[index] == 'NO' ? Colors.redAccent : AbubaPallate.greenabuba,
                              //                         fontWeight: FontWeight.w500
                              //                       ),
                              //                     ),
                              //                   )
                              //                 ],
                              //               )
                              //         ),
                              //       );
                              //     }).toList()
                              //   )
                              // )
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
                                        'IV. ISTILAH',
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
                                  children: List.generate(istilahDeskripsi.length, (index) {
                                    return Padding(
                                      padding: const EdgeInsets.only(top: 5.0, bottom: 5.0),
                                      child: Row(
                                        children: <Widget>[
                                          Flexible(
                                            child: Text(
                                              '${index + 1}. ${istilahDeskripsi[index].toString()}',
                                              style: TextStyle(
                                                fontSize: 14.0,
                                                color: Colors.black38,
                                                fontWeight: FontWeight.w500
                                              ),
                                            ),
                                          )
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
                                              return DialogBottomIstilah(
                                                istilahComment: istilahComment,
                                                istilahCommentStatus: istilahCommentStatus,
                                                istilahCommentCreated: istilahCommentCreated,
                                                istilahCommentTgl: istilahCommentTgl,
                                                onResult: (value) {
                                                  setState(() {
                                                    if (value[0] == 'YES') {
                                                      if (catatanRevisiNo.length == 0) {
                                                        catatanRevisiNo.add(1);
                                                        catatanRevisiTgl.add(DateTime.now());
                                                        catatanRevisiDeskripsi.add(value[1]);
                                                      } else {
                                                        var bantu10 = catatanRevisiDeskripsi[0].toString().split('!@##');
                                                        bantu10.add(value[1]);
                                                        var bantu = bantu10.join('!@##');
                                                        catatanRevisiDeskripsi.clear();
                                                        catatanRevisiDeskripsi.add(bantu);
                                                      }
                                                    }

                                                    print(catatanRevisiNo);
                                                    print(catatanRevisiDeskripsi);
                                                    print(catatanRevisiTgl);
                                                  });
                                                },
                                              );
                                            }
                                          ).then((value) {
                                            print('berhasil');
                                          });
                                        }
                                      ),
                                    ),
                                  ],
                                )
                              ),
                              // Padding(
                              //   padding: EdgeInsets.only(bottom: 10.0, left: 20.0, right: 20.0),
                              //   child: Column(
                              //     children: List.generate(istilahComment.length, (index) {
                              //       return ListTile(
                              //         title: Container(
                              //           width: MediaQuery.of(context).size.width * 0.6,
                              //           child: Row(
                              //             children: <Widget>[
                              //               Flexible(
                              //                 child: Text(
                              //                   '${index + 1}. ${istilahComment[index]}',
                              //                   style: TextStyle(
                              //                     fontSize: 14.0,
                              //                     color: AbubaPallate.menuBluebird,
                              //                     fontWeight: FontWeight.w500
                              //                   ),
                              //                 ),
                              //               )
                              //             ],
                              //           ),
                              //         ),
                              //         trailing: Container(
                              //           width: MediaQuery.of(context).size.width * 0.3,
                              //           child: istilahCommentStatus[index] == 'OPEN'
                              //             ? Row(
                              //                 children: <Widget>[
                              //                   ButtonTheme(
                              //                     minWidth: 50.0,
                              //                     height: 30.0,
                              //                     child: OutlineButton(
                              //                       child: Text(
                              //                         'NO',
                              //                         style: TextStyle(fontSize: 13.0, color: Colors.redAccent),
                              //                       ),
                              //                       borderSide: BorderSide(color: Colors.redAccent, width: 1.0),
                              //                       highlightedBorderColor: Colors.redAccent,
                              //                       onPressed: () {
                              //                         setState(() {
                              //                           istilahCommentStatus[index] = 'NO';
                              //                         });
                              //                       }
                              //                     ),
                              //                   ),
                              //                   SizedBox(
                              //                     width: 5.0,
                              //                   ),
                              //                   ButtonTheme(
                              //                     minWidth: 50.0,
                              //                     height: 30.0,
                              //                     child: OutlineButton(
                              //                       child: Text(
                              //                         'YES',
                              //                         style: TextStyle(fontSize: 13.0, color: AbubaPallate.greenabuba),
                              //                       ),
                              //                       borderSide: BorderSide(color: AbubaPallate.greenabuba, width: 1.0),
                              //                       highlightedBorderColor: AbubaPallate.greenabuba,
                              //                       onPressed: () {
                              //                         setState(() {
                              //                           istilahCommentStatus[index] = 'YES';
                              //                           if (catatanRevisiNo.length == 0) {
                              //                             catatanRevisiNo.add(1);
                              //                             catatanRevisiTgl.add(DateTime.now());
                              //                             catatanRevisiDeskripsi.add(istilahComment[index]);
                              //                           } else {
                              //                             var bantu10 = catatanRevisiDeskripsi[0].toString().split('!@##');
                              //                             bantu10.add(istilahComment[index]);
                              //                             var bantu = bantu10.join('!@##');
                              //                             catatanRevisiDeskripsi.clear();
                              //                             catatanRevisiDeskripsi.add(bantu);
                              //                           }

                              //                           print(catatanRevisiNo);
                              //                           print(catatanRevisiDeskripsi);
                              //                           print(catatanRevisiTgl);
                              //                         });
                              //                       }
                              //                     ),
                              //                   )
                              //                 ],
                              //               )
                              //             : Row(
                              //                 mainAxisAlignment: MainAxisAlignment.end,
                              //                 children: <Widget>[
                              //                   Flexible(
                              //                     child: Text(
                              //                       istilahCommentStatus[index],
                              //                       style: TextStyle(
                              //                         fontSize: 14.0,
                              //                         color: istilahCommentStatus[index] == 'NO' ? Colors.redAccent : AbubaPallate.greenabuba,
                              //                         fontWeight: FontWeight.w500
                              //                       ),
                              //                     ),
                              //                   )
                              //                 ],
                              //               )
                              //         ),
                              //       );
                              //     }).toList()
                              //   )
                              // )
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
                                        'V. CATATAN REVISI',
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
                                  children: catatanRevisiNo.length == 0
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
                                    : List.generate(catatanRevisiNo.length, (index2) {
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
                                                        'Tanggal Revisi',
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
                                                    'REV ${catatanRevisiNo[index2].toString().padLeft(2, '0')}',
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
                                                      var bantuDetail = catatanRevisiDeskripsi[index2].toString().split('!@##');

                                                      showModalBottomSheet(
                                                        context: context,
                                                        builder: (builder) {
                                                          return Container(
                                                            color: Color(0xFF737373),
                                                            height: MediaQuery.of(context).size.height * 0.5,
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
                                                                    height: MediaQuery.of(context).size.height * 0.5 - 46.0,
                                                                    padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 20.0),
                                                                    child: Column(
                                                                      children: <Widget>[
                                                                        Expanded(
                                                                          child: ListView(
                                                                            physics: ScrollPhysics(),
                                                                            children: List.generate(bantuDetail.length, (index3) {
                                                                              return Padding(
                                                                                padding: const EdgeInsets.only(top: 5.0, bottom: 5.0),
                                                                                child: Row(
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
                                                                                ),
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
                                                      catatanRevisiTgl[index2].toString().substring(8, 10) + '/' + catatanRevisiTgl[index2].toString().substring(5, 7) + '/' +catatanRevisiTgl[index2].toString().substring(0, 4),
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
                        // risiko sini taro
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
                                        'VI. RISIKO',
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
                                  children: List.generate(risikoDeskripsi.length, (index) {
                                    return Padding(
                                      padding: const EdgeInsets.only(top: 5.0, bottom: 5.0),
                                      child: Row(
                                        children: <Widget>[
                                          Flexible(
                                            child: Text(
                                              '${index + 1}. ${risikoDeskripsi[index].toString()}',
                                              style: TextStyle(
                                                fontSize: 14.0,
                                                color: Colors.black38,
                                                fontWeight: FontWeight.w500
                                              ),
                                            ),
                                          )
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
                                              return DialogBottomRisiko(
                                                risikoComment: risikoComment,
                                                risikoCommentStatus: risikoCommentStatus,
                                                risikoCommentCreated: risikoCommentCreated,
                                                risikoCommentTgl: risikoCommentTgl,
                                                onResult: (value) {
                                                  setState(() {
                                                    if (value[0] == 'YES') {
                                                      if (catatanRevisiNo.length == 0) {
                                                        catatanRevisiNo.add(1);
                                                        catatanRevisiTgl.add(DateTime.now());
                                                        catatanRevisiDeskripsi.add(value[1]);
                                                      } else {
                                                        var bantu10 = catatanRevisiDeskripsi[0].toString().split('!@##');
                                                        bantu10.add(value[1]);
                                                        var bantu = bantu10.join('!@##');
                                                        catatanRevisiDeskripsi.clear();
                                                        catatanRevisiDeskripsi.add(bantu);
                                                      }
                                                    }

                                                    print(catatanRevisiNo);
                                                    print(catatanRevisiDeskripsi);
                                                    print(catatanRevisiTgl);
                                                  });
                                                },
                                              );
                                            }
                                          ).then((value) {
                                            print('berhasil');
                                          });
                                        }
                                      ),
                                    ),
                                  ],
                                )
                              ),
                              // Padding(
                              //   padding: EdgeInsets.only(bottom: 10.0, left: 20.0, right: 20.0),
                              //   child: Column(
                              //     children: List.generate(istilahComment.length, (index) {
                              //       return ListTile(
                              //         title: Container(
                              //           width: MediaQuery.of(context).size.width * 0.6,
                              //           child: Row(
                              //             children: <Widget>[
                              //               Flexible(
                              //                 child: Text(
                              //                   '${index + 1}. ${istilahComment[index]}',
                              //                   style: TextStyle(
                              //                     fontSize: 14.0,
                              //                     color: AbubaPallate.menuBluebird,
                              //                     fontWeight: FontWeight.w500
                              //                   ),
                              //                 ),
                              //               )
                              //             ],
                              //           ),
                              //         ),
                              //         trailing: Container(
                              //           width: MediaQuery.of(context).size.width * 0.3,
                              //           child: istilahCommentStatus[index] == 'OPEN'
                              //             ? Row(
                              //                 children: <Widget>[
                              //                   ButtonTheme(
                              //                     minWidth: 50.0,
                              //                     height: 30.0,
                              //                     child: OutlineButton(
                              //                       child: Text(
                              //                         'NO',
                              //                         style: TextStyle(fontSize: 13.0, color: Colors.redAccent),
                              //                       ),
                              //                       borderSide: BorderSide(color: Colors.redAccent, width: 1.0),
                              //                       highlightedBorderColor: Colors.redAccent,
                              //                       onPressed: () {
                              //                         setState(() {
                              //                           istilahCommentStatus[index] = 'NO';
                              //                         });
                              //                       }
                              //                     ),
                              //                   ),
                              //                   SizedBox(
                              //                     width: 5.0,
                              //                   ),
                              //                   ButtonTheme(
                              //                     minWidth: 50.0,
                              //                     height: 30.0,
                              //                     child: OutlineButton(
                              //                       child: Text(
                              //                         'YES',
                              //                         style: TextStyle(fontSize: 13.0, color: AbubaPallate.greenabuba),
                              //                       ),
                              //                       borderSide: BorderSide(color: AbubaPallate.greenabuba, width: 1.0),
                              //                       highlightedBorderColor: AbubaPallate.greenabuba,
                              //                       onPressed: () {
                              //                         setState(() {
                              //                           istilahCommentStatus[index] = 'YES';
                              //                           if (catatanRevisiNo.length == 0) {
                              //                             catatanRevisiNo.add(1);
                              //                             catatanRevisiTgl.add(DateTime.now());
                              //                             catatanRevisiDeskripsi.add(istilahComment[index]);
                              //                           } else {
                              //                             var bantu10 = catatanRevisiDeskripsi[0].toString().split('!@##');
                              //                             bantu10.add(istilahComment[index]);
                              //                             var bantu = bantu10.join('!@##');
                              //                             catatanRevisiDeskripsi.clear();
                              //                             catatanRevisiDeskripsi.add(bantu);
                              //                           }

                              //                           print(catatanRevisiNo);
                              //                           print(catatanRevisiDeskripsi);
                              //                           print(catatanRevisiTgl);
                              //                         });
                              //                       }
                              //                     ),
                              //                   )
                              //                 ],
                              //               )
                              //             : Row(
                              //                 mainAxisAlignment: MainAxisAlignment.end,
                              //                 children: <Widget>[
                              //                   Flexible(
                              //                     child: Text(
                              //                       istilahCommentStatus[index],
                              //                       style: TextStyle(
                              //                         fontSize: 14.0,
                              //                         color: istilahCommentStatus[index] == 'NO' ? Colors.redAccent : AbubaPallate.greenabuba,
                              //                         fontWeight: FontWeight.w500
                              //                       ),
                              //                     ),
                              //                   )
                              //                 ],
                              //               )
                              //         ),
                              //       );
                              //     }).toList()
                              //   )
                              // )
                            ],
                          ),
                        ),
                        widget.type == 'doc'
                          ? Container(
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
                                        'VII. PROSEDUR',
                                        style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold, color: Colors.black87)
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            children: <Widget>[
                              Column(
                                children: List.generate(pTugas.length, (index) {
                                  return Container(
                                    padding: EdgeInsets.only(left: 10.0, right: 10.0, bottom: 10.0),
                                    child: Card(
                                      elevation: 1.0,
                                      child: Container(
                                        color: Colors.white,
                                        padding: EdgeInsets.symmetric(vertical: 15.0),
                                        child: Column(
                                          children: <Widget>[
                                            Row(
                                              children: <Widget>[
                                                Expanded(
                                                  child: Padding(
                                                    padding: const EdgeInsets.all(10.0),
                                                    child: Column(
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: <Widget>[
                                                        Row(
                                                          mainAxisAlignment: MainAxisAlignment.start,
                                                          children: <Widget>[
                                                            Flexible(
                                                              child: Text(
                                                                '${index + 1}. ${pJabatan[index].toString().toUpperCase()} - ${pDepartment[index].toString().toUpperCase()}',
                                                                style: TextStyle(
                                                                  fontSize: 15.0,
                                                                  fontWeight: FontWeight.w700,
                                                                  color: Colors.black87
                                                                ),
                                                              ),
                                                            )
                                                          ],
                                                        ),
                                                        SizedBox(
                                                          height: 5.0,
                                                        ),
                                                        Row(
                                                          mainAxisAlignment: MainAxisAlignment.start,
                                                          children: <Widget>[
                                                            Flexible(
                                                              child: Text(
                                                                pTugas[index],
                                                                style: TextStyle(
                                                                  fontSize: 14.0,
                                                                  fontWeight: FontWeight.w400,
                                                                  color: Colors.black87
                                                                ),
                                                              ),
                                                            )
                                                          ],
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                                Expanded(
                                                  child: Padding(
                                                    padding: const EdgeInsets.only(right: 20.0, left: 20.0, bottom: 5.0),
                                                    child: Row(
                                                      mainAxisAlignment: MainAxisAlignment.end,
                                                      children: <Widget>[
                                                        widget.pDocTerkait[index] == null
                                                          ? Container()
                                                          : GestureDetector(
                                                          child: Text(
                                                            'Document',
                                                            style: TextStyle(fontSize: 14.0, color: AbubaPallate.menuBluebird, fontWeight: FontWeight.w500),
                                                          ),
                                                          onTap: () {
                                                            // sini document terkait
                                                            showModalBottomSheet(
                                                              context: context,
                                                              builder: (builder) {
                                                                return DialogBottomDocumentTerkait(
                                                                  docTerkait: widget.pDocTerkait[index],
                                                                );
                                                              },
                                                            );
                                                          },
                                                        ),
                                                        SizedBox(
                                                          width: 10.0,
                                                        ),
                                                        pKeterangan[index] == null
                                                          ? Container() 
                                                          : GestureDetector(
                                                          child: Text(
                                                            'Note',
                                                            style: TextStyle(fontSize: 14.0, color: AbubaPallate.menuBluebird, fontWeight: FontWeight.w500),
                                                          ),
                                                          onTap: () {
                                                            showModalBottomSheet(
                                                              context: context,
                                                              builder: (builder) {
                                                                return Container(
                                                                  color: Color(0xFF737373),
                                                                  height: MediaQuery.of(context).size.height * 0.3,
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
                                                                                  'Keterangan',
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
                                                                                  children: <Widget>[
                                                                                    pKeterangan[index] == null
                                                                                      ? Row(
                                                                                          mainAxisAlignment: MainAxisAlignment.center,
                                                                                          children: <Widget>[
                                                                                            Flexible(
                                                                                              child: Text(
                                                                                                'No Data',
                                                                                                style: TextStyle(
                                                                                                  fontSize: 15.0,
                                                                                                  color: Colors.black87,
                                                                                                  fontWeight: FontWeight.bold
                                                                                                ),
                                                                                                textAlign: TextAlign.center,
                                                                                              ),
                                                                                            )
                                                                                          ],
                                                                                        )
                                                                                      : Row(
                                                                                          mainAxisAlignment: MainAxisAlignment.center,
                                                                                          children: <Widget>[
                                                                                            Flexible(
                                                                                              child: Text(
                                                                                                pKeterangan[index],
                                                                                                style: TextStyle(
                                                                                                  fontSize: 15.0,
                                                                                                  color: Colors.black38,
                                                                                                  fontWeight: FontWeight.w500
                                                                                                ),
                                                                                                textAlign: TextAlign.center,
                                                                                              ),
                                                                                            )
                                                                                          ],
                                                                                        )
                                                                                  ]
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
                                                        ),
                                                      ],
                                                    ),
                                                  )
                                                )
                                              ],
                                            ),
                                              // sini bottom
                                            Padding(
                                              padding: EdgeInsets.only(left: 10.0, right: 20.0),
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: <Widget>[
                                                  pAction[index] == 'option'
                                                    ? Padding(
                                                        padding: const EdgeInsets.only(right: 20.0),
                                                        child: Row(
                                                          mainAxisAlignment: MainAxisAlignment.end,
                                                          children: <Widget>[
                                                            ButtonTheme(
                                                              minWidth: 50.0,
                                                              height: 30.0,
                                                              child: RaisedButton(
                                                                child: Text(
                                                                  'TIDAK',
                                                                  style: TextStyle(fontSize: 13.0, color: Colors.white),
                                                                ),
                                                                color: Colors.redAccent,
                                                                splashColor: Colors.redAccent,
                                                                highlightColor: Colors.redAccent,
                                                                onPressed: () {
                                                                  setState(() {
                                                                    int count = option.length;
                                                                    option.clear();
                                                                    for (int z = 0; z < count; z++) {
                                                                      option.add('kosong');
                                                                    }
                                                                    option[index] = 'TIDAK';
                                                                  });
                                                                }
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              width: 5.0,
                                                            ),
                                                            ButtonTheme(
                                                              minWidth: 50.0,
                                                              height: 30.0,
                                                              child: OutlineButton(
                                                                child: Text(
                                                                  'YA',
                                                                  style: TextStyle(fontSize: 13.0, color: AbubaPallate.greenabuba),
                                                                ),
                                                                borderSide: BorderSide(color: AbubaPallate.greenabuba, width: 1.0),
                                                                highlightedBorderColor: AbubaPallate.greenabuba,
                                                                onPressed: () {
                                                                  setState(() {
                                                                    int count = option.length;
                                                                    option.clear();
                                                                    for (int z = 0; z < count; z++) {
                                                                      option.add('kosong');
                                                                    }
                                                                    option[index] = 'YA';
                                                                  });
                                                                }
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      )
                                                    : Container(),
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
                                                        print(prosedurCommentCreated[index]);
                                                        showModalBottomSheet(
                                                          context: context,
                                                          builder: (builder) {
                                                            if (prosedurCommentCreated[index] == null) {
                                                              return DialogBottomProsedur(
                                                                bantu: 'kosong',
                                                              );
                                                            } else { 
                                                              return DialogBottomProsedur(
                                                                prosedurComment: bantua[index],
                                                                prosedurCommentStatus: bantuc[index],
                                                                prosedurCommentCreated: prosedurCommentCreated[index].toString().split('!@##'),
                                                                prosedurCommentTgl: bantug[index],
                                                                bantu: 'ada',
                                                                onResult: (value) {
                                                                  setState(() {
                                                                    if (value[0] == 'YES') {
                                                                      if (catatanRevisiNo.length == 0) {
                                                                        catatanRevisiNo.add(1);
                                                                        catatanRevisiTgl.add(DateTime.now());
                                                                        catatanRevisiDeskripsi.add(value[1]);
                                                                      } else {
                                                                        var bantu10 = catatanRevisiDeskripsi[0].toString().split('!@##');
                                                                        bantu10.add(value[1]);
                                                                        var bantu = bantu10.join('!@##');
                                                                        catatanRevisiDeskripsi.clear();
                                                                        catatanRevisiDeskripsi.add(bantu);
                                                                      }
                                                                    }

                                                                    print(catatanRevisiNo);
                                                                    print(catatanRevisiDeskripsi);
                                                                    print(catatanRevisiTgl);
                                                                  });
                                                                },
                                                              );
                                                            }
                                                          }
                                                        ).then((value) {
                                                          print('berhasil');
                                                        });
                                                      }
                                                    ),
                                                  ),
                                                ],
                                              )
                                            ),
                                            option[index] != 'kosong'
                                              ? Padding(
                                                  padding: EdgeInsets.only(right: 20.0, left: 10.0),
                                                  child: Row(
                                                    mainAxisAlignment: MainAxisAlignment.start,
                                                    children: <Widget>[
                                                      Flexible(
                                                        child: Text(
                                                          option[index] == 'YA'
                                                            ? '"Lanjut ke tahapan no ${index + 2}"'
                                                            : pActionTo[index] != null
                                                                ? '"Jawaban Tidak, maka proses akan lanjut ke tahapan no : ${pActionTo[index].toString()}"'
                                                                : ' ',
                                                          style: TextStyle(
                                                            color: option[index] == 'YA' ? AbubaPallate.greenabuba : Colors.redAccent,
                                                            fontSize: 14.0,
                                                            fontWeight: FontWeight.w400,
                                                          ),
                                                        )
                                                      )
                                                    ],
                                                  ),
                                                )
                                              : Container(),
                                            // prosedurComment[index] == null
                                            //   ? Container()
                                            //   : Row(
                                            //       children: <Widget>[
                                            //         Expanded(
                                            //           child: Padding(
                                            //             padding: const EdgeInsets.only(top: 20.0, bottom: 10.0),
                                            //             child: Column(
                                            //               children: List.generate(bantua[index].length, (index7) {
                                            //                 return ListTile(
                                            //                   title: Container(
                                            //                     width: MediaQuery.of(context).size.width * 0.6,
                                            //                     child: Row(
                                            //                       children: <Widget>[
                                            //                         Flexible(
                                            //                           child: Text(
                                            //                             '${index7 + 1}. ${bantua[index][index7]}',
                                            //                             style: TextStyle(
                                            //                               fontSize: 14.0,
                                            //                               color: AbubaPallate.menuBluebird,
                                            //                               fontWeight: FontWeight.w500
                                            //                             ),
                                            //                           ),
                                            //                         )
                                            //                       ],
                                            //                     ),
                                            //                   ),
                                            //                   trailing: Container(
                                            //                     width: MediaQuery.of(context).size.width * 0.3,
                                            //                     child: bantuc[index][index7] == 'OPEN'
                                            //                       ? Row(
                                            //                           children: <Widget>[
                                            //                             ButtonTheme(
                                            //                               minWidth: 50.0,
                                            //                               height: 30.0,
                                            //                               child: OutlineButton(
                                            //                                 child: Text(
                                            //                                   'NO',
                                            //                                   style: TextStyle(fontSize: 13.0, color: Colors.redAccent),
                                            //                                 ),
                                            //                                 borderSide: BorderSide(color: Colors.redAccent, width: 1.0),
                                            //                                 highlightedBorderColor: Colors.redAccent,
                                            //                                 onPressed: () {
                                            //                                   setState(() {
                                            //                                     bantuc[index].removeAt(index7);
                                            //                                     bantuc[index].insert(index7, 'NO');
                                            //                                   });

                                            //                                   print(bantua);
                                            //                                   print(bantuc);
                                            //                                 }
                                            //                               ),
                                            //                             ),
                                            //                             SizedBox(
                                            //                               width: 5.0,
                                            //                             ),
                                            //                             ButtonTheme(
                                            //                               minWidth: 50.0,
                                            //                               height: 30.0,
                                            //                               child: OutlineButton(
                                            //                                 child: Text(
                                            //                                   'YES',
                                            //                                   style: TextStyle(fontSize: 13.0, color: AbubaPallate.greenabuba),
                                            //                                 ),
                                            //                                 borderSide: BorderSide(color: AbubaPallate.greenabuba, width: 1.0),
                                            //                                 highlightedBorderColor: AbubaPallate.greenabuba,
                                            //                                 onPressed: () {
                                            //                                   setState(() {
                                            //                                     bantuc[index][index7] = 'YES';
                                            //                                     if (catatanRevisiNo.length == 0) {
                                            //                                       catatanRevisiNo.add(1);
                                            //                                       catatanRevisiTgl.add(DateTime.now());
                                            //                                       catatanRevisiDeskripsi.add(bantua[index][index7]);
                                            //                                     } else {
                                            //                                       var bantu10 = catatanRevisiDeskripsi[0].toString().split('!@##');
                                            //                                       bantu10.add(bantua[index][index7]);
                                            //                                       var bantu = bantu10.join('!@##');
                                            //                                       catatanRevisiDeskripsi.clear();
                                            //                                       catatanRevisiDeskripsi.add(bantu);
                                            //                                     }

                                            //                                     print(bantua);
                                            //                                     print(bantuc);

                                            //                                     print(catatanRevisiNo);
                                            //                                     print(catatanRevisiDeskripsi);
                                            //                                     print(catatanRevisiTgl);
                                            //                                   });
                                            //                                 }
                                            //                               ),
                                            //                             )
                                            //                           ],
                                            //                         )
                                            //                       : Padding(
                                            //                           padding: EdgeInsets.only(right: 20.0),
                                            //                           child: Row(
                                            //                             mainAxisAlignment: MainAxisAlignment.end,
                                            //                             children: <Widget>[
                                            //                               Flexible(
                                            //                                 child: Text(
                                            //                                   bantuc[index][index7],
                                            //                                   style: TextStyle(
                                            //                                     fontSize: 14.0,
                                            //                                     color: bantuc[index][index7] == 'NO' ? Colors.redAccent : AbubaPallate.greenabuba,
                                            //                                     fontWeight: FontWeight.w500
                                            //                                   ),
                                            //                                 ),
                                            //                               )
                                            //                             ],
                                            //                           )
                                            //                         )
                                            //                   ),
                                            //                 );
                                            //               }).toList()
                                            //             ),
                                            //           )
                                            //         )
                                            //       ],
                                            //     )
                                          ],
                                        )
                                      ),
                                    ),
                                  );
                                }).toList()
                              ),
                              Container(
                                padding: EdgeInsets.only(left: 10.0, right: 10.0, bottom: 10.0),
                                child: Card(
                                  elevation: 1.0,
                                  child: Container(
                                    color: Colors.white,
                                    padding: EdgeInsets.symmetric(vertical: 5.0),
                                    child: Column(
                                      children: <Widget>[
                                        Row(
                                          children: <Widget>[
                                            Expanded(
                                              child: Container(
                                                width: MediaQuery.of(context).size.width * 0.2,
                                                padding: const EdgeInsets.all(10.0),
                                                child: Row(
                                                  children: <Widget>[
                                                    ButtonTheme(
                                                      minWidth: 50.0,
                                                      height: 30.0,
                                                      child: OutlineButton(
                                                        child: Text(
                                                          'SELESAI',
                                                          style: TextStyle(
                                                            fontSize: 14.0,
                                                            color: Colors.grey,
                                                            fontWeight: FontWeight.bold
                                                          ),
                                                        ),
                                                        borderSide: BorderSide(color: Colors.grey, width: 2.0),
                                                        highlightedBorderColor: Colors.grey,
                                                        splashColor: Colors.grey,
                                                        onPressed: null,
                                                        shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(30.0))
                                                      ),
                                                    ),
                                                  ],
                                                )
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    )
                                  ),
                                ),
                              )
                            ],
                          ),
                        )
                          // batas if
                          : GestureDetector(
                              onTap: () {
                                setState(() {
                                  _controller.play();
                                });
                                showModalBottomSheet(
                                  context: context,
                                  builder: (builder) {
                                    return Container(
                                      child: Wrap(
                                        children: <Widget>[
                                          Padding(
                                            padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 20.0),
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              children: <Widget>[
                                                Flexible(
                                                  child: Text(
                                                    'Detail Prosedur',
                                                    style: TextStyle(
                                                      fontSize: 18.0,
                                                      color: Colors.black54,
                                                      fontWeight: FontWeight.bold
                                                    ),
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                          Center(
                                            child: Container(
                                              padding: const EdgeInsets.all(8.0),
                                              width: MediaQuery.of(context).size.width,
                                              height: 250,
                                              child: FutureBuilder(
                                                future: _initializeVideoPlayerFuture,
                                                builder: (context, snapshot) {
                                                  if (snapshot.connectionState == ConnectionState.done) {
                                                    return AspectRatio(
                                                      aspectRatio: _controller.value.aspectRatio,
                                                      child: VideoPlayer(_controller),
                                                    );
                                                  } else {
                                                    return Center(
                                                      child: CircularProgressIndicator(),
                                                    );
                                                  }
                                                },
                                              )
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  }
                                ).then((value) {
                                  setState(() {
                                    if (_controller.value.isPlaying) {
                                      _controller.pause();
                                    }
                                  });
                                });
                              },
                              child: Container(
                                padding: EdgeInsets.only(left: 10.0, right: 10.0),
                                color: Colors.white,
                                child: Padding(
                                  padding: const EdgeInsets.all(15.0),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: <Widget>[
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Flexible(
                                            child: Text(
                                              'VII. PROSEDUR',
                                              style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold, color: Colors.black87)
                                            ),
                                          ),
                                          Flexible(
                                            child: Icon(Icons.ondemand_video, color: Colors.black54),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
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
                                child: RaisedButton(
                                  child: isProcess
                                    ? SizedBox(
                                        child: CircularProgressIndicator(
                                          valueColor: AlwaysStoppedAnimation(Colors.white),
                                          strokeWidth: 2.0
                                        ),
                                        height: 20.0,
                                        width: 20.0
                                      )
                                    : Text(
                                        'SEND',
                                        style: TextStyle(fontSize: 13.0, color: Colors.white),
                                      ),
                                  splashColor: AbubaPallate.greenabuba,
                                  highlightColor: AbubaPallate.greenabuba,
                                  disabledColor: AbubaPallate.greenabuba,
                                  color: AbubaPallate.greenabuba,
                                  onPressed: () {
                                    setState(() {
                                      isProcess = true;
                                    });

                                    if (isProcess) {
                                        var bantuq = [];
                                        for (int q = 0; q < bantuc.length; q++) {
                                          bantuq.add(bantuc[q].join('!@##'));
                                        }

                                        DocumentReference docReference = Firestore.instance.collection('docControl').document(widget.index);

                                        if (tujuanCommentStatus.length != 0) {
                                          docReference.updateData({
                                            'tujuanCommentStatus': tujuanCommentStatus,
                                          }).then((doc) {
                                            print('success');
                                          }).catchError((error) {
                                            print(error);
                                          });
                                        }

                                        if (ruangLingkupCommentStatus.length != 0) {
                                          docReference.updateData({
                                            'rLingkupCommentStatus': ruangLingkupCommentStatus,
                                          }).then((doc) {
                                            print('success');
                                          }).catchError((error) {
                                            print(error);
                                          });
                                        }

                                        if (referensiCommentStatus.length != 0) {
                                          docReference.updateData({
                                            'referensiCommentStatus': referensiCommentStatus,
                                          }).then((doc) {
                                            print('success');
                                          }).catchError((error) {
                                            print(error);
                                          });
                                        }

                                        if (istilahCommentStatus.length != 0) {
                                          docReference.updateData({
                                            'istilahCommentStatus': istilahCommentStatus,
                                          }).then((doc) {
                                            print('success');
                                          }).catchError((error) {
                                            print(error);
                                          });
                                        }

                                        if (risikoCommentStatus.length != 0) {
                                          docReference.updateData({
                                            'risikoCommentStatus': risikoCommentStatus,
                                          }).then((doc) {
                                            print('success');
                                          }).catchError((error) {
                                            print(error);
                                          });
                                        }

                                        docReference.updateData({
                                          'status': 'SENDREVISI',
                                          'revisiSendDate': DateTime.now(),
                                          'revisiDetail': catatanRevisiDeskripsi,
                                          'revisiTgl': catatanRevisiTgl,
                                          'revisiNo': catatanRevisiNo,
                                          'p_CommentStatus': bantuq,
                                        }).then((doc) {
                                          setState(() {
                                            isProcess = false;
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
                                                        'Periksa set up pada website untuk melakukan perbaikan document',
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
                                            Navigator.pushReplacement(context,
                                              MaterialPageRoute(
                                                builder: (_) => BerandaDocument(departmentUser: widget.departmentUser, idUser: widget.idUser, namaUser: widget.namaUser)
                                              )
                                            );
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

class DialogBottomTujuan extends StatefulWidget {
  List<dynamic> tujuanComment;
  List<dynamic> tujuanCommentTgl;
  List<dynamic> tujuanCommentStatus;
  List<dynamic> tujuanCommentCreated;
  final ValueChanged<List<String>> onResult;

  DialogBottomTujuan({this.tujuanComment, this.tujuanCommentStatus, this.onResult, this.tujuanCommentCreated, this.tujuanCommentTgl});
  @override
  _DialogBottomTujuanState createState() => _DialogBottomTujuanState();
}

class _DialogBottomTujuanState extends State<DialogBottomTujuan> {
  List<dynamic> tujuanComment = [];
  List<dynamic> tujuanCommentTgl = [];
  List<dynamic> tujuanCommentCreated = [];
  List<dynamic> tujuanCommentStatus = [];

  @override
  void initState() {
    setState(() {
      tujuanComment = widget.tujuanComment;
      tujuanCommentTgl = widget.tujuanCommentTgl;
      tujuanCommentCreated = widget.tujuanCommentCreated;
      tujuanCommentStatus = widget.tujuanCommentStatus;
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
              child: tujuanComment.length == 0
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
                      itemCount: tujuanComment.length,
                      itemBuilder: (BuildContext context, int index) {
                        Timestamp tglBantu = tujuanCommentTgl[index];

                        return ListTile(
                          title: Container(
                            width: MediaQuery.of(context).size.width * 0.6,
                            child: Row(
                              children: <Widget>[
                                Flexible(
                                  child: Text(
                                    '${index + 1}. ${tujuanComment[index]}',
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
                                    '${tujuanCommentCreated[index]} - ${tglBantu.toDate().toString().substring(8, 10)}/${tglBantu.toDate().toString().substring(5, 7)}/${tglBantu.toDate().toString().substring(0, 4)}',
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
                            child: tujuanCommentStatus[index] == 'OPEN'
                              ? Row(
                                  children: <Widget>[
                                    ButtonTheme(
                                      minWidth: 50.0,
                                      height: 30.0,
                                      child: OutlineButton(
                                        child: Text(
                                          'NO',
                                          style: TextStyle(fontSize: 13.0, color: Colors.redAccent),
                                        ),
                                        borderSide: BorderSide(color: Colors.redAccent, width: 1.0),
                                        highlightedBorderColor: Colors.redAccent,
                                        onPressed: () {
                                          setState(() {
                                            tujuanCommentStatus[index] = 'NO';
                                            widget.onResult([
                                              'NO',
                                              null
                                            ]);
                                          });
                                        }
                                      ),
                                    ),
                                    SizedBox(
                                      width: 5.0,
                                    ),
                                    ButtonTheme(
                                      minWidth: 50.0,
                                      height: 30.0,
                                      child: OutlineButton(
                                        child: Text(
                                          'YES',
                                          style: TextStyle(fontSize: 13.0, color: AbubaPallate.greenabuba),
                                        ),
                                        borderSide: BorderSide(color: AbubaPallate.greenabuba, width: 1.0),
                                        highlightedBorderColor: AbubaPallate.greenabuba,
                                        onPressed: () {
                                          setState(() {
                                            tujuanCommentStatus[index] = 'YES';
                                            widget.onResult([
                                              'YES',
                                              tujuanComment[index]
                                            ]);
                                          });
                                        }
                                      ),
                                    )
                                  ],
                                )
                              : Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: <Widget>[
                                    Flexible(
                                      child: Text(
                                        tujuanCommentStatus[index],
                                        style: TextStyle(
                                          fontSize: 14.0,
                                          color: tujuanCommentStatus[index] == 'NO' ? Colors.redAccent : AbubaPallate.greenabuba,
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

// history ruang lingkup
class DialogBottomRuangLingkup extends StatefulWidget {
  List<dynamic> ruangLingkupComment;
  List<dynamic> ruangLingkupCommentTgl;
  List<dynamic> ruangLingkupCommentStatus;
  List<dynamic> ruangLingkupCommentCreated;
  final ValueChanged<List<String>> onResult;

  DialogBottomRuangLingkup({this.ruangLingkupComment, this.ruangLingkupCommentStatus, this.onResult, this.ruangLingkupCommentCreated, this.ruangLingkupCommentTgl});
  @override
  _DialogBottomRuangLingkupState createState() => _DialogBottomRuangLingkupState();
}

class _DialogBottomRuangLingkupState extends State<DialogBottomRuangLingkup> {
  List<dynamic> ruangLingkupComment = [];
  List<dynamic> ruangLingkupCommentTgl = [];
  List<dynamic> ruangLingkupCommentCreated = [];
  List<dynamic> ruangLingkupCommentStatus = [];

  @override
  void initState() {
    setState(() {
      ruangLingkupComment = widget.ruangLingkupComment;
      ruangLingkupCommentTgl = widget.ruangLingkupCommentTgl;
      ruangLingkupCommentCreated = widget.ruangLingkupCommentCreated;
      ruangLingkupCommentStatus = widget.ruangLingkupCommentStatus;
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
              child: ruangLingkupComment.length == 0
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
                          itemCount: ruangLingkupComment.length,
                          itemBuilder: (BuildContext context, int index) {
                            Timestamp tglBantu = ruangLingkupCommentTgl[index];

                            return ListTile(
                              title: Container(
                                width: MediaQuery.of(context).size.width * 0.6,
                                child: Row(
                                  children: <Widget>[
                                    Flexible(
                                      child: Text(
                                        '${index + 1}. ${ruangLingkupComment[index]}',
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
                                        '${ruangLingkupCommentCreated[index]} - ${tglBantu.toDate().toString().substring(8, 10)}/${tglBantu.toDate().toString().substring(5, 7)}/${tglBantu.toDate().toString().substring(0, 4)}',
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
                                child: ruangLingkupCommentStatus[index] == 'OPEN'
                                  ? Row(
                                      children: <Widget>[
                                        ButtonTheme(
                                          minWidth: 50.0,
                                          height: 30.0,
                                          child: OutlineButton(
                                            child: Text(
                                              'NO',
                                              style: TextStyle(fontSize: 13.0, color: Colors.redAccent),
                                            ),
                                            borderSide: BorderSide(color: Colors.redAccent, width: 1.0),
                                            highlightedBorderColor: Colors.redAccent,
                                            onPressed: () {
                                              setState(() {
                                                ruangLingkupCommentStatus[index] = 'NO';
                                                widget.onResult([
                                                  'NO',
                                                  null
                                                ]);
                                              });
                                            }
                                          ),
                                        ),
                                        SizedBox(
                                          width: 5.0,
                                        ),
                                        ButtonTheme(
                                          minWidth: 50.0,
                                          height: 30.0,
                                          child: OutlineButton(
                                            child: Text(
                                              'YES',
                                              style: TextStyle(fontSize: 13.0, color: AbubaPallate.greenabuba),
                                            ),
                                            borderSide: BorderSide(color: AbubaPallate.greenabuba, width: 1.0),
                                            highlightedBorderColor: AbubaPallate.greenabuba,
                                            onPressed: () {
                                              setState(() {
                                                ruangLingkupCommentStatus[index] = 'YES';
                                                widget.onResult([
                                                  'YES',
                                                  ruangLingkupComment[index]
                                                ]);
                                              });
                                            }
                                          ),
                                        )
                                      ],
                                    )
                                  : Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: <Widget>[
                                        Flexible(
                                          child: Text(
                                            ruangLingkupCommentStatus[index],
                                            style: TextStyle(
                                              fontSize: 14.0,
                                              color: ruangLingkupCommentStatus[index] == 'NO' ? Colors.redAccent : AbubaPallate.greenabuba,
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

// history referensi
class DialogBottomReferensi extends StatefulWidget {
  List<dynamic> referensiComment;
  List<dynamic> referensiCommentTgl;
  List<dynamic> referensiCommentStatus;
  List<dynamic> referensiCommentCreated;
  final ValueChanged<List<String>> onResult;

  DialogBottomReferensi({this.referensiComment, this.referensiCommentStatus, this.onResult, this.referensiCommentCreated, this.referensiCommentTgl});
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
      referensiCommentCreated = widget.referensiCommentCreated;
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
                            child: referensiCommentStatus[index] == 'OPEN'
                              ? Row(
                                  children: <Widget>[
                                    ButtonTheme(
                                      minWidth: 50.0,
                                      height: 30.0,
                                      child: OutlineButton(
                                        child: Text(
                                          'NO',
                                          style: TextStyle(fontSize: 13.0, color: Colors.redAccent),
                                        ),
                                        borderSide: BorderSide(color: Colors.redAccent, width: 1.0),
                                        highlightedBorderColor: Colors.redAccent,
                                        onPressed: () {
                                          setState(() {
                                            referensiCommentStatus[index] = 'NO';
                                            widget.onResult([
                                              'NO',
                                              null
                                            ]);
                                          });
                                        }
                                      ),
                                    ),
                                    SizedBox(
                                      width: 5.0,
                                    ),
                                    ButtonTheme(
                                      minWidth: 50.0,
                                      height: 30.0,
                                      child: OutlineButton(
                                        child: Text(
                                          'YES',
                                          style: TextStyle(fontSize: 13.0, color: AbubaPallate.greenabuba),
                                        ),
                                        borderSide: BorderSide(color: AbubaPallate.greenabuba, width: 1.0),
                                        highlightedBorderColor: AbubaPallate.greenabuba,
                                        onPressed: () {
                                          setState(() {
                                            referensiCommentStatus[index] = 'YES';
                                            widget.onResult([
                                              'YES',
                                              referensiComment[index]
                                            ]);
                                          });
                                        }
                                      ),
                                    )
                                  ],
                                )
                              : Row(
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

// history istilah
class DialogBottomIstilah extends StatefulWidget {
  List<dynamic> istilahComment;
  List<dynamic> istilahCommentTgl;
  List<dynamic> istilahCommentStatus;
  List<dynamic> istilahCommentCreated;
  final ValueChanged<List<String>> onResult;

  DialogBottomIstilah({this.istilahComment, this.istilahCommentStatus, this.onResult, this.istilahCommentCreated, this.istilahCommentTgl});
  @override
  _DialogBottomIstilahState createState() => _DialogBottomIstilahState();
}

class _DialogBottomIstilahState extends State<DialogBottomIstilah> {
  List<dynamic> istilahComment = [];
  List<dynamic> istilahCommentTgl = [];
  List<dynamic> istilahCommentCreated = [];
  List<dynamic> istilahCommentStatus = [];

  @override
  void initState() {
    setState(() {
      istilahComment = widget.istilahComment;
      istilahCommentTgl = widget.istilahCommentTgl;
      istilahCommentCreated = widget.istilahCommentCreated;
      istilahCommentStatus = widget.istilahCommentStatus;
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
              child: istilahComment.length == 0
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
                      itemCount: istilahComment.length,
                      itemBuilder: (BuildContext context, int index) {
                        Timestamp tglBantu = istilahCommentTgl[index];

                        return ListTile(
                          title: Container(
                            width: MediaQuery.of(context).size.width * 0.6,
                            child: Row(
                              children: <Widget>[
                                Flexible(
                                  child: Text(
                                    '${index + 1}. ${istilahComment[index]}',
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
                                    '${istilahCommentCreated[index]} - ${tglBantu.toDate().toString().substring(8, 10)}/${tglBantu.toDate().toString().substring(5, 7)}/${tglBantu.toDate().toString().substring(0, 4)}',
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
                            child: istilahCommentStatus[index] == 'OPEN'
                              ? Row(
                                  children: <Widget>[
                                    ButtonTheme(
                                      minWidth: 50.0,
                                      height: 30.0,
                                      child: OutlineButton(
                                        child: Text(
                                          'NO',
                                          style: TextStyle(fontSize: 13.0, color: Colors.redAccent),
                                        ),
                                        borderSide: BorderSide(color: Colors.redAccent, width: 1.0),
                                        highlightedBorderColor: Colors.redAccent,
                                        onPressed: () {
                                          setState(() {
                                            istilahCommentStatus[index] = 'NO';
                                            widget.onResult([
                                              'NO',
                                              null
                                            ]);
                                          });
                                        }
                                      ),
                                    ),
                                    SizedBox(
                                      width: 5.0,
                                    ),
                                    ButtonTheme(
                                      minWidth: 50.0,
                                      height: 30.0,
                                      child: OutlineButton(
                                        child: Text(
                                          'YES',
                                          style: TextStyle(fontSize: 13.0, color: AbubaPallate.greenabuba),
                                        ),
                                        borderSide: BorderSide(color: AbubaPallate.greenabuba, width: 1.0),
                                        highlightedBorderColor: AbubaPallate.greenabuba,
                                        onPressed: () {
                                          setState(() {
                                            istilahCommentStatus[index] = 'YES';
                                            widget.onResult([
                                              'YES',
                                              istilahComment[index]
                                            ]);
                                          });
                                        }
                                      ),
                                    )
                                  ],
                                )
                              : Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: <Widget>[
                                    Flexible(
                                      child: Text(
                                        istilahCommentStatus[index],
                                        style: TextStyle(
                                          fontSize: 14.0,
                                          color: istilahCommentStatus[index] == 'NO' ? Colors.redAccent : AbubaPallate.greenabuba,
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

// history risiko
class DialogBottomRisiko extends StatefulWidget {
  List<dynamic> risikoComment;
  List<dynamic> risikoCommentTgl;
  List<dynamic> risikoCommentStatus;
  List<dynamic> risikoCommentCreated;
  final ValueChanged<List<String>> onResult;

  DialogBottomRisiko({this.risikoComment, this.risikoCommentStatus, this.onResult, this.risikoCommentCreated, this.risikoCommentTgl});
  @override
  _DialogBottomRisikoState createState() => _DialogBottomRisikoState();
}

class _DialogBottomRisikoState extends State<DialogBottomRisiko> {
  List<dynamic> risikoComment = [];
  List<dynamic> risikoCommentTgl = [];
  List<dynamic> risikoCommentCreated = [];
  List<dynamic> risikoCommentStatus = [];

  @override
  void initState() {
    setState(() {
      risikoComment = widget.risikoComment;
      risikoCommentTgl = widget.risikoCommentTgl;
      risikoCommentCreated = widget.risikoCommentCreated;
      risikoCommentStatus = widget.risikoCommentStatus;
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
              child: risikoComment.length == 0
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
                      itemCount: risikoComment.length,
                      itemBuilder: (BuildContext context, int index) {
                        Timestamp tglBantu = risikoCommentTgl[index];

                        return ListTile(
                          title: Container(
                            width: MediaQuery.of(context).size.width * 0.6,
                            child: Row(
                              children: <Widget>[
                                Flexible(
                                  child: Text(
                                    '${index + 1}. ${risikoComment[index]}',
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
                                    '${risikoCommentCreated[index]} - ${tglBantu.toDate().toString().substring(8, 10)}/${tglBantu.toDate().toString().substring(5, 7)}/${tglBantu.toDate().toString().substring(0, 4)}',
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
                            child: risikoCommentStatus[index] == 'OPEN'
                              ? Row(
                                  children: <Widget>[
                                    ButtonTheme(
                                      minWidth: 50.0,
                                      height: 30.0,
                                      child: OutlineButton(
                                        child: Text(
                                          'NO',
                                          style: TextStyle(fontSize: 13.0, color: Colors.redAccent),
                                        ),
                                        borderSide: BorderSide(color: Colors.redAccent, width: 1.0),
                                        highlightedBorderColor: Colors.redAccent,
                                        onPressed: () {
                                          setState(() {
                                            risikoCommentStatus[index] = 'NO';
                                            widget.onResult([
                                              'NO',
                                              null
                                            ]);
                                          });
                                        }
                                      ),
                                    ),
                                    SizedBox(
                                      width: 5.0,
                                    ),
                                    ButtonTheme(
                                      minWidth: 50.0,
                                      height: 30.0,
                                      child: OutlineButton(
                                        child: Text(
                                          'YES',
                                          style: TextStyle(fontSize: 13.0, color: AbubaPallate.greenabuba),
                                        ),
                                        borderSide: BorderSide(color: AbubaPallate.greenabuba, width: 1.0),
                                        highlightedBorderColor: AbubaPallate.greenabuba,
                                        onPressed: () {
                                          setState(() {
                                            risikoCommentStatus[index] = 'YES';
                                            widget.onResult([
                                              'YES',
                                              risikoComment[index]
                                            ]);
                                          });
                                        }
                                      ),
                                    )
                                  ],
                                )
                              : Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: <Widget>[
                                    Flexible(
                                      child: Text(
                                        risikoCommentStatus[index],
                                        style: TextStyle(
                                          fontSize: 14.0,
                                          color: risikoCommentStatus[index] == 'NO' ? Colors.redAccent : AbubaPallate.greenabuba,
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

// history prosedur
class DialogBottomProsedur extends StatefulWidget {
  List<dynamic> prosedurComment;
  List<dynamic> prosedurCommentTgl;
  List<dynamic> prosedurCommentStatus;
  List<String> prosedurCommentCreated;
  final ValueChanged<List<String>> onResult;
  String bantu;

  DialogBottomProsedur({this.prosedurComment, this.prosedurCommentStatus, this.onResult, this.prosedurCommentCreated, this.prosedurCommentTgl, this.bantu});
  @override
  _DialogBottomProsedurState createState() => _DialogBottomProsedurState();
}

class _DialogBottomProsedurState extends State<DialogBottomProsedur> with TickerProviderStateMixin {
  AnimationController animationController;
  List<dynamic> prosedurComment = [];
  List<dynamic> prosedurCommentTgl = [];
  List<String> prosedurCommentCreated = [];
  List<dynamic> prosedurCommentStatus = [];

  @override
  void initState() {
    if (widget.bantu == 'ada') {
      setState(() {
        prosedurComment = widget.prosedurComment;
        prosedurCommentTgl = widget.prosedurCommentTgl;
        prosedurCommentStatus = widget.prosedurCommentStatus;
      });

      for (int c = 0; c < widget.prosedurCommentCreated.length; c++) {
        Firestore.instance.collection('user').where('id', isEqualTo: int.tryParse(widget.prosedurCommentCreated[c].toString())).snapshots().listen((data14) {
          setState(() {
            prosedurCommentCreated.add(data14.documents[0].data['nama']);
          });
        });
      }
    }

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
              child: AnimatedBuilder(
                animation: animationController,
                builder: (_, Widget child) {
                  return animationController.isAnimating
                    ? Container(
                        child: Center(
                          child: CircularProgressIndicator(),
                        ),
                      )
                    : widget.bantu == 'kosong'
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
                                  itemCount: prosedurComment.length,
                                  itemBuilder: (BuildContext context, int index) {
                                    return ListTile(
                                      title: Container(
                                        width: MediaQuery.of(context).size.width * 0.6,
                                        child: Row(
                                          children: <Widget>[
                                            Flexible(
                                              child: Text(
                                                '${index + 1}. ${prosedurComment[index]}',
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
                                                // '${prosedurCommentCreated[index]} - ${tglBantu.toDate().toString().substring(8, 10)}/${tglBantu.toDate().toString().substring(5, 7)}/${tglBantu.toDate().toString().substring(0, 4)}',
                                                prosedurCommentTgl.length == 1
                                                  ? '${prosedurCommentCreated[index]} - ${DateTime.now().toString().substring(8, 10)}/${DateTime.now().toString().substring(5, 7)}/${DateTime.now().toString().substring(0, 4)}'
                                                  : '${prosedurCommentCreated[index]} - ${prosedurCommentTgl[index].toString().substring(8, 10)}/${prosedurCommentTgl[index].toString().substring(5, 7)}/${prosedurCommentTgl[index].toString().substring(0, 4)}',
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
                                        child: prosedurCommentStatus[index] == 'OPEN'
                                          ? Row(
                                              children: <Widget>[
                                                ButtonTheme(
                                                  minWidth: 50.0,
                                                  height: 30.0,
                                                  child: OutlineButton(
                                                    child: Text(
                                                      'NO',
                                                      style: TextStyle(fontSize: 13.0, color: Colors.redAccent),
                                                    ),
                                                    borderSide: BorderSide(color: Colors.redAccent, width: 1.0),
                                                    highlightedBorderColor: Colors.redAccent,
                                                    onPressed: () {
                                                      setState(() {
                                                        prosedurCommentStatus[index] = 'NO';
                                                        widget.onResult([
                                                          'NO',
                                                          null
                                                        ]);
                                                      });
                                                    }
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 5.0,
                                                ),
                                                ButtonTheme(
                                                  minWidth: 50.0,
                                                  height: 30.0,
                                                  child: OutlineButton(
                                                    child: Text(
                                                      'YES',
                                                      style: TextStyle(fontSize: 13.0, color: AbubaPallate.greenabuba),
                                                    ),
                                                    borderSide: BorderSide(color: AbubaPallate.greenabuba, width: 1.0),
                                                    highlightedBorderColor: AbubaPallate.greenabuba,
                                                    onPressed: () {
                                                      setState(() {
                                                        prosedurCommentStatus[index] = 'YES';
                                                        widget.onResult([
                                                          'YES',
                                                          prosedurComment[index]
                                                        ]);
                                                      });
                                                    }
                                                  ),
                                                )
                                              ],
                                            )
                                          : Row(
                                              mainAxisAlignment: MainAxisAlignment.end,
                                              children: <Widget>[
                                                Flexible(
                                                  child: Text(
                                                    prosedurCommentStatus[index],
                                                    style: TextStyle(
                                                      fontSize: 14.0,
                                                      color: prosedurCommentStatus[index] == 'NO' ? Colors.redAccent : AbubaPallate.greenabuba,
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
                          );
                },
              )
            )
          ],
        )
      ),
    );
  }
}

// dokument terkait
class DialogBottomDocumentTerkait extends StatefulWidget {
  String docTerkait;

  DialogBottomDocumentTerkait({this.docTerkait});
  @override
  _DialogBottomDocumentTerkaitState createState() => _DialogBottomDocumentTerkaitState();
}

class _DialogBottomDocumentTerkaitState extends State<DialogBottomDocumentTerkait> with TickerProviderStateMixin {
  AnimationController animationController;
  String namaDocument;
  var indexDocument;
  bool isProcessTerkait = false;
  bool many = false;
  List<dynamic> bantu = [];

  @override
  void initState() {
    // Firestore.instance.collection('docControl').where('noDoc', isEqualTo: widget.docTerkait).snapshots().listen((data7) {
    //   setState(() {
    //     if (widget.docTerkait == null) {
    //       indexDocument = null;
    //       namaDocument = ' ';
    //     } else {
    //       indexDocument = data7.documents[0].documentID;
    //       namaDocument = data7.documents[0].data['judul'];
    //     }
    //   });
    // });

    setState(() {
      if (widget.docTerkait.length > 1) {
        bantu = widget.docTerkait.split('!@##');
        many = true;
      } else {
        many = false;
        if (widget.docTerkait == null) {
          namaDocument = ' ';
        } else {
          namaDocument = widget.docTerkait;
        }
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
    return Container(
      color: Color(0xFF737373),
      height: MediaQuery.of(context).size.height * 0.5,
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
                      'Dokumen Terkait',
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
              child: AnimatedBuilder(
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
                            height: MediaQuery.of(context).size.height * 0.3 - 46.0,
                            padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 20.0),
                            child: Column(
                              children: <Widget>[
                                Expanded(
                                  child: ListView(
                                    physics: ScrollPhysics(),
                                    children: <Widget>[
                                      widget.docTerkait == null
                                        ? Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: <Widget>[
                                              Flexible(
                                                child: Text(
                                                  'No Data',
                                                  style: TextStyle(
                                                    fontSize: 15.0,
                                                    color: Colors.black87,
                                                    fontWeight: FontWeight.bold
                                                  ),
                                                  textAlign: TextAlign.center,
                                                ),
                                              )
                                            ],
                                          )
                                        : Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: <Widget>[
                                              many
                                                ? Flexible(
                                                    child: Column(
                                                      children: List.generate(bantu.length, (index3) {
                                                        return Container(
                                                          padding: EdgeInsets.symmetric(vertical: 5.0),
                                                          width: MediaQuery.of(context).size.width * 8,
                                                          child: Row(
                                                            mainAxisAlignment: MainAxisAlignment.start,
                                                            children: <Widget>[
                                                              Flexible(
                                                                child: Text(
                                                                  '${index3 + 1}. ${bantu[index3]}',
                                                                  style: TextStyle(
                                                                    fontSize: 15.0,
                                                                    color: Colors.black38,
                                                                    fontWeight: FontWeight.w500
                                                                  ),
                                                                  textAlign: TextAlign.start,
                                                                ),
                                                              ),
                                                            ],
                                                          )
                                                        );
                                                      }).toList()
                                                    ),
                                                  )
                                                : Container(
                                                    width: MediaQuery.of(context).size.width * 0.4,
                                                    child: Row(
                                                      mainAxisAlignment: MainAxisAlignment.start,
                                                      children: <Widget>[
                                                        Flexible(
                                                          child: Text(
                                                            '1. ' + namaDocument,
                                                            style: TextStyle(
                                                              fontSize: 15.0,
                                                              color: Colors.black38,
                                                              fontWeight: FontWeight.w500
                                                            ),
                                                            textAlign: TextAlign.start,
                                                          ),
                                                        ),
                                                      ],
                                                    )
                                                  ),
                                              // GestureDetector(
                                              //   onTap: () {
                                              //     setState(() {
                                              //       isProcessTerkait = true;
                                              //     });
                                              //     var pJabatanTerkait = [];
                                              //     var pDepartmentTerkait = [];
                                              //     var dokumentTerkaitJudulTerkait = [];
                                              //     Firestore.instance.collection('docControl').document(indexDocument).snapshots().listen((data10) async {
                                              //       for (int i = 0; i < data10.data['p_jabatan'].length; i++) {
                                              //         Firestore.instance.collection('jabatan').where('id', isEqualTo: data10.data['p_jabatan'][i]).snapshots().listen((data11) {
                                              //           setState(() {
                                              //             pJabatanTerkait.add(data11.documents[0].data['jabatan']);
                                              //           });
                                              //         });

                                              //         Firestore.instance.collection('department').where('id', isEqualTo: data10.data['p_department'][i]).snapshots().listen((data12) {
                                              //           setState(() {
                                              //             pDepartmentTerkait.add(data12.documents[0].data['department']);
                                              //           });
                                              //         });
                                              //       };
                                              //       for (int i = 0; i < data10.data['p_docTerkait'].length; i++) {
                                              //         Firestore.instance.collection('docControl').where('noDoc', isEqualTo: data10.data['p_docTerkait'][i]).snapshots().listen((data12) {
                                              //           setState(() {
                                              //             dokumentTerkaitJudulTerkait.add(data12.documents[0].data['judul']);
                                              //           });
                                              //         });
                                              //       };
                                              //       await new Future.delayed(Duration(
                                              //         seconds: 3
                                              //       ));
                                              //       setState(() {
                                              //         isProcessTerkait = false;
                                              //       });

                                              //       // print(pJabatanTerkait);
                                              //       // print(pDepartmentTerkait);
                                              //       // print(dokumentTerkaitJudulTerkait);
                                              //       Navigator.pop(context);
                                              //       showModalBottomSheet(
                                              //         context: context,
                                              //         // isScrollControlled: true,
                                              //         builder: (builder) {
                                              //           return DialogBottomDua(
                                              //             dokumentTerkaitJudulTerkait: dokumentTerkaitJudulTerkait,
                                              //             pDepartmentTerkait: pDepartmentTerkait,
                                              //             pJabatanTerkait: pJabatanTerkait,
                                              //             namaDocument: namaDocument,
                                              //             noDocTerkait: widget.docTerkait,
                                              //             tujuanDeskripsi: data10.data['tujuanDeskripsi'],
                                              //             ruangLingkupDeskripsi: data10.data['rLingkupDeskripsi'],
                                              //             referensiDeskripsi: data10.data['referensiDeskripsi'],
                                              //             istilahDeskripsi: data10.data['istilahDeskripsi'],
                                              //             risikoDeskripsi: data10.data['risikoDeskripsi'],
                                              //             revisiNo: data10.data['revisiNo'],
                                              //             revisiTgl: data10.data['revisiTgl'],
                                              //             revisiDetail: data10.data['revisiDetail'],
                                              //             p_keterangan: data10.data['p_keterangan'],
                                              //             p_tugas: data10.data['p_tugas'],
                                              //             p_docTerkait: data10.data['p_docTerkait'],
                                              //           );
                                              //         },
                                              //       );
                                              //     });
                                              //   },
                                              //   child: Container(
                                              //     width: MediaQuery.of(context).size.width * 0.4,
                                              //     child: Row(
                                              //       mainAxisAlignment: MainAxisAlignment.end,
                                              //       children: <Widget>[
                                              //         Flexible(
                                              //           child: Text(
                                              //             isProcessTerkait
                                              //               ? 'Please wait ..'
                                              //               : widget.docTerkait,
                                              //             style: TextStyle(
                                              //               fontSize: 15.0,
                                              //               color: AbubaPallate.menuBluebird,
                                              //               fontWeight: FontWeight.w500
                                              //             ),
                                              //             textAlign: TextAlign.end,
                                              //           ),
                                              //         ),
                                              //       ],
                                              //     )
                                              //   ),
                                              // )
                                            ],
                                          )
                                    ]
                                  ),
                                )
                              ],
                            ),
                          )
                        ],
                      );
                },
              )
            )
          ],
        )
      ),
    );
  }
}

class DialogBottomDua extends StatefulWidget {
  var pJabatanTerkait;
  var pDepartmentTerkait;
  var dokumentTerkaitJudulTerkait;
  String noDocTerkait;
  String namaDocument;
  String tujuanDeskripsi;
  String ruangLingkupDeskripsi;
  String referensiDeskripsi;
  List<dynamic> istilahDeskripsi;
  List<dynamic> risikoDeskripsi;
  List<dynamic> revisiNo;
  List<dynamic> revisiTgl;
  List<dynamic> revisiDetail;
  List<dynamic> p_keterangan;
  List<dynamic> p_tugas;
  List<dynamic> p_docTerkait;

  DialogBottomDua({this.pDepartmentTerkait, this.dokumentTerkaitJudulTerkait, this.pJabatanTerkait, this.namaDocument, this.noDocTerkait, this.istilahDeskripsi, this.p_keterangan, this.p_tugas, this.referensiDeskripsi, this.revisiDetail, this.revisiNo, this.revisiTgl, this.ruangLingkupDeskripsi, this.tujuanDeskripsi, this.p_docTerkait, this.risikoDeskripsi});
  @override
  _DialogBottomDuaState createState() => _DialogBottomDuaState();
}

class _DialogBottomDuaState extends State<DialogBottomDua> {
  var pJabatanTerkait = [];
  var pDepartmentTerkait = [];
  var dokumentTerkaitJudulTerkait = [];

  @override
  void initState() {
    setState(() {
      pJabatanTerkait = widget.pJabatanTerkait;
      pDepartmentTerkait = widget.pDepartmentTerkait;
      dokumentTerkaitJudulTerkait = widget.dokumentTerkaitJudulTerkait;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xFF737373),
      height: MediaQuery.of(context).size.height * 0.9,
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
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Flexible(
                    child: Text(
                      widget.noDocTerkait,
                      style: TextStyle(
                        fontSize: 16.0,
                        color: Colors.white,
                        fontWeight: FontWeight.bold
                      ),
                    ),
                  ),
                  Flexible(
                    child: Text(
                      widget.namaDocument,
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
              height: MediaQuery.of(context).size.height * 0.9 - 46.0,
              padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 20.0),
              child: Column(
                children: <Widget>[
                  Expanded(
                    child: ListView(
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
                                      'I. TUJUAN',
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
                                      widget.tujuanDeskripsi,
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
                          ],
                        ),
                        ExpansionTile(
                          title: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Flexible(
                                    child: Text(
                                      'II. RUANG LINGKUP',
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
                                      widget.ruangLingkupDeskripsi,
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
                          ],
                        ),
                        ExpansionTile(
                          title: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Flexible(
                                    child: Text(
                                      'III. REFERENSI',
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
                                      widget.referensiDeskripsi,
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
                          ],
                        ),
                        ExpansionTile(
                          title: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Flexible(
                                    child: Text(
                                      'IV. ISTILAH',
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
                              child: widget.istilahDeskripsi.length == 0
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
                                    children: List.generate(widget.istilahDeskripsi.length, (index4) {
                                      return Padding(
                                        padding: const EdgeInsets.only(top: 5.0, bottom: 5.0),
                                        child: Row(
                                          children: <Widget>[
                                            Flexible(
                                              child: Text(
                                                '${index4 + 1}. ${widget.istilahDeskripsi[index4].toString()}',
                                                style: TextStyle(
                                                  fontSize: 14.0,
                                                  color: Colors.black38,
                                                  fontWeight: FontWeight.w500
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      );
                                    }).toList()
                                  )
                            ),
                          ],
                        ),
                        ExpansionTile(
                          title: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Flexible(
                                    child: Text(
                                      'V. CATATAN REVISI',
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
                                children: widget.revisiNo.length == 0
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
                                  : List.generate(widget.revisiNo.length, (index2) {
                                    Timestamp tglBantu = widget.revisiTgl[index2];
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
                                                      'Tanggal Revisi',
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
                                                  'REV ${widget.revisiNo[index2].toString().padLeft(2, '0')}',
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
                                                    var bantuDetail = widget.revisiDetail[index2].toString().split('!@##');

                                                    showDialog(
                                                      barrierDismissible: false,
                                                      context: context,
                                                      builder: (context) => Dialog(
                                                        child: Container(
                                                          height: MediaQuery.of(context).size.width * 0.6,
                                                          child: Column(
                                                            children: <Widget>[
                                                              Container(
                                                                color: AbubaPallate.greenabuba,
                                                                height: 50.0,
                                                                child: Center(
                                                                  child: Text(
                                                                    'ALASAN PERUBAHAN',
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
                                                                height: MediaQuery.of(context).size.height * 0.15,
                                                                padding: EdgeInsets.symmetric(horizontal: 20.0),
                                                                child: ListView.builder(
                                                                  scrollDirection: Axis.vertical,
                                                                  shrinkWrap: true,
                                                                  physics: ScrollPhysics(),
                                                                  itemCount: bantuDetail.length,
                                                                  itemBuilder: (BuildContext context, int index3) {
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
                                                                  },
                                                                )
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
                        ExpansionTile(
                          title: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Flexible(
                                    child: Text(
                                      'VI. RISIKO',
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
                                children: List.generate(widget.risikoDeskripsi.length, (index4) {
                                  return Padding(
                                    padding: const EdgeInsets.only(top: 5.0, bottom: 5.0),
                                    child: Row(
                                      children: <Widget>[
                                        Flexible(
                                          child: Text(
                                            '${index4 + 1}. ${widget.risikoDeskripsi[index4].toString()}',
                                            style: TextStyle(
                                              fontSize: 14.0,
                                              color: Colors.black38,
                                              fontWeight: FontWeight.w500
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  );
                                }).toList()
                              )
                            ),
                          ],
                        ),
                        ExpansionTile(
                          title: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Flexible(
                                    child: Text(
                                      'VII. PROSEDUR',
                                      style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold, color: Colors.black87)
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          children: <Widget>[
                            Column(
                              children: List.generate(widget.p_tugas.length, (index5) {
                                return Container(
                                  padding: EdgeInsets.only(left: 10.0, right: 10.0, bottom: 10.0),
                                  child: Card(
                                    elevation: 1.0,
                                    child: Container(
                                      color: Colors.white,
                                      padding: EdgeInsets.symmetric(vertical: 15.0),
                                      child: Column(
                                        children: <Widget>[
                                          Row(
                                            children: <Widget>[
                                              Expanded(
                                                child: Padding(
                                                  padding: const EdgeInsets.all(10.0),
                                                  child: Column(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: <Widget>[
                                                      Row(
                                                        mainAxisAlignment: MainAxisAlignment.start,
                                                        children: <Widget>[
                                                          Flexible(
                                                            child: Text(
                                                              '${index5 + 1}. ${pJabatanTerkait[index5].toString().toUpperCase()} - ${pDepartmentTerkait[index5].toString().toUpperCase()}',
                                                              style: TextStyle(
                                                                fontSize: 15.0,
                                                                fontWeight: FontWeight.w700,
                                                                color: Colors.black87
                                                              ),
                                                            ),
                                                          )
                                                        ],
                                                      ),
                                                      SizedBox(
                                                        height: 5.0,
                                                      ),
                                                      Row(
                                                        mainAxisAlignment: MainAxisAlignment.start,
                                                        children: <Widget>[
                                                          Flexible(
                                                            child: Text(
                                                              widget.p_tugas[index5],
                                                              style: TextStyle(
                                                                fontSize: 14.0,
                                                                fontWeight: FontWeight.w400,
                                                                color: Colors.black87
                                                              ),
                                                            ),
                                                          )
                                                        ],
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              Expanded(
                                                child: Padding(
                                                  padding: const EdgeInsets.only(right: 20.0, left: 20.0, bottom: 5.0),
                                                  child: Row(
                                                    mainAxisAlignment: MainAxisAlignment.end,
                                                    children: <Widget>[
                                                      ButtonTheme(
                                                        minWidth: 50.0,
                                                        height: 30.0,
                                                        child: RaisedButton(
                                                          child: Text(
                                                            'DOCS',
                                                            style: TextStyle(fontSize: 13.0, color: Colors.white),
                                                          ),
                                                          splashColor: AbubaPallate.greenabuba,
                                                          highlightColor: AbubaPallate.greenabuba,
                                                          disabledColor: AbubaPallate.greenabuba,
                                                          color: AbubaPallate.greenabuba,
                                                          onPressed: () {
                                                            // int jumlahNullDoc = data10.data['p_docTerkait'].where((result) => result == null).length;

                                                            showDialog(
                                                              barrierDismissible: false,
                                                              context: context,
                                                              builder: (context) => Dialog(
                                                                child: Container(
                                                                  height: MediaQuery.of(context).size.height * 0.3,
                                                                  child: Column(
                                                                    children: <Widget>[
                                                                      Container(
                                                                        color: AbubaPallate.greenabuba,
                                                                        height: 50.0,
                                                                        child: Center(
                                                                          child: Text(
                                                                            'Dokumen Terkait',
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
                                                                        color: Colors.white,
                                                                        height: MediaQuery.of(context).size.height * 0.1,
                                                                        padding: EdgeInsets.symmetric(horizontal: 20.0),
                                                                        child: Column(
                                                                          children: <Widget>[
                                                                            Expanded(
                                                                              child: ListView(
                                                                                physics: ScrollPhysics(),
                                                                                children: widget.p_docTerkait[index5] == null
                                                                                ? <Widget>[
                                                                                    Row(
                                                                                      mainAxisAlignment: MainAxisAlignment.center,
                                                                                      children: <Widget>[
                                                                                        Flexible(
                                                                                          child: Text(
                                                                                            'No Data',
                                                                                            style: TextStyle(
                                                                                              fontSize: 15.0,
                                                                                              color: Colors.black87,
                                                                                              fontWeight: FontWeight.bold
                                                                                            ),
                                                                                          ),
                                                                                        )
                                                                                      ],
                                                                                    )
                                                                                  ]
                                                                                : <Widget>[
                                                                                    Row(
                                                                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                      children: <Widget>[
                                                                                        Container(
                                                                                          width: MediaQuery.of(context).size.width * 0.3,
                                                                                          child: Row(
                                                                                            mainAxisAlignment: MainAxisAlignment.start,
                                                                                            children: <Widget>[
                                                                                              Flexible(
                                                                                                child: Text(
                                                                                                  dokumentTerkaitJudulTerkait[index5],
                                                                                                  style: TextStyle(
                                                                                                    fontSize: 15.0,
                                                                                                    color: Colors.black38,
                                                                                                    fontWeight: FontWeight.w500
                                                                                                  ),
                                                                                                  textAlign: TextAlign.start,
                                                                                                ),
                                                                                              ),
                                                                                            ],
                                                                                          )
                                                                                        ),
                                                                                        Container(
                                                                                          width: MediaQuery.of(context).size.width * 0.3,
                                                                                          child: Row(
                                                                                            mainAxisAlignment: MainAxisAlignment.end,
                                                                                            children: <Widget>[
                                                                                              Flexible(
                                                                                                child: Text(
                                                                                                  widget.p_docTerkait[index5],
                                                                                                  style: TextStyle(
                                                                                                    fontSize: 15.0,
                                                                                                    color: Colors.black38,
                                                                                                    fontWeight: FontWeight.w500
                                                                                                  ),
                                                                                                  textAlign: TextAlign.end,
                                                                                                ),
                                                                                              ),
                                                                                            ],
                                                                                          )
                                                                                        ),
                                                                                      ],
                                                                                    )
                                                                                  ]
                                                                              ),
                                                                            )
                                                                          ],
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
                                                            );
                                                          },
                                                        )
                                                      ),
                                                      SizedBox(
                                                        width: 5.0,
                                                      ),
                                                      ButtonTheme(
                                                        minWidth: 50.0,
                                                        height: 30.0,
                                                        child: OutlineButton(
                                                          child: Text(
                                                            'NOTE',
                                                            style: TextStyle(
                                                              fontSize: 13.0,
                                                              color: AbubaPallate.menuBluebird,
                                                              fontWeight: FontWeight.bold
                                                            ),
                                                          ),
                                                          borderSide: BorderSide(color: AbubaPallate.menuBluebird, width: 2.0),
                                                          highlightedBorderColor: AbubaPallate.menuBluebird,
                                                          splashColor: AbubaPallate.menuBluebird,
                                                          onPressed: () {
                                                            showDialog(
                                                              barrierDismissible: false,
                                                              context: context,
                                                              builder: (context) => Dialog(
                                                                child: Container(
                                                                  height: MediaQuery.of(context).size.height * 0.3,
                                                                  child: Column(
                                                                    children: <Widget>[
                                                                      Container(
                                                                        color: AbubaPallate.menuBluebird,
                                                                        height: 50.0,
                                                                        child: Center(
                                                                          child: Text(
                                                                            'Keterangan',
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
                                                                        color: Colors.white,
                                                                        height: MediaQuery.of(context).size.height * 0.1,
                                                                        padding: EdgeInsets.symmetric(horizontal: 20.0),
                                                                        child: Column(
                                                                          children: <Widget>[
                                                                            Expanded(
                                                                              child: ListView(
                                                                                physics: ScrollPhysics(),
                                                                                children: <Widget>[
                                                                                  widget.p_keterangan[index5] == null
                                                                                    ? Row(
                                                                                        mainAxisAlignment: MainAxisAlignment.center,
                                                                                        children: <Widget>[
                                                                                          Flexible(
                                                                                            child: Text(
                                                                                              'No Data',
                                                                                              style: TextStyle(
                                                                                                fontSize: 15.0,
                                                                                                color: Colors.black87,
                                                                                                fontWeight: FontWeight.bold
                                                                                              ),
                                                                                              textAlign: TextAlign.center,
                                                                                            ),
                                                                                          )
                                                                                        ],
                                                                                      )
                                                                                    : Row(
                                                                                        mainAxisAlignment: MainAxisAlignment.center,
                                                                                        children: <Widget>[
                                                                                          Flexible(
                                                                                            child: Text(
                                                                                              widget.p_keterangan[index5],
                                                                                              style: TextStyle(
                                                                                                fontSize: 15.0,
                                                                                                color: Colors.black38,
                                                                                                fontWeight: FontWeight.w500
                                                                                              ),
                                                                                              textAlign: TextAlign.center,
                                                                                            ),
                                                                                          )
                                                                                        ],
                                                                                      )
                                                                                ]
                                                                              ),
                                                                            )
                                                                          ],
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
                                                            );
                                                          },
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                )
                                              )
                                            ],
                                          ),
                                        ],
                                      )
                                    ),
                                  ),
                                );
                              }).toList()
                            ),
                            Container(
                              padding: EdgeInsets.only(left: 10.0, right: 10.0, bottom: 10.0),
                              child: Card(
                                elevation: 1.0,
                                child: Container(
                                  color: Colors.white,
                                  padding: EdgeInsets.symmetric(vertical: 5.0),
                                  child: Column(
                                    children: <Widget>[
                                      Row(
                                        children: <Widget>[
                                          Expanded(
                                            child: Container(
                                              width: MediaQuery.of(context).size.width * 0.2,
                                              padding: const EdgeInsets.all(10.0),
                                              child: Row(
                                                children: <Widget>[
                                                  ButtonTheme(
                                                    minWidth: 50.0,
                                                    height: 30.0,
                                                    child: OutlineButton(
                                                      child: Text(
                                                        'SELESAI',
                                                        style: TextStyle(
                                                          fontSize: 14.0,
                                                          color: Colors.grey,
                                                          fontWeight: FontWeight.bold
                                                        ),
                                                      ),
                                                      borderSide: BorderSide(color: Colors.grey, width: 2.0),
                                                      highlightedBorderColor: Colors.grey,
                                                      splashColor: Colors.grey,
                                                      onPressed: null,
                                                      shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(30.0))
                                                    ),
                                                  ),
                                                ],
                                              )
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  )
                                ),
                              ),
                            )
                          ],
                        )
                      ],
                    )
                  )
                ],
              ),
            )
          ],
        )
      ),
    );
  }
}