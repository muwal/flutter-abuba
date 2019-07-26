import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_abuba/constant.dart';
import 'package:flutter_abuba/isoft/operation_page/correctiveaction/form_reportcar.dart';
import 'package:flutter_circular_chart/flutter_circular_chart.dart';
import 'package:intl/intl.dart';

class PraReportCar extends StatefulWidget {
  PraReportCar({this.idUser, this.namaUser, this.departmentUser, this.persen, this.unclosedCAR, this.closedCAR, this.grafik, this.grafikText});

  final int idUser;
  final String namaUser;
  final String departmentUser;
  final double persen;
  var closedCAR;
  var unclosedCAR;
  var grafik;
  final String grafikText;

  @override
  _PraReportCarState createState() => _PraReportCarState();
}

class _PraReportCarState extends State<PraReportCar> with TickerProviderStateMixin {
  final GlobalKey<AnimatedCircularChartState> _chartKey = new GlobalKey<AnimatedCircularChartState>();
  AnimationController animationController;

  var ratingChiller = 0.0;
  TextEditingController controllerNoteSatu = new TextEditingController();

  final dateFormat = DateFormat("MMMM d, yyyy");
  DateTime dateStart;
  DateTime dateEnd;

  bool showDataFiltered = false;
  bool showHelper = false;
  String helperText = '';

  double closedPersen = 0.0;

  List<dynamic> tanggalList = [];
  List<dynamic> kategoriList = [];
  List<dynamic> departmentList = [];
  List<dynamic> noCarList = [];
  List<dynamic> statusList = [];
  List<dynamic> docIDList = [];

  List<dynamic> tanggal = [];
  List<dynamic> kategori = [];
  List<dynamic> department = [];
  List<dynamic> noCar = [];
  List<dynamic> status = [];

  var docID = [];

  var _searchEdit = new TextEditingController();

  bool _isSearch = true;
  String _searchText = "";

  _PraReportCarState() {
    _searchEdit.addListener(() {
      if (_searchEdit.text.isEmpty) {
        setState(() {
          _isSearch = true;
          _searchText = "";
        });
      } else {
        setState(() {
          _isSearch = false;
          _searchText = _searchEdit.text;
        });
      }
    });
  }
  
  int departmentIDUser;

