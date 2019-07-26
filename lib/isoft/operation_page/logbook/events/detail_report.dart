import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_abuba/constant.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:intl/intl.dart';

class DetailReport extends StatefulWidget {
  final int acaraID;
  final Timestamp tanggalAcara;
  DetailReport({this.acaraID, this.tanggalAcara});
  

  @override
  _DetailReportState createState() => _DetailReportState();
}

class _DetailReportState extends State<DetailReport> with TickerProviderStateMixin {

  AnimationController animationController;
  var documentID = [];
  List<dynamic> dataJenisAcara = [];
  List<dynamic> dataPack = [];
  List<dynamic> dataWaktu = [];
  List<dynamic> dataJenisAcaraID = [];
  String shiftData;

  @override
  void initState() { 
    super.initState();
    CollectionReference reference = Firestore.instance.collection('event');
    reference.where('id_shift', isEqualTo: widget.acaraID).snapshots().listen((data) {
      data.documentChanges.forEach((change) {
        setState(() {

          print(widget.tanggalAcara);
          print(change.document.data['id_jenis_acara']);

          Timestamp tanggalBantu = change.document.data['waktu'];
          String tanggalBantu2 = tanggalBantu.toDate().toString().substring(8, 10) + '/' + tanggalBantu.toDate().toString().substring(5, 7) + '/' + tanggalBantu.toDate().toString().substring(0, 4);
          String tanggalAcara2 = widget.tanggalAcara.toDate().toString().substring(8, 10) + '/' + widget.tanggalAcara.toDate().toString().substring(5, 7) + '/' + widget.tanggalAcara.toDate().toString().substring(0, 4);
       
          if (tanggalBantu2 == tanggalAcara2) {
            Firestore.instance.collection('jenis_acara').where('id', isEqualTo: change.document.data['id_jenis_acara']).snapshots().listen((data2) {
              dataJenisAcara.add(data2.documents[0].data['jenis_acara']);
            });
          

            dataJenisAcaraID.add(change.document.data['id']);
            dataPack.add(change.document.data['pack']);
            
            Timestamp tampungDate = change.document.data['waktu'];
            dataWaktu.add(tampungDate);
          }

          print(dataJenisAcaraID);
        });
      });
    });

    animationController = AnimationController(vsync: this, duration: Duration(seconds: 3));
    animationController.reverse(
      from: animationController.value == 0.0
        ? 1.0
        : animationController.value
    );

    Firestore.instance.collection('shift').where('id', isEqualTo: widget.acaraID).snapshots().listen((data3) {
      shiftData = data3.documents[0].data['shift'];
    });

  }

