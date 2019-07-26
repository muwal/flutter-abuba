import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_abuba/constant.dart';
import 'package:flutter_abuba/isoft/operation_page/correctiveaction/verifikasiPage.dart';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Verifikasi extends StatefulWidget {
  final int idUser;
  final String namaUser;
  final String departmentUser;
  Verifikasi({this.idUser, this.namaUser, this.departmentUser});

  @override
  _VerifikasiState createState() => _VerifikasiState();
}

class _VerifikasiState extends State<Verifikasi> with TickerProviderStateMixin {
  AnimationController animationController;

  final dateFormat = DateFormat("MMMM d, yyyy");
  DateTime dateStart;
  DateTime dateEnd;

  bool showDataFiltered = false;
  bool showHelper = false;
  String helperText = '';

  List<dynamic> tanggalList = [];
  List<dynamic> kategoriList = [];
  List<dynamic> departmenttList = [];
  List<dynamic> noCarList = [];
  List<dynamic> statusList = [];
  List<dynamic> docIDList = [];
  List<dynamic> userTujuList = [];
  List<dynamic> NamaList = [];

  List<dynamic> tanggal = [];
  List<dynamic> kategori = [];
  List<dynamic> departmentt = [];
  List<dynamic> noCar = [];
  List<dynamic> status = [];
  List<dynamic> Nama = [];
  List<dynamic> userTuju = [];

  var docID = [];

  var _searchEdit = new TextEditingController();

  bool _isSearch = true;
  String _searchText = "";

