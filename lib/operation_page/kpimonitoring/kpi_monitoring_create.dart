import 'package:flutter/material.dart';
import 'package:flutter_abuba/constant.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:intl/intl.dart';
import 'package:badges/badges.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class CreateKpiMonitoring extends StatefulWidget {
  CreateKpiMonitoring({Key key}) : super(key: key);

  @override
  _CreateKpiMonitoringState createState() => new _CreateKpiMonitoringState();
}

class _CreateKpiMonitoringState extends State<CreateKpiMonitoring> with SingleTickerProviderStateMixin{ 
  GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  TabController _tabController;

  int counter = 0;
  void _addTask() {
    setState(() {
      counter++;      
    });
  }

  final List<Tab> createKpiMonitoringTabs = <Tab>[
    Tab(child: Text('Header', style: TextStyle(color: Colors.grey[400]))),
    Tab(child: Text('Task', style: TextStyle(color: Colors.grey[400]))),
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: createKpiMonitoringTabs.length);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  final dateFormat = DateFormat("MMMM d, yyyy");
  DateTime dateStart;
  DateTime dateEnd;
  DateTime dueDate;
  
  String _categorySelection;
  String _category;
  List<Map> _categoryJSON = [
    {"id":"1", "category":"BRC"},
    {"id":"2", "category":"Not BRC"},
  ];

