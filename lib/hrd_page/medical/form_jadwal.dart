import 'package:flutter/material.dart';
import 'package:flutter_abuba/constant.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:flutter_abuba/beranda/beranda_appbardua.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:intl/intl.dart';

class FormJadwal extends StatefulWidget {
  @override
  _FormJadwalState createState() => _FormJadwalState();
}

class _FormJadwalState extends State<FormJadwal> {
  final _scaffoldState = GlobalKey<ScaffoldState>();

  final dateFormat = DateFormat("MMMM d, yyyy");
  DateTime dateStart;
  DateTime dateEnd;
  DateTime dateSchedule;

  String _mySelection;
  String _jenisAcara;
  List<Map> _jenisAcaraJson = [
    {"id": 1, "jenis": "One"},
    {"id": 2, "jenis": "Two"}
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        key: _scaffoldState,
        appBar: AbubaAppBar(),
        body: GestureDetector(
          onTap: () {
            FocusScope.of(context).requestFocus(FocusNode());
          },
          child: _buildLogMenu(),
        ),
      ),
    );
  }

  Widget _buildLogMenu() {
    return ListView(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Text(
                'Medical',
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
                  'Jadwal',
                  style:
                      TextStyle(color: AbubaPallate.greenabuba, fontSize: 12.0),
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 0.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Flexible(child: Text('Waktu'))
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 0.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                width: 150.0,
                child: DateTimePickerFormField(
                  format: dateFormat,
                  onChanged: (dt) => setState(() => dateStart = dt),
                  dateOnly: true,
                  style: TextStyle(fontSize: 14.0, color: Colors.black),
                  decoration: InputDecoration(
                      border: UnderlineInputBorder(),
                      labelStyle: TextStyle(fontSize: 12.0),
                      labelText: 'Start'),
                ),
              ),
              Container(
                width: 150.0,
                child: DateTimePickerFormField(
                  format: dateFormat,
                  onChanged: (dt) => setState(() => dateStart = dt),
                  dateOnly: true,
                  style: TextStyle(fontSize: 14.0, color: Colors.black),
                  decoration: InputDecoration(
                      border: UnderlineInputBorder(),
                      labelStyle: TextStyle(fontSize: 12.0),
                      labelText: 'End'),
                ),
              )
            ],
          )
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(20.0, 5.0, 20.0, 0.0),
          child: Container(
            width: MediaQuery.of(context).size.width,
            child: DropdownButtonFormField<String>(
              hint: Text(
                'Vendor',
                style: TextStyle(fontSize: 12.0),
              ),
              value: _mySelection,
              onChanged: (String newValue) {
                setState(() {
                  switch (int.tryParse(newValue)) {
                    case 1:
                      _jenisAcara = 'Vendor 1';
                      break;
                    case 2:
                      _jenisAcara = 'Vendor 2';
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
          child: TextField(
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              labelText: 'Jumlah Peserta',
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
                'Parameter',
                style: TextStyle(fontSize: 12.0),
              ),
              value: _mySelection,
              onChanged: (String newValue) {
                setState(() {
                  switch (int.tryParse(newValue)) {
                    case 1:
                      _jenisAcara = 'Vendor 1';
                      break;
                    case 2:
                      _jenisAcara = 'Vendor 2';
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
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Padding(
              padding:
              const EdgeInsets.only(top: 10.0, right: 20.0),
              child: ButtonTheme(
                minWidth: 50.0,
                height: 30.0,
                child: OutlineButton(
                  child: Text(
                    'SAVE',
                    style: TextStyle(
                        fontSize: 13.0, color: AbubaPallate.greenabuba),
                  ),
                  borderSide:
                  BorderSide(color: AbubaPallate.greenabuba, width: 1.0),
                  highlightedBorderColor: AbubaPallate.greenabuba,
                  onPressed: () {},
                ),
              ),
            ),
          ],
        )
      ],
    );
  }
}
