import 'package:flutter/material.dart';
import 'package:flutter_abuba/constant.dart';
import 'package:flutter_abuba/beranda/beranda_appbardua.dart';

class ReviewRevisi extends StatefulWidget {
  @override
  _ReviewRevisiState createState() => _ReviewRevisiState();
}

class _ReviewRevisiState extends State<ReviewRevisi> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AbubaAppBar(),
        body: _buildForm(),
      ),
    );
  }

  Widget _buildForm() {
    return ListView(
      children: <Widget>[
        Container(
          width: MediaQuery.of(context).size.width,
          color: AbubaPallate.greenabuba,
          padding: EdgeInsets.all(12.0),
          child: Row(
            children: <Widget>[
              Flexible(
                  child: Text(
                'Review Revisi',
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.w700),
              )),
            ],
          ),
        ),
        Container(
          color: Colors.grey[200],
          margin: EdgeInsets.all(15.0),
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Icon(
                      Icons.border_color,
                      color: AbubaPallate.greenabuba,
                    ),
                    SizedBox(
                      width: 10.0,
                    ),
                    Flexible(
                      child: Text(
                        'Edit Halaman',
                        style: TextStyle(color: AbubaPallate.greenabuba),
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.all(10.0),
                child: Column(
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Flexible(
                          child: Text('BEFORE'),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Container(
                      color: AbubaPallate.greenabuba,
                      width: MediaQuery.of(context).size.width,
                      padding: EdgeInsets.all(12.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Flexible(
                            child: Text(
                              'COVER',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 12.0,
                                  fontWeight: FontWeight.w700),
                            ),
                          ),
                          Flexible(
                            child: Text(
                              '1 of 15',
                              style: TextStyle(
                                  color: Colors.white, fontSize: 12.0),
                              textAlign: TextAlign.start,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      color: Colors.white,
                      height: 150.0,
                      width: MediaQuery.of(context).size.width,
                      padding: EdgeInsets.all(12.0),
                      child: Center(child: Text('PEMERIKSAAN PRODUK')),
                    ),
                  ],
                ),
              ),
              Divider(
                height: 15.0,
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(10.0, 10.0,10.0, 20.0),
                child: Column(
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Flexible(
                          child: Text('AFTER'),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Container(
                      color: AbubaPallate.greenabuba,
                      width: MediaQuery.of(context).size.width,
                      padding: EdgeInsets.all(12.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Flexible(
                            child: Text(
                              'COVER',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 12.0,
                                  fontWeight: FontWeight.w700),
                            ),
                          ),
                          Flexible(
                            child: Text(
                              '1 of 15',
                              style: TextStyle(
                                  color: Colors.white, fontSize: 12.0),
                              textAlign: TextAlign.start,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      color: Colors.white,
                      height: 150.0,
                      width: MediaQuery.of(context).size.width,
                      padding: EdgeInsets.all(12.0),
                      child: Center(child: Text('PEMERIKSAAN MAKANAN', style: TextStyle(color: Colors.blue),)),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
