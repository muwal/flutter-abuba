import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_abuba/beranda/accountPage.dart';
import 'package:flutter_abuba/beranda/backup.dart';
import 'package:flutter_abuba/creative_page/form_comment.dart';
import 'package:flutter_abuba/misteri_shop/beranda_mg.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:flutter_abuba/constant.dart';

import 'package:flutter_abuba/whats_page/form_comment.dart';
import 'package:flutter_abuba/whats_page/form_create_happening.dart';
import 'package:flutter_abuba/creative_page/form_detail.dart';
import 'package:flutter_abuba/creative_page/form_create.dart';
import 'package:flutter_abuba/sixsigma/beranda_sigma.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_abuba/launcher/launcher_view.dart';

import 'package:flutter_abuba/isoft/berandaisoft.dart';
import 'inboxPage.dart';

class BerandaPage extends StatefulWidget {
  final int idUser;
  final String aksesStatus;
  final String namaUser;
  final String departmentUser;
  var index;

  BerandaPage(
      {this.idUser,
      this.aksesStatus,
      this.namaUser,
      this.departmentUser,
      this.index});

  @override
  _BerandaPageState createState() => _BerandaPageState();
}

class _BerandaPageState extends State<BerandaPage>
    with TickerProviderStateMixin {
  AnimationController animationController;

  List<String> department = [
    'Procurement',
    'FAT',
    'IA',
    'BD',
    'HRD',
    'IT',
    'BOD',
    'IA',
    'OPR',
  ];

  List<String> nama = [
    'Inne Rettiani',
    'Dewi Kurniasih',
    'Indah',
    'Andi Lala',
    'Rizal Baydillah',
    'Sony Ramdhani Tahir',
    'M. Ali Ariansyah',
    'Ade Ridwan',
    'Rahmat Yasir',
  ];

  List<String> gambar = [
    'inne.jpeg',
    'Ibu DEWI KURNIASIH - FAT MANAGER.png',
    'INDAH.jpeg',
    'Pak ANDI LALA - BUSINESS DEVELOPMENT MANAGER.jpeg',
    'Pak RIZAL BAYDILLAH - HRD MANAGER.jpeg',
    'Pak SONNY RAMADHAN - IT ASST. MANAGER.jpg',
    'DIRUT (2).jpg',
    'Pak ADE RIDWAN - INTERNAL AUDIT MANAGER.jpeg',
    'Pak YASIR - OPERASIONAL MANAGER.jpeg',
  ];

  Future<bool> onWillPop() {
    return showDialog(
            context: context,
            barrierDismissible: false,
            builder: (context) => AlertDialog(
                  title: Text('Are you sure?'),
                  content: Text('Do you want to exit Abuba Steak App ?'),
                  actions: <Widget>[
                    FlatButton(
                      onPressed: () => Navigator.of(context).pop(false),
                      child: Text('No'),
                    ),
                    FlatButton(
                      onPressed: () => SystemChannels.platform
                          .invokeMethod('SystemNavigator.pop'),
                      child: Text('Yes'),
                    )
                  ],
                )) ??
        false;
  }

  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<FirebaseUser> getUser() async {
    return await _auth.currentUser();
  }

  @override
  void initState() {
    super.initState();
    animationController =
        AnimationController(vsync: this, duration: Duration(seconds: 3));
    animationController.reverse(
        from:
            animationController.value == 0.0 ? 1.0 : animationController.value);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: WillPopScope(
        onWillPop: onWillPop,
        child: Scaffold(
          backgroundColor: Color(0xfff9f9f9),
          body: Scrollbar(
            child: ListView(
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  verticalDirection: VerticalDirection.down,
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 15.0),
                      child: Container(
                        child: Padding(
                          padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
                          child: Column(
                            children: <Widget>[
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  PopupMenuButton(
                                    child: Container(
                                      width: 40.0,
                                      height: 40.0,
                                      decoration: new BoxDecoration(
                                          color: AbubaPallate.greenabuba,
                                          shape: BoxShape.circle,
                                          border: Border.all(
                                            color: Colors.white,
                                            width: 3.0,
                                          ),
                                          image: DecorationImage(
                                              image: NetworkImage(
                                                  'https://image.flaticon.com/icons/png/512/149/149071.png'),
                                              fit: BoxFit.cover)),
                                    ),
                                    elevation: 3.2,
                                    onCanceled: () {},
                                    tooltip: 'Tooltip',
                                    onSelected: (val) {
                                      showDialog(
                                          barrierDismissible: false,
                                          context: context,
                                          builder: (context) => AlertDialog(
                                                title: Text('Are you sure?'),
                                                content: Text(
                                                    'Do you want to sign out ?'),
                                                actions: <Widget>[
                                                  FlatButton(
                                                    onPressed: () =>
                                                        Navigator.of(context)
                                                            .pop(false),
                                                    child: Text('No'),
                                                  ),
                                                  FlatButton(
                                                    onPressed: () async {
                                                      await _auth
                                                          .signOut()
                                                          .then((_) {
                                                        Navigator.pushReplacement(
                                                            context,
                                                            MaterialPageRoute(
                                                                builder: (_) =>
                                                                    LoginPage()));
                                                      });
                                                    },
                                                    child: Text('Yes'),
                                                  )
                                                ],
                                              ));
                                    },
                                    itemBuilder: (BuildContext context) {
                                      return [
                                        PopupMenuItem(
                                          value: 'signout',
                                          child: Text('Sign Out'),
                                        )
                                      ];
                                    },
                                  ),
                                  Flexible(
                                    child: Column(
                                      children: <Widget>[
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              left: 10.0,
                                              right: 5.0,
                                              bottom: 2.5),
                                          child: Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment.start,
                                            children: <Widget>[
                                              Flexible(
                                                child: Text(
                                                  'Hello,',
                                                  style: TextStyle(
                                                      fontSize: 14.0,
                                                      fontWeight:
                                                      FontWeight.w600,
                                                      color: Colors.black54,
                                                      letterSpacing: 1.0),
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              left: 10.0,
                                              right: 5.0,
                                              bottom: 0.0),
                                          child: Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment.start,
                                            children: <Widget>[
                                              Flexible(
                                                child: Text(
                                                  widget.namaUser ?? '-',
                                                  style: TextStyle(
                                                    fontSize: 16.0,
                                                    fontWeight: FontWeight.w600,
                                                    color: Colors.black,
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Stack(
                                    children: <Widget>[
                                      Icon(Icons.notifications, color: Colors.grey[400],)
                                    ],
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0),
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(25.0),
                        bottomRight: Radius.circular(5.0),
                        topRight: Radius.circular(5.0),
                        topLeft: Radius.circular(5.0),
                      ),
                    ),
                    semanticContainer: true,
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    child: Stack(
                      children: <Widget>[
                        Image.asset(
                          'assets/images/Line_graph.png',
                          fit: BoxFit.fill,
                        ),
                        Container(
                          margin: EdgeInsets.all(10.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                'Your Performance',
                                style: TextStyle(
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.white),
                              ),
                              Text(
                                '90%',
                                style: TextStyle(
                                    fontSize: 24.0,
                                    fontWeight: FontWeight.w700,
                                    color: Colors.white),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    elevation: 5.0,
                  ),
                ),
                SizedBox(
                  height: 15.0,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      // isoft
                      GestureDetector(
                        onTap: () => Navigator.push(
                            context,
                            MyCustomRoute(
                                builder: (context) => BerandaIsoft(
                                      idUser: widget.idUser,
                                      namaUser: widget.namaUser,
                                      departmentUser: widget.departmentUser,
                                    ))),
                        child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(10.0),
                              bottomRight: Radius.circular(10.0),
                              topRight: Radius.circular(10.0),
                              topLeft: Radius.circular(10.0),
                            ),
                          ),
                          elevation: 5.0,
                          child: Container(
                            width: MediaQuery.of(context).size.width * 0.28,
                            margin: EdgeInsets.symmetric(vertical: 10.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Image.asset(
                                  'assets/images/home page/isoft.png',
                                  width: 45.0,
                                  height: 45.0,
                                ),
                                SizedBox(
                                  height: 5.0,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Flexible(
                                      child: Text(
                                        'Isoft',
                                        style: TextStyle(
                                            fontWeight: FontWeight.w400),
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                      ),

                      // six sigma
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MyCustomRoute(
                                  builder: (context) => BerandaSigma(
                                      idUser: widget.idUser,
                                      namaUser: widget.namaUser,
                                      departmentUser: widget.departmentUser)));
                        },
                        child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(10.0),
                              bottomRight: Radius.circular(10.0),
                              topRight: Radius.circular(10.0),
                              topLeft: Radius.circular(10.0),
                            ),
                          ),
                          elevation: 5.0,
                          child: Container(
                            width: MediaQuery.of(context).size.width * 0.28,
                            margin: EdgeInsets.symmetric(vertical: 10.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Image.asset(
                                  'assets/images/home page/six sigma.png',
                                  width: 45.0,
                                  height: 45.0,
                                ),
                                SizedBox(
                                  height: 5.0,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Flexible(
                                        child: Text('Six Sigma',
                                            style: TextStyle(
                                                fontWeight: FontWeight.w400)))
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),

                      // mystery shopper
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MyCustomRoute(
                                  builder: (context) => BerandaMG(
                                      idUser: widget.idUser,
                                      aksesStatus: widget.aksesStatus)));
                        },
                        child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(10.0),
                              bottomRight: Radius.circular(10.0),
                              topRight: Radius.circular(10.0),
                              topLeft: Radius.circular(10.0),
                            ),
                          ),
                          elevation: 5.0,
                          child: Container(
                            width: MediaQuery.of(context).size.width * 0.28,
                            margin: EdgeInsets.symmetric(vertical: 10.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Image.asset(
                                  'assets/images/home page/mystery shopper.png',
                                  width: 45.0,
                                  height: 45.0,
                                ),
                                SizedBox(
                                  height: 5.0,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Flexible(
                                        child: Text('Mystery Shopper',
                                            style: TextStyle(
                                                fontWeight: FontWeight.w400)))
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 20.0,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(left: 5.0),
                        child: Text(
                          "Best Employee",
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
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 15.0),
                  margin: EdgeInsets.symmetric(vertical: 10.0),
                  height: 130.0,
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
                                  : ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: nama.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      Padding(
                                        padding: EdgeInsets.all(10.0),
                                        child: Stack(
                                          overflow: Overflow.visible,
                                          children: <Widget>[
                                            Container(
                                              height: 70.0,
                                              width: 70.0,
                                              decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  shape: BoxShape.circle,
                                                  border: Border.all(
                                                    color: Colors.grey[300],
                                                    width: 3.0,
                                                  ),
                                                  // image: DecorationImage(
                                                  //   image: NetworkImage("https://image.flaticon.com/icons/png/512/149/149071.png"),
                                                  //   fit: BoxFit.cover
                                                  // )
                                                  image: DecorationImage(
                                                      image: AssetImage(
                                                        'assets/images/user/'+gambar[index],
                                                      ),
                                                      fit: BoxFit.cover
                                                  )
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(top: 5.0, right: 10.0, left: 10.0),
                                        child: Text(
                                          nama[index],
                                          style: TextStyle(fontSize: 13.0),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(top: 5.0, right: 10.0, left: 10.0),
                                        child: Text(
                                          department[index],
                                          style: TextStyle(fontSize: 12.0, fontWeight: FontWeight.w700),
                                        ),
                                      )
                                    ],
                                  );
                                },
                              );
                            },
                          )
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 15.0,
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
                  height: 10.0,
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
          ),
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
          icon: FlatButton(
            splashColor: Colors.transparent,
            color: Colors.transparent,
            disabledColor: Colors.transparent,
            disabledTextColor: Colors.transparent,
            highlightColor: Colors.transparent,
            onPressed: () {
              Navigator.push(
                  context,
                  MyCustomRoute(
                      builder: (_) => BerandaPage2(idUser: widget.idUser)));
            },
            padding: EdgeInsets.only(top: 10.0),
            child: Column(
              children: <Widget>[
                Icon(
                  Icons.timeline,
                  color: Colors.grey,
                ),
                SizedBox(
                  height: 2.0,
                ),
                Text('What\'s New',
                    style: TextStyle(
                        color: Colors.grey,
                        fontWeight: FontWeight.normal,
                        fontSize: 11.5))
              ],
            ),
          ),
          title: new Text(''),
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
              Navigator.push(
                  context,
                  MyCustomRoute(
                      builder: (_) => InboxPage(idUser: widget.idUser)));
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
                Text('Inbox',
                    style: TextStyle(
                        color: Colors.grey,
                        fontWeight: FontWeight.normal,
                        fontSize: 11.5))
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
              CollectionReference reference =
                  Firestore.instance.collection('maintenance_testing');
              reference.snapshots().listen((querySnapshot) {
                querySnapshot.documentChanges.forEach((change) {
                  setState(() {
                    outlet.add(change.document.data['outlet']);
                  });
                });
              });

              await new Future.delayed(Duration(milliseconds: 500));
              Navigator.push(
                  context,
                  MyCustomRoute(
                      builder: (_) => AccountPage(
                          idUser: widget.idUser, index: widget.index)
                      // builder: (_) => Testing(idUser: widget.idUser, departmentUser: widget.departmentUser, namaUser: widget.namaUser, count: outlet.length),
                      ));
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
                Text('Account',
                    style: TextStyle(
                        color: Colors.grey,
                        fontWeight: FontWeight.normal,
                        fontSize: 11.5))
              ],
            ),
          ),
          title: Text(''),
        ),
      ],
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
                              /* if (widget.document[index].data['likes'].contains(widget.idUser)) {
                                 setState(() {
                                   tempOutput.removeWhere((dynamic userID) => userID == widget.idUser);
                                 });
                                 var initialDataNoTimestamp = <String, dynamic>{
                                   'likes': tempOutput,
                                 };
                                 DocumentReference docReference = Firestore.instance.collection('whats-happening').document(widget.document[index].documentID);
                                 docReference.updateData(initialDataNoTimestamp).then((doc) {
                                   print('not like');
                                 }).catchError((error) {
                                   print('error');
                                 });
                               } else {
                                 setState(() {
                                   tempOutput.add(widget.idUser);
                                 });
                                 var initialDataNoTimestamp = <String, dynamic>{
                                   'likes': tempOutput,
                                 };
                                 DocumentReference docReference = Firestore.instance.collection('whats-happening').document(widget.document[index].documentID);
                                 docReference.updateData(initialDataNoTimestamp).then((doc) {
                                   print('liked');
                                 }).catchError((error) {
                                   print('error');
                                 });
                               }*/
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