  String _picSelection;
  String _pic;
  List<Map> _picJSON = [
    {"id":"1", "pic":"Anto"},
    {"id":"2", "pic":"Inem"},
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: DefaultTabController(
        length: createKpiMonitoringTabs.length,
        child: Scaffold(
          resizeToAvoidBottomPadding: false,
          backgroundColor: Colors.white,
          key: _scaffoldKey,
          appBar: _appBar(),
          body: TabBarView(
            controller: _tabController,
            children: <Widget>[
              _buildFormHeader(),
              _buildFormTask()
            ],
          )
        )
      ),
    );
  }

  Widget _buildFormHeader() {
    final double width = MediaQuery.of(context).size.width;

    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 100.0, horizontal: 20.0),
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                  padding: EdgeInsets.only(bottom: 20.0),
                  width: width / 2.5,
                  child: DateTimePickerFormField(
                    format: dateFormat,
                    onChanged: (dt) => setState(() => dateStart = dt),
                    dateOnly: true,
                    style: TextStyle(fontSize: 16.0, color: Colors.black),
                    decoration: InputDecoration(
                      border: UnderlineInputBorder(),
                      labelStyle: TextStyle(fontSize: 14.0),
                      labelText: 'Start'
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(bottom: 20.0),
                  width: width / 2.5,
                  child: DateTimePickerFormField(
                    format: dateFormat,
                    onChanged: (dt) => setState(() => dateEnd = dt),
                    dateOnly: true,
                    style: TextStyle(fontSize: 16.0, color: Colors.black),
                    decoration: InputDecoration(
                      border: UnderlineInputBorder(),
                      labelStyle: TextStyle(fontSize: 14.0),
                      labelText: 'End'
                    ),
                  ),
                )
              ],
            ),
            Container(
              padding: EdgeInsets.only(bottom: 10.0),
              width: width,
              child: DropdownButtonFormField(
                hint: Text(
                  'Category',
                  style: TextStyle(
                    fontSize: 14.0
                  ),
                ),
                value: _categorySelection,
                onChanged: (String value) {
                  setState(() {
                    switch (int.tryParse(value)) {
                      case 1:
                        _category = 'BRC';
                        break;
                      
                      case 2:
                        _category = 'Not BRC';
                        break;
                    }
                    _categorySelection = value;
                  });
                },
                items: _categoryJSON.map((Map map) {
                  return new DropdownMenuItem(
                    value: map['id'].toString(),
                    child: Text(map['category']),
                  );
                }).toList(),
              ),
            ),
            Container(
              padding: EdgeInsets.only(bottom: 10.0),
              width: width,
              child: TextField(
                decoration: InputDecoration(
                  labelText: 'Title',
                  labelStyle: TextStyle(
                    fontSize: 14.0
                  )
                ),
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.only(bottom: 10.0),
              width: width,
              child: TextField(
                decoration: InputDecoration(
                  labelText: 'Description',
                  labelStyle: TextStyle(
                    fontSize: 14.0
                  )
                ),
                maxLines: 3,
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
            ),
            Container(
              alignment: Alignment.centerRight,
              padding: const EdgeInsets.only(top: 10.0),
              child: ButtonTheme(
                minWidth: 50.0,
                height: 30.0,
                child: OutlineButton(
                  child: Text(
                    'NEXT',
                    style: TextStyle(
                        fontSize: 13.0, color: Colors.blue),
                  ),
                  borderSide:
                      BorderSide(color: Colors.blue, width: 1.0),
                  highlightedBorderColor: Colors.blue,
                  onPressed: () {
                    _tabController.animateTo(_tabController.index + 1);
                  },
                ),
              ),
            ),
          ],
        ),
      )
    );
  }

  Widget _buildFormTask() {
    final double width = MediaQuery.of(context).size.width;

    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 125.0, horizontal: 20.0),
        child: Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(bottom: 10.0),
              width: width,
              child: TextField(
                decoration: InputDecoration(
                  labelText: 'Task',
                  labelStyle: TextStyle(
                    fontSize: 14.0
                  )
                ),
                maxLines: 3,
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.only(bottom: 10.0),
              width: width,
              child: DropdownButtonFormField(
                hint: Text(
                  'PIC',
                  style: TextStyle(
                    fontSize: 14.0
                  ),
                ),
                value: _picSelection,
                onChanged: (String value) {
                  setState(() {
                    switch (int.tryParse(value)) {
                      case 1:
                        _pic = 'Anto';
                        break;
                      
                      case 2:
                        _pic = 'Inem';
                        break;
                    }
                    _picSelection = value;
                  });
                },
                items: _picJSON.map((Map map) {
                  return new DropdownMenuItem(
                    value: map['id'].toString(),
                    child: Text(map['pic']),
                  );
                }).toList(),
              ),
            ),
            Container(
              padding: EdgeInsets.only(bottom: 20.0),
              width: width,
              child: DateTimePickerFormField(
                format: dateFormat,
                onChanged: (dt) => setState(() => dueDate = dt),
                dateOnly: true,
                style: TextStyle(fontSize: 16.0, color: Colors.black),
                decoration: InputDecoration(
                  border: UnderlineInputBorder(),
                  labelStyle: TextStyle(fontSize: 14.0),
                  labelText: 'Due Date'
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Container(
                  alignment: Alignment.centerRight,
                  padding: const EdgeInsets.only(top: 10.0, right: 20.0),
                  child: ButtonTheme(
                    minWidth: 50.0,
                    height: 30.0,
                    child: OutlineButton(
                      child: Text(
                        'Back',
                        style: TextStyle(
                            fontSize: 13.0, color: Colors.grey),
                      ),
                      borderSide:
                          BorderSide(color: Colors.grey, width: 1.0),
                      highlightedBorderColor: Colors.grey,
                      onPressed: () {
                        _tabController.animateTo(_tabController.index - 1);
                      },
                    ),
                  ),
                ),
                Container(
                  alignment: Alignment.centerRight,
                  padding: const EdgeInsets.only(top: 10.0),
                  child: ButtonTheme(
                    minWidth: 50.0,
                    height: 30.0,
                    child: OutlineButton(
                      child: Text(
                        'Add',
                        style: TextStyle(
                            fontSize: 13.0, color: Colors.green),
                      ),
                      borderSide:
                          BorderSide(color: Colors.green, width: 1.0),
                      highlightedBorderColor: Colors.green,
                      onPressed: () {
                        _addTask();
                      },
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      )
    );
  }

  Widget _appBar() {
    return AppBar(
      elevation: 0.25,
      backgroundColor: Colors.white,
      iconTheme: IconThemeData(color: Colors.black),
      actions: <Widget>[
        BadgeIconButton(
          itemCount: counter,
          hideZeroCount: true,
          badgeColor: Colors.redAccent,
          badgeTextColor: Colors.white,
          icon: Icon(MdiIcons.formatListCheckbox, size: 26.0),
          onPressed: () {
            Navigator.push(context, 
              MaterialPageRoute(
                builder: (context) => new DataTable(counterData: counter,)
              )
            );
          },
        )
      ],
      title: Image.asset(
        'assets/images/logo.png',
        height: 100.0,
        width: 120.0,
      ),
      bottom: new TabBar(
        controller: _tabController,
        isScrollable: false,
        indicatorColor: AbubaPallate.greenabuba,
        tabs: <Widget>[
          new Tab(
            child: Text(
              'Header',
              style: TextStyle(color: Colors.grey[400]),
            ),
          ),
          new Tab(
            child: Text(
              'Task',
              style: TextStyle(color: Colors.grey[400]),
            ),
          ),
        ],
      ),
    );
  }
}

class DataTable extends StatefulWidget {
  final int counterData;
  DataTable({this.counterData});

  @override
  _DataTableState createState() => new _DataTableState();
}

class _DataTableState extends State<DataTable> {
  int _rowsPerPage = PaginatedDataTable.defaultRowsPerPage;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.counterData.toString()} Data'),
      ),
      body: SingleChildScrollView(
        child: PaginatedDataTable(
          header: Text('Task Data'),
          rowsPerPage: _rowsPerPage,
          availableRowsPerPage: <int>[5, 10, 20],
          onRowsPerPageChanged: (int value) {
            setState(() {
              _rowsPerPage = value;            
            });
          },
          columns: kTableColumns,
          source: DessertDataSource(),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.delete),
              tooltip: 'Delete selected data',
              onPressed: () {
                print('qwe');
              },
            )
          ],
        ),
      ),
    );
  }
}

