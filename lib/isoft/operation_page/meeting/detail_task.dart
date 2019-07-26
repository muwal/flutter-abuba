import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_abuba/constant.dart';

class DetailTask extends StatefulWidget {
  DetailTask({this.idUser, this.namaUser, this.departmentUser, this.index, this.pic, this.createdNotulen, this.noteActionPlan});

  final int idUser;
  final String namaUser;
  final String departmentUser;
  var index;
  final List<dynamic> pic;
  final List<dynamic> createdNotulen;
  List<dynamic> noteActionPlan;

  @override
  _DetailTaskState createState() => _DetailTaskState();
}

class _DetailTaskState extends State<DetailTask> with TickerProviderStateMixin {
  AnimationController animationController;

  String namaKoordinator;
  Timestamp tanggal;
  int no;

  List<String> namaPIC = [];
  List<dynamic> issue = [];
  List<dynamic> actionPlan = [];
  List<dynamic> dueDate = [];
  List<String> namaCreatedNotulen = [];
  List<dynamic> useActionPlan = [];
  List<dynamic> statusActionPlan = [];
  List<dynamic> dateDoneActionPlan = [];
  List<bool> showNoteActionPlan = [];
  var noteActionPlanSave;
  var textt = <TextEditingController>[];

  TextEditingController controllerNote = TextEditingController();

  @override
  void initState() {
    super.initState();
    
    Firestore.instance.collection('minutesMeeting').document(widget.index).snapshots().listen((data) {
      setState(() {
        no = data.data['meetingNo'];
        tanggal = data.data['meetingStart'];

        issue = data.data['issueNotulen'];
        actionPlan = data.data['actionPlanNotulen'];
        dueDate = data.data['dueDateNotulen'];
        useActionPlan = data.data['useActionPlan'];
        statusActionPlan = data.data['statusActionPlan'];
        dateDoneActionPlan = data.data['dateDoneActionPlan'];

        Firestore.instance.collection('user').where('id', isEqualTo: data.data['userCreated']).snapshots().listen((data2) {
          namaKoordinator = data2.documents[0].data['nama'];
        });
      });
    });

    noteActionPlanSave = List<dynamic>.from(widget.noteActionPlan);

    for (int i = 0; i < widget.pic.length; i++) {
      Firestore.instance.collection('user').where('id', isEqualTo: widget.pic[i]).snapshots().listen((data6) {
        namaPIC.add(data6.documents[0].data['nama']);
      });
    }

    for (int i = 0; i < widget.createdNotulen.length; i++) {
      Firestore.instance.collection('user').where('id', isEqualTo: widget.createdNotulen[i]).snapshots().listen((data7) {
        namaCreatedNotulen.add(data7.documents[0].data['nama']);
      });
    }

    for (int q = 0; q < widget.noteActionPlan.length; q++) {
      showNoteActionPlan.add(false);
      textt.add(TextEditingController());
    }

    animationController = AnimationController(vsync: this, duration: Duration(seconds: 3));
    animationController.reverse(
      from: animationController.value == 0.0
        ? 1.0
        : animationController.value
    );
  }

