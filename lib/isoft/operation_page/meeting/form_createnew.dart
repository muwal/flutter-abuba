import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_abuba/constant.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:intl/intl.dart';
import 'package:search_widget/search_widget.dart';

class LeaderBoard {
  final String name;
  final int id;

  LeaderBoard(this.name, this.id);
}

class FormCreateNew extends StatefulWidget {
  final int idUser;
  final String namaUser;
  final String departmentUser;

  FormCreateNew({this.idUser, this.namaUser, this.departmentUser});

  @override
  _FormCreateNewState createState() => _FormCreateNewState();
}

class _FormCreateNewState extends State<FormCreateNew> with SingleTickerProviderStateMixin {
  TabController _tabController;
  bool _isProccess = false;

  final List<Tab> internalAuditTabs = <Tab>[
    new Tab(child: Text('General', style: TextStyle(color: Colors.grey[400]))),
    new Tab(child: Text('Peserta', style: TextStyle(color: Colors.grey[400]))),
  ];

  var maxidMeeting;
  var indexMeeting;

  final dateFormat = DateFormat("MMMM d, yyyy h:mm a");
  DateTime dateStart;
  TextEditingController controllerAgenda = TextEditingController();
  TextEditingController controllerAgendaBantu = TextEditingController();
  List<String> agenda = [];

  String mySelection;
  List<int> whoID = [];
  List<String> whoName = [];
  String whoSelection;
  String whoSelection2;

  bool alertDateMeeting = false;

