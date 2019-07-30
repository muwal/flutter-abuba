import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_abuba/constant.dart';
import 'package:flutter_abuba/isoft/operation_page/incoming/detail_report.dart';
import 'package:intl/intl.dart';

class FormReport extends StatefulWidget {
  final int idUser;
  final String namaUser;
  final String departmentUser;
  FormReport({this.idUser, this.namaUser, this.departmentUser});

  @override
  _FormReportState createState() => _FormReportState();
}

class _FormReportState extends State<FormReport> with TickerProviderStateMixin {
  AnimationController animationController;
  
  final dateFormat = DateFormat("MMMM d, yyyy");
  DateTime dateStart;
  DateTime dateEnd;

  bool showDataFiltered = false;
  bool showHelper = false;
  String helperText = '';

  List<String> materialList = [];
  List<dynamic> materialCodeList = [];
  List<Timestamp> tanggalList = [];
  List<String> statusList = [];
  List<String> supplierList = [];

  List<dynamic> docIDList = [];

  List<String> material = [];
  List<dynamic> materialCode = [];
  List<Timestamp> tanggal = [];
  List<String> status = [];
  List<String> supplier = [];

  var docID = [];

  var _searchEdit = new TextEditingController();

  bool _isSearch = true;
  String _searchText = "";

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
  void initState() {
    super.initState();
    CollectionReference reference = Firestore.instance.collection('incoming');
    reference.snapshots().listen((data) {
      data.documentChanges.forEach((change) {
        setState(() {
          status.add(change.document.data['status']);
          tanggal.add(change.document.data['date_created']);
          docID.add(change.document.documentID);

          Firestore.instance.collection('material').where('id', isEqualTo: change.document.data['id_material']).snapshots().listen((data2) {
            material.add(data2.documents[0].data['material']);
            materialCode.add(data2.documents[0].data['resource_code']);
          });

          Firestore.instance.collection('supplier').where('id', isEqualTo: change.document.data['id_supplier']).snapshots().listen((data2) {
            supplier.add(data2.documents[0].data['supplier']);
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
          elevation: 1.0,
          backgroundColor: Colors.white,
          iconTheme: IconThemeData(color: Colors.black),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Flexible(
                child: Text('Report', style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w600, color: Colors.black),),
              ),
              /*Stack(
                children: <Widget>[
                  Icon(Icons.notifications, color: Colors.grey[400],)
                ],
              )*/
            ],
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
        ),
      ),
    );
  }

  Widget _searchBox() {
    return new Container(
      margin: const EdgeInsets.only(bottom: 10.0, right: 15.0, left: 15.0, top: 10.0),
      decoration: BoxDecoration(border: Border.all(width: 1.0, color: Colors.white), borderRadius: BorderRadius.circular(25.0), color: Colors.white, boxShadow: [BoxShadow(
        color: Colors.grey[200],
        blurRadius: 2.0,
      ),]  ),
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

            if (status[index] != 'APPROVED' && status[index] != 'REJECTED' && status[index] != 'CONCESSION') {
              return Container ();
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
                                            text: material[index],
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
                                            text: supplier[index],
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
                                            text: '# ${materialCode[index]}',
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
                                style: TextStyle(fontSize: 13.0,
                                    color: status[index] == 'APPROVED'
                                        ? Colors.green
                                        : status[index] == 'REJECTED'
                                        ? Colors.redAccent
                                        : AbubaPallate.menuBluebird),
                              ),
                              borderSide: BorderSide(
                                  color: status[index] == 'APPROVED'
                                      ? Colors.green
                                      : status[index] == 'REJECTED'
                                      ? Colors.redAccent
                                      : AbubaPallate.menuBluebird, width: 1.0),
                              highlightedBorderColor: status[index] == 'APPROVED'
                                  ? Colors.green
                                  : status[index] == 'REJECTED'
                                  ? Colors.redAccent
                                  : AbubaPallate.menuBluebird,
                              onPressed: () {
                                Navigator.push(context,
                                    MaterialPageRoute(
                                        builder: (_) => DetailReport(idUser: widget.idUser, namaUser: widget.namaUser, departmentUser: widget.departmentUser, index: docID[index])
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
      ),
    );
  }

  Widget _searchListView() {
    final double width = MediaQuery.of(context).size.width;

    materialList = List<String>();
    materialCodeList = List<dynamic> ();
    tanggalList = List<Timestamp> ();
    statusList = List<String>();
    supplierList = List<String>();
    docIDList = List<dynamic> ();

    for (int i = 0; i < status.length; i++) {
      var materialDua = material[i];
      var statusDua = status[i];
      var materialCodeDua = materialCode[i];
      var tanggalDua = tanggal[i];
      var supplierDua = supplier[i];
      var docIDDua = docID[i];


      if (materialDua.toLowerCase().contains(_searchText.toLowerCase())) {
        materialList.add(materialDua);
        statusList.add(statusDua);
        materialCodeList.add(materialCodeDua);
        tanggalList.add(tanggalDua);
        supplierList.add(supplierDua);
        docIDList.add(docIDDua);
      } else if (supplierDua.toLowerCase().contains(_searchText.toLowerCase())) {
        materialList.add(materialDua);
        statusList.add(statusDua);
        materialCodeList.add(materialCodeDua);
        tanggalList.add(tanggalDua);
        supplierList.add(supplierDua);
        docIDList.add(docIDDua);
      } else if (statusDua.toLowerCase().contains(_searchText.toLowerCase())) {
        materialList.add(materialDua);
        statusList.add(statusDua);
        materialCodeList.add(materialCodeDua);
        tanggalList.add(tanggalDua);
        supplierList.add(supplierDua);
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

            if (statusList[index] != 'APPROVED' && statusList[index] != 'REJECTED' && statusList[index] != 'CONCESSION') {
              return Container ();
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
                                            text: materialList[index],
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
                                            text: supplierList[index],
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
                                            text: '# ${materialCodeList[index]}',
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
                                statusList[index] ,
                                style: TextStyle(fontSize: 13.0,
                                    color: statusList[index] == 'APPROVED'
                                        ? Colors.green
                                        : statusList[index] == 'REJECTED'
                                        ? Colors.redAccent
                                        : AbubaPallate.menuBluebird),
                              ),
                              borderSide: BorderSide(
                                  color: statusList[index] == 'APPROVED'
                                      ? Colors.green
                                      : statusList[index] == 'REJECTED'
                                      ? Colors.redAccent
                                      : AbubaPallate.menuBluebird, width: 1.0),
                              highlightedBorderColor: statusList[index] == 'APPROVED'
                                  ? Colors.green
                                  : statusList[index] == 'REJECTED'
                                  ? Colors.redAccent
                                  : AbubaPallate.menuBluebird,
                              onPressed: () {
                                Navigator.push(context,
                                    MaterialPageRoute(
                                        builder: (_) => DetailReport(idUser: widget.idUser, namaUser: widget.namaUser, departmentUser: widget.departmentUser, index: docIDList[index])
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
                'Incoming',
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
                      // setState(() {
                      //   if (dateStart.isAfter(dateEnd) == false) {
                      //     showDataFiltered = true;
                      //     showHelper = false;
                      //     helperText = '';
                      //   } else {
                      //     showDataFiltered = false;
                      //     showHelper = true;
                      //     helperText = "can\'t back date";
                      //   }
                      // });
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
        AnimatedBuilder(
          animation: animationController,
          builder: (_, Widget child) {
            return animationController.isAnimating
              ? Container(
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                )
              : Container(
                  color: Colors.white,
                  child: Column(
                    children: List.generate(material.length, (index) {
                      if (status[index] != 'APPROVED' && status[index] != 'REJECTED' && status[index] != 'CONCESSION') {
                        return Container();
                      } else {
                        return ListTile(
                          leading: Container(
                            padding: EdgeInsets.only(top: 5.0),
                            alignment: Alignment.centerRight,
                            width: MediaQuery.of(context).size.width * 0.35,
                            child: Row(
                              children: <Widget>[
                                Flexible(
                                  child: Text(
                                    material[index],
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
                                    tanggal[index].toDate().toString().substring(8, 10) + '/' + tanggal[index].toDate().toString().substring(5, 7) + '/' +tanggal[index].toDate().toString().substring(0, 4),
                                    style: TextStyle(
                                        fontSize: 12.0, color: Colors.black54),
                                  ),
                                )
                              ],
                            ),
                          ),
                          trailing: Container(
                            alignment: Alignment.centerRight,
                            width: MediaQuery.of(context).size.width * 0.3,
                            child: ButtonTheme(
                              padding: EdgeInsets.all(0.0),
                              height: 20.0,
                              child: OutlineButton(
                                child: Text(
                                  status[index],
                                  style: TextStyle(fontSize: 13.0, 
                                  color: status[index] == 'APPROVED' 
                                      ? Colors.green 
                                      : status[index] == 'REJECTED'
                                          ? Colors.redAccent 
                                          : AbubaPallate.menuBluebird),
                                  ),
                                  borderSide: BorderSide( 
                                  color: status[index] == 'APPROVED' 
                                        ? Colors.green 
                                        : status[index] == 'REJECTED'
                                            ? Colors.redAccent 
                                            : AbubaPallate.menuBluebird, width: 1.0),
                                  highlightedBorderColor: status[index] == 'APPROVED' 
                                        ? Colors.green 
                                        : status[index] == 'REJECTED'
                                            ? Colors.redAccent 
                                            : AbubaPallate.menuBluebird,
                                onPressed: () {
                                  Navigator.push(context,
                                    MaterialPageRoute(
                                      builder: (_) => DetailReport(idUser: widget.idUser, namaUser: widget.namaUser, departmentUser: widget.departmentUser, index: docID[index])
                                    )
                                  );
                                },
                              ),
                            )
                          )
                        );
                      }
                    }).toList()
                  )
                );
          },
        )
      ],
    );
  }
}
