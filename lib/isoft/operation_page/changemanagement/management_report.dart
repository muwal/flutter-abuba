import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_abuba/constant.dart';
import 'package:flutter_abuba/isoft/operation_page/changemanagement/management_report_detail.dart';

class ManagementReport extends StatefulWidget {
  final int idUser;
  final String namaUser;
  final String departmentUser;
  ManagementReport({this.idUser, this.namaUser, this.departmentUser});

  @override
  _ManagementReportState createState() => _ManagementReportState();
}

class _ManagementReportState extends State<ManagementReport> with TickerProviderStateMixin {
  AnimationController animationController;

  List<dynamic> categoryList = [];
  List<String> personReviewDateList = [];
  List<String> userCreatedList = [];
  List<String> deptUserList = [];
  List<dynamic> changeNoList = [];
  List<dynamic> tanggalList = [];
  List<dynamic> statusList = [];
  List<dynamic> reviewDateList = [];
  List<dynamic> personReviewList = [];
  List<dynamic> docIDList = [];

  List<dynamic> category = [];
  List<String> personReviewDate = [];
  List<String> userCreated = [];
  List<String> deptUser = [];
  List<dynamic> changeNo = [];
  List<dynamic> tanggal = [];
  List<dynamic> status = [];
  List<dynamic> reviewDate = [];
  List<dynamic> personReview = [];
  var docID = [];

  var _searchEdit = new TextEditingController();

  bool _isSearch = true;
  String _searchText = "";

