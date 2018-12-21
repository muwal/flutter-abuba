import 'package:flutter/material.dart';
import 'package:flutter_abuba/constant.dart';
import 'package:flutter_abuba/beranda/beranda_appbardua.dart';

class FormTemperature extends StatefulWidget {
  FormTemperature({this.material});

  final String material;

  @override
  _FormTemperatureState createState() => _FormTemperatureState();
}

class _FormTemperatureState extends State<FormTemperature> {
  FocusNode _focusNode = new FocusNode();

  double _sliderValueChiller1 = 0.0;
  double _sliderValueChiller2 = 0.0;
  double _sliderValueChiller3 = 0.0;
  double _sliderValueKulkas = 0.0;

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
                        'Chiller 1',
                        style: TextStyle(color: Colors.grey, fontSize: 13.0),
                        overflow: TextOverflow.clip,
                      ),
                    ),
                    Container(
                      width: 180.0,
                      child: Slider(
                        value: _sliderValueChiller1,
                        min: -10.0,
                        max: 10.0,
                        divisions: 100,
                        label: '${_sliderValueChiller1.round()}',
                        onChanged: (double value) {
                          setState(() => _sliderValueChiller1 = value);
                        },
                      )
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
                        'Chiller 2',
                        style: TextStyle(color: Colors.grey, fontSize: 13.0),
                        overflow: TextOverflow.clip,
                      ),
                    ),
                    Container(
                      width: 180.0,
                      child: Slider(
                        value: _sliderValueChiller2,
                        min: -10.0,
                        max: 10.0,
                        divisions: 100,
                        label: '${_sliderValueChiller2.round()}',
                        onChanged: (double value) {
                          setState(() => _sliderValueChiller2 = value);
                        },
                      )
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
                    Container(
                      width: 180.0,
                      child: Slider(
                        value: _sliderValueChiller3,
                        min: -10.0,
                        max: 10.0,
                        divisions: 100,
                        label: '${_sliderValueChiller3.round()}',
                        onChanged: (double value) {
                          setState(() => _sliderValueChiller3 = value);
                        },
                      )
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
                    Container(
                      width: 180.0,
                      child: Slider(
                        value: _sliderValueKulkas,
                        min: -10.0,
                        max: 10.0,
                        divisions: 100,
                        label: '${_sliderValueKulkas.round()}',
                        onChanged: (double value) {
                          setState(() => _sliderValueKulkas = value);
                        },
                      )
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
