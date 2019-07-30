import 'package:flutter/material.dart';
import 'package:flutter_abuba/isoft/R_D/beranda_RD.dart';
import 'package:flutter_abuba/creative_page/form_comment.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:flutter_abuba/constant.dart';

import 'package:flutter_abuba/isoft/finance_page/purchasing/beranda_purchasing.dart';
import 'package:flutter_abuba/isoft/more_page/beranda_more.dart';
import 'package:flutter_abuba/isoft/operation_page/berandaoperation.dart';
import 'package:flutter_abuba/isoft/IT_page/berandaIT.dart';
import 'package:flutter_abuba/isoft/hrd_page/berandahrd.dart';
import 'package:flutter_abuba/whats_page/form_comment.dart';
import 'package:flutter_abuba/whats_page/form_create_happening.dart';
import 'package:flutter_abuba/creative_page/form_detail.dart';
import 'package:flutter_abuba/creative_page/form_create.dart';
import 'package:flutter_abuba/isoft/finance_page/beranda_finance.dart';
import 'package:flutter_abuba/isoft/kitchen_page/beranda_kitchen.dart';
import 'package:flutter_abuba/isoft/kitchen_page/beranda_kitchen2.dart';
import 'package:flutter/services.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

class BerandaIsoft extends StatefulWidget {
  final int idUser;
  final String namaUser;
  final String departmentUser;
  BerandaIsoft({this.idUser, this.namaUser, this.departmentUser});

  @override
  _BerandaIsoftState createState() => _BerandaIsoftState();
}

