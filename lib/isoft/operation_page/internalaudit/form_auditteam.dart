import 'package:flutter/material.dart';
import 'package:flutter_abuba/constant.dart';

class FormAuditTeam extends StatefulWidget {
  @override
  _FormAuditTeamState createState() => _FormAuditTeamState();
}

class _FormAuditTeamState extends State<FormAuditTeam> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: _appBar(),
          body: TabBarView(
            children: <Widget>[_buildDaftarForm(), _buildTrackForm()],
          ),
        ),
      ),
    );
  }
}

Widget _buildDaftarForm() {
  return ListView(
    children: <Widget>[
      Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            SizedBox(
              width: 150.0,
              height: 35.0,
              child: Container(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        'Auditor',
                        style: TextStyle(color: Colors.white, fontSize: 14.0),
                        textAlign: TextAlign.start,
                      ),
                    ],
                  ),
                ),
                decoration: BoxDecoration(
                  color: Color(0xFF2F592F),
                ),
              ),
            ),
            SizedBox(
              width: 150.0,
              height: 35.0,
              child: Container(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        'Tgl Training',
                        style: TextStyle(color: Colors.white, fontSize: 14.0),
                        textAlign: TextAlign.start,
                      ),
                    ],
                  ),
                ),
                decoration: BoxDecoration(
                  color: Color(0xFF2F592F),
                ),
              ),
            ),
          ],
        ),
      ),
      Padding(
        padding: const EdgeInsets.only(right: 20.0, left: 20.0, bottom: 10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Container(
              width: 150.0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Flexible(
                    child: Text(
                      'Ridwan Surgawi',
                      style: TextStyle(color: Colors.grey[500]),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              width: 150.0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Flexible(
                    child: Text(
                      '17/09/2018',
                      style: TextStyle(color: Colors.grey[500]),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
      Padding(
        padding: const EdgeInsets.only(right: 20.0, left: 20.0, bottom: 10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Container(
              width: 150.0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Flexible(
                    child: Text(
                      'Yani',
                      style: TextStyle(color: Colors.grey[500]),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              width: 150.0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Flexible(
                    child: Text(
                      '18/09/2018',
                      style: TextStyle(color: Colors.grey[500]),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    ],
  );
}

Widget _buildTrackForm() {
  return ListView(
    children: <Widget>[
      Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Column(
              children: <Widget>[
                Text(
                  '17/09/2018',
                  style: TextStyle(color: Colors.black54),
                ),
                Text('Last Audit', style: TextStyle(color: AbubaPallate.greenabuba))
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  width: 100.0,
                  height: 100.0,
                  margin: EdgeInsets.only(bottom: 10.0),
                  decoration: new BoxDecoration(
                    shape: BoxShape.circle,
                    border:
                        Border.all(color: AbubaPallate.greenabuba, width: 3.0),
                    image: new DecorationImage(
                      fit: BoxFit.fill,
                      image: NetworkImage(
                          "https://www.biography.com/.image/ar_1:1%2Cc_fill%2Ccs_srgb%2Cg_face%2Cq_auto:good%2Cw_300/MTE5NTU2MzE2NDE4MzExNjkx/jackie-chan-9542080-1-402.jpg"),
                    ),
                  ),
                ),
                Text("John Doe", textScaleFactor: 1.5, style: TextStyle(color: AbubaPallate.greenabuba))
              ],
            ),
            Column(
              children: <Widget>[
                Text(
                  'HRD',
                  style: TextStyle(color: Colors.black54),
                ),
                Text('Departemen', style: TextStyle(color: AbubaPallate.greenabuba),)
              ],
            ),
          ],
        ),
      ),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25.0),
        child: Row(
          children: <Widget>[
            Flexible(
                child: Text(
              '“ Prinsip saya dalam mengaudit adalah memastikan auditee nya ada untuk diaudit"',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.black54, fontStyle: FontStyle.italic),
            )),
          ],
        ),
      ),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 40.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Column(
              children: <Widget>[
                Text(
                  '5',
                  style: TextStyle(color: AbubaPallate.greenabuba, fontSize: 25.0, fontWeight: FontWeight.bold),
                ),
                Text(
                  'Auditor',
                  style: TextStyle(color: Colors.black54),
                ),
              ],
            ),
            Column(
              children: <Widget>[
                Text(
                  '5',
                  style: TextStyle(color: AbubaPallate.greenabuba, fontSize: 25.0, fontWeight: FontWeight.bold),
                ),
                Text('Auditee', style: TextStyle(color: Colors.black54)),
              ],
            ),
            Column(
              children: <Widget>[
                Text(
                  '5',
                  style: TextStyle(color: AbubaPallate.greenabuba, fontSize: 25.0, fontWeight: FontWeight.bold),
                ),
                Text('CAR Issued', style: TextStyle(color: Colors.black54)),
              ],
            ),
          ],
        ),
      ),
    ],
  );
}

Widget _appBar() {
  return AppBar(
    elevation: 0.25,
    backgroundColor: Colors.white,
    iconTheme: IconThemeData(color: Colors.black),
    title: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Image.asset(
          'assets/images/logo2.png',
          height: 150.0,
          width: 120.0,
        ),
        new Container(
          child: new Row(
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(right: 15.0),
                child: Row(
                  children: [
                    Icon(
                      Icons.favorite,
                      color: Colors.red[500],
                      size: 20.0,
                    ),
                    SizedBox(
                      width: 5.0,
                    ),
                    Text(
                      '41 pts',
                      style: TextStyle(fontSize: 12.0, color: Colors.grey),
                    ),
                  ],
                ),
              )
            ],
          ),
        )
      ],
    ),
    bottom: new TabBar(
      isScrollable: false,
      indicatorColor: AbubaPallate.greenabuba,
      tabs: <Widget>[
        new Tab(
          child: Text(
            'Daftar',
            style: TextStyle(color: Colors.grey[400]),
          ),
        ), // 1st Tab
        new Tab(
          child: Text(
            'Track Record',
            style: TextStyle(color: Colors.grey[400]),
          ),
        ), // 1st Tab
      ],
    ),
  );
}
