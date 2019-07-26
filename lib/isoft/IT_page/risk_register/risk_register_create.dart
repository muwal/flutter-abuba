import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class RiskRegisterCreate extends StatefulWidget {
  RiskRegisterCreate({Key key}) : super(key: key);

  _RiskRegisterCreateState createState() => _RiskRegisterCreateState();
}

class _RiskRegisterCreateState extends State<RiskRegisterCreate>
    with TickerProviderStateMixin {
  String _selectionSumber;
  String _sumber;
  List<Map> _sumberJSON = [
    {"id": 1, "sumber": "Human Error"},
    {"id": 2, "sumber": "System Error"},
  ];

  String _selectionPIC;
  String _pic;
  List<Map> _picJSON = [
    {"id": 1, "pic": "Ironman"},
    {"id": 2, "pic": "Spiderman"},
  ];

  String _selectionVerifikator;
  String _verifikator;
  List<Map> _verifikatorJSON = [
    {"id": 1, "verifikator": "Hulk"},
    {"id": 2, "verifikator": "Thor"},
  ];

  Color _colorLowSe = Colors.grey;
  Color _colorMedSe = Colors.grey;
  Color _colorHighSe = Colors.grey;

  Color _colorLowLi = Colors.grey;
  Color _colorMedLi = Colors.grey;
  Color _colorHighLi = Colors.grey;

  String _risk = ' ';
  Color _colorRisk = Colors.grey;

  List<Map> myList = [
    {"nomor": 1},
    {"nomor": 2},
    {"nomor": 3},
    {"nomor": 4},
    {"nomor": 5},
  ];

  String severity = '';
  String likelihood = '';
  int bantuSeverity = 0;
  int bantuLikelihood = 0;

  TabController _cardController;
  TabPageSelector _tabPageSelector;

  @override
  void initState() {
    super.initState();
    _cardController = new TabController(vsync: this, length: myList.length);
    _tabPageSelector = new TabPageSelector(controller: _cardController);
  }

  @override
  void dispose() {
    _cardController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;

    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
          elevation: 0.25,
          backgroundColor: Colors.white,
          iconTheme: IconThemeData(color: Colors.black),
          title: Image.asset(
            'assets/images/logo2.png',
            height: 150.0,
            width: 120.0,
          ),
        ),
          body: Center(
            child: Column(
              children: <Widget>[
                myList.isEmpty
                    ? new Container(
                        height: 30.0,
                      )
                    : new Container(
                        height: 30.0,
                        child: _tabPageSelector,
                        alignment: Alignment.center,
                      ),
                Expanded(
                  child: TabBarView(
                      controller: _cardController,
                      children: myList.isEmpty
                          ? <Widget>[]
                          : myList.map((Map map) {
                              return _buildFormRisk(width);
                            }).toList()),
                )
              ],
            ),
          )),
    );
  }

  Widget _buildFormRisk(double width) {
    return Scrollbar(
      child: ListView(
        padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 0.0),
            child: TextFormField(
              textCapitalization: TextCapitalization.words,
              decoration: InputDecoration(
                border: UnderlineInputBorder(),
                labelText: 'Jenis',
                labelStyle: TextStyle(fontSize: 14.0),
              ),
              style: TextStyle(
                  fontStyle: FontStyle.normal,
                  color: Colors.black87,
                  fontSize: 14.0),
              onSaved: null,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10.0),
            child: DropdownButtonFormField<String>(
              decoration: InputDecoration(
                labelText: 'Sumber',
                labelStyle: TextStyle(fontSize: 14.0),
              ),
              value: _selectionSumber,
              onChanged: (String value) {
                setState(() {
                  switch (int.tryParse(value)) {
                    case 1:
                      _sumber = 'Human Error';
                      break;
                    case 2:
                      _sumber = 'System Error';
                      break;
                    default:
                      _sumber = '-';
                      break;
                  }
                  _selectionSumber = value;
                });
              },
              items: _sumberJSON.map((Map map) {
                return DropdownMenuItem(
                  value: map['id'].toString(),
                  child: Text(map['sumber']),
                );
              }).toList(),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10.0),
            child: TextFormField(
              textCapitalization: TextCapitalization.words,
              decoration: InputDecoration(
                border: UnderlineInputBorder(),
                labelText: 'Dampak',
                labelStyle: TextStyle(fontSize: 14.0),
              ),
              style: TextStyle(
                  fontStyle: FontStyle.normal,
                  color: Colors.black87,
                  fontSize: 14.0),
              onSaved: null,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 30.0),
            child: Column(
              children: <Widget>[
                Container(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Severity',
                    style: TextStyle(color: Colors.black54),
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
                            style: TextStyle(color: _colorLowSe),
                          ),
                          borderSide:
                              BorderSide(color: _colorLowSe, width: 1.0),
                          highlightedBorderColor: _colorLowSe,
                          onPressed: () {
                            setState(() {
                              severity = 'Low';
                              bantuSeverity = 1;
                              _colorLowSe = Colors.green[400];
                              _colorMedSe = Colors.grey;
                              _colorHighSe = Colors.grey;

                              if (bantuSeverity != 0 && bantuLikelihood != 0) {
                                  if (bantuSeverity > bantuLikelihood) {
                                    if (bantuSeverity == 1) {
                                      _risk = 'Low';
                                      _colorRisk = Colors.green[400];
                                    } else if (bantuSeverity == 2) {
                                      _risk = 'Medium';
                                      _colorRisk = Colors.orangeAccent;
                                    } else if (bantuSeverity == 3) {
                                      _risk = 'High';
                                      _colorRisk = Colors.redAccent;
                                    }
                                  } else if (bantuSeverity < bantuLikelihood) {
                                    if (bantuLikelihood == 1) {
                                      _risk = 'Low';
                                      _colorRisk = Colors.green[400];
                                    } else if (bantuLikelihood == 2) {
                                      _risk = 'Medium';
                                      _colorRisk = Colors.orangeAccent;
                                    } else if (bantuLikelihood == 3) {
                                      _risk = 'High';
                                      _colorRisk = Colors.redAccent;
                                    }
                                  } else if (bantuSeverity == bantuLikelihood) {
                                    if (bantuSeverity == 1) {
                                      _risk = 'Low';
                                      _colorRisk = Colors.green[400];
                                    } else if (bantuSeverity == 2) {
                                      _risk = 'Medium';
                                      _colorRisk = Colors.orangeAccent;
                                    } else if (bantuSeverity == 3) {
                                      _risk = 'High';
                                      _colorRisk = Colors.redAccent;
                                    }
                                  }
                                } else {
                                  _risk = '';
                                }
                            });
                          },
                        ),
                      ),
                      ButtonTheme(
                        height: 30.0,
                        child: OutlineButton(
                          child: Text(
                            'Medium',
                            style: TextStyle(color: _colorMedSe),
                          ),
                          borderSide:
                              BorderSide(color: _colorMedSe, width: 1.0),
                          highlightedBorderColor: _colorMedSe,
                          onPressed: () {
                            setState(() {
                              severity = 'Medium';
                              bantuSeverity = 2;
                              _colorLowSe = Colors.grey;
                              _colorMedSe = Colors.orangeAccent;
                              _colorHighSe = Colors.grey;

                              if (bantuSeverity != 0 && bantuLikelihood != 0) {
                                  if (bantuSeverity > bantuLikelihood) {
                                    if (bantuSeverity == 1) {
                                      _risk = 'Low';
                                      _colorRisk = Colors.green[400];
                                    } else if (bantuSeverity == 2) {
                                      _risk = 'Medium';
                                      _colorRisk = Colors.orangeAccent;
                                    } else if (bantuSeverity == 3) {
                                      _risk = 'High';
                                      _colorRisk = Colors.redAccent;
                                    }
                                  } else if (bantuSeverity < bantuLikelihood) {
                                    if (bantuLikelihood == 1) {
                                      _risk = 'Low';
                                      _colorRisk = Colors.green[400];
                                    } else if (bantuLikelihood == 2) {
                                      _risk = 'Medium';
                                      _colorRisk = Colors.orangeAccent;
                                    } else if (bantuLikelihood == 3) {
                                      _risk = 'High';
                                      _colorRisk = Colors.redAccent;
                                    }
                                  } else if (bantuSeverity == bantuLikelihood) {
                                    if (bantuSeverity == 1) {
                                      _risk = 'Low';
                                      _colorRisk = Colors.green[400];
                                    } else if (bantuSeverity == 2) {
                                      _risk = 'Medium';
                                      _colorRisk = Colors.orangeAccent;
                                    } else if (bantuSeverity == 3) {
                                      _risk = 'High';
                                      _colorRisk = Colors.redAccent;
                                    }
                                  }
                                } else {
                                  _risk = '';
                                }
                            });
                          },
                        ),
                      ),
                      ButtonTheme(
                        height: 30.0,
                        child: OutlineButton(
                          child: Text(
                            'High',
                            style: TextStyle(color: _colorHighSe),
                          ),
                          borderSide:
                              BorderSide(color: _colorHighSe, width: 1.0),
                          highlightedBorderColor: _colorHighSe,
                          onPressed: () {
                            setState(() {
                              severity = 'High';
                              bantuSeverity = 3;
                              _colorLowSe = Colors.grey;
                              _colorMedSe = Colors.grey;
                              _colorHighSe = Colors.redAccent;

                              if (bantuSeverity != 0 && bantuLikelihood != 0) {
                                  if (bantuSeverity > bantuLikelihood) {
                                    if (bantuSeverity == 1) {
                                      _risk = 'Low';
                                      _colorRisk = Colors.green[400];
                                    } else if (bantuSeverity == 2) {
                                      _risk = 'Medium';
                                      _colorRisk = Colors.orangeAccent;
                                    } else if (bantuSeverity == 3) {
                                      _risk = 'High';
                                      _colorRisk = Colors.redAccent;
                                    }
                                  } else if (bantuSeverity < bantuLikelihood) {
                                    if (bantuLikelihood == 1) {
                                      _risk = 'Low';
                                      _colorRisk = Colors.green[400];
                                    } else if (bantuLikelihood == 2) {
                                      _risk = 'Medium';
                                      _colorRisk = Colors.orangeAccent;
                                    } else if (bantuLikelihood == 3) {
                                      _risk = 'High';
                                      _colorRisk = Colors.redAccent;
                                    }
                                  } else if (bantuSeverity == bantuLikelihood) {
                                    if (bantuSeverity == 1) {
                                      _risk = 'Low';
                                      _colorRisk = Colors.green[400];
                                    } else if (bantuSeverity == 2) {
                                      _risk = 'Medium';
                                      _colorRisk = Colors.orangeAccent;
                                    } else if (bantuSeverity == 3) {
                                      _risk = 'High';
                                      _colorRisk = Colors.redAccent;
                                    }
                                  }
                                } else {
                                  _risk = '';
                                }
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
          Padding(
              padding: EdgeInsets.only(top: 20.0),
              child: Column(
                children: <Widget>[
                  Container(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Likelihood',
                      style: TextStyle(color: Colors.black54),
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
                              'Low 1',
                              style: TextStyle(color: _colorLowLi),
                            ),
                            borderSide:
                                BorderSide(color: _colorLowLi, width: 1.0),
                            highlightedBorderColor: _colorLowLi,
                            onPressed: () {
                              setState(() {
                                likelihood = 'Low';
                                bantuLikelihood = 1;
                                _colorLowLi = Colors.green[400];
                                _colorMedLi = Colors.grey;
                                _colorHighLi = Colors.grey;

                                // _risk = 'Low';
                                // _colorRisk = Colors.green[400];

                                if (bantuSeverity != 0 && bantuLikelihood != 0) {
                                  if (bantuSeverity > bantuLikelihood) {
                                    if (bantuSeverity == 1) {
                                      _risk = 'Low';
                                      _colorRisk = Colors.green[400];
                                    } else if (bantuSeverity == 2) {
                                      _risk = 'Medium';
                                      _colorRisk = Colors.orangeAccent;
                                    } else if (bantuSeverity == 3) {
                                      _risk = 'High';
                                      _colorRisk = Colors.redAccent;
                                    }
                                  } else if (bantuSeverity < bantuLikelihood) {
                                    if (bantuLikelihood == 1) {
                                      _risk = 'Low';
                                      _colorRisk = Colors.green[400];
                                    } else if (bantuLikelihood == 2) {
                                      _risk = 'Medium';
                                      _colorRisk = Colors.orangeAccent;
                                    } else if (bantuLikelihood == 3) {
                                      _risk = 'High';
                                      _colorRisk = Colors.redAccent;
                                    }
                                  } else if (bantuSeverity == bantuLikelihood) {
                                    if (bantuSeverity == 1) {
                                      _risk = 'Low';
                                      _colorRisk = Colors.green[400];
                                    } else if (bantuSeverity == 2) {
                                      _risk = 'Medium';
                                      _colorRisk = Colors.orangeAccent;
                                    } else if (bantuSeverity == 3) {
                                      _risk = 'High';
                                      _colorRisk = Colors.redAccent;
                                    }
                                  }
                                } else {
                                  _risk = '';
                                }
                              });
                            },
                          ),
                        ),
                        ButtonTheme(
                          height: 30.0,
                          child: OutlineButton(
                            child: Text(
                              'Medium',
                              style: TextStyle(color: _colorMedLi),
                            ),
                            borderSide:
                                BorderSide(color: _colorMedLi, width: 1.0),
                            highlightedBorderColor: _colorMedLi,
                            onPressed: () {
                              setState(() {
                                likelihood = 'Medium';
                                bantuLikelihood = 2;
                                _colorLowLi = Colors.grey;
                                _colorMedLi = Colors.orangeAccent;
                                _colorHighLi = Colors.grey;

                                // _risk = 'Medium';
                                // _colorRisk = Colors.orangeAccent;

                                if (bantuSeverity != 0 && bantuLikelihood != 0) {
                                  if (bantuSeverity > bantuLikelihood) {
                                    if (bantuSeverity == 1) {
                                      _risk = 'Low';
                                      _colorRisk = Colors.green[400];
                                    } else if (bantuSeverity == 2) {
                                      _risk = 'Medium';
                                      _colorRisk = Colors.orangeAccent;
                                    } else if (bantuSeverity == 3) {
                                      _risk = 'High';
                                      _colorRisk = Colors.redAccent;
                                    }
                                  } else if (bantuSeverity < bantuLikelihood) {
                                    if (bantuLikelihood == 1) {
                                      _risk = 'Low';
                                      _colorRisk = Colors.green[400];
                                    } else if (bantuLikelihood == 2) {
                                      _risk = 'Medium';
                                      _colorRisk = Colors.orangeAccent;
                                    } else if (bantuLikelihood == 3) {
                                      _risk = 'High';
                                      _colorRisk = Colors.redAccent;
                                    }
                                  } else if (bantuSeverity == bantuLikelihood) {
                                    if (bantuSeverity == 1) {
                                      _risk = 'Low';
                                      _colorRisk = Colors.green[400];
                                    } else if (bantuSeverity == 2) {
                                      _risk = 'Medium';
                                      _colorRisk = Colors.orangeAccent;
                                    } else if (bantuSeverity == 3) {
                                      _risk = 'High';
                                      _colorRisk = Colors.redAccent;
                                    }
                                  }
                                } else {
                                  _risk = '';
                                }
                              });
                            },
                          ),
                        ),
                        ButtonTheme(
                          height: 30.0,
                          child: OutlineButton(
                            child: Text(
                              'High',
                              style: TextStyle(color: _colorHighLi),
                            ),
                            borderSide:
                                BorderSide(color: _colorHighLi, width: 1.0),
                            highlightedBorderColor: _colorHighLi,
                            onPressed: () {
                              setState(() {
                                likelihood = 'High';
                                bantuLikelihood = 3;
                                _colorLowLi = Colors.grey;
                                _colorMedLi = Colors.grey;
                                _colorHighLi = Colors.redAccent;

                                // _risk = 'High';
                                // _colorRisk = Colors.redAccent;

                                if (bantuSeverity != 0 && bantuLikelihood != 0) {
                                  if (bantuSeverity > bantuLikelihood) {
                                    if (bantuSeverity == 1) {
                                      _risk = 'Low';
                                      _colorRisk = Colors.green[400];
                                    } else if (bantuSeverity == 2) {
                                      _risk = 'Medium';
                                      _colorRisk = Colors.orangeAccent;
                                    } else if (bantuSeverity == 3) {
                                      _risk = 'High';
                                      _colorRisk = Colors.redAccent;
                                    }
                                  } else if (bantuSeverity < bantuLikelihood) {
                                    if (bantuLikelihood == 1) {
                                      _risk = 'Low';
                                      _colorRisk = Colors.green[400];
                                    } else if (bantuLikelihood == 2) {
                                      _risk = 'Medium';
                                      _colorRisk = Colors.orangeAccent;
                                    } else if (bantuLikelihood == 3) {
                                      _risk = 'High';
                                      _colorRisk = Colors.redAccent;
                                    }
                                  } else if (bantuSeverity == bantuLikelihood) {
                                    if (bantuSeverity == 1) {
                                      _risk = 'Low';
                                      _colorRisk = Colors.green[400];
                                    } else if (bantuSeverity == 2) {
                                      _risk = 'Medium';
                                      _colorRisk = Colors.orangeAccent;
                                    } else if (bantuSeverity == 3) {
                                      _risk = 'High';
                                      _colorRisk = Colors.redAccent;
                                    }
                                  }
                                } else {
                                  _risk = '';
                                }
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              )),
          Padding(
            padding: EdgeInsets.only(top: 20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Container(
                  padding: EdgeInsets.only(bottom: 10.0),
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Risk',
                    style: TextStyle(color: Colors.black54),
                    textAlign: TextAlign.start,
                  ),
                ),
                Stack(
                  alignment: AlignmentDirectional.centerStart,
                  children: <Widget>[
                    Container(
                      color: _colorRisk,
                      height: 50.0,
                    ),
                    Container(
                      child: Text(
                        _risk,
                        style: TextStyle(color: Colors.white, fontSize: 16.0),
                      ),
                      alignment: Alignment.center,
                    )
                  ],
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20.0),
            child: TextFormField(
              textCapitalization: TextCapitalization.words,
              decoration: InputDecoration(
                border: UnderlineInputBorder(),
                labelText: 'Pengendalian',
                labelStyle: TextStyle(fontSize: 14.0),
              ),
              style: TextStyle(
                  fontStyle: FontStyle.normal,
                  color: Colors.black87,
                  fontSize: 14.0),
              onSaved: null,
            ),
          ),
          Padding(
              padding: const EdgeInsets.only(top: 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(
                    width: 250,
                    child: TextFormField(
                      maxLines: 3,
                      keyboardType: TextInputType.text,
                      textCapitalization: TextCapitalization.words,
                      decoration: InputDecoration(
                        border: UnderlineInputBorder(),
                        labelText: 'Deskripsi',
                        labelStyle: TextStyle(fontSize: 14.0),
                      ),
                      style: TextStyle(
                          fontStyle: FontStyle.normal,
                          color: Colors.black87,
                          fontSize: 14.0),
                      onSaved: null,
                    ),
                  ),
                  Container(
                      width: 50.0,
                      child: IconButton(
                        icon: Icon(Icons.add),
                        color: Colors.blue,
                        onPressed: () {},
                      ))
                ],
              )),
          Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(
                    width: 250,
                    child: TextFormField(
                      textCapitalization: TextCapitalization.words,
                      decoration: InputDecoration(
                        border: UnderlineInputBorder(),
                        labelText: 'Pemantauan',
                        labelStyle: TextStyle(fontSize: 14.0),
                        hintText: 'Pemantauan',
                      ),
                      style: TextStyle(
                          fontStyle: FontStyle.normal,
                          color: Colors.black87,
                          fontSize: 14.0),
                      onSaved: null,
                    ),
                  ),
                  Container(
                      width: 50.0,
                      child: IconButton(
                        icon: Icon(Icons.add),
                        color: Colors.blue,
                        onPressed: () {},
                      ))
                ],
              )),
          Padding(
              padding: const EdgeInsets.only(top: 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(
                    width: 250,
                    child: DropdownButtonFormField<String>(
                      decoration: InputDecoration(
                        labelText: 'PIC',
                        labelStyle: TextStyle(fontSize: 14.0),
                      ),
                      value: _selectionPIC,
                      onChanged: (String value) {
                        setState(() {
                          switch (int.tryParse(value)) {
                            case 1:
                              _pic = 'Ironman';
                              break;
                            case 2:
                              _pic = 'Spiderman';
                              break;
                            default:
                              _pic = '-';
                              break;
                          }
                          _selectionPIC = value;
                        });
                      },
                      items: _picJSON.map((Map map) {
                        return DropdownMenuItem(
                          value: map['id'].toString(),
                          child: Text(map['pic']),
                        );
                      }).toList(),
                    ),
                  ),
                  Container(
                      width: 50.0,
                      child: IconButton(
                        icon: Icon(Icons.add),
                        color: Colors.blue,
                        onPressed: () {},
                      ))
                ],
              )),
          Padding(
              padding: const EdgeInsets.only(top: 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(
                    width: 250,
                    child: DropdownButtonFormField<String>(
                      decoration: InputDecoration(
                        labelText: 'Verifikator',
                        labelStyle: TextStyle(fontSize: 14.0),
                      ),
                      value: _selectionVerifikator,
                      onChanged: (String value) {
                        setState(() {
                          switch (int.tryParse(value)) {
                            case 1:
                              _verifikator = 'Hulk';
                              break;
                            case 2:
                              _verifikator = 'Thor';
                              break;
                            default:
                              _verifikator = '-';
                              break;
                          }
                          _selectionVerifikator = value;
                        });
                      },
                      items: _verifikatorJSON.map((Map map) {
                        return DropdownMenuItem(
                          value: map['id'].toString(),
                          child: Text(map['verifikator']),
                        );
                      }).toList(),
                    ),
                  ),
                  Container(
                      width: 50.0,
                      child: IconButton(
                        icon: Icon(Icons.add),
                        color: Colors.blue,
                        onPressed: () {},
                      ))
                ],
              )),
          Padding(
            padding: EdgeInsets.only(top: 20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                ButtonTheme(
                  height: 30.0,
                  child: OutlineButton(
                    child: Text(
                      'EDIT',
                      style: TextStyle(
                          color: Colors.grey, fontWeight: FontWeight.w700),
                    ),
                    borderSide: BorderSide(color: Colors.grey, width: 2.0),
                    highlightedBorderColor: Colors.grey,
                    onPressed: () {},
                  ),
                ),
                RaisedButton(
                  child: Text(
                    'SAVE',
                  ),
                  onPressed: () {},
                  textColor: Colors.white,
                  color: Colors.green,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
