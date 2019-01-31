import 'package:flutter/material.dart';
import 'package:flutter_abuba/constant.dart';
import 'package:flutter_abuba/beranda/beranda_appbardua.dart';
import 'package:flutter_circular_chart/flutter_circular_chart.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class DetailReport extends StatefulWidget {
  @override
  _DetailReportState createState() => _DetailReportState();
}

class _DetailReportState extends State<DetailReport> {
  final GlobalKey<AnimatedCircularChartState> _chartKey =
      new GlobalKey<AnimatedCircularChartState>();

  bool _gambar = false;
  bool _catatan = false;
  bool _nilai = false;

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
                  'Report',
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
                    'Detail Report',
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
                      const EdgeInsets.only(top: 10.0, right: 15.0, left: 15.0),
                  child: Column(
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Flexible(
                            child: Text(
                              'Abuba Bogor',
                              style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  color: Colors.black54),
                            ),
                          ),
                          Flexible(
                            child: Text(
                              '17/08/2019',
                              style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  color: Colors.black54),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Flexible(
                            child: Text(
                              'Naily Zulfa',
                              style: TextStyle(
                                  color: Colors.black54, fontSize: 13.0),
                            ),
                          ),
                          Flexible(
                            child: Text(
                              '17:00 - 18:00',
                              style: TextStyle(
                                  color: Colors.black54, fontSize: 13.0),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5.0),
                  child: Center(
                    child: new AnimatedCircularChart(
                      key: _chartKey,
                      size: Size(size / 4, size / 3),
                      initialChartData: <CircularStackEntry>[
                        new CircularStackEntry(
                          <CircularSegmentEntry>[
                            new CircularSegmentEntry(
                              30.0,
                              Colors.blue[400],
                              rankKey: 'completed',
                            ),
                            new CircularSegmentEntry(
                              70.0,
                              Colors.blueGrey[600],
                              rankKey: 'remaining',
                            ),
                          ],
                          rankKey: 'progress',
                        ),
                      ],
                      chartType: CircularChartType.Radial,
                      percentageValues: true,
                      holeLabel: '30%',
                      labelStyle: new TextStyle(
                        color: Colors.blueGrey[600],
                        fontWeight: FontWeight.bold,
                        fontSize: 24.0,
                      ),
                    ),
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
                          child: Column(
                            children: <Widget>[
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Flexible(
                                    child: Text('1. Parking'),
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: <Widget>[
                                      IconButton(
                                        icon: Icon(Icons.image),
                                        onPressed: () {
                                          setState(() => _gambar = !_gambar);
                                        },
                                      ),
                                      IconButton(
                                        icon: Icon(Icons.note_add),
                                        onPressed: () {
                                          setState(() => _catatan = !_catatan);
                                        },
                                      ),
                                      IconButton(
                                        icon: Icon(Icons.check_box),
                                        onPressed: () {
                                          setState(() => _nilai = !_nilai);
                                        },
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                        Container(
                          alignment: Alignment.centerLeft,
                          child: LinearPercentIndicator(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 17.0),
                            width: MediaQuery.of(context).size.width,
                            animation: true,
                            lineHeight: 30.0,
                            percent: 0.8,
                            animationDuration: 1000,
                            linearStrokeCap: LinearStrokeCap.butt,
                            progressColor: Colors.green[300],
                          ),
                        ),
                        _gambar
                            ? Container(
                                child: GridView.count(
                                  padding: const EdgeInsets.only(
                                      right: 17.0, left: 17.0, bottom: 10.0),
                                  crossAxisCount: 2,
                                  childAspectRatio: 1.0,
                                  mainAxisSpacing: 4.0,
                                  crossAxisSpacing: 4.0,
                                  shrinkWrap: true,
                                  children: <String>[
                                    'assets/images/abuba5.jpg',
                                    'assets/images/abuba5.jpg',
                                  ].map((String url) {
                                    return new GridTile(
                                      child: new Image.asset(url,
                                          fit: BoxFit.cover),
                                    );
                                  }).toList(),
                                ),
                              )
                            : Container(),
                        _catatan
                            ? Padding(
                                padding: EdgeInsets.only(
                                    left: 17.0, right: 17.0, bottom: 5.0),
                                child: Container(
                                  color: Colors.grey[200],
                                  padding: EdgeInsets.all(10.0),
                                  child: Column(
                                    children: <Widget>[
                                      Row(
                                        children: <Widget>[
                                          Flexible(
                                            child: Text(
                                              'Catatan',
                                              style: TextStyle(
                                                  color: Colors.black54,
                                                  fontWeight: FontWeight.w700),
                                            ),
                                          )
                                        ],
                                      ),
                                      SizedBox(
                                        height: 5.0,
                                      ),
                                      Row(
                                        children: <Widget>[
                                          Flexible(
                                            child: Text(
                                              'Petugas parkir sangat membantu dan ramah',
                                              style: TextStyle(
                                                color: Colors.black38,
                                              ),
                                            ),
                                          )
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              )
                            : Container(),
                        _nilai
                            ? Padding(
                                padding: EdgeInsets.only(
                                    left: 17.0, right: 17.0, bottom: 5.0),
                                child: Container(
                                  color: Colors.grey[200],
                                  padding: EdgeInsets.all(10.0),
                                  child: Column(
                                    children: <Widget>[
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Container(
                                            width: 100.0,
                                            child: Row(
                                              children: <Widget>[
                                                Flexible(
                                                  child: Text(
                                                    'Score 0',
                                                    style: TextStyle(
                                                        color: Colors.black54,
                                                        fontWeight:
                                                            FontWeight.w700),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Container(
                                            width: 200.0,
                                            child: Column(
                                              children: <Widget>[
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.end,
                                                  children: <Widget>[
                                                    Flexible(
                                                      child: Text(
                                                        'Parkiran penuh',
                                                        style: TextStyle(
                                                          color: Colors.black38,
                                                        ),
                                                      ),
                                                    )
                                                  ],
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.end,
                                                  children: <Widget>[
                                                    Flexible(
                                                      child: Text(
                                                        'Antrian Lama',
                                                        style: TextStyle(
                                                          color: Colors.black38,
                                                        ),
                                                      ),
                                                    )
                                                  ],
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.end,
                                                  children: <Widget>[
                                                    Flexible(
                                                      child: Text(
                                                        'Tiket tidak keluar',
                                                        style: TextStyle(
                                                          color: Colors.black38,
                                                        ),
                                                      ),
                                                    )
                                                  ],
                                                )
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                      SizedBox(
                                        height: 5.0,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Container(
                                            width: 100.0,
                                            child: Row(
                                              children: <Widget>[
                                                Flexible(
                                                  child: Text(
                                                    'Score 1',
                                                    style: TextStyle(
                                                        color: Colors.black54,
                                                        fontWeight:
                                                            FontWeight.w700),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Container(
                                            width: 200.0,
                                            child: Column(
                                              children: <Widget>[
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.end,
                                                  children: <Widget>[
                                                    Flexible(
                                                      child: Text(
                                                        'Parkiran penuh',
                                                        style: TextStyle(
                                                          color: Colors.black38,
                                                        ),
                                                      ),
                                                    )
                                                  ],
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.end,
                                                  children: <Widget>[
                                                    Flexible(
                                                      child: Text(
                                                        'Antrian Lama',
                                                        style: TextStyle(
                                                          color: Colors.black38,
                                                        ),
                                                      ),
                                                    )
                                                  ],
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.end,
                                                  children: <Widget>[
                                                    Flexible(
                                                      child: Text(
                                                        'Tiket tidak keluar',
                                                        style: TextStyle(
                                                          color: Colors.black38,
                                                        ),
                                                      ),
                                                    )
                                                  ],
                                                )
                                              ],
                                            ),
                                          )
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              )
                            : Container(),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 17.0),
                          child: Column(
                            children: <Widget>[
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Flexible(
                                    child: Text('2. Toilet'),
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: <Widget>[
                                      Icon(Icons.image),
                                      Icon(Icons.note_add),
                                      Icon(Icons.check_box)
                                    ],
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                        Container(
                          alignment: Alignment.centerLeft,
                          child: LinearPercentIndicator(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 17.0),
                            width: MediaQuery.of(context).size.width,
                            animation: true,
                            lineHeight: 30.0,
                            percent: 0.8,
                            animationDuration: 1000,
                            linearStrokeCap: LinearStrokeCap.butt,
                            progressColor: Colors.green[300],
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
                          padding: EdgeInsets.fromLTRB(17.0, 0.0, 17.0, 0.0),
                          child: Column(
                            children: <Widget>[
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  Flexible(
                                    child: Text(
                                      'Serving Time',
                                      style: TextStyle(
                                          color: AbubaPallate.greenabuba,
                                          fontWeight: FontWeight.w700),
                                    ),
                                  )
                                ],
                              ),
                              Container(
                                padding: EdgeInsets.only(
                                    left: 5.0, top: 10.0, bottom: 10.0),
                                child: Column(
                                  children: <Widget>[
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Container(
                                          width: 100.0,
                                          child: Row(
                                            children: <Widget>[
                                              Flexible(
                                                child: Text(
                                                  'Drinks',
                                                  style: TextStyle(
                                                    color: Colors.black54,
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                        Container(
                                          width: 100.0,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: <Widget>[
                                              Flexible(
                                                child: Text(
                                                  '10:10:00',
                                                  style: TextStyle(
                                                    color: Colors.black54,
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                        Container(
                                          width: 100.0,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            children: <Widget>[
                                              Flexible(
                                                child: Text(
                                                  '09:00:00',
                                                  style: TextStyle(
                                                    color: Colors.black54,
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 5.0,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Container(
                                          width: 100.0,
                                          child: Row(
                                            children: <Widget>[
                                              Flexible(
                                                child: Text(
                                                  'Juice',
                                                  style: TextStyle(
                                                    color: Colors.black54,
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                        Container(
                                          width: 100.0,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: <Widget>[
                                              Flexible(
                                                child: Text(
                                                  '10:10:00',
                                                  style: TextStyle(
                                                    color: Colors.black54,
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                        Container(
                                          width: 100.0,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            children: <Widget>[
                                              Flexible(
                                                child: Text(
                                                  '09:00:00',
                                                  style: TextStyle(
                                                    color: Colors.black54,
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 5.0,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Container(
                                          width: 100.0,
                                          child: Row(
                                            children: <Widget>[
                                              Flexible(
                                                child: Text(
                                                  'Appetizer',
                                                  style: TextStyle(
                                                    color: Colors.black54,
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                        Container(
                                          width: 100.0,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: <Widget>[
                                              Flexible(
                                                child: Text(
                                                  '10:10:00',
                                                  style: TextStyle(
                                                    color: Colors.black54,
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                        Container(
                                          width: 100.0,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            children: <Widget>[
                                              Flexible(
                                                child: Text(
                                                  '09:00:00',
                                                  style: TextStyle(
                                                    color: Colors.black54,
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 5.0,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Container(
                                          width: 100.0,
                                          child: Row(
                                            children: <Widget>[
                                              Flexible(
                                                child: Text(
                                                  'Main Course',
                                                  style: TextStyle(
                                                    color: Colors.black54,
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                        Container(
                                          width: 100.0,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: <Widget>[
                                              Flexible(
                                                child: Text(
                                                  '10:10:00',
                                                  style: TextStyle(
                                                    color: Colors.black54,
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                        Container(
                                          width: 100.0,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            children: <Widget>[
                                              Flexible(
                                                child: Text(
                                                  '09:00:00',
                                                  style: TextStyle(
                                                    color: Colors.black54,
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 5.0,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Container(
                                          width: 100.0,
                                          child: Row(
                                            children: <Widget>[
                                              Flexible(
                                                child: Text(
                                                  'Dessert',
                                                  style: TextStyle(
                                                    color: Colors.black54,
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                        Container(
                                          width: 100.0,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: <Widget>[
                                              Flexible(
                                                child: Text(
                                                  '10:10:00',
                                                  style: TextStyle(
                                                    color: Colors.black54,
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                        Container(
                                          width: 100.0,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            children: <Widget>[
                                              Flexible(
                                                child: Text(
                                                  '09:00:00',
                                                  style: TextStyle(
                                                    color: Colors.black54,
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 17.0),
                          child: Column(
                            children: <Widget>[
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  Flexible(
                                    child: Text(
                                      'Moment of Truth',
                                      style: TextStyle(
                                          color: AbubaPallate.greenabuba,
                                          fontWeight: FontWeight.w700),
                                    ),
                                  )
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Flexible(
                                    child: Text('4. Greeting'),
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: <Widget>[
                                      Icon(Icons.image),
                                      Icon(Icons.note_add),
                                      Icon(Icons.check_box)
                                    ],
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                        Container(
                          alignment: Alignment.centerLeft,
                          child: LinearPercentIndicator(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 17.0),
                            width: MediaQuery.of(context).size.width,
                            animation: true,
                            lineHeight: 30.0,
                            percent: 0.8,
                            animationDuration: 1000,
                            linearStrokeCap: LinearStrokeCap.butt,
                            progressColor: Colors.green[300],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 17.0),
                          child: Column(
                            children: <Widget>[
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Flexible(
                                    child: Text('5. Seating'),
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: <Widget>[
                                      Icon(Icons.image),
                                      Icon(Icons.note_add),
                                      Icon(Icons.check_box)
                                    ],
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                        Container(
                          alignment: Alignment.centerLeft,
                          child: LinearPercentIndicator(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 17.0),
                            width: MediaQuery.of(context).size.width,
                            animation: true,
                            lineHeight: 30.0,
                            percent: 0.8,
                            animationDuration: 1000,
                            linearStrokeCap: LinearStrokeCap.butt,
                            progressColor: Colors.green[300],
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
                          padding: EdgeInsets.fromLTRB(17.0, 0.0, 17.0, 0.0),
                          child: Column(
                            children: <Widget>[
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  Flexible(
                                    child: Text(
                                      'Detail Complaint',
                                      style: TextStyle(
                                          color: AbubaPallate.greenabuba,
                                          fontWeight: FontWeight.w700),
                                    ),
                                  )
                                ],
                              ),
                              Container(
                                padding: EdgeInsets.only(
                                    left: 5.0, top: 10.0, bottom: 10.0),
                                child: Column(
                                  children: <Widget>[
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Container(
                                          width: 150.0,
                                          child: Row(
                                            children: <Widget>[
                                              Flexible(
                                                child: Text(
                                                  'Category',
                                                  style: TextStyle(
                                                      color: Colors.black54,
                                                      fontWeight:
                                                          FontWeight.w700),
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                        Container(
                                          width: 150.0,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            children: <Widget>[
                                              Flexible(
                                                child: Text(
                                                  'Service',
                                                  style: TextStyle(
                                                    color: Colors.black54,
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 5.0,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Container(
                                          width: 150.0,
                                          child: Row(
                                            children: <Widget>[
                                              Flexible(
                                                child: Text(
                                                  'Product',
                                                  style: TextStyle(
                                                      color: Colors.black54,
                                                      fontWeight:
                                                          FontWeight.w700),
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                        Container(
                                          width: 150.0,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            children: <Widget>[
                                              Flexible(
                                                child: Text(
                                                  '-',
                                                  style: TextStyle(
                                                    color: Colors.black54,
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 5.0,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Container(
                                          width: 150.0,
                                          child: Row(
                                            children: <Widget>[
                                              Flexible(
                                                child: Text(
                                                  'Service',
                                                  style: TextStyle(
                                                      color: Colors.black54,
                                                      fontWeight:
                                                          FontWeight.w700),
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                        Container(
                                          width: 150.0,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            children: <Widget>[
                                              Flexible(
                                                child: Text(
                                                  'Kebersihan',
                                                  style: TextStyle(
                                                    color: Colors.black54,
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 5.0,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Container(
                                          width: 150.0,
                                          child: Row(
                                            children: <Widget>[
                                              Flexible(
                                                child: Text(
                                                  'PIC yang dituju',
                                                  style: TextStyle(
                                                      color: Colors.black54,
                                                      fontWeight:
                                                          FontWeight.w700),
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                        Container(
                                          width: 150.0,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            children: <Widget>[
                                              Flexible(
                                                child: Text(
                                                  'Manager',
                                                  style: TextStyle(
                                                    color: Colors.black54,
                                                  ),
                                                  textAlign: TextAlign.right,
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 5.0,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Container(
                                          width: 150.0,
                                          child: Row(
                                            children: <Widget>[
                                              Flexible(
                                                child: Text(
                                                  'Verbatim Complaint',
                                                  style: TextStyle(
                                                      color: Colors.black54,
                                                      fontWeight:
                                                          FontWeight.w700),
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                        Container(
                                          width: 150.0,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            children: <Widget>[
                                              Flexible(
                                                child: Text(
                                                  'Ditemukan kotoran pada gelas juices',
                                                  style: TextStyle(
                                                    color: Colors.black54,
                                                  ),
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
                              )
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 17.0),
                          child: Column(
                            children: <Widget>[
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  Flexible(
                                    child: Text(
                                      'Detail Complaint',
                                      style: TextStyle(
                                          color: AbubaPallate.greenabuba,
                                          fontWeight: FontWeight.w700),
                                    ),
                                  )
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Flexible(
                                    child: Text('Score'),
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: <Widget>[
                                      Icon(Icons.image),
                                      Icon(Icons.note_add),
                                      IconButton(
                                        icon: Icon(Icons.check_box),
                                        onPressed: () {
                                          setState(() => _nilai = !_nilai);
                                        },
                                      ),
                                      Text(
                                        '0.9',
                                        style: TextStyle(
                                            color: Colors.red,
                                            fontWeight: FontWeight.w700, fontSize: 20.0),
                                      )
                                    ],
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                        _nilai
                            ? Padding(
                          padding: EdgeInsets.only(
                              left: 17.0, right: 17.0, bottom: 5.0),
                          child: Container(
                            color: Colors.grey[200],
                            padding: EdgeInsets.all(10.0),
                            child: Column(
                              children: <Widget>[

                                Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Container(
                                      width: 100.0,
                                      child: Row(
                                        children: <Widget>[
                                          Flexible(
                                            child: Text(
                                              'Score 1',
                                              style: TextStyle(
                                                  color: Colors.black54,
                                                  fontWeight:
                                                  FontWeight.w700),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      width: 200.0,
                                      child: Column(
                                        children: <Widget>[Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment.end,
                                            children: <Widget>[
                                              Flexible(
                                                child: Text(
                                                  'Waiters tidak mengucapkan maaf',
                                                  style: TextStyle(
                                                    color: Colors.black38,
                                                  ),
                                                ),
                                              )
                                            ],
                                          )
                                        ],
                                      ),
                                    )
                                  ],
                                )
                              ],
                            ),
                          ),
                        )
                            : Container(),
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
                          child: Column(
                            children: <Widget>[
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Flexible(
                                    child: Text('1. Table Setting'),
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: <Widget>[
                                      Icon(Icons.image),
                                      Icon(Icons.note_add),
                                      Icon(Icons.check_box)
                                    ],
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                        Container(
                          alignment: Alignment.centerLeft,
                          child: LinearPercentIndicator(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 17.0),
                            width: MediaQuery.of(context).size.width,
                            animation: true,
                            lineHeight: 30.0,
                            percent: 0.8,
                            animationDuration: 1000,
                            linearStrokeCap: LinearStrokeCap.butt,
                            progressColor: Colors.green[300],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 17.0),
                          child: Column(
                            children: <Widget>[
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Flexible(
                                    child: Text('2. Kerapihan'),
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: <Widget>[
                                      Icon(Icons.image),
                                      Icon(Icons.note_add),
                                      Icon(Icons.check_box)
                                    ],
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                        Container(
                          alignment: Alignment.centerLeft,
                          child: LinearPercentIndicator(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 17.0),
                            width: MediaQuery.of(context).size.width,
                            animation: true,
                            lineHeight: 30.0,
                            percent: 0.8,
                            animationDuration: 1000,
                            linearStrokeCap: LinearStrokeCap.butt,
                            progressColor: Colors.green[300],
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
