import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_abuba/constant.dart';
import 'detail_report.dart';
import 'package:intl/intl.dart';

class FormReport extends StatefulWidget {
  final int idUser;
  final String namaUser;
  final String departmentUser;
  FormReport({this.idUser, this.namaUser, this.departmentUser});

  @override
  _FormReportState createState() => _FormReportState() ;
}

class _FormReportState extends State<FormReport> with TickerProviderStateMixin {

  AnimationController animationController;

  final dateFormat = DateFormat("MMMM d, yyyy");
  DateTime dateStart;
  DateTime dateEnd;

  bool showDataFiltered = false;
  bool showHelper = false;
  String helperText = '';

  var _searchEdit = new TextEditingController();

  bool _isSearch = true;
  String _searchText = "";

  List<String> namaMeetingList = [];
  List<dynamic> lokasiList = [];
  List<dynamic> dateCreatedList = [];
  List<dynamic> noList = [];
  List<dynamic> statusList = [];
  List<dynamic> statusActionPlanList = [];
  List<dynamic> pesertaHadirList = [];
  List<dynamic> pesertaMeetingList = [];
  List<dynamic> picList = [];
  List<dynamic> createdNotulenList = [];
  List<dynamic> noteActionList = [];
  List<dynamic> docIDList = [];

  List<dynamic> namaMeeting = [];
  List<dynamic> lokasi = [];
  List<dynamic> dateCreated = [];
  List<dynamic> no = [];
  List<dynamic> status = [];
  List<dynamic> statusActionPlan = [];
  List<dynamic> pesertaHadir = [];
  List<dynamic> pesertaMeeting = [];
  List<dynamic> pic = [];
  List<dynamic> createdNotulen = [];
  List<dynamic> noteAction = [];

  var docID = [];


