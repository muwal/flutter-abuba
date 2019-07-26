import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_abuba/constant.dart';

class FormDetailRevisiWorking extends StatefulWidget {
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
  FormDetailRevisiWorking({this.idUser, this.namaUser, this.departmentUser, this.index, this.pJabatan, this.pDocTerkait, this.pDepartment, this.pComment, this.pCommentStatus, this.tujuanCommentCreated, this.istilahCommentCreated, this.referensiCommentCreated, this.ruangLingkupCommentCreated, this.prosedurCommentTgl, this.bantuistilah, this.bantureferensi, this.banturisiko, this.banturuanglingkup, this.bantutujuan, this.risikoCommentCreated});

  @override
  _FormDetailRevisiWorkingState createState() => _FormDetailRevisiWorkingState();
}

class _FormDetailRevisiWorkingState extends State<FormDetailRevisiWorking> with TickerProviderStateMixin {
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

  bool isProcess = false;

  List<dynamic> tujuanComment = [];
  List<dynamic> tujuanCommentTgl = [];
  List<String> tujuanCommentCreated = [];

  List<dynamic> ruangLingkupComment = [];
  List<dynamic> ruangLingkupCommentTgl = [];
  List<String> ruangLingkupCommentCreated = [];

  List<dynamic> referensiComment = [];
  List<dynamic> referensiCommentTgl = [];
  List<dynamic> referensiCommentCreated = [];

  List<dynamic> instruksiComment = [];
  List<dynamic> instruksiCommentTgl = [];
  List<dynamic> instruksiCommentCreated = [];

  List<dynamic> risikoComment = [];
  List<dynamic> risikoCommentTgl = [];
  List<String> risikoCommentCreated = [];

  List<dynamic> prosedurComment = [];
  List<dynamic> prosedurCommentCreated = [];
  
  var tujuanCommentStatus = [];
  var ruangLingkupCommentStatus = [];
  var referensiCommentStatus = [];
  var instruksiCommentStatus = [];
  var risikoCommentStatus = [];
  var prosedurCommentStatus = [];

  var catatanRevisiNo = [];
  var catatanRevisiTgl = [];
  var catatanRevisiDeskripsi = [];

  List<dynamic> imageInstruksi = [];
  List<bool> _gambarInstruksi = [];

  var bantua = [];
  var bantuc = [];
  var bantug = [];

  List<String> option = [];
  List<dynamic> bantuReferensiCommentCreated = [];
  List<dynamic> bantuInstruksiCommentCreated = [];

