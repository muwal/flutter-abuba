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
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Flexible(
                    child: Text(
                      'Stevani Miller (0), Susan (M), Jack (C)',
                      style: TextStyle(fontSize: 12.0, color: Colors.black54),
                    ),
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Flexible(
                    child: Text(
                      'Diinput oleh',
                      style: TextStyle(fontSize: 10.0, color: Colors.black38),
                    ),
                  )
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
                            '08:00 - 08:15',
                            style: TextStyle(
                                fontSize: 10.0, color: Colors.black38),
                          ),
                        ),
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
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(
                    width: 50.0,
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
                    width: 60.0,
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
                    width: 50.0,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Flexible(
                          child: Text(
                            'Middle',
                            style: TextStyle(
                                fontSize: 13.0, color: AbubaPallate.green),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: 50.0,
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
              SizedBox(
                height: 12.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(
                    width: 50.0,
                    child: Row(
                      children: <Widget>[
                        Flexible(
                          child: Text(
                            'Cashier',
                            style: TextStyle(
                                fontSize: 12.0, color: Colors.black38),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: 50.0,
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
                    width: 50.0,
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
                  Container(
                    width: 50.0,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Flexible(
                          child: Text('3',
                              style: TextStyle(
                                  fontSize: 12.0, color: Colors.black38),
                              textAlign: TextAlign.center),
                        ),
                      ],
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 6.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(
                    width: 50.0,
                    child: Row(
                      children: <Widget>[
                        Flexible(
                          child: Text(
                            'Section 1',
                            style: TextStyle(
                                fontSize: 12.0, color: Colors.black38),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: 50.0,
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
                    width: 50.0,
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
                  Container(
                    width: 50.0,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Flexible(
                          child: Text('3',
                              style: TextStyle(
                                  fontSize: 12.0, color: Colors.black38),
                              textAlign: TextAlign.center),
                        ),
                      ],
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 6.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(
                    width: 50.0,
                    child: Row(
                      children: <Widget>[
                        Flexible(
                          child: Text(
                            'Bartender',
                            style: TextStyle(
                                fontSize: 12.0, color: Colors.black38),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: 50.0,
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
                    width: 50.0,
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
                  Container(
                    width: 50.0,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Flexible(
                          child: Text('3',
                              style: TextStyle(
                                  fontSize: 12.0, color: Colors.black38),
                              textAlign: TextAlign.center),
                        ),
                      ],
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 6.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(
                    width: 50.0,
                    child: Row(
                      children: <Widget>[
                        Flexible(
                          child: Text(
                            'Runner',
                            style: TextStyle(
                                fontSize: 12.0, color: Colors.black38),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: 50.0,
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
                    width: 50.0,
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
                  Container(
                    width: 50.0,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Flexible(
                          child: Text('3',
                              style: TextStyle(
                                  fontSize: 12.0, color: Colors.black38),
                              textAlign: TextAlign.center),
                        ),
                      ],
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 6.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(
                    width: 50.0,
                    child: Row(
                      children: <Widget>[
                        Flexible(
                          child: Text(
                            'Steaward',
                            style: TextStyle(
                                fontSize: 12.0, color: Colors.black38),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: 50.0,
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
                    width: 50.0,
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
                  Container(
                    width: 50.0,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Flexible(
                          child: Text('3',
                              style: TextStyle(
                                  fontSize: 12.0, color: Colors.black38),
                              textAlign: TextAlign.center),
                        ),
                      ],
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 6.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(
                    width: 50.0,
                    child: Row(
                      children: <Widget>[
                        Flexible(
                          child: Text(
                            'Kitchen - Grill',
                            style: TextStyle(
                                fontSize: 12.0, color: Colors.black38),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: 50.0,
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
                    width: 50.0,
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
                  Container(
                    width: 50.0,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Flexible(
                          child: Text('3',
                              style: TextStyle(
                                  fontSize: 12.0, color: Colors.black38),
                              textAlign: TextAlign.center),
                        ),
                      ],
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 6.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(
                    width: 50.0,
                    child: Row(
                      children: <Widget>[
                        Flexible(
                          child: Text(
                            'Jumlah',
                            style: TextStyle(
                                fontSize: 12.0, color: AbubaPallate.green),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: 50.0,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Flexible(
                          child: Text(
                            '1',
                            style: TextStyle(
                                fontSize: 12.0, color: AbubaPallate.green),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: 50.0,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Flexible(
                          child: Text('2',
                              style: TextStyle(
                                  fontSize: 12.0, color: AbubaPallate.green),
                              textAlign: TextAlign.center),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: 50.0,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Flexible(
                          child: Text('3',
                              style: TextStyle(
                                  fontSize: 12.0, color: AbubaPallate.green),
                              textAlign: TextAlign.center),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ],
          ),
        )
      ],
    );
  }
}
