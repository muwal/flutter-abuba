import 'package:flutter/material.dart';
import 'package:flutter_abuba/constant.dart';
import 'package:flutter_abuba/sixsigma/5why/form_5why.dart';
import 'package:flutter_abuba/sixsigma/5why/form_report.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
/*import 'form_report.dart';*/

class Beranda5Whys extends StatefulWidget {
  final int idUser;
  final String namaUser;
  final String departmentUser;
  Beranda5Whys({this.idUser, this.namaUser, this.departmentUser});

  @override
  _Beranda5WhysState createState() => _Beranda5WhysState();
}

class _Beranda5WhysState extends State<Beranda5Whys> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
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
        body: _buildMenu(),
      ),
    );
  }

  Widget _buildMenu() {
    return ListView(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Text(
                'Six Sigma',
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
                  '5 Why',
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
                  Navigator.push(
                      context,
                      MyCustomRoute(
                          builder: (context) => FormFiveWhy(idUser: widget.idUser, namaUser: widget.namaUser, departmentUser: widget.departmentUser)));
                },
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Stack(
                      overflow: Overflow.visible,
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
                        Positioned(
                          top: -10.0,
                          right: -8.0,
                          child: Icon(
                            Icons.brightness_1,
                            size: 25.0,
                            color: Colors.redAccent,
                          ),
                        ),
                        Positioned(
                          top: -5.0,
                          right: 2.0,
                          child: Text(
                            '2',
                            style: TextStyle(color: Colors.white),
                          ),
                        )
                      ],
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
                  Navigator.push(
                      context,
                      MyCustomRoute(
                          builder: (context) => FormReport(idUser: widget.idUser, namaUser: widget.namaUser, departmentUser: widget.departmentUser)));
                },
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Stack(
                      overflow: Overflow.visible,
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
                        Positioned(
                          top: -10.0,
                          right: -8.0,
                          child: Icon(
                            Icons.brightness_1,
                            size: 25.0,
                            color: Colors.redAccent,
                          ),
                        ),
                        Positioned(
                          top: -5.0,
                          right: 2.0,
                          child: Text(
                            '2',
                            style: TextStyle(color: Colors.white),
                          ),
                        )
                      ],
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
