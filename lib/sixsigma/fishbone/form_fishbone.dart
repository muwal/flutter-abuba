import 'package:datetime_picker_formfield/time_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter_abuba/constant.dart';
import 'package:intl/intl.dart';

class FishBone extends StatefulWidget {
  final String titleJudul;

  FishBone({this.titleJudul});

  @override
  _FishBoneState createState() => _FishBoneState();
}

class _FishBoneState extends State<FishBone> {
  TextEditingController _controller = TextEditingController();
  TextEditingController _controllerDetail = TextEditingController();
  TextEditingController _controllerDetailBanget = TextEditingController();
  TextEditingController _controllerScore = TextEditingController();
  List<String> _list = [];
  List<String> _listDua = [];
  List<String> _listTiga = [];
  List<String> _listTigaScore = [];
  List<List<String>> _allList = [];

  bool _confirm = false;
  bool _confirmDua = false;
  bool _confirmTiga = false;
  String _textButton = 'CONFIRM';

  bool _scoreShow = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: _appBar(widget.titleJudul),
        body: GestureDetector(
          onTap: () {
            FocusScope.of(context).requestFocus(FocusNode());
          },
          child: _confirm == false ? Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              ListTile(
                title: Container(
                  padding: const EdgeInsets.only(top: 20.0, bottom: 20.0),
                  width: _scoreShow ? MediaQuery.of(context).size.width - 100.0 : MediaQuery.of(context).size.width,
                  child: TextField(
                    textCapitalization: TextCapitalization.sentences,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Type Here',
                      labelStyle: TextStyle(fontSize: 14.0)
                    ),
                    controller: _controller,
                    style: TextStyle(color: Colors.black),
                    onEditingComplete: () {
                      setState(() {
                        _list.add(_controller.text);
                        _controller.clear();
                      });
                    },
                  ),
                ),
                trailing: _scoreShow
                  ? Container(
                      padding: const EdgeInsets.only(top: 20.0, bottom: 20.0),
                      width: 100.0,
                      child: TextField(
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Score',
                          labelStyle: TextStyle(fontSize: 14.0)
                        ),
                        controller: _controllerScore,
                        style: TextStyle(color: Colors.black),
                        onEditingComplete: () {
                          setState(() {
                            _list.add(_controller.text);
                            _listTigaScore.add(_controllerScore.text);
                            _controller.clear();
                            _controllerScore.clear();
                          });
                        },
                      ),
                    )
                  : Container(child: Text(''))
              ),
              Expanded(
                child: ListView(
                  shrinkWrap: true,
                  physics: ScrollPhysics(),
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(left: 10.0, right: 10.0, top: 10.0, bottom: 20.0),
                      child: Wrap(
                        spacing: 8.0,
                        runSpacing: 4.0,
                        runAlignment: WrapAlignment.start,
                        direction: Axis.horizontal,
                        children: _list.map((String name) => Chip(
                          label: Text(name),
                          onDeleted: () {
                            setState(() {
                              _list.remove(name);
                            });
                          },
                        )).toList(),
                      ),
                    ),
                  ],
                ),
              )
            ],
          )
          : _confirmDua == false ? Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Expanded(
                child: ListView.builder(
                  shrinkWrap: true,
                  physics: ScrollPhysics(),
                  itemCount: _list.length,
                  itemBuilder: (context, index) {
                    return Container(
                      padding: EdgeInsets.symmetric(horizontal: 10.0),
                      color: Colors.white,
                      child: ExpansionTile(
                        title: Text(
                          _list[index],
                          style: TextStyle(
                            fontSize: 14.0
                          ),
                        ),
                        children: <Widget>[
                          ListTile(
                            title: Container(
                              padding: const EdgeInsets.only(top: 5.0, bottom: 10.0),
                              width: _scoreShow ? MediaQuery.of(context).size.width - 100.0 : MediaQuery.of(context).size.width,
                              child: TextField(
                                textCapitalization: TextCapitalization.sentences,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelText: 'Type Here',
                                  labelStyle: TextStyle(fontSize: 14.0)
                                ),
                                controller: _controllerDetail,
                                style: TextStyle(color: Colors.black),
                                onEditingComplete: () {
                                  setState(() {
                                    _listDua.add(_controllerDetail.text);
                                    _controllerDetail.clear();
                                  });
                                },
                              ),
                            ),
                            trailing: _scoreShow
                              ? Container(
                                  padding: const EdgeInsets.only(top: 5.0, bottom: 10.0),
                                  width: 100.0,
                                  child: TextField(
                                    keyboardType: TextInputType.number,
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(),
                                      labelText: 'Score',
                                      labelStyle: TextStyle(fontSize: 14.0)
                                    ),
                                    controller: _controllerScore,
                                    style: TextStyle(color: Colors.black),
                                    onEditingComplete: () {
                                      setState(() {
                                        _listDua.add(_controllerDetail.text);
                                        _listTigaScore.add(_controllerScore.text);
                                        _controllerDetail.clear();
                                        _controllerScore.clear();
                                      });
                                    },
                                  ),
                                )
                              : Container(child: Text(''))
                          ),
                          Container(
                            alignment: Alignment.topLeft,
                            padding: EdgeInsets.only(left: 20.0, right: 20.0, bottom: 20.0),
                            child: Wrap(
                              spacing: 8.0,
                              runSpacing: 4.0,
                              runAlignment: WrapAlignment.start,
                              direction: Axis.horizontal,
                              children: _listDua.map((String nameDetail) => Chip(
                                label: Text(nameDetail),
                                onDeleted: () {
                                  setState(() {
                                    _listDua.remove(nameDetail);
                                  });
                                },
                              )).toList(),
                            ),
                          )
                        ],
                      ),
                    );
                  },
                ),
              )
            ],
          )
          : Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10.0),
                color: Colors.white,
                child: ExpansionTile(
                  title: Text(
                    'Makanan Pokok',
                    style: TextStyle(
                      fontSize: 14.0
                    ),
                  ),
                  children: <Widget>[
                    Container(
                      color: Colors.white,
                      child: ExpansionTile(
                        title: Text(
                          'Nasi',
                          style: TextStyle(
                            fontSize: 14.0
                          ),
                        ),
                        children: <Widget>[
                          ListTile(
                            title: Container(
                              padding: const EdgeInsets.only(top: 5.0, bottom: 10.0),
                              width: MediaQuery.of(context).size.width - 100.0,
                              child: TextField(
                                textCapitalization: TextCapitalization.sentences,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelText: 'Type Here',
                                  labelStyle: TextStyle(fontSize: 14.0)
                                ),
                                controller: _controllerDetailBanget,
                                style: TextStyle(color: Colors.black),
                                textInputAction: TextInputAction.next,
                              ),
                            ),
                            trailing: Container(
                              padding: const EdgeInsets.only(top: 5.0, bottom: 10.0),
                              width: 100.0,
                              child: TextField(
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelText: 'Score',
                                  labelStyle: TextStyle(fontSize: 14.0)
                                ),
                                controller: _controllerScore,
                                style: TextStyle(color: Colors.black),
                                onEditingComplete: () {
                                  setState(() {
                                    _listTiga.add(_controllerDetailBanget.text);
                                    _listTigaScore.add(_controllerScore.text);
                                    _controllerDetailBanget.clear();
                                    _controllerScore.clear();
                                  });
                                },
                              ),
                            ),
                          ),
                          Container(
                            alignment: Alignment.topLeft,
                            padding: EdgeInsets.only(left: 20.0, right: 20.0, bottom: 20.0),
                            child: Wrap(
                              spacing: 8.0,
                              runSpacing: 4.0,
                              runAlignment: WrapAlignment.start,
                              direction: Axis.horizontal,
                              children: _listTiga.map((String nameDetail) => Chip(
                                label: Text(nameDetail),
                                onDeleted: () {
                                  setState(() {
                                    _listTiga.remove(nameDetail);
                                  });
                                },
                              )).toList(),
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
              // Expanded(
              //   child: ListView.builder(
              //     shrinkWrap: true,
              //     physics: ScrollPhysics(),
              //     itemCount: _listDua.length,
              //     itemBuilder: (context, index) {
              //       return Container(
              //         padding: EdgeInsets.symmetric(horizontal: 10.0),
              //         color: Colors.white,
              //         child: ExpansionTile(
              //           title: Text(
              //             _listDua[index],
              //             style: TextStyle(
              //               fontSize: 14.0
              //             ),
              //           ),
              //           children: <Widget>[
              //             ListTile(
              //               title: Container(
              //                 padding: const EdgeInsets.only(top: 5.0, bottom: 10.0),
              //                 width: MediaQuery.of(context).size.width - 100.0,
              //                 child: TextField(
              //                   textCapitalization: TextCapitalization.sentences,
              //                   decoration: InputDecoration(
              //                     border: OutlineInputBorder(),
              //                     labelText: 'Type Here',
              //                     labelStyle: TextStyle(fontSize: 14.0)
              //                   ),
              //                   controller: _controllerDetailBanget,
              //                   style: TextStyle(color: Colors.black),
              //                   textInputAction: TextInputAction.next,
              //                 ),
              //               ),
              //               trailing: Container(
              //                 padding: const EdgeInsets.only(top: 5.0, bottom: 10.0),
              //                 width: 100.0,
              //                 child: TextField(
              //                   keyboardType: TextInputType.number,
              //                   decoration: InputDecoration(
              //                     border: OutlineInputBorder(),
              //                     labelText: 'Score',
              //                     labelStyle: TextStyle(fontSize: 14.0)
              //                   ),
              //                   controller: _controllerScore,
              //                   style: TextStyle(color: Colors.black),
              //                   onEditingComplete: () {
              //                     setState(() {
              //                       _listTiga.add(_controllerDetailBanget.text);
              //                       _listTigaScore.add(_controllerScore.text);
              //                       _controllerDetailBanget.clear();
              //                       _controllerScore.clear();
              //                     });
              //                   },
              //                 ),
              //               ),
              //             ),
              //             Container(
              //               alignment: Alignment.topLeft,
              //               padding: EdgeInsets.only(left: 20.0, right: 20.0, bottom: 20.0),
              //               child: Wrap(
              //                 spacing: 8.0,
              //                 runSpacing: 4.0,
              //                 runAlignment: WrapAlignment.start,
              //                 direction: Axis.horizontal,
              //                 children: _listTiga.map((String nameDetail) => Chip(
              //                   label: Text(nameDetail),
              //                   onDeleted: () {
              //                     setState(() {
              //                       _listTiga.remove(nameDetail);
              //                     });
              //                   },
              //                 )).toList(),
              //               ),
              //             )
              //           ],
              //         ),
              //       );
              //     },
              //   ),
              // )
            ],
          )
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
              _scoreShow
                ? Container()
                : ButtonTheme(
                    minWidth: 50.0,
                    height: 35.0,
                    child: RaisedButton(
                      color: Colors.green,
                      child: Text(
                        'Score',
                        style: TextStyle(
                          fontSize: 14.0,
                          color: Colors.white
                        ),
                      ),
                      onPressed: () {
                        setState(() {
                          _scoreShow = true;
                        });
                      },
                    ),
                  ),
              SizedBox(
                width: 15.0,
              ),
              _scoreShow
                ? ButtonTheme(
                    minWidth: 50.0,
                    height: 35.0,
                    child: RaisedButton(
                      color: Colors.green,
                      child: Text(
                        'SAVE',
                        style: TextStyle(
                          fontSize: 14.0,
                          color: Colors.white
                        ),
                      ),
                      onPressed: () {
                        setState(() {
                          _allList.add(_list);
                          _allList.add(_listDua);
                          _allList.add(_listTiga);
                          _allList.add(_listTigaScore);
                          print(_allList);
                          Navigator.pop(context, _allList);
                        });
                      },
                    ),
                  )
                : ButtonTheme(
                    minWidth: 50.0,
                    height: 35.0,
                    child: RaisedButton(
                      color: Colors.green,
                      child: Text(
                        _textButton,
                        style: TextStyle(
                          fontSize: 14.0,
                          color: Colors.white
                        ),
                      ),
                      onPressed: () {
                        setState(() {
                          if (_confirm == false && _confirmDua == false && _confirmTiga == false) {
                            _confirm = true;
                            _textButton = 'CONFIRM';
                          } else if (_confirm == true && _confirmDua == false && _confirmTiga == false) {
                            _confirmDua = true;
                            _textButton = 'SAVE';
                          } else if (_confirm == true && _confirmDua == true && _confirmTiga == false) {
                            _allList.add(_list);
                            _allList.add(_listDua);
                            _allList.add(_listTiga);
                            _allList.add(_listTigaScore);
                            print(_allList);
                            Navigator.pop(context, _allList);
                          }
                        });
                      },
                    ),
                  ),
            ],
          ),
        ),
        decoration: BoxDecoration(color: Color(0xFF2F592F))
      ),
    );
  }
  
  Widget _appBar(String titleJudul) {
    return AppBar(
      elevation: 0.25,
      backgroundColor: Colors.white,
      iconTheme: IconThemeData(color: Colors.black),
      title: Image.asset(
        'assets/images/logo2.png',
        height: 150.0,
        width: 120.0,
      ),
      leading: IconButton(
        icon: Icon(Icons.arrow_back),
        onPressed: () {
          Navigator.pop(context, _allList);
        },
      ),
      bottom: PreferredSize(
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
                          titleJudul,
                          style: TextStyle(color: Colors.white, fontSize: 16.0),
                          textAlign: TextAlign.start,
                        ),
                      ],
                    ),
                  ),
                  decoration: BoxDecoration(color: Color(0xFF2F592F))),
            ),
          ],
        ),
      ),
    );
  }
}

