import 'package:flutter/material.dart';
import 'package:flutter_abuba/constant.dart';
import 'package:flutter_abuba/isoft/operation_page/kpimonitoring/kpi_history.dart';

class KpiMonitoring extends StatefulWidget {
  @override
  _KpiMonitoringState createState() => _KpiMonitoringState();
}

class _KpiMonitoringState extends State<KpiMonitoring> {
  List<String> _titleKPI = [
    'Susun standar kompetensi untuk masing-masing posisi',
    'Lakukan penilaian kompetensi secara rutin.',
    'Susun rencana pelatihan untuk kompetensi yang belum terpenuhi.',
    'Petugas CCP wajib mendapat training rutin terkait dengan aktivitas di titik CCP yang dipantaunya.',
    'Susun SOP Pelatihan',
  ];
  
  List<String> _subtitleKPI = [
    'Hendri 3',
    'Hendri 3',
    'Hendri 3',
    'Hendri 3',
    'Hendri 3',
  ];

  List<String> _tanggalKPI = [
    '20 Des 2018',
    '20 Des 2018',
    '20 Des 2018',
    '20 Des 2018',
    '20 Des 2018',
  ];

  List<String> _valueKPI = [
    '1',
    '2',
    '3',
    '4',
    '5',
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
          appBar: _appBar(),
          body: TabBarView(
            children: <Widget>[
              _buildFormToday(),
              _buildFormOutstanding(),
              _buildFormOutstanding(),
              _buildFormOutstanding(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFormToday() {
    return Column(
      children: <Widget>[
        Expanded(
          child: Scrollbar(
            child: ListView.builder(
              itemCount: _titleKPI.length,
              itemBuilder: (BuildContext, int index) {
                final String titleKPI = _titleKPI[index];
                final String valueKPI = _valueKPI[index];
                final String subtitleKPI = _subtitleKPI[index];
                final String tanggalKPI = _tanggalKPI[index];

                return _titleKPI.length == 0
                ? Center(
                    child: Text('No Data'),
                  )
                : Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                      child: Dismissible(
                        key: Key(valueKPI),
                        onDismissed: (DismissDirection dir) {
                          setState(() {
                            this._titleKPI.removeAt(index);
                            this._valueKPI.removeAt(index);
                            this._subtitleKPI.removeAt(index);
                            this._tanggalKPI.removeAt(index);
                          });

                          _scaffoldKey.currentState.showSnackBar(
                            SnackBar(
                              content: RichText(
                                overflow: TextOverflow.ellipsis,
                                text: TextSpan(
                                  text: dir == DismissDirection.startToEnd
                                  ? '$titleKPI'
                                  : '$titleKPI',
                                ),
                              ),
                              action: SnackBarAction(
                                label: 'UNDO',
                                onPressed: () {
                                  setState(() {
                                    this._titleKPI.insert(index, titleKPI);
                                    this._subtitleKPI.insert(index, subtitleKPI);
                                    this._tanggalKPI.insert(index, tanggalKPI);
                                    this._valueKPI.insert(index, valueKPI);
                                  });
                                },
                              ),
                              duration: Duration(
                                seconds: 3
                              ),
                            )
                          );
                        },
                        background: Container(
                          color: Colors.green,
                          padding: const EdgeInsets.only(right: 30.0, left: 30.0, bottom: 10.0),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              Container(
                                height: 30.0,
                                width: 30.0,
                                child: Icon(Icons.done, color: Colors.white, size: 14.0),
                              ),
                              Text(
                                'DONE',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 14.0
                                ),
                              )
                            ],
                          ),
                          alignment: Alignment.centerLeft
                        ),
                        secondaryBackground: Container(
                          color: Colors.green,
                          padding: const EdgeInsets.only(right: 30.0, left: 30.0, bottom: 10.0),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              Container(
                                height: 30.0,
                                width: 30.0,
                                child: Icon(Icons.done, color: Colors.white, size: 14.0),
                              ),
                              Text(
                                'DONE',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 14.0
                                ),
                              )
                            ],
                          ),
                          alignment: Alignment.centerRight
                        ),
                        child: Container(
                          color: Colors.white,
                          child: ListTile(
                            title: Text(
                              _titleKPI[index],
                              style: TextStyle(
                                fontSize: 16.0
                              ),
                            ),
                            subtitle: Padding(
                              padding: EdgeInsets.only(top: 10.0),
                              child: Text(
                                _tanggalKPI[index] + ' - ' + _subtitleKPI[index],
                                style: TextStyle(
                                  fontSize: 14.0
                                ),
                              ),
                            ),
                            trailing: ButtonTheme(
                              minWidth: 50.0,
                              height: 20.0,
                              child: OutlineButton(
                                child: Text(
                                  'Note',
                                  style: TextStyle(
                                      fontSize: 13.0
                                  ),
                                ),
                                borderSide: BorderSide(
                                    color: Colors.green,
                                    width: 1.0
                                ),
                                highlightedBorderColor: Colors.green,
                                onPressed: () {
                                  showDialog(
                                    context: context,
                                    builder: (context) {
                                      return AlertDialog(
                                        title: Text(_titleKPI[index]),
                                        content: Container(
                                          width: 300.0,
                                          child: TextField(
                                            controller: _controllerNote,
                                            decoration: InputDecoration(
                                              border: OutlineInputBorder(),
                                              hintText: 'Note',
                                              hintStyle: TextStyle(fontSize: 12.0),
                                            ),
                                            maxLines: 3,
                                            style: TextStyle(
                                              color: Colors.black,
                                            ),
                                          ),
                                        ),
                                        actions: <Widget>[
                                          FlatButton(
                                            splashColor: Colors.greenAccent,
                                            child: Text(
                                              'OK',
                                              style: TextStyle(
                                                color: Colors.green
                                              ),
                                            ),
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                          )
                                        ],
                                      );
                                    }
                                  );
                                },
                              ),
                            )
                          ),
                        )
                      ),
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

  Widget _buildFormOutstanding() {
    return Column(
      children: <Widget>[
        Expanded(
          child: Scrollbar(
            child: ListView.builder(
              itemCount: _titleKPI.length,
              itemBuilder: (BuildContext, int index) {
                final String titleKPI = _titleKPI[index];
                final String valueKPI = _valueKPI[index];
                final String subtitleKPI = _subtitleKPI[index];
                final String tanggalKPI = _tanggalKPI[index];

                return _titleKPI.length == 0
                ? Center(
                    child: Text('No Data'),
                  )
                : Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                      child: Dismissible(
                        key: Key(valueKPI),
                        onDismissed: (DismissDirection dir) {
                          setState(() {
                            this._titleKPI.removeAt(index);
                            this._valueKPI.removeAt(index);
                            this._subtitleKPI.removeAt(index);
                            this._tanggalKPI.removeAt(index);
                          });

                          _scaffoldKey.currentState.showSnackBar(
                            SnackBar(
                              content: RichText(
                                overflow: TextOverflow.ellipsis,
                                text: TextSpan(
                                  text: dir == DismissDirection.startToEnd
                                  ? '$titleKPI'
                                  : '$titleKPI',
                                ),
                              ),
                              action: SnackBarAction(
                                label: 'UNDO',
                                onPressed: () {
                                  setState(() {
                                    this._titleKPI.insert(index, titleKPI);
                                    this._subtitleKPI.insert(index, subtitleKPI);
                                    this._tanggalKPI.insert(index, tanggalKPI);
                                    this._valueKPI.insert(index, valueKPI);
                                  });
                                },
                              ),
                              duration: Duration(
                                seconds: 3
                              ),
                            )
                          );
                        },
                        background: Container(
                          color: Colors.green,
                          padding: const EdgeInsets.only(right: 30.0, left: 30.0, bottom: 10.0),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              Container(
                                height: 30.0,
                                width: 30.0,
                                child: Icon(Icons.done, color: Colors.white, size: 14.0),
                              ),
                              Text(
                                'DONE',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 14.0
                                ),
                              )
                            ],
                          ),
                          alignment: Alignment.centerLeft
                        ),
                        secondaryBackground: Container(
                          color: Colors.green,
                          padding: const EdgeInsets.only(right: 30.0, left: 30.0, bottom: 10.0),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              Container(
                                height: 30.0,
                                width: 30.0,
                                child: Icon(Icons.done, color: Colors.white, size: 14.0),
                              ),
                              Text(
                                'DONE',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 14.0
                                ),
                              )
                            ],
                          ),
                          alignment: Alignment.centerRight
                        ),
                        child: Container(
                          color: Colors.white,
                          child: ListTile(
                            title: Text(
                              _titleKPI[index],
                              style: TextStyle(
                                fontSize: 16.0
                              ),
                            ),
                            subtitle: Padding(
                              padding: EdgeInsets.only(top: 10.0),
                              child: Text(
                                _tanggalKPI[index] + ' - ' + _subtitleKPI[index],
                                style: TextStyle(
                                  fontSize: 14.0
                                ),
                              ),
                            ),
                            trailing: ButtonTheme(
                              minWidth: 50.0,
                              height: 20.0,
                              child: OutlineButton(
                                child: Text(
                                  'Note',
                                  style: TextStyle(
                                      fontSize: 13.0
                                  ),
                                ),
                                borderSide: BorderSide(
                                    color: Colors.green,
                                    width: 1.0
                                ),
                                highlightedBorderColor: Colors.green,
                                onPressed: () {
                                  showDialog(
                                    context: context,
                                    builder: (context) {
                                      return AlertDialog(
                                        title: Text(_titleKPI[index]),
                                        content: Container(
                                          width: 300.0,
                                          child: TextField(
                                            controller: _controllerNote,
                                            decoration: InputDecoration(
                                              border: OutlineInputBorder(),
                                              hintText: 'Note',
                                              hintStyle: TextStyle(fontSize: 12.0),
                                            ),
                                            maxLines: 3,
                                            style: TextStyle(
                                              color: Colors.black,
                                            ),
                                          ),
                                        ),
                                        actions: <Widget>[
                                          FlatButton(
                                            splashColor: Colors.greenAccent,
                                            child: Text(
                                              'OK',
                                              style: TextStyle(
                                                color: Colors.green
                                              ),
                                            ),
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                          )
                                        ],
                                      );
                                    }
                                  );
                                },
                              ),
                            )
                          ),
                        )
                      ),
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

  Widget _appBar() {
    return AppBar(
      elevation: 0.25,
      backgroundColor: Colors.white,
      iconTheme: IconThemeData(color: Colors.black),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Image.asset(
            'assets/images/logo2.png',
            height: 150.0,
            width: 120.0,
          ),
          new Container(
            child: IconButton(
              icon: Icon(Icons.history),
              color: Colors.black,
              iconSize: 22.0,
              onPressed: () {
                Navigator.push(context,
                  MyCustomRoute(
                    builder: (context) => new History()
                  )
                );
              },
              tooltip: 'History',
            ),
          )
        ],
      ),
      bottom: new TabBar(
        isScrollable: true,
        indicatorColor: AbubaPallate.greenabuba,
        tabs: <Widget>[
          new Tab(
            child: Text(
              'Today',
              style: TextStyle(color: Colors.grey[400]),
            ),
          ),
          new Tab(
            child: Text(
              'Outstanding',
              style: TextStyle(color: Colors.grey[400]),
            ),
          ),
          new Tab(
            child: Text(
              'On Time',
              style: TextStyle(color: Colors.grey[400]),
            ),
          ),
          new Tab(
            child: Text(
              'Late',
              style: TextStyle(color: Colors.grey[400]),
            ),
          ),
        ],
      ),
    );
  }
}