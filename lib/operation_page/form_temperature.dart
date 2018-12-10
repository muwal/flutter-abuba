import 'package:flutter/material.dart';
import 'package:flutter_abuba/constant.dart';
import 'package:flutter_abuba/beranda/beranda_appbardua.dart';

import 'package:datetime_picker_formfield/time_picker_formfield.dart';
import 'package:intl/intl.dart';

class FormTemperature extends StatefulWidget {
  FormTemperature({this.material});

  final String material;

  @override
  _FormTemperatureState createState() => _FormTemperatureState();
}

class _FormTemperatureState extends State<FormTemperature> {
  Color colorYesWaktu = Colors.green;
  Color colorNoWaktu = Colors.grey;

  Color colorYesJumlah = Colors.green;
  Color colorNoJumlah = Colors.grey;

  final timeFormat = DateFormat("h:mm a");
  TimeOfDay time;

  FocusNode _focusNode = new FocusNode();

  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomPadding: false,
        appBar: AbubaAppBar(),
        body: GestureDetector(
            onTap: () {
              FocusScope.of(context).requestFocus(FocusNode());
            },
            child: _buildFormInspection()),
      ),
    );
  }

  Widget _buildFormInspection() {
    return ListView(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Text(
                'Operational Process',
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
                  'Temperature',
                  style:
                  TextStyle(color: AbubaPallate.greenabuba, fontSize: 12.0),
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5.0),
          child: Column(
            children: <Widget>[
              ListTile(
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Expanded(
                      child: Text(
                        'Chiller 2',
                        style: TextStyle(color: Colors.grey, fontSize: 13.0),
                        overflow: TextOverflow.clip,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          width: 120.0,
                          child: TextField(
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                                hintText: 'Type here',
                                hintStyle: TextStyle(fontSize: 12.0)),
                            style: TextStyle(
                              color: Colors.black,
                            ),
                          ),
                        ),
                        IconButton(icon: Icon(Icons.help_outline), onPressed: null)
                      ],
                    )
                  ],
                ),
              ),
              ListTile(
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Expanded(
                      child: Text(
                        'Chiller 1',
                        style: TextStyle(color: Colors.grey, fontSize: 13.0),
                        overflow: TextOverflow.clip,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          width: 120.0,
                          child: TextField(
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                                hintText: 'Type here',
                                hintStyle: TextStyle(fontSize: 12.0)),
                            style: TextStyle(
                              color: Colors.black,
                            ),
                          ),
                        ),
                        IconButton(icon: Icon(Icons.help_outline), onPressed: null)
                      ],
                    )
                  ],
                ),
              ),
              ListTile(
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Expanded(
                      child: Text(
                        'Chiller 3',
                        style: TextStyle(color: Colors.grey, fontSize: 13.0),
                        overflow: TextOverflow.clip,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          width: 120.0,
                          child: TextField(
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                                hintText: 'Type here',
                                hintStyle: TextStyle(fontSize: 12.0)),
                            style: TextStyle(
                              color: Colors.black,
                            ),
                          ),
                        ),
                        IconButton(icon: Icon(Icons.help_outline), onPressed: null)
                      ],
                    )
                  ],
                ),
              ),
              ListTile(
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Expanded(
                      child: Text(
                        'Refrigerator 1',
                        style: TextStyle(color: Colors.grey, fontSize: 13.0),
                        overflow: TextOverflow.clip,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          width: 120.0,
                          child: TextField(
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                                hintText: 'Type here',
                                hintStyle: TextStyle(fontSize: 12.0)),
                            style: TextStyle(
                              color: Colors.black,
                            ),
                          ),
                        ),
                        IconButton(icon: Icon(Icons.help_outline), onPressed: null)
                      ],
                    )
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(right: 10.0),
                    child: ButtonTheme(
                      minWidth: 50.0,
                      height: 30.0,
                      child: OutlineButton(
                        child: Text(
                          'EDIT',
                          style: TextStyle(fontSize: 13.0),
                        ),
                        textColor: AbubaPallate.menuBluebird,
                        borderSide: BorderSide(color: AbubaPallate.menuBluebird),
                        onPressed: () {},
                      ),
                    ),
                  ),
                  ButtonTheme(
                    minWidth: 50.0,
                    height: 30.0,
                    child: OutlineButton(
                      child: Text(
                        'SAVE',
                        style: TextStyle(fontSize: 13.0),
                      ),
                      textColor: Colors.green,
                      borderSide: BorderSide(color: AbubaPallate.greenabuba),
                      onPressed: () {},
                    ),
                  ),

                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
