import 'package:flutter/material.dart';
import 'package:flutter_abuba/constant.dart';
import 'package:flutter/cupertino.dart';class FormMaintenance extends StatefulWidget {
  FormMaintenance({Key key}) : super(key: key);

  _FormMaintenanceState createState() => _FormMaintenanceState();
}

class _FormMaintenanceState extends State<FormMaintenance> {
  final _lokasi = List<String>.generate(5, (i) => 'Outlet ${i + 1}');
  final _item = ['Computer', 'Printer', 'Kulkas', 'Meja', 'Kursi'];
  final _merek = ['Lenovo', 'HP', 'Panasonic', 'IKEA', 'IKEA'];

  List<String> isiCheckbox = ['Alasan 1', 'Alasan 2', 'Alasan 3', 'Alasan 4', 'Alasan 5'];
  List<String> valueCheckbox = ['1', '2', '3', '4', '5'];
  List<String> selectedValue = [];
  List<String> selectedAlasan = [];

  void _dialogDetail(int index) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(_lokasi[index] + ' - ' + _item[index] + ' - ' + _merek[index]),
          content: Text('Alert Dialog Body'),
          actions: <Widget>[
            FlatButton(
              splashColor: Colors.greenAccent,
              child: Text(
                'CLOSE',
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
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: DefaultTabController(
        length: 2,
        child: Scaffold(
          resizeToAvoidBottomPadding: false,
          appBar: _appBar(),
          body: TabBarView(
            children: <Widget>[
              _buildApprovalForm(),
              _buildApprovalForm(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildApprovalForm() {
    return ListView.builder(
      itemCount: _lokasi.length,
      itemBuilder: (context, index) {
        final String lokasi = _lokasi[index];
        final String item = _item[index];
        final String merek = _merek[index];

        return Dismissible(
          key: Key(lokasi),
          onDismissed: (DismissDirection dir) {
            setState((){
              this._lokasi.removeAt(index);
              this._item.removeAt(index);
              this._merek.removeAt(index);
            });

            dir == DismissDirection.startToEnd
              ? showDialog(
                  barrierDismissible: false,
                  context: context,
                  builder: (context) {
                    return Checkbox(
                      lokasi: lokasi,
                      item: item,
                      merek: merek,
                      alasan: isiCheckbox,
                      valueCheck: valueCheckbox,
                      selectedAlasan: selectedAlasan,
                      selectedValue: selectedValue,
                      onSelectedAlasanListChanged: (alasans) {
                        print(alasans);
                        selectedAlasan = alasans;
                      },
                      onCancelResult: (cancelResult) {
                        setState(() {
                          this._lokasi.insert(index, cancelResult[0]);
                          this._item.insert(index, cancelResult[1]);
                          this._merek.insert(index, cancelResult[2]);
                        });
                      },
                    );
                  }
                )
              : showDialog(
                  barrierDismissible: false,
                  context: context,
                  builder: (context) {
                    return Checkbox(
                      lokasi: lokasi,
                      item: item,
                      merek: merek,
                      alasan: isiCheckbox,
                      valueCheck: valueCheckbox,
                      selectedAlasan: selectedAlasan,
                      selectedValue: selectedValue,
                      onSelectedAlasanListChanged: (alasans) {
                        selectedAlasan = alasans;
                      },
                      onCancelResult: (cancelResult) {
                        setState(() {
                          this._lokasi.insert(index, cancelResult[0]);
                          this._item.insert(index, cancelResult[1]);
                          this._merek.insert(index, cancelResult[2]);
                        });
                      },
                    );
                  }
                );
          },
          background: Container(
            color: Colors.green,
            child: Padding(
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
            ),
            alignment: Alignment.centerLeft,
          ),
          secondaryBackground: Container(
            color: Colors.blueAccent,
            child: Padding(
              padding: const EdgeInsets.only(right: 30.0, left: 30.0, bottom: 10.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Container(
                    height: 30.0,
                    width: 30.0,
                    child: Icon(Icons.refresh, color: Colors.white, size: 14.0),
                  ),
                  Text(
                    'SKIP',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                        fontSize: 14.0
                    ),
                  )
                ],
              ),
            ),
            alignment: Alignment.centerRight,
          ),
          child: GestureDetector(
            onTap: () {
              _dialogDetail(index);
            },
            child: Container(
              color: Colors.white,
              child: ListTile(
                leading: Padding(
                  padding: EdgeInsets.only(right: 20.0, left: 20.0),
                  child: Text(_lokasi[index]),
                ),
                title: Text(_item[index]),
                subtitle: Text(_merek[index]),
                trailing: ButtonTheme(
                  minWidth: 50.0,
                  height: 20.0,
                  child: OutlineButton(
                    child: Text(
                      'Detail',
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
                      _dialogDetail(index);
                    },
                  ),
                ),
              ),
            ),
          )
        );
      },
    );
  }
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
      isScrollable: false,
      indicatorColor: AbubaPallate.greenabuba,
      tabs: <Widget>[
        new Tab(
          child: Text(
            'Infrastruktur',
            style: TextStyle(color: Colors.grey[400]),
          ),
        ), // 1st Tab
        new Tab(
          child: Text(
            'Peralatan',
            style: TextStyle(color: Colors.grey[400]),
          ),
        ), // 1st Tab
      ],
    ),
  );
}

class Checkbox extends StatefulWidget {
  Checkbox({
    this.alasan,
    this.selectedAlasan,
    this.selectedValue,
    this.onSelectedAlasanListChanged,
    this.onCancelResult,
    this.valueCheck,
    this.lokasi,
    this.item,
    this.merek,
  });

  final List<String> alasan;
  final List<String> valueCheck;
  final List<String> selectedAlasan;
  final List<String> selectedValue;
  final ValueChanged<List<String>> onSelectedAlasanListChanged;
  final ValueChanged<List<String>> onCancelResult;
  final String lokasi;
  final String item;
  final String merek;

  @override
  _CheckboxState createState() => new _CheckboxState();
}

class _CheckboxState extends State<Checkbox> {
  List<String> _tempSelectedAlasan= [];
  List<String> _tempSelectedValueAlasan = [];

  bool _note = false;
  double height = 300.0;
  TextEditingController _noteController = new TextEditingController();

  @override
  void initState() {
    _tempSelectedAlasan= widget.selectedAlasan;
    _tempSelectedValueAlasan = widget.selectedValue;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        height: height,
        child: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(20.0),
              child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Flexible(
                        child: Text(
                          widget.lokasi +
                              ' - ' +
                              widget.item +
                              ' - ' +
                              widget.merek,
                          style: TextStyle(fontSize: 18.0, color: Colors.black),
                          textAlign: TextAlign.left,
                        ),
                      ),
                      FlatButton(
                        child: Text(
                          'Add Note',
                          style: TextStyle(color: Colors.green, fontSize: 12.0),
                        ),
                        onPressed: () {
                          setState(() {
                            if (_note == true) {
                              height = 300.0;
                            } else {
                              height = height + 100.0;
                            }

                            _note = !_note;
                          });
                        },
                      ),
                    ],
                  )),
            ),
            Expanded(
              child: Scrollbar(
                child: ListView.builder(
                    scrollDirection: Axis.vertical,
                    itemCount: widget.alasan.length,
                    itemBuilder: (BuildContext context, int index) {
                      final AlasanValue = widget.alasan[index];
                      final ValueFinal = widget.valueCheck[index];

                      return Container(
                        child: CheckboxListTile(
                            title: Text(AlasanValue),
                            controlAffinity: ListTileControlAffinity.leading,
                            activeColor: Colors.green,
                            value: _tempSelectedAlasan.contains(AlasanValue),
                            onChanged: (bool value) {
                              if (value) {
                                if (!_tempSelectedAlasan
                                    .contains(AlasanValue)) {
                                  setState(() {
                                    _tempSelectedValueAlasan.add(ValueFinal);
                                    _tempSelectedAlasan.add(AlasanValue);
                                  });
                                }
                              } else {
                                if (_tempSelectedAlasan.contains(AlasanValue)) {
                                  setState(() {
                                    _tempSelectedAlasan.removeWhere(
                                            (String city) => city == AlasanValue);
                                    _tempSelectedValueAlasan.removeWhere(
                                            (String city) => city == ValueFinal);
                                  });
                                }
                              }
                              widget.onSelectedAlasanListChanged(_tempSelectedValueAlasan);
                            }),
                      );
                    }),
              ),
            ),
            _note
                ? Padding(
              padding:
              EdgeInsets.only(top: 20.0, right: 10.0, left: 10.0),
              child: Container(
                width: MediaQuery.of(context).size.width / 1.1,
                child: TextField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Note',
                  ),
                  maxLines: 3,
                  controller: _noteController,
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
              ),
            )
                : Container(),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(right: 10.0),
                    child: RaisedButton(
                      color: Colors.red[300],
                      child: Text(
                        'CANCEL',
                        style: TextStyle(color: Colors.white, fontSize: 12.0),
                      ),
                      onPressed: () {
                        widget.onCancelResult(
                            [widget.lokasi, widget.item, widget.merek]);
                        Navigator.of(context).pop();
                      },
                      splashColor: Colors.red[300],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(right: 10.0),
                    child: RaisedButton(
                      color: Colors.green[300],
                      child: Text(
                        'OK',
                        style: TextStyle(color: Colors.white, fontSize: 12.0),
                      ),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      splashColor: Colors.green[300],
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}