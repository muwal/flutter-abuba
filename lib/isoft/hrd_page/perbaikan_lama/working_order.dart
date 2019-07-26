import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_abuba/constant.dart';
import 'package:flutter_abuba/isoft/hrd_page/perbaikan/detail_workingOrder.dart';
import 'package:intl/intl.dart';

class WorkingOrder extends StatefulWidget {
  final int idUser;
  final String namaUser;
  final String departmentUser;
  WorkingOrder({this.idUser, this.namaUser, this.departmentUser});

  @override
  _WorkingOrderState createState() => _WorkingOrderState();
}

class _WorkingOrderState extends State<WorkingOrder> with TickerProviderStateMixin {
  final dateFormat = DateFormat("MMMM d, yyyy");
  DateTime dateStart;
  DateTime dateEnd;

  AnimationController animationController;

  bool showDataFiltered = false;
  bool showHelper = false;
  String helperText = '';

  var _searchEdit = new TextEditingController();

  int managerIT;

  bool _isSearch = true;
  String _searchText = "";
  List<String> _searchListItems;
  List<String> statusListItems;
  List<String> itemListItems;
  List<String> lokasiListItems;
  List<String> merekListItems;
  List<String> itemNoListItems;
  List<dynamic> dueDateListItems;
  List<dynamic> dateListItems;
  List<dynamic> picListItems;
  List<String> frequencyListItems;
  List<dynamic> jobdescIDListItems;
  List<dynamic> jobdescNameDoneListItems;
  List<dynamic> jobdescNameSkipListItems;
  List<dynamic> jobdescTimeListItems;
  List<dynamic> alasanListItems;
  List<dynamic> newScheduleListItems;
  List<dynamic> rescheduleByListItems;
  List<dynamic> ratingListItems;
  List<dynamic> docIDListItems;

  List<String> _socialListItems;

  List<dynamic> date = [];
  List<dynamic> outlet = [];
  List<dynamic> lokasi = [];
  List<dynamic> item = [];
  List<dynamic> merek = [];
  List<dynamic> itemNo = [];
  List<dynamic> status = [];
  List<dynamic> pic = [];
  List<dynamic> frequency = [];
  List<dynamic> jobdescID = [];
  List<dynamic> jobdescNameDone = [];
  List<dynamic> jobdescNameSkip = [];
  List<dynamic> jobdescTime = [];
  List<dynamic> dueDate = [];
  List<dynamic> alasan = [];
  List<dynamic> rating = [];
  var docID = [];
  List<dynamic> newSchedule = [];
  List<dynamic> rescheduleBy = [];

  String alasanName = '';
  String rescheduleByName = '';

