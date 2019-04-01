import 'package:flutter/material.dart';

class ParetoChart extends StatefulWidget {
  @override
  _ParetoChartState createState() => _ParetoChartState();
}

class _ParetoChartState extends State<ParetoChart> with TickerProviderStateMixin {
  List<Map> _listData = [ {'nomor': '1'}, {'nomor': '2'}];

  List<Map> _pertanyaan = [
    {'pertanyaan': 'Memberikan senyum', 'score': '1'},
    {'pertanyaan': 'Memberikan salam', 'score': '1'},
    {'pertanyaan': 'Menyapa dengan sopan', 'score': '1'},
  ];

  int _currentIndex = 0;

  TabController _cardController;

  @override
  void initState() {
    super.initState();
    _cardController = new TabController(vsync: this, length: _listData.length);
  }

  @override
  void dispose() {
    _cardController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: _appBar(),
        body: GestureDetector(
          onTap: () {
            FocusScope.of(context).requestFocus(FocusNode());
          },
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  child: TabBarView(
                    controller: _cardController,
                    physics: ScrollPhysics(),
                    children: <Widget>[
                      ListView(
                        shrinkWrap: true,
                        physics: ScrollPhysics(),
                        children: <Widget>[
                          PreferredSize(
                            preferredSize: Size.fromHeight(55.0),
                            child: Column(
                              children: <Widget>[
                                SizedBox(
                                  width: MediaQuery.of(context).size.width,
                                  height: 55.0,
                                  child: Container(
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(horizontal: 10.0),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Text(
                                            '1. index = ${_currentIndex.toString()}',
                                            style: TextStyle(color: Colors.white, fontSize: 14.0),
                                            textAlign: TextAlign.start,
                                          ),
                                          Text(
                                            '1 of ${_listData.length.toString()}',
                                            style: TextStyle(
                                                color: Colors.white, fontSize: 14.0),
                                            textAlign: TextAlign.start,
                                          ),
                                        ],
                                      ),
                                    ),
                                    decoration: BoxDecoration(color: Color(0xFF2F592F))
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Column(
                            children: <Widget>[
                              Stack(
                                children: <Widget>[
                                  Container(
                                    width: MediaQuery.of(context).size.width,
                                    height: MediaQuery.of(context).size.height - 290.0,
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                        image: AssetImage('assets/images/open_door.jpg'),
                                        fit: BoxFit.cover
                                      )
                                    ),
                                    child: null,
                                  ),
                                  Positioned(
                                    bottom: 20.0,
                                    width: MediaQuery.of(context).size.width,
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                      children: <Widget>[
                                        RaisedButton(
                                          padding: const EdgeInsets.all(8.0),
                                          textColor: Colors.white,
                                          color: Colors.blue,
                                          onPressed: () {
                                            setState(() {
                                              if (_currentIndex + 1 < _pertanyaan.length) {
                                                _pertanyaan[_currentIndex]['score'] = '0';
                                                _currentIndex++;
                                              } else {
                                                _cardController.animateTo(_cardController.index + 1);
                                              }
                                            });
                                          },
                                          child: Text(
                                            '0',
                                            style: TextStyle(fontSize: 26.0),
                                          ),
                                        ),
                                        RaisedButton(
                                          onPressed: () {
                                            setState(() {
                                              if (_currentIndex + 1 < _pertanyaan.length) {
                                                _pertanyaan[_currentIndex]['score'] = '1';
                                                _currentIndex++;
                                              } else {
                                                _cardController.animateTo(_cardController.index + 1);
                                              }
                                            });
                                          },
                                          textColor: Colors.white,
                                          color: Colors.redAccent,
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(
                                            '1',
                                            style: TextStyle(fontSize: 26.0),
                                          ),
                                        ),
                                        RaisedButton(
                                          onPressed: () {
                                            setState(() {
                                              if (_currentIndex + 1 < _pertanyaan.length) {
                                                _pertanyaan[_currentIndex]['score'] = '2';
                                                _currentIndex++;
                                              } else {
                                                _cardController.animateTo(_cardController.index + 1);
                                              }
                                            });
                                          },
                                          textColor: Colors.white,
                                          color: Colors.green,
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(
                                            '2',
                                            style: TextStyle(fontSize: 26.0),
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: 20.0),
                                width: MediaQuery.of(context).size.width,
                                height: 100.0,
                                color: Colors.white,
                                child: Row(
                                  children: <Widget>[
                                    Flexible(
                                      child: Text(
                                        _pertanyaan[_currentIndex]['pertanyaan'],
                                        style: TextStyle(
                                          fontSize: 16.0,
                                          color: Colors.black87
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                      ListView(
                        shrinkWrap: true,
                        physics: ScrollPhysics(),
                        children: <Widget>[
                          PreferredSize(
                            preferredSize: Size.fromHeight(55.0),
                            child: Column(
                              children: <Widget>[
                                SizedBox(
                                  width: MediaQuery.of(context).size.width,
                                  height: 55.0,
                                  child: Container(
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(horizontal: 10.0),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Text(
                                            '1. General Information',
                                            style: TextStyle(color: Colors.white, fontSize: 14.0),
                                            textAlign: TextAlign.start,
                                          ),
                                          Text(
                                            '2 of ${_listData.length.toString()}',
                                            style: TextStyle(
                                                color: Colors.white, fontSize: 14.0),
                                            textAlign: TextAlign.start,
                                          ),
                                        ],
                                      ),
                                    ),
                                    decoration: BoxDecoration(color: Color(0xFF2F592F))
                                  ),
                                ),
                              ],
                            ),
                          ),
                          RaisedButton(
                            child: Text(
                              'hasil',
                            ),
                            onPressed: () {
                              print(_pertanyaan);
                            },
                          )
                        ],
                      ),
                    ]
                  ),
                ),
              ],
            ),
          ),
        ),
        bottomNavigationBar: _bottomBar(),
      ),
    );
  }

  Widget _bottomBar() {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: 55.0,
      child: Container(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  IconButton(
                    icon: Icon(Icons.arrow_back_ios, color: Colors.white),
                    onPressed: () {
                      _cardController.animateTo(_cardController.index - 1);
                    },
                    tooltip: 'Previous',
                  ),
                  IconButton(
                    icon: Icon(Icons.arrow_forward_ios, color: Colors.white),
                    onPressed: () {
                      _cardController.animateTo(_cardController.index + 1);
                    },
                    tooltip: 'Next',
                  ),
                ],
              )
            ],
          ),
        ),
        decoration: BoxDecoration(color: Color(0xFF2F592F))
      ),
    );
  }

  Widget _appBar() {
    return AppBar(
      elevation: 0.25,
      backgroundColor: Colors.white,
      iconTheme: IconThemeData(color: Colors.black),
      title: Image.asset(
        'assets/images/logo2.png',
        height: 150.0,
        width: 120.0,
      ),
    );
  }
}