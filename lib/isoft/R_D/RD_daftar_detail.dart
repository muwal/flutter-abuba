import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_abuba/constant.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

class RDdaftarDetail extends StatefulWidget {
  var eksperimenID;
  final int idUser;
  final List<dynamic> parameter;
  List<dynamic> status;
  List<dynamic> dateApprove;
  var indexUpdate;
  List<dynamic> score;
  List<dynamic> note;

  RDdaftarDetail({this.eksperimenID, this.idUser, this.parameter, this.dateApprove, this.status, this.indexUpdate, this.score, this.note});

  @override
  _RDdaftarDetailState createState() => _RDdaftarDetailState();
}

class _RDdaftarDetailState extends State<RDdaftarDetail> with TickerProviderStateMixin {
  AnimationController animationController;
  bool _note = false;
  var ratingChiller = 0.0;
  String namaProduk;
  String category;
  String tujuan;
  var tanggalEksperimen;

  bool reject = false;
  bool approve = false;

  List<dynamic> _komposisi_ = [];
  List<dynamic> kirim_kepada = [];

  List<String> parameterView = [];
  List<dynamic> ratingParameter = [];

  var statusApprove;
  var dateApprove;
  var score;
  var note;

  TextEditingController controllerNoteSatu = new TextEditingController();
  TextEditingController _catatan_ = new TextEditingController();

