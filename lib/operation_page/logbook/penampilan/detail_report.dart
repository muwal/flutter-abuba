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
                    width: 100.0,
                    child: Row(
                      children: <Widget>[
                        Flexible(
                          child: Text(
                            '',
                            style: TextStyle(
                                fontSize: 13.0, color: AbubaPallate.green),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: 100.0,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Flexible(
                          child: Text(
                            'Opening',
                            style: TextStyle(
                                fontSize: 13.0, color: AbubaPallate.green),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: 100.0,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Flexible(
                          child: Text(
                            'Closing',
                            style: TextStyle(
                                fontSize: 13.0, color: AbubaPallate.green),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 6.0),
                margin: EdgeInsets.symmetric(vertical: 5.0),
                color: Colors.grey[300],
                child: Row(
                  children: <Widget>[
                    Flexible(
                      child: Text(
                        'Penampilan',
                        style: TextStyle(fontSize: 12.0),
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 4.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(
                    width: 100.0,
                    child: Row(
                      children: <Widget>[
                        Flexible(
                          child: Text(
                            'Grooming',
                            style: TextStyle(
                                fontSize: 12.0, color: Colors.black38),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: 100.0,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Flexible(
                          child: Text(
                            '1',
                            style: TextStyle(
                                fontSize: 12.0, color: Colors.black38),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: 100.0,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Flexible(
                          child: Text('2',
                              style: TextStyle(
                                  fontSize: 12.0, color: Colors.black38),
                              textAlign: TextAlign.center),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 6.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(
                    width: 100.0,
                    child: Row(
                      children: <Widget>[
                        Flexible(
                          child: Text(
                            'Seragam',
                            style: TextStyle(
                                fontSize: 12.0, color: Colors.black38),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: 100.0,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Flexible(
                          child: Text(
                            '1',
                            style: TextStyle(
                                fontSize: 12.0, color: Colors.black38),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: 100.0,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Flexible(
                          child: Text('2',
                              style: TextStyle(
                                  fontSize: 12.0, color: Colors.black38),
                              textAlign: TextAlign.center),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 6.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(
                    width: 100.0,
                    child: Row(
                      children: <Widget>[
                        Flexible(
                          child: Text(
                            'Aksesoris',
                            style: TextStyle(
                                fontSize: 12.0, color: Colors.black38),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: 100.0,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Flexible(
                          child: Text(
                            '1',
                            style: TextStyle(
                                fontSize: 12.0, color: Colors.black38),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: 100.0,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Flexible(
                          child: Text('2',
                              style: TextStyle(
                                  fontSize: 12.0, color: Colors.black38),
                              textAlign: TextAlign.center),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 6.0),
                margin: EdgeInsets.symmetric(vertical: 5.0),
                color: Colors.grey[300],
                child: Row(
                  children: <Widget>[
                    Flexible(
                      child: Text(
                        'Evaluasi',
                        style: TextStyle(fontSize: 12.0),
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 4.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(
                    width: 100.0,
                    child: Row(
                      children: <Widget>[
                        Flexible(
                          child: Text(
                            'Operation',
                            style: TextStyle(
                                fontSize: 12.0, color: Colors.black38),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: 100.0,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Flexible(
                          child: Text(
                            '1',
                            style: TextStyle(
                                fontSize: 12.0, color: Colors.black38),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: 100.0,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Flexible(
                          child: Text('2',
                              style: TextStyle(
                                  fontSize: 12.0, color: Colors.black38),
                              textAlign: TextAlign.center),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 6.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(
                    width: 100.0,
                    child: Row(
                      children: <Widget>[
                        Flexible(
                          child: Text(
                            'LSM',
                            style: TextStyle(
                                fontSize: 12.0, color: Colors.black38),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: 100.0,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Flexible(
                          child: Text(
                            '1',
                            style: TextStyle(
                                fontSize: 12.0, color: Colors.black38),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: 100.0,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Flexible(
                          child: Text('2',
                              style: TextStyle(
                                  fontSize: 12.0, color: Colors.black38),
                              textAlign: TextAlign.center),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 6.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(
                    width: 100.0,
                    child: Row(
                      children: <Widget>[
                        Flexible(
                          child: Text(
                            'Program Kerja',
                            style: TextStyle(
                                fontSize: 12.0, color: Colors.black38),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: 100.0,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Flexible(
                          child: Text(
                            '1',
                            style: TextStyle(
                                fontSize: 12.0, color: Colors.black38),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: 100.0,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Flexible(
                          child: Text('2',
                              style: TextStyle(
                                  fontSize: 12.0, color: Colors.black38),
                              textAlign: TextAlign.center),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 6.0),
                margin: EdgeInsets.symmetric(vertical: 5.0),
                color: Colors.grey[300],
                child: Row(
                  children: <Widget>[
                    Flexible(
                      child: Text(
                        'Schedule',
                        style: TextStyle(fontSize: 12.0),
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 4.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(
                    width: 100.0,
                    child: Row(
                      children: <Widget>[
                        Flexible(
                          child: Text(
                            'Tukar Shift',
                            style: TextStyle(
                                fontSize: 12.0, color: Colors.black38),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: 100.0,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Flexible(
                          child: Text(
                            '1',
                            style: TextStyle(
                                fontSize: 12.0, color: Colors.black38),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: 100.0,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Flexible(
                          child: Text('2',
                              style: TextStyle(
                                  fontSize: 12.0, color: Colors.black38),
                              textAlign: TextAlign.center),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 6.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(
                    width: 100.0,
                    child: Row(
                      children: <Widget>[
                        Flexible(
                          child: Text(
                            'Tukar Off',
                            style: TextStyle(
                                fontSize: 12.0, color: Colors.black38),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: 100.0,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Flexible(
                          child: Text(
                            '1',
                            style: TextStyle(
                                fontSize: 12.0, color: Colors.black38),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: 100.0,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Flexible(
                          child: Text('2',
                              style: TextStyle(
                                  fontSize: 12.0, color: Colors.black38),
                              textAlign: TextAlign.center),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        )
      ],
    );
  }
}