  @override
  void initState() {
    super.initState();

    Firestore.instance.collection('user').where('id', isEqualTo: widget.idUser).snapshots().listen((data2) {
      setState(() {
        departmentIDUser = data2.documents[0].data['departmentID'];
      });
    });

    CollectionReference reference = Firestore.instance.collection('correctiveAction');
    reference.snapshots().listen((data) {
      data.documentChanges.forEach((change) {
        if (departmentIDUser == change.document.data['departmentDituju']) {
          setState(() {
            status.add(change.document.data['status']);
            tanggal.add(change.document.data['dateCreated']);
            noCar.add(change.document.data['carNo']);
            docID.add(change.document.documentID);

            Firestore.instance.collection('correctiveAction_category').where('id', isEqualTo: change.document.data['category']).snapshots().listen((data2) {
              kategori.add(data2.documents[0].data['category']);
            });

            Firestore.instance.collection('user').where('id', isEqualTo: change.document.data['userDituju']).snapshots().listen((data3) {
              department.add(data3.documents[0].data['department']);
            });
          });
        }
      });
    });

    animationController = AnimationController(vsync: this, duration: Duration(seconds: 3));
    animationController.reverse(
        from: animationController.value == 0.0
            ? 1.0
            : animationController.value
    );
  }

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;

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
        body: GestureDetector(
          onTap: () {
            FocusScope.of(context).requestFocus(FocusNode());
          },
            child: AnimatedBuilder(animation: animationController, builder: (_, Widget child){
              return animationController.isAnimating
                  ? Container (
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              ) :
              Column(
                children: <Widget>[
                  Container(
                    margin: const EdgeInsets.only(bottom: 10.0, right: 15.0, left: 15.0, top: 10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          'Corrective Action',
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
                            'Report',
                            style:
                            TextStyle(color: AbubaPallate.greenabuba, fontSize: 12.0),
                          ),
                        ),
                      ],
                    ),
                  ),
                  _searchBox(),
                  Container(
                    color: Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5.0),
                      child: Center(
                        child: new AnimatedCircularChart(
                          key: _chartKey,
                          size: Size(width * 0.35, width * 0.35),
                          initialChartData: <CircularStackEntry>[
                            new CircularStackEntry(
                              <CircularSegmentEntry>[
                                new CircularSegmentEntry(
                                  widget.grafik,
                                  Colors.blue[400],
                                  rankKey: 'completed',
                                ),
                                new CircularSegmentEntry(
                                  100.0 - widget.grafik,
                                  Colors.blueGrey[600],
                                  rankKey: 'remaining',
                                ),
                              ],
                              rankKey: 'progress',
                            ),
                          ],
                          chartType: CircularChartType.Radial,
                          percentageValues: true,
                          holeLabel: widget.grafik == 0 ? '0%' : double.tryParse(widget.grafikText) >= 100.0 ? '100%' : '${widget.grafikText}%',
                          labelStyle: new TextStyle(
                            color: Colors.blueGrey[600],
                            fontWeight: FontWeight.bold,
                            fontSize: 24.0,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: width,
                    color: Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Container(
                            width: width * 0.2,
                            child: Row(
                              children: <Widget>[
                                Flexible(
                                  child: Text(
                                    'Date',
                                    style: TextStyle(color: Colors.green, fontWeight: FontWeight.w600),
                                  ),
                                )
                              ],
                            ),
                          ),
                          Container(
                            width: width * 0.4,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Flexible(
                                  child: Text(
                                    'Detail',
                                    style: TextStyle(color: Colors.green, fontWeight: FontWeight.w600),
                                  ),
                                )
                              ],
                            ),
                          ),
                          Container(
                            width: width * 0.3,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: <Widget>[
                                Flexible(
                                  child: Text(
                                    'Status',
                                    style: TextStyle(color: Colors.green, fontWeight: FontWeight.w600),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  _isSearch ? _listView(width) : _searchListView()
                ],
              );
            })
        ),
      ),
    );
  }

  Widget _searchBox() {
    return new Container(
      margin: const EdgeInsets.only(bottom: 10.0, right: 15.0, left: 15.0),
      decoration: BoxDecoration(border: Border.all(width: 1.0, color: Colors.white), borderRadius: BorderRadius.circular(25.0), color: Colors.white  ),
      child: new TextField(
        controller: _searchEdit,
        decoration: InputDecoration(
            hintText: "Search",
            hintStyle: new TextStyle(color: Colors.black54),
            prefixIcon: Icon(Icons.search),
            prefixStyle: TextStyle(color: Colors.green),
            border: InputBorder.none
        ),
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget _listView(width) {
    return new Flexible(
      child: ListView.builder(
          itemCount: status.length,
          itemBuilder: (BuildContext context, int index) {
            Timestamp date = tanggal[index];
            DateTime dateBantu = DateTime.tryParse(date.toDate().toString());

            // if (status[index] == 'CLOSED') {
              return Container(
                width: width,
                color: Colors.white,
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5.0),
                      child: ListTile(
                        leading: Container(
                          padding: EdgeInsets.only(top: 5.0),
                          alignment: Alignment.center,
                          width: MediaQuery.of(context).size.width * 0.3,
                          child: Row(
                            children: <Widget>[
                              Flexible(
                                child: Text(
                                  date.toDate().toString().substring(8, 10) + '/' + date.toDate().toString().substring(5, 7) + '/' + date.toDate().toString().substring(0, 4),
                                  style: TextStyle(
                                      fontSize: 12.0, color: Colors.black54),
                                ),
                              )
                            ],
                          ),
                        ),
                        title: Container(
                            alignment: Alignment.center,
                            width: MediaQuery.of(context).size.width * 0.3,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Container(
                                  width: MediaQuery.of(context).size.width * 0.3,
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: <Widget>[
                                      Flexible(
                                        fit: FlexFit.loose,
                                        child: RichText(
                                          softWrap: true,
                                          textAlign: TextAlign.start,
                                          overflow: TextOverflow.visible,
                                          text: TextSpan(
                                            text: department[index],
                                            style: TextStyle(
                                                fontSize: 12.0,
                                                color: Colors.black
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 3.0,
                                ),
                                Container(
                                  width: MediaQuery.of(context).size.width * 0.3,
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: <Widget>[
                                      Flexible(
                                        fit: FlexFit.loose,
                                        child: RichText(
                                          softWrap: true,
                                          textAlign: TextAlign.start,
                                          overflow: TextOverflow.visible,
                                          text: TextSpan(
                                            text: kategori[index],
                                            style: TextStyle(
                                                fontSize: 11.0,
                                                fontWeight: FontWeight.w300,
                                                color: Colors.black45
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 5.0,
                                ),
                                Container(
                                  width: MediaQuery.of(context).size.width * 0.3,
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: <Widget>[
                                      Flexible(
                                        fit: FlexFit.loose,
                                        child: RichText(
                                          softWrap: true,
                                          textAlign: TextAlign.start,
                                          overflow: TextOverflow.visible,
                                          text: TextSpan(
                                            text: 'CAR-${noCar[index].toString().padLeft(4, '0')}',
                                            style: TextStyle(
                                                fontSize: 11.0,
                                                fontWeight: FontWeight.w300,
                                                color: status[index] == 'OPEN' ? Colors.redAccent : status[index] == 'ONGOING' ? Colors.orangeAccent : status[index] == 'DONE' ? AbubaPallate.menuBluebird : Colors.green
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 5.0,
                                ),
                              ],
                            )
                        ),
                        trailing: Container(
                          alignment: Alignment.centerRight,
                          width: MediaQuery.of(context).size.width * 0.3,
                          child: ButtonTheme(
                            padding: EdgeInsets.all(0.0),
                            minWidth: 80.0,
                            height: 30.0,
                            child: OutlineButton(
                              child: Text(
                                status[index] == 'CLOSED' ? 'VERIFIED' : status[index],
                                style: TextStyle(fontSize: 12.0, color: status[index] == 'OPEN' ? Colors.redAccent : status[index] == 'ONGOING' ? Colors.orangeAccent : status[index] == 'DONE' ? AbubaPallate.menuBluebird : Colors.green),
                              ),
                              borderSide: BorderSide(
                                color: status[index] == 'OPEN' ? Colors.redAccent : status[index] == 'ONGOING' ? Colors.orangeAccent : status[index] == 'DONE' ? AbubaPallate.menuBluebird : Colors.green),
                              highlightedBorderColor: status[index] == 'OPEN' ? Colors.redAccent : status[index] == 'ONGOING' ? Colors.orangeAccent : status[index] == 'DONE' ? AbubaPallate.menuBluebird : Colors.green,
                              onPressed: () {
                                Navigator.push(context,
                                    MaterialPageRoute(
                                        builder: (context) => ReportCar(idUser: widget.idUser, departmentUser: widget.departmentUser, namaUser: widget.namaUser, index: docID[index])
                                    )
                                );
                              },
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            // } else {
            //   return Container ();
            // }


          }
      ),
    );
  }

  Widget _searchListView() {
    final double width = MediaQuery.of(context).size.width;

    tanggalList = List<dynamic>();
    kategoriList = List<dynamic>();
    departmentList = List<dynamic>();
    noCarList = List<dynamic>();
    statusList = List<dynamic>();
    docIDList = List<dynamic>();

    for (int i = 0; i < status.length; i++) {
      var kategoriDua = kategori[i];
      var statusDua = status[i];
      var tanggalDua = tanggal[i];
      var docIDDua = docID[i];
      var noCarDua = noCar[i];
      var departmentDua = department[i];


      if (kategoriDua.toLowerCase().contains(_searchText.toLowerCase())) {
        kategoriList.add(kategoriDua);
        statusList.add(statusDua);
        departmentList.add(departmentDua);
        tanggalList.add(tanggalDua);
        noCarList.add(noCarDua);
        docIDList.add(docIDDua);
      } else if (statusDua.toLowerCase().contains(_searchText.toLowerCase())) {
        kategoriList.add(kategoriDua);
        statusList.add(statusDua);
        departmentList.add(departmentDua);
        tanggalList.add(tanggalDua);
        noCarList.add(noCarDua);
        docIDList.add(docIDDua);
      } else if (departmentDua.toLowerCase().contains(_searchText.toLowerCase())) {
        kategoriList.add(kategoriDua);
        statusList.add(statusDua);
        departmentList.add(departmentDua);
        tanggalList.add(tanggalDua);
        noCarList.add(noCarDua);
        docIDList.add(docIDDua);
      }
    }
    return _searchAddList(width);
  }

  Widget _searchAddList(width) {
    return new Flexible(
      child: ListView.builder(
          itemCount: statusList.length,
          itemBuilder: (BuildContext context, int index) {
            Timestamp date = tanggalList[index];
            DateTime dateBantu = DateTime.tryParse(date.toDate().toString());

            // if (statusList[index] == 'CLOSED') {
              return Container(
                width: width,
                color: Colors.white,
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5.0),
                      child: ListTile(
                        leading: Container(
                          padding: EdgeInsets.only(top: 5.0),
                          alignment: Alignment.center,
                          width: MediaQuery.of(context).size.width * 0.3,
                          child: Row(
                            children: <Widget>[
                              Flexible(
                                child: Text(
                                  date.toDate().toString().substring(8, 10) + '/' + date.toDate().toString().substring(5, 7) + '/' + date.toDate().toString().substring(0, 4),
                                  style: TextStyle(
                                      fontSize: 12.0, color: Colors.black54),
                                ),
                              )
                            ],
                          ),
                        ),
                        title: Container(
                            alignment: Alignment.center,
                            width: MediaQuery.of(context).size.width * 0.3,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Container(
                                  width: MediaQuery.of(context).size.width * 0.3,
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: <Widget>[
                                      Flexible(
                                        fit: FlexFit.loose,
                                        child: RichText(
                                          softWrap: true,
                                          textAlign: TextAlign.start,
                                          overflow: TextOverflow.visible,
                                          text: TextSpan(
                                            text: departmentList[index],
                                            style: TextStyle(
                                                fontSize: 12.0,
                                                color: Colors.black
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 3.0,
                                ),
                                Container(
                                  width: MediaQuery.of(context).size.width * 0.3,
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: <Widget>[
                                      Flexible(
                                        fit: FlexFit.loose,
                                        child: RichText(
                                          softWrap: true,
                                          textAlign: TextAlign.start,
                                          overflow: TextOverflow.visible,
                                          text: TextSpan(
                                            text: kategoriList[index],
                                            style: TextStyle(
                                                fontSize: 11.0,
                                                fontWeight: FontWeight.w300,
                                                color: Colors.black45
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 5.0,
                                ),
                                Container(
                                  width: MediaQuery.of(context).size.width * 0.3,
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: <Widget>[
                                      Flexible(
                                        fit: FlexFit.loose,
                                        child: RichText(
                                          softWrap: true,
                                          textAlign: TextAlign.start,
                                          overflow: TextOverflow.visible,
                                          text: TextSpan(
                                            text: 'CAR-${noCarList[index].toString().padLeft(4, '0')}',
                                            style: TextStyle(
                                                fontSize: 11.0,
                                                fontWeight: FontWeight.w300,
                                                color: statusList[index] == 'OPEN' ? Colors.redAccent : statusList[index] == 'ONGOING' ? Colors.orangeAccent : statusList[index] == 'DONE' ? AbubaPallate.menuBluebird : Colors.green
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 5.0,
                                ),
                              ],
                            )
                        ),
                        trailing: Container(
                          alignment: Alignment.centerRight,
                          width: MediaQuery.of(context).size.width * 0.3,
                          child: ButtonTheme(
                            padding: EdgeInsets.all(0.0),
                            minWidth: 80.0,
                            height: 30.0,
                            child: OutlineButton(
                              child: Text(
                                statusList[index] == 'CLOSED' ? 'VERIFIED' : statusList[index],
                                style: TextStyle(fontSize: 12.0, color: statusList[index] == 'OPEN' ? Colors.redAccent : statusList[index] == 'ONGOING' ? Colors.orangeAccent : statusList[index] == 'DONE' ? AbubaPallate.menuBluebird : Colors.green),
                              ),
                              borderSide: BorderSide(
                                  color: statusList[index] == 'OPEN' ? Colors.redAccent : statusList[index] == 'ONGOING' ? Colors.orangeAccent : statusList[index] == 'DONE' ? AbubaPallate.menuBluebird : Colors.green),
                              highlightedBorderColor: statusList[index] == 'OPEN' ? Colors.redAccent : statusList[index] == 'ONGOING' ? Colors.orangeAccent : statusList[index] == 'DONE' ? AbubaPallate.menuBluebird : Colors.green,
                              onPressed: () {
                                Navigator.push(context,
                                    MaterialPageRoute(
                                        builder: (context) => ReportCar(idUser: widget.idUser, departmentUser: widget.departmentUser, namaUser: widget.namaUser, index: docIDList[index])
                                    )
                                );
                              },
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            // } else {
            //   return Container ();
            // }


          }
      ),
    );
  }

  Widget _bodyForm(double size) {
    return Scrollbar(
      child: ListView(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Text(
                  'Corrective Action',
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
                    'Report',
                    style: TextStyle(
                        color: AbubaPallate.greenabuba, fontSize: 12.0),
                  ),
                ),
              ],
            ),
          ),
          Container(
            color: Colors.white,
            width: size,
            child: ExpansionTile(
              title: Text(
                'Search',
                style: TextStyle(
                  fontSize: 14.0,
                ),
              ),
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(top: 10.0, left: 20.0, right: 20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Container(
                        width: size / 2.5,
                        child: DateTimePickerFormField(
                          format: dateFormat,
                          onChanged: (dt) => setState(() => dateStart = dt),
                          dateOnly: true,
                          editable: false,
                          style: TextStyle(fontSize: 16.0, color: Colors.black),
                          decoration: InputDecoration(
                            border: UnderlineInputBorder(),
                            labelStyle: TextStyle(fontSize: 14.0),
                            labelText: 'From',
                            helperText: helperText,
                            helperStyle: TextStyle(
                              color: showHelper ? Colors.redAccent : Colors.black38,
                              fontStyle: showHelper ? FontStyle.italic : FontStyle.normal,
                              fontSize: 14.0
                            ),
                          ),
                        ),
                      ),
                      Container(
                        width: size / 2.5,
                        child: DateTimePickerFormField(
                      format: dateFormat,
                      onChanged: (dt) => setState(() => dateEnd = dt),
                      dateOnly: true,
                      editable: false,
                      style: TextStyle(fontSize: 16.0, color: Colors.black),
                      decoration: InputDecoration(
                        border: UnderlineInputBorder(),
                        labelStyle: TextStyle(fontSize: 14.0),
                        labelText: 'To',
                        helperText: '',
                      ),
                    ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10.0, left: 20.0, right: 20.0, bottom: 20.0),
                  child: ButtonTheme(
                    minWidth: size / 2.5,
                    height: 40.0,
                    child: RaisedButton(
                      color: Colors.green,
                      child: Text(
                        'SEARCH',
                        style: TextStyle(
                            fontSize: 13.0, color: Colors.white),
                      ),
                      onPressed: () {
                        setState(() {
                          if (dateStart.isAfter(dateEnd) == false) {
                            showDataFiltered = true;
                            showHelper = false;
                            helperText = '';
                          } else {
                            showDataFiltered = false;
                            showHelper = true;
                            helperText = "can\'t back date";
                          }
                        });
                      },
                    ),
                  ),
                )
              ],
            ),
          ),
          SizedBox(
            height: 20.0,
          ),
          Container(
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 5.0),
              child: Center(
                child: new AnimatedCircularChart(
                  key: _chartKey,
                  size: Size(size * 0.35, size * 0.35),
                  initialChartData: <CircularStackEntry>[
                    new CircularStackEntry(
                      <CircularSegmentEntry>[
                        new CircularSegmentEntry(
                          widget.persen,
                          Colors.blue[400],
                          rankKey: 'completed',
                        ),
                        new CircularSegmentEntry(
                          100.0 - widget.persen,
                          Colors.blueGrey[600],
                          rankKey: 'remaining',
                        ),
                      ],
                      rankKey: 'progress',
                    ),
                  ],
                  chartType: CircularChartType.Radial,
                  percentageValues: true,
                  holeLabel: widget.persen >= 100.0 ? '100%' : '${widget.persen.toString().substring(0, 2)}%',
                  labelStyle: new TextStyle(
                    color: Colors.blueGrey[600],
                    fontWeight: FontWeight.bold,
                    fontSize: 24.0,
                  ),
                ),
              ),
            ),
          ),
          Container(
            width: size,
            color: Colors.white,
            child: Column(
              children: <Widget>[
                StreamBuilder(
                  stream: showDataFiltered
                    ? Firestore.instance.collection('correctiveAction').where('dateCreated', isGreaterThanOrEqualTo: dateStart).orderBy('dateCreated', descending: false).snapshots()
                    : Firestore.instance.collection('correctiveAction').orderBy('dateCreated', descending: false).snapshots(),
                  builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (!snapshot.hasData)
                      return Container(
                        child: Center(
                          child: CircularProgressIndicator(),
                        ),
                      );

                    return Column(
                      children: List.generate(snapshot.data.documents.length, (index) {
                        Timestamp tanggalStart = snapshot.data.documents[index].data['dateCreated'];
                        DateTime tanggalBantu = DateTime.tryParse(tanggalStart.toDate().toString());
                        if (showDataFiltered && dateEnd != null && dateStart != null) {
                          if (tanggalBantu.isAfter(dateEnd.subtract(Duration(days: -1))) == true) {
                            return Container();
                          } else {
                            if (snapshot.data.documents[index].data['status'] == 'CLOSED') {
                              return ListTile(
                                leading: Container(
                                  padding: EdgeInsets.only(top: 5.0),
                                  alignment: Alignment.centerRight,
                                  width: MediaQuery.of(context).size.width * 0.35,
                                  child: Row(
                                    children: <Widget>[
                                      Flexible(
                                        child: Text(
                                          tanggalStart.toDate().toString().substring(8, 10) + '/' + tanggalStart.toDate().toString().substring(5, 7) + '/' +tanggalStart.toDate().toString().substring(0, 4),
                                          style: TextStyle(
                                              fontSize: 12.0, color: Colors.black54),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                title: Container(
                                  alignment: Alignment.centerRight,
                                  width: MediaQuery.of(context).size.width * 0.35,
                                  child: Row(
                                    children: <Widget>[
                                      Flexible(
                                        child: Text(
                                          'Department Name',
                                          style: TextStyle(
                                              fontSize: 12.0, color: Colors.black54),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                trailing: GestureDetector(
                                  onTap: () {
                                    Navigator.push(context,
                                      MaterialPageRoute(
                                        builder: (context) => ReportCar(idUser: widget.idUser, departmentUser: widget.departmentUser, namaUser: widget.namaUser, index: snapshot.data.documents[index].documentID)
                                      )
                                    );
                                  },
                                  child: Container(
                                    alignment: Alignment.centerRight,
                                    width: MediaQuery.of(context).size.width * 0.35,
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: <Widget>[
                                        Flexible(
                                          child: Text(
                                            'CAR-${snapshot.data.documents[index].data['carNo'].toString().padLeft(4, '0')} - ${snapshot.data.documents[index].data['status'].toString()}',
                                            style: TextStyle(fontSize: 12.0, color: snapshot.data.documents[index].data['status'] == 'OPEN' ? Colors.green : snapshot.data.documents[index].data['status'] == 'ONGOING' ? Colors.orangeAccent : snapshot.data.documents[index].data['status'] == 'DONE' ? Colors.green : Colors.redAccent),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            } else {
                              return Container();
                            }
                          }
                        } else {
                          if (snapshot.data.documents[index].data['status'] == 'CLOSED') {
                            return ListTile(
                              leading: Container(
                                padding: EdgeInsets.only(top: 5.0),
                                alignment: Alignment.centerRight,
                                width: MediaQuery.of(context).size.width * 0.35,
                                child: Row(
                                  children: <Widget>[
                                    Flexible(
                                      child: Text(
                                        tanggalStart.toDate().toString().substring(8, 10) + '/' + tanggalStart.toDate().toString().substring(5, 7) + '/' +tanggalStart.toDate().toString().substring(0, 4),
                                        style: TextStyle(
                                            fontSize: 12.0, color: Colors.black54),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              title: Container(
                                alignment: Alignment.centerRight,
                                width: MediaQuery.of(context).size.width * 0.35,
                                child: Row(
                                  children: <Widget>[
                                    Flexible(
                                      child: Text(
                                        'Department Name',
                                        style: TextStyle(
                                            fontSize: 12.0, color: Colors.black54),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              trailing: GestureDetector(
                                onTap: () {
                                  Navigator.push(context,
                                    MaterialPageRoute(
                                      builder: (context) => ReportCar(idUser: widget.idUser, departmentUser: widget.departmentUser, namaUser: widget.namaUser, index: snapshot.data.documents[index].documentID)
                                    )
                                  );
                                },
                                child: Container(
                                  alignment: Alignment.centerRight,
                                  width: MediaQuery.of(context).size.width * 0.35,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: <Widget>[
                                      Flexible(
                                        child: Text(
                                          'CAR-${snapshot.data.documents[index].data['carNo'].toString().padLeft(4, '0')} - ${snapshot.data.documents[index].data['status'].toString()}',
                                          style: TextStyle(fontSize: 12.0, color: snapshot.data.documents[index].data['status'] == 'OPEN' ? Colors.green : snapshot.data.documents[index].data['status'] == 'ONGOING' ? Colors.orangeAccent : snapshot.data.documents[index].data['status'] == 'DONE' ? Colors.green : Colors.redAccent),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            );
                          } else {
                            return Container();
                          }
                        }
                      }).toList(),
                    );
                  },
                )
              ],
            ),
          ),
          SizedBox(
            height: 20.0,
          ),
        ],
//        itemCount: 10,
      ),
    );
  }
}
