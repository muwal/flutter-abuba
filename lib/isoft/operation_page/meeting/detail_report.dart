import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_abuba/constant.dart';

class DetailReport extends StatefulWidget {
  DetailReport({this.idUser, this.namaUser, this.departmentUser, this.index, this.pesertaHadir, this.pesertaMeeting, this.pic, this.createdNotulen, this.noteActionPlan});

  final int idUser;
  final String namaUser;
  final String departmentUser;
  var index;
  final List<dynamic> pic;
  final List<dynamic> createdNotulen;
  final List<dynamic> noteActionPlan;
  final List<dynamic> pesertaHadir;
  final List<dynamic> pesertaMeeting;

  @override
  _DetailReportState createState() => _DetailReportState();
}

class _DetailReportState extends State<DetailReport> with TickerProviderStateMixin {
  AnimationController animationController;

  String namaKoordinator;
  Timestamp tanggal;
  int no;
  String status;

  String namaMeeting;
  List<dynamic> agenda = [];
  String lokasi;
  Timestamp meetingStart;
  Timestamp meetingEnd;
  Timestamp dateMeeting;

  List<String> namaPesertaHadir = [];
  List<String> pesertaTidakHadir = [];
  int jumlahUndangan = 0;

  List<String> namaPIC = [];
  List<dynamic> issue = [];
  List<dynamic> actionPlan = [];
  List<dynamic> dueDate = [];
  List<String> namaCreatedNotulen = [];
  List<dynamic> useActionPlan = [];
  List<dynamic> statusActionPlan = [];
  List<dynamic> dateDoneActionPlan = [];
  List<bool> showNoteActionPlan = [];
  List<dynamic> checkIn = [];
  List<dynamic> checkOut = [];

  Timestamp start;

  double stickToTheAgenda;
  double manageTime;
  double followGroundRules;
  double balanceOfParticipants;
  double listenToEachOthers;
  double makingProgress;

  String bantuRating = '';

