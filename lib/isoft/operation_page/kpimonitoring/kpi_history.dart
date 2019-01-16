import 'package:flutter/material.dart';
import 'package:flutter_abuba/constant.dart';

class History extends StatefulWidget {
  @override
  HistoryState createState() => new HistoryState();
}

class HistoryState extends State<History> {
  List<String> _statusAddHistory = [
    'add',
    'add',
    'add',
    'add',
    'add',
  ];
  
  List<String> _personAdd = [
    'Hendri 3',
    'Hendri 3',
    'Hendri 3',
    'Hendri 3',
    'Hendri 3',
  ];

  List<String> _datetimeAdd = [
    '20 Desember 2018 - 13.48',
    '20 Desember 2018 - 13.48',
    '20 Desember 2018 - 13.48',
    '20 Desember 2018 - 13.48',
    '20 Desember 2018 - 13.48',
  ];

  List<String> _taskAdd = [
    'Susun IK penggunaan sarung tangan, ketentuan penggantian atau pencuciannya.',
    'Susun IK penggunaan sarung tangan, ketentuan penggantian atau pencuciannya.',
    'Susun IK penggunaan sarung tangan, ketentuan penggantian atau pencuciannya.',
    'Susun IK penggunaan sarung tangan, ketentuan penggantian atau pencuciannya.',
    'Susun IK penggunaan sarung tangan, ketentuan penggantian atau pencuciannya.',
  ];

  TextEditingController _controllerNote = new TextEditingController();
  GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: DefaultTabController(
        length: 4,
        child: Scaffold(
          backgroundColor: Colors.white,
          key: _scaffoldKey,
          appBar: _appBarHistory(),
          body: TabBarView(
            children: <Widget>[
              _buildHistoryAll(),
              _buildHistoryAll(),
              _buildHistoryAll(),
              _buildHistoryAll(),
            ],
          )
        ),
      ),
    );
  }

  Widget _buildHistoryAll() {
    return Column(
      children: <Widget>[
        Expanded(
          child: Scrollbar(
            child: ListView.builder(
              itemCount: _statusAddHistory.length,
              itemBuilder: (BuildContext, int index) {
                return Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                      child: Container(
                        color: Colors.white,
                        child: ListTile(
                          title: Text(
                            '${_personAdd[index]} ${_statusAddHistory[index]}ed ${_taskAdd[index]}',
                            style: TextStyle(
                              fontSize: 16.0
                            ),
                          ),
                          subtitle: Padding(
                            padding: EdgeInsets.only(top: 10.0),
                            child: Row(
                              children: <Widget>[
                                Container(
                                  padding: EdgeInsets.only(right: 5.0),
                                  child: Icon(Icons.access_time, size: 16.0),
                                ),
                                Container(
                                  margin: EdgeInsets.only(top: 5.0),
                                  child: Text(
                                    _datetimeAdd[index],
                                    style: TextStyle(
                                      fontSize: 14.0
                                    ),
                                  ),
                                )
                              ],
                            )
                          ),
                        ),
                      )
                    ),
                    Divider(
                      height: 2.0,
                    )
                  ],
                );
              },
            ),
          ),
        ),
      ],
    );
  }

  Widget _appBarHistory() {
    return AppBar(
      elevation: 0.25,
      backgroundColor: Colors.white,
      leading: IconButton(
        icon: Icon(Icons.close),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
      iconTheme: IconThemeData(color: Colors.black),
      title: Text(
        'History',
        style: TextStyle(
          color: Colors.black,
          fontSize: 18.0
        ),
      ),
      bottom: new TabBar(
        isScrollable: false,
        indicatorColor: AbubaPallate.greenabuba,
        tabs: <Widget>[
          new Tab(
            child: Text(
              'All',
              style: TextStyle(color: Colors.grey[400]),
            ),
          ),
          new Tab(
            child: Text(
              'Add',
              style: TextStyle(color: Colors.grey[400]),
            ),
          ),
          new Tab(
            child: Text(
              'Edit',
              style: TextStyle(color: Colors.grey[400]),
            ),
          ),
          new Tab(
            child: Text(
              'Delete',
              style: TextStyle(color: Colors.grey[400]),
            ),
          ),
        ],
      ),
    );
  }
}