const kTableColumns = <DataColumn>[
  DataColumn(
    label: const Text('No'),
    numeric: true
  ),
  DataColumn(
    label: const Text('Task'),
  ),
  DataColumn(
    label: const Text('PIC'),
  ),
  DataColumn(
    label: const Text('Due Date'),
  ),
];

class Dessert {
  Dessert({this.no, this.task, this.pic, this.duedate});

  final int no;
  final String task;
  final String pic;
  final String duedate;
  bool selected = false;
}

class DessertDataSource extends DataTableSource {
  int _selectedCount = 0;
  final List<Dessert> _desserts = <Dessert>[
    Dessert(no: 1, task: 'Task 1', pic: 'Udin', duedate: '10 Desember 2018'),
    Dessert(no: 2, task: 'Task 2', pic: 'Udin', duedate: '10 Desember 2018'),
    Dessert(no: 3, task: 'Task 3', pic: 'Udin', duedate: '10 Desember 2018'),
    Dessert(no: 4, task: 'Task 4', pic: 'Udin', duedate: '10 Desember 2018'),
    Dessert(no: 5, task: 'Task 5', pic: 'Udin', duedate: '10 Desember 2018'),
    Dessert(no: 6, task: 'Task 6', pic: 'Udin', duedate: '10 Desember 2018'),
    Dessert(no: 7, task: 'Task 7', pic: 'Udin', duedate: '10 Desember 2018'),
    Dessert(no: 8, task: 'Task 8', pic: 'Udin', duedate: '10 Desember 2018'),
    Dessert(no: 9, task: 'Task 9', pic: 'Udin', duedate: '10 Desember 2018'),
    Dessert(no: 10, task: 'Task 10', pic: 'Udin', duedate: '10 Desember 2018'),
    Dessert(no: 11, task: 'Task 11', pic: 'Udin', duedate: '10 Desember 2018'),
    Dessert(no: 12, task: 'Task 12', pic: 'Udin', duedate: '10 Desember 2018'),
    Dessert(no: 13, task: 'Task 13', pic: 'Udin', duedate: '10 Desember 2018'),
    Dessert(no: 14, task: 'Task 14', pic: 'Udin', duedate: '10 Desember 2018'),
  ];

  @override
  DataRow getRow(int index) {
    assert(index >= 0);
    if (index >= _desserts.length) return null;
    final Dessert dessert = _desserts[index];

    return DataRow.byIndex(
      index: index,
      selected: dessert.selected,
      onSelectChanged: (bool value) {
        if (dessert.selected != value) {
          _selectedCount += value ? 1 : -1;
          assert(_selectedCount >= 0);
          dessert.selected = value;
          notifyListeners();
        }
      },
      cells: <DataCell>[
        DataCell(Text('${dessert.no}')),
        DataCell(Text('${dessert.task}')),
        DataCell(Text('${dessert.pic}')),
        DataCell(Text('${dessert.duedate}')),
      ]
    );
  }

  @override
  int get rowCount => _desserts.length;

  @override
  bool get isRowCountApproximate => false;

  @override
  int get selectedRowCount => _selectedCount;
}