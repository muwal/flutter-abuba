import 'package:flutter/material.dart';
import 'package:flutter_abuba/constant.dart';
// import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
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
                  'Event(s)',
                  style:
                      TextStyle(color: AbubaPallate.greenabuba, fontSize: 12.0),
                ),
              ),
            ],
          ),
        ),
        _buildCustomForm(),
        SizedBox(height: 10.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
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
      ],
    );
  }

  Widget _buildCustomForm() {
    return Column(
      children: <Widget>[
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
                    'Jenis Acara',
                    style: TextStyle(
                      color: Colors.green,
                    ),
                  ),
                  Container(
                    width: 150.0,
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        isDense: true,
                        hint: Text('Jenis Acara'),
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
                            child: Text(map['jenis']),
                          );
                        }).toList(),
                      ),
                    ),
                  )
                ],
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                verticalDirection: VerticalDirection.up,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    'Pack',
                    style: TextStyle(color: Colors.green),
                  ),
                  Container(
                    width: 150.0,
                    child: TextField(
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        hintText: 'Pack',
                        hintStyle: TextStyle(fontSize: 12.0),
                      ),
                      style: TextStyle(
                        color: Colors.black,
                      ),
                    ),
                  )
                ],
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                verticalDirection: VerticalDirection.up,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    'Waktu',
                    style: TextStyle(color: Colors.green),
                  ),
                  Container(
                    width: 150.0,
                    padding: EdgeInsets.only(top: 5.0),
                    child: TimePickerFormField(
                      format: timeFormat,
                      onChanged: (t) => setState(() => time = t),
                      decoration: InputDecoration(
                        border: UnderlineInputBorder(),
                        hintText: 'Waktu',
                        hintStyle: TextStyle(fontSize: 12.0),
                      ),
                    ),
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
            ],
          ),
        ),
      ],
    );
  }
}
