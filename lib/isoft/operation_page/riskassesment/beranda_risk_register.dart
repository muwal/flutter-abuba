import 'package:flutter/material.dart';
import 'risk_register/risk_register_create.dart';
import 'risk_register/risk_register_report.dart';
import 'risk_register/detail_report.dart';
import 'package:flutter_abuba/constant.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class BerandaRiskRegister extends StatefulWidget {
  final int idUser;
  final String namaUser;
  final String departmentUser;
  BerandaRiskRegister({
    this.departmentUser,
    this.idUser,
    this.namaUser,
  });

  @override
  _BerandaRiskRegisterState createState() => _BerandaRiskRegisterState();
}

class _BerandaRiskRegisterState extends State<BerandaRiskRegister> {
  final _scaffoldState = GlobalKey<ScaffoldState>();
  int no;
  bool buttonView = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        key: _scaffoldState,
        appBar: AppBar(
          elevation: 0.25,
          backgroundColor: Colors.white,
          iconTheme: IconThemeData(color: Colors.black),
          title: Image.asset(
            'assets/images/logo2.png',
            height: 150.0,
            width: 120.0,
          ),
        ),
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
                'ISO',
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
                  'Risk Assesment',
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
                      builder: (context) => new RiskRegisterCreate(idUser: widget.idUser, namaUser: widget.namaUser, departmentUser: widget.departmentUser)
                    )
                  );
                },
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Container(
                      height: MediaQuery.of(context).size.width * 0.09,
                      width: MediaQuery.of(context).size.width * 0.09,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage(
                                'assets/images/hrd/create new.png',
                              ),
                              fit: BoxFit.cover
                          )
                      ),
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
              StreamBuilder(
                stream: Firestore.instance.collection('risk_assesment').orderBy('createdTime', descending: true).snapshots(),
                builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (!snapshot.hasData)
                    return Container(
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    );
                  no = snapshot.data.documents.length;
                  return GestureDetector(
                    onTap: () async {
                      setState(() {
                        buttonView = false;
                        buttonView = true;
                      });
                      await new Future.delayed(Duration(seconds: 3));
                      setState(() {
                        buttonView = true;
                        buttonView = false;
                      });

                      Navigator.push(context,
                        MyCustomRoute(
                          builder: (context) => new DetailReport(idUser: widget.idUser, namaUser: widget.namaUser, departmentUser: widget.departmentUser, noData: no)
                        )
                      );
                    },
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Container(
                          height: MediaQuery.of(context).size.width * 0.09,
                          width: MediaQuery.of(context).size.width * 0.09,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage(
                                    'assets/images/hrd/report.png',
                                  ),
                                  fit: BoxFit.cover
                              )
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 10.0),
                          child: Text(
                            buttonView
                                ? 'Preparing data ...'
                                : 'Report',
                            style: TextStyle(
                                fontSize: 12.0,
                                color: buttonView
                                    ? Colors.black54
                                    : Colors.black87, fontWeight: FontWeight.w500),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    ),
                  );
                }
              ),
            ],
          ),
        ),
      ],
    );
  }
}