  @override
  void initState() {
    super.initState();

    Firestore.instance.collection('jabatan').where('jabatan', isEqualTo: 'Manager').snapshots().listen((data1) {
      Firestore.instance.collection('department').where('department', isEqualTo: 'IT').snapshots().listen((data2) {
        Firestore.instance.collection('user').where('jabatan', isEqualTo: data1.documents[0].data['id']).where('departmentID', isEqualTo: data2.documents[0].data['id']).snapshots().listen((data3) {
          setState(() {
            managerIT = data3.documents[0].data['id'];
          });
        });
      });
    });

    CollectionReference reference = Firestore.instance.collection('perbaikan');
    reference.snapshots().listen((data) {
      data.documentChanges.forEach((change) {
        setState(() {
          date.add(change.document.data['dateCreated']);
          status.add(change.document.data['statusPerbaikan']);
          frequency.add(change.document.data['frequency']);
          jobdescID.add(change.document.data['jobdesc']);
          jobdescTime.add(change.document.data['jobdesc_done']);
          rescheduleBy.add(change.document.data['rescheduleBy']);
          alasan.add(change.document.data['alasan']);
          rating.add(change.document.data['rating']);
          docID.add(change.document.documentID);

          if (change.document.data['newDueDate'] == null) {
            newSchedule.add(null);
          } else {
            newSchedule.add(change.document.data['newDueDate']);
          }

          Firestore.instance.collection('maintenance_item').where('id', isEqualTo: change.document.data['item']).snapshots().listen((data2) {
            item.add(data2.documents[0].data['item']);
            itemNo.add(data2.documents[0].data['kode']);
          });

          Firestore.instance.collection('perbaikanCategory').where('id', isEqualTo: change.document.data['category']).snapshots().listen((data3) {
            merek.add(data3.documents[0].data['category']);
          });

          Firestore.instance.collection('outlet').where('id', isEqualTo: change.document.data['area']).snapshots().listen((data4) {
            outlet.add(data4.documents[0].data['nama_outlet']);
          });

          Firestore.instance.collection('lokasi').where('id', isEqualTo: change.document.data['lokasi']).snapshots().listen((data5) {
            lokasi.add(data5.documents[0].data['lokasi']);
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
            child: AnimatedBuilder(
              animation: animationController,
              builder: (_, Widget child) {
                return animationController.isAnimating
                    ? Container(
                    child: Center(
                        child: CircularProgressIndicator()
                    )
                )
                    : new Column(
                  children: <Widget>[
                    Container(
                      margin: const EdgeInsets.only(bottom: 10.0, right: 15.0, left: 15.0, top: 10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            'Perbaikan',
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
                              'Working Order',
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
                              width: width * 0.3,
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
                              width: width * 0.3,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
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
              },
            )
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
      child: new ListView.builder(
          itemCount: outlet.length,
          itemBuilder: (BuildContext context, int index) {
            Timestamp dateView = date[index];
            if (status[index] != 'NOT READY') {
              return Container();
            } else if (status[index] == 'NOT READY') {
              if (managerIT == widget.idUser) {
                return Container(
                  width: width,
                  padding: const EdgeInsets.only(right: 5.0, left: 5.0),
                  color: Colors.white,
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: index == status.length - 1 ? const EdgeInsets.fromLTRB(12.0, 6.0, 12.0, 12.0) : const EdgeInsets.fromLTRB(12.0, 6.0, 12.0, 12.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Container(
                              width: width * 0.3,
                              child: Row(
                                children: <Widget>[
                                  Flexible(
                                    child: Text(
                                      dateView.toDate().toString().substring(8, 10) + '/' + dateView.toDate().toString().substring(5, 7) + '/' +dateView.toDate().toString().substring(0, 4),
                                      style: TextStyle(
                                          fontSize: 12.0, color: Colors.black),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Container(
                                width: width * 0.3,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    Container(
                                      width: MediaQuery.of(context).size.width * 0.7,
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
                                                text: '${outlet[index]}',
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
                                      width: MediaQuery.of(context).size.width * 0.7,
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
                                      width: MediaQuery.of(context).size.width * 0.7,
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
                                                text: '${merek[index]} - ${item[index]}',
                                                style: TextStyle(
                                                    fontSize: 12.0,
                                                    color: Colors.black
                                                ),
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      height: 3.0,
                                    ),
                                    Container(
                                      width: MediaQuery.of(context).size.width * 0.7,
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
                                                text: '# ${itemNo[index]}',
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
                            Container(
                              width: width * 0.3,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: <Widget>[
                                  Flexible(
                                    child: ButtonTheme(
                                      minWidth: 50.0,
                                      height: 30.0,
                                      splashColor: AbubaPallate.menuBluebird,
                                      child: OutlineButton(
                                        child: Text(
                                          'OPEN',
                                          style: TextStyle(fontSize: 13.0, color: AbubaPallate.menuBluebird),
                                        ),
                                        borderSide: BorderSide(color: AbubaPallate.menuBluebird, width: 1.0),
                                        highlightedBorderColor: AbubaPallate.menuBluebird,
                                        onPressed: () {
                                          Navigator.push(context,
                                              MaterialPageRoute(
                                                  builder: (_) => DetailWorkingOrder(idUser: widget.idUser, namaUser: widget.namaUser, departmentUser: widget.departmentUser, index: docID[index])
                                              )
                                          );
                                        },
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                );
              } else {
                return Container();
              }
            } else {
              return Container();
            }
          }
        ),
    );
  }

  Widget _searchListView() {
    final double width = MediaQuery.of(context).size.width;

    dateListItems = new List<dynamic>();
    statusListItems = new List<String>();
    _searchListItems = new List<String>();
    itemListItems = new List<String>();
    lokasiListItems = new List<String>();
    merekListItems = new List<String>();
    itemNoListItems = new List<String>();
    dueDateListItems = new List<dynamic>();
    jobdescTimeListItems = new List<dynamic>();
    newScheduleListItems = new List<dynamic>();
    alasanListItems = new List<dynamic>();
    rescheduleByListItems = new List<dynamic>();
    jobdescIDListItems = new List<dynamic>();
    frequencyListItems = new List<String>();
    picListItems = new List<dynamic>();
    ratingListItems = new List<dynamic>();
    docIDListItems = new List<dynamic>();
    for (int i = 0; i < outlet.length; i++) {
      var outletDua = outlet[i];
      var statusDua = status[i];
      var itemDua = item[i];
      var dateDua = date[i];
      var lokasiDua = lokasi[i];
      var merekDua = merek[i];
      var itemNoDua = itemNo[i];
      var dueDateDua = dueDate[i];
      var jobdescTimeDua = jobdescTime[i];
      var newScheduleDua = newSchedule[i];
      var alasanDua = alasan[i];
      var rescheduleByDua = rescheduleBy[i];
      var jobdescIDDua = jobdescID[i];
      var frequencyDua = frequency[i];
      var picDua = pic[i];
      var ratingDua = rating[i];
      var indexDua = docID[i];

      if (outletDua.toLowerCase().contains(_searchText.toLowerCase())) {
        _searchListItems.add(outletDua);
        statusListItems.add(statusDua);
        itemListItems.add(itemDua);
        dateListItems.add(dateDua);
        lokasiListItems.add(lokasiDua);
        merekListItems.add(merekDua);
        itemNoListItems.add(itemNoDua);
        dueDateListItems.add(dueDateDua);
        jobdescTimeListItems.add(jobdescTimeDua);
        newScheduleListItems.add(newScheduleDua);
        alasanListItems.add(alasanDua);
        rescheduleByListItems.add(rescheduleByDua);
        jobdescIDListItems.add(jobdescIDDua);
        frequencyListItems.add(frequencyDua);
        picListItems.add(picDua);
        ratingListItems.add(ratingDua);
        docIDListItems.add(indexDua);
      } else  if (statusDua.toLowerCase().contains(_searchText.toLowerCase())) {
        _searchListItems.add(outletDua);
        statusListItems.add(statusDua);
        itemListItems.add(itemDua);
        dateListItems.add(dateDua);
        lokasiListItems.add(lokasiDua);
        merekListItems.add(merekDua);
        itemNoListItems.add(itemNoDua);
        dueDateListItems.add(dueDateDua);
        jobdescTimeListItems.add(jobdescTimeDua);
        newScheduleListItems.add(newScheduleDua);
        alasanListItems.add(alasanDua);
        rescheduleByListItems.add(rescheduleByDua);
        jobdescIDListItems.add(jobdescIDDua);
        frequencyListItems.add(frequencyDua);
        picListItems.add(picDua);
        ratingListItems.add(ratingDua);
        docIDListItems.add(indexDua);
      } else  if (itemDua.toLowerCase().contains(_searchText.toLowerCase())) {
        _searchListItems.add(outletDua);
        statusListItems.add(statusDua);
        itemListItems.add(itemDua);
        dateListItems.add(dateDua);
        lokasiListItems.add(lokasiDua);
        merekListItems.add(merekDua);
        itemNoListItems.add(itemNoDua);
        dueDateListItems.add(dueDateDua);
        jobdescTimeListItems.add(jobdescTimeDua);
        newScheduleListItems.add(newScheduleDua);
        alasanListItems.add(alasanDua);
        rescheduleByListItems.add(rescheduleByDua);
        jobdescIDListItems.add(jobdescIDDua);
        frequencyListItems.add(frequencyDua);
        picListItems.add(picDua);
        ratingListItems.add(ratingDua);
        docIDListItems.add(indexDua);
      } else  if (lokasiDua.toLowerCase().contains(_searchText.toLowerCase())) {
        _searchListItems.add(outletDua);
        statusListItems.add(statusDua);
        itemListItems.add(itemDua);
        dateListItems.add(dateDua);
        lokasiListItems.add(lokasiDua);
        merekListItems.add(merekDua);
        itemNoListItems.add(itemNoDua);
        dueDateListItems.add(dueDateDua);
        jobdescTimeListItems.add(jobdescTimeDua);
        newScheduleListItems.add(newScheduleDua);
        alasanListItems.add(alasanDua);
        rescheduleByListItems.add(rescheduleByDua);
        jobdescIDListItems.add(jobdescIDDua);
        frequencyListItems.add(frequencyDua);
        picListItems.add(picDua);
        ratingListItems.add(ratingDua);
        docIDListItems.add(indexDua);
      } else  if (merekDua.toLowerCase().contains(_searchText.toLowerCase())) {
        _searchListItems.add(outletDua);
        statusListItems.add(statusDua);
        itemListItems.add(itemDua);
        dateListItems.add(dateDua);
        lokasiListItems.add(lokasiDua);
        merekListItems.add(merekDua);
        itemNoListItems.add(itemNoDua);
        dueDateListItems.add(dueDateDua);
        jobdescTimeListItems.add(jobdescTimeDua);
        newScheduleListItems.add(newScheduleDua);
        alasanListItems.add(alasanDua);
        rescheduleByListItems.add(rescheduleByDua);
        jobdescIDListItems.add(jobdescIDDua);
        frequencyListItems.add(frequencyDua);
        picListItems.add(picDua);
        ratingListItems.add(ratingDua);
        docIDListItems.add(indexDua);
      }
    }
    return _searchAddList(width);
  }

  Widget _searchAddList(width) {
    return new Flexible(
      child: new ListView.builder(
          itemCount: _searchListItems.length,
          itemBuilder: (BuildContext context, int index) {
            Timestamp dateView = dateListItems[index];
            if (statusListItems[index] != 'NOT READY') {
              return Container();
            } else if (statusListItems[index] == 'NOT READY') {
              if (managerIT == widget.idUser) {
                return Container(
                  width: width,
                  padding: const EdgeInsets.only(right: 5.0, left: 5.0),
                  margin: const EdgeInsets.only(bottom: 5.0),
                  color: Colors.grey[100],
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: index == statusListItems.length - 1 ? const EdgeInsets.fromLTRB(12.0, 6.0, 12.0, 12.0) : const EdgeInsets.fromLTRB(12.0, 6.0, 12.0, 12.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Container(
                              width: width * 0.3,
                              child: Row(
                                children: <Widget>[
                                  Flexible(
                                    child: Text(
                                      dateView.toDate().toString().substring(8, 10) + '/' + dateView.toDate().toString().substring(5, 7) + '/' +dateView.toDate().toString().substring(0, 4),
                                      style: TextStyle(
                                          fontSize: 12.0, color: Colors.black),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Container(
                                width: width * 0.3,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    Container(
                                      width: MediaQuery.of(context).size.width * 0.7,
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
                                                text: '${_searchListItems[index]}',
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
                                      width: MediaQuery.of(context).size.width * 0.7,
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
                                                text: lokasiListItems[index],
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
                                      width: MediaQuery.of(context).size.width * 0.7,
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
                                                text: '${merekListItems[index]} - ${itemListItems[index]}',
                                                style: TextStyle(
                                                    fontSize: 12.0,
                                                    color: Colors.black
                                                ),
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      height: 3.0,
                                    ),
                                    Container(
                                      width: MediaQuery.of(context).size.width * 0.7,
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
                                                text: '# ${itemNoListItems[index]}',
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
                            Container(
                              width: width * 0.3,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: <Widget>[
                                  Flexible(
                                    child: ButtonTheme(
                                      minWidth: 50.0,
                                      height: 30.0,
                                      splashColor: AbubaPallate.menuBluebird,
                                      child: OutlineButton(
                                        child: Text(
                                          'OPEN',
                                          style: TextStyle(fontSize: 13.0, color: AbubaPallate.menuBluebird),
                                        ),
                                        borderSide: BorderSide(color: AbubaPallate.menuBluebird, width: 1.0),
                                        highlightedBorderColor: AbubaPallate.menuBluebird,
                                        onPressed: () {
                                          Navigator.push(context,
                                              MaterialPageRoute(
                                                  builder: (_) => DetailWorkingOrder(idUser: widget.idUser, namaUser: widget.namaUser, departmentUser: widget.departmentUser, index: docIDListItems[index])
                                              )
                                          );
                                        },
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                );
              } else {
                return Container();
              }
            } else {
              return Container();
            }
          }),
    );
  }
}