  List<LeaderBoard> listPIC = <LeaderBoard>[];
  int selectedPIC;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: internalAuditTabs.length);
    Firestore.instance.collection('dumper_minutesMeeting').snapshots().listen((data) {
      setState(() {
        maxidMeeting = data.documents[0].data['maxid_minutesMeeting'] + 1;
        indexMeeting = data.documents[0].documentID;
      });
    });

    Firestore.instance.collection('user').where('id', isEqualTo: widget.idUser).snapshots().listen((data) {
      setState(() {
        whoID.add(widget.idUser);
        whoName.add(data.documents[0].data['nama']);
      });
    });

    CollectionReference reference = Firestore.instance.collection('user');
    reference.orderBy('department', descending: false).snapshots().listen((data) {
      data.documentChanges.forEach((change) {
        setState(() {
          if (change.document.data['id'] != widget.idUser) {
            listPIC.add(LeaderBoard(change.document.data['department'] + ' - ' +change.document.data['nama'], change.document.data['id']));
          }
        });
      });
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  Widget _appBar() {
    return AppBar(
      elevation: 0.25,
      backgroundColor: Colors.white,
      iconTheme: IconThemeData(color: Colors.black),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Image.asset(
            'assets/images/logo2.png',
            height: 150.0,
            width: 120.0,
          ),
          new Container(
            child: new Row(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.only(right: 15.0),
                  child: Row(
                    children: [
                      Icon(
                        Icons.favorite,
                        color: Colors.red[500],
                        size: 20.0,
                      ),
                      SizedBox(
                        width: 5.0,
                      ),
                      Text(
                        '41 pts',
                        style: TextStyle(fontSize: 12.0, color: Colors.grey),
                      ),
                    ],
                  ),
                )
              ],
            ),
          )
        ],
      ),
      bottom: new TabBar(
        controller: _tabController,
        isScrollable: false,
        indicatorColor: AbubaPallate.greenabuba,
        tabs: internalAuditTabs,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: _appBar(),
          body: GestureDetector(
            onTap: () {
              FocusScope.of(context).requestFocus(FocusNode());
            },
            child: TabBarView(
              controller: _tabController,
              children: <Widget>[
                ListView(
                  children: <Widget>[
                    ListTile(
                      title: Padding(
                        padding: const EdgeInsets.only(left: 10.0),
                        child: Container(
                          alignment: Alignment.centerLeft,
                          decoration: BoxDecoration(
                            border: Border(
                              bottom: BorderSide(color: Colors.black87),
                            ),
                          ),
                          child: FlatButton(
                            onPressed: () {
                              DatePicker.showDateTimePicker(context,
                                showTitleActions: true,
                                onChanged: (date) {
                                  setState(() {
                                    if (date.isBefore(DateTime.now())) {
                                      alertDateMeeting = true;
                                    } else {
                                      alertDateMeeting = false;
                                      dateStart = date;
                                    }
                                  });
                                },
                                onConfirm: (date) {
                                  setState(() {
                                    if (date.isBefore(DateTime.now())) {
                                      alertDateMeeting = true;
                                    } else {
                                      alertDateMeeting = false;
                                      dateStart = date;
                                    }
                                  });
                                },
                                currentTime: dateStart == null ? DateTime.now() : dateStart,
                                locale: LocaleType.en
                              );
                            },
                            child: Text(
                              alertDateMeeting ? 'Can\'t back date' : dateStart == null ? 'Date Meeting' : dateStart.toString().substring(8, 10) + '/' + dateStart.toString().substring(5, 7) + '/' + dateStart.toString().substring(0, 4) + ' - ' + dateStart.toString().substring(11, 13) + ':' + dateStart.toString().substring(14, 16),
                              style: TextStyle(
                                color: alertDateMeeting ? Colors.redAccent: Colors.black45,
                                fontSize: 12.0
                              ),
                              textAlign: TextAlign.start,
                            ),
                          ),
                        )
                      ),
                      trailing: IconButton(
                        icon: Icon(Icons.add, color: Colors.transparent),
                        onPressed: () {},
                      ),
                    ),
                    ListTile(
                      title: Padding(
                        padding: const EdgeInsets.only(left: 10.0),
                          child: TextField(
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                            labelText: 'Nama Meeting',
                            labelStyle: TextStyle(fontSize: 12.0),
                          ),
                          maxLength: 100,
                          controller: controllerAgenda,
                          textCapitalization: TextCapitalization.sentences,
                          style: TextStyle(
                            color: Colors.black,
                          ),
                        ),
                      ),
                      trailing: IconButton(
                        icon: Icon(Icons.add, color: Colors.transparent),
                        onPressed: () {},
                      ),
                    ),
                    ListTile(
                      title: Padding(
                        padding: const EdgeInsets.only(left: 10.0),
                        child: TextField(
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                            labelText: 'Agenda',
                            labelStyle: TextStyle(fontSize: 12.0),
                          ),
                          maxLength: 250,
                          controller: controllerAgendaBantu,
                          textCapitalization: TextCapitalization.sentences,
                          style: TextStyle(
                            color: Colors.black,
                          ),
                        ),
                      ),
                      trailing: IconButton(
                        icon: Icon(Icons.add, color: AbubaPallate.greenabuba),
                        onPressed: () {
                          setState(() {
                            if (agenda.contains(controllerAgendaBantu.text)) {

                            } else {
                              agenda.add(controllerAgendaBantu.text);
                            }
                            controllerAgendaBantu.clear();
                          });
                        },
                      ),
                    ),
                    Container(
                      alignment: Alignment.centerLeft,
                      padding: EdgeInsets.only(left: 30.0, right: 10.0, top: agenda.length == 0 ? 0.0 : 10.0, bottom: agenda.length == 0 ? 0.0 : 20.0),
                      child: Wrap(
                        spacing: 8.0,
                        runSpacing: 4.0,
                        runAlignment: WrapAlignment.start,
                        direction: Axis.horizontal,
                        children: agenda.length == 0
                          ? [Container()]
                          : agenda.map((String name) => Chip(
                              label: Text(name),
                              onDeleted: () {
                                setState(() {
                                  agenda.remove(name);
                                });
                              },
                            )).toList(),
                      ),
                    ),
                    ListTile(
                      title: Padding(
                        padding: const EdgeInsets.only(left: 10.0),
                        child: StreamBuilder(
                          stream: Firestore.instance.collection('locationMeeting').orderBy('location', descending: false).snapshots(),
                          builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                            if (!snapshot.hasData)
                              return Container(
                                child: Center(
                                  child: CircularProgressIndicator(),
                                ),
                              );

                            return DropdownButtonFormField<String>(
                              decoration: InputDecoration(
                                labelText: 'Location',
                                labelStyle: TextStyle(fontSize: 12.0),
                              ),
                              validator: (value) {
                                if (value == null) {
                                  return 'Please select location';
                                } else {
                                  return null;
                                }
                              },
                              value: mySelection,
                              onChanged: (String value) {
                                setState(() {
                                  mySelection = value;
                                  });
                              },
                              items: snapshot.data.documents.map((DocumentSnapshot document) {
                                return DropdownMenuItem(
                                  value: document['id'].toString(),
                                  child: Padding(
                                    padding: EdgeInsets.all(10.0),
                                    child: RichText(
                                      overflow: TextOverflow.visible,
                                      text: TextSpan(
                                        text: document['location'].toString(),
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 12.0
                                        )
                                      ),
                                    ),
                                  ),
                                );
                              }).toList()
                            );
                          },
                        )
                      ),
                      trailing: Container(
                        width: 30.0
                      )
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        Padding(
                          padding:
                              const EdgeInsets.only(top: 10.0, right: 20.0),
                          child: ButtonTheme(
                            minWidth: 50.0,
                            height: 30.0,
                            child: OutlineButton(
                              child: Text(
                                'NEXT',
                                style: TextStyle(
                                    fontSize: 13.0, color: Colors.blue),
                              ),
                              borderSide:
                                  BorderSide(color: Colors.blue, width: 1.0),
                              highlightedBorderColor: Colors.blue,
                              onPressed: () {
                                _tabController
                                    .animateTo((_tabController.index + 1));
                              },
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
                ListView(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(top: 10.0, bottom: 5.0),
                      child: SearchWidget<LeaderBoard>(
                        dataList: listPIC,
                        hideSearchBoxWhenItemSelected: false,
                        listContainerHeight: MediaQuery.of(context).size.height / 4,
                        queryBuilder: (String query, List<LeaderBoard> list) {
                          return list.where((LeaderBoard item) => item.name.toLowerCase().contains(query.toLowerCase())).toList();
                        },
                        popupListItemBuilder: (LeaderBoard item) {
                          return Container(
                            padding: const EdgeInsets.all(12.0),
                            child: Text(
                              item.name,
                              style: TextStyle(fontSize: 16.0),
                            ),
                          );
                        },
                        selectedItemBuilder: (LeaderBoard selectedItem, VoidCallback deleteSelectedItem) {
                          var bantu = selectedItem.name.split(' - ');
                          if (whoID.contains(int.tryParse(selectedItem.id.toString()))) {

                          } else {
                            whoID.add(int.tryParse(selectedItem.id.toString()));
                          }
                          if (whoName.contains(bantu[1])) {

                          } else {
                            whoName.add(bantu[1]);
                          }
                          deleteSelectedItem();
                        },
                        // widget customization
                        noItemsFoundWidget: Container(
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              Icon(
                                Icons.folder_open,
                                size: 24,
                                color: Colors.grey[900].withOpacity(0.7),
                              ),
                              SizedBox(width: 10.0),
                              Text(
                                "No Items Found",
                                style: TextStyle(
                                  fontSize: 16.0,
                                  color: Colors.grey[900].withOpacity(0.7),
                                ),
                              ),
                            ],
                          ),
                        ),
                        textFieldBuilder: (TextEditingController controllerCategory, FocusNode focusNodeCategory) {
                          return Padding(
                            padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                            child: TextField(
                              controller: controllerCategory,
                              focusNode: focusNodeCategory,
                              style: new TextStyle(fontSize: 16, color: Colors.grey[600]),
                              decoration: InputDecoration(
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Color(0x4437474F)),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Theme.of(context).primaryColor),
                                ),
                                border: InputBorder.none,
                                hintText: "Participant",
                                hintStyle: TextStyle(
                                  fontSize: 14.0
                                ),
                                contentPadding: EdgeInsets.only(
                                  left: 16,
                                  right: 20,
                                  top: 14,
                                  bottom: 14,
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    // Padding(
                    //   padding: EdgeInsets.only(top: 10.0, bottom: 10.0, left: 15.0, right: 10.0, ),
                    //   child: StreamBuilder(
                    //     stream: Firestore.instance.collection('user').orderBy('nama', descending: false).snapshots(),
                    //     builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                    //       if (!snapshot.hasData)
                    //         return Container(
                    //           child: Center(
                    //             child: CircularProgressIndicator(),
                    //           ),
                    //         );

                    //       return DropdownButtonFormField<String>(
                    //         decoration: InputDecoration(
                    //           labelText: 'Who',
                    //           labelStyle: TextStyle(fontSize: 12.0),
                    //         ),
                    //         validator: (value) {
                    //           if (value == null) {
                    //             return 'Please select person';
                    //           } else {
                    //             return null;
                    //           }
                    //         },
                    //         value: whoSelection,
                    //         onChanged: (String value) {
                    //           Firestore.instance.collection('user').where('id', isEqualTo: int.tryParse(value)).snapshots().listen((data) {
                    //             setState(() {
                    //               // whoSelection2 = data.documents[0].data['nama'];
                    //               // whoSelection = value;

                    //               if (whoID.contains(int.tryParse(value))) {

                    //               } else {
                    //                 whoID.add(int.tryParse(value));
                    //               }
                    //               if (whoName.contains(data.documents[0].data['nama'])) {

                    //               } else {
                    //                 whoName.add(data.documents[0].data['nama']);
                    //               }
                    //             });
                    //           });
                    //         },
                    //         items: snapshot.data.documents.map((DocumentSnapshot document) {
                    //           return DropdownMenuItem(
                    //             value: document['id'].toString(),
                    //             child: Padding(
                    //               padding: EdgeInsets.all(10.0),
                    //               child: RichText(
                    //                 overflow: TextOverflow.visible,
                    //                 text: TextSpan(
                    //                   text: document['nama'].toString(),
                    //                   style: TextStyle(
                    //                     color: Colors.black,
                    //                     fontSize: 12.0
                    //                   )
                    //                 ),
                    //               ),
                    //             ),
                    //           );
                    //         }).toList()
                    //       );
                    //     },
                    //   )
                    // ),
                    Container(
                      alignment: Alignment.centerLeft,
                      padding: EdgeInsets.only(left: 15.0, right: 10.0, top: whoName.length == 0 ? 0.0 : 10.0, bottom: whoName.length == 0 ? 0.0 : 20.0),
                      child: Wrap(
                        spacing: 8.0,
                        runSpacing: 4.0,
                        runAlignment: WrapAlignment.start,
                        direction: Axis.horizontal,
                        children: whoName.length == 0
                          ? [Container()]
                          : whoName.map((String name) => Chip(
                              label: Text(name),
                              deleteIcon: whoID[whoName.indexWhere((result) => result.startsWith(name))] == widget.idUser ? Icon(Icons.close, color: Colors.transparent,) : null,
                              onDeleted: () {
                                if (whoID[whoName.indexWhere((result) => result.startsWith(name))] == widget.idUser) {

                                } else {
                                  setState(() {
                                    whoID.removeAt(whoName.indexOf(name));
                                    whoName.remove(name);
                                  });
                                  print(whoID);
                                  print(whoName);
                                }
                              },
                            )).toList(),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(top: 10.0, left: 20.0),
                          child: ButtonTheme(
                            minWidth: 50.0,
                            height: 30.0,
                            child: OutlineButton(
                              child: Text(
                                'PREV',
                                style: TextStyle(
                                    fontSize: 13.0, color: Colors.grey),
                              ),
                              borderSide:
                                  BorderSide(color: Colors.grey, width: 1.0),
                              highlightedBorderColor: Colors.grey,
                              onPressed: () {
                                _tabController
                                    .animateTo((_tabController.index - 1));
                              },
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 10.0, right: 20.0),
                          child: _isProccess
                            ? Container(
                                child: Center(
                                  child: CircularProgressIndicator(),
                                ),
                              )
                            : ButtonTheme(
                                minWidth: 50.0,
                                height: 30.0,
                                child: OutlineButton(
                                  child: Text(
                                    'INVITE',
                                    style: TextStyle(
                                      fontSize: 13.0,
                                      color: AbubaPallate.greenabuba
                                    ),
                                  ),
                                  borderSide: BorderSide(color: AbubaPallate.greenabuba, width: 1.0),
                                  highlightedBorderColor: AbubaPallate.greenabuba,
                                  onPressed: () {
                                    if (alertDateMeeting || dateStart == null) {
                                      showDialog(
                                        barrierDismissible: false,
                                        context: context,
                                        builder: (context) => Dialog(
                                          child: Container(
                                            height: 180.0,
                                            child: Column(
                                              children: <Widget>[
                                                Container(
                                                  color: Colors.orangeAccent,
                                                  height: 50.0,
                                                  child: Center(
                                                    child: Text(
                                                      'ALERT!',
                                                      style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 17.0,
                                                        fontWeight: FontWeight.w700
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 20.0,
                                                ),
                                                Container(
                                                  padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
                                                  child: Text(
                                                    'Date meeting is empty',
                                                    style: TextStyle(
                                                      fontSize: 16.0,
                                                    ),
                                                  ),
                                                ),
                                                Row(
                                                  mainAxisAlignment: MainAxisAlignment.end,
                                                  children: <Widget>[
                                                    FlatButton(
                                                      child: Text('OK'),
                                                      onPressed: () {
                                                        Navigator.pop(context);
                                                      },
                                                    )
                                                  ],
                                                )
                                              ],
                                            ),
                                          ),
                                        )
                                      );
                                    } else {
                                      setState(() {
                                        _isProccess = true;
                                      });

                                      DocumentReference docReference = Firestore.instance.collection('minutesMeeting').document();

                                      List<DateTime> checkIn = [];
                                      List<DateTime> checkout = [];

                                      for(int i = 0; i < whoID.length; i++) {
                                        checkIn.add(null);
                                        checkout.add(null);
                                      }

                                      docReference.setData({
                                        'userCreated': widget.idUser,
                                        'dateCreated': DateTime.now(),
                                        'dateMeeting':dateStart,
                                        'namaMeeting':controllerAgenda.text,
                                        'agenda': agenda,
                                        'location': int.tryParse(mySelection),
                                        'pesertaID':whoID,
                                        'pesertaName': whoName,
                                        'status': 'OPEN',
                                        'meetingNo':maxidMeeting,
                                        'pesertaHadir': [],
                                        'checkInPeserta': checkIn,
                                        'checkOutPeserta': checkout,
                                        'meetingStart': null,
                                        'meetingEnd': null
                                      }).then((doc) {
                                        setState(() {
                                          _isProccess = false;
                                        });

                                        DocumentReference documentReference =Firestore.instance.collection('dumper_minutesMeeting').document(indexMeeting);

                                        documentReference.updateData({
                                          'maxid_minutesMeeting':maxidMeeting
                                        }).then((doc2) {
                                          print('success');
                                        }).catchError((error2) {
                                          print(error2);
                                        });

                                        showDialog(
                                          barrierDismissible: false,
                                          context: context,
                                          builder: (context) => Dialog(
                                            child: Container(
                                              height: 180.0,
                                              child: Column(
                                                children: <Widget>[
                                                  Container(
                                                    color: AbubaPallate.greenabuba,
                                                    height: 50.0,
                                                    child: Center(
                                                      child: Text(
                                                        'SUCCESSFUL!',
                                                        style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 17.0,
                                                          fontWeight: FontWeight.w700),
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 20.0,
                                                  ),
                                                  Container(
                                                    padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
                                                    child: Text(
                                                      'Meeting No. MMT-${maxidMeeting.toString().padLeft(4, '0')}',
                                                      style: TextStyle(
                                                        fontSize: 16.0,
                                                      ),
                                                    ),
                                                  ),
                                                  Row(
                                                    mainAxisAlignment: MainAxisAlignment.end,
                                                    children: <Widget>[
                                                      FlatButton(
                                                        child: Text('OK'),
                                                        onPressed: () {
                                                          Navigator.pop(context);
                                                        },
                                                      )
                                                    ],
                                                  )
                                                ],
                                              ),
                                            ),
                                          )
                                        ).whenComplete(() {
                                          Navigator.pop(context);
                                        });
                                      }).catchError((error) {
                                        print(error);
                                      });
                                    }
                                  },
                                ),
                              ),
                        ),
                      ],
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
