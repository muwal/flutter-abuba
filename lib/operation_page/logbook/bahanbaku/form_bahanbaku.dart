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
    final double width = MediaQuery.of(context).size.width;

    return SafeArea(
      child: Scaffold(
        appBar: AbubaAppBar(),
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
        Padding(
          padding: const EdgeInsets.only(top: 10.0, left: 20.0, right: 20.0),
          child: DropdownButtonFormField(
            decoration: InputDecoration(
              border: UnderlineInputBorder(),
              labelText: 'Bahan Baku',
              labelStyle: TextStyle(fontSize: 14.0),
            ),
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
                child: Text(map['jenis'], style: TextStyle(fontSize: 14.0)),
              );
            }).toList(),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 10.0, left: 20.0, right: 20.0),
          child: DropdownButtonFormField(
            decoration: InputDecoration(
              border: UnderlineInputBorder(),
              labelText: 'Limit',
              labelStyle: TextStyle(fontSize: 14.0),
            ),
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
                child: Text(map['jenis'], style: TextStyle(fontSize: 14.0)),
              );
            }).toList(),
          ),
        ),
        ListTile(
          title: Padding(
            padding: const EdgeInsets.only(top: 10.0, left: 5.0),
            child: DropdownButtonFormField(
              decoration: InputDecoration(
              border: UnderlineInputBorder(),
              labelText: 'Suggestion',
              labelStyle: TextStyle(fontSize: 14.0),
            ),
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
                  child: Text(map['jenis'], style: TextStyle(fontSize: 14.0)),
                );
              }).toList(),
            ),
          ),
          trailing: Padding(
            padding: const EdgeInsets.only(top: 10.0),
            child: IconButton(
              icon: Icon(
                Icons.add_circle,
                color: Colors.green,
                size: 30.0,
              ),
              onPressed: () {},
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 10.0, left: 20.0, right: 20.0),
          child: TextFormField(
            textCapitalization: TextCapitalization.words,
            maxLines: 3,
            keyboardType: TextInputType.multiline,
            decoration: InputDecoration(
              border: UnderlineInputBorder(),
              labelText: 'Catatan',
              labelStyle: TextStyle(fontSize: 14.0),
            ),
            style: TextStyle(
              fontStyle: FontStyle.normal,
              color: Colors.black87,
              fontSize: 14.0
            ),
            onSaved: null,
          ),
        ),
        Container(
          padding: const EdgeInsets.fromLTRB(12.0, 12.0, 12.0, 6.0),
          alignment: Alignment.center,
          child: Padding(
            padding: const EdgeInsets.only(left: 5.0),
            child: ButtonTheme(
              minWidth: 50.0,
              height: 30.0,
              child: OutlineButton(
                child: Text(
                  'SAVE',
                  style: TextStyle(
                    fontSize: 13.0,
                    color: Colors.green
                  ),
                ),
                borderSide: BorderSide(color: Colors.green, width: 1.0),
                highlightedBorderColor: Colors.green,
                onPressed: () {},
              ),
            ),
          )
        ),
      ],
    );
  }
}
