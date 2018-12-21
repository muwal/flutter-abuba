import 'package:flutter/material.dart';
import 'package:flutter_abuba/constant.dart';
// import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:flutter_abuba/beranda/beranda_appbardua.dart';

class FormBahanBaku extends StatefulWidget {
  @override
  _FormBahanBakuState createState() => _FormBahanBakuState();
}

class _FormBahanBakuState extends State<FormBahanBaku> {
  String _mySelection;
  String _mySelectionsatu;
  String _mySelectiondua;
  String _jenisAcara;
  List<Map> _jenisAcaraJson = [
    {"id": 1, "jenis": "Bahan Baku 1"},
    {"id": 2, "jenis": "Bahan Baku 2"}
  ];

  TextEditingController controller = new TextEditingController();
  List<String> textList = [];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AbubaAppBar(),
        body: GestureDetector(
            onTap: () {
              FocusScope.of(context).requestFocus(FocusNode());
            },
            child: _buildFormMenu()),
      ),
    );
  }

  Widget _buildFormMenu() {
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
                  'Bahan Baku',
                  style:
                      TextStyle(color: AbubaPallate.greenabuba, fontSize: 12.0),
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            children: <Widget>[
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                verticalDirection: VerticalDirection.up,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    'Sold Out',
                    style: TextStyle(
                      color: Colors.green,
                    ),
                  ),
                  Container(
                    width: 150.0,
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        isDense: true,
                        hint: Text('Bahan Baku'),
                        value: _mySelection,
                        onChanged: (String newValue) {
                          setState(() {
                            switch (int.tryParse(newValue)) {
                              case 1:
                                _jenisAcara = 'Bahan Baku 1';
                                break;
                              case 2:
                                _jenisAcara = 'Bahan Baku 2';
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
                  )
                ],
              ),
              SizedBox(
                height: 10.0,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                verticalDirection: VerticalDirection.up,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    'Limit',
                    style: TextStyle(
                      color: Colors.green,
                    ),
                  ),
                  Container(
                    width: 150.0,
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        isDense: true,
                        hint: Text('Bahan Baku'),
                        value: _mySelectionsatu,
                        onChanged: (String newValue) {
                          setState(() {
                            switch (int.tryParse(newValue)) {
                              case 1:
                                _jenisAcara = 'Bahan Baku 1';
                                break;
                              case 2:
                                _jenisAcara = 'Bahan Baku 2';
                                break;
                              default:
                                _jenisAcara = '-';
                                break;
                            }
                            _mySelectionsatu = newValue;
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
                  )
                ],
              ),
              SizedBox(
                height: 10.0,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                verticalDirection: VerticalDirection.up,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    'Sugestion',
                    style: TextStyle(
                      color: Colors.green,
                    ),
                  ),
                  Container(
                    width: 150.0,
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        isDense: true,
                        hint: Text('Bahan Baku'),
                        value: _mySelectiondua,
                        onChanged: (String newValue) {
                          setState(() {
                            switch (int.tryParse(newValue)) {
                              case 1:
                                _jenisAcara = 'Bahan Baku 1';
                                break;
                              case 2:
                                _jenisAcara = 'Bahan Baku 2';
                                break;
                              default:
                                _jenisAcara = '-';
                                break;
                            }
                            _mySelectiondua = newValue;
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
                ],
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                verticalDirection: VerticalDirection.up,
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  IconButton(
                    icon: Icon(
                      Icons.add_circle,
                      color: Colors.green,
                      size: 30.0,
                    ),
                    onPressed: () {
                      setState(() {
                        textList.add(controller.text);
                        controller.clear();
                      });
                    },
                  ),
                ],
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                verticalDirection: VerticalDirection.up,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    'Catatan',
                    style: TextStyle(color: Colors.green),
                  ),
                  Container(
                    width: 150.0,
                    child: TextField(
                      maxLines: 3,
                      keyboardType: TextInputType.multiline,
                      decoration: InputDecoration(
                        hintText: 'Catatan',
                        hintStyle: TextStyle(fontSize: 12.0),
                      ),
                      textCapitalization: TextCapitalization.sentences,
                      style: TextStyle(
                        color: Colors.black,
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 15.0,
              ),
              ButtonTheme(
                minWidth: 50.0,
                height: 30.0,
                child: RaisedButton(
                  child: Text(
                    'SAVE',
                    style: TextStyle(fontSize: 13.0),
                  ),
                  textColor: Colors.white,
                  color: Colors.green,
                  onPressed: () {},
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
