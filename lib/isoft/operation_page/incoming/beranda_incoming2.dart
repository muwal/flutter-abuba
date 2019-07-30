import 'package:flutter/material.dart';
import 'package:flutter_abuba/constant.dart';
import 'package:flutter_abuba/isoft/operation_page/incoming/beranda_incoming.dart';
import 'package:flutter_abuba/isoft/operation_page/incoming/driver_konfirmasi.dart';
import 'package:flutter_abuba/isoft/operation_page/incoming/form_report.dart';

class BerandaIncoming2 extends StatefulWidget {
  final int idUser;
  final String namaUser;
  final String departmentUser;
  BerandaIncoming2({this.idUser, this.namaUser, this.departmentUser});

  @override
  _BerandaIncoming2 createState() => _BerandaIncoming2();
}

class _BerandaIncoming2 extends State<BerandaIncoming2> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          elevation: 0.25,
          backgroundColor: Colors.white,
          iconTheme: IconThemeData(color: Colors.black),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Flexible(
                child: Text('Incoming Material', style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w600, color: Colors.black),),
              ),
              /*Stack(
                children: <Widget>[
                  Icon(Icons.notifications, color: Colors.grey[400],)
                ],
              )*/
            ],
          ),
        ),
        body: _buildMenu(),
      ),
    );
  }

  Widget _buildMenu() {
    return ListView(
      children: <Widget>[
        SizedBox(
          height: 15.0,
        ),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 15.0),
          height: 100.0,
          child: GridView.count(
            crossAxisCount: 3,
            mainAxisSpacing: 0.1,
            crossAxisSpacing: 0.1,
//            childAspectRatio: 1.7,
            children: <Widget>[
              GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MyCustomRoute(
                          builder: (context) => BerandaIncoming(idUser: widget.idUser, namaUser: widget.namaUser, departmentUser: widget.departmentUser)
                      ));
                },
                child: Column(
                  children: <Widget>[
                    Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(15.0),
                            bottomRight: Radius.circular(15.0),
                            topRight: Radius.circular(15.0),
                            topLeft: Radius.circular(15.0),
                          ),
                        ),
                        elevation: 1.0,
                        child: Container(
                          width: MediaQuery.of(context).size.width * 0.17,
                          margin: EdgeInsets.symmetric(vertical: 10.0),
                          child: Stack(
                            overflow: Overflow.visible,
                            children: <Widget>[
                              Center(
                                child: Image.asset(
                                  'assets/images/incoming/inspection.png',
                                  width: 30.0,
                                  height: 30.0,
                                ),
                              ),
                            ],
                          ),
                        )
                    ),
                    SizedBox(
                      height: 5.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Flexible(
                          child: Text(
                            'Inspection',
                            style: TextStyle(
                                fontWeight: FontWeight.w400, color: Colors.grey),
                            textAlign: TextAlign.center,
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(context,
                      MyCustomRoute(
                          builder: (context) => DriverKonfirmasi(idUser: widget.idUser, namaUser: widget.namaUser, departmentUser: widget.departmentUser)
                      )
                  );
                },
                child: Column(
                  children: <Widget>[
                    Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(15.0),
                          bottomRight: Radius.circular(15.0),
                          topRight: Radius.circular(15.0),
                          topLeft: Radius.circular(15.0),
                        ),
                      ),
                      elevation: 1.0,
                      child: Container(
                          width: MediaQuery.of(context).size.width * 0.17,
                          margin: EdgeInsets.symmetric(vertical: 10.0),
                          child: Stack(
                            overflow: Overflow.visible,
                            children: <Widget>[
                              Center(
                                child: Image.asset(
                                  'assets/images/iso/qc2.png',
                                  width: 30.0,
                                  height: 30.0,
                                ),
                              ),
                            ],
                          )
                      ),
                    ),
                    SizedBox(
                      height: 5.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Flexible(
                          child: Text(
                            'Konfirmasi Driver',
                            style: TextStyle(
                                fontWeight: FontWeight.w400, color: Colors.grey),
                            textAlign: TextAlign.center,
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MyCustomRoute(
                          builder: (context) => FormReport(departmentUser: widget.departmentUser, idUser: widget.idUser, namaUser: widget.namaUser,)
                      ));
                },
                child: Column(
                  children: <Widget>[
                    Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(15.0),
                          bottomRight: Radius.circular(15.0),
                          topRight: Radius.circular(15.0),
                          topLeft: Radius.circular(15.0),
                        ),
                      ),
                      elevation: 1.0,
                      child: Container(
                          width: MediaQuery.of(context).size.width * 0.17,
                          margin: EdgeInsets.symmetric(vertical: 10.0),
                          child: Stack(
                            overflow: Overflow.visible,
                            children: <Widget>[
                              Center(
                                child: Image.asset(
                                  'assets/images/hrd/report2.png',
                                  width: 30.0,
                                  height: 30.0,
                                ),
                              ),
                            ],
                          )
                      ),
                    ),
                    SizedBox(
                      height: 5.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Flexible(
                          child: Text(
                            'Report',
                            style: TextStyle(
                                fontWeight: FontWeight.w400, color: Colors.grey),
                            textAlign: TextAlign.center,
                          ),
                        )
                      ],
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
