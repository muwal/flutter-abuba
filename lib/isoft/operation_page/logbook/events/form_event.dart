import 'package:flutter/material.dart';
import 'package:flutter_abuba/constant.dart';
import 'package:flutter_abuba/beranda/beranda_appbardua.dart';
import 'package:datetime_picker_formfield/time_picker_formfield.dart';
import 'package:intl/intl.dart';

class FormEvent extends StatefulWidget {
  @override
  _FormEventState createState() => _FormEventState();
}

class _FormEventState extends State<FormEvent> {
  String _mySelection;
  String _jenisAcara;
  List<Map> _jenisAcaraJson = [
    {"id": 1, "jenis": "Pernikahan"},
    {"id": 2, "jenis": "Ulang tahun"}
  ];

  final timeFormat = DateFormat("h:mm a");
  TimeOfDay time;

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
                  'Event(s)',
                  style:
                      TextStyle(color: AbubaPallate.greenabuba, fontSize: 12.0),
                ),
              ),
            ],
          ),
        ),
        _buildCustomForm(width),
        SizedBox(height: 10.0),
        Container(
          padding: const EdgeInsets.fromLTRB(12.0, 12.0, 12.0, 6.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(right: 5.0),
                child: IconButton(
                  icon: Icon(
                    Icons.add_circle,
                    color: Colors.green,
                    size: 30.0,
                  ),
                  onPressed: () {},
                ),
              ),
              Padding(
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
            ],
          )
        ),
      ],
    );
  }

  Widget _buildCustomForm(double width) {
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(top: 10.0, left: 20.0, right: 20.0),
          child: DropdownButtonFormField(
            decoration: InputDecoration(
              border: UnderlineInputBorder(),
              labelText: 'Jenis Acara',
              labelStyle: TextStyle(fontSize: 14.0),
            ),
            value: _mySelection,
            onChanged: (String newValue) {
              setState(() {
                switch (int.tryParse(newValue)) {
                  case 1:
                    _jenisAcara = 'Pernikahan';
                    break;
                  case 2:
                    _jenisAcara = 'Ulang tahun';
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
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                width: width / 2.5,
                child: TextFormField(
                  textCapitalization: TextCapitalization.words,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    border: UnderlineInputBorder(),
                    labelText: 'Pack',
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
                width: width / 2.5,
                child: TimePickerFormField(
                  format: timeFormat,
                  onChanged: (t) => setState(() => time = t),
                  decoration: InputDecoration(
                    border: UnderlineInputBorder(),
                    hintText: 'Waktu',
                    hintStyle: TextStyle(fontSize: 12.0),
                  ),
                ),
              )
            ],
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
      ],
    );
  }
}