class _BerandaIsoftState extends State<BerandaIsoft> with TickerProviderStateMixin {
  AnimationController animationController;

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(vsync: this, duration: Duration(seconds: 3));
    animationController.reverse(
        from: animationController.value == 0.0
            ? 1.0
            : animationController.value
    );
  }

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
                  child: Text('Isoft', style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w600, color: Colors.black),),
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
            height: 220.0,
            child: GridView.count(
              crossAxisCount: 3,
              children: <Widget>[
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MyCustomRoute(
                            builder: (context) => BerandaOperation(idUser: widget.idUser, namaUser: widget.namaUser, departmentUser: widget.departmentUser)));
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
                                    'assets/images/isoft/operation.png',
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
                              'Operation',
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
                        MyCustomRoute(builder: (context) => MenuKitchen(idUser: widget.idUser, namaUser: widget.namaUser, departmentUser: widget.departmentUser)));
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
                                    'assets/images/isoft/kitchen.png',
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
                              'Kitchen',
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
                        MyCustomRoute(builder: (context) => MenuIT(idUser: widget.idUser, namaUser: widget.namaUser, departmentUser: widget.departmentUser)));
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
                                  'assets/images/isoft/it.png',
                                  width: 30.0,
                                  height: 30.0,
                                ),
                              ),
                            ],
                          ),
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
                              'IT',
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
                        MyCustomRoute(builder: (context) => MenuHRD(idUser: widget.idUser, namaUser: widget.namaUser, departmentUser: widget.departmentUser)));
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
                                  'assets/images/isoft/hrd.png',
                                  width: 30.0,
                                  height: 30.0,
                                ),
                              ),
                            ],
                          ),
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
                              'HRD',
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
                        MyCustomRoute(builder: (context) => BerandaPurchasing(idUser: widget.idUser, namaUser: widget.namaUser, departmentUser: widget.departmentUser)));
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
                                  'assets/images/purchasing.png',
                                  width: 30.0,
                                  height: 30.0,
                                ),
                              ),
                            ],
                          ),
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
                              'Purchasing',
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
                        MyCustomRoute(builder: (context) => MenuRD(idUser: widget.idUser, namaUser: widget.namaUser, departmentUser: widget.departmentUser)));
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
                                  'assets/images/r&d.png',
                                  width: 30.0,
                                  height: 30.0,
                                ),
                              ),
                            ],
                          ),
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
                              'R&D',
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
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 15.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(left: 5.0),
                  child: Text(
                    "What's Happening",
                    style: TextStyle(
                        color: Colors.black38,
                        fontWeight: FontWeight.w500),
                  ),
                ),
                Expanded(
                  child: new Container(
                      margin:
                      const EdgeInsets.only(left: 10.0, right: 10.0),
                      child: Divider(
                        color: Colors.black38,
                        height: 2,
                      )),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 5.0,
          ),
          Container(
            height: MediaQuery.of(context).size.height * 0.43,
            margin: EdgeInsets.all(10.0),
            child: Column(
              children: <Widget>[
                Flexible(
                    child: AnimatedBuilder(
                      animation: animationController,
                      builder: (_, Widget child) {
                        return animationController.isAnimating
                            ? Container(
                          child: Center(
                            child: CircularProgressIndicator(),
                          ),
                        )
                            : StreamBuilder(
                          stream: Firestore.instance.collection('whats-happening').orderBy('dateCreated', descending: true).snapshots(),
                          builder: (BuildContext contex, AsyncSnapshot<QuerySnapshot> snapshot) {
                            if (!snapshot.hasData)
                              return Container(
                                child: Center(
                                  child: CircularProgressIndicator(),
                                ),
                              );

                            if (snapshot.data.documents.length == 0) {
                              return Container();
                            } else {
                              return CardList(document: snapshot.data.documents, idUser: widget.idUser,);
                            }
                          },
                        );
                      },
                    )
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class CardList extends StatefulWidget {
  final List<DocumentSnapshot> document;
  final int idUser;
  CardList({this.document, this.idUser});

  @override
  _CardListState createState() => _CardListState();
}

class _CardListState extends State<CardList> {
  var tempOutput;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: widget.document.length,
      itemBuilder: (context, index) {
        tempOutput = List<dynamic>.from(widget.document[index].data['likes']);

        return Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          elevation: 2.0,
          child: Container(
            width: MediaQuery.of(context).size.width * 0.80,
            height: MediaQuery.of(context).size.height * 0.0,
            child: Column(
              children: <Widget>[
                Container(
                  width: MediaQuery.of(context).size.width * 1.0,
                  height: MediaQuery.of(context).size.height * 0.20,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(topLeft: Radius.circular(15.0), topRight: Radius.circular(15.0)),
                      color: Colors.grey,
                      image: DecorationImage(
                          image: NetworkImage(
                            widget.document[index].data['image'],
                          ),
                          fit: BoxFit.cover)),
                ),
                Container(
                  margin: EdgeInsets.all(10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Flexible(
                            child: Text(
                              widget.document[index].data['title'],
                              textAlign: TextAlign.justify,
                              style: TextStyle(
                                  color: Colors.black, fontSize: 14.0),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 5.0,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Flexible(
                            child: Text(
                              widget.document[index].data['description'],
                              textAlign: TextAlign.justify,
                              style: TextStyle(
                                  color: Colors.black38, fontSize: 12.5),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          IconButton(
                            tooltip: 'Like',
                            alignment: Alignment.center,
                            icon: widget.document[index].data['likes'].contains(widget.idUser) ? Icon(Icons.favorite) : Icon(Icons.favorite_border),
                            iconSize: 18.0,
                            color: widget.document[index].data['likes'].contains(widget.idUser) ? Colors.redAccent : Colors.grey,
                            onPressed: () {
                              // if (widget.document[index].data['likes'].contains(widget.idUser)) {
                              //   setState(() {
                              //     tempOutput.removeWhere((dynamic userID) => userID == widget.idUser);
                              //   });
                              //   var initialDataNoTimestamp = <String, dynamic>{
                              //     'likes': tempOutput,
                              //   };
                              //   DocumentReference docReference = Firestore.instance.collection('whats-happening').document(widget.document[index].documentID);
                              //   docReference.updateData(initialDataNoTimestamp).then((doc) {
                              //     print('not like');
                              //   }).catchError((error) {
                              //     print('error');
                              //   });
                              // } else {
                              //   setState(() {
                              //     tempOutput.add(widget.idUser);
                              //   });
                              //   var initialDataNoTimestamp = <String, dynamic>{
                              //     'likes': tempOutput,
                              //   };
                              //   DocumentReference docReference = Firestore.instance.collection('whats-happening').document(widget.document[index].documentID);
                              //   docReference.updateData(initialDataNoTimestamp).then((doc) {
                              //     print('liked');
                              //   }).catchError((error) {
                              //     print('error');
                              //   });
                              // }
                            },
                          ),
                          Text(
                            widget.document[index].data['likes'].length.toString(),
                            style: TextStyle(
                                color: Colors.grey[500]
                            ),
                          ),

                          SizedBox(
                            width: 20.0,
                          ),

                          GestureDetector(
                            onTap: () => Navigator.push(context,
                                MyCustomRoute(
                                    builder: (context) => FormComment()
                                )
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Icon(
                                  Icons.chat,
                                  size: 18.0,
                                  color: AbubaPallate.greenabuba,
                                ),
                                SizedBox(
                                  width: 10.0,
                                ),
                                Flexible(
                                  child: Text(
                                    widget.document[index].data['comments'].length.toString(),
                                    style: TextStyle(
                                        color: Colors.grey[500]
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

              ],
            ),
          ),
          /*child: Container(
            width: MediaQuery.of(context).size.width - 100.0,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Container(
                  height: 15.0,
                  alignment: Alignment.topLeft,
                  child: Text(
                    widget.document[index].data['title'],
                    style: TextStyle(
                        fontSize: 14.0,
                        color: Colors.black,
                        fontWeight: FontWeight.w700),
                  ),
                ),
                Container(
                  height: 100.0,
                  alignment: Alignment.topLeft,
                  padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                  child: RichText(
                    overflow: TextOverflow.visible,
                    text: TextSpan(
                      text: widget.document[index].data['description'],
                      style: TextStyle(color: Colors.black38, fontSize: 12.0),
                    ),
                  ),
                ),
                ListTile(
                  contentPadding: EdgeInsets.symmetric(horizontal: 10.0),
                  onTap: () {},
                  title: Container(
                    height: 140.0,
                    decoration: BoxDecoration(
                        color: Colors.grey,
                        border: Border.all(
                          color: Colors.black12,
                          width: 2.0,
                        ),
                        image: DecorationImage(
                            image: NetworkImage(
                              widget.document[index].data['image'],
                            ),
                            fit: BoxFit.cover)),
                  ),
                  subtitle: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(top: 10.0),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            IconButton(
                              tooltip: 'Like',
                              alignment: Alignment.centerRight,
                              icon: widget.document[index].data['likes']
                                      .contains(widget.idUser)
                                  ? Icon(Icons.favorite)
                                  : Icon(Icons.favorite_border),
                              iconSize: 18.0,
                              color: widget.document[index].data['likes']
                                      .contains(widget.idUser)
                                  ? Colors.redAccent
                                  : Colors.grey,
                              onPressed: () {
                                // if (widget.document[index].data['likes'].contains(widget.idUser)) {
                                //   setState(() {
                                //     tempOutput.removeWhere((dynamic userID) => userID == widget.idUser);
                                //   });
                                //   var initialDataNoTimestamp = <String, dynamic>{
                                //     'likes': tempOutput,
                                //   };
                                //   DocumentReference docReference = Firestore.instance.collection('whats-happening').document(widget.document[index].documentID);
                                //   docReference.updateData(initialDataNoTimestamp).then((doc) {
                                //     print('not like');
                                //   }).catchError((error) {
                                //     print('error');
                                //   });
                                // } else {
                                //   setState(() {
                                //     tempOutput.add(widget.idUser);
                                //   });
                                //   var initialDataNoTimestamp = <String, dynamic>{
                                //     'likes': tempOutput,
                                //   };
                                //   DocumentReference docReference = Firestore.instance.collection('whats-happening').document(widget.document[index].documentID);
                                //   docReference.updateData(initialDataNoTimestamp).then((doc) {
                                //     print('liked');
                                //   }).catchError((error) {
                                //     print('error');
                                //   });
                                // }
                              },
                            ),
                            Container(
                              margin: EdgeInsets.only(top: 5.0),
                              child: Text(
                                widget.document[index].data['likes'].length
                                    .toString(),
                                style: TextStyle(color: Colors.grey[500]),
                              ),
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 10.0),
                        child: GestureDetector(
                          onTap: () => Navigator.push(context,
                              MyCustomRoute(builder: (context) => FormComment())),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Icon(
                                Icons.chat,
                                size: 18.0,
                                color: AbubaPallate.greenabuba,
                              ),
                              Container(
                                padding: EdgeInsets.only(left: 5.0),
                                margin: EdgeInsets.only(top: 5.0),
                                child: Text(
                                  widget.document[index].data['comments'].length
                                      .toString(),
                                  style: TextStyle(color: Colors.grey[500]),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),*/
        );
      },
    );
  }
}