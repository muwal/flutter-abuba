import 'package:flutter/material.dart';
import 'package:flutter_abuba/constant.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:flutter_abuba/beranda/beranda_appbardua.dart';

import 'purchasing/beranda_purchasing.dart';

class BerandaFinance extends StatefulWidget {
  @override
  _BerandaFinanceState createState() => _BerandaFinanceState();
}

class _BerandaFinanceState extends State<BerandaFinance> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AbubaAppBar(),
        body: _buildIsoMenu(),
      ),
    );
  }

  Widget _buildIsoMenu() {
    return ListView(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Text(
                'Home',
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
                  'Finance',
                  style:
                      TextStyle(color: AbubaPallate.greenabuba, fontSize: 12.0),
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 5.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              GestureDetector(
                onTap: () {
                  Navigator.push(context,
                      MyCustomRoute(builder: (context) => BerandaPurchasing()));
                },
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Container(
                      height: 70.0,
                      width: 70.0,
                      decoration: BoxDecoration(
                          color: Colors.transparent,
                          border: Border.all(color: Colors.grey, width: 1.0),
                          borderRadius:
                              BorderRadius.all(Radius.circular(18.0))),
                      child:
                          Icon(MdiIcons.heart, size: 25.0, color: Colors.grey),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 10.0),
                      child: Text(
                        'Purchasing',
                        style: TextStyle(
                            fontWeight: FontWeight.w500, fontSize: 12.0),
                      ),
                    ),
                  ],
                ),
              ),
              GestureDetector(
                onTap: () {},
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Container(
                      height: 70.0,
                      width: 70.0,
                      child:
                          Icon(MdiIcons.heart, size: 25.0, color: Colors.grey),
                      decoration: BoxDecoration(
                          color: Colors.transparent,
                          border: Border.all(color: Colors.grey, width: 1.0),
                          borderRadius:
                              BorderRadius.all(Radius.circular(18.0))),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 10.0),
                      child: Text(
                        '',
                        style: TextStyle(
                            fontWeight: FontWeight.w500, fontSize: 12.0),
                      ),
                    ),
                  ],
                ),
              ),
              GestureDetector(
                onTap: () {},
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Container(
                      height: 70.0,
                      width: 70.0,
                      child:
                          Icon(MdiIcons.heart, size: 25.0, color: Colors.grey),
                      decoration: BoxDecoration(
                          color: Colors.transparent,
                          border: Border.all(color: Colors.grey, width: 1.0),
                          borderRadius:
                              BorderRadius.all(Radius.circular(18.0))),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 10.0),
                      child: Text(
                        '',
                        style: TextStyle(
                            fontWeight: FontWeight.w500, fontSize: 12.0),
                      ),
                    ),
                  ],
                ),
              ),
              GestureDetector(
                onTap: () {},
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Container(
                      height: 70.0,
                      width: 70.0,
                      child:
                          Icon(MdiIcons.heart, size: 25.0, color: Colors.grey),
                      decoration: BoxDecoration(
                          color: Colors.transparent,
                          border: Border.all(color: Colors.grey, width: 1.0),
                          borderRadius:
                              BorderRadius.all(Radius.circular(18.0))),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 10.0),
                      child: Text(
                        '',
                        style: TextStyle(
                            fontWeight: FontWeight.w500, fontSize: 12.0),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
