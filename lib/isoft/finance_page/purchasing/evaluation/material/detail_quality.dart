import 'package:flutter/material.dart';
import 'package:flutter_abuba/constant.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class DetailQuality extends StatefulWidget {
  @override
  _DetailQualityState createState() => _DetailQualityState();
}

class _DetailQualityState extends State<DetailQuality> {
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
        body: _buildIsoMenu(),
      ),
    );
  }

  Widget _buildIsoMenu() {
    return ListView(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Text(
                'Evaluation',
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
                  'Detail Quality',
                  style:
                      TextStyle(color: AbubaPallate.greenabuba, fontSize: 12.0),
                ),
              ),
            ],
          ),
        ),
        Container(
          width: MediaQuery.of(context).size.width,
          color: Colors.white,
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text('PT Supplier'),
                        SizedBox(
                          height: 3.0,
                        ),
                        Text(
                          '123456',
                          style:
                              TextStyle(fontSize: 12.0, color: Colors.black54),
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          'APPROVED',
                          style: TextStyle(
                              fontSize: 14.0, color: AbubaPallate.greenabuba),
                        ),
                        Text(''),
                      ],
                    )
                  ],
                ),
              ),
              Divider(
                height: 0.0,
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(12.0, 12.0, 12.0, 12.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Flexible(
                      child: Text(
                        'Performance',
                        style: TextStyle(color: AbubaPallate.greenabuba),
                      ),
                    ),
                    Flexible(
                      child: Text(
                        '01 Jan 2018 - 30 Des 2018',
                        style: TextStyle(color: Colors.black54, fontSize: 10.0),
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(12.0, 0.0, 12.0, 8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Flexible(
                          child: Text(
                            '29%',
                            style: TextStyle(
                                color: Colors.black87, fontSize: 14.0),
                          ),
                        )
                      ],
                    ),
                    LinearPercentIndicator(
                      alignment: MainAxisAlignment.center,
                      width: 330.0,
                      animation: true,
                      lineHeight: 30.0,
                      percent: 0.29,
                      animationDuration: 1000,
                      linearStrokeCap: LinearStrokeCap.butt,
                      progressColor: Colors.green[300],
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(12.0, 0.0, 12.0, 2.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Flexible(
                      child: Text(
                        'Total delivery',
                        style: TextStyle(fontSize: 12.0, color: Colors.black38),
                      ),
                    ),
                    Flexible(
                      child: Text(
                        '# Rejected',
                        style: TextStyle(fontSize: 12.0, color: Colors.black38),
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(12.0, 0.0, 12.0, 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Flexible(
                      child: Text(
                        '100',
                        style: TextStyle(
                            fontSize: 13.0,
                            color: Colors.black54,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                    Flexible(
                      child: Text(
                        '4',
                        style: TextStyle(
                            fontSize: 13.0,
                            color: Colors.black54,
                            fontWeight: FontWeight.w600),
                      ),
                    )
                  ],
                ),
              ),
              Divider(
                height: 8.0,
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(12.0, 8.0, 12.0, 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Flexible(
                      child: Text(
                        'Detail Rejection',
                        style: TextStyle(color: AbubaPallate.greenabuba),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(12.0, 0.0, 12.0, 12.0),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  child: bodyData(),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget bodyData() => DataTable(
        onSelectAll: (b) {},
        sortColumnIndex: 1,
        sortAscending: true,
        columns: <DataColumn>[
          DataColumn(
            label: Text("Tanggal"),
            numeric: false,
            onSort: (i, b) {
              print("$i $b");
              setState(() {
                names.sort((a, b) => a.firstName.compareTo(b.firstName));
              });
            },
            tooltip: "To display first name of the Name",
          ),
          DataColumn(
            label: Text("Material"),
            numeric: false,
            onSort: (i, b) {
              print("$i $b");
              setState(
                () {
                  names.sort((a, b) => a.firstName.compareTo(b.firstName));
                },
              );
            },
            tooltip: "To display first name of the Name",
          ),
        ],
        rows: names
            .map(
              (name) => DataRow(
                    cells: [
                      DataCell(
                        Text(name.firstName),
                        showEditIcon: false,
                        placeholder: false,
                      ),
                      DataCell(
                        Text(name.lastName),
                        showEditIcon: false,
                        placeholder: false,
                      )
                    ],
                  ),
            )
            .toList(),
      );
}

class Name {
  String firstName;
  String lastName;

  Name({this.firstName, this.lastName});
}

var names = <Name>[
  Name(firstName: "Pawan", lastName: "Kumar"),
  Name(firstName: "Aakash", lastName: "Tewari"),
  Name(firstName: "Rohan", lastName: "Singh"),
];
