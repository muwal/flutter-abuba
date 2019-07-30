import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_abuba/constant.dart';

class DriverKonfirmasi extends StatefulWidget {
  final int idUser;
  final String namaUser;
  final String departmentUser;

  DriverKonfirmasi({this.idUser, this.departmentUser, this.namaUser});

  @override
  _DriverKonfirmasiState createState() => _DriverKonfirmasiState();
}

class _DriverKonfirmasiState extends State<DriverKonfirmasi> with TickerProviderStateMixin {
  AnimationController animationController;

  @override
  void initState() {
    animationController = AnimationController(vsync: this, duration: Duration(seconds: 3));
    animationController.reverse(
      from: animationController.value == 0.0
        ? 1.0
        : animationController.value
    );

    super.initState();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

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
                child: Text('Konfirmasi Driver', style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w600, color: Colors.black),),
              ),
              /*Stack(
                children: <Widget>[
                  Icon(Icons.notifications, color: Colors.grey[400],)
                ],
              )*/
            ],
          ),
        ),
        body: GestureDetector(
          onTap: () {
            FocusScope.of(context).requestFocus(FocusNode());
          },
          child: AnimatedBuilder(
            animation: animationController,
            builder: (_, Widget child) {
              return animationController.isAnimating
                ? Container(
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  )
                : ListView.builder(
                    itemCount: 5,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 5.0),
                        child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          elevation: 2.0,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            verticalDirection: VerticalDirection.down,
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.only(top: 10.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Flexible(
                                      child: Column(
                                        children: <Widget>[
                                          Padding(
                                            padding: const EdgeInsets.only(left: 10.0, right: 5.0, bottom: 5.0),
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              children: <Widget>[
                                                Icon(Icons.location_on, color: Colors.grey, size: 16.0),
                                                Flexible(
                                                  child: Text(
                                                    'asd',
                                                    style: TextStyle(
                                                        fontSize: 14.0,
                                                        fontWeight: FontWeight.w400,
                                                        color: Colors.black87
                                                    ),
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(left: 10.0, right: 5.0, bottom: 5.0),
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              children: <Widget>[
                                                Flexible(
                                                  child: Text(
                                                    'asd',
                                                    style: TextStyle(
                                                        fontSize: 16.0,
                                                        fontWeight: FontWeight.w700,
                                                        color: AbubaPallate.greenabuba
                                                    ),
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 5.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Flexible(
                                      child: Column(
                                        children: <Widget>[
                                          Padding(
                                            padding: const EdgeInsets.only(left: 10.0, right: 5.0, bottom: 5.0),
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              children: <Widget>[
                                                Flexible(
                                                  child: Text(
                                                    'FREQUENCY',
                                                    style: TextStyle(
                                                      fontSize: 15.0,
                                                      fontWeight: FontWeight.w800,
                                                      color: Colors.black54,
                                                      letterSpacing: 1.0
                                                    ),
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(left: 10.0, right: 5.0, bottom: 5.0),
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              children: <Widget>[
                                                Flexible(
                                                  child: Text(
                                                    'asd',
                                                    style: TextStyle(
                                                      fontSize: 14.0,
                                                      fontWeight: FontWeight.w500,
                                                      color: Colors.black54,
                                                    ),
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 10.0, bottom: 3.0),
                                child: Divider(
                                  height: 3.0,
                                ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Flexible(
                                      child: Container(
                                        width: MediaQuery.of(context).size.width * 0.5,
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            ButtonTheme(
                                              minWidth: MediaQuery.of(context).size.width * 0.15,
                                              height: 30.0,
                                              child: OutlineButton(
                                                child: Row(
                                                  children: <Widget>[
                                                    Container(
                                                      width: MediaQuery.of(context).size.width * 0.15,
                                                      alignment: Alignment.center,
                                                      child: Text(
                                                        'Skip',
                                                        style: TextStyle(
                                                          fontSize: 13.0,
                                                          color: AbubaPallate.menuBluebird,
                                                          fontWeight: FontWeight.bold
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                borderSide: BorderSide(color: Colors.transparent, width: 2.0),
                                                highlightedBorderColor: Colors.transparent,
                                                splashColor: Colors.white,
                                                onPressed: () {

                                                },
                                              ),
                                            )
                                          ],
                                        ),
                                      )
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
            },
          ),
        )
      ),
    );
  }
}

class DialogView extends StatefulWidget {
  var indexx;
  List<dynamic> auditor;
  final String status;
  final int idUser;

  DialogView({this.indexx, this.auditor, this.status, this.idUser});
  @override
  _DialogViewState createState() => _DialogViewState();
}

class _DialogViewState extends State<DialogView> with TickerProviderStateMixin {
  AnimationController animationController;
  bool isProcess = false;
  
  @override
  void initState() {
    animationController = AnimationController(vsync: this, duration: Duration(seconds: 3));
    animationController.reverse(
      from: animationController.value == 0.0
        ? 1.0
        : animationController.value
    );

    super.initState();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        height: MediaQuery.of(context).size.height * 0.6,
        child: AnimatedBuilder(
          animation: animationController,
          builder: (_, Widget child) {
            return animationController.isAnimating
              ? Container(
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                )
              : Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(left: 12.0, right: 12.0, bottom: 5.0, top: 10.0),
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        height: 35.0,
                        decoration: new BoxDecoration(
                          color: Colors.grey,
                          shape: BoxShape.rectangle,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Flexible(
                              child: Container(
                                padding: EdgeInsets.only(left: 10.0),
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  'Department',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 12.0),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                            Flexible(
                              child: Container(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  'Sub Area - Auditor',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 12.0),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    ),
                    Expanded(
                      child: ListView(
                        shrinkWrap: true,
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.only(left: 5.0, right: 5.0, bottom: 5.0),
                            child: Container(
                              padding: EdgeInsets.only(top: 5.0, bottom: 10.0),
                              child: Column(
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.only(left: 20.0, right: 12.0, top: 10.0),
                                    child: Column(
                                      children: <Widget>[
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Container(
                                              alignment: Alignment.topLeft,
                                              width: MediaQuery.of(context).size.width * 0.2,
                                              child: Column( 
                                                mainAxisAlignment: MainAxisAlignment.start,
                                                children: <Widget>[
                                                  Row(
                                                    children: <Widget>[
                                                      Flexible(
                                                        child: Text(
                                                          'asd',
                                                          style: TextStyle(color: Colors.grey[500], fontSize: 13.0, fontWeight: FontWeight.w700)
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  SizedBox(
                                                    height: 3.0,
                                                  ),
                                                  Row(
                                                    children: <Widget>[
                                                      Flexible(
                                                        child: Text(
                                                          'asd',
                                                          style: TextStyle(color: Colors.grey[500], fontSize: 13.0, fontWeight: FontWeight.w700)
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  SizedBox(
                                                    height: 3.0,
                                                  ),
                                                  Row(
                                                    children: <Widget>[
                                                      Flexible(
                                                        child: Text(
                                                          'asd',
                                                          style: TextStyle(color: Colors.grey[500], fontSize: 13.0, fontWeight: FontWeight.w700)
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  SizedBox(
                                                    height: 15.0,
                                                  ),
                                                  Row(
                                                    children: <Widget>[
                                                      Flexible(
                                                        child: Text(
                                                          'Auditee',
                                                          style: TextStyle(color: AbubaPallate.greenabuba, fontSize: 13.0, fontWeight: FontWeight.w700)
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  SizedBox(
                                                    height: 3.0,
                                                  ),
                                                  Row(
                                                    children: <Widget>[
                                                      Flexible(
                                                        child: Text(
                                                          'asd',
                                                          style: TextStyle(color: Colors.grey[500], fontSize: 13.0, fontWeight: FontWeight.w700)
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  SizedBox(
                                                    height: 15.0,
                                                  ),
                                                  Row(
                                                    children: <Widget>[
                                                      Flexible(
                                                        child: Text(
                                                          'Lead Auditor',
                                                          style: TextStyle(color: AbubaPallate.greenabuba, fontSize: 13.0, fontWeight: FontWeight.w700)
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        width: 3.0,
                                                      ),
                                                    ],
                                                  ),
                                                  SizedBox(
                                                    height: 3.0,
                                                  ),
                                                  Row(
                                                    children: <Widget>[
                                                      Flexible(
                                                        child: Text(
                                                          'asd',
                                                          style: TextStyle(color: Colors.grey[500], fontSize: 13.0, fontWeight: FontWeight.w700)
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    )
                                  ),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                );
          },
        )
      ),
    );
  }
}