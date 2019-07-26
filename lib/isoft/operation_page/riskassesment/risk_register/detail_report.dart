import 'package:flutter/material.dart';
import 'package:flutter_abuba/constant.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DetailReport extends StatefulWidget {
  final int idUser;
  final String namaUser;
  final String departmentUser;
  var index;
  final int noData;
  DetailReport({this.idUser, this.namaUser, this.departmentUser, this.index, this.noData});

  @override
  _DetailReportState createState() => _DetailReportState();
}

class _DetailReportState extends State<DetailReport>
    with TickerProviderStateMixin {
  AnimationController animationController;

  List<dynamic> userNama = [];
  List<dynamic> tanggal = [];
  List<dynamic> no = [];

  List<dynamic> kategori = [];
  List<dynamic> sop = [];
  List<dynamic> jenis = [];
  List<dynamic> jenisDesk = [];
  List<dynamic> sumber = [];
  List<dynamic> sumberDesk = [];
  List<dynamic> dampak = [];
  List<dynamic> dampakDesk = [];
  List<dynamic> severity = [];
  List<dynamic> likelihood = [];
  List<dynamic> risk = [];
  List<dynamic> pengendalian = [];
  List<dynamic> deskripsi = [];
  List<dynamic> pemantauan = [];
  List<dynamic> PIC = [];
  List<dynamic> verifikator = [];
  List<dynamic> idRisk = [];

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

      CollectionReference reference = Firestore.instance.collection('risk_assesment');
      reference.orderBy('createdTime', descending: true).snapshots().listen((querySnapshot) {
        querySnapshot.documentChanges.forEach((data) {
          setState(() {
            no.add(data.document.data['maxid'].toString().padLeft(4, '0'));
            Timestamp tanggalBantu = data.document.data['createdTime'];
            tanggal.add(tanggalBantu.toDate().toString().substring(8, 10) + '/' + tanggalBantu.toDate().toString().substring(5, 7) + '/'
                + tanggalBantu.toDate().toString().substring(0, 4));

            userNama.add(data.document.data['createdBy']);
            kategori.add(data.document.data['kategori']);
            sop.add(data.document.data['sop']);
            jenis.add(data.document.data['jenis']);
            jenisDesk.add(data.document.data['jenisDesk']);
            sumber.add(data.document.data['sumber']);
            sumberDesk.add(data.document.data['sumberDesk']);
            dampak.add(data.document.data['dampak']);
            dampakDesk.add(data.document.data['dampakDesk']);
            severity.add(data.document.data['severity']);
            likelihood.add(data.document.data['likelihood']);
            risk.add(data.document.data['risk']);
            pengendalian.add(data.document.data['pengendalian']);
            deskripsi.add(data.document.data['deskripsi']);
            pemantauan.add(data.document.data['pemantauan']);
            PIC.add(data.document.data['pic']);
            verifikator.add(data.document.data['verifikator']);
            idRisk.add(data.document.data['idRisk']);
          });
        });
      });


      /*Firestore.instance
        .collection('risk_assesment2')
        .document(widget.index)
        .snapshots()
        .listen((data) {
          no = data.data['maxid'].toString().padLeft(4, '0');
          Timestamp tanggalBantu = data.data['createdTime'];
          tanggal = tanggalBantu.toDate().toString().substring(8, 10) + '/' + tanggalBantu.toDate().toString().substring(5, 7) + '/'
              + tanggalBantu.toDate().toString().substring(0, 4);

          userNama = data.data['createdBy'];
          jenis = data.data['jenis'];
          sumber = data.data['sumber'];
          dampak = data.data['dampak'];
          severity = data.data['severity'];
          likelihood = data.data['likelihood'];
          risk = data.data['risk'];
          pengendalian = data.data['pengendalian'];
          deskripsi = data.data['deskripsi'];
          pemantauan = data.data['pemantauan'];
          PIC = data.data['pic'];
          verifikator = data.data['verifikator'];
      });*/
    });

    _cardController = new TabController(vsync: this, length: widget.noData);
    _tabPageSelector = new TabPageSelector(controller: _cardController);

    animationController =
        AnimationController(vsync: this, duration: Duration(seconds: 3));
    animationController.reverse(
        from:
            animationController.value == 0.0 ? 1.0 : animationController.value);
  }

  @override
  void dispose() {
    _cardController.dispose();
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
              : Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(left: 15.0, top: 15.0, bottom: 15.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'Report asdsad',
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
                        'Detail Report',
                        style: TextStyle(
                            color: AbubaPallate.greenabuba, fontSize: 12.0),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: TabBarView(
                    controller: _cardController,
                    children: List.generate(jenis.length, (index) {
                      return Container(
                        color: Colors.white,
                        child: ListView(
                          children: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Container(
                                  padding: const EdgeInsets.fromLTRB(12.0, 12.0, 12.0, 12.0),
                                  width: width,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Flexible(
                                        child: Text(
                                          'Risk Assesment RA-${no[index]}',
                                          style: TextStyle(
                                              fontSize: 14.0, fontWeight: FontWeight.w600, color: AbubaPallate.greenabuba),
                                        ),
                                      ),
                                      Flexible(
                                        child: Text(
                                          '${idRisk[index]} of ${jenis.length}',
                                          style: TextStyle(
                                              fontSize: 12.0, fontWeight: FontWeight.w600, color: Colors.black54),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            Divider(
                              height: 2.0,
                              color: Colors.grey,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 12.0, right: 12.0, top: 12.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Container(
                                    width: 150.0,
                                    child: Row(
                                      children: <Widget>[
                                        Flexible(
                                          child: Text(
                                            userNama[index] == null ? '-' : userNama[index],
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
                                      children: <Widget>[
                                        Flexible(
                                          child: Text(
                                            tanggal[index] == null ? '-' : tanggal[index],
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
                                  left: 12.0, right: 12.0, bottom: 12.0),
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
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Container(
                                  padding: const EdgeInsets.fromLTRB(12.0, 12.0, 12.0, 12.0),
                                  width: width / 3,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: <Widget>[
                                      Flexible(
                                        child: Text(
                                          'Kategori',
                                          style: TextStyle(
                                              fontSize: 14.0, fontWeight: FontWeight.w600, color: Colors.black54),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                Container(
                                  padding: const EdgeInsets.fromLTRB(12.0, 12.0, 12.0, 12.0),
                                  width: width / 2,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: <Widget>[
                                      Flexible(
                                        child: Text(
                                          kategori[index] == null ? '-' : kategori[index],
                                          style: TextStyle(color: Colors.grey, fontSize: 14.0),
                                          textAlign: TextAlign.left,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            Divider(
                              height: 2.0,
                              color: Colors.grey,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Container(
                                  padding: const EdgeInsets.fromLTRB(12.0, 12.0, 12.0, 12.0),
                                  width: width / 3,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: <Widget>[
                                      Flexible(
                                        child: Text(
                                          'SOP',
                                          style: TextStyle(
                                              fontSize: 14.0, fontWeight: FontWeight.w600, color: Colors.black54),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                Container(
                                  padding: const EdgeInsets.fromLTRB(12.0, 12.0, 12.0, 12.0),
                                  width: width / 2,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: <Widget>[
                                      Flexible(
                                        child: Text(
                                          sop[index] == null ? '-' : sop[index],
                                          style: TextStyle(color: Colors.grey, fontSize: 14.0),
                                          textAlign: TextAlign.left,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            Divider(
                              height: 2.0,
                              color: Colors.grey,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Container(
                                  padding:
                                  const EdgeInsets.fromLTRB(12.0, 12.0, 12.0, 12.0),
                                  width: width / 3,
                                  child: Column(
                                    children: <Widget>[
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: <Widget>[
                                          Flexible(
                                            child: Text(
                                              'Jenis',
                                              style: TextStyle(
                                                  fontSize: 14.0, fontWeight: FontWeight.w600, color: Colors.green),
                                            ),
                                          )
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: <Widget>[
                                          Flexible(
                                            child: Text(
                                              'Category',
                                              style: TextStyle(
                                                  fontSize: 14.0, fontWeight: FontWeight.w600, color: Colors.black54),
                                            ),
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                    padding:
                                    const EdgeInsets.fromLTRB(12.0, 12.0, 12.0, 12.0),
                                    width: width / 2,
                                    child: Column(
                                        children: List.generate(jenis[index].length, (indexJen) {
                                          List<dynamic> jenis2 = jenis[index];
                                          return Row(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            children: <Widget>[
                                              Flexible(
                                                child: Text(
                                                  '${(indexJen + 1).toString()}. ${jenis2[indexJen] == null ? '-' : jenis2[indexJen]}',
                                                  style: TextStyle(color: Colors.grey, fontSize: 14.0),
                                                  textAlign: TextAlign.left,
                                                ),
                                              ),
                                            ],
                                          );
                                        }).toList()
                                    )
                                ),
                              ],
                            ),
                            Divider(
                              height: 2.0,
                              color: Colors.grey,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Container(
                                  padding: const EdgeInsets.fromLTRB(12.0, 12.0, 12.0, 12.0),
                                  width: width / 3,
                                  child: Column(
                                    children: <Widget>[
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: <Widget>[
                                          Flexible(
                                            child: Text(
                                              'Jenis',
                                              style: TextStyle(
                                                  fontSize: 14.0, fontWeight: FontWeight.w600, color: Colors.black54),
                                            ),
                                          )
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: <Widget>[
                                          Flexible(
                                            child: Text(
                                              'Deskripsi',
                                              style: TextStyle(
                                                  fontSize: 14.0, fontWeight: FontWeight.w600, color: Colors.black54),
                                            ),
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  padding: const EdgeInsets.fromLTRB(12.0, 12.0, 12.0, 12.0),
                                  width: width / 2,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: <Widget>[
                                      Flexible(
                                        child: Text(
                                          jenisDesk[index] == null ? '-' : jenisDesk[index],
                                          style: TextStyle(color: Colors.grey, fontSize: 14.0),
                                          textAlign: TextAlign.left,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            Divider(
                              height: 2.0,
                              color: Colors.grey,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Container(
                                  padding:
                                  const EdgeInsets.fromLTRB(12.0, 12.0, 12.0, 12.0),
                                  width: width / 3,
                                  child: Column(
                                    children: <Widget>[
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: <Widget>[
                                          Flexible(
                                            child: Text(
                                              'Sumber',
                                              style: TextStyle(
                                                  fontSize: 14.0, fontWeight: FontWeight.w600, color: Colors.green),
                                            ),
                                          )
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: <Widget>[
                                          Flexible(
                                            child: Text(
                                              'Category',
                                              style: TextStyle(
                                                  fontSize: 14.0, fontWeight: FontWeight.w600, color: Colors.black54),
                                            ),
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  padding:
                                  const EdgeInsets.fromLTRB(12.0, 12.0, 12.0, 12.0),
                                  width: width / 2,
                                  child: Column(
                                      children: List.generate(sumber[index].length, (indexSum) {
                                        List<dynamic> sumber2 = sumber[index];
                                        return Row(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          children: <Widget>[
                                            Flexible(
                                              child: Text(
                                                '${(indexSum + 1).toString()}. ${sumber2[indexSum] == null ? '-' : sumber2[indexSum]}',
                                                style: TextStyle(color: Colors.grey, fontSize: 14.0),
                                                textAlign: TextAlign.left,
                                              ),
                                            ),
                                          ],
                                        );
                                      }).toList()
                                  )
                                ),
                              ],
                            ),
                            Divider(
                              height: 2.0,
                              color: Colors.grey,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Container(
                                  padding: const EdgeInsets.fromLTRB(12.0, 12.0, 12.0, 12.0),
                                  width: width / 3,
                                  child: Column(
                                    children: <Widget>[
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: <Widget>[
                                          Flexible(
                                            child: Text(
                                              'Sumber',
                                              style: TextStyle(
                                                  fontSize: 14.0, fontWeight: FontWeight.w600, color: Colors.black54),
                                            ),
                                          )
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: <Widget>[
                                          Flexible(
                                            child: Text(
                                              'Deskripsi',
                                              style: TextStyle(
                                                  fontSize: 14.0, fontWeight: FontWeight.w600, color: Colors.black54),
                                            ),
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  padding: const EdgeInsets.fromLTRB(12.0, 12.0, 12.0, 12.0),
                                  width: width / 2,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: <Widget>[
                                      Flexible(
                                        child: Text(
                                          sumberDesk[index] == null ? '-' : sumberDesk[index],
                                          style: TextStyle(color: Colors.grey, fontSize: 14.0),
                                          textAlign: TextAlign.left,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            Divider(
                              height: 2.0,
                              color: Colors.grey,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Container(
                                  padding:
                                  const EdgeInsets.fromLTRB(12.0, 12.0, 12.0, 12.0),
                                  width: width / 3,
                                  child: Column(
                                    children: <Widget>[
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: <Widget>[
                                          Flexible(
                                            child: Text(
                                              'Dampak',
                                              style: TextStyle(
                                                  fontSize: 14.0, fontWeight: FontWeight.w600, color: Colors.green),
                                            ),
                                          )
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: <Widget>[
                                          Flexible(
                                            child: Text(
                                              'Category',
                                              style: TextStyle(
                                                  fontSize: 14.0, fontWeight: FontWeight.w600, color: Colors.black54),
                                            ),
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  padding:
                                  const EdgeInsets.fromLTRB(12.0, 12.0, 12.0, 12.0),
                                  width: width / 2,
                                  child: Column(
                                      children: List.generate(dampak[index].length, (indexDam) {
                                        List<dynamic> dampak2 = dampak[index];
                                        return Row(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          children: <Widget>[
                                            Flexible(
                                              child: Text(
                                                '${(indexDam + 1).toString()}. ${dampak2[indexDam] == null ? '-' :  dampak2[indexDam]} ',
                                                style: TextStyle(color: Colors.grey, fontSize: 14.0),
                                                textAlign: TextAlign.left,
                                              ),
                                            ),
                                          ],
                                        );
                                      }).toList()
                                  )
                                ),
                              ],
                            ),
                            Divider(
                              height: 2.0,
                              color: Colors.grey,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Container(
                                  padding: const EdgeInsets.fromLTRB(12.0, 12.0, 12.0, 12.0),
                                  width: width / 3,
                                  child: Column(
                                    children: <Widget>[
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: <Widget>[
                                          Flexible(
                                            child: Text(
                                              'Dampak',
                                              style: TextStyle(
                                                  fontSize: 14.0, fontWeight: FontWeight.w600, color: Colors.black54),
                                            ),
                                          )
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: <Widget>[
                                          Flexible(
                                            child: Text(
                                              'Deskripsi',
                                              style: TextStyle(
                                                  fontSize: 14.0, fontWeight: FontWeight.w600, color: Colors.black54),
                                            ),
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  padding: const EdgeInsets.fromLTRB(12.0, 12.0, 12.0, 12.0),
                                  width: width / 2,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: <Widget>[
                                      Flexible(
                                        child: Text(
                                          dampakDesk[index] == null ? '-' : dampakDesk[index],
                                          style: TextStyle(color: Colors.grey, fontSize: 14.0),
                                          textAlign: TextAlign.left,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            Divider(
                              height: 2.0,
                              color: Colors.grey,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Container(
                                  padding:
                                  const EdgeInsets.fromLTRB(12.0, 12.0, 12.0, 12.0),
                                  width: width / 3,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: <Widget>[
                                      Flexible(
                                        child: Text(
                                          'Severity',
                                          style: TextStyle(
                                              fontSize: 14.0, fontWeight: FontWeight.w600, color: Colors.black54),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                Container(
                                  padding:
                                  const EdgeInsets.fromLTRB(12.0, 12.0, 12.0, 12.0),
                                  width: width / 2,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: <Widget>[
                                      Flexible(
                                        child: Text(
                                          severity[index],
                                          style: TextStyle(color: Colors.grey),
                                          textAlign: TextAlign.left,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            Divider(
                              height: 2.0,
                              color: Colors.grey,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Container(
                                  padding:
                                  const EdgeInsets.fromLTRB(12.0, 12.0, 12.0, 12.0),
                                  width: width / 3,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: <Widget>[
                                      Flexible(
                                        child: Text(
                                          'Likelihood',
                                          style: TextStyle(
                                              fontSize: 14.0, fontWeight: FontWeight.w600, color: Colors.black54),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                Container(
                                  padding:
                                  const EdgeInsets.fromLTRB(12.0, 12.0, 12.0, 12.0),
                                  width: width / 2,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: <Widget>[
                                      Flexible(
                                        child: Text(
                                          likelihood[index],
                                          style: TextStyle(color: Colors.grey),
                                          textAlign: TextAlign.left,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            Divider(
                              height: 2.0,
                              color: Colors.grey,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Container(
                                  padding:
                                  const EdgeInsets.fromLTRB(12.0, 12.0, 12.0, 12.0),
                                  width: width / 3,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: <Widget>[
                                      Flexible(
                                        child: Text(
                                          'Risk',
                                          style: TextStyle(
                                              fontSize: 14.0, fontWeight: FontWeight.w600, color: Colors.black54),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                Container(
                                  color: risk[index] == 'High' ? Colors.redAccent : risk[index] == 'Medium' ? Colors.orangeAccent : Colors.green,
                                  padding: const EdgeInsets.fromLTRB(12.0, 12.0, 12.0, 12.0),
                                  width: width / 2,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: <Widget>[
                                      Flexible(
                                        child: Text(
                                          risk[index],
                                          style: TextStyle(color: Colors.white),
                                          textAlign: TextAlign.left,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            Divider(
                              height: 2.0,
                              color: Colors.grey,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Container(
                                  padding:
                                  const EdgeInsets.fromLTRB(12.0, 12.0, 12.0, 12.0),
                                  width: width / 3,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: <Widget>[
                                      Flexible(
                                        child: Text(
                                          'Pengendalian',
                                          style: TextStyle(
                                              fontSize: 14.0, fontWeight: FontWeight.w600, color: Colors.black54),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                Container(
                                  padding:
                                  const EdgeInsets.fromLTRB(12.0, 12.0, 12.0, 12.0),
                                  width: width / 2,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: <Widget>[
                                      Flexible(
                                        child: Text(
                                          pengendalian[index],
                                          style: TextStyle(color: Colors.grey),
                                          textAlign: TextAlign.left,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            Divider(
                              height: 2.0,
                              color: Colors.grey,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Container(
                                  padding:
                                  const EdgeInsets.fromLTRB(12.0, 12.0, 12.0, 12.0),
                                  width: width / 3,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: <Widget>[
                                      Flexible(
                                        child: Text(
                                          'Deskripsi',
                                          style: TextStyle(
                                              fontSize: 14.0, fontWeight: FontWeight.w600, color: Colors.black54),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                Container(
                                  padding:
                                  const EdgeInsets.fromLTRB(12.0, 12.0, 12.0, 12.0),
                                  width: width / 2,
                                  child: Column(
                                      children: List.generate(deskripsi[index].length, (indexD) {
                                        List<dynamic> deskripsi2 = deskripsi[index];
                                        return Row(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          children: <Widget>[
                                            Flexible(
                                              child: Text(
                                                '${(indexD + 1).toString()}. ${deskripsi2[indexD]}',
                                                style: TextStyle(color: Colors.grey, fontSize: 14.0),
                                                textAlign: TextAlign.left,
                                              ),
                                            ),
                                          ],
                                        );
                                      }).toList()
                                  )
                                ),
                              ],
                            ),
                            Divider(
                              height: 2.0,
                              color: Colors.grey,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Container(
                                  padding:
                                  const EdgeInsets.fromLTRB(12.0, 12.0, 12.0, 12.0),
                                  width: width / 3,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: <Widget>[
                                      Flexible(
                                        child: Text(
                                          'Pemantauan',
                                          style: TextStyle(
                                              fontSize: 14.0, fontWeight: FontWeight.w600, color: Colors.black54),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                Container(
                                  padding:
                                  const EdgeInsets.fromLTRB(12.0, 12.0, 12.0, 12.0),
                                  width: width / 2,
                                  child: Column(
                                      children: List.generate(pemantauan[index].length, (indexPem) {
                                        List<dynamic> pemantauan2 = pemantauan[index];
                                        return Row(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          children: <Widget>[
                                            Flexible(
                                              child: Text(
                                                '${(indexPem + 1).toString()}. ${pemantauan2[indexPem]}',
                                                style: TextStyle(color: Colors.grey, fontSize: 14.0),
                                                textAlign: TextAlign.left,
                                              ),
                                            ),
                                          ],
                                        );
                                      }).toList()
                                  )
                                ),
                              ],
                            ),
                            Divider(
                              height: 2.0,
                              color: Colors.grey,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Container(
                                  padding:
                                  const EdgeInsets.fromLTRB(12.0, 12.0, 12.0, 12.0),
                                  width: width / 3,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: <Widget>[
                                      Flexible(
                                        child: Text(
                                          'PIC',
                                          style: TextStyle(
                                              fontSize: 14.0, fontWeight: FontWeight.w600, color: Colors.black54),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                Container(
                                  padding:
                                  const EdgeInsets.fromLTRB(12.0, 12.0, 12.0, 12.0),
                                  width: width / 2,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: <Widget>[
                                      Flexible(
                                        child: Text(
                                          PIC[index],
                                          style: TextStyle(color: Colors.grey),
                                          textAlign: TextAlign.left,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            Divider(
                              height: 2.0,
                              color: Colors.grey,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Container(
                                  padding:
                                  const EdgeInsets.fromLTRB(12.0, 12.0, 12.0, 12.0),
                                  width: width / 3,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: <Widget>[
                                      Flexible(
                                        child: Text(
                                          'Verifikator',
                                          style: TextStyle(
                                              fontSize: 14.0, fontWeight: FontWeight.w600, color: Colors.black54),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                Container(
                                  padding:
                                  const EdgeInsets.fromLTRB(12.0, 12.0, 12.0, 12.0),
                                  width: width / 2,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: <Widget>[
                                      Flexible(
                                        child: Text(
                                          verifikator[index],
                                          style: TextStyle(color: Colors.grey),
                                          textAlign: TextAlign.left,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            Divider(
                              height: 2.0,
                              color: Colors.grey,
                            ),
                          ],
                        ),
                      );
                    }).toList()
                ),
              ),
              /*Container(
                height: 30.0,
                width: MediaQuery.of(context).size.width,
                child: _tabPageSelector,
                alignment: Alignment.center,
              ),*/

            ],
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
