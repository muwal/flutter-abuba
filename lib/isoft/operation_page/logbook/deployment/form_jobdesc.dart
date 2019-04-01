import 'package:flutter/material.dart';
import 'package:flutter_abuba/constant.dart';

class FormJobdesc extends StatefulWidget {
  @override
  _FormJobdescState createState() => _FormJobdescState();
}

class _FormJobdescState extends State<FormJobdesc> {
  Color _opening = Colors.green;
  Color _middle = Colors.grey;
  Color _closing = Colors.grey;

  Color _duapuluhColor = Colors.grey;
  Color _limapuluhColor = Colors.grey;
  bool _showMap = false;
  
  String _hijau = '0';
  String _kuningkanan = '0';
  String _kuningbawah = '0';
  String _merah = '0';

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final _scaffoldKey = new GlobalKey<ScaffoldState>();

    return SafeArea(
      child: Scaffold(
        key: _scaffoldKey,
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
        body: GestureDetector(
            onTap: () {
              FocusScope.of(context).requestFocus(FocusNode());
            },
            child: _buildFormMenu(width)),
      ),
    );
  }

  Widget _buildFormMenu(double width) {
    return ListView(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Text(
                'Log Book MOD',
                style: TextStyle(color: Colors.black12, fontSize: 12.0),
              ),
              Padding(
                padding: EdgeInsets.only(left: 15.0),
                child: Text(
                  '|',
                  style:
                      TextStyle(color: AbubaPallate.greenabuba, fontSize: 12.0),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 15.0),
                child: Text(
                  'Deployment',
                  style:
                      TextStyle(color: AbubaPallate.greenabuba, fontSize: 12.0),
                ),
              ),
            ],
          ),
        ),
        Container(
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.only(right: 20.0, left: 20.0, bottom: 5.0, top: 20.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              GestureDetector(
                onTap: () {
                  setState(() {
                    _opening = Colors.green;
                    _middle = Colors.grey;
                    _closing = Colors.grey;
                  });
                },
                child: Container(
                  width: width / 4,
                  child: Column(
                    children: <Widget>[
                      Text(
                        'OPENING',
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
                    _closing = Colors.grey;
                  });
                },
                child: Container(
                  width: width / 4,
                  child: Column(
                    children: <Widget>[
                      Text(
                        'MIDDLE',
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
              GestureDetector(
                onTap: () {
                  setState(() {
                    _opening = Colors.grey;
                    _middle = Colors.grey;
                    _closing = Colors.green;
                  });
                },
                child: Container(
                  width: width / 4,
                  child: Column(
                    children: <Widget>[
                      Text(
                        'CLOSING',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: _closing
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5.0),
                        child: Divider(
                          height: 10.0,
                          color: _closing,
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
          padding: EdgeInsets.only(top: 10.0, left: 20.0, right: 20.0),
          child: Column(
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(top: 5.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Flexible(
                      child: Text(
                        'Target Sales',
                        style: TextStyle(
                            color: Colors.black54),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.only(top: 5.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Container(
                      child: ButtonTheme(
                        height: 30.0,
                        child: OutlineButton(
                            child: Text(
                              'IDR 20.000.000',
                              style: TextStyle(
                                  color: _duapuluhColor
                              ),
                            ),
                            borderSide: BorderSide(
                                color: _duapuluhColor,
                                width: 1.0
                            ),
                            highlightedBorderColor: _duapuluhColor,
                            onPressed: () {
                              setState(() {
                                _showMap = true;
                                _duapuluhColor = AbubaPallate.green;
                                _limapuluhColor = Colors.grey;

                                _hijau = '1';
                                _kuningkanan = '2';
                                _kuningbawah = '1';
                                _merah = '2';
                              });
                            }
                        ),
                      ),
                    ),
                    Container(
                      child: ButtonTheme(
                        height: 30.0,
                        child: OutlineButton(
                          child: Text(
                            'IDR 50.000.000',
                            style: TextStyle(
                                color: _limapuluhColor
                            ),
                          ),
                          borderSide: BorderSide(
                              color: _limapuluhColor,
                              width: 1.0
                          ),
                          highlightedBorderColor: _limapuluhColor,
                          onPressed: () {
                            setState(() {
                              _showMap = true;
                              _duapuluhColor = Colors.grey;
                              _limapuluhColor = AbubaPallate.green;

                              _hijau = '2';
                              _kuningkanan = '2';
                              _kuningbawah = '3';
                              _merah = '4';
                            });
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          )
        ),
        _showMap
          ? Padding(
              padding: EdgeInsets.only(top: 10.0, left: 20.0, right: 20.0, bottom: 20.0),
              child: Stack(
                children: <Widget>[
                  Container(
                    color: Colors.white,
                    width: width,
                    height: MediaQuery.of(context).size.height - 300.0,
                    child: Image.asset(
                      'assets/images/map_2.png',
                      fit: BoxFit.fill,
                    ),
                  ),
                  Positioned(
                    left: 25.0,
                    top: 40.0,
                    child: ButtonTheme(
                      height: 45.0,
                      child: OutlineButton(
                        child: Text(
                          _hijau,
                          style: TextStyle(
                            color: Colors.black87,
                            fontSize: 24.0
                          ),
                        ),
                        borderSide: BorderSide(
                          color: AbubaPallate.greenabuba,
                          width: 3.0
                        ),
                        splashColor: Colors.transparent,
                        highlightedBorderColor: AbubaPallate.greenabuba,
                        shape: CircleBorder(),
                        onPressed: () {
                          showModalBottomSheet(
                            context: context,
                            builder: (context) {
                              return MyDialog(jabatan: 'Cashier', color: AbubaPallate.greenabuba, standard: _hijau,);
                            }
                          );
                        },
                      ),
                    ),
                  ),
                  Positioned(
                    right: 40.0,
                    top: 120.0,
                    child: ButtonTheme(
                      height: 45.0,
                      child: OutlineButton(
                        child: Text(
                          _kuningkanan,
                          style: TextStyle(
                            color: Colors.black87,
                            fontSize: 24.0
                          ),
                        ),
                        borderSide: BorderSide(
                          color: Colors.orangeAccent,
                          width: 3.0
                        ),
                        splashColor: Colors.transparent,
                        highlightedBorderColor: Colors.orangeAccent,
                        shape: CircleBorder(),
                        onPressed: () {
                          showModalBottomSheet(
                            context: context,
                            builder: (context) {
                              return MyDialog(jabatan: 'Server (Pelayan Resto)', color: Colors.orangeAccent, standard: _kuningkanan);
                            }
                          );
                        },
                      ),
                    ),
                  ),
                  Positioned(
                    left: 30.0,
                    bottom: 30.0,
                    child: ButtonTheme(
                      height: 45.0,
                      child: OutlineButton(
                        child: Text(
                          _kuningbawah,
                          style: TextStyle(
                            color: Colors.black87,
                            fontSize: 24.0
                          ),
                        ),
                        borderSide: BorderSide(
                          color: Colors.orangeAccent,
                          width: 3.0
                        ),
                        splashColor: Colors.transparent,
                        highlightedBorderColor: Colors.orangeAccent,
                        shape: CircleBorder(),
                        onPressed: () {
                          showModalBottomSheet(
                            context: context,
                            builder: (context) {
                              return MyDialog(jabatan: 'Server (Pelayan Resto)', color: Colors.orangeAccent, standard: _kuningbawah);
                            }
                          );
                        },
                      ),
                    ),
                  ),
                  Positioned(
                    right: 65.0,
                    bottom: 60.0,
                    child: ButtonTheme(
                      height: 45.0,
                      child: OutlineButton(
                        child: Text(
                          _merah,
                          style: TextStyle(
                            color: Colors.black87,
                            fontSize: 24.0
                          ),
                        ),
                        splashColor: Colors.transparent,
                        borderSide: BorderSide(
                          color: Colors.redAccent,
                          width: 3.0
                        ),
                        highlightedBorderColor: Colors.redAccent,
                        shape: CircleBorder(),
                        onPressed: () {
                          showModalBottomSheet(
                            context: context,
                            builder: (context) {
                              return MyDialog(jabatan: 'Cooker', color: Colors.redAccent, standard: _merah);
                            }
                          );
                        },
                      ),
                    ),
                  ),
                ],
              )
            )
        : Container()
      ],
    );
  }
}

class MyDialog extends StatefulWidget {
  final String jabatan;
  final Color color;
  final String standard;
  MyDialog({this.jabatan, this.color, this.standard});

  @override
  _MyDialogState createState() => _MyDialogState();
}

class _MyDialogState extends State<MyDialog> {
  bool _editActual = false;
  String _actualValue;

  @override
  void initState() {
    super.initState();
    _actualValue = widget.standard;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xFF737373),
      height: 280.0,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topRight: const Radius.circular(20.0),
            topLeft: const Radius.circular(20.0),
          ),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 12.0),
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: ListTile(
                    title: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        ButtonTheme(
                          height: 30.0,
                          child: OutlineButton(
                            child: Text(
                              '',
                              style: TextStyle(
                                  color: Colors.black87,
                                  fontSize: 24.0
                              ),
                            ),
                            borderSide: BorderSide(
                                color: widget.color,
                                width: 3.0
                            ),
                            splashColor: Colors.transparent,
                            highlightedBorderColor: widget.color,
                            shape: CircleBorder(),
                            onPressed: () {},
                          ),
                        ),
                        Text(
                          widget.jabatan,
                          style: TextStyle(
                              color: Colors.black54, fontWeight: FontWeight.w700, fontSize: 14.0
                          ),
                        ),
                      ],
                    ),
                    trailing: Padding(
                      padding: const EdgeInsets.only(right: 20.0),
                      child: Text(
                        '17/01/2019 Shift A',
                        style: TextStyle(
                            color: Colors.black54, fontWeight: FontWeight.w700),
                      ),
                    )
                ),
              ),
              Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: ListTile(
                      leading: Container(
                          width: 50.0,
                          child: Row(
                            children: <Widget>[
                              Flexible(
                                fit: FlexFit.loose,
                                child: Text(
                                  'Standard',
                                  style: TextStyle(
                                      fontSize: 13.0
                                  ),
                                ),
                              )
                            ],
                          )
                      ),
                      title: Container(
                          width: MediaQuery.of(context).size.width - 50.0 - 20.0 - 20.0,
                          child: Row(
                            children: <Widget>[
                              IconButton(
                                  icon: Icon(Icons.remove, color: Colors.white),
                                  onPressed: null
                              ),
                              Flexible(
                                fit: FlexFit.loose,
                                child: Text(
                                  widget.standard,
                                  style: TextStyle(
                                      fontSize: 13.0
                                  ),
                                ),
                              ),
                              IconButton(
                                icon: Icon(Icons.add, color: Colors.white),
                                onPressed: null,
                              ),
                            ],
                          )
                      )
                  )
              ),
              Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: ListTile(
                      leading: Container(
                          width: 50.0,
                          child: Row(
                            children: <Widget>[
                              Flexible(
                                fit: FlexFit.loose,
                                child: Text(
                                  'Actual',
                                  style: TextStyle(
                                      fontSize: 13.0
                                  ),
                                ),
                              )
                            ],
                          )
                      ),
                      title: _editActual
                          ? Container(
                          width: MediaQuery.of(context).size.width - 50.0 - 20.0 - 20.0,
                          child: Row(
                            children: <Widget>[
                              int.parse(_actualValue) > 0
                                  ? IconButton(
                                icon: Icon(Icons.remove),
                                onPressed: () {
                                  setState(() {
                                    int _bantuActual = int.parse(_actualValue);

                                    if (_bantuActual > 0) {
                                      _bantuActual--;
                                      _actualValue = _bantuActual.toString();
                                    } else {
                                      _actualValue = _actualValue;
                                    }
                                  });
                                },
                              )
                                  : IconButton(
                                  icon: Icon(Icons.remove, color: Colors.white),
                                  onPressed: null
                              ),
                              Flexible(
                                fit: FlexFit.loose,
                                child: Text(
                                  _actualValue,
                                  style: TextStyle(
                                      fontSize: 13.0
                                  ),
                                ),
                              ),
                              IconButton(
                                icon: Icon(Icons.add),
                                onPressed: () {
                                  setState(() {
                                    int _bantuActual = int.parse(_actualValue);
                                    _bantuActual++;
                                    _actualValue = _bantuActual.toString();
                                  });
                                },
                              ),
                            ],
                          )
                      )
                          : Container(
                          width: MediaQuery.of(context).size.width - 50.0 - 20.0 - 20.0,
                          child: Row(
                            children: <Widget>[
                              IconButton(
                                  icon: Icon(Icons.remove, color: Colors.white),
                                  onPressed: null
                              ),
                              Flexible(
                                fit: FlexFit.loose,
                                child: Text(
                                  _actualValue,
                                  style: TextStyle(
                                      fontSize: 13.0
                                  ),
                                ),
                              ),
                              IconButton(
                                icon: Icon(Icons.add, color: Colors.white),
                                onPressed: null,
                              ),
                            ],
                          )
                      )
                  )
              ),
              _editActual
                  ? Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(right: 5.0),
                      child: ButtonTheme(
                        height: 30.0,
                        child: OutlineButton(
                            child: Text(
                              'UPDATE',
                              style: TextStyle(
                                  color: AbubaPallate.menuBluebird
                              ),
                            ),
                            borderSide: BorderSide(
                                color: AbubaPallate.menuBluebird,
                                width: 1.0
                            ),
                            highlightedBorderColor: AbubaPallate.menuBluebird,
                            onPressed: () {
                              setState(() {
                                _editActual = !_editActual;
                              });
                            }
                        ),
                      ),
                    ),
                  ],
                ),
              )
                  : Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(right: 5.0),
                      child: ButtonTheme(
                        height: 30.0,
                        child: OutlineButton(
                            child: Text(
                              'EDIT',
                              style: TextStyle(
                                  color: AbubaPallate.menuBluebird
                              ),
                            ),
                            borderSide: BorderSide(
                                color: AbubaPallate.menuBluebird,
                                width: 1.0
                            ),
                            highlightedBorderColor: AbubaPallate.menuBluebird,
                            onPressed: () {
                              setState(() {
                                _editActual = !_editActual;
                              });
                            }
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 5.0),
                      child: ButtonTheme(
                        height: 30.0,
                        child: OutlineButton(
                            child: Text(
                              'SAVE',
                              style: TextStyle(
                                  color: AbubaPallate.greenabuba
                              ),
                            ),
                            borderSide: BorderSide(
                                color: AbubaPallate.greenabuba,
                                width: 1.0
                            ),
                            highlightedBorderColor: AbubaPallate.greenabuba,
                            onPressed: () {
                              Navigator.pop(context);
                            }
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}