  @override
  void initState() {
    super.initState();

    Firestore.instance.collection('docInstruksi').document(widget.index).snapshots().listen((data) {
      setState(() {
        noDoc = data.data['noDoc'];
        judulDoc = data.data['judul'];
        revisi = data.data['lastRevisi'];

        referensiDeskripsi = data.data['referensiDeskripsi'];
        imageInstruksi = data.data['instruksiImage'];
        referensiComment = data.data['referensiComment'];
        referensiCommentTgl = data.data['referensiCommentTgl'];
        for (int a = 0; a < data.data['referensiCommentCreated'].length; a++) {
          Firestore.instance.collection('user').where('id', isEqualTo: data.data['referensiCommentCreated'][a]).snapshots().listen((data) {
            bantuReferensiCommentCreated.add(data.documents[0].data['nama']);
          });
        }
        referensiCommentCreated = bantuReferensiCommentCreated;
        referensiCommentStatus = List<dynamic>.from(data.data['referensiCommentStatus']);

        instruksiDeskripsi = data.data['instruksiDeskripsi'];
        instruksiComment = data.data['instruksiComment'];
        instruksiCommentTgl = data.data['instruksiCommentTgl'];
        for (int q = 0; q < data.data['instruksiCommentCreated'].length; q++) {
          Firestore.instance.collection('user').where('id', isEqualTo: data.data['instruksiCommentCreated'][q]).snapshots().listen((data2) {
            bantuInstruksiCommentCreated.add(data2.documents[0].data['nama']);
          });
        }
        instruksiCommentCreated = bantuInstruksiCommentCreated;
        instruksiCommentStatus = List<dynamic>.from(data.data['instruksiCommentStatus']);
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
                                        ]
                                      )
                                    )
                                  ),
                                ),
                              ],
                            ),
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
                                          print(instruksiCommentStatus);

                                          showModalBottomSheet(
                                            context: context,
                                            builder: (builder) {
                                              return DialogBottomInstruksi(
                                                instruksiComment: instruksiComment,
                                                instruksiCommentStatus: instruksiCommentStatus,
                                                instruksiCommentCreated: instruksiCommentCreated,
                                                instruksiCommentTgl: instruksiCommentTgl,
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
                              //     children: List.generate(instruksiComment.length, (index) {
                              //       return ListTile(
                              //         title: Container(
                              //           width: MediaQuery.of(context).size.width * 0.6,
                              //           child: Row(
                              //             children: <Widget>[
                              //               Flexible(
                              //                 child: Text(
                              //                   '${index + 1}. ${instruksiComment[index]}',
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
                              //           child: instruksiCommentStatus[index] == 'OPEN'
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
                              //                           instruksiCommentStatus[index] = 'NO';
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
                              //                           instruksiCommentStatus[index] = 'YES';
                              //                           if (catatanRevisiNo.length == 0) {
                              //                             catatanRevisiNo.add(1);
                              //                             catatanRevisiTgl.add(DateTime.now());
                              //                             catatanRevisiDeskripsi.add(instruksiComment[index]);
                              //                           } else {
                              //                             var bantu10 = catatanRevisiDeskripsi[0].toString().split('!@##');
                              //                             bantu10.add(instruksiComment[index]);
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
                              //                       instruksiCommentStatus[index],
                              //                       style: TextStyle(
                              //                         fontSize: 14.0,
                              //                         color: instruksiCommentStatus[index] == 'NO' ? Colors.redAccent : AbubaPallate.greenabuba,
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

                                        DocumentReference docReference = Firestore.instance.collection('docInstruksi').document(widget.index);

                                        if (referensiCommentStatus.length != 0) {
                                          docReference.updateData({
                                            'referensiCommentStatus': referensiCommentStatus,
                                          }).then((doc) {
                                            print('success');
                                          }).catchError((error) {
                                            print(error);
                                          });
                                        }

                                        if (instruksiCommentStatus.length != 0) {
                                          docReference.updateData({
                                            'instruksiCommentStatus': instruksiCommentStatus,
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
              child: widget.referensiComment.length == 0
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
                      itemCount: widget.referensiComment.length,
                      itemBuilder: (BuildContext context, int index) {
                        Timestamp tglBantu = widget.referensiCommentTgl[index];

                        return ListTile(
                          title: Container(
                            width: MediaQuery.of(context).size.width * 0.6,
                            child: Row(
                              children: <Widget>[
                                Flexible(
                                  child: Text(
                                    '${index + 1}. ${widget.referensiComment[index]}',
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
                                    '${widget.referensiCommentCreated[index]} - ${tglBantu.toDate().toString().substring(8, 10)}/${tglBantu.toDate().toString().substring(5, 7)}/${tglBantu.toDate().toString().substring(0, 4)}',
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
                            child: widget.referensiCommentStatus[index] == 'OPEN'
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
                                              widget.referensiComment[index]
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

// history instruksi
class DialogBottomInstruksi extends StatefulWidget {
  List<dynamic> instruksiComment;
  List<dynamic> instruksiCommentTgl;
  List<dynamic> instruksiCommentStatus;
  List<dynamic> instruksiCommentCreated;
  final ValueChanged<List<String>> onResult;

  DialogBottomInstruksi({this.instruksiComment, this.instruksiCommentStatus, this.onResult, this.instruksiCommentCreated, this.instruksiCommentTgl});
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
      instruksiCommentCreated = widget.instruksiCommentCreated;
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
              child: widget.instruksiComment.length == 0
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
                  // RaisedButton(
                  //   child: Text(
                  //     'asd'
                  //   ),
                  //   onPressed: () {
                  //     print(widget.instruksiComment);
                  //     print(widget.instruksiCommentStatus);
                  //     print(widget.instruksiCommentCreated);
                  //     print(widget.instruksiCommentTgl);
                  //   },
                  // )
                  Expanded(
                    child: ListView.builder(
                      physics: ScrollPhysics(),
                      itemCount: widget.instruksiComment.length,
                      itemBuilder: (BuildContext context, int index) {
                        Timestamp tglBantu = widget.instruksiCommentTgl[index];

                        return ListTile(
                          title: Container(
                            width: MediaQuery.of(context).size.width * 0.6,
                            child: Row(
                              children: <Widget>[
                                Flexible(
                                  child: Text(
                                    '${index + 1}. ${widget.instruksiComment[index]}',
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
                                    '${widget.instruksiCommentCreated[index]} - ${tglBantu.toDate().toString().substring(8, 10)}/${tglBantu.toDate().toString().substring(5, 7)}/${tglBantu.toDate().toString().substring(0, 4)}',
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
                            child: widget.instruksiCommentStatus[index] == 'OPEN'
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
                                            widget.instruksiCommentStatus[index] = 'NO';
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
                                            widget.instruksiCommentStatus[index] = 'YES';
                                            widget.onResult([
                                              'YES',
                                              widget.instruksiComment[index]
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
                                        widget.instruksiCommentStatus[index],
                                        style: TextStyle(
                                          fontSize: 14.0,
                                          color: widget.instruksiCommentStatus[index] == 'NO' ? Colors.redAccent : AbubaPallate.greenabuba,
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