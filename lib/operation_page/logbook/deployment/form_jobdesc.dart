import 'package:flutter/material.dart';
import 'package:flutter_abuba/constant.dart';
// import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:flutter_abuba/beranda/beranda_appbardua.dart';

class FormJobdesc extends StatefulWidget {
  @override
  _FormJobdescState createState() => _FormJobdescState();
}

class _FormJobdescState extends State<FormJobdesc> {
  TextEditingController controller = new TextEditingController();
  List<String> textList = [];

  Color _opening = Colors.green;
  Color _middle = Colors.grey;
  Color _closing = Colors.grey;

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
        Container(
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.only(right: 20.0, left: 20.0, bottom: 5.0, top: 20.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              GestureDetector(
                onTap: () {
                  setState(() {
                    _opening = Colors.green;
                    _middle = Colors.grey;
                    _closing = Colors.grey;
                  });
                },
                child: Container(
                  width: width / 4,
                  child: Column(
                    children: <Widget>[
                      Text(
                        'OPENING',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: _opening
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5.0),
                        child: Divider(
                          height: 10.0,
                          color: _opening,
                        ),
                      )
                    ],
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    _opening = Colors.grey;
                    _middle = Colors.green;
                    _closing = Colors.grey;
                  });
                },
                child: Container(
                  width: width / 4,
                  child: Column(
                    children: <Widget>[
                      Text(
                        'MIDDLE',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: _middle
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5.0),
                        child: Divider(
                          height: 10.0,
                          color: _middle,
                        ),
                      )
                    ],
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    _opening = Colors.grey;
                    _middle = Colors.grey;
                    _closing = Colors.green;
                  });
                },
                child: Container(
                  width: width / 4,
                  child: Column(
                    children: <Widget>[
                      Text(
                        'CLOSING',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: _closing
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5.0),
                        child: Divider(
                          height: 10.0,
                          color: _closing,
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          )
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
                    labelText: 'Cashier',
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
                child: TextFormField(
                  textCapitalization: TextCapitalization.words,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    border: UnderlineInputBorder(),
                    labelText: 'Section 1',
                    labelStyle: TextStyle(fontSize: 14.0),
                  ),
                  style: TextStyle(
                    fontStyle: FontStyle.normal,
                    color: Colors.black87,
                    fontSize: 14.0
                  ),
                  onSaved: null,
                ),
              )
            ],
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
                    labelText: 'Bar Tender',
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
                child: TextFormField(
                  textCapitalization: TextCapitalization.words,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    border: UnderlineInputBorder(),
                    labelText: 'Runner',
                    labelStyle: TextStyle(fontSize: 14.0),
                  ),
                  style: TextStyle(
                    fontStyle: FontStyle.normal,
                    color: Colors.black87,
                    fontSize: 14.0
                  ),
                  onSaved: null,
                ),
              )
            ],
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
                    labelText: 'Steaward',
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
                child: TextFormField(
                  textCapitalization: TextCapitalization.words,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    border: UnderlineInputBorder(),
                    labelText: 'Kitchen - Grill',
                    labelStyle: TextStyle(fontSize: 14.0),
                  ),
                  style: TextStyle(
                    fontStyle: FontStyle.normal,
                    color: Colors.black87,
                    fontSize: 14.0
                  ),
                  onSaved: null,
                ),
              )
            ],
          ),
        ),
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
                padding: const EdgeInsets.only(left: 5.0, right: 5.0),
                child: ButtonTheme(
                  minWidth: 50.0,
                  height: 30.0,
                  child: OutlineButton(
                    child: Text(
                      'EDIT',
                      style: TextStyle(
                        fontSize: 13.0,
                        color: AbubaPallate.menuBluebird
                      ),
                    ),
                    borderSide: BorderSide(color: AbubaPallate.menuBluebird, width: 1.0),
                    highlightedBorderColor: AbubaPallate.menuBluebird,
                    onPressed: () {},
                  ),
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
}
