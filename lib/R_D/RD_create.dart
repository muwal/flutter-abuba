import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_abuba/beranda/beranda_appbardua.dart';
import 'package:flutter_abuba/constant.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:intl/intl.dart';

class RDcreate extends StatefulWidget {
  RDcreate({Key key}) : super(key: key);

  _RDcreateState createState() => _RDcreateState();
}

class _RDcreateState extends State<RDcreate>{
  final dateFormat = DateFormat("MMMM d, yyyy");
  DateTime dateEksperimen;

  String _selectionCategoryEksperimen;
  String _categoryEksperimen;
  List<Map> _categoryEksperimenJSON = [
    {"id":1, "categoryEksperimen":"NPD"},
    {"id":2, "categoryEksperimen":"Alternative Material"},
    {"id":3, "categoryEksperimen":"Cost Saving"},
  ];

  String _selectionPIC;
  String _pic;
  List<Map> _picJSON = [
    {"id":1, "pic":"Ironman"},
    {"id":2, "pic":"Spiderman"},
  ];

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;

    return SafeArea(
      child: Scaffold(
        appBar: AbubaAppBar(),
        body: _buildFormRisk(width)
      ),
    );
  }

  Widget _buildFormRisk(double width) {
    return Scrollbar(
      child: ListView(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Text(
                  'R&D',
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
                    'Create',
                    style:
                        TextStyle(color: AbubaPallate.greenabuba, fontSize: 12.0),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 0.0, right: 20.0, left: 20.0),
            child: TextFormField(
              textCapitalization:
              TextCapitalization.words,
              decoration: InputDecoration(
                border: UnderlineInputBorder(),
                labelText: 'Nama Produk',
                labelStyle: TextStyle(fontSize: 14.0),
              ),
              style: TextStyle(
                  fontStyle: FontStyle.normal,
                  color: Colors.black87,
                  fontSize: 14.0),
              onSaved: null,
            ),
          ),
          Padding(
            padding:
            const EdgeInsets.only(top: 20.0, right: 20.0, left: 20.0),
            child: Row(
              mainAxisAlignment:
              MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                  width: 250,
                  child: TextFormField(
                    textCapitalization:
                    TextCapitalization.words,
                    decoration: InputDecoration(
                      border:
                      UnderlineInputBorder(),
                      labelText: 'Komposisi',
                      labelStyle:
                      TextStyle(fontSize: 14.0),
                      hintText: 'Komposisi',
                    ),
                    style: TextStyle(
                        fontStyle: FontStyle.normal,
                        color: Colors.black87,
                        fontSize: 14.0),
                    onSaved: null,
                  ),
                ),
                Container(
                    width: 50.0,
                    child: IconButton(
                      icon: Icon(Icons.add),
                      color: Colors.blue,
                      onPressed: () {},
                    ))
              ],
            )
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20.0, right: 20.0, left: 20.0),
            child: DateTimePickerFormField(
              format: dateFormat,
              onChanged: (dt) => setState(() => dateEksperimen = dt),
              dateOnly: true,
              style: TextStyle(fontSize: 16.0, color: Colors.black),
              decoration: InputDecoration(
                border: UnderlineInputBorder(),
                labelStyle: TextStyle(fontSize: 14.0),
                labelText: 'Date Experiment'
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10.0, right: 20.0, left: 20.0),
            child: DropdownButtonFormField<String>(
              decoration: InputDecoration(
                labelText: 'Category Experiment',
                labelStyle: TextStyle(fontSize: 14.0),
              ),
              value: _selectionCategoryEksperimen,
              onChanged: (String value) {
                setState(() {
                  switch (int.tryParse(value)) {
                    case 1:
                      _categoryEksperimen = 'NPD';
                      break;
                    case 2:
                      _categoryEksperimen = 'Alternative Material';
                      break;
                    case 3:
                      _categoryEksperimen = 'Cost Saving';
                      break;
                    default:
                      _categoryEksperimen = '-';
                      break;
                  }
                  _selectionCategoryEksperimen = value;
                });
              },
              items: _categoryEksperimenJSON.map((Map map) {
                return DropdownMenuItem(
                  value: map['id'].toString(),
                  child: Text(map['categoryEksperimen']),
                );
              }).toList(),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10.0, right: 20.0, left: 20.0),
            child: TextFormField(
              textCapitalization:
              TextCapitalization.words,
              decoration: InputDecoration(
                border: UnderlineInputBorder(),
                labelText: 'Tujuan Experiment',
                labelStyle: TextStyle(fontSize: 14.0),
              ),
              style: TextStyle(
                  fontStyle: FontStyle.normal,
                  color: Colors.black87,
                  fontSize: 14.0),
              onSaved: null,
            ),
          ),
          Padding(
            padding:
            const EdgeInsets.only(top: 10.0, right: 20.0, left: 20.0),
            child: Row(
              mainAxisAlignment:
              MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                  width: 250,
                  child: DropdownButtonFormField<
                      String>(
                    decoration: InputDecoration(
                      labelText: 'Kirim Kepada',
                      labelStyle:
                      TextStyle(fontSize: 14.0),
                    ),
                    value: _selectionPIC,
                    onChanged: (String value) {
                      setState(() {
                        switch (
                        int.tryParse(value)) {
                          case 1:
                            _pic = 'Ironman';
                            break;
                          case 2:
                            _pic = 'Spiderman';
                            break;
                          default:
                            _pic = '-';
                            break;
                        }
                        _selectionPIC = value;
                      });
                    },
                    items: _picJSON.map((Map map) {
                      return DropdownMenuItem(
                        value: map['id'].toString(),
                        child: Text(map['pic']),
                      );
                    }).toList(),
                  ),
                ),
                Container(
                  width: 50.0,
                  child: IconButton(
                    icon: Icon(Icons.add),
                    color: Colors.blue,
                    onPressed: () {},
                  )
                )
              ],
            )
          ),
          Padding(
            padding: EdgeInsets.only(top: 20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                ButtonTheme(
                  height: 30.0,
                  child: OutlineButton(
                    child: Text(
                      'SEND',
                      style: TextStyle(
                        color: Colors.green),
                    ),
                    borderSide: BorderSide(
                      color: Colors.green,
                      width: 1.0),
                    highlightedBorderColor: Colors.green,
                    onPressed: () {},
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}