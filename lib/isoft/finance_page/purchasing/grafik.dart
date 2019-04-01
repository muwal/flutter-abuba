import 'package:flutter/material.dart';
import 'package:flutter_abuba/constant.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class Grafik extends StatefulWidget {
  @override
  _GrafikState createState() => _GrafikState();
}

class _GrafikState extends State<Grafik> {
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
        body: _buildBody(),
      ),
    );
  }

  Widget _buildBody() {
    return ListView(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Text(
                'Purchasing',
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
                  'Grafik',
                  style:
                  TextStyle(color: AbubaPallate.greenabuba, fontSize: 12.0),
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
                padding: const EdgeInsets.fromLTRB(12.0, 12.0, 12.0, 0.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Flexible(
                      child: Text(
                        'Total Performance',
                        style: TextStyle(color: AbubaPallate.greenabuba),
                      ),
                    ),
                    Flexible(
                      child: Text(
                        '01 Jan 2018 - 30 Des 2018',
                        style: TextStyle(color: Colors.black54, fontSize: 10.0),
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(12.0, 0.0, 12.0, 0.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Container(
                      width: 60.0,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              Flexible(
                                child: Text(
                                  'Delivery',
                                  style: TextStyle(fontSize: 10.0, color: Colors.black38),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 3.0,
                          ),
                          Row(
                            children: <Widget>[
                              Flexible(
                                child: Text(
                                  '1000',
                                  style:
                                  TextStyle(fontSize: 12.0, color: Colors.black54),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: 180.0,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              Flexible(
                                child: Text(
                                  'Rejected',
                                  style: TextStyle(fontSize: 10.0, color: Colors.black38),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 3.0,
                          ),
                          Row(
                            children: <Widget>[
                              Flexible(
                                child: Text(
                                  '1000',
                                  style:
                                  TextStyle(fontSize: 12.0, color: Colors.black54),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        ButtonTheme(
                          minWidth: 50.0,
                          height: 20.0,
                          child: OutlineButton(
                            borderSide: BorderSide(color: AbubaPallate.menuBluebird),
                            child: Text(
                              'Edit',
                              style: TextStyle(
                                  fontSize: 12.0, color: AbubaPallate.menuBluebird),
                            ),
                            onPressed: () {},
                          ),
                        ),
                        Text(''),
                      ],
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(12.0, 0.0, 12.0, 8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Flexible(
                          child: Text(
                            '29%',
                            style: TextStyle(
                                color: Colors.black87, fontSize: 14.0),
                          ),
                        )
                      ],
                    ),
                    LinearPercentIndicator(
                      alignment: MainAxisAlignment.center,
                      width: 330.0,
                      animation: true,
                      lineHeight: 30.0,
                      percent: 0.29,
                      animationDuration: 1000,
                      linearStrokeCap: LinearStrokeCap.butt,
                      progressColor: Colors.green[300],
                    ),
                  ],
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
