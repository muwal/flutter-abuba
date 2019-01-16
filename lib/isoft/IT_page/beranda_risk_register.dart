import 'package:flutter/material.dart';
import 'package:flutter_abuba/isoft/IT_page/risk_register/risk_register_create.dart';
import 'package:flutter_abuba/isoft/IT_page/risk_register/risk_register_report.dart';
import 'package:flutter_abuba/constant.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:flutter_abuba/beranda/beranda_appbardua.dart';

class BerandaRiskRegister extends StatefulWidget {
  @override
  _BerandaRiskRegisterState createState() => _BerandaRiskRegisterState();
}

class _BerandaRiskRegisterState extends State<BerandaRiskRegister> {
  final _scaffoldState = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        key: _scaffoldState,
        appBar: AbubaAppBar(),
        body: _buildLogMenu(),
      ),
    );
  }

  Widget _buildLogMenu() {
    return ListView(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Text(
                'IT',
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
                  'Risk Register',
                  style:
                      TextStyle(color: AbubaPallate.greenabuba, fontSize: 12.0),
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              GestureDetector(
                onTap: () {
                  Navigator.push(context,
                    MyCustomRoute(
                      builder: (context) => new RiskRegisterCreate()
                    )
                  );
                },
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Container(
                      height: 70.0,
                      width: 70.0,
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                        border: Border.all(
                          color: Colors.grey, width: 1.0),
                        borderRadius:
                          BorderRadius.all(Radius.circular(18.0)
                        )
                      ),
                      child: Icon(MdiIcons.heart,size: 25.0, color: Colors.grey),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 10.0),
                      child: Text(
                        'Create New',
                        style: TextStyle(
                            fontWeight: FontWeight.w500, fontSize: 12.0),
                      ),
                    ),
                  ],
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(context,
                    MyCustomRoute(
                      builder: (context) => new RiskRegisterReport()
                    )
                  );
                },
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Container(
                      height: 70.0,
                      width: 70.0,
                      child: Icon(MdiIcons.heart, size: 25.0, color: Colors.grey),
                      decoration: BoxDecoration(
                          color: Colors.transparent,
                          border: Border.all(
                              color: Colors.grey, width: 1.0),
                          borderRadius:
                              BorderRadius.all(Radius.circular(18.0))),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 10.0),
                      child: Text(
                        'Report',
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
