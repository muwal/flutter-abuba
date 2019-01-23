import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_abuba/constant.dart';
import 'package:intl/intl.dart';

class FormA3Report extends StatefulWidget {
  @override
  _FormA3ReportState createState() => _FormA3ReportState();
}

class _FormA3ReportState extends State<FormA3Report> with TickerProviderStateMixin {
  List<Map> _listData = [ {'nomor': '1'}, {'nomor': '2'}, {'nomor': '3'}, {'nomor': '4'}, {'nomor': '5'}, {'nomor': '6'}, {'nomor': '7'}];

  String _issueBackgroundSelection;
  String _issueBackground;
  List<Map> _issueBackgroundJson = [
    {"id": 1, "issueBackground": "Issue 1"},
    {"id": 2, "issueBackground": "Issue 2"},
  ];

  String _contextSelection;
  String _context;
  List<Map> _contextJson = [
    {"id": 1, "context": "Context 1"},
    {"id": 2, "context": "Context 2"},
  ];

  Color _colorLowSe = Colors.grey;
  Color _colorMedSe = Colors.grey;
  Color _colorHighSe = Colors.grey;

  String _whoSelection;
  String _who;
  List<Map> _whoJson = [
    {"id": 1, "who": "Ridwan"},
    {"id": 2, "who": "Sony"},
    {"id": 3, "who": "Rijal"},
  ];

  String _whereSelection;
  String _where;
  List<Map> _whereJson = [
    {"id": 1, "where": "Outlet A"},
    {"id": 2, "where": "Outlet B"},
    {"id": 3, "where": "Outlet C"},
  ];

  final dateFormat = DateFormat("MMMM d, yyyy");
  DateTime dateWhen;

