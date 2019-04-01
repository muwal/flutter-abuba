import 'package:flutter/material.dart';
import 'package:flutter_abuba/constant.dart';

class FormVoice extends StatefulWidget {
  @override
  _FormVoiceState createState() => _FormVoiceState();
}

class _FormVoiceState extends State<FormVoice> with TickerProviderStateMixin {
  List<Map> _listData = [
    {'nomor': '1', 'title': '1. Customer Identity', 'title_dalam': 'Who is the customer ?', 'select': 'true'},
    {'nomor': '2', 'title': '2. Voice Of The Customer', 'title_dalam': 'What did the customer say ?', 'select': 'false'},
    {'nomor': '3', 'title': '3. Key Customer Issues', 'title_dalam': 'What does the customer need ?', 'select': 'false'},
    {'nomor': '4', 'title': '4. Critical Customer Requirement', 'title_dalam': 'What resulting action is required ?', 'select': 'false'},
  ];

  String _whoSelection;
  String _who;
  List<Map> _whoJson = [
    {"id": 1, "who": "Robert - Cashier"},
    {"id": 2, "who": "Susan - Cashier"},
    {"id": 3, "who": "Alberto - Cashier"},
  ];
  List<String> _whoSelected = [];

  TabController _cardController;
  TextEditingController _controllerText = new TextEditingController();

  @override
  void initState() {
    super.initState();
    _cardController = new TabController(vsync: this, length: 8);
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
                    children: _listData.isEmpty
                      ? <Widget>[]
                      : _listData.map((Map map) {
                        return ListView(
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
                                              map['title'],
                                              style: TextStyle(color: Colors.white, fontSize: 12.0),
                                              textAlign: TextAlign.start,
                                            ),
                                            Text(
                                              '${map['nomor']} of ${_listData.length.toString()}',
                                              style: TextStyle(
                                                  color: Colors.white, fontSize: 12.0),
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
                                            map['title_dalam'].toString(),
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
                                      map['select'] == 'true'
                                        ? ListTile(
                                            title: Padding(
                                              padding: EdgeInsets.only(
                                                  top: 10.0, bottom: 10.0),
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
                                            trailing: IconButton(
                                              icon: Icon(Icons.add, color: AbubaPallate.greenabuba),
                                              onPressed: () {
                                                setState(() {
                                                  _whoSelected.add(_who);
                                                });
                                              },
                                            ),
                                          )
                                        : Container(
                                            padding: const EdgeInsets.only(top: 20.0, left: 20.0, right: 20.0),
                                            width: MediaQuery.of(context).size.width,
                                            child: TextField(
                                              decoration: InputDecoration(
                                                  border: OutlineInputBorder(),
                                                  hintText: 'Type Here',
                                                  hintStyle: TextStyle(fontSize: 12.0)),
                                              maxLines: 3,
                                              controller: _controllerText,
                                              style: TextStyle(color: Colors.black),
                                            ),
                                          ),
                                        map['select'] == 'true'
                                          ? Column(
                                              children: <Widget>[
                                                Padding(
                                                  padding: EdgeInsets.only(top: 10.0),
                                                  child: Wrap(
                                                    spacing: 4.0,
                                                    runSpacing: 2.0,
                                                    runAlignment: WrapAlignment.start,
                                                    direction: Axis.horizontal,
                                                    children: _whoSelected.map((String name) => Chip(
                                                      label: Text(name),
                                                      onDeleted: () {
                                                        setState(() {
                                                          _whoSelected.remove(name);
                                                        });
                                                      },
                                                    )).toList(),
                                                  ),
                                                ),
                                              ],
                                            )
                                          : Container(),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ],
                        );
                      }).toList()
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