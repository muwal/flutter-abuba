import 'package:flutter/material.dart';
import 'package:flutter_abuba/constant.dart';
// import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:flutter_abuba/beranda/beranda_appbardua.dart';

class FormBriefing extends StatefulWidget {
  @override
  _FormBriefingState createState() => _FormBriefingState();
}

class _FormBriefingState extends State<FormBriefing> {
  TextEditingController controller = new TextEditingController();
  List<String> textList = [
    'Menu Baru',
    'Event',
    'Upselling',
    'Hasil Audit',
    'Pengumuman'
  ];

  bool _note = false;
  String _briefing;
  void _pilihBriefing(String value) {
    setState(() {
      _briefing = value;      
    });
  }

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
                  'Briefing',
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
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    'Menu Baru',
                    style: TextStyle(
                      color: Colors.green,
                    ),
                  ),
                  Container(
                    width: 150.0,
                    child: Radio(value: 'Menu Baru', groupValue: _briefing, onChanged: (String value) {_pilihBriefing(value); }),
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    'Menu Baru',
                    style: TextStyle(
                      color: Colors.green,
                    ),
                  ),
                  Container(
                    width: 150.0,
                    child: Radio(value: 'Menu Baru 2', groupValue: _briefing, onChanged: (String value) {_pilihBriefing(value);}),
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    'Event',
                    style: TextStyle(
                      color: Colors.green,
                    ),
                  ),
                  Container(
                    width: 150.0,
                    child: Radio(value: 'Event', groupValue: _briefing, onChanged: (String value) {_pilihBriefing(value);}),
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    'Upselling',
                    style: TextStyle(
                      color: Colors.green,
                    ),
                  ),
                  Container(
                    width: 150.0,
                    child: Radio(value: 'Upselling', groupValue: _briefing, onChanged: (String value) {_pilihBriefing(value);}),
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    'Hasil Audit',
                    style: TextStyle(
                      color: Colors.green,
                    ),
                  ),
                  Container(
                    width: 150.0,
                    child: Radio(value: 'Hasil Audit', groupValue: _briefing, onChanged: (String value) {_pilihBriefing(value);}),
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    'Pengumuman',
                    style: TextStyle(
                      color: Colors.green,
                    ),
                  ),
                  Container(
                    width: 150.0,
                    child: Radio(value: 'Pengumuman', groupValue: _briefing, onChanged: (String value) {_pilihBriefing(value);}),
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  IconButton(
                    icon: Icon(
                      Icons.add_circle,
                      color: Colors.green,
                      size: 30.0,
                    ),
                    onPressed: () {

                    },
                  ),
                ],
              ),
              SizedBox(
                height: 15.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  ButtonTheme(
                    minWidth: 50.0,
                    height: 30.0,
                    child: RaisedButton(
                      color: AbubaPallate.menuBluebird,
                      child: Text(
                        'Note',
                        style: TextStyle(fontSize: 13.0, color: Colors.white),
                      ),
                      onPressed: () {
                        setState(() {
                          _note = !_note;
                        });
                      },
                    ),
                  ),
                  Padding(padding: EdgeInsets.symmetric(horizontal: 10.0),),
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
                      onPressed: () {

                      },
                    ),
                  ),
                ],
              ),

              _note
                  ? Container(
                    padding: EdgeInsets.only(bottom: 10.0),
                    width: 300.0,
                    child: TextField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Note',
                        hintStyle: TextStyle(fontSize: 12.0),
                      ),
                      maxLines: 3,
                      style: TextStyle(
                        color: Colors.black,
                      ),
                    ),
                  )
                  : Container()
            ],
          ),
        ),
      ],
    );
  }
}