  _VerifikasiState() {
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

  @override
  void initState() {
    super.initState();
    CollectionReference reference = Firestore.instance.collection('correctiveAction');
    reference.snapshots().listen((data) {
      data.documentChanges.forEach((change) {
        setState(() {
          status.add(change.document.data['status']);
          tanggal.add(change.document.data['dateCreated']);
          noCar.add(change.document.data['carNo']);
          userTuju.add(change.document.data['userCreated']);
          docID.add(change.document.documentID);

          Firestore.instance.collection('correctiveAction_category').where('id', isEqualTo: change.document.data['category']).snapshots().listen((data2) {
            kategori.add(data2.documents[0].data['category']);
          });

          Firestore.instance.collection('user').where('id', isEqualTo: change.document.data['userDituju']).snapshots().listen((data3) {
            departmentt.add(data3.documents[0].data['department']);
            Nama.add(data3.documents[0].data['nama']);
          });
        });
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
                            'Verification',
                            style:
                            TextStyle(color: AbubaPallate.greenabuba, fontSize: 12.0),
                          ),
                        ),
                      ],
                    ),
                  ),
                  // _searchBox(),
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

            if (status[index] == 'DONE') {
              if (userTuju[index] == widget.idUser) {
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
                                              text: kategori[index],
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
                                              text: '${Nama[index]} - ${departmentt[index]}',
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
                                                  color: status[index] == 'OPEN' ? Colors.green : status[index] == 'ONGOING' ? Colors.orangeAccent : status[index] == 'DONE' ? AbubaPallate.menuBluebird : Colors.redAccent
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
                                  status[index] ,
                                  style: TextStyle(fontSize: 12.0, color: status[index] == 'OPEN' ? Colors.green : status[index] == 'ONGOING' ? Colors.orangeAccent : status[index] == 'DONE' ? AbubaPallate.menuBluebird : Colors.redAccent),
                                ),
                                borderSide: BorderSide(
                                    color: status[index] == 'OPEN' ? Colors.green : status[index] == 'ONGOING' ? Colors.orangeAccent : status[index] == 'DONE' ? AbubaPallate.menuBluebird : Colors.redAccent),
                                highlightedBorderColor: status[index] == 'OPEN' ? Colors.green : status[index] == 'ONGOING' ? Colors.orangeAccent : status[index] == 'DONE' ? AbubaPallate.menuBluebird : Colors.redAccent,
                                onPressed: () {
                                  Navigator.push(context,
                                      MyCustomRoute(
                                          builder: (context) => VerifikasiLanjutan(idUser: widget.idUser, departmentUser: widget.departmentUser, namaUser: widget.namaUser, status: 'carLanjutan', index: docID[index])
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
              } else {
                return Container ();
              }
            }


          }
      ),
    );
  }

  Widget _searchListView() {
    final double width = MediaQuery.of(context).size.width;

    tanggalList = List<dynamic>();
    kategoriList = List<dynamic>();
    departmenttList = List<dynamic>();
    noCarList = List<dynamic>();
    statusList = List<dynamic>();
    docIDList = List<dynamic>();
    NamaList = List<dynamic>();
    userTujuList = List<dynamic>();

    for (int i = 0; i < status.length; i++) {
      var kategoriDua = kategori[i];
      var statusDua = status[i];
      var tanggalDua = tanggal[i];
      var docIDDua = docID[i];
      var noCarDua = noCar[i];
      var departmentDua = departmentt[i];
      var namaDua = Nama[i];
      var userTujuDua = userTuju[i];


      if (kategoriDua.toLowerCase().contains(_searchText.toLowerCase())) {
        kategoriList.add(kategoriDua);
        statusList.add(statusDua);
        departmenttList.add(departmentDua);
        tanggalList.add(tanggalDua);
        noCarList.add(noCarDua);
        docIDList.add(docIDDua);
        NamaList.add(namaDua);
        userTujuList.add(userTujuDua);
      } else if (statusDua.toLowerCase().contains(_searchText.toLowerCase())) {
        kategoriList.add(kategoriDua);
        statusList.add(statusDua);
        departmenttList.add(departmentDua);
        tanggalList.add(tanggalDua);
        noCarList.add(noCarDua);
        docIDList.add(docIDDua);
        NamaList.add(namaDua);
        userTujuList.add(userTujuDua);
      } else if (departmentDua.toLowerCase().contains(_searchText.toLowerCase())) {
        kategoriList.add(kategoriDua);
        statusList.add(statusDua);
        departmenttList.add(departmentDua);
        tanggalList.add(tanggalDua);
        noCarList.add(noCarDua);
        docIDList.add(docIDDua);
        NamaList.add(namaDua);
        userTujuList.add(userTujuDua);
      } else if (namaDua.toLowerCase().contains(_searchText.toLowerCase())) {
        kategoriList.add(kategoriDua);
        statusList.add(statusDua);
        departmenttList.add(departmentDua);
        tanggalList.add(tanggalDua);
        noCarList.add(noCarDua);
        docIDList.add(docIDDua);
        NamaList.add(namaDua);
        userTujuList.add(userTujuDua);
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

            if (statusList[index] == 'DONE') {
              if (userTujuList[index] == widget.idUser) {
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
                                              text: kategoriList[index],
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
                                              text: '${NamaList[index]} - ${departmenttList[index]}',

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
                                                  color: status[index] == 'OPEN' ? Colors.green : status[index] == 'ONGOING' ? Colors.orangeAccent : status[index] == 'DONE' ? AbubaPallate.menuBluebird : Colors.redAccent
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
                                  status[index] ,
                                  style: TextStyle(fontSize: 12.0, color: statusList[index] == 'OPEN' ? Colors.green : statusList[index] == 'ONGOING' ? Colors.orangeAccent : statusList[index] == 'DONE' ? AbubaPallate.menuBluebird : Colors.redAccent),
                                ),
                                borderSide: BorderSide(
                                    color: statusList[index] == 'OPEN' ? Colors.green : statusList[index] == 'ONGOING' ? Colors.orangeAccent : statusList[index] == 'DONE' ? AbubaPallate.menuBluebird : Colors.redAccent),
                                highlightedBorderColor: statusList[index] == 'OPEN' ? Colors.green : statusList[index] == 'ONGOING' ? Colors.orangeAccent : statusList[index] == 'DONE' ? AbubaPallate.menuBluebird : Colors.redAccent,
                                onPressed: () {
                                  Navigator.push(context,
                                      MyCustomRoute(
                                          builder: (context) => VerifikasiLanjutan(idUser: widget.idUser, departmentUser: widget.departmentUser, namaUser: widget.namaUser, status: 'carLanjutan', index: docIDList[index])
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
              } else {
                return Container ();
              }
            }


          }
      ),
    );
  }

  Widget _buildReport(double width) {
    return ListView(
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
                  style:
                      TextStyle(color: AbubaPallate.greenabuba, fontSize: 12.0),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 15.0),
                child: Text(
                  'Verification',
                  style:
                      TextStyle(color: AbubaPallate.greenabuba, fontSize: 12.0),
                ),
              ),
            ],
          ),
        ),
        Container(
          color: Colors.white,
          width: width,
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
                      width: width / 2.5,
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
                      width: width / 2.5,
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
                  minWidth: width / 2.5,
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
          width: width,
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
                      Timestamp tanggal = snapshot.data.documents[index].data['dateCreated'];
                      DateTime tanggalBantu = DateTime.tryParse(snapshot.data.documents[index].data['dateCreated'].toString());
                      if (showDataFiltered && dateEnd != null && dateStart != null) {
                        if (tanggalBantu.isAfter(dateEnd.subtract(Duration(days: -1))) == true) {
                          return Container();
                        } else {
                          if (snapshot.data.documents[index].data['status'] == 'DONE') {
                            if (snapshot.data.documents[index].data['userCreated'] == widget.idUser) {
                              return ListTile(
                                leading: Container(
                                  padding: EdgeInsets.only(top: 5.0),
                                  alignment: Alignment.centerRight,
                                  width: MediaQuery.of(context).size.width * 0.35,
                                  child: Row(
                                    children: <Widget>[
                                      Flexible(
                                        child: Text(
                                          tanggal.toDate().toString().substring(8, 10) + '/' + tanggal.toDate().toString().substring(5, 7) + '/' +tanggal.toDate().toString().substring(0, 4),
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
                                        builder: (context) => VerifikasiLanjutan(idUser: widget.idUser, departmentUser: widget.departmentUser, namaUser: widget.namaUser, status: 'carLanjutan', index: snapshot.data.documents[index].documentID)
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
                                            style: TextStyle(fontSize: 12.0, color: snapshot.data.documents[index].data['status'] == 'OPEN' ? Colors.green : snapshot.data.documents[index].data['status'] == 'ONGOING' ? Colors.orangeAccent : snapshot.data.documents[index].data['status'] == 'DONE' ? AbubaPallate.menuBluebird : Colors.redAccent),
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
                          } else {
                            return Container();
                          }
                        }
                      } else {
                        if (snapshot.data.documents[index].data['status'] == 'DONE') {
                          if (snapshot.data.documents[index].data['userCreated'] == widget.idUser) {
                            return ListTile(
                              leading: Container(
                                padding: EdgeInsets.only(top: 5.0),
                                alignment: Alignment.centerRight,
                                width: MediaQuery.of(context).size.width * 0.35,
                                child: Row(
                                  children: <Widget>[
                                    Flexible(
                                      child: Text(
                                        tanggal.toDate().toString().substring(8, 10) + '/' + tanggal.toDate().toString().substring(5, 7) + '/' +tanggal.toDate().toString().substring(0, 4),
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
                                      builder: (context) => VerifikasiLanjutan(idUser: widget.idUser, departmentUser: widget.departmentUser, namaUser: widget.namaUser, status: 'carLanjutan', index: snapshot.data.documents[index].documentID)
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
                                          style: TextStyle(fontSize: 12.0, color: snapshot.data.documents[index].data['status'] == 'OPEN' ? Colors.green : snapshot.data.documents[index].data['status'] == 'ONGOING' ? Colors.orangeAccent : snapshot.data.documents[index].data['status'] == 'DONE' ? AbubaPallate.menuBluebird : Colors.redAccent),
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
        )
      ],
    );
  }
}
