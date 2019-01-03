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
                      'Stevani Miller',
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
                            style: TextStyle(fontSize: 10.0, color: Colors.black38),
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
                            '21:16:18 WIB',
                            style: TextStyle(fontSize: 10.0, color: Colors.black38),
                          ),
                        )
                      ],
                    ),
                  )
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
                    width: 150.0,
                    child: Row(
                      children: <Widget>[
                        Flexible(
                          child: Text(
                            'Sales per-shift',
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
                            'Rp 167,000,000',
                            style: TextStyle(
                                fontSize: 12.0, color: Colors.red),
                          ),
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
                    width: 150.0,
                    child: Row(
                      children: <Widget>[
                        Flexible(
                          child: Text(
                            'Customer',
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
                            '167',
                            style: TextStyle(
                                fontSize: 12.0, color: Colors.black38),
                          ),
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
                    width: 150.0,
                    child: Row(
                      children: <Widget>[
                        Flexible(
                          child: Text(
                            'Average Check',
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
                            'Rp 168,000,000',
                            style: TextStyle(
                                fontSize: 12.0, color: Colors.black38),
                          ),
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
                    width: 150.0,
                    child: Row(
                      children: <Widget>[
                        Flexible(
                          child: Text(
                            'Target Sales',
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
                            'Rp 168,000,000',
                            style: TextStyle(
                                fontSize: 12.0, color: Colors.black38),
                          ),
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
                    width: 150.0,
                    child: Row(
                      children: <Widget>[
                        Flexible(
                          child: Text(
                            'Hand Over Sales',
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
                            'Rp 186,000,000',
                            style: TextStyle(
                                fontSize: 12.0, color: Colors.green),
                          ),
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
                    width: 150.0,
                    child: Row(
                      children: <Widget>[
                        Flexible(
                          child: Text(
                            'Sales Bulanan',
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
                            'Rp 168,000,000',
                            style: TextStyle(
                                fontSize: 12.0, color: Colors.black38),
                          ),
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
