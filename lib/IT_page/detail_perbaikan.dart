import 'package:flutter/material.dart';
import 'package:flutter_abuba/constant.dart';
import 'package:flutter_abuba/beranda/beranda_appbardua.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

class DetailPerbaikan extends StatefulWidget {
  @override
  _DetailPerbaikanState createState() => _DetailPerbaikanState();
}

class _DetailPerbaikanState extends State<DetailPerbaikan> {
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
                  'Perbaikan',
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
                    'Status',
                    style: TextStyle(
                        color: AbubaPallate.greenabuba, fontSize: 12.0),
                  ),
                ),
              ],
            ),
          ),
          Container(
            color: Colors.white,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Flexible(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(12.0, 12.0, 12.0, 6.0),
                    child: Text(
                      '# PERBAIKAN : 001',
                      style: TextStyle(
                          fontSize: 16.0,
                          color: AbubaPallate.greenabuba,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                Flexible(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(12.0, 12.0, 12.0, 6.0),
                    child: Text(
                      'CLOSED',
                      style: TextStyle(
                          fontSize: 16.0,
                          color: AbubaPallate.yellow,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ],
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
                    'Hardware / Software',
                    style:
                        TextStyle(fontSize: 15.0, fontWeight: FontWeight.w600),
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
                      padding: const EdgeInsets.fromLTRB(12.0, 12.0, 12.0, 6.0),
                      width: 150.0,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Flexible(
                            child: Text(
                              'Category',
                              style: TextStyle(
                                  fontSize: 14.0, fontWeight: FontWeight.w100),
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.fromLTRB(12.0, 12.0, 12.0, 6.0),
                      width: 150.0,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          Flexible(
                            child: Text(
                              'Hardware / Software',
                              style: TextStyle(color: Colors.grey),
                              textAlign: TextAlign.right,
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
                      width: 150.0,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Flexible(
                            child: Text(
                              'Lokasi',
                              style: TextStyle(
                                  fontSize: 14.0, fontWeight: FontWeight.w100),
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      padding:
                          const EdgeInsets.fromLTRB(12.0, 12.0, 12.0, 12.0),
                      width: 150.0,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          Flexible(
                            child: Text(
                              'Office',
                              style: TextStyle(color: Colors.grey),
                              textAlign: TextAlign.right,
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
                      width: 150.0,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Flexible(
                            child: Text(
                              'Item',
                              style: TextStyle(
                                  fontSize: 14.0, fontWeight: FontWeight.w100),
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      padding:
                          const EdgeInsets.fromLTRB(12.0, 12.0, 12.0, 12.0),
                      width: 150.0,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          Flexible(
                            child: Text(
                              'Laptop - Lenovo',
                              style: TextStyle(color: Colors.grey),
                              textAlign: TextAlign.right,
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
                      width: 150.0,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Flexible(
                            child: Text(
                              'No. Identitas',
                              style: TextStyle(
                                  fontSize: 14.0, fontWeight: FontWeight.w100),
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      padding:
                          const EdgeInsets.fromLTRB(12.0, 12.0, 12.0, 12.0),
                      width: 150.0,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          Flexible(
                            child: Text(
                              '0123456',
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
          SizedBox(
            height: 20.0,
          ),
          Container(
            color: Colors.white,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.fromLTRB(12.0, 12.0, 12.0, 6.0),
                  child: Text(
                    'Masalah',
                    style:
                        TextStyle(fontSize: 15.0, fontWeight: FontWeight.w600),
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
                  padding: const EdgeInsets.fromLTRB(12.0, 12.0, 12.0, 6.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Flexible(
                        child: Text(
                          'Virus',
                          style: TextStyle(
                              fontSize: 14.0, fontWeight: FontWeight.w100),
                        ),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(12.0, 0.0, 12.0, 12.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Flexible(
                        child: Text(
                          'Terdapat serangan virus tidak dikenal.',
                          style: TextStyle(color: Colors.grey),
                          textAlign: TextAlign.right,
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 20.0,
          ),
          Container(
            color: Colors.white,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.fromLTRB(12.0, 12.0, 12.0, 6.0),
                  child: Text(
                    'Detail Perbaikan',
                    style:
                        TextStyle(fontSize: 15.0, fontWeight: FontWeight.w600),
                  ),
                ),
              ],
            ),
          ),
          Container(
            color: Colors.white,
            child: Column(
              children: <Widget>[
                /*Padding(
                  padding: const EdgeInsets.fromLTRB(12.0, 12.0, 12.0, 6.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Container(
                        width: 150.0,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Radio(value: 0, groupValue: null, onChanged: null),
                            Flexible(
                              child: Text(
                                'Update Anti Virus',
                                style: TextStyle(
                                    fontSize: 14.0,
                                    fontWeight: FontWeight.w100),
                              ),
                            ),
                          ],
                        ),
                      ),
                      ButtonTheme(
                        minWidth: 30.0,
                        height: 25.0,
                        child: RaisedButton(
                          color: AbubaPallate.menuBluebird,
                          child: Text(
                            'Detail',
                            style:
                                TextStyle(fontSize: 12.0, color: Colors.white),
                          ),
                          onPressed: () {
                            setState(() {
                              _note = !_note;
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(6.0, 0.0, 6.0, 6.0),
                  child: _note
                      ? Container(
                          width: 330.0,
                          child: TextField(
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                            ),
                            controller: controllerNoteSatu,
                            maxLines: 3,
                            style: TextStyle(
                              color: Colors.black,
                            ),
                          ),
                        )
                      : Container(),
                ),
                Padding(
                    padding: const EdgeInsets.fromLTRB(12.0, 6.0, 12.0, 12.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        ButtonTheme(
                          minWidth: 30.0,
                          height: 25.0,
                          child: OutlineButton(
                            color: AbubaPallate.greenabuba,
                            child: Text(
                              'Submit',
                              style: TextStyle(
                                  fontSize: 12.0,
                                  color: AbubaPallate.greenabuba),
                            ),
                            onPressed: () {},
                            borderSide:
                                BorderSide(color: AbubaPallate.greenabuba),
                          ),
                        ),
                      ],
                    ),
                ),*/
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Flexible(
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(12.0, 12.0, 6.0, 6.0),
                        child: Text(
                          'Tgl Perbaikan',
                          style: TextStyle(
                              fontSize: 14.0, fontWeight: FontWeight.w100),
                        ),
                      ),
                    ),
                    Flexible(
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(6.0, 12.0, 12.0, 6.0),
                        child: Text(
                          'Dikerjakan oleh',
                          style: TextStyle(
                              fontSize: 14.0, fontWeight: FontWeight.w100),
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Flexible(
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(12.0, 0.0, 6.0, 12.0),
                        child: Text(
                          '17/08/2018 - 16:16:16',
                          style: TextStyle(
                              fontSize: 13.0, color: Colors.grey),
                        ),
                      ),
                    ),
                    Flexible(
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(6.0, 0.0, 12.0, 12.0),
                        child: Text(
                          'Sony',
                          style: TextStyle(
                              fontSize: 13.0, color: Colors.grey),
                        ),
                      ),
                    ),
                  ],
                ),
                Divider(
                  height: 2.0,
                  color: Colors.grey,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Flexible(
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(12.0, 12.0, 6.0, 6.0),
                        child: Text(
                          'Update Anti Virus',
                          style: TextStyle(
                              fontSize: 14.0, fontWeight: FontWeight.w100),
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Flexible(
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(12.0, 0.0, 6.0, 12.0),
                        child: Text(
                          'Anti Virus berhasil di perbarui ke versi 2.0',
                          style: TextStyle(
                              fontSize: 13.0, color: Colors.grey),
                        ),
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
                    Flexible(
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(12.0, 12.0, 6.0, 6.0),
                        child: Text(
                          'Tgl Verifikasi',
                          style: TextStyle(
                              fontSize: 14.0, fontWeight: FontWeight.w100),
                        ),
                      ),
                    ),
                    Flexible(
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(12.0, 12.0, 6.0, 6.0),
                        child: Text(
                          'Diverifikasi oleh',
                          style: TextStyle(
                              fontSize: 14.0, fontWeight: FontWeight.w100),
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Flexible(
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(12.0, 0.0, 6.0, 6.0),
                        child: Text(
                          '17/08/2018 - 18:18:18',
                          style: TextStyle(
                              fontSize: 13.0, color: Colors.grey),
                        ),
                      ),
                    ),
                    Flexible(
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(12.0, 0.0, 6.0, 6.0),
                        child: Text(
                          'Yani',
                          style: TextStyle(
                              fontSize: 13.0, color: Colors.grey),
                        ),
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
                    Flexible(
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(12.0, 12.0, 6.0, 6.0),
                        child: Text(
                          'Status',
                          style: TextStyle(
                              fontSize: 14.0, fontWeight: FontWeight.w100),
                        ),
                      ),
                    ),
                    Flexible(
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(12.0, 12.0, 6.0, 6.0),
                        child: Text(
                          'Rating',
                          style: TextStyle(
                              fontSize: 14.0, fontWeight: FontWeight.w100),
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Flexible(
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(12.0, 0.0, 6.0, 12.0),
                        child: Text(
                          'Approved',
                          style: TextStyle(
                              fontSize: 13.0, color: Colors.grey),
                        ),
                      ),
                    ),
                    Flexible(
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(12.0, 0.0, 6.0, 12.0),
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
          SizedBox(height: 20.0,)
        ],
//        itemCount: 10,
      ),
    );
  }
}