class FormFishbone extends StatefulWidget {
  final List<String> listMother;
  final List<String> listChild;
  final List<String> listGrandChild;

  FormFishbone({this.listMother, this.listChild, this.listGrandChild});

  @override
  _FormFishboneState createState() => _FormFishboneState();
}

class _FormFishboneState extends State<FormFishbone> with TickerProviderStateMixin {
  bool _noteWhat = false;
  TextEditingController _controllerNoteWhat = new TextEditingController();
  
  bool _noteWhen = false;
  TextEditingController _controllerNoteWhen = new TextEditingController();

  bool _noteWhere = false;
  TextEditingController _controllerNoteWhere = new TextEditingController();

  bool _noteWhy = false;
  TextEditingController _controllerNoteWhy = new TextEditingController();

  bool _noteHowServe = false;
  TextEditingController _controllerNoteHowServe = new TextEditingController();

  String _whatSelection;
  String _what;
  List<Map> _whatJson = [
    {"id": 1, "what": "Customer Complain"},
    {"id": 2, "what": "Alat Rusak"},
    {"id": 3, "what": "Disiplin Karyawan"},
  ];

  String _whoSelection;
  String _who;
  List<Map> _whoJson = [
    {"id": 1, "who": "Robert - Cashier"},
    {"id": 2, "who": "Susan - Cashier"},
    {"id": 3, "who": "Alberto - Cashier"},
  ];

