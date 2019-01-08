import 'package:flutter/material.dart';
import 'package:flutter_abuba/constant.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:intl/intl.dart';

class MenuNotulen extends StatefulWidget {
  @override
  _MenuNotulenState createState() => _MenuNotulenState();
}

class _MenuNotulenState extends State<MenuNotulen>
    with SingleTickerProviderStateMixin {
  final dateFormat = DateFormat("MMMM d, yyyy");
  DateTime dateStart;
  DateTime dateEnd;
  DateTime dateSchedule;

  String _mySelection;
  String _jenisAcara;
  List<Map> _jenisAcaraJson = [
    {"id": 1, "jenis": "PIC 1"},
    {"id": 2, "jenis": "PIC 2"}
  ];

  TabController _tabController;

  final List<Tab> internalAuditTabs = <Tab>[
    new Tab(child: Text('Notulen', style: TextStyle(color: Colors.grey[400]))),
    new Tab(child: Text('Report', style: TextStyle(color: Colors.grey[400]))),
  ];

  @override
  void initState() {
    super.initState();
    _tabController =
        TabController(vsync: this, length: internalAuditTabs.length);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: _appBar(),
          body: GestureDetector(
            onTap: () {
              FocusScope.of(context).requestFocus(FocusNode());
            },
            child: TabBarView(
              controller: _tabController,
              children: <Widget>[_buildNotulenForm(), _buildReport()],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNotulenForm() {
    return ListView(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 0.0),
          child: TextFormField(
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
              labelText: 'Issue',
              labelStyle: TextStyle(fontSize: 12.0),
            ),
            textCapitalization: TextCapitalization.sentences,
            style: TextStyle(
              color: Colors.black,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 0.0),
          child: TextFormField(
            maxLines: null,
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
              labelText: 'Action Plan',
              labelStyle: TextStyle(fontSize: 12.0),
            ),
            textCapitalization: TextCapitalization.sentences,
            style: TextStyle(
              color: Colors.black,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(20.0, 5.0, 20.0, 0.0),
          child: Container(
            width: MediaQuery.of(context).size.width,
            child: DropdownButtonFormField<String>(
              hint: Text(
                'PIC',
                style: TextStyle(fontSize: 12.0),
              ),
              value: _mySelection,
              onChanged: (String newValue) {
                setState(() {
                  switch (int.tryParse(newValue)) {
                    case 1:
                      _jenisAcara = 'PIC 1';
                      break;
                    case 2:
                      _jenisAcara = 'PIC 2';
                      break;
                    default:
                      _jenisAcara = '-';
                      break;
                  }
                  _mySelection = newValue;
                });
              },
              items: _jenisAcaraJson.map((Map map) {
                return new DropdownMenuItem(
                  value: map['id'].toString(),
                  child: Text(map['jenis']),
                );
              }).toList(),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 0.0),
          child: DateTimePickerFormField(
            format: dateFormat,
            onChanged: (dt) => setState(() => dateStart = dt),
            dateOnly: true,
            style: TextStyle(fontSize: 14.0, color: Colors.black),
            decoration: InputDecoration(
                border: UnderlineInputBorder(),
                labelStyle: TextStyle(fontSize: 12.0),
                labelText: 'Due Date'),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 10.0, right: 20.0),
              child: ButtonTheme(
                minWidth: 50.0,
                height: 30.0,
                child: OutlineButton(
                  child: Text(
                    'CHECK OUT',
                    style: TextStyle(fontSize: 13.0, color: Colors.redAccent),
                  ),
                  borderSide: BorderSide(color: Colors.redAccent, width: 1.0),
                  highlightedBorderColor: Colors.redAccent,
                  splashColor: Colors.redAccent,
                  onPressed: () {},
                ),
              ),
            ),
          ],
        )
      ],
    );
  }

  Widget _buildReport() {
    return ListView(
      children: <Widget>[
        Container(
          color: Colors.white,
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 0.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Flexible(
                      child: Text(
                        'Input by : Ridwan',
                        style: TextStyle(color: AbubaPallate.greenabuba),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20.0, 5.0, 20.0, 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Flexible(
                      child: Text(
                        '17/09/2018 - 12:12:12',
                        style: TextStyle(
                            color: AbubaPallate.greenabuba,
                            fontSize: 12.0,
                            fontWeight: FontWeight.w400),
                      ),
                    ),
                  ],
                ),
              ),
              Divider(height: 8.0,),
              Padding(
                padding: const EdgeInsets.fromLTRB(20.0, 8.0, 20.0, 0.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Flexible(
                      child: Text(
                        'Issue',
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20.0, 5.0, 20.0, 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Flexible(
                      child: Text(
                        '-',
                        style: TextStyle(
                            fontSize: 12.0,
                            fontWeight: FontWeight.w400, color: Colors.grey),
                      ),
                    ),
                  ],
                ),
              ),
              Divider(height: 8.0,),
              Padding(
                padding: const EdgeInsets.fromLTRB(20.0, 8.0, 20.0, 0.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Flexible(
                      child: Text(
                        'Action Plan',
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20.0, 5.0, 20.0, 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Flexible(
                      child: Text(
                        '-',
                        style: TextStyle(
                            fontSize: 12.0,
                            fontWeight: FontWeight.w400, color: Colors.grey),
                      ),
                    ),
                  ],
                ),
              ),
              Divider(height: 8.0,),
              Padding(
                padding: const EdgeInsets.fromLTRB(20.0, 8.0, 20.0, 0.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Flexible(
                      child: Text(
                        'PIC',
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20.0, 5.0, 20.0, 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Flexible(
                      child: Text(
                        '-',
                        style: TextStyle(
                            fontSize: 12.0,
                            fontWeight: FontWeight.w400, color: Colors.grey),
                      ),
                    ),
                  ],
                ),
              ),
              Divider(height: 8.0,),
              Padding(
                padding: const EdgeInsets.fromLTRB(20.0, 8.0, 20.0, 0.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Flexible(
                      child: Text(
                        'Due Date',
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20.0, 5.0, 20.0, 12.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Flexible(
                      child: Text(
                        '-',
                        style: TextStyle(
                            fontSize: 12.0,
                            fontWeight: FontWeight.w400, color: Colors.grey),
                      ),
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
            child: new Row(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.only(right: 15.0),
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
                )
              ],
            ),
          )
        ],
      ),
      bottom: new TabBar(
        controller: _tabController,
        isScrollable: false,
        indicatorColor: AbubaPallate.greenabuba,
        tabs: internalAuditTabs,
      ),
    );
  }
}
