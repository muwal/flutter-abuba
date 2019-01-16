import 'package:flutter/material.dart';
import 'package:flutter_abuba/constant.dart';
import 'package:flutter_abuba/beranda/beranda_appbardua.dart';

// import 'package:datetime_picker_formfield/time_picker_formfield.dart';
import 'package:intl/intl.dart';

class Inspection extends StatefulWidget {
  Inspection({this.material});

  final String material;

  @override
  _InspectionState createState() => _InspectionState();
}

class _InspectionState extends State<Inspection> {
  Color colorYesWaktu = Colors.green;
  Color colorNoWaktu = Colors.grey;

  Color colorYesJumlah = Colors.green;
  Color colorNoJumlah = Colors.grey;

  final timeFormat = DateFormat("h:mm a");
  TimeOfDay time;

  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
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
                'Kitchen',
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
                  'Inspection',
                  style:
                      TextStyle(color: AbubaPallate.greenabuba, fontSize: 12.0),
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[Text('Widget')],
          ),
        ),
        SizedBox(
          height: 15.0,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            children: <Widget>[
              SizedBox(
                width: MediaQuery.of(context).size.width,
                height: 42.0,
                child: Container(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            'Parameter Atribut',
                            style:
                                TextStyle(color: Colors.white, fontSize: 14.0),
                            textAlign: TextAlign.start,
                          ),
                        ],
                      ),
                    ),
                    decoration: BoxDecoration(color: Color(0xFF2F592F))),
              ),
              ListTile(
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Flexible(
                      child: Text(
                        'Presentasi',
                        style: TextStyle(color: Colors.grey, fontSize: 13.0),
                        overflow: TextOverflow.clip,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.all(5.0),
                          child: ButtonTheme(
                            minWidth: 40.0,
                            height: 30.0,
                            child: OutlineButton(
                              child: Icon(Icons.close, color: colorNoWaktu, size: 14.0),
                              borderSide:
                                  BorderSide(color: colorNoWaktu, width: 1.0),
                              highlightedBorderColor: colorNoWaktu,
                              onPressed: () {
                                setState(() {
                                  colorYesWaktu = Colors.grey;
                                  colorNoWaktu = Colors.red;
                                });
                              },
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(5.0),
                          child: ButtonTheme(
                            minWidth: 40.0,
                            height: 30.0,
                            child: OutlineButton(
                              child: Icon(Icons.check, color: colorYesWaktu, size: 14.0),
                              borderSide:
                                  BorderSide(color: colorYesWaktu, width: 1.0),
                              highlightedBorderColor: colorYesWaktu,
                              onPressed: () {
                                setState(() {
                                  colorYesWaktu = Colors.green;
                                  colorNoWaktu = Colors.grey;
                                });
                              },
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
                    Flexible(
                      child: Text(
                        'Kebersihan',
                        style: TextStyle(color: Colors.grey, fontSize: 13.0),
                        overflow: TextOverflow.clip,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.all(5.0),
                          child: ButtonTheme(
                            minWidth: 40.0,
                            height: 30.0,
                            child: OutlineButton(
                              child: Icon(Icons.close, color: colorNoJumlah, size: 14.0),
                              borderSide:
                                  BorderSide(color: colorNoJumlah, width: 1.0),
                              highlightedBorderColor: colorNoJumlah,
                              onPressed: () {
                                setState(() {
                                  colorYesJumlah = Colors.grey;
                                  colorNoJumlah = Colors.red;
                                });
                              },
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(5.0),
                          child: ButtonTheme(
                            minWidth: 40.0,
                            height: 30.0,
                            child: OutlineButton(
                              child: Icon(Icons.check, color: colorYesJumlah, size: 14.0),
                              borderSide:
                                  BorderSide(color: colorYesJumlah, width: 1.0),
                              highlightedBorderColor: colorYesJumlah,
                              onPressed: () {
                                setState(() {
                                  colorYesJumlah = Colors.green;
                                  colorNoJumlah = Colors.grey;
                                });
                              },
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
                    Flexible(
                      child: Text(
                        'Kematangan',
                        style: TextStyle(color: Colors.grey, fontSize: 13.0),
                        overflow: TextOverflow.clip,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.all(5.0),
                          child: ButtonTheme(
                            minWidth: 40.0,
                            height: 30.0,
                            child: OutlineButton(
                              child: Icon(Icons.close, color: colorNoWaktu, size: 14.0),
                              borderSide:
                              BorderSide(color: colorNoWaktu, width: 1.0),
                              highlightedBorderColor: colorNoWaktu,
                              onPressed: () {
                                setState(() {
                                  colorYesWaktu = Colors.grey;
                                  colorNoWaktu = Colors.red;
                                });
                              },
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(5.0),
                          child: ButtonTheme(
                            minWidth: 40.0,
                            height: 30.0,
                            child: OutlineButton(
                              child: Icon(Icons.check, color: colorYesWaktu, size: 14.0),
                              borderSide:
                              BorderSide(color: colorYesWaktu, width: 1.0),
                              highlightedBorderColor: colorYesWaktu,
                              onPressed: () {
                                setState(() {
                                  colorYesWaktu = Colors.green;
                                  colorNoWaktu = Colors.grey;
                                });
                              },
                            ),
                          ),
                        ),
                        IconButton(icon: Icon(Icons.help_outline), onPressed: null)
                      ],
                    )
                  ],
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                height: 42.0,
                child: Container(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            'Parameter Variabel',
                            style:
                                TextStyle(color: Colors.white, fontSize: 14.0),
                            textAlign: TextAlign.start,
                          ),
                        ],
                      ),
                    ),
                    decoration: BoxDecoration(color: Color(0xFF2F592F))),
              ),
              ListTile(
                title: Container(
                  width: MediaQuery.of(context).size.width / 1.5,
                  child: TextFormField(
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                        hintText: 'Suhu',
                        hintStyle: TextStyle(fontSize: 12.0)),
                    style: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                ),
                trailing: IconButton(icon: Icon(Icons.help_outline), onPressed: null),
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