  final dateFormat = DateFormat("MMMM d, yyyy");
  DateTime dateWhen;
  final timeFormat = DateFormat("h:mm a");
  TimeOfDay timeWhen;

  String _shiftSelection;
  String _shift;
  List<Map> _shiftJson = [
    {"id": 1, "shift": "Shift Pagi"},
    {"id": 2, "shift": "Shift Siang"},
  ];
  
  String _departmentSelection;
  String _department;
  List<Map> _departmentJson = [
    {"id": 1, "department": "HRD"},
    {"id": 2, "department": "Operation"},
    {"id": 3, "department": "Marketing"},
  ];

  String _divisiSelection;
  String _divisi;
  List<Map> _divisiJson = [
    {"id": 1, "divisi": "Divisi 1"},
    {"id": 2, "divisi": "Divisi 2"},
    {"id": 3, "divisi": "Divisi 3"},
  ];

  String _areaSelection;
  String _area;
  List<Map> _areaJson = [
    {"id": 1, "area": "Dapur"},
    {"id": 2, "area": "Cashier"},
    {"id": 3, "area": "Ruang VIP"},
  ];

  String _whySelection;
  String _why;
  List<Map> _whyJson = [
    {"id": 1, "why": "Loss Revenue"},
    {"id": 2, "why": "High Turnover"},
  ];

  Color _colorLowSe = Colors.grey;
  Color _colorMedSe = Colors.grey;
  Color _colorHighSe = Colors.grey;

  TabController _cardController;
  TabPageSelector _tabPageSelector;

  int _currentStep = 0;
  List<List<String>> _listGetMother = [];
  Color _yesColor = Colors.green[200];
  Color _noColor = Colors.grey[200];
  Color _yesfont = Colors.white;
  Color _nofont = Colors.black54;

  @override
  void initState() {
    super.initState();
    _cardController = new TabController(vsync: this, length: 8);
    _tabPageSelector = new TabPageSelector(controller: _cardController);
  }

