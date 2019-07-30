import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_abuba/constant.dart';
import 'package:flutter_abuba/isoft/IT_page/perbaikan/detail_workingOrder.dart';
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

  var _searchEdit = TextEditingController();

  int managerIT;
  int asManagerIT;

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

    Firestore.instance.collection('user').where('grade', isEqualTo: 'Manager').where('department', isEqualTo: 'IT').snapshots().listen((data3) {
      setState(() {
        managerIT = data3.documents[0].data['id'];
      });
    });

    Firestore.instance.collection('user').where('grade', isEqualTo: 'Assistant Manager').where('department', isEqualTo: 'IT').snapshots().listen((data4) {
      setState(() {
        asManagerIT = data4.documents[0].data['id'];
      });
    });

    CollectionReference reference = Firestore.instance.collection('perbaikanIT');
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

          item.add(change.document.data['item']);
          itemNo.add(change.document.data['itemNo']);

          if (change.document.data['newDueDate'] == null) {
            newSchedule.add(null);
          } else {
            newSchedule.add(change.document.data['newDueDate']);
          }

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

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.dark.copyWith(
      statusBarColor: Color(0xfff9f9f9),),
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            elevation: 0.25,
            backgroundColor: Colors.white,
            iconTheme: IconThemeData(color: Colors.black),
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Flexible(
                  child: Text('Working Order', style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w600, color: Colors.black)),
                )
              ],
            )
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
                      : Column(
                    children: <Widget>[
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
                      Flexible(
                        child: ListView.builder(
                          itemCount: outlet.length,
                          itemBuilder: (BuildContext context, int index) {
                            Timestamp dateView = date[index];
                            if (status[index] != 'NOT READY') {
                              return Container();
                            } else if (status[index] == 'NOT READY') {
                              if (managerIT == widget.idUser || asManagerIT == widget.idUser) {
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
                                                          Navigator.pushReplacement(context,
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
                      )
                    ],
                  );
                },
              )
          )
        ),
      ),
    );
  }
}
