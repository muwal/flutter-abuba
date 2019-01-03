import 'package:flutter/material.dart';
import 'package:flutter_abuba/constant.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class DashboardKpiMonitoringDetail extends StatefulWidget {
  DashboardKpiMonitoringDetail({Key key}) : super(key: key);

  @override
  _DashboardKpiMonitoringDetailState createState() =>
      new _DashboardKpiMonitoringDetailState();
}

class _DashboardKpiMonitoringDetailState
    extends State<DashboardKpiMonitoringDetail> {
  bool _progressShow = true;
  Color _progressColor = AbubaPallate.green;
  bool _badgetingShow = false;
  Color _badgetingColor = Colors.grey;
  bool _todayShow = true;
  Color _todayColor = AbubaPallate.green;
  bool _openShow = false;
  Color _openColor = Colors.grey;
  bool _doneShow = false;
  Color _doneColor = Colors.grey;

  bool _comment = false;
  bool _noteShowDone = false;

  List<String> _titlePertama = [
    "Plan",
    "Do",
    "Check",
    "Adjust",
  ];

  List<String> _titleKedua = [
    'Meeting koordinasi dengan tim outlet',
    'Meeting koordinasi dengan tim outlet',
    'Meeting koordinasi dengan tim outlet',
    'Meeting koordinasi dengan tim outlet',
  ];
  
  List<String> _subtitlePertama = [
    'Sony, Ridwan',
    'Sony, Ridwan',
    'Sony, Ridwan',
    'Sony, Ridwan',    
  ];

  List<String> _subtitleKedua = [
    '17/08/2018',
    '17/08/2018',
    '17/08/2018',
    '17/08/2018',
  ];

  List<String> _valueKPI = [
    '1',
    '2',
    '3',
    '4',
  ];

  TextEditingController _controllerNote = new TextEditingController();
  GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;

    return SafeArea(
      child: Scaffold(
        appBar: _appBar(),
        body: _buildAbubaMenu(width),
      ),
    );
  }

  Widget _buildAbubaMenu(double width) {
    return Scrollbar(
      child: ListView(
        children: <Widget>[
          Column(
            children: <Widget>[
              SizedBox(
                height: 20.0,
              ),
              Container(
                color: Colors.white,
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(
                          right: 20.0, left: 20.0, top: 16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Flexible(
                            child: Text(
                              'Outlet Senopati',
                              style: TextStyle(
                                  color: Colors.black54, fontSize: 20.0),
                            ),
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          right: 20.0, left: 20.0, top: 10.0, bottom: 16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Flexible(
                            child: Text(
                              'Pembangunan outlet baru mulai 1 January hingga 30 January 2019 dengan akurasi badget minimal 90%',
                              style: TextStyle(
                                  color: Colors.black54, fontSize: 12.0),
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              Container(
                color: Colors.white,
                child: Column(
                  children: <Widget>[
                    Container(
                        alignment: Alignment.centerLeft,
                        padding: const EdgeInsets.only(
                            right: 20.0, left: 20.0, bottom: 5.0, top: 20.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            ButtonTheme(
                              minWidth: width / 2.5,
                              height: 40.0,
                              child: RaisedButton(
                                color: _progressColor,
                                child: Text(
                                  'Task List',
                                  style: TextStyle(
                                      fontSize: 13.0, color: Colors.white),
                                ),
                                onPressed: () {
                                  setState(() {
                                    _progressColor = AbubaPallate.green;
                                    _badgetingColor = Colors.grey;
                                    _progressShow = true;
                                    _badgetingShow = false;
                                  });
                                },
                              ),
                            ),
                            ButtonTheme(
                              minWidth: width / 2.5,
                              height: 40.0,
                              child: RaisedButton(
                                color: _badgetingColor,
                                child: Text(
                                  'Badgeting',
                                  style: TextStyle(
                                      fontSize: 13.0, color: Colors.white),
                                ),
                                onPressed: () {
                                  setState(() {
                                    _progressColor = Colors.grey;
                                    _badgetingColor = AbubaPallate.green;
                                    _progressShow = false;
                                    _badgetingShow = true;
                                  });
                                },
                              ),
                            ),
                          ],
                        )),
                    Container(
                        alignment: Alignment.centerLeft,
                        padding: const EdgeInsets.only(
                            right: 20.0, left: 20.0, bottom: 15.0, top: 10.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  _todayColor = AbubaPallate.green;
                                  _todayShow = true;

                                  _openColor = Colors.grey;
                                  _openShow = false;

                                  _doneColor = Colors.grey;
                                  _doneShow = false;
                                });
                              },
                              child: Padding(
                                padding: const EdgeInsets.only(top: 2.0),
                                child: Text(
                                  'Today',
                                  style: TextStyle(
                                      color: _todayColor, fontSize: 13.0),
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  _todayColor = Colors.grey;
                                  _todayShow = false;

                                  _openColor = AbubaPallate.green;
                                  _openShow = true;

                                  _doneColor = Colors.grey;
                                  _doneShow = false;
                                });
                              },
                              child: Padding(
                                padding: const EdgeInsets.only(top: 2.0),
                                child: Text(
                                  'Open',
                                  style: TextStyle(
                                      color: _openColor, fontSize: 13.0),
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  _todayColor = Colors.grey;
                                  _todayShow = false;

                                  _openColor = Colors.grey;
                                  _openShow = false;

                                  _doneColor = AbubaPallate.green;
                                  _doneShow = true;
                                });
                              },
                              child: Padding(
                                padding: const EdgeInsets.only(top: 2.0),
                                child: Text(
                                  'Done',
                                  style: TextStyle(
                                      color: _doneColor, fontSize: 13.0),
                                ),
                              ),
                            ),
                          ],
                        )),
                  ],
                ),
              ),
              _todayShow
                ? Container(
                    color: Colors.white,
                    padding: EdgeInsets.symmetric(horizontal: 15.0),
                    height: MediaQuery.of(context).size.height / 1.8,
                    child: Column(
                      children: <Widget>[
                        _titlePertama.length == 0
                            ? Center(
                                child: Padding(
                                  padding: EdgeInsets.only(top: 10.0),
                                  child: Text(
                                    'No Data'
                                  ),
                                )
                              )
                            : Flexible(
                                child: ListView.builder(
                                  scrollDirection: Axis.vertical,
                                  itemCount: _titlePertama.length,
                                  itemBuilder: (BuildContext context, int index) {
                                    final String titlePertama = _titlePertama[index];
                                    final String titleKedua = _titleKedua[index];
                                    final String valueKPI = _valueKPI[index];
                                    final String subtitlePertama = _subtitlePertama[index];
                                    final String subtitleKedua = _subtitleKedua[index];

                                    return Column(
                                      children: <Widget>[
                                        Padding(
                                          padding: const EdgeInsets.symmetric(vertical: 10.0),
                                          child: Dismissible(
                                            key: Key(valueKPI),
                                            onDismissed: (DismissDirection dir) {
                                              setState(() {
                                                this._titlePertama.removeAt(index);
                                                this._titleKedua.removeAt(index);
                                                this._valueKPI.removeAt(index);
                                                this._subtitlePertama.removeAt(index);
                                                this._subtitleKedua.removeAt(index);
                                              });

                                              dir == DismissDirection.startToEnd
                                                ? Scaffold.of(context).showSnackBar(
                                                    SnackBar(
                                                      content: RichText(
                                                        overflow: TextOverflow.ellipsis,
                                                        text: TextSpan(
                                                          text: dir == DismissDirection.startToEnd
                                                          ? '$titlePertama - $titleKedua'
                                                          : '$titlePertama - $titleKedua',
                                                        ),
                                                      ),
                                                      action: SnackBarAction(
                                                        label: 'UNDO',
                                                        onPressed: () {
                                                          setState(() {
                                                            this._titlePertama.insert(index, titlePertama);
                                                            this._titleKedua.insert(index, titleKedua);
                                                            this._subtitlePertama.insert(index, subtitlePertama);
                                                            this._subtitleKedua.insert(index, subtitleKedua);
                                                            this._valueKPI.insert(index, valueKPI);
                                                          });
                                                        },
                                                      ),
                                                      duration: Duration(
                                                        seconds: 3
                                                      ),
                                                    )
                                                  )
                                                : showDialog(
                                                    context: context,
                                                    builder: (context) {
                                                      return AlertDialog(
                                                        title: Text('$titlePertama - $titleKedua'),
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
                                                            splashColor: Colors.redAccent,
                                                            child: Text(
                                                              'Cancel',
                                                              style: TextStyle(
                                                                color: Colors.redAccent
                                                              ),
                                                            ),
                                                            onPressed: () {
                                                              setState(() {
                                                                this._titlePertama.insert(index, titlePertama);
                                                                this._titleKedua.insert(index, titleKedua);
                                                                this._subtitlePertama.insert(index, subtitlePertama);
                                                                this._subtitleKedua.insert(index, subtitleKedua);
                                                                this._valueKPI.insert(index, valueKPI);
                                                              });
                                                              Navigator.of(context).pop();
                                                            },
                                                          ),
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
                                                    child: Icon(Icons.note_add, color: Colors.white, size: 14.0),
                                                  ),
                                                  Text(
                                                    'NOTE',
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
                                                title: Column(
                                                  mainAxisAlignment: MainAxisAlignment.start,
                                                  children: <Widget>[
                                                    Container(
                                                      alignment: Alignment.centerLeft,
                                                      child: Text(
                                                        titlePertama,
                                                        style: TextStyle(
                                                          fontSize: 15.0
                                                        ),
                                                      ),
                                                    ),
                                                    Container(
                                                      padding: EdgeInsets.only(top: 2.0),
                                                      alignment: Alignment.centerLeft,
                                                      child: Text(
                                                        _titleKedua[index],
                                                        style: TextStyle(
                                                          fontSize: 13.0
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                subtitle: Column(
                                                  mainAxisAlignment: MainAxisAlignment.start,
                                                  children: <Widget>[
                                                    Container(
                                                      alignment: Alignment.centerLeft,
                                                      padding: EdgeInsets.only(top: 8.0),
                                                      child: Text(
                                                        subtitlePertama,
                                                        style: TextStyle(
                                                          fontSize: 12.0
                                                        ),
                                                      ),
                                                    ),
                                                    Container(
                                                      alignment: Alignment.centerLeft,
                                                      padding: EdgeInsets.only(top: 2.0),
                                                      child: Text(
                                                        'Due Date $subtitleKedua',
                                                        style: TextStyle(
                                                          fontSize: 12.0
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                trailing: ButtonTheme(
                                                  minWidth: 50.0,
                                                  height: 20.0,
                                                  child: OutlineButton(
                                                    child: Padding(
                                                      padding: const EdgeInsets.only(top: 3.0),
                                                      child: Text(
                                                        'ADD',
                                                        style: TextStyle(
                                                            fontSize: 13.0,
                                                            color: Colors.blue
                                                        ),
                                                      ),
                                                    ),
                                                    borderSide: BorderSide(
                                                        color: Colors.blue,
                                                        width: 1.0
                                                    ),
                                                    highlightedBorderColor: Colors.blue,
                                                    onPressed: () {},
                                                  ),
                                                )
                                              ),
                                            )
                                          ),
                                        ),
                                      ],
                                    );
                                  },
                                ),
                              ),
                      ],
                    ),
                  )
                : Container(),
              _openShow
                ? Container(
                    color: Colors.white,
                    padding: EdgeInsets.symmetric(horizontal: 15.0),
                    height: MediaQuery.of(context).size.height / 1.8,
                    child: Column(
                      children: <Widget>[
                        _titlePertama.length == 0
                            ? Center(
                                child: Padding(
                                  padding: EdgeInsets.only(top: 10.0),
                                  child: Text(
                                    'No Data'
                                  ),
                                )
                              )
                            : Flexible(
                                child: ListView.builder(
                                  scrollDirection: Axis.vertical,
                                  itemCount: _titlePertama.length,
                                  itemBuilder: (BuildContext context, int index) {
                                    final String titlePertama = _titlePertama[index];
                                    final String titleKedua = _titleKedua[index];
                                    final String valueKPI = _valueKPI[index];
                                    final String subtitlePertama = _subtitlePertama[index];
                                    final String subtitleKedua = _subtitleKedua[index];

                                    return Column(
                                      children: <Widget>[
                                        Padding(
                                          padding: const EdgeInsets.symmetric(vertical: 10.0),
                                          child: Dismissible(
                                            key: Key(valueKPI),
                                            onDismissed: (DismissDirection dir) {
                                              setState(() {
                                                this._titlePertama.removeAt(index);
                                                this._titleKedua.removeAt(index);
                                                this._valueKPI.removeAt(index);
                                                this._subtitlePertama.removeAt(index);
                                                this._subtitleKedua.removeAt(index);
                                              });

                                              dir == DismissDirection.startToEnd
                                                ? Scaffold.of(context).showSnackBar(
                                                    SnackBar(
                                                      content: RichText(
                                                        overflow: TextOverflow.ellipsis,
                                                        text: TextSpan(
                                                          text: dir == DismissDirection.startToEnd
                                                          ? '$titlePertama - $titleKedua'
                                                          : '$titlePertama - $titleKedua',
                                                        ),
                                                      ),
                                                      action: SnackBarAction(
                                                        label: 'UNDO',
                                                        onPressed: () {
                                                          setState(() {
                                                            this._titlePertama.insert(index, titlePertama);
                                                            this._titleKedua.insert(index, titleKedua);
                                                            this._subtitlePertama.insert(index, subtitlePertama);
                                                            this._subtitleKedua.insert(index, subtitleKedua);
                                                            this._valueKPI.insert(index, valueKPI);
                                                          });
                                                        },
                                                      ),
                                                      duration: Duration(
                                                        seconds: 3
                                                      ),
                                                    )
                                                  )
                                                : showDialog(
                                                    context: context,
                                                    builder: (context) {
                                                      return AlertDialog(
                                                        title: Text('$titlePertama - $titleKedua'),
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
                                                            splashColor: Colors.redAccent,
                                                            child: Text(
                                                              'Cancel',
                                                              style: TextStyle(
                                                                color: Colors.redAccent
                                                              ),
                                                            ),
                                                            onPressed: () {
                                                              setState(() {
                                                                this._titlePertama.insert(index, titlePertama);
                                                                this._titleKedua.insert(index, titleKedua);
                                                                this._subtitlePertama.insert(index, subtitlePertama);
                                                                this._subtitleKedua.insert(index, subtitleKedua);
                                                                this._valueKPI.insert(index, valueKPI);
                                                              });
                                                              Navigator.of(context).pop();
                                                            },
                                                          ),
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
                                                    child: Icon(Icons.note_add, color: Colors.white, size: 14.0),
                                                  ),
                                                  Text(
                                                    'NOTE',
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
                                            child: Column(
                                              children: <Widget>[
                                                Container(
                                                  color: Colors.white,
                                                  child: ListTile(
                                                    title: Column(
                                                      mainAxisAlignment: MainAxisAlignment.start,
                                                      children: <Widget>[
                                                        Container(
                                                          alignment: Alignment.centerLeft,
                                                          child: Text(
                                                            titlePertama,
                                                            style: TextStyle(
                                                              fontSize: 15.0
                                                            ),
                                                          ),
                                                        ),
                                                        Container(
                                                          padding: EdgeInsets.only(top: 2.0),
                                                          alignment: Alignment.centerLeft,
                                                          child: Text(
                                                            _titleKedua[index],
                                                            style: TextStyle(
                                                              fontSize: 13.0
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    subtitle: Column(
                                                      mainAxisAlignment: MainAxisAlignment.start,
                                                      children: <Widget>[
                                                        Container(
                                                          alignment: Alignment.centerLeft,
                                                          padding: EdgeInsets.only(top: 8.0),
                                                          child: Text(
                                                            subtitlePertama,
                                                            style: TextStyle(
                                                              fontSize: 12.0
                                                            ),
                                                          ),
                                                        ),
                                                        Container(
                                                          alignment: Alignment.centerLeft,
                                                          padding: EdgeInsets.only(top: 2.0),
                                                          child: Row(
                                                            children: <Widget>[
                                                              Text(
                                                                'Due Date $subtitleKedua',
                                                                style: TextStyle(
                                                                  fontSize: 12.0
                                                                ),
                                                              ),
                                                              Padding(
                                                                padding: EdgeInsets.symmetric(horizontal: 5.0),
                                                                child: Text(
                                                                  '|',
                                                                  style: TextStyle(
                                                                    fontSize: 12.0
                                                                  ),
                                                                ),
                                                              ),
                                                              Text(
                                                                'Overdue',
                                                                style: TextStyle(
                                                                  fontSize: 12.0,
                                                                  color: Colors.redAccent
                                                                ),
                                                              ),
                                                              Padding(
                                                                padding: EdgeInsets.symmetric(horizontal: 2.0),
                                                                child: Text(
                                                                  ':',
                                                                  style: TextStyle(
                                                                    fontSize: 12.0
                                                                  ),
                                                                ),
                                                              ),
                                                              Text(
                                                                '2 days',
                                                                style: TextStyle(
                                                                  fontSize: 12.0
                                                                ),
                                                              ),
                                                            ],
                                                          )
                                                        ),
                                                      ],
                                                    ),
                                                    trailing: Column(
                                                      children: <Widget>[
                                                        ButtonTheme(
                                                          minWidth: 50.0,
                                                          height: 20.0,
                                                          child: OutlineButton(
                                                            child: Padding(
                                                              padding: const EdgeInsets.only(top: 3.0),
                                                              child: Text(
                                                                'ADD',
                                                                style: TextStyle(
                                                                    fontSize: 13.0,
                                                                    color: Colors.blue
                                                                ),
                                                              ),
                                                            ),
                                                            borderSide: BorderSide(
                                                                color: Colors.blue,
                                                                width: 1.0
                                                            ),
                                                            highlightedBorderColor: Colors.blue,
                                                            onPressed: () {},
                                                          ),
                                                        ),
                                                        FlatButton(
                                                          splashColor: Colors.grey,
                                                          child: Text(
                                                            'Comment',
                                                            style: TextStyle(
                                                              color: Colors.green
                                                            ),
                                                          ),
                                                          onPressed: () {
                                                            setState(() {
                                                              _comment = !_comment;                                                              
                                                            });
                                                          },
                                                        )
                                                      ],
                                                    )
                                                  ),
                                                ),
                                                _comment
                                                  ? Padding(
                                                      padding: const EdgeInsets.fromLTRB(5.0, 8.0, 5.0, 8.0),
                                                      child: ListTile(
                                                        leading: Container(
                                                          width: 35.0,
                                                          height: 35.0,
                                                          decoration: new BoxDecoration(
                                                            shape: BoxShape.circle,
                                                            image: new DecorationImage(
                                                              fit: BoxFit.fill,
                                                              image: NetworkImage(
                                                                  "https://www.biography.com/.image/ar_1:1%2Cc_fill%2Ccs_srgb%2Cg_face%2Cq_auto:good%2Cw_300/MTE5NTU2MzE2NDE4MzExNjkx/jackie-chan-9542080-1-402.jpg"),
                                                            ),
                                                          ),
                                                        ),
                                                        title: Container(
                                                          width: 150.0,
                                                          child: TextField(
                                                            maxLines: null,
                                                            keyboardType: TextInputType.text,
                                                            decoration: InputDecoration(
                                                              hintText: 'Sampaikan komentar Anda',
                                                              hintStyle: TextStyle(fontSize: 12.0),
                                                            ),
                                                            textCapitalization: TextCapitalization.sentences,
                                                            style: TextStyle(
                                                              color: Colors.black,
                                                            ),
                                                          ),
                                                        ),
                                                        trailing: ButtonTheme(
                                                          minWidth: 50.0,
                                                          height: 20.0,
                                                          child: RaisedButton(
                                                            color: AbubaPallate.greenabuba,
                                                            splashColor: AbubaPallate.greensatu,
                                                            child: Text(
                                                              'Kirim',
                                                              style: TextStyle(fontSize: 12.0, color: Colors.white),
                                                            ),
                                                            onPressed: () {},
                                                          ),
                                                        ),
                                                        onTap: null,
                                                      ),
                                                    )
                                                  : Container()
                                              ],
                                            )
                                          ),
                                        ),
                                      ],
                                    );
                                  },
                                ),
                              ),
                      ],
                    ),
                  )
                : Container(),
              _doneShow
                ? Column(
                    children: <Widget>[
                      Container(
                        color: Colors.white,
                        alignment: Alignment.centerLeft,
                        padding:
                            const EdgeInsets.only(right: 25.0, left: 25.0, top: 5.0),
                        child: Column(
                          children: <Widget>[
                            Text(
                              '90%',
                              style: TextStyle(color: Colors.black54, fontSize: 24.0),
                            ),
                          ],
                        )
                      ),
                      Container(
                        color: Colors.white,
                        alignment: Alignment.centerLeft,
                        child: LinearPercentIndicator(
                          padding: EdgeInsets.only(right: 25.0, left: 25.0),
                          width: width,
                          center: Text(
                            'Good',
                            style: TextStyle(
                              color: Colors.grey[50]
                            ),
                          ),
                          animation: true,
                          lineHeight: 30.0,
                          percent: 0.9,
                          animationDuration: 1000,
                          linearStrokeCap: LinearStrokeCap.butt,
                          progressColor: Colors.green[300],
                        )
                      ),
                      Container(
                        color: Colors.white,
                        padding: EdgeInsets.symmetric(horizontal: 15.0),
                        height: MediaQuery.of(context).size.height / 1.8,
                        child: Column(
                          children: <Widget>[
                            _titlePertama.length == 0
                                ? Center(
                                    child: Padding(
                                      padding: EdgeInsets.only(top: 10.0),
                                      child: Text(
                                        'No Data'
                                      ),
                                    )
                                  )
                                : Flexible(
                                    child: ListView.builder(
                                      scrollDirection: Axis.vertical,
                                      itemCount: _titlePertama.length,
                                      itemBuilder: (BuildContext context, int index) {
                                        final String titlePertama = _titlePertama[index];
                                        final String titleKedua = _titleKedua[index];
                                        final String valueKPI = _valueKPI[index];
                                        final String subtitlePertama = _subtitlePertama[index];
                                        final String subtitleKedua = _subtitleKedua[index];

                                        return Column(
                                          children: <Widget>[
                                            Padding(
                                              padding: const EdgeInsets.symmetric(vertical: 10.0),
                                              child: Dismissible(
                                                key: Key(valueKPI),
                                                onDismissed: (DismissDirection dir) {
                                                  setState(() {
                                                    this._titlePertama.removeAt(index);
                                                    this._titleKedua.removeAt(index);
                                                    this._valueKPI.removeAt(index);
                                                    this._subtitlePertama.removeAt(index);
                                                    this._subtitleKedua.removeAt(index);
                                                  });

                                                  dir == DismissDirection.startToEnd
                                                    ? Scaffold.of(context).showSnackBar(
                                                        SnackBar(
                                                          content: RichText(
                                                            overflow: TextOverflow.ellipsis,
                                                            text: TextSpan(
                                                              text: dir == DismissDirection.startToEnd
                                                              ? '$titlePertama - $titleKedua'
                                                              : '$titlePertama - $titleKedua',
                                                            ),
                                                          ),
                                                          action: SnackBarAction(
                                                            label: 'UNDO',
                                                            onPressed: () {
                                                              setState(() {
                                                                this._titlePertama.insert(index, titlePertama);
                                                                this._titleKedua.insert(index, titleKedua);
                                                                this._subtitlePertama.insert(index, subtitlePertama);
                                                                this._subtitleKedua.insert(index, subtitleKedua);
                                                                this._valueKPI.insert(index, valueKPI);
                                                              });
                                                            },
                                                          ),
                                                          duration: Duration(
                                                            seconds: 3
                                                          ),
                                                        )
                                                      )
                                                    : showDialog(
                                                        context: context,
                                                        builder: (context) {
                                                          return AlertDialog(
                                                            title: Text('$titlePertama - $titleKedua'),
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
                                                                splashColor: Colors.redAccent,
                                                                child: Text(
                                                                  'Cancel',
                                                                  style: TextStyle(
                                                                    color: Colors.redAccent
                                                                  ),
                                                                ),
                                                                onPressed: () {
                                                                  setState(() {
                                                                    this._titlePertama.insert(index, titlePertama);
                                                                    this._titleKedua.insert(index, titleKedua);
                                                                    this._subtitlePertama.insert(index, subtitlePertama);
                                                                    this._subtitleKedua.insert(index, subtitleKedua);
                                                                    this._valueKPI.insert(index, valueKPI);
                                                                  });
                                                                  Navigator.of(context).pop();
                                                                },
                                                              ),
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
                                                        child: Icon(Icons.note_add, color: Colors.white, size: 14.0),
                                                      ),
                                                      Text(
                                                        'NOTE',
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
                                                child: Column(
                                                  children: <Widget>[
                                                    Container(
                                                      color: Colors.white,
                                                      child: ListTile(
                                                        title: Column(
                                                          mainAxisAlignment: MainAxisAlignment.start,
                                                          children: <Widget>[
                                                            Container(
                                                              alignment: Alignment.centerLeft,
                                                              child: Text(
                                                                titlePertama,
                                                                style: TextStyle(
                                                                  fontSize: 15.0
                                                                ),
                                                              ),
                                                            ),
                                                            Container(
                                                              padding: EdgeInsets.only(top: 2.0),
                                                              alignment: Alignment.centerLeft,
                                                              child: Text(
                                                                _titleKedua[index],
                                                                style: TextStyle(
                                                                  fontSize: 13.0
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                        subtitle: Column(
                                                          mainAxisAlignment: MainAxisAlignment.start,
                                                          children: <Widget>[
                                                            Container(
                                                              alignment: Alignment.centerLeft,
                                                              padding: EdgeInsets.only(top: 8.0),
                                                              child: Text(
                                                                subtitlePertama,
                                                                style: TextStyle(
                                                                  fontSize: 12.0
                                                                ),
                                                              ),
                                                            ),
                                                            Container(
                                                              alignment: Alignment.centerLeft,
                                                              padding: EdgeInsets.only(top: 2.0),
                                                              child: Row(
                                                                children: <Widget>[
                                                                  Text(
                                                                    'Due Date $subtitleKedua',
                                                                    style: TextStyle(
                                                                      fontSize: 12.0
                                                                    ),
                                                                  ),
                                                                  Padding(
                                                                    padding: EdgeInsets.symmetric(horizontal: 5.0),
                                                                    child: Text(
                                                                      '|',
                                                                      style: TextStyle(
                                                                        fontSize: 12.0
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  Text(
                                                                    'Overdue',
                                                                    style: TextStyle(
                                                                      fontSize: 12.0,
                                                                      color: Colors.redAccent
                                                                    ),
                                                                  ),
                                                                  Padding(
                                                                    padding: EdgeInsets.symmetric(horizontal: 2.0),
                                                                    child: Text(
                                                                      ':',
                                                                      style: TextStyle(
                                                                        fontSize: 12.0
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  Text(
                                                                    '2 days',
                                                                    style: TextStyle(
                                                                      fontSize: 12.0
                                                                    ),
                                                                  ),
                                                                ],
                                                              )
                                                            ),
                                                          ],
                                                        ),
                                                        trailing: Column(
                                                          children: <Widget>[
                                                            ButtonTheme(
                                                              minWidth: 50.0,
                                                              height: 20.0,
                                                              child: OutlineButton(
                                                                child: Padding(
                                                                  padding: const EdgeInsets.only(top: 3.0),
                                                                  child: Text(
                                                                    'EDIT',
                                                                    style: TextStyle(
                                                                        fontSize: 13.0,
                                                                        color: Colors.blue
                                                                    ),
                                                                  ),
                                                                ),
                                                                borderSide: BorderSide(
                                                                    color: Colors.blue,
                                                                    width: 1.0
                                                                ),
                                                                highlightedBorderColor: Colors.blue,
                                                                onPressed: () {},
                                                              ),
                                                            ),
                                                            FlatButton(
                                                              splashColor: Colors.grey,
                                                              child: Text(
                                                                'Note',
                                                                style: TextStyle(
                                                                  color: Colors.green
                                                                ),
                                                              ),
                                                              onPressed: () {
                                                                setState(() {
                                                                  _noteShowDone = !_noteShowDone;                                                              
                                                                });
                                                              },
                                                            )
                                                          ],
                                                        )
                                                      ),
                                                    ),
                                                    _noteShowDone
                                                      ? Padding(
                                                          padding: const EdgeInsets.fromLTRB(5.0, 8.0, 5.0, 8.0),
                                                          child: ListTile(
                                                            leading: Container(
                                                              width: 35.0,
                                                              height: 35.0,
                                                              decoration: new BoxDecoration(
                                                                shape: BoxShape.circle,
                                                                image: new DecorationImage(
                                                                  fit: BoxFit.fill,
                                                                  image: NetworkImage(
                                                                      "https://www.biography.com/.image/ar_1:1%2Cc_fill%2Ccs_srgb%2Cg_face%2Cq_auto:good%2Cw_300/MTE5NTU2MzE2NDE4MzExNjkx/jackie-chan-9542080-1-402.jpg"),
                                                                ),
                                                              ),
                                                            ),
                                                            title: Container(
                                                              width: 150.0,
                                                              child: TextField(
                                                                maxLines: null,
                                                                keyboardType: TextInputType.text,
                                                                decoration: InputDecoration(
                                                                  hintText: 'Sampaikan komentar Anda',
                                                                  hintStyle: TextStyle(fontSize: 12.0),
                                                                ),
                                                                textCapitalization: TextCapitalization.sentences,
                                                                style: TextStyle(
                                                                  color: Colors.black,
                                                                ),
                                                              ),
                                                            ),
                                                            trailing: ButtonTheme(
                                                              minWidth: 50.0,
                                                              height: 20.0,
                                                              child: RaisedButton(
                                                                color: AbubaPallate.greenabuba,
                                                                splashColor: AbubaPallate.greensatu,
                                                                child: Text(
                                                                  'Kirim',
                                                                  style: TextStyle(fontSize: 12.0, color: Colors.white),
                                                                ),
                                                                onPressed: () {},
                                                              ),
                                                            ),
                                                            onTap: null,
                                                          ),
                                                        )
                                                      : Container()
                                                  ],
                                                )
                                              ),
                                            ),
                                          ],
                                        );
                                      },
                                    ),
                                  ),
                          ],
                        ),
                      )
                  ],
                )
                : Container()
            ],
          )
        ],
      ),
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
            'assets/images/logo.png',
            height: 100.0,
            width: 120.0,
          ),
          new Container(
            child: Container(
              child: Row(
                children: [
                  Icon(
                    Icons.favorite,
                    color: Colors.red[500],
                    size: 20.0,
                  ),
                  SizedBox(
                    width: 5.0,
                  ),
                  Text(
                    '41 pts',
                    style: TextStyle(fontSize: 12.0, color: Colors.grey),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
