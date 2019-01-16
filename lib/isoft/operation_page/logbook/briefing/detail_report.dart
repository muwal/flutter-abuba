import 'package:flutter/material.dart';
import 'package:flutter_abuba/constant.dart';
import 'package:flutter_abuba/beranda/beranda_appbardua.dart';

class DetailReport extends StatefulWidget {
  @override
  _DetailReportState createState() => _DetailReportState();
}

class _DetailReportState extends State<DetailReport> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AbubaAppBar(),
        body: _formDetail(),
      ),
    );
  }

  Widget _formDetail() {
    return ListView(
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
                  style:
                      TextStyle(color: AbubaPallate.greenabuba, fontSize: 12.0),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 15.0),
                child: Text(
                  'Detail',
                  style:
                      TextStyle(color: AbubaPallate.greenabuba, fontSize: 12.0),
                ),
              ),
            ],
          ),
        ),
        Container(
          padding: EdgeInsets.all(12.0),
          color: Colors.white,
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
                            '10 Orang',
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
                            'Diinput oleh',
                            style: TextStyle(
                                fontSize: 10.0, color: Colors.black38),
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
                            'Jumlah Peserta',
                            style: TextStyle(
                                fontSize: 10.0, color: Colors.black38),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 12.0,
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
                            '17 January 2018 - Shift A',
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
                            style: TextStyle(
                                fontSize: 10.0, color: Colors.black38),
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
                            '08:00 - 11:15',
                            style: TextStyle(
                                fontSize: 10.0, color: Colors.black38),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Divider(
                  height: 6.0,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Flexible(
                    child: Text(
                      'Menu Baru',
                      style: TextStyle(color: AbubaPallate.green),
                    ),
                  )
                ],
              ),
              Container(
                padding: EdgeInsets.all(12.0),
                margin: EdgeInsets.symmetric(vertical: 5.0),
                color: Colors.grey[300],
                child: Row(
                  children: <Widget>[
                    Flexible(
                      child: Text(
                        'Wagyu',
                        style: TextStyle(fontSize: 12.0),
                      ),
                    )
                  ],
                ),
              ),

              /*Event*/
              ExpansionTile(
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Flexible(
                      child: Text(
                        'Event',
                        style: TextStyle(fontSize: 12.0, color: Colors.black54),
                      ),
                    )
                  ],
                ),
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 15.0, right: 15.0, bottom: 15.0),
                    child: Column(
                      children: <Widget>[
                        Text('Konten')
                      ],
                    ),
                  ),
                ],
              ),

              /*Upselling*/
              ExpansionTile(
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Flexible(
                      child: Text(
                        'Upselling',
                        style: TextStyle(fontSize: 12.0, color: Colors.black54),
                      ),
                    )
                  ],
                ),
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 15.0, right: 15.0, bottom: 15.0),
                    child: Column(
                      children: <Widget>[
                        Text('Konten')
                      ],
                    ),
                  ),
                ],
              ),

              /*Audit*/
              ExpansionTile(
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Flexible(
                      child: Text(
                        'Hasil Audit',
                        style: TextStyle(fontSize: 12.0, color: Colors.black54),
                      ),
                    )
                  ],
                ),
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 15.0, right: 15.0, bottom: 15.0),
                    child: Column(
                      children: <Widget>[
                        Text('Konten')
                      ],
                    ),
                  ),
                ],
              ),

              ExpansionTile(
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Flexible(
                      child: Text(
                        'Pengumuman',
                        style: TextStyle(fontSize: 12.0, color: Colors.black54),
                      ),
                    )
                  ],
                ),
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 15.0, right: 15.0, bottom: 15.0),
                    child: Column(
                      children: <Widget>[
                        Text('Konten')
                      ],
                    ),
                  ),
                ],
              )
            ],
          ),
        )
      ],
    );
  }
}
