import 'package:flutter/material.dart';
import 'package:flutter_abuba/constant.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import 'package:flutter_abuba/isoft/operation_page/dailychecklist/form_kitchen.dart';
import 'form_report.dart';
import 'form_carilokasi.dart';
import 'package:flutter/services.dart';

class MenuChecklist extends StatefulWidget {
  final int idUser;
  final String namaUser;
  final String departmentUser;
  MenuChecklist({
    this.idUser,
    this.namaUser,
    this.departmentUser,
  });
  @override
  _MenuChecklistState createState() => _MenuChecklistState();
}

class _MenuChecklistState extends State<MenuChecklist> {
  bool buttonView = false;

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.dark.copyWith(
        statusBarColor: Color(0xfff9f9f9),),
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            elevation: 0.25,
            backgroundColor: Colors.white,
            iconTheme: IconThemeData(color: Colors.black),
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Flexible(
                  child: Text('Line Check Shifting', style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w600, color: Colors.black),),
                ),
                Stack(
                  children: <Widget>[
                    Icon(Icons.notifications, color: Colors.grey[400],)
                  ],
                )
              ],
            ),
          ),
          body: _buildAbubaMenu(),
        ),
      ),
    );
  }

  Widget _buildAbubaMenu() {
    return Scrollbar(
      child: ListView(
        children: <Widget>[
          SizedBox(
            height: 15.0,
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 15.0),
            height: 100.0,
            child: GridView.count(
              crossAxisCount: 2,
              mainAxisSpacing: 0.1,
              crossAxisSpacing: 0.1,
              childAspectRatio: 1.7,
              children: <Widget>[
                GestureDetector(
                  onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => FormCariLokasi(idUser: widget.idUser, departmentUser: widget.departmentUser, namaUser: widget.namaUser))),
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
                                    'assets/images/hrd/create new2.png',
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
                              'Create New',
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
                  onTap: () async {

                    /*setState(() {
                            buttonView = false;
                            buttonView = true;
                          });
                          await new Future.delayed(Duration(seconds: 3));
                          setState(() {
                            buttonView = true;
                            buttonView = false;
                          });*/

                    Navigator.push(
                        context,
                        MyCustomRoute(
                            builder: (context) => FormReport(idUser: widget.idUser, departmentUser: widget.departmentUser, namaUser: widget.namaUser)));
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
      ),
    );
  }
}