  @override
  Widget build(BuildContext context) {
  final double width = MediaQuery.of(context).size.width;
  return Scaffold(
      appBar: _appBar(),
      body: Scrollbar(
        child: ListView(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Report',
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
                      'Detail',
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
                      child: Column(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(top: 10.0, right: 15.0, left: 15.0),
                            child: Column(
                              children: <Widget>[
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Container(
                                      width: 150.0,
                                      child: Row(
                                        children: <Widget>[
                                          Flexible(
                                            child: Text(
                                              'Stevani Miller',
                                              style: TextStyle(
                                                  fontSize: 12.0, color: Colors.black54),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      width: 150.0,
                                      child: Row(
                                        children: <Widget>[
                                          Flexible(
                                            child: Text(
                                              '${widget.tanggalAcara.toDate().toString().substring(8, 10) + '/' + widget.tanggalAcara.toDate().toString().substring(5, 7) + '/' + 
                                                widget.tanggalAcara.toDate().toString().substring(0, 4) + ' - ' + shiftData}',
                                              style: TextStyle(
                                                  fontSize: 12.0, color: Colors.black54),
                                            ),
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Container(
                                      width: 150.0,
                                      child: Row(
                                        children: <Widget>[
                                          Flexible(
                                            child: Text(
                                              'MOD',
                                              style: TextStyle(fontSize: 10.0, color: Colors.black38),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            child: Divider(
                              height: 6.0,
                            ),
                          ),
                          Flexible(
                            child: ListView.builder(
                              scrollDirection: Axis.vertical,
                              itemCount: dataPack.length,
                              itemBuilder: (BuildContext context, int index) {
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
                                                        'Jenis Acara',
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
                                                        'Pack',
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
                                                        'Waktu',
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
                                    Padding(
                                      padding: index == dataJenisAcara.length - 1 ? const EdgeInsets.fromLTRB(12.0, 6.0, 12.0, 12.0) : const EdgeInsets.fromLTRB(12.0, 6.0, 12.0, 0.0),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Container(
                                              width: width / 5,
                                              child: Row(
                                                children: <Widget>[
                                                  Flexible(
                                                    child: Text(
                                                      dataJenisAcara[index],
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
                                                      dataPack[index].toString(),
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
                                                      dataWaktu[index].toDate().toString().substring(10, 16),
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
                                                          'Detail',
                                                          style: TextStyle(
                                                              fontSize: 12.0,
                                                              color: AbubaPallate.menuBluebird),
                                                          textAlign: TextAlign.center,
                                                        ),
                                                        onPressed: () {

                                                          Firestore.instance.collection('event').where('id', isEqualTo: dataJenisAcaraID[index]).snapshots().listen((data3) { 
                                                            Firestore.instance.collection('user').where('id', isEqualTo: data3.documents[0].data['created_by']).snapshots().listen((data4){
                                                              Timestamp detailDate = data3.documents[0].data['waktu'];
                                                              showDialog(
                                                                barrierDismissible: false,
                                                                context: context,
                                                                builder: (context) => Dialog(
                                                                  child: Container(
                                                                    height: 400.0,
                                                                    child: Column(
                                                                      children: <Widget>[
                                                                        Container(
                                                                          color: AbubaPallate.greenabuba,
                                                                          height: 50.0,
                                                                          child: Center(
                                                                            child: Text(
                                                                              'Detail Acara',
                                                                              style: TextStyle(
                                                                                color: Colors.white,
                                                                                fontSize: 17.0,
                                                                                fontWeight: FontWeight.w700),
                                                                            ),
                                                                          ),
                                                                        ),
                                                                        Expanded(
                                                                          child: Scrollbar(
                                                                            child: Padding(
                                                                              padding: const EdgeInsets.all(15.0),
                                                                              child: ListView(
                                                                                children: <Widget>[
                                                                                  Row(
                                                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                    children: <Widget>[
                                                                                      Container(
                                                                                        width: MediaQuery.of(context).size.width * 0.30,
                                                                                        child: Row(
                                                                                          children: <Widget>[
                                                                                            Flexible(
                                                                                              child: Text(
                                                                                                'Nama Customer',
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
                                                                                                data3.documents[0].data['nama_customer'],
                                                                                                style: TextStyle(
                                                                                                  fontSize: 13.0,
                                                                                                  color: Colors.black38,
                                                                                                  fontWeight: FontWeight.w700
                                                                                                ),
                                                                                                textAlign: TextAlign.right,
                                                                                              ),
                                                                                            ),
                                                                                          ],
                                                                                        ),
                                                                                      )
                                                                                    ],
                                                                                  ),
                                                                                  SizedBox(
                                                                                    height: 15.0,
                                                                                  ),
                                                                                  Row(
                                                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                    children: <Widget>[
                                                                                      Container(
                                                                                        width: MediaQuery.of(context).size.width * 0.25,
                                                                                        child: Row(
                                                                                          children: <Widget>[
                                                                                            Flexible(
                                                                                              child: Text(
                                                                                                'No. Telpon',
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
                                                                                                data3.documents[0].data['no_telp'],
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
                                                                                  SizedBox(
                                                                                    height: 15.0,
                                                                                  ),
                                                                                  Row(
                                                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                    children: <Widget>[
                                                                                      Container(
                                                                                        width: MediaQuery.of(context).size.width * 0.25,
                                                                                        child: Row(
                                                                                          children: <Widget>[
                                                                                            Flexible(
                                                                                              child: Text(
                                                                                                'Email',
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
                                                                                                data3.documents[0].data['email'],
                                                                                                style: TextStyle(
                                                                                                  fontSize: 13.0,
                                                                                                  color: Colors.black38,
                                                                                                  fontWeight: FontWeight.w700
                                                                                                ),
                                                                                                textAlign: TextAlign.right,
                                                                                              ),
                                                                                            ),
                                                                                          ],
                                                                                        ),
                                                                                      )
                                                                                    ],
                                                                                  ),
                                                                                  SizedBox(
                                                                                    height: 15.0,
                                                                                  ),
                                                                                  Row(
                                                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                    children: <Widget>[
                                                                                      Container(
                                                                                        width: MediaQuery.of(context).size.width * 0.25,
                                                                                        child: Row(
                                                                                          children: <Widget>[
                                                                                            Flexible(
                                                                                              child: Text(
                                                                                                'Tanggal/Jam',
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
                                                                                                detailDate.toDate().toString().substring(8, 10) + '/' + detailDate.toDate().toString().substring(5, 7) + '/' + 
                                                                                                detailDate.toDate().toString().substring(0, 4) + ' ' + detailDate.toDate().toString().substring(10, 16),
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
                                                                                  SizedBox(
                                                                                    height: 15.0,
                                                                                  ),
                                                                                  Row(
                                                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                    children: <Widget>[
                                                                                      Container(
                                                                                        width: MediaQuery.of(context).size.width * 0.25,
                                                                                        child: Row(
                                                                                          children: <Widget>[
                                                                                            Flexible(
                                                                                              child: Text(
                                                                                                'Jumlah Orang',
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
                                                                                                data3.documents[0].data['jumlah_orang'].toString(),
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
                                                                                  SizedBox(
                                                                                    height: 15.0,
                                                                                  ),
                                                                                  Row(
                                                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                    children: <Widget>[
                                                                                      Container(
                                                                                        width: MediaQuery.of(context).size.width * 0.25,
                                                                                        child: Row(
                                                                                          children: <Widget>[
                                                                                            Flexible(
                                                                                              child: Text(
                                                                                                'Catatan',
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
                                                                                                data3.documents[0].data['catatan'],
                                                                                                style: TextStyle(
                                                                                                  fontSize: 13.0,
                                                                                                  color: Colors.black38,
                                                                                                  fontWeight: FontWeight.w700
                                                                                                ),
                                                                                                textAlign: TextAlign.right,
                                                                                              ),
                                                                                            ),
                                                                                          ],
                                                                                        ),
                                                                                      )
                                                                                    ],
                                                                                  ),
                                                                                  SizedBox(
                                                                                    height: 15.0,
                                                                                  ),
                                                                                  Row(
                                                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                    children: <Widget>[
                                                                                      Container(
                                                                                        width: MediaQuery.of(context).size.width * 0.25,
                                                                                        child: Row(
                                                                                          children: <Widget>[
                                                                                            Flexible(
                                                                                              child: Text(
                                                                                                'Dibuat Oleh',
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
                                                                                                data4.documents[0].data['nama'],
                                                                                                style: TextStyle(
                                                                                                  fontSize: 13.0,
                                                                                                  color: Colors.black38,
                                                                                                  fontWeight: FontWeight.w700
                                                                                                ),
                                                                                                textAlign: TextAlign.right,
                                                                                              ),
                                                                                            ),
                                                                                          ],
                                                                                        ),
                                                                                      )
                                                                                    ],
                                                                                  ),
                                                                                ],
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        ),
                                                                        Padding(
                                                                          padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
                                                                          child: Row(
                                                                            mainAxisAlignment: MainAxisAlignment.end,
                                                                            children: <Widget>[
                                                                              RaisedButton(
                                                                                color: Colors.green,
                                                                                child: Text(
                                                                                  'OK',
                                                                                  style: TextStyle(color: Colors.white, fontSize: 12.0)
                                                                                ),
                                                                                onPressed: () {
                                                                                  Navigator.of(context).pop();
                                                                                },
                                                                              )
                                                                            ],
                                                                          ),
                                                                        )
                                                                      ],
                                                                    ),
                                                                  ),
                                                                )

                                                              );
                                                            });
                                                          });

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
                                  ],
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    );
              },
            )

          ],
        ),
      ), 
    );
  }

  Widget _appBar() {
    return AppBar(
      elevation: 0.25,
      backgroundColor: Colors.white,
      iconTheme: IconThemeData(color: Colors.black),
      actions: <Widget>[
        IconButton(
          tooltip: 'Search',
          icon: Icon(Icons.search),
          onPressed: () {}
        )
      ],
      title: Image.asset(
        'assets/images/logo2.png',
        height: 150.0,
        width: 120.0,
      ),
    );
  }

}