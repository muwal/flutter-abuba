import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_abuba/beranda/accountPage.dart';
import 'package:flutter_abuba/creative_page/form_comment.dart';
import 'package:flutter_abuba/constant.dart';
import 'package:flutter_abuba/whats_page/form_comment.dart';
import 'package:flutter_abuba/creative_page/form_detail.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'inboxPage.dart';

class BerandaPage2 extends StatefulWidget {
  final int idUser;
  final String aksesStatus;
  final String namaUser;
  final String departmentUser;
  var index;

  BerandaPage2({this.idUser, this.aksesStatus, this.namaUser, this.departmentUser, this.index});

  @override
  _BerandaPage2State createState() => _BerandaPage2State();
}

class _BerandaPage2State extends State<BerandaPage2> with TickerProviderStateMixin {
  AnimationController animationController;
  GlobalKey<ScaffoldState> _key = new GlobalKey<ScaffoldState>();

  List<String> menu = [
    'Maintenance',
    'Perbaikan',
    'Corrective Action',
    'Internal Audit',
    'Minutes of Meeting',
    'Change Management',
    'Document Control',
  ];

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
    return SafeArea(
      child: WillPopScope(
        onWillPop: () {
          Navigator.pop(context);
        },
        child: Scaffold(
          key: _key,
          endDrawer: Drawer(
            child: ListView(
              padding: EdgeInsets.zero,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(left: 25.0, right: 25.0, top: 15.0, bottom: 15.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Flexible(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 5.0, right: 5.0, bottom: 5.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Flexible(
                                child: Text(
                                  'Your Performance',
                                  style: TextStyle(
                                    fontSize: 13.0,
                                    fontWeight: FontWeight.w800,
                                    color: Colors.black54,
                                    letterSpacing: 1.0
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      Flexible(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 5.0, right: 5.0, bottom: 5.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: <Widget>[
                              Flexible(
                                child: Text(
                                  '90%',
                                  style: TextStyle(
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black54,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  )
                ),
                Divider(
                  height: 3.0,
                ),
                Padding(
                  padding: EdgeInsets.only(left: 15.0, right: 15.0, top: 15.0),
                  child: ListTile(
                    title: Text(
                      'Goal Department',
                      style: TextStyle(
                        fontSize: 15.0,
                        fontWeight: FontWeight.w800,
                        color: Colors.black54,
                        letterSpacing: 1.0
                      ),
                    ),
                    subtitle: LinearPercentIndicator(
                      width: MediaQuery.of(context).size.width * 0.5,
                      animation: true,
                      lineHeight: 30.0,
                      percent: 0.9,
                      center: Text(
                        '90%',
                        style: TextStyle(
                          color: Colors.black45
                        ),
                      ),
                      linearStrokeCap: LinearStrokeCap.butt,
                      progressColor: Colors.green[300],
                    ),
                    onTap: () {},
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 15.0, right: 15.0),
                  child: ListTile(
                    title: Text(
                      'Goal Individu',
                      style: TextStyle(
                        fontSize: 15.0,
                        fontWeight: FontWeight.w800,
                        color: Colors.black54,
                        letterSpacing: 1.0
                      ),
                    ),
                    subtitle: LinearPercentIndicator(
                      width: MediaQuery.of(context).size.width * 0.5,
                      animation: true,
                      lineHeight: 30.0,
                      percent: 0.5,
                      center: Text(
                        '50%',
                        style: TextStyle(
                          color: Colors.black45
                        ),
                      ),
                      linearStrokeCap: LinearStrokeCap.butt,
                      progressColor: Colors.redAccent,
                    ),
                    onTap: () {},
                  ),
                ),
                Container(
                  height: MediaQuery.of(context).size.height * 0.65,
                  child: Column(
                    children: <Widget>[
                      Expanded(
                        child: Align(
                          alignment: FractionalOffset.bottomCenter,
                          child: GestureDetector(
                            onTap: () {

                            },
                            child: Container(
                              padding: EdgeInsets.only(left: 25.0, right: 25.0, top: 15.0, bottom: 15.0),
                              child: Row(
                                children: <Widget>[
                                  Flexible(
                                    child: Padding(
                                      padding: const EdgeInsets.only(left: 5.0, right: 5.0, bottom: 5.0),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: <Widget>[
                                          Flexible(
                                            child: Text(
                                              'Sign Out',
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
                                  ),
                                ],
                              )
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
          body: Scrollbar(
            child: ListView(
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  verticalDirection: VerticalDirection.down,
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 10.0),
                      color: Colors.white,
                      child: Container(
                        child: Padding(
                          padding: EdgeInsets.only(left: 25.0, right: 25.0, top: 15.0, bottom: 15.0),
                          child: Column(
                            children: <Widget>[
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Flexible(
                                    child: Column(
                                      children: <Widget>[
                                        Padding(
                                          padding: const EdgeInsets.only(left: 5.0, right: 5.0, bottom: 5.0),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            children: <Widget>[
                                              Flexible(
                                                child: Text(
                                                  'Hello,',
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
                                          padding: const EdgeInsets.only(left: 5.0, right: 5.0, bottom: 5.0),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            children: <Widget>[
                                              Flexible(
                                                child: Text(
                                                  'Marcello',
                                                  style: TextStyle(
                                                    fontSize: 20.0,
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
                                  GestureDetector(
                                    onTap: () {
                                      _key.currentState.openEndDrawer();
                                    },
                                    child: Container(
                                      width: 45.0,
                                      height: 45.0,
                                      decoration: new BoxDecoration(
                                        color: AbubaPallate.greenabuba,
                                        shape: BoxShape.circle,
                                        border: Border.all(
                                          color: Colors.white,
                                          width: 3.0,
                                        ),
                                        image: DecorationImage(
                                          image: NetworkImage( 'https://image.flaticon.com/icons/png/512/149/149071.png'),  
                                          fit: BoxFit.cover
                                        )
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  verticalDirection: VerticalDirection.down,
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 10.0),
                      color: Colors.white,
                      child: Container(
                        child: Padding(
                          padding: EdgeInsets.only(left: 25.0, right: 25.0, bottom: 15.0),
                          child: Column(
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.only(top: 15.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Flexible(
                                      child: Padding(
                                        padding: const EdgeInsets.only(left: 5.0, right: 5.0, bottom: 10.0),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          children: <Widget>[
                                            Flexible(
                                              child: Text(
                                                'Employee of The Month',
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
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 15.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Container(
                                      width: 45.0,
                                      height: 45.0,
                                      decoration: new BoxDecoration(
                                        color: AbubaPallate.greenabuba,
                                        shape: BoxShape.circle,
                                        border: Border.all(
                                          color: Colors.white,
                                          width: 3.0,
                                        ),
                                        image: DecorationImage(
                                          image: NetworkImage( 'https://image.flaticon.com/icons/png/512/149/149071.png'),  
                                          fit: BoxFit.cover
                                        )
                                      ),
                                    ),
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
                                                    'Muhammad Awaludin',
                                                    style: TextStyle(
                                                      fontSize: 20.0,
                                                      fontWeight: FontWeight.w500,
                                                      color: Colors.black54,
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
                                                Padding(
                                                  padding: EdgeInsets.only(right: 2.0),
                                                  child: Text(
                                                    'IT - ',
                                                  ),
                                                ),
                                                Padding(
                                                  padding: EdgeInsets.only(right: 2.0),
                                                  child: Text(
                                                    '4.5',
                                                  ),
                                                ),
                                                Padding(
                                                  padding: EdgeInsets.only(right: 5.0),
                                                  child: Icon(Icons.star, size: 20.0, color: Colors.grey),
                                                )
                                              ],
                                            ),
                                          ),
                                        ],
                                      )
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  verticalDirection: VerticalDirection.down,
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 10.0),
                      color: Colors.white,
                      child: Container(
                        child: Padding(
                          padding: EdgeInsets.only(left: 25.0, right: 25.0, top: 15.0, bottom: 15.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.only(top: 15.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Flexible(
                                      child: Padding(
                                        padding: const EdgeInsets.only(left: 5.0, right: 5.0, bottom: 10.0),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          children: <Widget>[
                                            Flexible(
                                              child: Text(
                                                'What\'s Happening in Abuba',
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
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                height: MediaQuery.of(context).size.height * 0.4,
                                child: Column(
                                  children: <Widget>[
                                    Expanded(
                                      child: ListView.builder(
                                        itemCount: 5,
                                        scrollDirection: Axis.horizontal,
                                        itemBuilder: (context, index) {
                                          return Container(
                                            child: Card(
                                              shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.circular(7.0),
                                              ),
                                              child: Container(
                                                width: MediaQuery.of(context).size.width * 0.75,
                                                height: MediaQuery.of(context).size.width * 0.25,
                                                child: Column(
                                                  children: <Widget>[
                                                    Container(
                                                      height: MediaQuery.of(context).size.height * 0.15,
                                                      decoration: BoxDecoration(
                                                        borderRadius: BorderRadius.only(
                                                          topLeft: Radius.circular(7.0),
                                                          topRight: Radius.circular(7.0)
                                                        ),
                                                        image: DecorationImage(
                                                          image: NetworkImage('https://firebasestorage.googleapis.com/v0/b/flutter-83d2f.appspot.com/o/eugene-lim-260668.jpg?alt=media&token=d7c23fa0-6f21-4f88-81b5-e8a7a0dcef16'),
                                                          fit: BoxFit.cover
                                                        )
                                                      ),
                                                      child: null,
                                                    ),
                                                    Container(
                                                      height: MediaQuery.of(context).size.height * 0.05,
                                                      padding: const EdgeInsets.only(left: 20.0, right: 20.0, top: 5.0, bottom: 5.0),
                                                      child: Row(
                                                        children: <Widget>[
                                                          Flexible(
                                                            child: Text(
                                                              'Mount Everest',
                                                              style: TextStyle(
                                                                fontSize: 16.0,
                                                                fontWeight: FontWeight.bold,
                                                                color: Colors.black54,
                                                                letterSpacing: 1.0
                                                              ),
                                                            ),
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                    Container(
                                                      height: MediaQuery.of(context).size.height * 0.12,
                                                      padding: const EdgeInsets.only(left: 20.0, right: 20.0, top: 5.0, bottom: 5.0),
                                                      child: Row(
                                                        children: <Widget>[
                                                          Flexible(
                                                            child: Text(
                                                              'Mount Everest, known in Nepali as Sagarmatha, in Tibetan as Chomolungma and in Chinese as Zhumulangma, is Earth\'s highest mountain above sea level, located in the Mahalangur Himal sub-range of the Himalayas. The international border between Nepal and China runs across its summit point.',
                                                              style: TextStyle(
                                                                fontSize: 14.0,
                                                                fontWeight: FontWeight.w500,
                                                                color: Colors.black54,
                                                                letterSpacing: 1.0
                                                              ),
                                                            ),
                                                          )
                                                        ],
                                                      )
                                                    ),
                                                    Container(
                                                      height: MediaQuery.of(context).size.height * 0.07,
                                                      padding: const EdgeInsets.only(left: 10.0),
                                                      child: Row(
                                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                        children: <Widget>[
                                                          Flexible(
                                                            child: Container(
                                                              width: MediaQuery.of(context).size.width * 0.4,
                                                              padding: const EdgeInsets.only(left: 5.0, right: 5.0),
                                                              child: ButtonTheme(
                                                                height: 30.0,
                                                                child: OutlineButton(
                                                                  child: Text(
                                                                    'Detail',
                                                                    style: TextStyle(
                                                                      fontSize: 13.0,
                                                                      color: AbubaPallate.menuBluebird,
                                                                      fontWeight: FontWeight.bold
                                                                    ),
                                                                  ),
                                                                  borderSide: BorderSide(color: AbubaPallate.menuBluebird, width: 2.0),
                                                                  highlightedBorderColor: AbubaPallate.menuBluebird,
                                                                  splashColor: AbubaPallate.menuBluebird,
                                                                  onPressed: () {
                                                                    
                                                                  },
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                          Flexible(
                                                            child: Container(
                                                              width: MediaQuery.of(context).size.width * 0.4,
                                                              padding: const EdgeInsets.only(left: 5.0, right: 5.0),
                                                              child: Row(
                                                                mainAxisAlignment: MainAxisAlignment.center,
                                                                children: <Widget>[
                                                                  Padding(
                                                                    padding: EdgeInsets.only(right: 3.0),
                                                                    child: Icon(Icons.favorite, color: Colors.red, size: 20.0),
                                                                  ),
                                                                  Padding(
                                                                    padding: EdgeInsets.only(right: 20.0),
                                                                    child: Text(
                                                                      '150'
                                                                    ),
                                                                  ),
                                                                  Padding(
                                                                    padding: EdgeInsets.only(right: 3.0),
                                                                    child: Icon(Icons.comment, color: Colors.grey, size: 20.0),
                                                                  ),
                                                                  Padding(
                                                                    padding: EdgeInsets.only(right: 20.0),
                                                                    child: Text(
                                                                      '50'
                                                                    ),
                                                                  )
                                                                ],
                                                              )
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                  ],
                                )
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  verticalDirection: VerticalDirection.down,
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 10.0),
                      color: Colors.white,
                      child: Container(
                        child: Padding(
                          padding: EdgeInsets.only(left: 25.0, right: 25.0, bottom: 15.0),
                          child: Column(
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.only(top: 15.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Flexible(
                                      child: Padding(
                                        padding: const EdgeInsets.only(left: 5.0, right: 5.0, bottom: 10.0),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          children: <Widget>[
                                            Flexible(
                                              child: Text(
                                                'IT Department',
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
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                height: 200.0,
                                child: GridView.count(
                                  crossAxisCount: 3,
                                  children: List.generate(menu.length, (index) {
                                    return Card(
                                      child: Container(
                                        width: MediaQuery.of(context).size.width * 0.25,
                                        height: MediaQuery.of(context).size.width * 0.25,
                                        padding: EdgeInsets.all(5.0),
                                        child: Column(
                                          children: <Widget>[
                                            Container(child: Icon(Icons.lock, size: 35.0, color: Colors.grey), alignment: Alignment.center, padding: EdgeInsets.only(top: 15.0, left: 5.0, bottom: 15.0),),
                                            Text(menu[index], textAlign: TextAlign.center),
                                          ],
                                        ),
                                      ),
                                    );
                                  })
                                ),
                              ),
                              // Row(
                              //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              //   children: <Widget>[
                              //     Card(
                              //       child: Container(
                              //         width: MediaQuery.of(context).size.width * 0.25,
                              //         height: MediaQuery.of(context).size.width * 0.25,
                              //         padding: EdgeInsets.all(5.0),
                              //         child: Column(
                              //           children: <Widget>[
                              //             Container(child: Icon(Icons.lock, size: 35.0, color: Colors.grey), alignment: Alignment.center, padding: EdgeInsets.only(top: 15.0, left: 5.0, bottom: 15.0),),
                              //             Text('Maintenance')
                              //           ],
                              //         ),
                              //       ),
                              //     ),
                              //     Card(
                              //       child: Container(
                              //         width: MediaQuery.of(context).size.width * 0.25,
                              //         height: MediaQuery.of(context).size.width * 0.25,
                              //         padding: EdgeInsets.all(5.0),
                              //         child: Column(
                              //           children: <Widget>[
                              //             Container(child: Icon(Icons.card_travel, size: 35.0, color: Colors.grey), alignment: Alignment.center, padding: EdgeInsets.only(top: 15.0, left: 5.0, bottom: 15.0),),
                              //             Text('Perbaikan')
                              //           ],
                              //         ),
                              //       ),
                              //     ),
                              //     Card(
                              //       child: Container(
                              //         width: MediaQuery.of(context).size.width * 0.25,
                              //         height: MediaQuery.of(context).size.width * 0.25,
                              //         padding: EdgeInsets.all(5.0),
                              //         child: Column(
                              //           children: <Widget>[
                              //             Container(child: Icon(Icons.change_history, size: 35.0, color: Colors.grey), alignment: Alignment.center, padding: EdgeInsets.only(top: 15.0, left: 5.0, bottom: 15.0),),
                              //             Text('Perbaikan')
                              //           ],
                              //         ),
                              //       ),
                              //     ),
                              //   ],
                              // ),
                              // SizedBox(
                              //   height: 15.0,
                              // ),
                              // Row(
                              //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              //   children: <Widget>[
                              //     Card(
                              //       child: Container(
                              //         width: MediaQuery.of(context).size.width * 0.25,
                              //         height: MediaQuery.of(context).size.width * 0.25,
                              //         padding: EdgeInsets.all(5.0),
                              //         child: Column(
                              //           children: <Widget>[
                              //             Container(child: Icon(Icons.zoom_out, size: 35.0, color: Colors.grey), alignment: Alignment.center, padding: EdgeInsets.only(top: 15.0, left: 5.0, bottom: 15.0),),
                              //             Text('Maintenance')
                              //           ],
                              //         ),
                              //       ),
                              //     ),
                              //     Card(
                              //       child: Container(
                              //         width: MediaQuery.of(context).size.width * 0.25,
                              //         height: MediaQuery.of(context).size.width * 0.25,
                              //         padding: EdgeInsets.all(5.0),
                              //         child: Column(
                              //           children: <Widget>[
                              //             Container(child: Icon(Icons.radio, size: 35.0, color: Colors.grey), alignment: Alignment.center, padding: EdgeInsets.only(top: 15.0, left: 5.0, bottom: 15.0),),
                              //             Text('Perbaikan')
                              //           ],
                              //         ),
                              //       ),
                              //     ),
                              //     Card(
                              //       child: Container(
                              //         width: MediaQuery.of(context).size.width * 0.25,
                              //         height: MediaQuery.of(context).size.width * 0.25,
                              //         padding: EdgeInsets.all(5.0),
                              //         child: Column(
                              //           children: <Widget>[
                              //             Container(child: Icon(Icons.redeem, size: 35.0, color: Colors.grey), alignment: Alignment.center, padding: EdgeInsets.only(top: 15.0, left: 5.0, bottom: 15.0),),
                              //             Text('Perbaikan')
                              //           ],
                              //         ),
                              //       ),
                              //     ),
                              //   ],
                              // ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          bottomNavigationBar: _buildBottomNavigation(),
        ),
      ),
    );
  }

  Widget _buildBottomNavigation() {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      onTap: null,
      items: [
        BottomNavigationBarItem(
          activeIcon: new Icon(
            Icons.home,
            color: AbubaPallate.green,
          ),
          icon: new Icon(
            Icons.home,
            color: Colors.grey,
          ),
          title: new Text(
            'Home',
          ),
        ),
        BottomNavigationBarItem(
          activeIcon: new Icon(
            Icons.timeline,
            color: AbubaPallate.green,
          ),
          icon: new Icon(
            Icons.timeline,
            color: Colors.grey,
          ),
          title: new Text('What\'s New'),
        ),
        BottomNavigationBarItem(
          activeIcon: new Icon(
            Icons.mail,
            color: AbubaPallate.green,
          ),
          icon: FlatButton(
            splashColor: Colors.transparent,
            color: Colors.transparent,
            disabledColor: Colors.transparent,
            disabledTextColor: Colors.transparent,
            highlightColor: Colors.transparent,
            onPressed: () {
              Navigator.push(context,
                  MyCustomRoute(
                      builder: (_) => InboxPage(idUser: widget.idUser)
                  )
              );
            },
            padding: EdgeInsets.only(top: 10.0),
            child: Column(
              children: <Widget>[
                Icon(
                  Icons.mail,
                  color: Colors.grey,
                ),
                SizedBox(
                  height: 2.0,
                ),
                Text('Inbox', style: TextStyle(color: Colors.grey, fontWeight: FontWeight.normal, fontSize: 11.5))
              ],
            ),
          ),
          title: new Text(''),
        ),
        BottomNavigationBarItem(
          activeIcon: new Icon(
            Icons.person,
            color: AbubaPallate.green,
          ),
          icon: FlatButton(
            splashColor: Colors.transparent,
            color: Colors.transparent,
            disabledColor: Colors.transparent,
            disabledTextColor: Colors.transparent,
            highlightColor: Colors.transparent,
            onPressed: () async {
              List<dynamic> outlet = [];
              List<dynamic> outletSkip = [];

              setState(() {
                outlet.clear();
                outlet = [];
                outletSkip.clear();
                outletSkip = [];
              });
              CollectionReference reference = Firestore.instance.collection('maintenance_testing');
              reference.snapshots().listen((querySnapshot) {
                querySnapshot.documentChanges.forEach((change) {
                  setState(() {
                    outlet.add(change.document.data['outlet']);
                  });
                });
              });

              await new Future.delayed(Duration(
                  milliseconds: 500
              ));
              Navigator.push(context, 
                MyCustomRoute(
                  builder: (_) => AccountPage(idUser: widget.idUser, index: widget.index)
                  // builder: (_) => Testing(idUser: widget.idUser, departmentUser: widget.departmentUser, namaUser: widget.namaUser, count: outlet.length),
                )
              );
            },
            padding: EdgeInsets.only(top: 10.0),
            child: Column(
              children: <Widget>[
                Icon(
                  Icons.person,
                  color: Colors.grey,
                ),
                SizedBox(
                  height: 2.0,
                ),
                Text('Account', style: TextStyle(color: Colors.grey, fontWeight: FontWeight.normal, fontSize: 11.5))
              ],
            ),
          ),
          title: Text(''),
        ),
      ],
    );
  }
}

class CardList2 extends StatefulWidget {
  final List<DocumentSnapshot> document;
  final int idUser;
  CardList2({this.document, this.idUser});

  @override
  _CardList2State createState() => _CardList2State();
}

class _CardList2State extends State<CardList2> {
  var tempOutput;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: widget.document.length,
      itemBuilder: (context, index) {
        tempOutput = List<dynamic>.from(widget.document[index].data['likes']);

        return Container(
          width: MediaQuery.of(context).size.width - 100.0,
          height: 400.0,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Container(
                height: 15.0,
                alignment: Alignment.topLeft,
                child: Text(
                  widget.document[index].data['problem'],
                  style: TextStyle(
                      color: Colors.black, fontSize: 13.0),
                ),
              ),
              Container(
                height: 15.0,
                padding: EdgeInsets.only(top: 3.0),
                alignment: Alignment.topLeft,
                child: Text(
                  '${widget.document[index].data['userCreated'].toString()} . ${widget.document[index].data['userDepartment'].toString()}',
                  style: TextStyle(
                      color: Colors.black38, fontSize: 12.0),
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
                    style: TextStyle(color: Colors.black38, fontSize: 11.0),
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
                      image: NetworkImage(widget.document[index].data['image']),
                      fit: BoxFit.cover
                    )
                  ),
                ),
                subtitle: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                          Container(
                            margin: EdgeInsets.only(top: 5.0),
                            child: Text(
                              widget.document[index].data['likes'].length.toString(),
                              style: TextStyle(
                                color: Colors.grey[500]
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 10.0),
                      child: GestureDetector(
                        onTap: () => Navigator.push(context,
                          MyCustomRoute(
                            builder: (context) => FormCommentIdea()
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
                            Container(
                              padding: EdgeInsets.only(left: 5.0),
                              margin: EdgeInsets.only(top: 5.0),
                              child: Text(
                                widget.document[index].data['comments'].length.toString(),
                                style: TextStyle(
                                  color: Colors.grey[500]
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(right: 20.0, top: 20.0),
                      alignment: Alignment.topRight,
                      child: ButtonTheme(
                        minWidth: 50.0,
                        height: 20.0,
                        child: OutlineButton(
                          child: Text(
                            'Detail',
                            style: TextStyle(fontSize: 13.0),
                          ),
                          borderSide: BorderSide(
                              color: Colors.green, width: 1.0),
                          highlightedBorderColor: Colors.green,
                          onPressed: () => Navigator.push(context,
                            MyCustomRoute(
                              builder: (context) => FormDetail(index: widget.document[index].documentID)
                            )
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        );
      },
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

        return Container(
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
                    fontWeight: FontWeight.w700
                  ),
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
                    style: TextStyle(
                      color: Colors.black38,
                      fontSize: 12.0
                    ),
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
                      fit: BoxFit.cover
                    )
                  ),
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
                          Container(
                            margin: EdgeInsets.only(top: 5.0),
                            child: Text(
                              widget.document[index].data['likes'].length.toString(),
                              style: TextStyle(
                                color: Colors.grey[500]
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 10.0),
                      child: GestureDetector(
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
                            Container(
                              padding: EdgeInsets.only(left: 5.0),
                              margin: EdgeInsets.only(top: 5.0),
                              child: Text(
                                widget.document[index].data['comments'].length.toString(),
                                style: TextStyle(
                                  color: Colors.grey[500]
                                ),
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
        );
      },
    );
  }
}