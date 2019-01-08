import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_abuba/constant.dart';
import 'package:flutter_abuba/beranda/beranda_appbardua.dart';
import 'package:intl/intl.dart';

class Inspection extends StatefulWidget {
  Inspection({this.material});

  final String material;

  @override
  _InspectionState createState() => _InspectionState();
}

class _InspectionState extends State<Inspection> {
  Color colorYesWaktu = Colors.green;
  Color colorNoWaktu = Colors.grey;

  Color colorYesJumlah = Colors.green;
  Color colorNoJumlah = Colors.grey;

  final dateFormatProduction = DateFormat("MMM d, yyyy");
  final dateFormatExpiry = DateFormat("MMM d, yyyy");
  DateTime dateProduction;
  DateTime dateExpiry;

  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomPadding: true,
        appBar: AbubaAppBar(),
        body: GestureDetector(
            onTap: () {
              FocusScope.of(context).requestFocus(FocusNode());
            },
            child: _buildFormInspection()),
      ),
    );
  }

  Widget _buildFormInspection() {
    return ListView(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Text(
                'Operational Process',
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
                  'Inspection',
                  style:
                      TextStyle(color: AbubaPallate.greenabuba, fontSize: 12.0),
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[Text(widget.material)],
          ),
        ),
        SizedBox(
          height: 15.0,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            children: <Widget>[
              SizedBox(
                width: MediaQuery.of(context).size.width,
                height: 42.0,
                child: Container(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            'Supplier Evaluation',
                            style:
                                TextStyle(color: Colors.white, fontSize: 14.0),
                            textAlign: TextAlign.start,
                          ),
                        ],
                      ),
                    ),
                    decoration: BoxDecoration(color: Color(0xFF2F592F))),
              ),
              ListTile(
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Flexible(
                      child: Text(
                        'Barang datang tepat waktu',
                        style: TextStyle(color: Colors.grey, fontSize: 13.0),
                        overflow: TextOverflow.clip,
                      ),
                    ),
                    Row(
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.all(5.0),
                          child: ButtonTheme(
                            minWidth: 40.0,
                            height: 30.0,
                            child: OutlineButton(
                              child: Icon(Icons.close, color: colorNoWaktu, size: 14.0),
                              borderSide:
                                  BorderSide(color: colorNoWaktu, width: 1.0),
                              highlightedBorderColor: colorNoWaktu,
                              onPressed: () {
                                setState(() {
                                  colorYesWaktu = Colors.grey;
                                  colorNoWaktu = Colors.red;
                                });
                              },
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(5.0),
                          child: ButtonTheme(
                            minWidth: 40.0,
                            height: 30.0,
                            child: OutlineButton(
                              child: Icon(Icons.check, color: colorYesWaktu, size: 14.0),
                              borderSide:
                                  BorderSide(color: colorYesWaktu, width: 1.0),
                              highlightedBorderColor: colorYesWaktu,
                              onPressed: () {
                                setState(() {
                                  colorYesWaktu = Colors.green;
                                  colorNoWaktu = Colors.grey;
                                });
                              },
                            ),
                          ),
                        ),
                        IconButton(
                          icon: Icon(Icons.help_outline,
                              color: Colors.transparent),
                          onPressed: null,
                        )
                      ],
                    )
                  ],
                ),
              ),
              ListTile(
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Flexible(
                      child: Text(
                        'Barang datang tepat jumlah',
                        style: TextStyle(color: Colors.grey, fontSize: 13.0),
                        overflow: TextOverflow.clip,
                      ),
                    ),
                    Row(
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.all(5.0),
                          child: ButtonTheme(
                            minWidth: 40.0,
                            height: 30.0,
                            child: OutlineButton(
                              child: Icon(Icons.close, color: colorNoJumlah, size: 14.0),
                              borderSide:
                                  BorderSide(color: colorNoJumlah, width: 1.0),
                              highlightedBorderColor: colorNoJumlah,
                              onPressed: () {
                                setState(() {
                                  colorYesJumlah = Colors.grey;
                                  colorNoJumlah = Colors.red;
                                });
                              },
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 5.0),
                          child: ButtonTheme(
                            minWidth: 40.0,
                            height: 30.0,
                            child: OutlineButton(
                              child: Icon(Icons.check, color: colorYesJumlah, size: 14.0),
                              borderSide:
                                  BorderSide(color: colorYesJumlah, width: 1.0),
                              highlightedBorderColor: colorYesJumlah,
                              onPressed: () {
                                setState(() {
                                  colorYesJumlah = Colors.green;
                                  colorNoJumlah = Colors.grey;
                                });
                              },
                            ),
                          ),
                        ),
                        IconButton(
                          icon: Icon(Icons.help_outline,
                              color: Colors.transparent),
                          onPressed: null,
                        )
                      ],
                    )
                  ],
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                height: 42.0,
                child: Container(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            'Parameter Atribut',
                            style:
                                TextStyle(color: Colors.white, fontSize: 14.0),
                            textAlign: TextAlign.start,
                          ),
                        ],
                      ),
                    ),
                    decoration: BoxDecoration(color: Color(0xFF2F592F))),
              ),
              ListTile(
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Flexible(
                      child: Text(
                        'CoA',
                        style: TextStyle(color: Colors.grey, fontSize: 13.0),
                        overflow: TextOverflow.clip,
                      ),
                    ),
                    Row(
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.all(5.0),
                          child: ButtonTheme(
                            minWidth: 40.0,
                            height: 30.0,
                            child: OutlineButton(
                              child: Icon(Icons.close, color: colorNoWaktu, size: 14.0),
                              borderSide:
                                  BorderSide(color: colorNoWaktu, width: 1.0),
                              highlightedBorderColor: colorNoWaktu,
                              onPressed: () {
                                setState(() {
                                  colorYesWaktu = Colors.grey;
                                  colorNoWaktu = Colors.red;
                                });
                              },
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(5.0),
                          child: ButtonTheme(
                            minWidth: 40.0,
                            height: 30.0,
                            child: OutlineButton(
                              child: Icon(Icons.check, color: colorYesWaktu, size: 14.0),
                              borderSide:
                                  BorderSide(color: colorYesWaktu, width: 1.0),
                              highlightedBorderColor: colorYesWaktu,
                              onPressed: () {
                                setState(() {
                                  colorYesWaktu = Colors.green;
                                  colorNoWaktu = Colors.grey;
                                });
                              },
                            ),
                          ),
                        ),
                        IconButton(
                          icon: Icon(
                            Icons.help_outline,
                          ),
                          onPressed: null,
                        )
                      ],
                    )
                  ],
                ),
              ),
              ListTile(
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Flexible(
                      child: Text(
                        'Kondisi Kemasan',
                        style: TextStyle(color: Colors.grey, fontSize: 13.0),
                        overflow: TextOverflow.clip,
                      ),
                    ),
                    Row(
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.all(5.0),
                          child: ButtonTheme(
                            minWidth: 40.0,
                            height: 30.0,
                            child: OutlineButton(
                              child: Icon(Icons.close, color: colorNoJumlah, size: 14.0),
                              borderSide:
                                  BorderSide(color: colorNoJumlah, width: 1.0),
                              highlightedBorderColor: colorNoJumlah,
                              onPressed: () {
                                setState(() {
                                  colorYesJumlah = Colors.grey;
                                  colorNoJumlah = Colors.red;
                                });
                              },
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(5.0),
                          child: ButtonTheme(
                            minWidth: 40.0,
                            height: 30.0,
                            child: OutlineButton(
                              child: Icon(Icons.check, color: colorYesJumlah, size: 14.0),
                              borderSide:
                                  BorderSide(color: colorYesJumlah, width: 1.0),
                              highlightedBorderColor: colorYesJumlah,
                              onPressed: () {
                                setState(() {
                                  colorYesJumlah = Colors.green;
                                  colorNoJumlah = Colors.grey;
                                });
                              },
                            ),
                          ),
                        ),
                        IconButton(
                          icon: Icon(Icons.help_outline),
                          onPressed: null,
                        )
                      ],
                    )
                  ],
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                height: 42.0,
                child: Container(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            'Parameter Variabel',
                            style:
                                TextStyle(color: Colors.white, fontSize: 14.0),
                            textAlign: TextAlign.start,
                          ),
                        ],
                      ),
                    ),
                    decoration: BoxDecoration(color: Color(0xFF2F592F))),
              ),
              ListTile(
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  verticalDirection: VerticalDirection.up,
                  children: <Widget>[
                    Flexible(
                      child: Text(
                        'Suhu',
                        style: TextStyle(color: Colors.grey, fontSize: 13.0),
                        overflow: TextOverflow.clip,
                      ),
                    ),
                    Row(
                      children: <Widget>[
                        Container(
                          width: 120.0,
                          child: TextField(
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                                hintText: 'Suhu',
                                hintStyle: TextStyle(fontSize: 12.0)),
                            style: TextStyle(
                              color: Colors.black,
                            ),
                          ),
                        ),
                        IconButton(
                          icon: Icon(Icons.help_outline),
                          onPressed: null,
                        )
                      ],
                    )
                  ],
                ),
              ),
              ListTile(
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  verticalDirection: VerticalDirection.up,
                  children: <Widget>[
                    Flexible(
                      child: Text(
                        'Berat',
                        style: TextStyle(color: Colors.grey, fontSize: 13.0),
                        overflow: TextOverflow.clip,
                      ),
                    ),
                    Row(
                      children: <Widget>[
                        Container(
                          width: 120.0,
                          child: TextField(
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                                hintText: 'Berat',
                                hintStyle: TextStyle(fontSize: 12.0)),
                            style: TextStyle(
                              color: Colors.black,
                            ),
                          ),
                        ),
                        IconButton(
                          icon: Icon(Icons.help_outline),
                          onPressed: null,
                        )
                      ],
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: 42.0,
                  child: Container(
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              'Traceability',
                              style: TextStyle(
                                  color: Colors.white, fontSize: 14.0),
                              textAlign: TextAlign.start,
                            ),
                          ],
                        ),
                      ),
                      decoration: BoxDecoration(color: Color(0xFF2F592F))),
                ),
              ),
              ListTile(
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  verticalDirection: VerticalDirection.up,
                  children: <Widget>[
                    Flexible(
                      child: Text(
                        'Production Date',
                        style: TextStyle(color: Colors.grey, fontSize: 13.0),
                        overflow: TextOverflow.clip,
                      ),
                    ),
                    Row(
                      children: <Widget>[
                        Container(
                          width: 120.0,
                          child: DateTimePickerFormField(
                            format: dateFormatProduction,
                            onChanged: (dt) => setState(() => dateProduction = dt),
                            dateOnly: true,
                            style: TextStyle(
                              fontSize: 12.0,
                              color: Colors.black
                            ),
                            decoration:
                                InputDecoration(
                                  border: UnderlineInputBorder(),
                                  hintText: 'Production Date',
                                  hintStyle: TextStyle(
                                    fontSize: 12.0
                                  )
                                ),
                          ),
                        ),
                        IconButton(
                          icon: Icon(Icons.help_outline,
                              color: Colors.transparent),
                          onPressed: null,
                        )
                      ],
                    )
                  ],
                ),
              ),
              ListTile(
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  verticalDirection: VerticalDirection.up,
                  children: <Widget>[
                    Expanded(
                      child: Text(
                        'Expiry Date',
                        style: TextStyle(color: Colors.grey, fontSize: 13.0),
                        overflow: TextOverflow.clip,
                      ),
                    ),
                    Row(
                      children: <Widget>[
                        Container(
                          width: 120.0,
                          child: DateTimePickerFormField(
                            format: dateFormatExpiry,
                            onChanged: (dt) => setState(() => dateExpiry = dt),
                            dateOnly: true,
                            style: TextStyle(
                              fontSize: 12.0,
                              color: Colors.black
                            ),
                            decoration:
                              InputDecoration(
                                border: UnderlineInputBorder(),
                                hintText: 'Expiry Date',
                                hintStyle: TextStyle(
                                  fontSize: 12.0
                                )
                              ),
                          ),
                        ),
                        IconButton(
                          icon: Icon(Icons.help_outline,
                              color: Colors.transparent),
                          onPressed: null,
                        )
                      ],
                    )
                  ],
                ),
              ),
              ListTile(
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  verticalDirection: VerticalDirection.up,
                  children: <Widget>[
                    Expanded(
                      child: Text(
                        'Internal Lot #',
                        style: TextStyle(color: Colors.grey, fontSize: 13.0),
                        overflow: TextOverflow.clip,
                      ),
                    ),
                    Row(
                      children: <Widget>[
                        Container(
                          width: 120.0,
                          child: TextField(
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                                hintText: 'Internal Lot #',
                                hintStyle: TextStyle(fontSize: 12.0)),
                            style: TextStyle(
                              color: Colors.black,
                            ),
                          ),
                        ),
                        IconButton(
                            icon: Icon(Icons.help_outline), onPressed: null)
                      ],
                    )
                  ],
                ),
              ),
              ListTile(
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  verticalDirection: VerticalDirection.up,
                  children: <Widget>[
                    Expanded(
                      child: Text(
                        'Quantity',
                        style: TextStyle(color: Colors.grey, fontSize: 13.0),
                        overflow: TextOverflow.clip,
                      ),
                    ),
                    Row(
                      children: <Widget>[
                        Container(
                          width: 120.0,
                          child: TextField(
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                                hintText: 'Quantity',
                                hintStyle: TextStyle(fontSize: 12.0)),
                            style: TextStyle(
                              color: Colors.black,
                            ),
                          ),
                        ),
                        IconButton(
                          icon: Icon(Icons.help_outline,
                              color: Colors.transparent),
                          onPressed: null,
                        )
                      ],
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: 42.0,
                  child: Container(
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              'Status',
                              style: TextStyle(
                                  color: Colors.white, fontSize: 14.0),
                              textAlign: TextAlign.start,
                            ),
                          ],
                        ),
                      ),
                      decoration: BoxDecoration(color: Color(0xFF2F592F))),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 15.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    ButtonTheme(
                      minWidth: 50.0,
                      height: 30.0,
                      child: OutlineButton(
                        child: Text(
                          'REJECT',
                          style: TextStyle(fontSize: 13.0),
                        ),
                        textColor: AbubaPallate.menuDeals,
                        borderSide: BorderSide(color: AbubaPallate.menuDeals),
                        onPressed: () {},
                      ),
                    ),
                    ButtonTheme(
                      minWidth: 50.0,
                      height: 30.0,
                      child: OutlineButton(
                        child: Text(
                          'CONCESSION',
                          style: TextStyle(fontSize: 13.0),
                        ),
                        textColor: AbubaPallate.menuBluebird,
                        borderSide:
                            BorderSide(color: AbubaPallate.menuBluebird),
                        onPressed: () {},
                      ),
                    ),
                    ButtonTheme(
                      minWidth: 50.0,
                      height: 30.0,
                      child: OutlineButton(
                        child: Text(
                          'APPROVE',
                          style: TextStyle(fontSize: 13.0),
                        ),
                        textColor: Colors.green,
                        borderSide: BorderSide(color: AbubaPallate.greenabuba),
                        onPressed: () {},
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