  @override
  void dispose() {
    _cardController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    List<Step> steps = [
      Step(
        title: Text('Material'),
        isActive: true,
        state: StepState.indexed,
        content: Container(
          alignment: Alignment.centerLeft,
          child: ButtonTheme(
            minWidth: 50.0,
            height: 20.0,
            child: OutlineButton(
              child: Text(
                'Detail',
                style: TextStyle(fontSize: 13.0, color: AbubaPallate.menuBluebird),
              ),
              borderSide: BorderSide(color: AbubaPallate.menuBluebird, width: 1.0),
              highlightedBorderColor: AbubaPallate.menuBluebird,
              onPressed: () async {
                final List<List<String>> result = await Navigator.push(context,
                  MaterialPageRoute(
                    builder: (context) => FishBone(titleJudul: 'Material')
                  )
                );
                _listGetMother = result;
                print(result);
              },
            ),
          ),
        ),
      ),
      Step(
        title: Text('Method'),
        isActive: true,
        state: StepState.indexed,
        content: Container(
          alignment: Alignment.centerLeft,
          child: ButtonTheme(
            minWidth: 50.0,
            height: 20.0,
            child: OutlineButton(
              child: Text(
                'Detail',
                style: TextStyle(fontSize: 13.0, color: AbubaPallate.menuBluebird),
              ),
              borderSide: BorderSide(color: AbubaPallate.menuBluebird, width: 1.0),
              highlightedBorderColor: AbubaPallate.menuBluebird,
              onPressed: () async {
                final List<List<String>> result = await Navigator.push(context,
                  MaterialPageRoute(
                    builder: (context) => FishBone(titleJudul: 'Method')
                  )
                );
                _listGetMother = result;
                print(result);
              },
            ),
          ),
        ),
      ),
      Step(
        title: Text('Machine'),
        isActive: true,
        state: StepState.indexed,
        content: Container(
          alignment: Alignment.centerLeft,
          child: ButtonTheme(
            minWidth: 50.0,
            height: 20.0,
            child: OutlineButton(
              child: Text(
                'Detail',
                style: TextStyle(fontSize: 13.0, color: AbubaPallate.menuBluebird),
              ),
              borderSide: BorderSide(color: AbubaPallate.menuBluebird, width: 1.0),
              highlightedBorderColor: AbubaPallate.menuBluebird,
              onPressed: () async {
                final List<List<String>> result = await Navigator.push(context,
                  MaterialPageRoute(
                    builder: (context) => FishBone(titleJudul: 'Machine')
                  )
                );
                _listGetMother = result;
                print(result);
              },
            ),
          ),
        ),
      ),
      Step(
        title: Text('Measurement'),
        isActive: true,
        state: StepState.indexed,
        content: Container(
          alignment: Alignment.centerLeft,
          child: ButtonTheme(
            minWidth: 50.0,
            height: 20.0,
            child: OutlineButton(
              child: Text(
                'Detail',
                style: TextStyle(fontSize: 13.0, color: AbubaPallate.menuBluebird),
              ),
              borderSide: BorderSide(color: AbubaPallate.menuBluebird, width: 1.0),
              highlightedBorderColor: AbubaPallate.menuBluebird,
              onPressed: () async {
                final List<List<String>> result = await Navigator.push(context,
                  MaterialPageRoute(
                    builder: (context) => FishBone(titleJudul: 'Measurement')
                  )
                );
                _listGetMother = result;
                print(result);
              },
            ),
          ),
        ),
      ),
      Step(
        title: Text('Man'),
        isActive: true,
        state: StepState.indexed,
        content: Container(
          alignment: Alignment.centerLeft,
          child: ButtonTheme(
            minWidth: 50.0,
            height: 20.0,
            child: OutlineButton(
              child: Text(
                'Detail',
                style: TextStyle(fontSize: 13.0, color: AbubaPallate.menuBluebird),
              ),
              borderSide: BorderSide(color: AbubaPallate.menuBluebird, width: 1.0),
              highlightedBorderColor: AbubaPallate.menuBluebird,
              onPressed: () async {
                final List<List<String>> result = await Navigator.push(context,
                  MaterialPageRoute(
                    builder: (context) => FishBone(titleJudul: 'Man')
                  )
                );
                _listGetMother = result;
                print(result);
              },
            ),
          ),
        ),
      ),
      Step(
        title: Text('Environment'),
        isActive: true,
        state: StepState.indexed,
        content: Container(
          alignment: Alignment.centerLeft,
          child: ButtonTheme(
            minWidth: 50.0,
            height: 20.0,
            child: OutlineButton(
              child: Text(
                'Detail',
                style: TextStyle(fontSize: 13.0, color: AbubaPallate.menuBluebird),
              ),
              borderSide: BorderSide(color: AbubaPallate.menuBluebird, width: 1.0),
              highlightedBorderColor: AbubaPallate.menuBluebird,
              onPressed: () async {
                final List<List<String>> result = await Navigator.push(context,
                  MaterialPageRoute(
                    builder: (context) => FishBone(titleJudul: 'Environment')
                  )
                );
                _listGetMother = result;
                print(result);
              },
            ),
          ),
        ),
      ),
    ];

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
                                          'WHAT',
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
                                Column(
                                  children: <Widget>[
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: <Widget>[
                                        Flexible(
                                          child: Padding(
                                            padding: EdgeInsets.only(right: 10.0, left: 20.0, top: 20.0, bottom: 20.0),
                                            child: Text(
                                              'Apa masalah yang sedang terjadi ?',
                                              style: TextStyle(
                                                  color: Colors.black54,
                                                  fontSize: 24.0),
                                              textAlign: TextAlign.start,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(top: 30.0, bottom: 10.0, left: 20.0, right: 20.0),
                                      child: DropdownButtonFormField(
                                        value: _whatSelection,
                                        onChanged: (String newValue) {
                                          setState(() {
                                            switch (int.tryParse(newValue)) {
                                              case 1:
                                                _what = 'Customer Complaint';
                                                break;
                                              case 2:
                                                _what = 'Alat Rusak';
                                                break;
                                              case 3:
                                                _what = 'Disiplin Karyawan';
                                                break;
                                              default:
                                                _what = '-';
                                                break;
                                            }
                                            _whatSelection = newValue;
                                          });
                                        },
                                        decoration: InputDecoration(
                                          labelText: 'What',
                                          labelStyle: TextStyle(fontSize: 14.0),
                                        ),
                                        items: _whatJson.map((Map map) {
                                          return new DropdownMenuItem(
                                            value: map['id'].toString(),
                                            child: Text(map['what']),
                                          );
                                        }).toList(),
                                      ),
                                    ),
                                    Column(
                                      children: <Widget>[
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.end,
                                          children: <Widget>[
                                            Padding(
                                              padding: const EdgeInsets.only(right: 20.0),
                                              child: ButtonTheme(
                                                minWidth: 50.0,
                                                height: 35.0,
                                                child: RaisedButton(
                                                  color: AbubaPallate.menuBluebird,
                                                  child: Text(
                                                    'Note',
                                                    style: TextStyle(
                                                        fontSize: 14.0,
                                                        color: Colors.white),
                                                  ),
                                                  onPressed: () {
                                                    setState(() {
                                                      _noteWhat = !_noteWhat;
                                                    });
                                                  },
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        _noteWhat
                                          ? Container(
                                              padding: const EdgeInsets.only(top: 10.0, left: 20.0, right: 20.0),
                                              width: MediaQuery.of(context).size.width,
                                              child: TextField(
                                                decoration: InputDecoration(
                                                    border: OutlineInputBorder(),
                                                    hintText: 'Note',
                                                    hintStyle: TextStyle(fontSize: 12.0)),
                                                maxLines: 3,
                                                controller: _controllerNoteWhat,
                                                style: TextStyle(color: Colors.black),
                                              ),
                                            )
                                          : Container()
                                      ],
                                    )
                                  ],
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                      ListView(
                        shrinkWrap: true,
                        physics: ScrollPhysics(),
                        children: <Widget>[
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
                                          'WHO',
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
                                Column(
                                  children: <Widget>[
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: <Widget>[
                                        Flexible(
                                          child: Padding(
                                            padding: EdgeInsets.only(right: 10.0, left: 20.0, top: 20.0, bottom: 20.0),
                                            child: Text(
                                              'Siapa yang terlibat dengan masalah ini ?',
                                              style: TextStyle(
                                                  color: Colors.black54,
                                                  fontSize: 24.0),
                                              textAlign: TextAlign.start,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(top: 30.0, bottom: 10.0, left: 20.0, right: 20.0),
                                      child: DropdownButtonFormField(
                                        value: _whoSelection,
                                        onChanged: (String newValue) {
                                          setState(() {
                                            switch (int.tryParse(newValue)) {
                                              case 1:
                                                _who = 'Robert - Cashier';
                                                break;
                                              case 2:
                                                _who = 'Susan - Cashier';
                                                break;
                                              case 3:
                                                _who = 'Alberto - Cashier';
                                                break;
                                              default:
                                                _who = '-';
                                                break;
                                            }
                                            _whoSelection = newValue;
                                          });
                                        },
                                        decoration: InputDecoration(
                                          labelText: 'Who',
                                          labelStyle: TextStyle(fontSize: 14.0),
                                        ),
                                        items: _whoJson.map((Map map) {
                                          return new DropdownMenuItem(
                                            value: map['id'].toString(),
                                            child: Text(map['who']),
                                          );
                                        }).toList(),
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                      ListView(
                        shrinkWrap: true,
                        physics: ScrollPhysics(),
                        children: <Widget>[
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
                                          'WHEN',
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
                                Column(
                                  children: <Widget>[
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: <Widget>[
                                        Flexible(
                                          child: Padding(
                                            padding: EdgeInsets.only(right: 10.0, left: 20.0, top: 20.0, bottom: 20.0),
                                            child: Text(
                                              'Kapan masalah ini terjadi ?',
                                              style: TextStyle(
                                                  color: Colors.black54,
                                                  fontSize: 24.0),
                                              textAlign: TextAlign.start,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(top: 10.0, bottom: 10.0, left: 20.0, right: 20.0),
                                      child: DateTimePickerFormField(
                                        format: dateFormat,
                                        onChanged: (dt) => setState(() => dateWhen = dt),
                                        dateOnly: true,
                                        style: TextStyle(fontSize: 16.0, color: Colors.black),
                                        decoration: InputDecoration(
                                          border: UnderlineInputBorder(),
                                          labelStyle: TextStyle(fontSize: 14.0),
                                          labelText: 'Calendar'
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(top: 10.0, bottom: 10.0, left: 20.0, right: 20.0),
                                      child: TimePickerFormField(
                                        format: timeFormat,
                                        onChanged: (t) => setState(() => timeWhen = t),
                                        style: TextStyle(fontSize: 16.0, color: Colors.black),
                                        decoration: InputDecoration(
                                          border: UnderlineInputBorder(),
                                          labelText: 'Jam',
                                          labelStyle: TextStyle(fontSize: 14.0),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(top: 10.0, bottom: 10.0, left: 20.0, right: 20.0),
                                      child: DropdownButtonFormField(
                                        value: _shiftSelection,
                                        onChanged: (String newValue) {
                                          setState(() {
                                            switch (int.tryParse(newValue)) {
                                              case 1:
                                                _shift = 'Shift Page';
                                                break;
                                              case 2:
                                                _shift = 'Shift Siang';
                                                break;
                                              default:
                                                _shift = '-';
                                                break;
                                            }
                                            _shiftSelection = newValue;
                                          });
                                        },
                                        decoration: InputDecoration(
                                          labelText: 'Shift',
                                          labelStyle: TextStyle(fontSize: 14.0),
                                        ),
                                        items: _shiftJson.map((Map map) {
                                          return new DropdownMenuItem(
                                            value: map['id'].toString(),
                                            child: Text(map['shift']),
                                          );
                                        }).toList(),
                                      ),
                                    ),
                                    Column(
                                      children: <Widget>[
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.end,
                                          children: <Widget>[
                                            Padding(
                                              padding: const EdgeInsets.only(right: 20.0),
                                              child: ButtonTheme(
                                                minWidth: 50.0,
                                                height: 35.0,
                                                child: RaisedButton(
                                                  color: AbubaPallate.menuBluebird,
                                                  child: Text(
                                                    'Note',
                                                    style: TextStyle(
                                                        fontSize: 14.0,
                                                        color: Colors.white),
                                                  ),
                                                  onPressed: () {
                                                    setState(() {
                                                      _noteWhen = !_noteWhen;
                                                    });
                                                  },
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        _noteWhen
                                          ? Container(
                                              padding: const EdgeInsets.only(top: 10.0, left: 20.0, right: 20.0),
                                              width: MediaQuery.of(context).size.width,
                                              child: TextField(
                                                decoration: InputDecoration(
                                                    border: OutlineInputBorder(),
                                                    hintText: 'Note',
                                                    hintStyle: TextStyle(fontSize: 12.0)),
                                                maxLines: 3,
                                                controller: _controllerNoteWhen,
                                                style: TextStyle(color: Colors.black),
                                              ),
                                            )
                                          : Container()
                                      ],
                                    )
                                  ],
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                      ListView(
                        shrinkWrap: true,
                        physics: ScrollPhysics(),
                        children: <Widget>[
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
                                          'WHERE',
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
                                Column(
                                  children: <Widget>[
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: <Widget>[
                                        Flexible(
                                          child: Padding(
                                            padding: EdgeInsets.only(right: 10.0, left: 20.0, top: 20.0, bottom: 20.0),
                                            child: Text(
                                              'Dimana lokasi masalah ditemukan ?',
                                              style: TextStyle(
                                                  color: Colors.black54,
                                                  fontSize: 24.0),
                                              textAlign: TextAlign.start,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(top: 10.0, bottom: 10.0, left: 20.0, right: 20.0),
                                      child: DropdownButtonFormField(
                                        value: _departmentSelection,
                                        onChanged: (String newValue) {
                                          setState(() {
                                            switch (int.tryParse(newValue)) {
                                              case 1:
                                                _department = 'HRD';
                                                break;
                                              case 2:
                                                _department = 'Operation';
                                                break;
                                              case 3:
                                                _department = 'Marketing';
                                                break;
                                              default:
                                                _department = '-';
                                                break;
                                            }
                                            _departmentSelection = newValue;
                                          });
                                        },
                                        decoration: InputDecoration(
                                          labelText: 'Department',
                                          labelStyle: TextStyle(fontSize: 14.0),
                                        ),
                                        items: _departmentJson.map((Map map) {
                                          return new DropdownMenuItem(
                                            value: map['id'].toString(),
                                            child: Text(map['department']),
                                          );
                                        }).toList(),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(top: 10.0, bottom: 10.0, left: 20.0, right: 20.0),
                                      child: DropdownButtonFormField(
                                        value: _divisiSelection,
                                        onChanged: (String newValue) {
                                          setState(() {
                                            switch (int.tryParse(newValue)) {
                                              case 1:
                                                _divisi = 'Divisi 1';
                                                break;
                                              case 2:
                                                _divisi = 'Divisi 2';
                                                break;
                                              case 3:
                                                _divisi = 'Divisi 3';
                                                break;
                                              default:
                                                _divisi = '-';
                                                break;
                                            }
                                            _divisiSelection = newValue;
                                          });
                                        },
                                        decoration: InputDecoration(
                                          labelText: 'Divisi',
                                          labelStyle: TextStyle(fontSize: 14.0),
                                        ),
                                        items: _divisiJson.map((Map map) {
                                          return new DropdownMenuItem(
                                            value: map['id'].toString(),
                                            child: Text(map['divisi']),
                                          );
                                        }).toList(),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(top: 10.0, bottom: 10.0, left: 20.0, right: 20.0),
                                      child: DropdownButtonFormField(
                                        value: _areaSelection,
                                        onChanged: (String newValue) {
                                          setState(() {
                                            switch (int.tryParse(newValue)) {
                                              case 1:
                                                _area = 'Dapur';
                                                break;
                                              case 2:
                                                _area = 'Cashier';
                                                break;
                                              case 3:
                                                _area = 'Ruang VIP';
                                                break;
                                              default:
                                                _area = '-';
                                                break;
                                            }
                                            _areaSelection = newValue;
                                          });
                                        },
                                        decoration: InputDecoration(
                                          labelText: 'Area',
                                          labelStyle: TextStyle(fontSize: 14.0),
                                        ),
                                        items: _areaJson.map((Map map) {
                                          return new DropdownMenuItem(
                                            value: map['id'].toString(),
                                            child: Text(map['area']),
                                          );
                                        }).toList(),
                                      ),
                                    ),
                                    Column(
                                      children: <Widget>[
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.end,
                                          children: <Widget>[
                                            Padding(
                                              padding: const EdgeInsets.only(right: 20.0),
                                              child: ButtonTheme(
                                                minWidth: 50.0,
                                                height: 35.0,
                                                child: RaisedButton(
                                                  color: AbubaPallate.menuBluebird,
                                                  child: Text(
                                                    'Note',
                                                    style: TextStyle(
                                                        fontSize: 14.0,
                                                        color: Colors.white),
                                                  ),
                                                  onPressed: () {
                                                    setState(() {
                                                      _noteWhere = !_noteWhere;
                                                    });
                                                  },
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        _noteWhere
                                          ? Container(
                                              padding: const EdgeInsets.only(top: 10.0, left: 20.0, right: 20.0),
                                              width: MediaQuery.of(context).size.width,
                                              child: TextField(
                                                decoration: InputDecoration(
                                                    border: OutlineInputBorder(),
                                                    hintText: 'Note',
                                                    hintStyle: TextStyle(fontSize: 12.0)),
                                                maxLines: 3,
                                                controller: _controllerNoteWhere,
                                                style: TextStyle(color: Colors.black),
                                              ),
                                            )
                                          : Container()
                                      ],
                                    )
                                  ],
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                      ListView(
                        shrinkWrap: true,
                        physics: ScrollPhysics(),
                        children: <Widget>[
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
                                          'WHY',
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
                                Column(
                                  children: <Widget>[
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: <Widget>[
                                        Flexible(
                                          child: Padding(
                                            padding: EdgeInsets.only(right: 10.0, left: 20.0, top: 20.0, bottom: 20.0),
                                            child: Text(
                                              'Mengapa temuan / issue ini bisa menjadi masalah ? Apa konsekuensi dari masalah ini ?',
                                              style: TextStyle(
                                                  color: Colors.black54,
                                                  fontSize: 24.0),
                                              textAlign: TextAlign.start,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(top: 30.0, bottom: 10.0, left: 20.0, right: 20.0),
                                      child: DropdownButtonFormField(
                                        value: _whySelection,
                                        onChanged: (String newValue) {
                                          setState(() {
                                            switch (int.tryParse(newValue)) {
                                              case 1:
                                                _why = 'Loss Revenue';
                                                break;
                                              case 2:
                                                _why = 'High Turnover';
                                                break;
                                              default:
                                                _why = '-';
                                                break;
                                            }
                                            _whySelection = newValue;
                                          });
                                        },
                                        decoration: InputDecoration(
                                          labelText: 'Why',
                                          labelStyle: TextStyle(fontSize: 14.0),
                                        ),
                                        items: _whyJson.map((Map map) {
                                          return new DropdownMenuItem(
                                            value: map['id'].toString(),
                                            child: Text(map['why']),
                                          );
                                        }).toList(),
                                      ),
                                    ),
                                    Column(
                                      children: <Widget>[
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.end,
                                          children: <Widget>[
                                            Padding(
                                              padding: const EdgeInsets.only(right: 20.0),
                                              child: ButtonTheme(
                                                minWidth: 50.0,
                                                height: 35.0,
                                                child: RaisedButton(
                                                  color: AbubaPallate.menuBluebird,
                                                  child: Text(
                                                    'Note',
                                                    style: TextStyle(
                                                        fontSize: 14.0,
                                                        color: Colors.white),
                                                  ),
                                                  onPressed: () {
                                                    setState(() {
                                                      _noteWhy = !_noteWhy;
                                                    });
                                                  },
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        _noteWhy
                                          ? Container(
                                              padding: const EdgeInsets.only(top: 10.0, left: 20.0, right: 20.0),
                                              width: MediaQuery.of(context).size.width,
                                              child: TextField(
                                                decoration: InputDecoration(
                                                    border: OutlineInputBorder(),
                                                    hintText: 'Note',
                                                    hintStyle: TextStyle(fontSize: 12.0)),
                                                maxLines: 3,
                                                controller: _controllerNoteWhy,
                                                style: TextStyle(color: Colors.black),
                                              ),
                                            )
                                          : Container()
                                      ],
                                    )
                                  ],
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                      ListView(
                        shrinkWrap: true,
                        physics: ScrollPhysics(),
                        children: <Widget>[
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
                                          'HOW SEVERE',
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
                                Column(
                                  children: <Widget>[
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: <Widget>[
                                        Flexible(
                                          child: Padding(
                                            padding: EdgeInsets.only(right: 10.0, left: 20.0, top: 20.0, bottom: 20.0),
                                            child: Text(
                                              'Seberapa parah akibat yang ditimbulkan dari masalah ini ?',
                                              style: TextStyle(
                                                  color: Colors.black54,
                                                  fontSize: 24.0),
                                              textAlign: TextAlign.start,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(top: 30.0, left: 20.0, right: 20.0, bottom: 10.0),
                                      child: Column(
                                        children: <Widget>[
                                          Container(
                                            padding:
                                            EdgeInsets.only(top: 5.0),
                                            child: Row(
                                              mainAxisAlignment:
                                              MainAxisAlignment
                                                  .spaceAround,
                                              children: <Widget>[
                                                ButtonTheme(
                                                  height: 30.0,
                                                  child: OutlineButton(
                                                    child: Text(
                                                      'Low',
                                                      style: TextStyle(
                                                          color: _colorLowSe),
                                                    ),
                                                    borderSide: BorderSide(
                                                        color: _colorLowSe,
                                                        width: 1.0),
                                                    highlightedBorderColor:
                                                    _colorLowSe,
                                                    onPressed: () {
                                                      setState(() {
                                                        _colorLowSe =
                                                        Colors.green[400];
                                                        _colorMedSe =
                                                            Colors.grey;
                                                        _colorHighSe =
                                                            Colors.grey;
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
                                                          color: _colorMedSe),
                                                    ),
                                                    borderSide: BorderSide(
                                                        color: _colorMedSe,
                                                        width: 1.0),
                                                    highlightedBorderColor:
                                                    _colorMedSe,
                                                    onPressed: () {
                                                      setState(() {
                                                        _colorLowSe =
                                                            Colors.grey;
                                                        _colorMedSe = Colors
                                                            .orangeAccent;
                                                        _colorHighSe =
                                                            Colors.grey;
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
                                                          color:
                                                          _colorHighSe),
                                                    ),
                                                    borderSide: BorderSide(
                                                        color: _colorHighSe,
                                                        width: 1.0),
                                                    highlightedBorderColor:
                                                    _colorHighSe,
                                                    onPressed: () {
                                                      setState(() {
                                                        _colorLowSe =
                                                            Colors.grey;
                                                        _colorMedSe =
                                                            Colors.grey;
                                                        _colorHighSe =
                                                            Colors.redAccent;
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
                                    Column(
                                      children: <Widget>[
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.end,
                                          children: <Widget>[
                                            Padding(
                                              padding: const EdgeInsets.only(right: 20.0),
                                              child: ButtonTheme(
                                                minWidth: 50.0,
                                                height: 35.0,
                                                child: RaisedButton(
                                                  color: AbubaPallate.menuBluebird,
                                                  child: Text(
                                                    'Note',
                                                    style: TextStyle(
                                                        fontSize: 14.0,
                                                        color: Colors.white),
                                                  ),
                                                  onPressed: () {
                                                    setState(() {
                                                      _noteHowServe = !_noteHowServe;
                                                    });
                                                  },
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        _noteHowServe
                                          ? Container(
                                              padding: const EdgeInsets.only(top: 10.0, left: 20.0, right: 20.0),
                                              width: MediaQuery.of(context).size.width,
                                              child: TextField(
                                                decoration: InputDecoration(
                                                    border: OutlineInputBorder(),
                                                    hintText: 'Note',
                                                    hintStyle: TextStyle(fontSize: 12.0)),
                                                maxLines: 3,
                                                controller: _controllerNoteHowServe,
                                                style: TextStyle(color: Colors.black),
                                              ),
                                            )
                                          : Container()
                                      ],
                                    )
                                  ],
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                      ListView(
                        shrinkWrap: true,
                        physics: ScrollPhysics(),
                        children: <Widget>[
                          Container(
                            color: Colors.white,
                            alignment: Alignment.center,
                            child: Column(
                              children: <Widget>[
                                Stepper(
                                  steps: steps,
                                  type: StepperType.vertical,
                                  currentStep: this._currentStep,
                                  controlsBuilder: (BuildContext context, {VoidCallback onStepContinue, VoidCallback onStepCancel}) {
                                    return Container();
                                  },
                                  // onStepContinue: () {
                                  //   setState(() {
                                  //     if (_currentStep < steps.length - 1) {
                                  //       _currentStep = _currentStep + 1;
                                  //     } else {
                                  //       _currentStep = 0;
                                  //     }
                                  //   });
                                  // },
                                  // onStepCancel: () {
                                  //   setState(() {
                                  //     if (_currentStep > 0) {
                                  //       _currentStep = _currentStep - 1;
                                  //     } else {
                                  //       _currentStep = 0;
                                  //     }
                                  //   });
                                  // },
                                  onStepTapped: (step) {
                                    setState(() {
                                      _currentStep = step;
                                    });
                                  },
                                ),
                              ],
                            )
                          ),
                        ],
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(vertical: 15.0),
                        color: Colors.white,
                        alignment: Alignment.center,
                        child: Column(
                          children: <Widget>[
                            // _listGetMother.isEmpty
                            //   ? ListTile(
                            //       leading: Text(
                            //         'Hypothesis',
                            //         style: TextStyle(
                            //           color: Color(0xFF2F592F),
                            //           fontSize: 16.0,
                            //           fontWeight: FontWeight.bold
                            //         ),
                            //         textAlign: TextAlign.center,
                            //       ),
                            //       title: Text(
                            //         'Score',
                            //         style: TextStyle(
                            //           color: Color(0xFF2F592F),
                            //           fontSize: 16.0,
                            //           fontWeight: FontWeight.bold
                            //         ),
                            //         textAlign: TextAlign.center,
                            //       ),
                            //       trailing: Text(
                            //         'Analysis',
                            //         style: TextStyle(
                            //           color: Color(0xFF2F592F),
                            //           fontSize: 16.0,
                            //           fontWeight: FontWeight.bold
                            //         ),
                            //         textAlign: TextAlign.center,
                            //       ),
                            //     )
                            //   : Flexible(
                            //       child: ListView.builder(
                            //         itemCount: _listGetMother[2].length + 1,
                            //         itemBuilder: (context, index) {
                            //           return Column(
                            //             mainAxisSize: MainAxisSize.min,
                            //             children: <Widget>[
                            //               index == 0
                            //                 ? ListTile(
                            //                     leading: Container(
                            //                       width: MediaQuery.of(context).size.width / 3,
                            //                       child: Text(
                            //                         'Hypothesis',
                            //                         style: TextStyle(
                            //                           color: Color(0xFF2F592F),
                            //                           fontSize: 16.0,
                            //                           fontWeight: FontWeight.bold
                            //                         ),
                            //                         textAlign: TextAlign.start,
                            //                       ),
                            //                     ),
                            //                     title: Container(
                            //                       width: MediaQuery.of(context).size.width / 3,
                            //                       child: Text(
                            //                         'Score',
                            //                         style: TextStyle(
                            //                           color: Color(0xFF2F592F),
                            //                           fontSize: 16.0,
                            //                           fontWeight: FontWeight.bold
                            //                         ),
                            //                         textAlign: TextAlign.center,
                            //                       ),
                            //                     ),
                            //                     trailing: Container(
                            //                       width: MediaQuery.of(context).size.width / 3,
                            //                       child: Text(
                            //                         'Analysis',
                            //                         style: TextStyle(
                            //                           color: Color(0xFF2F592F),
                            //                           fontSize: 16.0,
                            //                           fontWeight: FontWeight.bold
                            //                         ),
                            //                         textAlign: TextAlign.end,
                            //                       ),
                            //                     ),
                            //                   )
                            //                 : ListTile(
                            //                     leading: Container(
                            //                       width: MediaQuery.of(context).size.width / 3,
                            //                       child: Column(
                            //                         mainAxisAlignment: MainAxisAlignment.start,
                            //                         children: <Widget>[
                            //                           Row(
                            //                             children: <Widget>[
                            //                               Flexible(
                            //                                 child: Text(
                            //                                   _listGetMother[2][index - 1],
                            //                                   style: TextStyle(
                            //                                     color: Color(0xFF2F592F),
                            //                                     fontSize: 14.0,
                            //                                   ),
                            //                                   textAlign: TextAlign.start,
                            //                                 ),
                            //                               )
                            //                             ],
                            //                           ),
                            //                           GestureDetector(
                            //                             onTap: () {},
                            //                             child: Row(
                            //                               children: <Widget>[
                            //                                 Flexible(
                            //                                   child: Text(
                            //                                     'Detail',
                            //                                     style: TextStyle(
                            //                                       color: AbubaPallate.menuBluebird,
                            //                                       fontSize: 12.0,
                            //                                     ),
                            //                                     textAlign: TextAlign.start,
                            //                                   ),
                            //                                 )
                            //                               ],
                            //                             ),
                            //                           ),
                            //                         ],
                            //                       )
                            //                     ),
                            //                     title: Container(
                            //                       width: MediaQuery.of(context).size.width / 3,
                            //                       child: Text(
                            //                         _listGetMother[3][index - 1],
                            //                         style: TextStyle(
                            //                           color: Color(0xFF2F592F),
                            //                           fontSize: 14.0,
                            //                         ),
                            //                         textAlign: TextAlign.center,
                            //                       ),
                            //                     ),
                            //                     trailing: Container(
                            //                       width: MediaQuery.of(context).size.width / 3,
                            //                       child: int.parse(_listGetMother[3][index - 1]) >= 8
                            //                         ? Row(
                            //                             mainAxisAlignment: MainAxisAlignment.end,
                            //                             children: <Widget>[
                            //                               ButtonTheme(
                            //                                 minWidth: 30.0,
                            //                                 height: 25.0,
                            //                                 child: RaisedButton(
                            //                                   color: _yesColor,
                            //                                   child: Text(
                            //                                     'YES',
                            //                                     style: TextStyle(
                            //                                       fontSize: 14.0,
                            //                                       color: _yesfont
                            //                                     ),
                            //                                   ),
                            //                                   onPressed: () {
                            //                                     setState(() {
                            //                                       _yesColor = Colors.green[200];
                            //                                       _yesfont = Colors.white;
                            //                                       _noColor = Colors.grey[200];
                            //                                       _nofont = Colors.black54;
                            //                                     });
                            //                                   },
                            //                                 ),
                            //                               ),
                            //                               ButtonTheme(
                            //                                 minWidth: 30.0,
                            //                                 height: 25.0,
                            //                                 child: RaisedButton(
                            //                                   color: _noColor,
                            //                                   child: Text(
                            //                                     'NO',
                            //                                     style: TextStyle(
                            //                                       fontSize: 14.0,
                            //                                       color: _nofont
                            //                                     ),
                            //                                   ),
                            //                                   onPressed: () {
                            //                                     setState(() {
                            //                                       _yesColor = Colors.grey[200];
                            //                                       _yesfont = Colors.black54;
                            //                                       _noColor = Colors.redAccent;
                            //                                       _nofont = Colors.white;
                            //                                     });
                            //                                   },
                            //                                 ),
                            //                               )
                            //                             ],
                            //                           )
                            //                         : Container(child: Text(''))
                            //                     ),
                            //                   ),
                            //             ],
                            //           );
                            //         },
                            //       ),
                            //     )
                            ListTile(
                              leading: Text(
                                'Hypothesis',
                                style: TextStyle(
                                  color: Color(0xFF2F592F),
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.bold
                                ),
                                textAlign: TextAlign.center,
                              ),
                              title: Text(
                                'Score',
                                style: TextStyle(
                                  color: Color(0xFF2F592F),
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.bold
                                ),
                                textAlign: TextAlign.center,
                              ),
                              trailing: Text(
                                'Analysis',
                                style: TextStyle(
                                  color: Color(0xFF2F592F),
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.bold
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                            ListTile(
                              leading: Container(
                                width: MediaQuery.of(context).size.width / 3,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: <Widget>[
                                    Row(
                                      children: <Widget>[
                                        Flexible(
                                          child: Text(
                                            'Nasi Merah',
                                            style: TextStyle(
                                              color: Color(0xFF2F592F),
                                              fontSize: 14.0,
                                            ),
                                            textAlign: TextAlign.start,
                                          ),
                                        )
                                      ],
                                    ),
                                    GestureDetector(
                                      onTap: () {},
                                      child: Row(
                                        children: <Widget>[
                                          Flexible(
                                            child: Text(
                                              'Detail',
                                              style: TextStyle(
                                                color: AbubaPallate.menuBluebird,
                                                fontSize: 12.0,
                                              ),
                                              textAlign: TextAlign.start,
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ],
                                )
                              ),
                              title: Container(
                                width: MediaQuery.of(context).size.width / 3,
                                child: Text(
                                  '3',
                                  style: TextStyle(
                                    color: Color(0xFF2F592F),
                                    fontSize: 14.0,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              trailing: Container(
                                width: MediaQuery.of(context).size.width / 3,
                                child: Container(child: Text(''))
                              ),
                            ),
                            ListTile(
                              leading: Container(
                                width: MediaQuery.of(context).size.width / 3,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: <Widget>[
                                    Row(
                                      children: <Widget>[
                                        Flexible(
                                          child: Text(
                                            'Nasi Jagung',
                                            style: TextStyle(
                                              color: Color(0xFF2F592F),
                                              fontSize: 14.0,
                                            ),
                                            textAlign: TextAlign.start,
                                          ),
                                        )
                                      ],
                                    ),
                                    GestureDetector(
                                      onTap: () {},
                                      child: Row(
                                        children: <Widget>[
                                          Flexible(
                                            child: Text(
                                              'Detail',
                                              style: TextStyle(
                                                color: AbubaPallate.menuBluebird,
                                                fontSize: 12.0,
                                              ),
                                              textAlign: TextAlign.start,
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ],
                                )
                              ),
                              title: Container(
                                width: MediaQuery.of(context).size.width / 3,
                                child: Text(
                                  '10',
                                  style: TextStyle(
                                    color: Color(0xFF2F592F),
                                    fontSize: 14.0,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              trailing: Container(
                                width: MediaQuery.of(context).size.width / 3,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: <Widget>[
                                    ButtonTheme(
                                      minWidth: 30.0,
                                      height: 25.0,
                                      child: RaisedButton(
                                        color: _yesColor,
                                        child: Text(
                                          'YES',
                                          style: TextStyle(
                                            fontSize: 14.0,
                                            color: _yesfont
                                          ),
                                        ),
                                        onPressed: () {
                                          setState(() {
                                            _yesColor = Colors.green[200];
                                            _yesfont = Colors.white;
                                            _noColor = Colors.grey[200];
                                            _nofont = Colors.black54;
                                          });
                                        },
                                      ),
                                    ),
                                    ButtonTheme(
                                      minWidth: 30.0,
                                      height: 25.0,
                                      child: RaisedButton(
                                        color: _noColor,
                                        child: Text(
                                          'NO',
                                          style: TextStyle(
                                            fontSize: 14.0,
                                            color: _nofont
                                          ),
                                        ),
                                        onPressed: () {
                                          setState(() {
                                            _yesColor = Colors.grey[200];
                                            _yesfont = Colors.black54;
                                            _noColor = Colors.redAccent;
                                            _nofont = Colors.white;
                                          });
                                        },
                                      ),
                                    )
                                  ],
                                )
                              ),
                            ),
                          ],
                        ),
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
          decoration: BoxDecoration(color: Color(0xFF2F592F))),
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
      bottom: PreferredSize(
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
                          '1. Identity Problem',
                          style: TextStyle(color: Colors.white, fontSize: 12.0),
                          textAlign: TextAlign.start,
                        ),
                        // Text(
                        //   '${_cardController.index.toString()} of 8',
                        //   style: TextStyle(
                        //       color: Colors.white, fontSize: 12.0),
                        //   textAlign: TextAlign.start,
                        // ),
                      ],
                    ),
                  ),
                  decoration: BoxDecoration(color: Color(0xFF2F592F))),
            ),
          ],
        ),
      ),
    );
  }
}