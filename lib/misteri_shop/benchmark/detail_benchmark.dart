import 'package:flutter/material.dart';
import 'package:flutter_abuba/constant.dart';
import 'package:flutter_abuba/beranda/beranda_appbardua.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class DetailBenchmark extends StatefulWidget {
  @override
  _DetailBenchmarkState createState() => _DetailBenchmarkState();
}

class _DetailBenchmarkState extends State<DetailBenchmark> {
  bool _note = false;
  var ratingChiller = 0.0;
  TextEditingController controllerNoteSatu = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    final double size = MediaQuery.of(context).size.width;

    return SafeArea(
      child: Scaffold(
        appBar: AbubaAppBar(),
        body: GestureDetector(
          onTap: () {
            FocusScope.of(context).requestFocus(FocusNode());
          },
          child: _bodyForm(size),
        ),
      ),
    );
  }

  Widget _bodyForm(double size) {
    return Scrollbar(
      child: ListView(
        shrinkWrap: true,
        physics: ScrollPhysics(),
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Text(
                  'Mystery Shopper',
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
                    'Benchmark',
                    style: TextStyle(
                        color: AbubaPallate.greenabuba, fontSize: 12.0),
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
                  padding:
                      const EdgeInsets.only(left: 13.0, right: 15.0, top: 10.0),
                  child: Row(
                    children: <Widget>[
                      Flexible(
                        child: Text(
                          'OUTLET BENCHMARK',
                          style: TextStyle(
                              fontSize: 14.0,
                              fontWeight: FontWeight.w700,
                              color: AbubaPallate.greenabuba),
                        ),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 13.0),
                  child: Row(
                    children: <Widget>[
                      Flexible(
                        child: Text(
                          '17/08/2018 – 17/08/2019',
                          style:
                              TextStyle(fontSize: 12.0, color: Colors.black38),
                        ),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 13.0),
                  child: Row(
                    children: <Widget>[
                      Flexible(
                        child: Text(
                          'SENOPATI VS BEKASI',
                          style:
                              TextStyle(fontSize: 12.0, color: Colors.black38),
                        ),
                      )
                    ],
                  ),
                ),
                ExpansionTile(
                  title: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Flexible(
                            child: Text(
                              'Supporting 1.5',
                              style: TextStyle(
                                  fontSize: 14.0, fontWeight: FontWeight.w700),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 17.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Flexible(
                                child: Text('1. Parking'),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          alignment: Alignment.centerLeft,
                          child: Column(
                            children: <Widget>[
                              LinearPercentIndicator(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 17.0, vertical: 0.0),
                                width: MediaQuery.of(context).size.width,
                                animation: true,
                                lineHeight: 20.0,
                                percent: 0.8,
                                animationDuration: 1000,
                                linearStrokeCap: LinearStrokeCap.butt,
                                progressColor: Colors.grey[300],
                              ),
                              LinearPercentIndicator(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 17.0),
                                width: MediaQuery.of(context).size.width,
                                animation: true,
                                lineHeight: 20.0,
                                percent: 0.8,
                                animationDuration: 1000,
                                linearStrokeCap: LinearStrokeCap.butt,
                                progressColor: Colors.blue[300],
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 17.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Flexible(
                                child: Text('2. Toilet'),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          alignment: Alignment.centerLeft,
                          child: Column(
                            children: <Widget>[
                              LinearPercentIndicator(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 17.0, vertical: 0.0),
                                width: MediaQuery.of(context).size.width,
                                animation: true,
                                lineHeight: 20.0,
                                percent: 0.8,
                                animationDuration: 1000,
                                linearStrokeCap: LinearStrokeCap.butt,
                                progressColor: Colors.grey[300],
                              ),
                              LinearPercentIndicator(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 17.0),
                                width: MediaQuery.of(context).size.width,
                                animation: true,
                                lineHeight: 20.0,
                                percent: 0.8,
                                animationDuration: 1000,
                                linearStrokeCap: LinearStrokeCap.butt,
                                progressColor: Colors.blue[300],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                ExpansionTile(
                  title: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Flexible(
                            child: Text(
                              'Service 2.0',
                              style: TextStyle(
                                  fontSize: 14.0, fontWeight: FontWeight.w700),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 17.0),
                          child: Row(
                            mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Flexible(
                                child: Text('3. Greeting'),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          alignment: Alignment.centerLeft,
                          child: Column(
                            children: <Widget>[
                              LinearPercentIndicator(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 17.0, vertical: 0.0),
                                width: MediaQuery.of(context).size.width,
                                animation: true,
                                lineHeight: 20.0,
                                percent: 0.8,
                                animationDuration: 1000,
                                linearStrokeCap: LinearStrokeCap.butt,
                                progressColor: Colors.grey[300],
                              ),
                              LinearPercentIndicator(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 17.0),
                                width: MediaQuery.of(context).size.width,
                                animation: true,
                                lineHeight: 20.0,
                                percent: 0.8,
                                animationDuration: 1000,
                                linearStrokeCap: LinearStrokeCap.butt,
                                progressColor: Colors.blue[300],
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 17.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Flexible(
                                child: Text('4. Seating'),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          alignment: Alignment.centerLeft,
                          child: Column(
                            children: <Widget>[
                              LinearPercentIndicator(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 17.0, vertical: 0.0),
                                width: MediaQuery.of(context).size.width,
                                animation: true,
                                lineHeight: 20.0,
                                percent: 0.8,
                                animationDuration: 1000,
                                linearStrokeCap: LinearStrokeCap.butt,
                                progressColor: Colors.grey[300],
                              ),
                              LinearPercentIndicator(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 17.0),
                                width: MediaQuery.of(context).size.width,
                                animation: true,
                                lineHeight: 20.0,
                                percent: 0.8,
                                animationDuration: 1000,
                                linearStrokeCap: LinearStrokeCap.butt,
                                progressColor: Colors.blue[300],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                ExpansionTile(
                  title: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Flexible(
                            child: Text(
                              'Complaint 1.0',
                              style: TextStyle(
                                  fontSize: 14.0, fontWeight: FontWeight.w700),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 17.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Flexible(
                                child: Text('1. Parking'),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          alignment: Alignment.centerLeft,
                          child: Column(
                            children: <Widget>[
                              LinearPercentIndicator(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 17.0, vertical: 0.0),
                                width: MediaQuery.of(context).size.width,
                                animation: true,
                                lineHeight: 20.0,
                                percent: 0.8,
                                animationDuration: 1000,
                                linearStrokeCap: LinearStrokeCap.butt,
                                progressColor: Colors.grey[300],
                              ),
                              LinearPercentIndicator(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 17.0),
                                width: MediaQuery.of(context).size.width,
                                animation: true,
                                lineHeight: 20.0,
                                percent: 0.8,
                                animationDuration: 1000,
                                linearStrokeCap: LinearStrokeCap.butt,
                                progressColor: Colors.blue[300],
                              ),
                            ],
                          ),
                        ),

                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 17.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Flexible(
                                child: Text('2. Toilet'),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          alignment: Alignment.centerLeft,
                          child: Column(
                            children: <Widget>[
                              LinearPercentIndicator(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 17.0, vertical: 0.0),
                                width: MediaQuery.of(context).size.width,
                                animation: true,
                                lineHeight: 20.0,
                                percent: 0.8,
                                animationDuration: 1000,
                                linearStrokeCap: LinearStrokeCap.butt,
                                progressColor: Colors.grey[300],
                              ),
                              LinearPercentIndicator(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 17.0),
                                width: MediaQuery.of(context).size.width,
                                animation: true,
                                lineHeight: 20.0,
                                percent: 0.8,
                                animationDuration: 1000,
                                linearStrokeCap: LinearStrokeCap.butt,
                                progressColor: Colors.blue[300],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                ExpansionTile(
                  title: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Flexible(
                            child: Text(
                              'Cleanliness 1.0',
                              style: TextStyle(
                                  fontSize: 14.0, fontWeight: FontWeight.w700),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 17.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Flexible(
                                child: Text('3. Greeting'),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          alignment: Alignment.centerLeft,
                          child: Column(
                            children: <Widget>[
                              LinearPercentIndicator(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 17.0, vertical: 0.0),
                                width: MediaQuery.of(context).size.width,
                                animation: true,
                                lineHeight: 20.0,
                                percent: 0.8,
                                animationDuration: 1000,
                                linearStrokeCap: LinearStrokeCap.butt,
                                progressColor: Colors.grey[300],
                              ),
                              LinearPercentIndicator(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 17.0),
                                width: MediaQuery.of(context).size.width,
                                animation: true,
                                lineHeight: 20.0,
                                percent: 0.8,
                                animationDuration: 1000,
                                linearStrokeCap: LinearStrokeCap.butt,
                                progressColor: Colors.blue[300],
                              ),
                            ],
                          ),
                        ),

                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 17.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Flexible(
                                child: Text('4. Seating'),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          alignment: Alignment.centerLeft,
                          child: Column(
                            children: <Widget>[
                              LinearPercentIndicator(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 17.0, vertical: 0.0),
                                width: MediaQuery.of(context).size.width,
                                animation: true,
                                lineHeight: 20.0,
                                percent: 0.8,
                                animationDuration: 1000,
                                linearStrokeCap: LinearStrokeCap.butt,
                                progressColor: Colors.grey[300],
                              ),
                              LinearPercentIndicator(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 17.0),
                                width: MediaQuery.of(context).size.width,
                                animation: true,
                                lineHeight: 20.0,
                                percent: 0.8,
                                animationDuration: 1000,
                                linearStrokeCap: LinearStrokeCap.butt,
                                progressColor: Colors.blue[300],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
//        itemCount: 10,
      ),
    );
  }
}
