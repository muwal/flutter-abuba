import 'package:flutter/material.dart';
import 'package:flutter_abuba/constant.dart';
import 'package:flutter_abuba/beranda/beranda_appbardua.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

class RDreportDetail extends StatefulWidget {
  @override
  _RDreportDetailState createState() => _RDreportDetailState();
}

class _RDreportDetailState extends State<RDreportDetail> {
  bool _note = false;
  var ratingChiller = 0.0;

  TextEditingController controllerNoteSatu = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AbubaAppBar(),
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
                          'Steak Wagyu',
                          style:
                              TextStyle(color: Colors.black54, fontSize: 12.0),
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
                          'Wagyu 100%',
                          style:
                              TextStyle(color: Colors.black54, fontSize: 12.0),
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
                          '17/09/2018',
                          style:
                              TextStyle(color: Colors.black54, fontSize: 12.0),
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
                          'Alternative Material',
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
                          style: TextStyle(fontWeight: FontWeight.w100),
                        ),
                      ),
                      Flexible(
                        child: Text(
                          'Mengganti wagyur import dengan wagyu lokal',
                          style:
                              TextStyle(color: Colors.black54, fontSize: 12.0),
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
                          'Andi - BD, Yaser - Operasional',
                          style:
                              TextStyle(color: Colors.black54, fontSize: 12.0),
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
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Container(
                      padding:
                          const EdgeInsets.fromLTRB(12.0, 12.0, 12.0, 12.0),
                      width: 150.0,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Flexible(
                            child: Text(
                              'Parameter 1',
                              style: TextStyle(
                                  fontSize: 14.0, fontWeight: FontWeight.w100),
                            ),
                          )
                        ],
                      ),
                    ),
                    Flexible(
                      child: Padding(
                        padding:
                            const EdgeInsets.fromLTRB(12.0, 0.0, 6.0, 12.0),
                        child: SmoothStarRating(
                          allowHalfRating: false,
                          onRatingChanged: (v) {
                            ratingChiller = v;
                            setState(() {});
                          },
                          starCount: 5,
                          rating: ratingChiller,
                          size: 22.0,
                          color: Colors.orangeAccent,
                          borderColor: Colors.grey,
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Container(
                      padding:
                          const EdgeInsets.fromLTRB(12.0, 12.0, 12.0, 12.0),
                      width: 150.0,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Flexible(
                            child: Text(
                              'Parameter 2',
                              style: TextStyle(
                                  fontSize: 14.0, fontWeight: FontWeight.w100),
                            ),
                          )
                        ],
                      ),
                    ),
                    Flexible(
                      child: Padding(
                        padding:
                            const EdgeInsets.fromLTRB(12.0, 0.0, 6.0, 12.0),
                        child: SmoothStarRating(
                          allowHalfRating: false,
                          onRatingChanged: (v) {
                            ratingChiller = v;
                            setState(() {});
                          },
                          starCount: 5,
                          rating: ratingChiller,
                          size: 22.0,
                          color: Colors.orangeAccent,
                          borderColor: Colors.grey,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
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
            child: Container(
              child: Padding(
                padding:
                    const EdgeInsets.only(top: 15.0, bottom: 15.0, left: 10.0),
                child: Text(
                  'Tekstur wagyu lebih bagus yang existing.',
                  style: TextStyle(color: Colors.black38),
                ),
              ),
              decoration: BoxDecoration(
                  color: Colors.grey[200],
                  border: Border.all(color: Colors.black12, width: 2.0)),
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
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Container(
                      padding:
                          const EdgeInsets.fromLTRB(12.0, 12.0, 12.0, 12.0),
                      width: 150.0,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Flexible(
                            child: Text(
                              'Diajukan Oleh',
                              style: TextStyle(
                                  fontSize: 14.0, fontWeight: FontWeight.w100),
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.fromLTRB(12.0, 12.0, 12.0, 5.0),
                      width: 150.0,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          Flexible(
                            child: Text(
                              'Yaser - Operasional',
                              style: TextStyle(color: Colors.grey),
                              textAlign: TextAlign.right,
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Container(
                      padding: const EdgeInsets.fromLTRB(12.0, 0.0, 12.0, 12.0),
                      width: 150.0,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          Flexible(
                            child: Text(
                              '17/08/2018',
                              style: TextStyle(color: Colors.grey),
                              textAlign: TextAlign.right,
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
          Container(
            color: Colors.white,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.fromLTRB(12.0, 12.0, 12.0, 5.0),
                      child: ButtonTheme(
                        minWidth: 50.0,
                        height: 30.0,
                        child: OutlineButton(
                          child: Padding(
                            padding: const EdgeInsets.only(top: 3.0),
                            child: Text(
                              'APPROVED',
                              style:
                                  TextStyle(fontSize: 13.0, color: Colors.blue),
                            ),
                          ),
                          borderSide:
                              BorderSide(color: Colors.blue, width: 1.0),
                          highlightedBorderColor: Colors.blue,
                          onPressed: () {},
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.fromLTRB(12.0, 12.0, 12.0, 5.0),
                      width: 150.0,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          Flexible(
                            child: Text(
                              'All - Management',
                              style: TextStyle(color: Colors.grey),
                              textAlign: TextAlign.right,
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Container(
                      padding: const EdgeInsets.fromLTRB(12.0, 0.0, 12.0, 12.0),
                      width: 150.0,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          Flexible(
                            child: Text(
                              '17/08/2018',
                              style: TextStyle(color: Colors.grey),
                              textAlign: TextAlign.right,
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
        ],
      ),
    );
  }
}