  @override
  Widget build(BuildContext context) {
    final double size = MediaQuery.of(context).size.width;

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
          child: _bodyForm(size),
        ),
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
                  'Minutes Meeting',
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
                    'Detail Task',
                    style: TextStyle(
                        color: AbubaPallate.greenabuba, fontSize: 12.0),
                  ),
                ),
              ],
            ),
          ),
          AnimatedBuilder(
            animation: animationController,
            builder: (_, Widget child) {
              return animationController.isAnimating
                ? Container(
                    child: Center(
                      child:CircularProgressIndicator()
                    ),
                  )
                : Container(
                    color: Colors.white,
                    child: Column(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(left: 12.0, right: 12.0, top: 12.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Container(
                                width: 150.0,
                                child: Row(
                                  children: <Widget>[
                                    Flexible(
                                      child: Text(
                                        namaKoordinator,
                                        style: TextStyle(
                                            fontSize: 12.0, color: Colors.black54),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                width: 150.0,
                                child: Row(
                                  children: <Widget>[
                                    Flexible(
                                      child: Text(
                                        '#MMT-${no.toString().padLeft(4, '0')}',
                                        style: TextStyle(
                                            fontSize: 12.0, color: Colors.black54),
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 12.0, right: 12.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Container(
                                width: 150.0,
                                child: Row(
                                  children: <Widget>[
                                    Flexible(
                                      child: Text(
                                        'Koordinator Meeting',
                                        style: TextStyle(
                                            fontSize: 10.0, color: Colors.black38),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              Container(
                                width: 150.0,
                                child: Row(
                                  children: <Widget>[
                                    Flexible(
                                      child: Text(
                                        tanggal.toDate().toString().substring(8, 10) + '/' + tanggal.toDate().toString().substring(5, 7) + '/' + tanggal.toDate().toString().substring(0, 4) + '  -' + tanggal.toDate().toString().substring(10, 16),
                                        style: TextStyle(
                                            fontSize: 10.0,
                                            color: Colors.black38,
                                            fontWeight: FontWeight.w700),
                                      ),
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 12.0),
                          child: Divider(
                            height: 6.0,
                          ),
                        ),
                        Column(
                          children: List.generate(issue.length, (index) {
                            Timestamp coba = dueDate[index];
                            if (statusActionPlan[index] == null || statusActionPlan[index] != 'OPEN') {
                              return Container();
                            } else {
                              if (widget.pic[index] == widget.idUser) {
                                return Column(
                                  children: <Widget>[
                                    Padding(
                                      padding: const EdgeInsets.only(left: 12.0, right: 12.0),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Container(
                                            width: size * 0.25,
                                            child: Row(
                                              children: <Widget>[
                                                Flexible(
                                                  child: Text(
                                                    namaCreatedNotulen[index],
                                                    style: TextStyle(
                                                        fontSize: 14.0, color: Colors.black87, fontWeight: FontWeight.w500),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Container(
                                            width: size * 0.25,
                                            child: Row(
                                              children: <Widget>[
                                                Flexible(
                                                  child: Text(
                                                    useActionPlan[index] == false ? '-' : namaPIC[index],
                                                    style: TextStyle(
                                                        fontSize: 14.0, color: Colors.black87, fontWeight: FontWeight.w500),
                                                    textAlign: TextAlign.center,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Container(
                                            width: size * 0.25,
                                            child: Row(
                                              children: <Widget>[
                                                Flexible(
                                                  child: Text(
                                                    useActionPlan[index] == false ? '-' : coba.toDate().toString().substring(8, 10) + '/' + coba.toDate().toString().substring(5, 7) + '/' + coba.toDate().toString().substring(0, 4),
                                                    style: TextStyle(
                                                        fontSize: 14.0, color: Colors.black87, fontWeight: FontWeight.w500),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 12.0, right: 12.0),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Container(
                                            width: size * 0.25,
                                            child: Row(
                                              children: <Widget>[
                                                Flexible(
                                                  child: Text(
                                                    'Dibuat oleh',
                                                    style: TextStyle(
                                                        fontSize: 12.0,
                                                        color: Colors.black38,
                                                        fontWeight: FontWeight.w700),
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                          Container(
                                            width: size * 0.25,
                                            child: Row(
                                              children: <Widget>[
                                                Flexible(
                                                  child: Text(
                                                    'Pelaksana',
                                                    style: TextStyle(
                                                      fontSize: 12.0,
                                                      color: Colors.black38,
                                                      fontWeight: FontWeight.w700
                                                    ),
                                                    textAlign: TextAlign.center,
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                          Container(
                                            width: size * 0.25,
                                            child: Row(
                                              children: <Widget>[
                                                Flexible(
                                                  child: Text(
                                                    'Pelaksanaan',
                                                    style: TextStyle(
                                                        fontSize: 12.0,
                                                        color: Colors.black38,
                                                        fontWeight: FontWeight.w700),
                                                  ),
                                                )
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      height: 15.0,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 12.0, right: 12.0, bottom: 5.0),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Flexible(
                                            child: RichText(
                                              overflow: TextOverflow.visible,
                                              softWrap: true,
                                              text: TextSpan(
                                                text: 'Issue / Note',
                                                style: TextStyle(
                                                  fontSize: 14.0,
                                                  color: Colors.black54,
                                                  fontWeight: FontWeight.w700
                                                ),
                                              ),
                                            )
                                          ),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 12.0, right: 12.0, bottom: 5.0),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Flexible(
                                            child: RichText(
                                              overflow: TextOverflow.visible,
                                              softWrap: true,
                                              text: TextSpan(
                                                text: issue[index],
                                                style: TextStyle(
                                                  fontSize: 12.0,
                                                  color: Colors.black54,
                                                ),
                                              ),
                                            )
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      height: 15.0,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 12.0, right: 12.0, bottom: 5.0),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Flexible(
                                            child: RichText(
                                              overflow: TextOverflow.visible,
                                              softWrap: true,
                                              text: TextSpan(
                                                text: 'Action Plan',
                                                style: TextStyle(
                                                  fontSize: 14.0,
                                                  color: Colors.black54,
                                                  fontWeight: FontWeight.w700
                                                ),
                                              ),
                                            )
                                          ),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 12.0, right: 12.0, bottom: 5.0),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Flexible(
                                            child: RichText(
                                              overflow: TextOverflow.visible,
                                              softWrap: true,
                                              text: TextSpan(
                                                text: useActionPlan[index] == false ? '-' : actionPlan[index],
                                                style: TextStyle(
                                                  fontSize: 12.0,
                                                  color: Colors.black54,
                                                ),
                                              ),
                                            )
                                          ),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 15.0, right: 15.0, bottom: 15.0),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.end,
                                        children: <Widget>[
                                          Container(
                                            padding: EdgeInsets.only(right: 15.0),
                                            alignment: Alignment.centerRight,
                                            child: SizedBox(
                                              height: 35.0,
                                              width: 95.0,
                                              child: OutlineButton(
                                                borderSide: BorderSide(color: AbubaPallate.menuBluebird, width: 1.0),
                                                highlightedBorderColor: AbubaPallate.menuBluebird,
                                                onPressed: () {
                                                  setState(() {
                                                    showNoteActionPlan[index] = !showNoteActionPlan[index];
                                                  });
                                                },
                                                child: Text(
                                                  'NOTE',
                                                  style: TextStyle(color: AbubaPallate.menuBluebird),
                                                ),
                                              ),
                                            )
                                          ),
                                          statusActionPlan[index] == null
                                            ? Container()
                                            : statusActionPlan[index] == 'OPEN'
                                                ? Container(
                                                    alignment: Alignment.centerRight,
                                                    child: RaisedButton(
                                                      padding: const EdgeInsets.all(8.0),
                                                      textColor: Colors.white,
                                                      color: Colors.green,
                                                      onPressed: () {
                                                        setState(() {
                                                          if (statusActionPlan[index] == 'OPEN') {
                                                            statusActionPlan[index] = 'DONE';
                                                            dateDoneActionPlan[index] = DateTime.now();
                                                            noteActionPlanSave.removeAt(index);
                                                            noteActionPlanSave.insert(index, textt[index].text);
                                                            
                                                            DocumentReference docReference = Firestore.instance.collection('minutesMeeting').document(widget.index);

                                                            docReference.updateData({
                                                              'statusActionPlan': statusActionPlan,
                                                              'dateDoneActionPlan': dateDoneActionPlan,
                                                              'noteActionPlan': noteActionPlanSave
                                                            }).then((doc) {
                                                              print('success');
                                                            }).catchError((error) {
                                                              print(error);
                                                            });
                                                          } else {

                                                          }
                                                        });
                                                      },
                                                      child: new Text("DONE"),
                                                    ),
                                                  )
                                                : Container()
                                        ],
                                      ),
                                    ),
                                    showNoteActionPlan[index]
                                      ? Padding(
                                          padding: EdgeInsets.only(left: 15.0, right: 15.0, bottom: 10.0),
                                          child: TextField(
                                            maxLines: 3,
                                            keyboardType: TextInputType.text,
                                            decoration: InputDecoration(
                                              labelText: 'Note',
                                              labelStyle: TextStyle(fontSize: 12.0),
                                              border: OutlineInputBorder()
                                            ),
                                            maxLength: 250,
                                            controller: textt[index],
                                            textCapitalization: TextCapitalization.sentences,
                                            style: TextStyle(
                                              color: Colors.black,
                                            ),
                                          ),
                                        )
                                      : Container(),
                                    SizedBox(
                                      height: 7.0,
                                    )
                                  ],
                                );
                              } else {
                                return Container();
                              }
                            }
                          }).toList()
                        )
                      ],
                    ),
                  );
            },
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
