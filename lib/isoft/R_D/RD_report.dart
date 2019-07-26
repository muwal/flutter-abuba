import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_abuba/isoft/R_D/RD_report_detail.dart';
import 'package:flutter_abuba/constant.dart';

class RDreport extends StatefulWidget {
  final int idUser;
  RDreport({Key key, this.idUser}) : super(key: key);

  _RDreportState createState() => _RDreportState();
}

class _RDreportState extends State<RDreport> with TickerProviderStateMixin {
  AnimationController animationController;

  var _searchEdit = new TextEditingController();

  bool _isSearch = true;
  String _searchText = "";

  List<dynamic> namaCreatedList = [];
  List<dynamic> departmentCreatedList = [];
  List<dynamic> tanggalEksperimenList = [];
  List<dynamic> namaProdukList = [];
  List<dynamic> categoryList = [];
  List<dynamic> statusList = [];
  List<dynamic> docIDList = [];
  List<dynamic> parameterList = [];
  List<dynamic> kirimKepadaList = [];
  List<dynamic> scoreParameterList = [];

  List<dynamic> namaCreated = [];
  List<dynamic> departmentCreated = [];
  List<dynamic> tanggalEksperimen = [];
  List<dynamic> namaProduk = [];
  List<dynamic> category = [];
  List<dynamic> status = [];
  var docID = [];
  List<dynamic> parameter = [];
  List<dynamic> kirimKepada = [];
  List<dynamic> scoreParameter = [];

