import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_abuba/constant.dart';

class RDreportDetail extends StatefulWidget {
  var eksperimenID;
  final int idUser;
  final List<dynamic> parameter;
  final List<dynamic> kirimKepada;
  final List<dynamic> score;

  RDreportDetail({this.eksperimenID, this.idUser, this.parameter, this.kirimKepada, this.score});

  @override
  _RDreportDetailState createState() => _RDreportDetailState();
}

class _RDreportDetailState extends State<RDreportDetail> with TickerProviderStateMixin {
  AnimationController animationController;
  var ratingChiller = 0.0;

  List<String> parameterView = [];
  List<double> ratingParameter = [];
  List<String> kirimKepada = [];
  List<dynamic> note = [];
  List<dynamic> approveDate = [];
  List<dynamic> status = [];
  List<dynamic> score = [];

  Timestamp tanggalEksperimen2;

  String namaProduk;
  List<dynamic> _komposisi_ = [];
  String category;
  String tujuan;

  String namaCreated;
  String departmentCreated;
  Timestamp dateCreated;

  TextEditingController controllerNoteSatu = new TextEditingController();
  @override
  void initState() {
    super.initState();

    Firestore.instance.collection('rnd_eksperimen').document(widget.eksperimenID).snapshots().listen((data) {
      setState(() {
        note = data.data['catatan'];
        approveDate = data.data['approveDate'];
        status = data.data['status'];
        tujuan = data.data['tujuan'];
        
        _komposisi_ = data.data['komposisi'];
        tanggalEksperimen2 = data.data['date_eksperimen'];
        dateCreated = data.data['dateCreated'];

        Firestore.instance.collection('product_complaint-mg').where('id', isEqualTo: data.data['id_product']).snapshots().listen((data2) {
          namaProduk = data2.documents[0].data['product'];
        });

        Firestore.instance.collection('user').where('id', isEqualTo: data.data['userCreated']).snapshots().listen((data5) {
          namaCreated = data5.documents[0].data['nama'];

          Firestore.instance.collection('department').where('id', isEqualTo: data5.documents[0].data['departmentID']).snapshots().listen((data6) {
            departmentCreated = data6.documents[0].data['department'];
          });
        });

        Firestore.instance.collection('rnd_eksperimen_category').where('id', isEqualTo: data.data['id_eksperimen_category']).snapshots().listen((data3) {
          category = data3.documents[0].data['category'];
        });
      });
    });

    for (int a = 0; a < widget.parameter.length; a++) {
      Firestore.instance.collection('rnd_parameter').where('id', isEqualTo: widget.parameter[a]).snapshots().listen((data4) {
        setState(() {
          parameterView.add(data4.documents[0].data['parameter']);
          ratingParameter.add(0.0);
        });
      });
    }

    for (int q = 0; q < widget.kirimKepada.length; q++) {
      Firestore.instance.collection('user').where('id', isEqualTo: widget.kirimKepada[q]).snapshots().listen((data5) {
        setState(() {
          kirimKepada.add(data5.documents[0].data['nama']);
        });
      });
    }

    for (int w = 0; w < widget.score.length; w++) {
      setState(() {
        score.add(widget.score[w].toString().split(','));
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
                  'Daftar',
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
                    'Analisa',
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
                                      'Nama Produk',
                                      style: TextStyle(
                                          fontSize: 14.0, color: Colors.black87, fontWeight: FontWeight.w500
                                      ),
                                    ),
                                  ),
                                  Flexible(
                                    child: Text(
                                      namaProduk,
                                      style: TextStyle(
                                          fontSize: 13.0,
                                          color: Colors.black38,
                                          fontWeight: FontWeight.w700
                                      ),
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
                                      'Komposisi',
                                      style: TextStyle(
                                          fontSize: 14.0, color: Colors.black87, fontWeight: FontWeight.w500
                                      ),
                                    ),
                                  ),
                                  Flexible(
                                    child: Text(
                                      _komposisi_.join(', ').toString(),
                                      style: TextStyle(
                                          fontSize: 13.0,
                                          color: Colors.black38,
                                          fontWeight: FontWeight.w700
                                      ),
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
                                      'Tanggal Experiment',
                                      style: TextStyle(
                                          fontSize: 14.0, color: Colors.black87, fontWeight: FontWeight.w500
                                      ),
                                    ),
                                  ),
                                  Flexible(
                                    child: Text(
                                      tanggalEksperimen2.toDate().toString().substring(8, 10) + '/' + tanggalEksperimen2.toDate().toString().substring(5, 7) + '/' + 
                                      tanggalEksperimen2.toDate().toString().substring(0, 4),
                                      style: TextStyle(
                                          fontSize: 13.0,
                                          color: Colors.black38,
                                          fontWeight: FontWeight.w700
                                      ),
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
                                      'Category Experiment',
                                      style: TextStyle(
                                          fontSize: 14.0, color: Colors.black87, fontWeight: FontWeight.w500
                                      ),
                                    ),
                                  ),
                                  Flexible(
                                    child: Text(
                                      category,
                                      style: TextStyle(
                                          color: AbubaPallate.menuBluebird, fontSize: 12.0),
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
                                      'Tujuan Experiment',
                                      style: TextStyle(
                                          fontSize: 14.0, color: Colors.black87, fontWeight: FontWeight.w500
                                      ),
                                    ),
                                  ),
                                  Flexible(
                                    child: Text(
                                      tujuan,
                                      style: TextStyle(
                                          fontSize: 13.0,
                                          color: Colors.black38,
                                          fontWeight: FontWeight.w700
                                      ),
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
                                      'Kirim kepada : ',
                                      style: TextStyle(
                                          fontSize: 14.0, color: Colors.black87, fontWeight: FontWeight.w500
                                      ),
                                    ),
                                  ),
                                  Flexible(
                                    child: Text(
                                      kirimKepada.join(', ').toString(),
                                      style: TextStyle(
                                          fontSize: 13.0,
                                          color: Colors.black38,
                                          fontWeight: FontWeight.w700
                                      ),
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
                                      'Diajukan oleh',
                                      style: TextStyle(
                                          fontSize: 14.0, color: Colors.black87, fontWeight: FontWeight.w500
                                      ),
                                    ),
                                  ),
                                  Flexible(
                                    child: Text(
                                      '$namaCreated - $departmentCreated',
                                      style: TextStyle(
                                          fontSize: 13.0,
                                          color: Colors.black38,
                                          fontWeight: FontWeight.w700
                                      ),
                                      textAlign: TextAlign.right,
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(12.0, 6.0, 12.0, 12.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: <Widget>[
                                  Flexible(
                                    child: Text(
                                      dateCreated.toDate().toString().substring(8, 10) + '/' + dateCreated.toDate().toString().substring(5, 7) + '/' + dateCreated.toDate().toString().substring(0, 4),
                                      style: TextStyle(color: Colors.black54, fontSize: 12.0),
                                      textAlign: TextAlign.right,
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Divider(
                              height: 3.0,
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(12.0, 12.0, 12.0, 6.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  Flexible(
                                    child: Text(
                                      'Analisa',
                                      style: TextStyle(
                                          fontSize: 15.0,
                                          fontWeight: FontWeight.w600,
                                          color: AbubaPallate.green),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),

                      Container(
                        color: Colors.white,
                        child: Column(
                          children: List.generate(kirimKepada.length, (index) {
                            return status[index] == 'OPEN'
                            ? Container()
                            : Column(
                              children: <Widget>[
                                Container(
                                  color: Colors.white,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: <Widget>[
                                      Padding(
                                        padding: const EdgeInsets.fromLTRB(12.0, 12.0, 12.0, 6.0),
                                        child: Text(
                                          kirimKepada[index],
                                          style: TextStyle(
                                              fontSize: 15.0,
                                              fontWeight: FontWeight.w600,
                                              color: Colors.black54),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),

                                // RaisedButton(
                                //   child: Text('dfs'),
                                //   onPressed: () {
                                //     print(status[index]);
                                //   },
                                // ),

                                Container(
                                  color: Colors.white,
                                  child: Column(
                                    children: List.generate(parameterView.length, (index2) {
                                      return Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Container(
                                            padding: const EdgeInsets.fromLTRB(12.0, 6.0, 12.0, 12.0),
                                            width: 150.0,
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              children: <Widget>[
                                                Flexible(
                                                  child: Text(
                                                    parameterView[index2],
                                                    style: TextStyle(
                                                        fontSize: 14.0, fontWeight: FontWeight.w100),
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                          Flexible(
                                            child: Padding(
                                              padding: const EdgeInsets.fromLTRB(12.0, 0.0, 6.0, 12.0),
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.end,
                                                children: <Widget>[
                                                  Row(
                                                    mainAxisAlignment: MainAxisAlignment.end,
                                                    children: List.generate(double.tryParse(score[index][index2].toString()).round(), (index) {
                                                      return Icon(
                                                        Icons.star,
                                                        size: 18.0,
                                                        color: Colors.orangeAccent
                                                      );
                                                    }).toList()
                                                  ),
                                                  Row(
                                                    mainAxisAlignment: MainAxisAlignment.end,
                                                    children: List.generate(5 - double.tryParse(score[index][index2].toString()).round(), (index) {
                                                      return Icon(
                                                        Icons.star_border,
                                                        size: 18.0,
                                                        color: Colors.grey
                                                      );
                                                    }).toList()
                                                  ),
                                                ],
                                              )
                                            ),
                                          ),
                                        ],
                                      );
                                    }).toList()
                                  ),
                                ),
                                note[index] == '' || note[index] == null
                                  ? Container()
                                  : Column(
                                    children: <Widget>[
                                      Container(
                                        color: Colors.white,
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          children: <Widget>[
                                            Padding(
                                              padding: const EdgeInsets.fromLTRB(12.0, 12.0, 12.0, 6.0),
                                              child: Text(
                                                'Catatan',
                                                style: TextStyle(
                                                    fontSize: 15.0,
                                                    fontWeight: FontWeight.w600,
                                                    color: Colors.black54),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        width: MediaQuery.of(context).size.width,
                                        padding: const EdgeInsets.fromLTRB(12.0, 6.0, 12.0, 6.0),
                                        color: Colors.white,
                                        child: Container(
                                          child: Padding(
                                            padding:
                                                const EdgeInsets.only(top: 15.0, bottom: 15.0, left: 10.0),
                                            child: Text(
                                              note[index],
                                              style: TextStyle(color: Colors.black38),
                                            ),
                                          ),
                                          decoration: BoxDecoration(
                                              color: Colors.grey[200],
                                              border: Border.all(color: Colors.black12, width: 2.0)),
                                        ),
                                      ),
                                    ],
                                  ),
                                Container(
                                  color: Colors.white,
                                  child: Divider(
                                    height: 3.0,
                                  ),
                                ),
                              ],
                            );
                          }).toList(),
                        ),
                      ),

                      Container(
                        color: Colors.white,
                        width: MediaQuery.of(context).size.width,
                        child: Column(
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.fromLTRB(12.0, 12.0, 12.0, 8.0),
                              child: Row(
                                children: <Widget>[
                                  Flexible(
                                    child: Text(
                                      'Kesimpulan',
                                      style: TextStyle(color: Colors.green, fontSize: 15.0),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        color: Colors.white,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: List.generate(kirimKepada.length, (index) {
                             return status[index] == 'OPEN'
                             ? Container()
                             : Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Expanded(
                                  child: Container(
                                    width: MediaQuery.of(context).size.width * 0.2,
                                    padding: const EdgeInsets.fromLTRB(12.0, 12.0, 12.0, 5.0),
                                    child: ButtonTheme(
                                      height: 30.0,
                                      child: OutlineButton(
                                        child: Padding(
                                          padding: const EdgeInsets.only(top: 3.0),
                                          child: Text(
                                            status[index],
                                            style:
                                                TextStyle(fontSize: 13.0, color: status[index] == 'REJECTED' ? Colors.redAccent : status[index] == 'APPROVED' ? AbubaPallate.greenabuba : Colors.black45),
                                          ),
                                        ),
                                        borderSide:
                                            BorderSide(color: status[index] == 'REJECTED' ? Colors.redAccent : status[index] == 'APPROVED' ? AbubaPallate.greenabuba : Colors.black45, width: 1.0),
                                        highlightedBorderColor: status[index] == 'REJECTED' ? Colors.redAccent : status[index] == 'APPROVED' ? AbubaPallate.greenabuba : Colors.black45,
                                        onPressed: () {},
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Container(
                                    padding: const EdgeInsets.fromLTRB(12.0, 12.0, 12.0, 5.0),
                                    width: MediaQuery.of(context).size.width * 0.5,
                                    child: Column(
                                      children: <Widget>[
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.end,
                                          children: <Widget>[
                                            Flexible(
                                              child: Text(
                                                kirimKepada[index],
                                                style: TextStyle(color: Colors.grey),
                                                textAlign: TextAlign.right,
                                              ),
                                            )
                                          ],
                                        ),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.end,
                                          children: <Widget>[
                                            Flexible(
                                              child: Text(
                                                approveDate[index] == null ? '-' : approveDate[index].toDate().toString().substring(8, 10) + '/' + approveDate[index].toDate().toString().substring(5, 7) + '/' + approveDate[index].toDate().toString().substring(0, 4),
                                                style: TextStyle(color: Colors.grey),
                                                textAlign: TextAlign.right,
                                              ),
                                            )
                                          ],
                                        )
                                      ],
                                    )
                                  ),
                                ),
                              ],
                            );
                          }).toList()
                        ),
                      ),
                    ],
                  );
            },
          )
        ],
      ),
    );
  }
}