  Color _opening = Colors.green;
  Color _middle = Colors.grey;

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
                                            '1. Theme',
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
                          Container(
                            padding: EdgeInsets.symmetric(vertical: 75.0),
                            color: Colors.white,
                            alignment: Alignment.center,
                            child: Column(
                              children: <Widget>[
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Flexible(
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(horizontal: 10.0),
                                        child: Text(
                                          'What Are You Trying to Accomplish ?',
                                          style: TextStyle(
                                            color: Color(0xFF2F592F),
                                            fontSize: 32.0,
                                            fontWeight: FontWeight.bold
                                          ),
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 20.0, left: 20.0, right: 20.0),
                                  child: TextFormField(
                                    textCapitalization: TextCapitalization.sentences,
                                    decoration: InputDecoration(
                                      border: UnderlineInputBorder(),
                                      labelText: 'Problem or Issue',
                                      labelStyle: TextStyle(fontSize: 16.0),
                                    ),
                                    maxLines: 3,
                                    keyboardType: TextInputType.multiline,
                                    style: TextStyle(
                                      fontStyle: FontStyle.normal,
                                      color: Colors.black87,
                                      fontSize: 16.0),
                                    onSaved: null,
                                  ),
                                ),
                              ],
                            ),
                          ),
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
                                            '2. Background',
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
                          Padding(
                            padding: const EdgeInsets.only(top: 10.0, left: 20.0, right: 20.0),
                            child: DropdownButtonFormField<String>(
                              decoration: InputDecoration(
                                labelText: 'Issue Background',
                                labelStyle: TextStyle(fontSize: 16.0),
                              ),
                              value: _issueBackgroundSelection,
                              onChanged: (String value) {
                                setState(() {
                                  switch (int.tryParse(value)) {
                                    case 1:
                                      _issueBackground = 'Issue 1';
                                      break;
                                    case 2:
                                      _issueBackground = 'Issue 2';
                                      break;
                                    default:
                                      _issueBackground = '-';
                                      break;
                                  }
                                  _issueBackgroundSelection = value;
                                });
                              },
                              items: _issueBackgroundJson.map((Map map) {
                                return DropdownMenuItem(
                                  value: map['id'].toString(),
                                  child: Text(map['issueBackground'], style: TextStyle(fontSize: 16.0, color: Colors.black87, fontStyle: FontStyle.normal)),
                                );
                              }).toList(),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 10.0, left: 20.0, right: 20.0),
                            child: DropdownButtonFormField<String>(
                              decoration: InputDecoration(
                                labelText: 'Context',
                                labelStyle: TextStyle(fontSize: 16.0),
                              ),
                              value: _contextSelection,
                              onChanged: (String value) {
                                setState(() {
                                  switch (int.tryParse(value)) {
                                    case 1:
                                      _context = 'Context 1';
                                      break;
                                    case 2:
                                      _context = 'Context 2';
                                      break;
                                    default:
                                      _context = '-';
                                      break;
                                  }
                                  _contextSelection = value;
                                });
                              },
                              items: _contextJson.map((Map map) {
                                return DropdownMenuItem(
                                  value: map['id'].toString(),
                                  child: Text(map['context'], style: TextStyle(fontSize: 16.0, color: Colors.black87, fontStyle: FontStyle.normal)),
                                );
                              }).toList(),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 30.0, left: 20.0, right: 20.0),
                            child: Column(
                              children: <Widget>[
                                Container(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    'Importance',
                                    style: TextStyle(
                                      color: Colors.black54,
                                      fontSize: 16.0
                                    ),
                                    textAlign: TextAlign.start,
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.only(top: 5.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                                    children: <Widget>[
                                      ButtonTheme(
                                        height: 30.0,
                                        child: OutlineButton(
                                          child: Text(
                                            'Low',
                                            style: TextStyle(
                                              color: _colorLowSe,
                                              fontSize: 16.0
                                            ),
                                          ),
                                          borderSide: BorderSide(
                                            color: _colorLowSe,
                                            width: 1.0
                                          ),
                                          highlightedBorderColor: _colorLowSe,
                                          onPressed: () {
                                            setState(() {
                                              _colorLowSe = Colors.green[400];
                                              _colorMedSe = Colors.grey;
                                              _colorHighSe = Colors.grey;
                                            });
                                          },
                                        ),
                                      ),
                                      ButtonTheme(
                                        height: 30.0,
                                        child: OutlineButton(
                                          child: Text(
                                            'Medium',
                                            style: TextStyle(
                                              color: _colorMedSe,
                                              fontSize: 16.0
                                            ),
                                          ),
                                          borderSide: BorderSide(
                                            color: _colorMedSe,
                                            width: 1.0
                                          ),
                                          highlightedBorderColor: _colorMedSe,
                                          onPressed: () {
                                            setState(() {
                                              _colorLowSe = Colors.grey;
                                              _colorMedSe = Colors.orangeAccent;
                                              _colorHighSe = Colors.grey;
                                            });
                                          },
                                        ),
                                      ),
                                      ButtonTheme(
                                        height: 30.0,
                                        child: OutlineButton(
                                          child: Text(
                                            'High',
                                            style: TextStyle(
                                              color: _colorHighSe,
                                              fontSize: 16.0
                                            ),
                                          ),
                                          borderSide: BorderSide(
                                            color: _colorHighSe,
                                            width: 1.0
                                          ),
                                          highlightedBorderColor: _colorHighSe,
                                          onPressed: () {
                                            setState(() {
                                              _colorLowSe = Colors.grey;
                                              _colorMedSe = Colors.grey;
                                              _colorHighSe = Colors.redAccent;
                                            });
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            )
                          ),
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
                                            '3. Current Condition',
                                            style: TextStyle(color: Colors.white, fontSize: 14.0),
                                            textAlign: TextAlign.start,
                                          ),
                                          Text(
                                            '3 of ${_listData.length.toString()}',
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
                          Padding(
                            padding: const EdgeInsets.only(top: 20.0, left: 20.0, right: 20.0),
                            child: TextFormField(
                              textCapitalization: TextCapitalization.sentences,
                              decoration: InputDecoration(
                                border: UnderlineInputBorder(),
                                labelText: 'Situation / Process Diagram',
                                labelStyle: TextStyle(fontSize: 16.0),
                              ),
                              keyboardType: TextInputType.multiline,
                              maxLines: 3,
                              style: TextStyle(
                                fontStyle: FontStyle.normal,
                                color: Colors.black87,
                                fontSize: 16.0),
                              onSaved: null,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 20.0, left: 20.0, right: 20.0),
                            child: TextFormField(
                              textCapitalization: TextCapitalization.sentences,
                              decoration: InputDecoration(
                                border: UnderlineInputBorder(),
                                labelText: 'Highlighted Problem',
                                labelStyle: TextStyle(fontSize: 16.0),
                              ),
                              keyboardType: TextInputType.multiline,
                              maxLines: 3,
                              style: TextStyle(
                                fontStyle: FontStyle.normal,
                                color: Colors.black87,
                                fontSize: 16.0),
                              onSaved: null,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 20.0, left: 20.0, right: 20.0),
                            child: TextFormField(
                              textCapitalization: TextCapitalization.sentences,
                              decoration: InputDecoration(
                                border: UnderlineInputBorder(),
                                labelText: 'Performance Measures',
                                labelStyle: TextStyle(fontSize: 16.0),
                              ),
                              style: TextStyle(
                                fontStyle: FontStyle.normal,
                                color: Colors.black87,
                                fontSize: 16.0),
                              onSaved: null,
                            ),
                          ),
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
                                            '4. Cause Analysis',
                                            style: TextStyle(color: Colors.white, fontSize: 14.0),
                                            textAlign: TextAlign.start,
                                          ),
                                          Text(
                                            '4 of ${_listData.length.toString()}',
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
                          Padding(
                            padding: const EdgeInsets.only(top: 20.0, left: 20.0, right: 20.0),
                            child: TextFormField(
                              textCapitalization: TextCapitalization.sentences,
                              decoration: InputDecoration(
                                border: UnderlineInputBorder(),
                                labelText: 'Problem',
                                labelStyle: TextStyle(fontSize: 16.0),
                              ),
                              keyboardType: TextInputType.multiline,
                              maxLines: 3,
                              style: TextStyle(
                                fontStyle: FontStyle.normal,
                                color: Colors.black87,
                                fontSize: 16.0),
                              onSaved: null,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 20.0, left: 20.0, right: 20.0),
                            child: TextFormField(
                              textCapitalization: TextCapitalization.sentences,
                              decoration: InputDecoration(
                                border: UnderlineInputBorder(),
                                labelText: 'Cause',
                                labelStyle: TextStyle(fontSize: 16.0),
                              ),
                              style: TextStyle(
                                fontStyle: FontStyle.normal,
                                color: Colors.black87,
                                fontSize: 16.0),
                              onSaved: null,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 20.0, left: 20.0, right: 20.0),
                            child: TextFormField(
                              textCapitalization: TextCapitalization.sentences,
                              decoration: InputDecoration(
                                border: UnderlineInputBorder(),
                                labelText: "5 Why\'s",
                                labelStyle: TextStyle(fontSize: 16.0),
                              ),
                              style: TextStyle(
                                fontStyle: FontStyle.normal,
                                color: Colors.black87,
                                fontSize: 16.0),
                              onSaved: null,
                            ),
                          ),
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
                                            '5. Target Condition',
                                            style: TextStyle(color: Colors.white, fontSize: 14.0),
                                            textAlign: TextAlign.start,
                                          ),
                                          Text(
                                            '5 of ${_listData.length.toString()}',
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
                          Padding(
                            padding: const EdgeInsets.only(top: 20.0, left: 20.0, right: 20.0),
                            child: TextFormField(
                              textCapitalization: TextCapitalization.sentences,
                              decoration: InputDecoration(
                                border: UnderlineInputBorder(),
                                labelText: 'Proposed Process Diagram',
                                labelStyle: TextStyle(fontSize: 16.0, color: Colors.redAccent),
                              ),
                              keyboardType: TextInputType.multiline,
                              maxLines: 3,
                              style: TextStyle(
                                fontStyle: FontStyle.normal,
                                color: Colors.black87,
                                fontSize: 16.0),
                              onSaved: null,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 20.0, left: 20.0, right: 20.0),
                            child: TextFormField(
                              textCapitalization: TextCapitalization.sentences,
                              decoration: InputDecoration(
                                border: UnderlineInputBorder(),
                                labelText: 'Countermeasures',
                                labelStyle: TextStyle(fontSize: 16.0),
                              ),
                              style: TextStyle(
                                fontStyle: FontStyle.normal,
                                color: Colors.black87,
                                fontSize: 16.0),
                              onSaved: null,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 20.0, left: 20.0, right: 20.0),
                            child: TextFormField(
                              textCapitalization: TextCapitalization.sentences,
                              decoration: InputDecoration(
                                border: UnderlineInputBorder(),
                                labelText: 'Measurable Targets',
                                labelStyle: TextStyle(fontSize: 16.0),
                              ),
                              style: TextStyle(
                                fontStyle: FontStyle.normal,
                                color: Colors.black87,
                                fontSize: 16.0),
                              onSaved: null,
                            ),
                          ),
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
                                            '6. Implementaation Plan',
                                            style: TextStyle(color: Colors.white, fontSize: 14.0),
                                            textAlign: TextAlign.start,
                                          ),
                                          Text(
                                            '6 of ${_listData.length.toString()}',
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
                          ListTile(
                            title: Padding(
                              padding: const EdgeInsets.only(top: 10.0, left: 10.0),
                              child: TextFormField(
                                keyboardType: TextInputType.multiline,
                                decoration: InputDecoration(
                                  border: UnderlineInputBorder(),
                                  labelText: 'WHAT - Requirement Actions',
                                  labelStyle: TextStyle(fontSize: 16.0),
                                ),
                                maxLines: 3,
                                style: TextStyle(
                                  fontStyle: FontStyle.normal,
                                  color: Colors.black87,
                                  fontSize: 16.0),
                                onSaved: null,
                              ),
                            ),
                            trailing: IconButton(
                              icon: Icon(Icons.add, color: Colors.white),
                              onPressed: null,
                            ),
                          ),
                          ListTile(
                            title: Padding(
                              padding: const EdgeInsets.only(top: 10.0, left: 10.0),
                              child: DropdownButtonFormField<String>(
                                decoration: InputDecoration(
                                  labelText: 'WHO - Person Responsible',
                                  labelStyle: TextStyle(fontSize: 16.0),
                                ),
                                value: _whoSelection,
                                onChanged: (String value) {
                                  setState(() {
                                    switch (int.tryParse(value)) {
                                      case 1:
                                        _who = 'Ridwan';
                                        break;
                                      case 2:
                                        _who = 'Sony';
                                        break;
                                      case 3:
                                        _who = 'Rijal';
                                        break;
                                      default:
                                        _who = '-';
                                        break;
                                    }
                                    _whoSelection = value;
                                  });
                                },
                                items: _whoJson.map((Map map) {
                                  return DropdownMenuItem(
                                    value: map['id'].toString(),
                                    child: Text(map['who'], style: TextStyle(fontSize: 16.0, color: Colors.black87, fontStyle: FontStyle.normal)),
                                  );
                                }).toList(),
                              ),
                            ),
                            trailing: IconButton(
                              icon: Icon(Icons.add, color: AbubaPallate.greenabuba),
                              onPressed: () {},
                            ),
                          ),
                          ListTile(
                            title: Padding(
                              padding: const EdgeInsets.only(top: 10.0, left: 10.0),
                              child: DateTimePickerFormField(
                                format: dateFormat,
                                onChanged: (dt) =>
                                    setState(() => dateWhen = dt),
                                dateOnly: true,
                                style: TextStyle(
                                  fontSize: 16.0,
                                  color: Colors.black87,
                                ),
                                decoration: InputDecoration(
                                  border: UnderlineInputBorder(),
                                  labelStyle: TextStyle(fontSize: 16.0),
                                  labelText: 'WHEN - Dates'
                                ),
                              ),
                            ),
                            trailing: IconButton(
                              icon: Icon(Icons.add, color: Colors.white),
                              onPressed: null,
                            ),
                          ),
                          ListTile(
                            title: Padding(
                              padding: const EdgeInsets.only(top: 10.0, left: 10.0),
                              child: DropdownButtonFormField<String>(
                                decoration: InputDecoration(
                                  labelText: 'WHERE - Location(s)',
                                  labelStyle: TextStyle(fontSize: 16.0),
                                ),
                                value: _whereSelection,
                                onChanged: (String value) {
                                  setState(() {
                                    switch (int.tryParse(value)) {
                                      case 1:
                                        _where = 'Outlet A';
                                        break;
                                      case 2:
                                        _where = 'Outlet B';
                                        break;
                                      case 3:
                                        _where = 'Outlet C';
                                        break;
                                      default:
                                        _where = '-';
                                        break;
                                    }
                                    _whereSelection = value;
                                  });
                                },
                                items: _whereJson.map((Map map) {
                                  return DropdownMenuItem(
                                    value: map['id'].toString(),
                                    child: Text(map['where'], style: TextStyle(fontSize: 16.0, color: Colors.black87, fontStyle: FontStyle.normal)),
                                  );
                                }).toList(),
                              ),
                            ),
                            trailing: IconButton(
                              icon: Icon(Icons.add, color: Colors.white),
                              onPressed: null,
                            ),
                          ),
                          ListTile(
                            title: Padding(
                              padding: const EdgeInsets.only(top: 10.0, left: 10.0),
                              child: TextFormField(
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                  border: UnderlineInputBorder(),
                                  labelText: 'COST - IDR',
                                  labelStyle: TextStyle(fontSize: 16.0),
                                ),
                                style: TextStyle(
                                  fontStyle: FontStyle.normal,
                                  color: Colors.black87,
                                  fontSize: 16.0),
                                onSaved: null,
                              ),
                            ),
                            trailing: IconButton(
                              icon: Icon(Icons.add, color: Colors.white),
                              onPressed: null,
                            ),
                          ),
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
                                            '7. Follow Up',
                                            style: TextStyle(color: Colors.white, fontSize: 14.0),
                                            textAlign: TextAlign.start,
                                          ),
                                          Text(
                                            '7 of ${_listData.length.toString()}',
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
                          Container(
                            alignment: Alignment.centerLeft,
                            padding: const EdgeInsets.only(right: 20.0, left: 20.0, bottom: 5.0, top: 30.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      _opening = Colors.green;
                                      _middle = Colors.grey;
                                    });
                                  },
                                  child: Container(
                                    width: MediaQuery.of(context).size.width / 4,
                                    child: Column(
                                      children: <Widget>[
                                        Text(
                                          'PLAN',
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: _opening
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(vertical: 5.0),
                                          child: Divider(
                                            height: 10.0,
                                            color: _opening,
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      _opening = Colors.grey;
                                      _middle = Colors.green;
                                    });
                                  },
                                  child: Container(
                                    width: MediaQuery.of(context).size.width / 4,
                                    child: Column(
                                      children: <Widget>[
                                        Text(
                                          'RESULT',
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: _middle
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(vertical: 5.0),
                                          child: Divider(
                                            height: 10.0,
                                            color: _middle,
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            )
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 10.0, left: 20.0, right: 20.0),
                            child: TextFormField(
                              textCapitalization: TextCapitalization.sentences,
                              decoration: InputDecoration(
                                border: UnderlineInputBorder(),
                                labelText: 'Measure',
                                labelStyle: TextStyle(fontSize: 16.0),
                              ),
                              style: TextStyle(
                                fontStyle: FontStyle.normal,
                                color: Colors.black87,
                                fontSize: 16.0),
                              onSaved: null,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 20.0, left: 20.0, right: 20.0),
                            child: TextFormField(
                              textCapitalization: TextCapitalization.sentences,
                              decoration: InputDecoration(
                                border: UnderlineInputBorder(),
                                labelText: 'Marks of Success',
                                labelStyle: TextStyle(fontSize: 16.0),
                              ),
                              style: TextStyle(
                                fontStyle: FontStyle.normal,
                                color: Colors.black87,
                                fontSize: 16.0),
                              onSaved: null,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 20.0, left: 20.0, right: 20.0),
                            child: TextFormField(
                              textCapitalization: TextCapitalization.sentences,
                              decoration: InputDecoration(
                                border: UnderlineInputBorder(),
                                labelText: 'Scheduled Checks',
                                labelStyle: TextStyle(fontSize: 16.0),
                              ),
                              style: TextStyle(
                                fontStyle: FontStyle.normal,
                                color: Colors.black87,
                                fontSize: 16.0),
                              onSaved: null,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 30.0, left: 20.0, right: 20.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: <Widget>[
                                RaisedButton(
                                  onPressed: () {},
                                  child: Text(
                                    'SAVE',
                                    style: TextStyle(
                                      fontSize: 14.0,
                                    ),
                                  ),
                                  textColor: Colors.white,
                                  color: AbubaPallate.greenabuba,
                                )
                              ],
                            )
                          ),
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
        'assets/images/logo.png',
        height: 100.0,
        width: 120.0,
      ),
    );
  }
}