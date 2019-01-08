import 'package:flutter/material.dart';
import 'package:flutter_abuba/constant.dart';
import 'package:flutter_abuba/beranda/beranda_appbardua.dart';

class FormPerformance extends StatefulWidget {
  @override
  _FormPerformanceState createState() => _FormPerformanceState();
}

class _FormPerformanceState extends State<FormPerformance> {
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
    return Scrollbar(
      child: ListView(
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
                    'Performance',
                    style:
                        TextStyle(color: AbubaPallate.greenabuba, fontSize: 12.0),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10.0, left: 20.0, right: 20.0),
            child: TextFormField(
              textCapitalization: TextCapitalization.words,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                border: UnderlineInputBorder(),
                labelText: 'Sales per-shift',
                prefixText: 'Rp ',
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
          Padding(
            padding: const EdgeInsets.only(top: 10.0, left: 20.0, right: 20.0),
            child: TextFormField(
              textCapitalization: TextCapitalization.words,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                border: UnderlineInputBorder(),
                labelText: 'Customer',
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
          Padding(
            padding: const EdgeInsets.only(top: 10.0, left: 20.0, right: 20.0),
            child: TextFormField(
              textCapitalization: TextCapitalization.words,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                border: UnderlineInputBorder(),
                labelText: 'Average Check',
                prefixText: 'Rp ',
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
          Padding(
            padding: const EdgeInsets.only(top: 10.0, left: 20.0, right: 20.0),
            child: TextFormField(
              textCapitalization: TextCapitalization.words,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                border: UnderlineInputBorder(),
                labelText: 'Target Sales',
                prefixText: 'Rp ',
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
          Padding(
            padding: const EdgeInsets.only(top: 10.0, left: 20.0, right: 20.0),
            child: TextFormField(
              textCapitalization: TextCapitalization.words,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                border: UnderlineInputBorder(),
                labelText: 'Hand Over Sales',
                prefixText: 'Rp ',
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
          Padding(
            padding: const EdgeInsets.only(top: 10.0, left: 20.0, right: 20.0),
            child: TextFormField(
              textCapitalization: TextCapitalization.words,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                border: UnderlineInputBorder(),
                labelText: 'Sales Bulanan',
                prefixText: 'Rp ',
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
      ),
    );
  }
}