  @override
  void initState() { 
    super.initState();
    Firestore.instance.collection('rnd_eksperimen').document(widget.eksperimenID).snapshots().listen((data) {
      _komposisi_ = data.data['komposisi'];
      Timestamp tanggalEksperimen2 = data.data['date_eksperimen'];
      tanggalEksperimen = tanggalEksperimen2;
      tujuan = data.data['tujuan'];

      for(int i = 0; i < data.data['kirim_kepada'].length; i++){ 
        Firestore.instance.collection('user').where('id', isEqualTo: data.data['kirim_kepada'][i]).snapshots().listen((data4) {
          kirim_kepada.add(data4.documents[0].data['nama']);
        });
      }

      Firestore.instance.collection('product_complaint-mg').where('id', isEqualTo: data.data['id_product']).snapshots().listen((data2) {
        namaProduk = data2.documents[0].data['product'];
        print(data2.documents[0].data['product']);
      });

      Firestore.instance.collection('rnd_eksperimen_category').where('id', isEqualTo: data.data['id_eksperimen_category']).snapshots().listen((data3) {
        category = data3.documents[0].data['category'];
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

    setState(() {
      statusApprove = List<String>.from(widget.status);
      dateApprove =  List<dynamic>.from(widget.dateApprove);
      score = List<dynamic>.from(widget.score);
      note = List<String>.from(widget.note);
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
                    )
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
                          style: TextStyle(fontWeight: FontWeight.w100),
                        ),
                      ),
                      Flexible(
                        child: Text(
                          namaProduk,
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
                          'Komposisi',
                          style: TextStyle(fontWeight: FontWeight.w100),
                        ),
                      ),
                      Flexible(
                        child: Text(
                          _komposisi_.join(', ').toString(),
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
                          'Tanggal Experiment',
                          style: TextStyle(fontWeight: FontWeight.w100),
                        ),
                      ),
                      Flexible(
                        child: Text(
                          tanggalEksperimen.toDate().toString().substring(8, 10) + '/' + tanggalEksperimen.toDate().toString().substring(5, 7) + '/' + 
                          tanggalEksperimen.toDate().toString().substring(0, 4),
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
                          'Category Experiment',
                          style: TextStyle(fontWeight: FontWeight.w100),
                        ),
                      ),
                      Flexible(
                        child: Text(
                          category,
                          style: TextStyle(color: AbubaPallate.menuBluebird, fontSize: 12.0),
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
                          style: TextStyle(fontWeight: FontWeight.w100),
                        ),
                      ),
                      Flexible(
                        child: Text(
                          tujuan,
                          style: TextStyle(color: Colors.black54, fontSize: 12.0),
                          textAlign: TextAlign.right,
                        ),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(12.0, 6.0, 12.0, 12.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Flexible(
                        child: Text(
                          'Kirim kepada : ',
                          style: TextStyle(fontWeight: FontWeight.w100),
                        ),
                      ),
                      Flexible(
                        child: Text(
                          kirim_kepada.join(', ').toString(),
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
              children: List.generate(parameterView.length, (index) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Container(
                      padding: const EdgeInsets.fromLTRB(12.0, 12.0, 12.0, 12.0),
                      width: 150.0,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Flexible(
                            child: Text(
                              parameterView[index],
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
                        child: SmoothStarRating(
                          allowHalfRating: false,
                          onRatingChanged: (v) {
                            setState(() {
                              ratingParameter.removeAt(index);
                              ratingParameter.insert(index, v);
                            });

                            print(ratingParameter);
                          },
                          starCount: 5,
                          rating: ratingParameter[index],
                          size: 22.0,
                          color: Colors.orangeAccent,
                          borderColor: Colors.grey,
                        ),
                      ),
                    ),
                  ],
                );
              }).toList()
            ),
          ),
          Container(
            color: Colors.white,
            child: Divider(
              height: 3.0,
            ),
          ),
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
            padding: const EdgeInsets.fromLTRB(12.0, 12.0, 12.0, 6.0),
            color: Colors.white,
            child: TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Catatan',
                hintStyle: TextStyle(fontSize: 12.0),
              ),
              controller: _catatan_,
              maxLines: 3,
              style: TextStyle(
                color: Colors.black,
              ),
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
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.fromLTRB(12.0, 12.0, 12.0, 6.0),
                  child: Text(
                    'Kesimpulan',
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
              padding: const EdgeInsets.fromLTRB(12.0, 12.0, 12.0, 6.0),
              color: Colors.white,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(right: 30.0),
                    child: ButtonTheme(
                      minWidth: 50.0,
                      height: 30.0,
                      child: OutlineButton(
                        child: Padding(
                          padding: const EdgeInsets.only(top: 3.0),
                          child: reject
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
                                style:
                                    TextStyle(fontSize: 13.0, color: Colors.redAccent),
                              ),
                        ),
                        borderSide:
                            BorderSide(color: Colors.redAccent, width: 1.0),
                        highlightedBorderColor: Colors.redAccent,
                        onPressed: () {
                          setState(() {
                            reject = true;

                            statusApprove.removeAt(widget.indexUpdate);
                            statusApprove.insert(widget.indexUpdate, 'REJECTED');

                            dateApprove.removeAt(widget.indexUpdate);
                            dateApprove.insert(widget.indexUpdate, DateTime.now());

                            note.removeAt(widget.indexUpdate);
                            note.insert(widget.indexUpdate, _catatan_.text);

                            score.removeAt(widget.indexUpdate);
                            score.insert(widget.indexUpdate, ratingParameter.join(',').toString());
                          });
                          if (reject == true && approve == false) {
                            DocumentReference documentReference = Firestore.instance.collection('rnd_eksperimen').document(widget.eksperimenID);
      
                            documentReference.updateData({
                              'catatan': note,
                              'status': 'REJECTED',
                              'scoreParameter': score,
                              'status': statusApprove,
                              'approveDate': dateApprove
                            }).then((doc2) {
                              print('success');

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
                                            'NOTIFICATION',
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
                                          'Data Saved Successfully',
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
                            }).catchError((error2) {
                              print(error2);
                            });
                          } else {

                          }
                        },
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 30.0),
                    child: ButtonTheme(
                      minWidth: 50.0,
                      height: 30.0,
                      child: OutlineButton(
                        child: Padding(
                          padding: const EdgeInsets.only(top: 3.0),
                          child: approve
                            ? Container(
                                padding: EdgeInsets.symmetric(vertical: 5.0),
                                child: Center(
                                  child: SizedBox(
                                    height: 15.0,
                                    width: 15.0,
                                    child: CircularProgressIndicator(
                                      valueColor: AlwaysStoppedAnimation(AbubaPallate.greenabuba),
                                      strokeWidth: 2.0,
                                    ),
                                  ),
                                ),
                              )
                            : Text(
                                'APPROVE',
                                style:
                                    TextStyle(fontSize: 13.0, color: AbubaPallate.greenabuba),
                              ),
                        ),
                        borderSide: BorderSide(color: AbubaPallate.greenabuba, width: 1.0),
                        highlightedBorderColor: AbubaPallate.greenabuba,
                        onPressed: () {
                          setState(() {
                            approve = true;

                            statusApprove.removeAt(widget.indexUpdate);
                            statusApprove.insert(widget.indexUpdate, 'APPROVED');

                            dateApprove.removeAt(widget.indexUpdate);
                            dateApprove.insert(widget.indexUpdate, DateTime.now());

                            note.removeAt(widget.indexUpdate);
                            note.insert(widget.indexUpdate, _catatan_.text);

                            score.removeAt(widget.indexUpdate);
                            score.insert(widget.indexUpdate, ratingParameter.join(',').toString());
                          });
                          if (approve == true && reject == false) {
                            DocumentReference documentReference = Firestore.instance.collection('rnd_eksperimen').document(widget.eksperimenID);
      
                            documentReference.updateData({
                              'catatan': note,
                              'status': 'APPROVED',
                              'scoreParameter': score,
                              'status': statusApprove,
                              'approveDate': dateApprove
                            }).then((doc2) {
                              print('success');

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
                                            'NOTIFICATION',
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
                                          'Data Saved Successfully',
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
                            }).catchError((error2) {
                              print(error2);
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
            }
          )
        ],
      ),
    );
  }
}