  @override
  void initState() {
    super.initState();
    CollectionReference reference = Firestore.instance.collection('minutesMeeting');
    reference.snapshots().listen((data) {
      data.documentChanges.forEach((change) {
        setState(() {
          docID.add(change.document.documentID);
          namaMeeting.add(change.document.data['namaMeeting']);
          dateCreated.add(change.document.data['dateCreated']);
          no.add(change.document.data['meetingNo']);
          status.add(change.document.data['status']);
          statusActionPlan.add(change.document.data['statusActionPlan']);
          pesertaHadir.add(change.document.data['pesertaHadir']);
          pesertaMeeting.add(change.document.data['pesertaID']);
          pic.add(change.document.data['picIDNotulen']);
          createdNotulen.add(change.document.data['userCreatedNotulen']);
          noteAction.add(change.document.data['noteActionPlan']);

          Firestore.instance.collection('locationMeeting').where('id', isEqualTo: change.document.data['location']).snapshots().listen((data5) {
            lokasi.add(data5.documents[0].data['location']);
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

  _FormReportState() {
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
                            'Project Screen',
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
                                      'Result',
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
                    _isSearch ? _listView(width) : Container()
                  ],
                );
              })
          )
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
      child: ListView(
        children: <Widget>[
          Container(
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
                              '17/09/2019',
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
                                        text: 'Project online sales',
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
                                        text: '#PSC001',
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
                                        text: 'Awal - IT',
                                        style: TextStyle(
                                            fontSize: 11.0,
                                            fontWeight: FontWeight.w300,
                                            color: Colors.black45
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ],
                        )
                    ),
                    trailing: Container(
                      alignment: Alignment.centerRight,
                      width: MediaQuery.of(context).size.width * 0.3,
                      child: ButtonTheme(
                        padding: EdgeInsets.all(0.0),
                        minWidth: 50.0,
                        height: 30.0,
                        child: OutlineButton(
                          child: Text(
                            'Top Pick',
                            style: TextStyle(fontSize: 13.0, color: AbubaPallate.menuBluebird),
                          ),
                          borderSide: BorderSide(color: Colors.white, width: 0.0),
                          highlightedBorderColor: AbubaPallate.menuBluebird,
                          onPressed: () {
                            Navigator.push(
                                context,
                                MyCustomRoute(
                                    builder: (context) => DetailReport(idUser: widget.idUser, namaUser: widget.namaUser, departmentUser: widget.departmentUser)));
                          },
                        ),
                      ),
                    ),
                  ),
                ),

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
                              '17/09/2019',
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
                                        text: 'Project bright future',
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
                                        text: '#PSC002',
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
                                        text: 'Awal - IT',
                                        style: TextStyle(
                                            fontSize: 11.0,
                                            fontWeight: FontWeight.w300,
                                            color: Colors.black45
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ],
                        )
                    ),
                    trailing: Container(
                      alignment: Alignment.centerRight,
                      width: MediaQuery.of(context).size.width * 0.3,
                      child: ButtonTheme(
                        padding: EdgeInsets.all(0.0),
                        minWidth: 50.0,
                        height: 30.0,
                        child: OutlineButton(
                          child: Text(
                            'Consider',
                            style: TextStyle(fontSize: 13.0, color: AbubaPallate.menuBluebird),
                          ),
                          borderSide: BorderSide(color: Colors.white, width: 0.0),
                          highlightedBorderColor: AbubaPallate.menuBluebird,
                          onPressed: () {
                            Navigator.push(
                                context,
                                MyCustomRoute(
                                    builder: (context) => DetailReport(idUser: widget.idUser, namaUser: widget.namaUser, departmentUser: widget.departmentUser)));
                          },
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      /*child: ListView.builder(
        itemCount: namaMeeting.length,
        itemBuilder: (BuildContext context, int index) {
          Timestamp date = dateCreated[index];
          DateTime dateBantu = DateTime.tryParse(date.toDate().toString());

          if (status[index] != 'CLOSE') {
            return Container();
          } else {
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
                        width: MediaQuery.of(context).size.width * 0.2,
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
                          width: MediaQuery.of(context).size.width * 0.4,
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
                                          text: namaMeeting[index],
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
                                          text: lokasi[index],
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
                                          text: 'MMT-${no[index].toString().padLeft(4, '0')}',
                                          style: TextStyle(
                                              fontSize: 11.0,
                                              fontWeight: FontWeight.w300,
                                              color: Colors.black45
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          )
                      ),
                      trailing: Container(
                        alignment: Alignment.centerRight,
                        width: MediaQuery.of(context).size.width * 0.3,
                        child: ButtonTheme(
                          padding: EdgeInsets.all(0.0),
                          minWidth: 50.0,
                          height: 30.0,
                          child: OutlineButton(
                            child: Text(
                              'Report',
                              style: TextStyle(fontSize: 13.0, color: statusActionPlan[index].contains('OPEN') ? Colors.redAccent : AbubaPallate.menuBluebird),
                            ),
                            borderSide: BorderSide(color: statusActionPlan[index].contains('OPEN') ? Colors.redAccent : AbubaPallate.menuBluebird, width: 1.0),
                            highlightedBorderColor: statusActionPlan[index].contains('OPEN') ? Colors.redAccent : AbubaPallate.menuBluebird,
                            onPressed: () {
                              Navigator.push(context,
                                  MaterialPageRoute(
                                      builder: (_) => DetailReport(idUser: widget.idUser, namaUser: widget.namaUser, departmentUser: widget.departmentUser, index: docID[index], pesertaHadir: pesertaHadir[index], pesertaMeeting: pesertaMeeting[index], pic: pic[index], createdNotulen: createdNotulen[index], noteActionPlan: noteAction[index])
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
          }
        }
      ),*/
    );
  }

  Widget _searchListView() {
    final double width = MediaQuery.of(context).size.width;

    namaMeetingList = List<String>();
    statusList = List<dynamic>();
    dateCreatedList = List<dynamic>();
    lokasiList = List<dynamic>();
    noList = List<dynamic>();
    statusActionPlanList = List<dynamic>();
    pesertaHadirList = List<dynamic>();
    pesertaMeetingList = List<dynamic>();
    picList = List<dynamic>();
    createdNotulenList = List<dynamic> ();
    noteActionList = List<dynamic> ();
    docIDList = List<dynamic> ();

    for (int i = 0; i < namaMeeting.length; i++) {
      var namaMeetingDua = namaMeeting[i];
      var statusDua = status[i];
      var dateCreatedDua = dateCreated[i];
      var lokasiDua = lokasi[i];
      var noDua = no[i];
      var statusActionPlanDua = statusActionPlan[i];
      var pesertaHadirDua = pesertaHadir[i];
      var pesertaMeetingDua = pesertaMeeting[i];
      var picDua = pic[i];
      var createdNotulenDua = createdNotulen[i];
      var noteActionDua = noteAction[i];
      var docIDDua = docID[i];

      if (namaMeetingDua.toLowerCase().contains(_searchText.toLowerCase())) {
        namaMeetingList.add(namaMeetingDua);
        statusList.add(statusDua);
        dateCreatedList.add(dateCreatedDua);
        lokasiList.add(lokasiDua);
        noList.add(noDua);
        statusActionPlanList.add(statusActionPlanDua);
        pesertaHadirList.add(pesertaHadirDua);
        pesertaMeetingList.add(pesertaMeetingDua);
        picList.add(picDua);
        createdNotulenList.add(createdNotulenDua);
        noteActionList.add(noteActionDua);
        docIDList.add(docIDDua);
        /*
        docIDList.add(docIDDua);*/
      } else if (lokasiDua.toLowerCase().contains(_searchText.toLowerCase())) {
        namaMeetingList.add(namaMeetingDua);
        statusList.add(statusDua);
        dateCreatedList.add(dateCreatedDua);
        lokasiList.add(lokasiDua);
        noList.add(noDua);
        statusActionPlanList.add(statusActionPlanDua);
        pesertaHadirList.add(pesertaHadirDua);
        pesertaMeetingList.add(pesertaMeetingDua);
        picList.add(picDua);
        createdNotulenList.add(createdNotulenDua);
        noteActionList.add(noteActionDua);
        docIDList.add(docIDDua);
      }
    }
    return _searchAddList(width);
  }

  Widget _searchAddList(width) {
    return new Flexible(
      child: ListView.builder(
          itemCount: namaMeetingList.length,
          itemBuilder: (BuildContext context, int index) {
            Timestamp date = dateCreatedList[index];
            DateTime dateBantu = DateTime.tryParse(date.toDate().toString());


            if (statusList[index] != 'CLOSE') {
              return Container();
            } else {
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
                          width: MediaQuery.of(context).size.width * 0.2,
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
                            width: MediaQuery.of(context).size.width * 0.4,
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
                                            text: '${namaMeetingList[index]}',
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
                                            text: lokasiList[index],
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
                                            text: 'MMT-${noList[index].toString().padLeft(4, '0')}',
                                            style: TextStyle(
                                                fontSize: 11.0,
                                                fontWeight: FontWeight.w300,
                                                color: Colors.black45
                                            ),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            )
                        ),
                        trailing: Container(
                          alignment: Alignment.centerRight,
                          width: MediaQuery.of(context).size.width * 0.3,
                          child: ButtonTheme(
                            padding: EdgeInsets.all(0.0),
                            minWidth: 50.0,
                            height: 30.0,
                            child: OutlineButton(
                              child: Text(
                                'Report',
                                style: TextStyle(fontSize: 13.0, color: statusActionPlanList[index].contains('OPEN') ? Colors.redAccent : AbubaPallate.menuBluebird),
                              ),
                              borderSide: BorderSide(color: statusActionPlanList[index].contains('OPEN') ? Colors.redAccent : AbubaPallate.menuBluebird, width: 1.0),
                              highlightedBorderColor: statusActionPlanList[index].contains('OPEN') ? Colors.redAccent : AbubaPallate.menuBluebird,
                              onPressed: () {
                                /*Navigator.push(context,
                                    MaterialPageRoute(
                                        builder: (_) => DetailReport(idUser: widget.idUser, namaUser: widget.namaUser, departmentUser: widget.departmentUser, index: docIDList[index], pesertaHadir: pesertaHadirList[index], pesertaMeeting: pesertaMeetingList[index], pic: picList[index], createdNotulen: createdNotulenList[index], noteActionPlan: noteActionList[index])
                                    )
                                );*/
                              },
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }
          }
      ),
    );
  }

}