  @override
  void initState() {
    super.initState();
    
    Firestore.instance.collection('minutesMeeting').document(widget.index).snapshots().listen((data) {
      setState(() {
        no = data.data['meetingNo'];
        tanggal = data.data['meetingStart'];
        
        namaMeeting = data.data['namaMeeting'];
        meetingStart = data.data['meetingStart'];
        meetingEnd = data.data['meetingEnd'];
        dateMeeting = data.data['dateMeeting'];

        if (data.data.containsKey('stickToTheAgenda')) {
          stickToTheAgenda = data.data['stickToTheAgenda'];
          manageTime = data.data['manageTime'];
          followGroundRules = data.data['followGroundRules'];
          balanceOfParticipants = data.data['balanceOfParticipants'];
          listenToEachOthers = data.data['listenToEachOthers'];
          makingProgress = data.data['makingProgress'];
          bantuRating = 'YES';
        } else {
          stickToTheAgenda = 0;
          manageTime = 0;
          followGroundRules = 0;
          balanceOfParticipants = 0;
          listenToEachOthers = 0;
          makingProgress = 0;
          bantuRating = 'NO';
        }

        start = data.data['dateMeeting'];

        issue = data.data['issueNotulen'];
        actionPlan = data.data['actionPlanNotulen'];
        dueDate = data.data['dueDateNotulen'];
        useActionPlan = data.data['useActionPlan'];
        statusActionPlan = data.data['statusActionPlan'];
        dateDoneActionPlan = data.data['dateDoneActionPlan'];
        checkIn = data.data['checkInPeserta'];
        checkOut = data.data['checkOutPeserta'];
        status = data.data['status'];
        agenda = data.data['agenda'];

        jumlahUndangan = data.data['pesertaID'].length;

        Firestore.instance.collection('user').where('id', isEqualTo: data.data['userCreated']).snapshots().listen((data2) {
          namaKoordinator = data2.documents[0].data['nama'];
        });

        Firestore.instance.collection('locationMeeting').where('id', isEqualTo: data.data['lokasi']).snapshots().listen((data5) {
          lokasi = data5.documents[0].data['location'];
        });
      });
    });

    for (int i = 0; i < widget.pesertaHadir.length; i++) {
      Firestore.instance.collection('user').where('id', isEqualTo: widget.pesertaHadir[i]).snapshots().listen((data3) {
        namaPesertaHadir.add(data3.documents[0].data['nama']);
      });
    }

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

    for (int a = 0; a < widget.pesertaMeeting.length; a++) {
      if (widget.pesertaHadir.contains(widget.pesertaMeeting[a])) {
        
      } else {
        Firestore.instance.collection('user').where('id', isEqualTo: widget.pesertaMeeting[a]).snapshots().listen((data4) {
          pesertaTidakHadir.add(data4.documents[0].data['nama']);
        });
      }
    }

    for (int q = 0; q < widget.noteActionPlan.length; q++) {
      showNoteActionPlan.add(false);
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
                        Container(
                          color: Colors.grey[200],
                          height: 50.0,
                          child: Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Flexible(
                                  child: Padding(
                                    padding: const EdgeInsets.all(12.0),
                                    child: Text(
                                      '# MMT-${no.toString().padLeft(4, '0')}',
                                      style: TextStyle(
                                          fontSize: 16.0,
                                          color: Colors.black38,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(right: 12.0),
                                  child: ButtonTheme(
                                    minWidth: 50.0,
                                    height: 30.0,
                                    splashColor: statusActionPlan.contains('OPEN') ? Colors.orangeAccent : AbubaPallate.greenabuba,
                                    child: FlatButton(
                                      color: statusActionPlan.contains('OPEN') ? Colors.orangeAccent : AbubaPallate.greenabuba,
                                      textColor: Colors.white,
                                      onPressed: () {},
                                      child: Text(
                                        statusActionPlan.contains('OPEN') ? 'ONGOING' : 'CLOSED'
                                      ),
                                    )
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 12.0, right: 12.0, bottom: 10.0, top: 20.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                width: MediaQuery.of(context).size.width * 0.35,
                                child: Row(
                                  children: <Widget>[
                                    Flexible(
                                      child: Text(
                                        'Data Umum',
                                        style: TextStyle(
                                          fontSize: 15.0, color: Colors.black87, fontWeight: FontWeight.bold
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 20.0, right: 20.0, bottom: 5.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Container(
                                width: MediaQuery.of(context).size.width * 0.35,
                                child: Row(
                                  children: <Widget>[
                                    Flexible(
                                      child: Text(
                                        'Tanggal',
                                        style: TextStyle(
                                          fontSize: 14.0, color: Colors.black87, fontWeight: FontWeight.w500
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width * 0.35,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: <Widget>[
                                    Flexible(
                                      child: Text(
                                        dateMeeting.toDate().toString().substring(8, 10) + '/' + dateMeeting.toDate().toString().substring(5, 7) + '/' + dateMeeting.toDate().toString().substring(0, 4),
                                        style: TextStyle(
                                          fontSize: 13.0,
                                          color: Colors.black38,
                                          fontWeight: FontWeight.w700
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 20.0, right: 20.0, bottom: 5.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Container(
                                width: MediaQuery.of(context).size.width * 0.35,
                                child: Row(
                                  children: <Widget>[
                                    Flexible(
                                      child: Text(
                                        'Jam',
                                        style: TextStyle(
                                          fontSize: 14.0, color: Colors.black87, fontWeight: FontWeight.w500
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width * 0.35,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: <Widget>[
                                    Flexible(
                                      child: Text(
                                        dateMeeting.toDate().toString().substring(10, 16).toString(),
                                        style: TextStyle(
                                          fontSize: 13.0,
                                          color: Colors.black38,
                                          fontWeight: FontWeight.w700
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 20.0, right: 20.0, bottom: 5.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Container(
                                width: MediaQuery.of(context).size.width * 0.35,
                                child: Row(
                                  children: <Widget>[
                                    Flexible(
                                      child: Text(
                                        'Lokasi',
                                        style: TextStyle(
                                          fontSize: 14.0, color: Colors.black87, fontWeight: FontWeight.w500
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width * 0.35,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: <Widget>[
                                    Flexible(
                                      child: Text(
                                        lokasi,
                                        style: TextStyle(
                                          fontSize: 13.0,
                                          color: Colors.black38,
                                          fontWeight: FontWeight.w700
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 20.0, right: 20.0, bottom: 5.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Container(
                                width: MediaQuery.of(context).size.width * 0.35,
                                child: Row(
                                  children: <Widget>[
                                    Flexible(
                                      child: Text(
                                        'Jumlah Undangan',
                                        style: TextStyle(
                                          fontSize: 14.0, color: Colors.black87, fontWeight: FontWeight.w500
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width * 0.35,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: <Widget>[
                                    Flexible(
                                      child: Text(
                                        '${jumlahUndangan.toString()} orang',
                                        style: TextStyle(
                                          fontSize: 13.0,
                                          color: Colors.black38,
                                          fontWeight: FontWeight.w700
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 10.0, right: 10.0, bottom: 10.0, top: 5.0),
                          child: Divider(
                            height: 5.0,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 12.0, right: 12.0, bottom: 10.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                width: MediaQuery.of(context).size.width * 0.35,
                                child: Row(
                                  children: <Widget>[
                                    Flexible(
                                      child: Text(
                                        'Rencana Meeting',
                                        style: TextStyle(
                                          fontSize: 15.0, color: Colors.black87, fontWeight: FontWeight.bold
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 20.0, right: 20.0, bottom: 5.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Container(
                                width: MediaQuery.of(context).size.width * 0.2,
                                child: Row(
                                  children: <Widget>[
                                    Flexible(
                                      child: Text(
                                        'Nama Meeting',
                                        style: TextStyle(
                                          fontSize: 14.0, color: Colors.black87, fontWeight: FontWeight.w500
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width * 0.5,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: <Widget>[
                                    Flexible(
                                      child: Text(
                                        namaMeeting,
                                        style: TextStyle(
                                          fontSize: 13.0,
                                          color: Colors.black38,
                                          fontWeight: FontWeight.w700
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 20.0, right: 20.0, bottom: 5.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Container(
                                width: MediaQuery.of(context).size.width * 0.2,
                                child: Row(
                                  children: <Widget>[
                                    Flexible(
                                      child: Text(
                                        'Agenda',
                                        style: TextStyle(
                                          fontSize: 14.0, color: Colors.black87, fontWeight: FontWeight.w500
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width * 0.5,
                                child: Column(
                                  children: List.generate(agenda.length, (index) {
                                    return Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: <Widget>[
                                        Flexible(
                                          child: Text(
                                            '${(index + 1).toString()}. ${agenda[index]}',
                                            style: TextStyle(
                                              fontSize: 13.0,
                                              color: Colors.black38,
                                              fontWeight: FontWeight.w700
                                            ),
                                          ),
                                        ),
                                      ],
                                    );
                                  }).toList()
                                )
                              )
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 10.0, right: 10.0, bottom: 10.0, top: 5.0),
                          child: Divider(
                            height: 5.0,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 12.0, right: 12.0, bottom: 10.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                width: MediaQuery.of(context).size.width * 0.35,
                                child: Row(
                                  children: <Widget>[
                                    Flexible(
                                      child: Text(
                                        'Realisasi Meeting',
                                        style: TextStyle(
                                          fontSize: 15.0, color: Colors.black87, fontWeight: FontWeight.bold
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 20.0, right: 20.0, bottom: 5.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Container(
                                width: MediaQuery.of(context).size.width * 0.2,
                                child: Row(
                                  children: <Widget>[
                                    Flexible(
                                      child: Text(
                                        'Tgl Realisasi',
                                        style: TextStyle(
                                          fontSize: 14.0, color: Colors.black87, fontWeight: FontWeight.w500
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width * 0.5,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: <Widget>[
                                    Flexible(
                                      child: Text(
                                        tanggal.toDate().toString().substring(8, 10) + '/' + tanggal.toDate().toString().substring(5, 7) + '/' + tanggal.toDate().toString().substring(0, 4),
                                        style: TextStyle(
                                          fontSize: 13.0,
                                          color: Colors.black38,
                                          fontWeight: FontWeight.w700
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 20.0, right: 20.0, bottom: 5.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Container(
                                width: MediaQuery.of(context).size.width * 0.2,
                                child: Row(
                                  children: <Widget>[
                                    Flexible(
                                      child: Text(
                                        'Jam Mulai',
                                        style: TextStyle(
                                          fontSize: 14.0, color: Colors.black87, fontWeight: FontWeight.w500
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width * 0.5,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: <Widget>[
                                    Flexible(
                                      child: Text(
                                        meetingStart.toDate().toString().substring(10, 16),
                                        style: TextStyle(
                                          fontSize: 13.0,
                                          color: Colors.black38,
                                          fontWeight: FontWeight.w700
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 20.0, right: 20.0, bottom: 5.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Container(
                                width: MediaQuery.of(context).size.width * 0.2,
                                child: Row(
                                  children: <Widget>[
                                    Flexible(
                                      child: Text(
                                        'Jam Selesai',
                                        style: TextStyle(
                                          fontSize: 14.0, color: Colors.black87, fontWeight: FontWeight.w500
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width * 0.5,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: <Widget>[
                                    Flexible(
                                      child: Text(
                                        meetingEnd.toDate().toString().substring(10, 16),
                                        style: TextStyle(
                                          fontSize: 13.0,
                                          color: Colors.black38,
                                          fontWeight: FontWeight.w700
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 10.0, right: 10.0, bottom: 10.0, top: 5.0),
                          child: Divider(
                            height: 5.0,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 12.0, right: 12.0, bottom: 10.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Container(
                                width: MediaQuery.of(context).size.width * 0.35,
                                child: Row(
                                  children: <Widget>[
                                    Flexible(
                                      child: Text(
                                        'Peserta Hadir',
                                        style: TextStyle(
                                          fontSize: 15.0, color: Colors.black87, fontWeight: FontWeight.bold
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.only(right: 5.0),
                                width: MediaQuery.of(context).size.width * 0.5,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: <Widget>[
                                    Flexible(
                                      child: Text(
                                        '${namaPesertaHadir.length} of ${namaPesertaHadir.length + pesertaTidakHadir.length} orang',
                                        style: TextStyle(
                                          fontSize: 13.0,
                                          color: Colors.black38,
                                          fontWeight: FontWeight.w700
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 20.0, right: 20.0, bottom: 5.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Container(
                                width: size * 0.25,
                                child: Row(
                                  children: <Widget>[
                                    Flexible(
                                      child: Text(
                                        'Nama',
                                        style: TextStyle(
                                          fontSize: 15.0, color: AbubaPallate.greenabuba, fontWeight: FontWeight.bold
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Container(
                                    width: size * 0.2,
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: <Widget>[
                                        Flexible(
                                          child: Text(
                                            'Masuk',
                                            style: TextStyle(
                                              fontSize: 15.0, color: AbubaPallate.greenabuba, fontWeight: FontWeight.bold
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    width: size * 0.2,
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: <Widget>[
                                        Flexible(
                                          child: Text(
                                            'Keluar',
                                            style: TextStyle(
                                              fontSize: 15.0, color: AbubaPallate.greenabuba, fontWeight: FontWeight.bold
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                        Column(
                          children: List.generate(namaPesertaHadir.length, (index) {
                            Timestamp checkInView = checkIn[index];
                            Timestamp checkOutView = checkOut[index];
                            return Padding(
                              padding: const EdgeInsets.only(left: 20.0, right: 20.0, bottom: 5.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Container(
                                    width: size * 0.25,
                                    child: Row(
                                      children: <Widget>[
                                        Flexible(
                                          child: Text(
                                            namaPesertaHadir[index],
                                            style: TextStyle(
                                              fontSize: 12.0,
                                              color: Colors.black38,
                                              fontWeight: FontWeight.w700
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Container(
                                        width: size * 0.2,
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.end,
                                          children: <Widget>[
                                            Flexible(
                                              child: Text(
                                                checkIn[index] == null ? '-' : checkInView.toDate().toString().substring(11, 16),
                                                // 'asd',
                                                style: TextStyle(
                                                  fontSize: 12.0,
                                                  color: checkIn[index] == null
                                                    ? Colors.black38
                                                    : DateTime.tryParse(checkIn[index].toDate().toString()).isAfter(DateTime.tryParse(start.toDate().toString())) == false ? Colors.black38 : Colors.redAccent,
                                                  fontWeight: FontWeight.w700),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        width: size * 0.2,
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.end,
                                          children: <Widget>[
                                            Flexible(
                                              child: Text(
                                                checkIn[index] == null
                                                  ? '-'
                                                  : checkOut[index] == null ? '-' : checkOutView.toDate().toString().substring(11, 16),
                                                style: TextStyle(
                                                  fontSize: 12.0,
                                                  color: Colors.black38,
                                                  fontWeight: FontWeight.w700),
                                              ),
                                            ),
                                          ],
                                        ),
                                      )
                                    ],
                                  )
                                ],
                              ),
                            );
                          }).toList()
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 10.0, right: 10.0, bottom: 10.0, top: 5.0),
                          child: Divider(
                            height: 5.0,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 12.0, right: 12.0, bottom: 10.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Container(
                                width: MediaQuery.of(context).size.width * 0.35,
                                child: Row(
                                  children: <Widget>[
                                    Flexible(
                                      child: Text(
                                        'Peserta Tidak Hadir',
                                        style: TextStyle(
                                          fontSize: 15.0, color: Colors.black87, fontWeight: FontWeight.bold
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                alignment: Alignment.bottomRight,
                                padding: EdgeInsets.only(right: 5.0),
                                width: MediaQuery.of(context).size.width * 0.5,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: <Widget>[
                                    Flexible(
                                      child: Text(
                                        '${pesertaTidakHadir.length} of ${namaPesertaHadir.length + pesertaTidakHadir.length} orang',
                                        style: TextStyle(
                                          fontSize: 13.0,
                                          color: Colors.black38,
                                          fontWeight: FontWeight.w700
                                        ),
                                        textAlign: TextAlign.end,
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                        pesertaTidakHadir.length == 0
                          ? Container()
                          : Padding(
                              padding: const EdgeInsets.only(left: 20.0, right: 20.0, bottom: 5.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  Container(
                                    width: size * 0.8,
                                    child: Row(
                                      children: <Widget>[
                                        Flexible(
                                          child: Text(
                                            'Nama',
                                            style: TextStyle(
                                              fontSize: 15.0, color: AbubaPallate.greenabuba, fontWeight: FontWeight.bold
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                        Column(
                          children: List.generate(pesertaTidakHadir.length, (index) {
                            return Padding(
                              padding: const EdgeInsets.only(left: 20.0, right: 10.0, bottom: 5.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  Container(
                                    width: size * 0.8,
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: <Widget>[
                                        Flexible(
                                          child: Text(
                                            pesertaTidakHadir[index],
                                            style: TextStyle(
                                              fontSize: 12.0,
                                              color: Colors.black38,
                                              fontWeight: FontWeight.w700
                                            ),
                                            textAlign: TextAlign.start,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }).toList()
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 10.0, right: 10.0, top: 5.0),
                          child: Divider(
                            height: 5.0,
                          ),
                        ),
                        ExpansionTile(
                          title: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                child: Row(
                                  children: <Widget>[
                                    Flexible(
                                      child: Text(
                                        'Minutes of Meeting',
                                        style: TextStyle(
                                          fontSize: 15.0, color: AbubaPallate.greenabuba, fontWeight: FontWeight.bold
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          children: List.generate(issue.length, (index) {
                            Timestamp dueDateView = dueDate[index];
                            return Column(
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.only(left: 20.0, right: 20.0, bottom: 5.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Container(
                                        width: MediaQuery.of(context).size.width * 0.2,
                                        child: Row(
                                          children: <Widget>[
                                            Flexible(
                                              child: Text(
                                                'Dibuat Oleh',
                                                style: TextStyle(
                                                  fontSize: 14.0, color: Colors.black87, fontWeight: FontWeight.w500
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        width: MediaQuery.of(context).size.width * 0.5,
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.end,
                                          children: <Widget>[
                                            Flexible(
                                              child: Text(
                                                namaCreatedNotulen[index],
                                                style: TextStyle(
                                                  fontSize: 13.0,
                                                  color: Colors.black38,
                                                  fontWeight: FontWeight.w700
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 20.0, right: 20.0, bottom: 5.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Container(
                                        width: MediaQuery.of(context).size.width * 0.2,
                                        child: Row(
                                          children: <Widget>[
                                            Flexible(
                                              child: Text(
                                                'Issue / Note',
                                                style: TextStyle(
                                                  fontSize: 14.0, color: Colors.black87, fontWeight: FontWeight.w500
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        width: MediaQuery.of(context).size.width * 0.5,
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.end,
                                          children: <Widget>[
                                            Flexible(
                                              child: Text(
                                                issue[index],
                                                style: TextStyle(
                                                  fontSize: 13.0,
                                                  color: Colors.black38,
                                                  fontWeight: FontWeight.w700
                                                ),
                                                textAlign: TextAlign.end,
                                              ),
                                            ),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 20.0, right: 20.0, bottom: 5.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Container(
                                        width: MediaQuery.of(context).size.width * 0.2,
                                        child: Row(
                                          children: <Widget>[
                                            Flexible(
                                              child: Text(
                                                'Action Plan',
                                                style: TextStyle(
                                                  fontSize: 14.0, color: Colors.black87, fontWeight: FontWeight.w500
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        width: MediaQuery.of(context).size.width * 0.5,
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.end,
                                          children: <Widget>[
                                            Flexible(
                                              child: Text(
                                                useActionPlan[index] == false ? '-' : actionPlan[index],
                                                style: TextStyle(
                                                  fontSize: 13.0,
                                                  color: Colors.black38,
                                                  fontWeight: FontWeight.w700
                                                ),
                                                textAlign: TextAlign.end,
                                              ),
                                            ),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 20.0, right: 20.0, bottom: 5.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Container(
                                        width: MediaQuery.of(context).size.width * 0.2,
                                        child: Row(
                                          children: <Widget>[
                                            Flexible(
                                              child: Text(
                                                'Pelaksana',
                                                style: TextStyle(
                                                  fontSize: 14.0, color: Colors.black87, fontWeight: FontWeight.w500
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        width: MediaQuery.of(context).size.width * 0.5,
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.end,
                                          children: <Widget>[
                                            Flexible(
                                              child: Text(
                                                useActionPlan[index] == false ? '-' : namaPIC[index],
                                                style: TextStyle(
                                                  fontSize: 13.0,
                                                  color: Colors.black38,
                                                  fontWeight: FontWeight.w700
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 20.0, right: 20.0, bottom: 5.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Container(
                                        width: MediaQuery.of(context).size.width * 0.3,
                                        child: Row(
                                          children: <Widget>[
                                            Flexible(
                                              child: Text(
                                                'Tgl Pelaksanaan',
                                                style: TextStyle(
                                                  fontSize: 14.0, color: Colors.black87, fontWeight: FontWeight.w500
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        width: MediaQuery.of(context).size.width * 0.5,
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.end,
                                          children: <Widget>[
                                            Flexible(
                                              child: Text(
                                                useActionPlan[index] == false ? '-' : dueDateView.toDate().toString().substring(8, 10) + '/' + dueDateView.toDate().toString().substring(5, 7) + '/' + dueDateView.toDate().toString().substring(0, 4),
                                                style: TextStyle(
                                                  fontSize: 13.0,
                                                  color: Colors.black38,
                                                  fontWeight: FontWeight.w700
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                statusActionPlan[index] == null
                                  ? Container()
                                  : Padding(
                                      padding: const EdgeInsets.only(left: 20.0, right: 20.0, bottom: 5.0),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Container(
                                            width: MediaQuery.of(context).size.width * 0.2,
                                            child: Row(
                                              children: <Widget>[
                                                Flexible(
                                                  child: Text(
                                                    'Status',
                                                    style: TextStyle(
                                                      fontSize: 14.0, color: Colors.black87, fontWeight: FontWeight.w500
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Container(
                                            width: MediaQuery.of(context).size.width * 0.5,
                                            child: Column(
                                              children: <Widget>[
                                                Row(
                                                  mainAxisAlignment: MainAxisAlignment.end,
                                                  children: <Widget>[
                                                    Flexible(
                                                      child: Text(
                                                        statusActionPlan[index] == 'OPEN' ? 'OPEN' : 'CLOSED',
                                                        style: TextStyle(
                                                          fontSize: 15.0,
                                                          fontWeight: FontWeight.bold,
                                                          color: statusActionPlan[index] == 'OPEN' ? Colors.redAccent : Colors.green,
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                Row(
                                                  mainAxisAlignment: MainAxisAlignment.end,
                                                  children: <Widget>[
                                                    Flexible(
                                                      child: Text(
                                                        statusActionPlan[index] == 'OPEN' ? '-' : useActionPlan[index] == false ? '-' : dueDateView.toDate().toString().substring(8, 10) + '/' + dueDateView.toDate().toString().substring(5, 7) + '/' + dueDateView.toDate().toString().substring(0, 4),
                                                        style: TextStyle(
                                                          fontSize: 13.0,
                                                          color: Colors.black38,
                                                          fontWeight: FontWeight.w700
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            )
                                          )
                                        ],
                                      ),
                                    ),
                                useActionPlan[index] == false
                                  ? SizedBox(
                                      height: 15.0,
                                    )
                                  : Padding(
                                      padding: const EdgeInsets.only(left: 15.0, right: 5.0, bottom: 15.0),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.end,
                                        children: <Widget>[
                                          Container(
                                            padding: EdgeInsets.only(right: 15.0),
                                            alignment: Alignment.centerRight,
                                            child: SizedBox(
                                              height: 20.0,
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
                                                  style: TextStyle(color: AbubaPallate.menuBluebird, fontSize: 12.0),
                                                ),
                                              ),
                                            )
                                          ),
                                        ],
                                      ),
                                    ),
                                showNoteActionPlan[index]
                                  ? Padding(
                                      padding: EdgeInsets.only(left: 17.0, right: 17.0, top: 10.0, bottom: 10.0),
                                      child: Container(
                                        decoration: const BoxDecoration(
                                          border: Border(
                                            top: BorderSide(width: 1.0, color: Color(0xFFFF000000)),
                                            left: BorderSide(width: 1.0, color: Color(0xFFFF000000)),
                                            right: BorderSide(width: 1.0, color: Color(0xFFFF000000)),
                                            bottom: BorderSide(width: 1.0, color: Color(0xFFFF000000)),
                                          ),
                                        ),
                                        padding: EdgeInsets.all(10.0),
                                        child: Column(
                                          children: <Widget>[
                                            Row(
                                              children: <Widget>[
                                                Flexible(
                                                  child: Text(
                                                    'Note',
                                                    style: TextStyle(
                                                        color: Colors.black54,
                                                        fontWeight: FontWeight.w700),
                                                  ),
                                                )
                                              ],
                                            ),
                                            SizedBox(
                                              height: 5.0,
                                            ),
                                            Row(
                                                children: <Widget>[
                                                  Flexible(
                                                    child: Text(
                                                      widget.noteActionPlan[index] == null ? '-' : widget.noteActionPlan[index],
                                                      style: TextStyle(
                                                        color: Colors.black38,
                                                      ),
                                                    ),
                                                  )
                                                ],
                                              )
                                          ],
                                        ),
                                      ),
                                    )
                                  : Container(),
                              ],
                            );
                          }).toList()
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 10.0, right: 10.0, top: 5.0),
                          child: Divider(
                            height: 5.0,
                          ),
                        ),
                        ExpansionTile(
                          title: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                child: Row(
                                  children: <Widget>[
                                    Flexible(
                                      child: Text(
                                        'Meeting Evaluation',
                                        style: TextStyle(
                                          fontSize: 15.0, color: AbubaPallate.greenabuba, fontWeight: FontWeight.bold
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          children: bantuRating == 'YES'
                            ? <Widget>[
                                Padding(
                                  padding: const EdgeInsets.only(left: 20.0, right: 20.0, bottom: 5.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Container(
                                        width: MediaQuery.of(context).size.width * 0.35,
                                        child: Row(
                                          children: <Widget>[
                                            Flexible(
                                              child: Text(
                                                'Stick to the agenda',
                                                style: TextStyle(
                                                  fontSize: 14.0, color: Colors.black87, fontWeight: FontWeight.w500
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        width: MediaQuery.of(context).size.width * 0.35,
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.end,
                                          children: <Widget>[
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.end,
                                              children: List.generate(stickToTheAgenda.round(), (index) {
                                                return Icon(
                                                  Icons.star,
                                                  size: 18.0,
                                                  color: Colors.orangeAccent
                                                );
                                              }).toList()
                                            ),
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.end,
                                              children: List.generate(5 - stickToTheAgenda.round(), (index) {
                                                return Icon(
                                                  Icons.star_border,
                                                  size: 18.0,
                                                  color: Colors.grey
                                                );
                                              }).toList()
                                            ),
                                          ],
                                        )
                                      )
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 20.0, right: 20.0, bottom: 5.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Container(
                                        width: MediaQuery.of(context).size.width * 0.35,
                                        child: Row(
                                          children: <Widget>[
                                            Flexible(
                                              child: Text(
                                                'Manage time',
                                                style: TextStyle(
                                                  fontSize: 14.0, color: Colors.black87, fontWeight: FontWeight.w500
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        width: MediaQuery.of(context).size.width * 0.35,
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.end,
                                          children: <Widget>[
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.end,
                                              children: List.generate(manageTime.round(), (index) {
                                                return Icon(
                                                  Icons.star,
                                                  size: 18.0,
                                                  color: Colors.orangeAccent
                                                );
                                              }).toList()
                                            ),
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.end,
                                              children: List.generate(5 - manageTime.round(), (index) {
                                                return Icon(
                                                  Icons.star_border,
                                                  size: 18.0,
                                                  color: Colors.grey
                                                );
                                              }).toList()
                                            ),
                                          ],
                                        )
                                      )
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 20.0, right: 20.0, bottom: 5.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Container(
                                        width: MediaQuery.of(context).size.width * 0.35,
                                        child: Row(
                                          children: <Widget>[
                                            Flexible(
                                              child: Text(
                                                'Follow ground rules',
                                                style: TextStyle(
                                                  fontSize: 14.0, color: Colors.black87, fontWeight: FontWeight.w500
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        width: MediaQuery.of(context).size.width * 0.35,
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.end,
                                          children: <Widget>[
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.end,
                                              children: List.generate(followGroundRules.round(), (index) {
                                                return Icon(
                                                  Icons.star,
                                                  size: 18.0,
                                                  color: Colors.orangeAccent
                                                );
                                              }).toList()
                                            ),
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.end,
                                              children: List.generate(5 - followGroundRules.round(), (index) {
                                                return Icon(
                                                  Icons.star_border,
                                                  size: 18.0,
                                                  color: Colors.grey
                                                );
                                              }).toList()
                                            ),
                                          ],
                                        )
                                      )
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 20.0, right: 20.0, bottom: 5.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Container(
                                        width: MediaQuery.of(context).size.width * 0.35,
                                        child: Row(
                                          children: <Widget>[
                                            Flexible(
                                              child: Text(
                                                'Balance of participants',
                                                style: TextStyle(
                                                  fontSize: 14.0, color: Colors.black87, fontWeight: FontWeight.w500
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        width: MediaQuery.of(context).size.width * 0.35,
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.end,
                                          children: <Widget>[
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.end,
                                              children: List.generate(balanceOfParticipants.round(), (index) {
                                                return Icon(
                                                  Icons.star,
                                                  size: 18.0,
                                                  color: Colors.orangeAccent
                                                );
                                              }).toList()
                                            ),
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.end,
                                              children: List.generate(5 - balanceOfParticipants.round(), (index) {
                                                return Icon(
                                                  Icons.star_border,
                                                  size: 18.0,
                                                  color: Colors.grey
                                                );
                                              }).toList()
                                            ),
                                          ],
                                        )
                                      )
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 20.0, right: 20.0, bottom: 5.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Container(
                                        width: MediaQuery.of(context).size.width * 0.35,
                                        child: Row(
                                          children: <Widget>[
                                            Flexible(
                                              child: Text(
                                                'Listen to each others',
                                                style: TextStyle(
                                                  fontSize: 14.0, color: Colors.black87, fontWeight: FontWeight.w500
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        width: MediaQuery.of(context).size.width * 0.35,
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.end,
                                          children: <Widget>[
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.end,
                                              children: List.generate(listenToEachOthers.round(), (index) {
                                                return Icon(
                                                  Icons.star,
                                                  size: 18.0,
                                                  color: Colors.orangeAccent
                                                );
                                              }).toList()
                                            ),
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.end,
                                              children: List.generate(5 - listenToEachOthers.round(), (index) {
                                                return Icon(
                                                  Icons.star_border,
                                                  size: 18.0,
                                                  color: Colors.grey
                                                );
                                              }).toList()
                                            ),
                                          ],
                                        )
                                      )
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 20.0, right: 20.0, bottom: 5.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Container(
                                        width: MediaQuery.of(context).size.width * 0.35,
                                        child: Row(
                                          children: <Widget>[
                                            Flexible(
                                              child: Text(
                                                'Making progress',
                                                style: TextStyle(
                                                  fontSize: 14.0, color: Colors.black87, fontWeight: FontWeight.w500
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        width: MediaQuery.of(context).size.width * 0.35,
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.end,
                                          children: <Widget>[
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.end,
                                              children: List.generate(makingProgress.round(), (index) {
                                                return Icon(
                                                  Icons.star,
                                                  size: 18.0,
                                                  color: Colors.orangeAccent
                                                );
                                              }).toList()
                                            ),
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.end,
                                              children: List.generate(5 - makingProgress.round(), (index) {
                                                return Icon(
                                                  Icons.star_border,
                                                  size: 18.0,
                                                  color: Colors.grey
                                                );
                                              }).toList()
                                            ),
                                          ],
                                        )
                                      )
                                    ],
                                  ),
                                ),
                              ]
                            : <Widget>[
                                Container(
                                  padding: EdgeInsets.only(bottom: 10.0),
                                  child: Text(
                                    'No Data Meeting Evaluation',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 14.0
                                    ),
                                  ),
                                ) 
                              ]
                        ),
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
