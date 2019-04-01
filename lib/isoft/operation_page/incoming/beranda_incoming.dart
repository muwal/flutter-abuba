import 'package:flutter/material.dart';
import 'package:flutter_abuba/constant.dart';
import 'package:flutter_abuba/isoft/operation_page/incoming/form_inspection.dart';

class BerandaIncoming extends StatefulWidget {
  @override
  _BerandaIncomingState createState() => _BerandaIncomingState();
}

class _BerandaIncomingState extends State<BerandaIncoming> {
  List<Map> material = [
    {"resource": "1234567890", "material": "Daging Ayam", "supplier": "PT Abuba"},
    {"resource": "1234567891", "material": "Daging Sapi", "supplier": "PT Daging"},
    {"resource": "1234567892", "material": "Daging Kambing", "supplier": "PT Abuba"},
    {"resource": "1234567893", "material": "Telur", "supplier": "Peternakan Ayam Nasional"},
    {"resource": "1234567894", "material": "Tepung Terigu", "supplier": "PT Terigu"},
    {"resource": "1234567895", "material": "Gula Pasir", "supplier": "Gula Nasional"},
    {"resource": "1234567896", "material": "Kecap Manis", "supplier": "Bango"},
    {"resource": "1234567897", "material": "Wortel", "supplier": "PT Kebun"},
    {"resource": "1234567898", "material": "Kentang", "supplier": "PT Kebun"},
    {"resource": "1234567899", "material": "Garam", "supplier": "PT Laut"},
    {"resource": "1234567810", "material": "Jagung Manis Puncak", "supplier": "PT Kebun"}
  ];

  final recentMaterials = [
    {"resource": "1234567890", "material": "Daging Ayam", "supplier": "PT Abuba"},
    {"resource": "1234567891", "material": "Daging Sapi", "supplier": "PT Abuba"},
    {"resource": "1234567892", "material": "Daging Kambing", "supplier": "PT Abuba"}
  ];
  
  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;

    return SafeArea(
      child: Scaffold(
        appBar: _appBar(),
        body: _buildFormRisk(width),
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
                  'Operation Process',
                  style: TextStyle(color: Colors.black12, fontSize: 12.0),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 15.0),
                  child: Text(
                    '|',
                    style: TextStyle(
                        color: AbubaPallate.greenabuba, fontSize: 12.0),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 15.0),
                  child: Text(
                    'Incoming',
                    style: TextStyle(
                        color: AbubaPallate.greenabuba, fontSize: 12.0),
                  ),
                ),
              ],
            ),
          ),
          Container(
            color: Colors.white,
            width: width,
            height: MediaQuery.of(context).size.height / 1.2,
            child: Column(
              children: <Widget>[
                Flexible(
                  child: ListView.builder(
                    scrollDirection: Axis.vertical,
                    itemCount: material.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          index == 0
                            ? Padding(
                                padding: const EdgeInsets.fromLTRB(12.0, 12.0, 12.0, 0.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Container(
                                      width: width / 5,
                                      child: Row(
                                        children: <Widget>[
                                          Flexible(
                                            child: Text(
                                              'Resource #',
                                              style: TextStyle(color: Colors.green),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    Container(
                                      width: width / 5,
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: <Widget>[
                                          Flexible(
                                            child: Text(
                                              'Material',
                                              style: TextStyle(color: Colors.green),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    Container(
                                      width: width / 5,
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: <Widget>[
                                          Flexible(
                                            child: Text(
                                              'Supplier',
                                              style: TextStyle(color: Colors.green),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    Container(
                                      width: width / 5,
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.end,
                                        children: <Widget>[
                                          Flexible(
                                            child: Text(
                                              '',
                                              style: TextStyle(color: Colors.green),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            : Container(),
                          Padding(
                            padding: index == material.length - 1 ? const EdgeInsets.fromLTRB(12.0, 6.0, 12.0, 12.0) : const EdgeInsets.fromLTRB(12.0, 6.0, 12.0, 0.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Container(
                                  width: width / 5,
                                  child: Row(
                                    children: <Widget>[
                                      Flexible(
                                        child: Text(
                                          material[index]['resource'],
                                          style: TextStyle(
                                              fontSize: 12.0, color: Colors.black38),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                Container(
                                  width: width / 5,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: <Widget>[
                                      Flexible(
                                        child: Text(
                                          material[index]['material'],
                                          style: TextStyle(
                                              fontSize: 12.0, color: Colors.black38),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                Container(
                                  width: width / 5,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: <Widget>[
                                      Flexible(
                                        child: Text(
                                          material[index]['supplier'],
                                          style: TextStyle(
                                              fontSize: 12.0, color: Colors.black38),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                Container(
                                  width: width / 5,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: <Widget>[
                                      Flexible(
                                        child: ButtonTheme(
                                          minWidth: 50.0,
                                          height: 30.0,
                                          splashColor: AbubaPallate.menuBluebird,
                                          child: OutlineButton(
                                            borderSide: BorderSide(
                                                color: AbubaPallate.menuBluebird),
                                            child: Text(
                                              'View',
                                              style: TextStyle(
                                                  fontSize: 12.0,
                                                  color: AbubaPallate.menuBluebird),
                                              textAlign: TextAlign.center,
                                            ),
                                            onPressed: () {
                                              Navigator.push(context,
                                                  MyCustomRoute(
                                                      builder: (context) => Inspection(material: material[index]['material'])
                                                  )
                                              );
                                            },
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          )
                        ],
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
  
  Widget _appBar() {
    return AppBar(
      elevation: 0.25,
      backgroundColor: Colors.white,
      iconTheme: IconThemeData(color: Colors.black),
      actions: <Widget>[
        IconButton(
          tooltip: 'Search',
          icon: Icon(Icons.search),
          onPressed: () {}
        )
      ],
      title: Image.asset(
        'assets/images/logo2.png',
        height: 150.0,
        width: 120.0,
      ),
    );
  }
}