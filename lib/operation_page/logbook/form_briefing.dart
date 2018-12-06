import 'package:flutter/material.dart';
import 'package:flutter_abuba/constant.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
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
                    child: Radio(value: 0, groupValue: null, onChanged: null),
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
                    child: Radio(value: 0, groupValue: null, onChanged: null),
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
                    child: Radio(value: 0, groupValue: null, onChanged: null),
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
                    child: Radio(value: 0, groupValue: null, onChanged: null),
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
                    child: Radio(value: 0, groupValue: null, onChanged: null),
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
                    child: Radio(value: 0, groupValue: null, onChanged: null),
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
                    onPressed: () {},
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
                    width: 300.0,
                    child: TextField(
                      decoration:
                          InputDecoration(border: OutlineInputBorder()),
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
