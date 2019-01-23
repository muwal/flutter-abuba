import 'package:flutter/material.dart';
import 'package:flutter_abuba/constant.dart';
import 'package:flutter_abuba/beranda/beranda_appbardua.dart';

class FormCariLokasi extends StatefulWidget {
  @override
  _FormCariLokasiState createState() => _FormCariLokasiState();
}

class _FormCariLokasiState extends State<FormCariLokasi> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AbubaAppBar(),
        body: _buildMenu(),
      ),
    );
  }

  Widget _buildMenu() {
    return Scrollbar(
      child: ListView(
        children: <Widget>[
          Container(
            height: 400.0,
            width: MediaQuery.of(context).size.width,
            color: Colors.white,
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        'Mystery Shopper',
                        style: TextStyle(color: Colors.black12, fontSize: 12.0),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 15.0),
                        child: Text(
                          '|',
                          style: TextStyle(
                              color: AbubaPallate.greenabuba, fontSize: 12.0),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 15.0),
                        child: Text(
                          'Location',
                          style: TextStyle(
                              color: AbubaPallate.greenabuba, fontSize: 12.0),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(20.0, 100.0, 20.0, 20.0),
                  child: Column(
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Flexible(
                            child: Text(
                              'Welcome to ABUBA Paris',
                              style: TextStyle(
                                  color: AbubaPallate.greenabuba,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 20.0),
                            ),
                          )
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Flexible(
                            child: Text(
                              'Jl Paris Raya no 18 C South France 172345',
                              style: TextStyle(
                                  fontSize: 14.0, color: Colors.black54),
                            ),
                          )
                        ],
                      ),
                      SizedBox(height: 30.0,),
                      ButtonTheme(
                        minWidth: 50.0,
                        height: 40.0,
                        child: RaisedButton(
                          shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(5.0)),
                          child: Text(
                            'CHECK IN',
                            style: TextStyle(fontSize: 13.0, color: Colors.white),
                          ),
                          color: Colors.green,
                          onPressed: () {
                            Navigator.push(context,
                                MyCustomRoute(builder: (context) => FormSuasanaResto()));
                          },
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
          Container(
            child: Image.asset(
              'assets/images/slide2.png',
              fit: BoxFit.fitWidth,
            ),
          )
        ],
      ),
    );
  }
}

class FormSuasanaResto extends StatefulWidget {
  @override
  _FormSuasanaRestoState createState() => _FormSuasanaRestoState();
}

class _FormSuasanaRestoState extends State<FormSuasanaResto> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AbubaAppBar(),
        body: _buildMenu(),
      ),
    );
  }

  Widget _buildMenu() {
    return Scrollbar(
      child: ListView(
        children: <Widget>[
          Container(
            height: 400.0,
            width: MediaQuery.of(context).size.width,
            color: Colors.white,
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        'Mystery Shopper',
                        style: TextStyle(color: Colors.black12, fontSize: 12.0),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 15.0),
                        child: Text(
                          '|',
                          style: TextStyle(
                              color: AbubaPallate.greenabuba, fontSize: 12.0),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 15.0),
                        child: Text(
                          'Location',
                          style: TextStyle(
                              color: AbubaPallate.greenabuba, fontSize: 12.0),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(20.0, 100.0, 20.0, 20.0),
                  child: Column(
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Flexible(
                            child: Text(
                              'Perhatikan suasana resto',
                              style: TextStyle(
                                  color: AbubaPallate.greenabuba,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 20.0),
                            ),
                          )
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Flexible(
                            child: Text(
                              'Pilih tempat duduk yang memudahkan Anda melihat suasana resto secara utuh',
                              style: TextStyle(
                                  fontSize: 14.0, color: Colors.black54),
                              textAlign: TextAlign.center,
                            ),
                          )
                        ],
                      ),
                      SizedBox(height: 30.0,),
                      ButtonTheme(
                        minWidth: 50.0,
                        height: 40.0,
                        child: RaisedButton(
                          shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(5.0)),
                          child: Text(
                            'PAHAM',
                            style: TextStyle(fontSize: 13.0, color: Colors.white),
                          ),
                          color: Colors.blueAccent,
                          onPressed: () {},
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
          Container(
            child: Image.asset(
              'assets/images/slide3.png',
              fit: BoxFit.fitWidth,
            ),
          )
        ],
      ),
    );
  }
}

/*GridView.count(
crossAxisCount: 2,
childAspectRatio: 2.0,
padding: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 8.0),
mainAxisSpacing: 4.0,
crossAxisSpacing: 2.0,
children: <String>[
'assets/images/slide2.png',
'assets/images/slide2.png',
'assets/images/slide2.png',
'assets/images/slide2.png',
'assets/images/slide2.png',
'assets/images/slide2.png',
].map(
(String url) {
return new GridTile(
child: new Image.asset(
url,
fit: BoxFit.scaleDown,
),
);
},
).toList()),*/