  _RDreportState() {
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

    CollectionReference reference = Firestore.instance.collection('rnd_eksperimen');
    reference.snapshots().listen((data) {
      data.documentChanges.forEach((change) {
        setState(() {
          docID.add(change.document.documentID);
          parameter.add(change.document.data['id_parameter']);
          kirimKepada.add(change.document.data['kirim_kepada']);
          scoreParameter.add(change.document.data['scoreParameter']);
          tanggalEksperimen.add(change.document.data['dateCreated']);
          status.add(change.document.data['status']);
          Firestore.instance.collection('product_complaint-mg').where('id', isEqualTo: change.document.data['id_product']).snapshots().listen((data2) {
            namaProduk.add(data2.documents[0].data['product']);
          });

          Firestore.instance.collection('rnd_eksperimen_category').where('id', isEqualTo: change.document.data['id_eksperimen_category']).snapshots().listen((data3) {
            category.add(data3.documents[0].data['category']);
          });

          Firestore.instance.collection('user').where('id', isEqualTo: change.document.data['userCreated']).snapshots().listen((data5) {
            namaCreated.add(data5.documents[0].data['nama']);

            Firestore.instance.collection('department').where('id', isEqualTo: data5.documents[0].data['departmentID']).snapshots().listen((data6) {
              departmentCreated.add(data6.documents[0].data['department']);
            });
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
          appBar: _appBar(),
          body:GestureDetector(
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
                            'R&D',
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
      child: ListView.builder(
          itemCount: namaProduk.length,
          itemBuilder: (BuildContext context, int index) {
            Timestamp date = tanggalEksperimen[index];
            DateTime dateBantu = DateTime.tryParse(date.toDate().toString());

            if (status[index].contains('APPROVED') || status[index].contains('REJECTED')) {
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
                                            text: namaProduk[index],
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
                                            text: 'Diajukan oleh',
                                            style: TextStyle(
                                                fontSize: 11.0,
                                                fontWeight: FontWeight.w300,
                                                color: AbubaPallate.green
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
                                            text: '${namaCreated[index]} - ${departmentCreated[index]}',
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
                                style: TextStyle(fontSize: 13.0, color: status[index].contains('REJECTED') ? Colors.redAccent : AbubaPallate.green),
                              ),
                              borderSide: BorderSide(color: status[index].contains('REJECTED') ? Colors.redAccent : AbubaPallate.green, width: 1.0),
                              highlightedBorderColor: status[index].contains('REJECTED') ? Colors.redAccent : AbubaPallate.green,
                              onPressed: () {
                                Navigator.push(context,
                                    MyCustomRoute(
                                      builder: (context) => RDreportDetail(idUser: widget.idUser, eksperimenID: docID[index], parameter: parameter[index], kirimKepada: kirimKepada[index], score: scoreParameter[index]),
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
      ),
    );
  }

  Widget _searchListView() {
    final double width = MediaQuery.of(context).size.width;

    namaCreatedList = List<dynamic>();
    departmentCreatedList = List<dynamic>();
    tanggalEksperimenList = List<dynamic>();
    namaProdukList = List<dynamic>();
    categoryList = List<dynamic>();
    statusList = List<dynamic>();
    docIDList = List<dynamic>();
    parameterList = List<dynamic>();
    kirimKepadaList = List<dynamic>();
    scoreParameterList = List<dynamic>();

    for (int i = 0; i < namaProduk.length; i++) {
      var namaCreatedDua = namaCreated[i];
      var statusDua = status[i];
      var departmentCreatedDua = departmentCreated[i];
      var tanggalEksperimenDua = tanggalEksperimen[i];
      var namaProdukDua = namaProduk[i];
      var categoryDua = category[i];
      var docIDDua = docID[i];
      var parameterDua = parameter[i];
      var kirimKepadaDua = kirimKepada[i];
      var scoreParameterDua = scoreParameter[i];

      if (namaCreatedDua.toLowerCase().contains(_searchText.toLowerCase())) {
        namaCreatedList.add(namaCreatedDua);
        statusList.add(statusDua);
        departmentCreatedList.add(departmentCreatedDua);
        tanggalEksperimenList.add(tanggalEksperimenDua);
        namaProdukList.add(namaProdukDua);
        categoryList.add(categoryDua);
        docIDList.add(docIDDua);
        parameterList.add(parameterDua);
        kirimKepadaList.add(kirimKepadaDua);
        scoreParameterList.add(scoreParameterDua);
      } else if (namaProdukDua.toLowerCase().contains(_searchText.toLowerCase())) {
        namaCreatedList.add(namaCreatedDua);
        statusList.add(statusDua);
        departmentCreatedList.add(departmentCreatedDua);
        tanggalEksperimenList.add(tanggalEksperimenDua);
        namaProdukList.add(namaProdukDua);
        categoryList.add(categoryDua);
        docIDList.add(docIDDua);
        parameterList.add(parameterDua);
        kirimKepadaList.add(kirimKepadaDua);
        scoreParameterList.add(scoreParameterDua);
      } else if (categoryDua.toLowerCase().contains(_searchText.toLowerCase())) {
        namaCreatedList.add(namaCreatedDua);
        statusList.add(statusDua);
        departmentCreatedList.add(departmentCreatedDua);
        tanggalEksperimenList.add(tanggalEksperimenDua);
        namaProdukList.add(namaProdukDua);
        categoryList.add(categoryDua);
        docIDList.add(docIDDua);
        parameterList.add(parameterDua);
        kirimKepadaList.add(kirimKepadaDua);
        scoreParameterList.add(scoreParameterDua);
      }
    }
    return _searchAddList(width);
  }

  Widget _searchAddList(width) {
    return new Flexible(
      child: ListView.builder(
          itemCount: namaCreatedList.length,
          itemBuilder: (BuildContext context, int index) {
            Timestamp date = tanggalEksperimenList[index];
            DateTime dateBantu = DateTime.tryParse(date.toDate().toString());

            if (statusList[index].contains('APPROVED') || statusList[index].contains('REJECTED')) {
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
                                            text: namaProdukList[index],
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
                                            text: 'Diajukan oleh',
                                            style: TextStyle(
                                                fontSize: 11.0,
                                                fontWeight: FontWeight.w300,
                                                color: AbubaPallate.green
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
                                            text: '${namaCreatedList[index]} - ${departmentCreatedList[index]}',
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
                                style: TextStyle(fontSize: 13.0, color: statusList[index].contains('REJECTED') ? Colors.redAccent : AbubaPallate.green),
                              ),
                              borderSide: BorderSide(color: statusList[index].contains('REJECTED') ? Colors.redAccent : AbubaPallate.green, width: 1.0),
                              highlightedBorderColor: statusList[index].contains('REJECTED') ? Colors.redAccent : AbubaPallate.green,
                              onPressed: () {
                                Navigator.push(context,
                                    MyCustomRoute(
                                      builder: (context) => RDreportDetail(idUser: widget.idUser, eksperimenID: docIDList[index], parameter: parameterList[index], kirimKepada: kirimKepadaList[index], score: scoreParameterList[index]),
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
      ),
    );
  }

  Widget _appBar() {
    return AppBar(
      elevation: 0.25,
      backgroundColor: Colors.white,
      iconTheme: IconThemeData(color: Colors.black),
      actions: <Widget>[
        IconButton(
            tooltip: 'Search',
            icon: Icon(Icons.search),
            onPressed: () {}
        )
      ],
      title: Image.asset(
        'assets/images/logo2.png',
        height: 150.0,
        width: 120.0,
      ),
    );
  }
}