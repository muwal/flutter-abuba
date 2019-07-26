import 'package:flutter/material.dart';
import 'package:flutter_abuba/constant.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DetailReport extends StatefulWidget {
  final int idUser;
  final String namaUser;
  final String departmentUser;
  var index;
  final List<dynamic> pertanyaan;
  final List<dynamic> score;
  DetailReport({this.idUser, this.namaUser, this.departmentUser, this.index, this.pertanyaan, this.score});

  @override
  _DetailReportState createState() => _DetailReportState();
}

class _DetailReportState extends State<DetailReport>
    with TickerProviderStateMixin {
  AnimationController animationController;

  String userNama;
  String tanggal;
  String no;

  String noPolisi;
  String namaCust;
  String namaSupir;

  String status;

  /*String jenis;
  String sumber;
  String dampak;
  String severity;
  String likelihood;
  String risk;
  String pengendalian;
  String deskripsi;
  String pemantauan;
  String PIC;
  String verifikator;*/

  TabController _cardController;
  TabPageSelector _tabPageSelector;

  @override
  void initState() {

    super.initState();
    setState(() {

      Firestore.instance
        .collection('kitchen')
        .document(widget.index)
        .snapshots()
        .listen((data) {
          no = data.data['maxid'].toString().padLeft(4, '0');
          Timestamp tanggalBantu = data.data['dateCreated'];
          tanggal = tanggalBantu.toDate().toString().substring(8, 10) + '/' + tanggalBantu.toDate().toString().substring(5, 7) + '/'
              + tanggalBantu.toDate().toString().substring(0, 4);

          userNama = data.data['userCreated'];
          noPolisi = data.data['noPolisi'];
          namaCust = data.data['namaCust'];
          namaSupir = data.data['namaSupir'];
          status = data.data['status'];
      });
    });


    animationController =
        AnimationController(vsync: this, duration: Duration(seconds: 3));
    animationController.reverse(
        from:
            animationController.value == 0.0 ? 1.0 : animationController.value);
  }

  @override
  void dispose() {
    super.dispose();
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
        body: _formDetail(context),
      ),
    );
  }

  Widget _formDetail(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;

    return Scrollbar(

      child: AnimatedBuilder(
        animation: animationController,
        builder: (_, Widget child) {
          return animationController.isAnimating
              ? Container(
            child: Center(
              child: CircularProgressIndicator(),
            ),
          )
              : Scrollbar(
              child: ListView(

                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(left: 15.0, top: 15.0, bottom: 15.0),
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
                            'Kitchen No. K-${no}',
                            style: TextStyle(
                                color: AbubaPallate.greenabuba, fontSize: 12.0),
                          ),
                        ),
                      ],
                    ),
                  ),

                  Container(
                    color: Colors.white,
                    child: Column(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 15.0, right: 12.0, top: 12.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Container(
                                width: 150.0,
                                child: Row(
                                  children: <Widget>[
                                    Flexible(
                                      child: Text(
                                        userNama == null ? '' : userNama,
                                        style: TextStyle(
                                            fontSize: 12.0,
                                            color: Colors.black54),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                width: 150.0,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: <Widget>[
                                    Flexible(
                                      child: Text(
                                        tanggal,
                                        style: TextStyle(
                                            fontSize: 12.0,
                                            color: Colors.black54),
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),

                        Padding(
                          padding: const EdgeInsets.only(
                              left: 15.0, right: 12.0, bottom: 12.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Container(
                                width: 150.0,
                                child: Row(
                                  children: <Widget>[
                                    Flexible(
                                      child: Text(
                                        'Diinput oleh',
                                        style: TextStyle(
                                            fontSize: 10.0,
                                            color: Colors.black38),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              Container(
                                width: 150.0,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: <Widget>[
                                    Flexible(
                                      child: Text(
                                        'Tanggal input',
                                        style: TextStyle(
                                            fontSize: 10.0,
                                            color: Colors.black38),
                                      ),
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                        Divider(
                          height: 2.0,
                          color: Colors.grey,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              right: 15.0, left: 15.0, top: 10.0),
                          child: Row(
                            mainAxisAlignment:
                            MainAxisAlignment.end,
                            children: <Widget>[
                              Flexible(
                                child: Text(
                                  status == 'Approved' ? 'APPROVED' : 'REJECTED',
                                  style: TextStyle(
                                    fontSize: 14.0,
                                    fontWeight: FontWeight.w700,
                                    color:
                                    status == 'Approved' ? AbubaPallate.green : status == 'Rejected' ? AbubaPallate.menuFood : Colors.blue,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 15.0, vertical: 10.0),
                          child: Row(
                            mainAxisAlignment:
                            MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Flexible(
                                child: Text(
                                  'No. Polisi',
                                  style: TextStyle(
                                    fontSize: 14.0,
                                    color: Colors.black87,
                                  ),
                                ),
                              ),
                              Flexible(
                                child: Text(
                                  noPolisi == null ? '-' : noPolisi,
                                  style: TextStyle(
                                    fontSize: 14.0,
                                    color: Colors.black54,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 15.0, vertical: 10.0),
                          child: Row(
                            mainAxisAlignment:
                            MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Flexible(
                                child: Text(
                                  'Nama Supir',
                                  style: TextStyle(
                                    fontSize: 14.0,
                                    color: Colors.black87,
                                  ),
                                ),
                              ),
                              Flexible(
                                child: Text(
                                  namaSupir == null ? '-' : namaSupir,
                                  style: TextStyle(
                                    fontSize: 14.0,
                                    color: Colors.black54,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 15.0, vertical: 10.0),
                          child: Row(
                            mainAxisAlignment:
                            MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Flexible(
                                child: Text(
                                  'Nama Customer',
                                  style: TextStyle(
                                    fontSize: 14.0,
                                    color: Colors.black87,
                                  ),
                                ),
                              ),
                              Flexible(
                                child: Text(
                                  namaCust == null ? '-' : namaCust,
                                  style: TextStyle(
                                    fontSize: 14.0,
                                    color: Colors.black54,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              right: 15.0, left: 15.0, top: 10.0),
                          child: Row(
                            mainAxisAlignment:
                            MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Flexible(
                                child: Text(
                                  'PARAMETER',
                                  style: TextStyle(
                                    fontSize: 14.0,
                                    fontWeight: FontWeight.w700,
                                    color:
                                    /*widget.hasilAreaLuar * 100 > 85.0
                                      ? Colors.green
                                      : widget.hasilAreaLuar * 100 < 70.0
                                      ? Colors.redAccent
                                      : Colors.orangeAccent,*/
                                    Colors.green,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Column(
                          children: List.generate(
                            widget.pertanyaan.length,
                                (index) {
                              return Column(
                                children: <Widget>[
                                  ListTile(
                                    title: Container(
                                      width: 270.0,
                                      child: Column(
                                        children: <Widget>[
                                          Row(
                                            children: <Widget>[
                                              Flexible(
                                                child: Text(
                                                  '${index + 1}. ${widget.pertanyaan[index]}',
                                                  style: TextStyle(
                                                      color:
                                                      Colors.black54,
                                                      fontSize: 14.0),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                    trailing: Container(
                                      width: 30.0,
                                      child: Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment
                                            .spaceBetween,
                                        children: <Widget>[
                                          Flexible(
                                            child: Text(
                                              widget.score[
                                              index] ==
                                                  0
                                                  ? 'NO'
                                                  : 'YES',
                                              style: TextStyle(
                                                  color:
                                                  widget.score[
                                                  index] ==
                                                      0
                                                      ? Colors
                                                      .redAccent
                                                      : Colors.black54,
                                                  fontWeight:
                                                  FontWeight.w700),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),

                ],
              )
          );
        },
      )
    );
  }

  Widget _buildFormReport(double width) {
    return Scrollbar(
      child: ListView(
        children: <Widget>[

        ],
      ),
    );
  }
}