   @override
  void initState() {
    super.initState();

    CollectionReference reference = Firestore.instance.collection('changeMgmt');
    reference.snapshots().listen((querySnapshot) {
      querySnapshot.documentChanges.forEach((change) {
        setState(() {
          changeNo.add(change.document.data['changeNo']);
          tanggal.add(change.document.data['dateCreated']);
          status.add(change.document.data['finalStatus']);
          reviewDate.add(change.document.data['personReviewDate']);
          personReview.add(change.document.data['personReview']);
          docID.add(change.document.documentID);

          Firestore.instance.collection('changeMgmt_Category').where('id', isEqualTo: change.document.data['category']).snapshots().listen((data) {
            category.add(data.documents[0].data['category']);
          });

          Firestore.instance.collection('user').where('id', isEqualTo: change.document.data['userCreated']).snapshots().listen((data6) {
            userCreated.add(data6.documents[0].data['nama']);
            deptUser.add(data6.documents[0].data['department']);
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

  _ManagementReportState() {
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
          // actions: <Widget>[
          //   IconButton(
          //     tooltip: 'Search',
          //     icon: Icon(Icons.search),
          //     onPressed: () {}
          //   )
          // ],
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
                          'Change Management',
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
          itemCount: changeNo.length,
          itemBuilder: (BuildContext context, int index) {
            Timestamp date = tanggal[index];
            DateTime dateBantu = DateTime.tryParse(date.toDate().toString());

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
                                          text: category[index],
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
                                          text: '${userCreated[index]} - ${deptUser[index]}',
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
                                          text: '${changeNo[index].toString().padLeft(4, '0')}',
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
                          padding: EdgeInsets.symmetric(horizontal: 5.0),
                          minWidth: 80.0,
                          height: 30.0,
                          child: OutlineButton(
                            borderSide: BorderSide(
                                color: status[index] == 'OPEN' ? AbubaPallate.menuBluebird : status[index] == 'APPROVED' ? AbubaPallate.greenabuba : status[index] == 'REJECTED' ? Colors.redAccent : AbubaPallate.menuBluebird),
                            child: Text(
                              status[index],
                              style: TextStyle(
                                  fontSize: 12.0,
                                  color: status[index] == 'OPEN' ? AbubaPallate.menuBluebird : status[index] == 'APPROVED' ? AbubaPallate.greenabuba : status[index] == 'REJECTED' ? Colors.redAccent : AbubaPallate.menuBluebird),
                              textAlign: TextAlign.center,
                            ),
                            onPressed: () {
                              personReviewDate.clear();
                              personReviewDate = [];

                              for (int a = 0; a < reviewDate[index].length; a++) {
                                /*print(reviewDate[index][a]);*/
                                if (personReviewDate.length > reviewDate[index].length) {

                                } else {
                                  if (reviewDate[index][a] == null) {
                                    personReviewDate.add(' ');
                                  } else {
                                    Timestamp bantu = reviewDate[index][a];
                                    personReviewDate.add(bantu.toDate().toString().substring(8, 10) + '/' + bantu.toDate().toString().substring(5, 7) + '/' +bantu.toDate().toString().substring(0, 4));
                                  }
                                }
                              }

                              Navigator.push(context,
                                  MyCustomRoute(
                                      builder: (context) => ManagementReportDetail(idUser: widget.idUser, namaUser: widget.namaUser, departmentUser: widget.departmentUser, index: docID[index], personReview: personReview[index], personReviewDate: personReviewDate)
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
      ),
    );
  }

  Widget _searchListView() {
    final double width = MediaQuery.of(context).size.width;

    categoryList = List<dynamic>();
    personReviewDateList = List<String>();
    userCreatedList = List<String>();
    deptUserList = List<String>();
    changeNoList = List<dynamic>();
    tanggalList = List<dynamic>();
    statusList = List<dynamic>();
    reviewDateList = List<dynamic> ();
    personReviewList = List<dynamic> ();
    docIDList = List<dynamic>();

    for (int i = 0; i < changeNo.length; i++) {
      var categoryDua = category[i];
      var tanggalDua = tanggal[i];
      var changeNoDua = changeNo[i];
      var statusDua = status[i];
      var userCreatedDua = userCreated[i];
      var reviewDateDua = reviewDate[i];
      var personReviewDua = personReview[i];
      var docIDDua = docID[i];
      /*
      var dateCreatedDua = dateCreated[i];
      var lokasiDua = lokasi[i];
      var noDua = no[i];
      var statusActionPlanDua = statusActionPlan[i];*/
      /*
      var docIDDua = docID[i];
      */

      if (categoryDua.toLowerCase().contains(_searchText.toLowerCase())) {
        categoryList.add(categoryDua);
        tanggalList.add(tanggalDua);
        changeNoList.add(changeNoDua);
        statusList.add(statusDua);
        userCreatedList.add(userCreatedDua);
        reviewDateList.add(reviewDateDua);
        personReviewList.add(personReviewDua);
        docIDList.add(docIDDua);
      } else if (userCreatedDua.toLowerCase().contains(_searchText.toLowerCase())) {
        categoryList.add(categoryDua);
        tanggalList.add(tanggalDua);
        changeNoList.add(changeNoDua);
        statusList.add(statusDua);
        userCreatedList.add(userCreatedDua);
        reviewDateList.add(reviewDateDua);
        personReviewList.add(personReviewDua);
        docIDList.add(docIDDua);
      }
    }
    return _searchAddList(width);
  }

  Widget _searchAddList(width) {
    return new Flexible(
      child: ListView.builder(
          itemCount: changeNoList.length,
          itemBuilder: (BuildContext context, int index) {
            Timestamp date = tanggalList[index];
            DateTime dateBantu = DateTime.tryParse(date.toDate().toString());


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
                                          text: categoryList[index],
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
                                          text: '${userCreatedList[index]} - ',
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
                                          text: '${changeNoList[index].toString().padLeft(4, '0')}',
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
                          padding: EdgeInsets.symmetric(horizontal: 5.0),
                          minWidth: 80.0,
                          height: 30.0,
                          child: OutlineButton(
                            borderSide: BorderSide(
                                color: statusList[index] == 'OPEN' ? AbubaPallate.yellow : statusList[index] == 'APPROVED' ? AbubaPallate.greenabuba : statusList[index] == 'REJECTED' ? Colors.redAccent : AbubaPallate.menuBluebird),
                            child: Text(
                              statusList[index],
                              style: TextStyle(
                                  fontSize: 12.0,
                                  color: statusList[index] == 'OPEN' ? AbubaPallate.yellow : statusList[index] == 'APPROVED' ? AbubaPallate.greenabuba : statusList[index] == 'REJECTED' ? Colors.redAccent : AbubaPallate.menuBluebird),
                              textAlign: TextAlign.center,
                            ),
                            onPressed: () {
                              personReviewDate.clear();
                              personReviewDate = [];

                              for (int a = 0; a < reviewDateList[index].length; a++) {
                                /*print(reviewDate[index][a]);*/
                                if (personReviewDate.length > reviewDateList[index].length) {

                                } else {
                                  if (reviewDateList[index][a] == null) {
                                    personReviewDate.add(' ');
                                  } else {
                                    Timestamp bantu = reviewDateList[index][a];
                                    personReviewDate.add(bantu.toDate().toString().substring(8, 10) + '/' + bantu.toDate().toString().substring(5, 7) + '/' +bantu.toDate().toString().substring(0, 4));
                                  }
                                }
                              }


                              Navigator.push(context,
                                  MyCustomRoute(
                                      builder: (context) => ManagementReportDetail(idUser: widget.idUser, namaUser: widget.namaUser, departmentUser: widget.departmentUser, index: docIDList[index], personReview: personReviewList[index], personReviewDate: personReviewDate)
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
      ),
    );
  }
}