import 'package:flutter/material.dart';
import 'package:flutter_abuba/constant.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:flutter_abuba/beranda/beranda_appbardua.dart';

import 'material/form_material.dart';

class BerandaEvaluation extends StatefulWidget {
  @override
  _BerandaEvaluationState createState() => _BerandaEvaluationState();
}

class _BerandaEvaluationState extends State<BerandaEvaluation> {
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
                'Purchasing',
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
                  'Evaluation',
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
                      MyCustomRoute(builder: (context) => FormMaterial()));
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
                        'Material',
                        style: TextStyle(
                            fontWeight: FontWeight.w500, fontSize: 12.0),
                      ),
                    ),
                  ],
                ),
              ),
              GestureDetector(
                onTap: () {

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
                        'Jasa',
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