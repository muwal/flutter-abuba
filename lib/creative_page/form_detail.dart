import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_abuba/constant.dart';
import 'package:intl/intl.dart';

class FormDetail extends StatefulWidget {
  var index;
  FormDetail({this.index});

  @override
  _FormDetailState createState() => _FormDetailState();
}

class _FormDetailState extends State<FormDetail> with TickerProviderStateMixin {
  final formatter = NumberFormat('#,###');
  bool _note = false;
  bool _notedua = false;
  bool _notetiga = false;
  bool _noteEmpat = false;
  bool _noteLima = false;
  bool _noteEnam = false;

  AnimationController animationController;

  String problem = '';
  String userName = '';
  String userDepartment = '';
  String status = '';
  String man = '';
  String material = '';
  String method = '';
  String environment = '';
  String deskripsi = '';
  String financialImprovement = '';
  String financialImprovementDate = '';
  String financialSaving = '';
  String financialSavingDate = '';
  String quality = '';
  String qualityDate = '';

  String financialImprovementHasil = '';
  String financialImprovementDateHasil = '';
  String financialSavingHasil = '';
  String financialSavingDateHasil = '';
  String qualityHasil = '';
  String qualityDateHasil = '';
  String createdDate = '';

  String noteFinancialImprovement = '';
  String noteFinancialSaving = '';
  String noteQuality = '';
  String noteFinancialImprovementHasil = '';
  String noteFinancialSavingHasil = '';
  String noteQualityHasil = '';
  String noCreativeIdea = '';

  String define = '';
  String measure = '';
  String analysis = '';
  String improve = '';
  String control = '';

  @override
  void initState() {
    super.initState();
    Firestore.instance.collection('creative-idea').document(widget.index).snapshots().listen((data){
      setState(() {
        problem = data.data['problem'];
        userName = data.data['userCreated'];
        userDepartment = data.data['userDepartment'];
        status = data.data['status'];
        deskripsi = data.data['description'];
        man = data.data['man'];
        material = data.data['material'];
        method = data.data['method'];
        environment = data.data['environment'];
        financialImprovement = data.data['financial_improvement'];
        financialSaving = data.data['financial_saving'];
        quality = data.data['quality'];

        financialImprovementHasil = data.data['financial_improvement_hasil'];
        financialSavingHasil = data.data['financial_saving_hasil'];
        qualityHasil = data.data['quality_hasil'];

        Timestamp financialImprovementDateBantu = data.data['dateFinancialImprovement'];
        financialImprovementDate = financialImprovementDateBantu.toDate().toString().substring(8, 10) + '/' + financialImprovementDateBantu.toDate().toString().substring(5, 7) + '/' + financialImprovementDateBantu.toDate().toString().substring(0, 4);

        Timestamp financialSavingDateBantu = data.data['dateFinancialSaving'];
        financialSavingDate = financialSavingDateBantu.toDate().toString().substring(8, 10) + '/' + financialSavingDateBantu.toDate().toString().substring(5, 7) + '/' + financialSavingDateBantu.toDate().toString().substring(0, 4);
        Timestamp qualityDateBantu = data.data['dateQuality'];
        qualityDate = qualityDateBantu.toDate().toString().substring(8, 10) + '/' + qualityDateBantu.toDate().toString().substring(5, 7) + '/' + qualityDateBantu.toDate().toString().substring(0, 4);

        Timestamp financialImprovementDateHasilBantu = data.data['dateFinancialImprovementHasil'];
        financialImprovementDateHasil = financialImprovementDateHasilBantu.toDate().toString().substring(8, 10) + '/' + financialImprovementDateHasilBantu.toDate().toString().substring(5, 7) + '/' + financialImprovementDateHasilBantu.toDate().toString().substring(0, 4);

        Timestamp financialSavingDateHasilBantu = data.data['dateFinancialSavingHasil'];
        financialSavingDateHasil = financialSavingDateHasilBantu.toDate().toString().substring(8, 10) + '/' + financialSavingDateHasilBantu.toDate().toString().substring(5, 7) + '/' + financialSavingDateHasilBantu.toDate().toString().substring(0, 4);

        Timestamp qualityDateHasilBantu = data.data['dateQualityHasil'];
        qualityDateHasil = qualityDateHasilBantu.toDate().toString().substring(8, 10) + '/' + qualityDateHasilBantu.toDate().toString().substring(5, 7) + '/' + qualityDateHasilBantu.toDate().toString().substring(0, 4);

        Timestamp createdDateBantu = data.data['dateCreated'];
        createdDate = createdDateBantu.toDate().toString().substring(8, 10) + '/' + createdDateBantu.toDate().toString().substring(5, 7) + '/' + createdDateBantu.toDate().toString().substring(0, 4);

        noteFinancialImprovement = data.data['noteFinancialImprovement'];
        noteFinancialSaving = data.data['noteFinancialSaving'];
        noteQuality = data.data['noteQuality'];

        noteFinancialImprovementHasil = data.data['noteFinancialImprovementHasil'];
        noteFinancialSavingHasil = data.data['noteFinancialSavingHasil'];
        noteQualityHasil = data.data['noteQualityHasil'];

        Timestamp defineBantu = data.data['define'];
        define = defineBantu.toDate().toString().substring(8, 10) + '/' + defineBantu.toDate().toString().substring(5, 7) + '/' + defineBantu.toDate().toString().substring(0, 4);
        Timestamp measureBantu = data.data['measure'];
        measure = measureBantu.toDate().toString().substring(8, 10) + '/' + measureBantu.toDate().toString().substring(5, 7) + '/' + measureBantu.toDate().toString().substring(0, 4);
        Timestamp analysisBantu = data.data['analysis'];
        analysis = analysisBantu.toDate().toString().substring(8, 10) + '/' + analysisBantu.toDate().toString().substring(5, 7) + '/' + analysisBantu.toDate().toString().substring(0, 4);
        Timestamp improveBantu = data.data['improve'];
        improve = improveBantu.toDate().toString().substring(8, 10) + '/' + improveBantu.toDate().toString().substring(5, 7) + '/' + improveBantu.toDate().toString().substring(0, 4);
        Timestamp controlBantu = data.data['control'];
        control = controlBantu.toDate().toString().substring(8, 10) + '/' + controlBantu.toDate().toString().substring(5, 7) + '/' + controlBantu.toDate().toString().substring(0, 4);

        noCreativeIdea = data.data['creativeIdeaNo'].toString().padLeft(4, '0');
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
          child: Scrollbar(
            child: ListView(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Flexible(
                        child: Text(
                          'Creative Idea',
                          style: TextStyle(color: Colors.black12, fontSize: 12.0),
                        ),
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
                          'Detail',
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
                            child: CircularProgressIndicator(),
                          ),
                        )
                      : Column(
                          children: <Widget>[
                            Container(
                  color: Colors.white,
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding:
                            const EdgeInsets.only(right: 20.0, left: 20.0, top: 16.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Flexible(
                              child: Text(
                                'Creative Ideas',
                                style: TextStyle(color: AbubaPallate.green),
                              ),
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(5.0, 8.0, 20.0, 5.0),
                        child: ListTile(
                          onTap: null,
                          leading: Container(
                            width: 50.0,
                            height: 50.0,
                            decoration: new BoxDecoration(
                              shape: BoxShape.circle,
                              image: new DecorationImage(
                                fit: BoxFit.fill,
                                image: NetworkImage("https://image.flaticon.com/icons/png/512/149/149071.png"),
                              ),
                            ),
                          ),
                          title: Text(
                            'No. Creative Idea  $noCreativeIdea',
                            style: TextStyle(
                                color: Colors.black54, fontSize: 12.0),
                          ),
                          subtitle: Padding(
                            padding: const EdgeInsets.only(top: 5.0),
                            child: Text(
                              '$userName . $userDepartment',
                              style: TextStyle(
                                  color: Colors.grey[500], fontSize: 10.0),
                            ),
                          ),
                          trailing: ButtonTheme(
                            minWidth: 50.0,
                            height: 20.0,
                            child: RaisedButton(
                              color: status == 'Pending' ? Colors.red[300] : AbubaPallate.menuBluebird,
                              elevation: 0.0,
                              child: Text(
                                status,
                                style: TextStyle(fontSize: 12.0, color: Colors.white),
                              ),
                              onPressed: () {},
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 15.0,
                ),
                Container(
                  color: Colors.white,
                  child: ExpansionTile(
                    title: Text(
                      'Problem',
                      style: TextStyle(
                        fontSize: 14.0
                      ),
                    ),
                    children: <Widget>[
                      Container(
                        alignment: Alignment.topLeft,
                        padding: const EdgeInsets.only(left: 15.0, right: 15.0, bottom: 15.0),
                        child: Text(
                          problem,
                          style: TextStyle(
                            fontSize: 12.0,
                            color: Colors.black38
                          )
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  color: Colors.white,
                  child: ExpansionTile(
                    title: Text(
                      'Akar Masalah',
                      style: TextStyle(
                        fontSize: 14.0
                      ),
                    ),
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.fromLTRB(15.0, 0.0, 15.0, 6.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                Flexible(
                                  child: Text(
                                    'Man',
                                    style: TextStyle(
                                        fontSize: 13.0, color: Colors.black54),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 5.0,
                            ),
                            Row(
                              children: <Widget>[
                                Flexible(
                                  child: Text(
                                    man,
                                    style: TextStyle(
                                        fontSize: 12.0, color: Colors.black38),
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(15.0, 12.0, 15.0, 6.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                Flexible(
                                  child: Text(
                                    'Material',
                                    style: TextStyle(
                                        fontSize: 13.0, color: Colors.black54),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 5.0,
                            ),
                            Row(
                              children: <Widget>[
                                Flexible(
                                  child: Text(
                                    material,
                                    style: TextStyle(
                                        fontSize: 12.0, color: Colors.black38),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(15.0, 12.0, 15.0, 6.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                Flexible(
                                  child: Text(
                                    'Method',
                                    style: TextStyle(
                                        fontSize: 13.0, color: Colors.black54),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 5.0,
                            ),
                            Row(
                              children: <Widget>[
                                Flexible(
                                  child: Text(
                                    method,
                                    style: TextStyle(
                                        fontSize: 12.0, color: Colors.black38),
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(15.0, 12.0, 15.0, 15.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                Flexible(
                                  child: Text(
                                    'Environment',
                                    style: TextStyle(
                                        fontSize: 13.0, color: Colors.black54),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 5.0,
                            ),
                            Row(
                              children: <Widget>[
                                Flexible(
                                  child: Text(
                                    environment,
                                    style: TextStyle(
                                        fontSize: 12.0, color: Colors.black38),
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  color: Colors.white,
                  child: ExpansionTile(
                    title: Text(
                      'Ide',
                      style: TextStyle(
                        fontSize: 14.0
                      ),
                    ),
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.fromLTRB(15.0, 0.0, 15.0, 6.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                Flexible(
                                  child: Text(
                                    'Deskripsi',
                                    style: TextStyle(
                                        fontSize: 13.0, color: Colors.black54),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 5.0,
                            ),
                            Row(
                              children: <Widget>[
                                Flexible(
                                  child: Text(
                                    deskripsi,
                                    style: TextStyle(
                                        fontSize: 12.0, color: Colors.black38),
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(15.0, 12.0, 15.0, 6.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Flexible(
                                  child: Text(
                                    'Financial Improvement',
                                    style: TextStyle(
                                        fontSize: 13.0, color: Colors.black54),
                                  ),
                                ),
                                Flexible(
                                  child: Text(
                                    financialImprovementDate,
                                    style: TextStyle(
                                        fontSize: 12.0, color: Colors.black38),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 3.0,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Flexible(
                                  child: Text(
                                    'IDR ${formatter.format(int.tryParse(financialImprovement))}',
                                    style: TextStyle(
                                        fontSize: 12.0, color: Colors.black38),
                                  ),
                                ),
                                Flexible(
                                  child: GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        _note = !_note;
                                      });
                                    },
                                    child: Text(
                                      'Note',
                                      style: TextStyle(
                                          fontSize: 13.5,
                                          color: AbubaPallate.menuBluebird),
                                    ),
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 3.0),
                        child: _note
                            ? Container(
                                width: MediaQuery.of(context).size.width,
                                padding: const EdgeInsets.fromLTRB(12.0, 12.0, 12.0, 6.0),
                                color: Colors.white,
                                child: Container(
                                  child: Padding(
                                    padding: const EdgeInsets.only(top: 15.0, bottom: 15.0, left: 10.0),
                                    child: Text(
                                      noteFinancialImprovement,
                                      style: TextStyle(color: Colors.black38),
                                    ),
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.grey[200],
                                    border: Border.all(color: Colors.black12, width: 2.0)
                                  ),
                                ),
                              )
                            : Container(),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(15.0, 12.0, 15.0, 6.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Flexible(
                                  child: Text(
                                    'Financial Saving',
                                    style: TextStyle(
                                        fontSize: 13.0, color: Colors.black54),
                                  ),
                                ),
                                Flexible(
                                  child: Text(
                                    financialSavingDate,
                                    style: TextStyle(
                                        fontSize: 12.0, color: Colors.black38),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 3.0,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Flexible(
                                  child: Text(
                                    'IDR ${formatter.format(int.tryParse(financialSaving))}',
                                    style: TextStyle(
                                        fontSize: 12.0, color: Colors.black38),
                                  ),
                                ),
                                Flexible(
                                  child: GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        _notedua = !_notedua;
                                      });
                                    },
                                    child: Text(
                                      'Note',
                                      style: TextStyle(
                                          fontSize: 13.5,
                                          color: AbubaPallate.menuBluebird),
                                    ),
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 3.0),
                        child: _notedua
                            ? Container(
                                width: MediaQuery.of(context).size.width,
                                padding: const EdgeInsets.fromLTRB(12.0, 12.0, 12.0, 6.0),
                                color: Colors.white,
                                child: Container(
                                  child: Padding(
                                    padding: const EdgeInsets.only(top: 15.0, bottom: 15.0, left: 10.0),
                                    child: Text(
                                      noteFinancialSaving,
                                      style: TextStyle(color: Colors.black38),
                                    ),
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.grey[200],
                                    border: Border.all(color: Colors.black12, width: 2.0)
                                  ),
                                ),
                              )
                            : Container(),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(15.0, 12.0, 15.0, 6.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Flexible(
                                  child: Text(
                                    'Quality',
                                    style: TextStyle(
                                        fontSize: 13.0, color: Colors.black54),
                                  ),
                                ),
                                Flexible(
                                  child: Text(
                                    qualityDate,
                                    style: TextStyle(
                                        fontSize: 12.0, color: Colors.black38),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 3.0,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Flexible(
                                  child: Text(
                                    quality,
                                    style: TextStyle(
                                        fontSize: 12.0, color: Colors.black38),
                                  ),
                                ),
                                Flexible(
                                  child: GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        _notetiga = !_notetiga;
                                      });
                                    },
                                    child: Text(
                                      'Note',
                                      style: TextStyle(
                                          fontSize: 13.5,
                                          color: AbubaPallate.menuBluebird),
                                    ),
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 10.0),
                        child: _notetiga
                            ? Container(
                                width: MediaQuery.of(context).size.width,
                                padding: const EdgeInsets.fromLTRB(12.0, 12.0, 12.0, 6.0),
                                color: Colors.white,
                                child: Container(
                                  child: Padding(
                                    padding: const EdgeInsets.only(top: 15.0, bottom: 15.0, left: 10.0),
                                    child: Text(
                                      noteQuality,
                                      style: TextStyle(color: Colors.black38),
                                    ),
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.grey[200],
                                    border: Border.all(color: Colors.black12, width: 2.0)
                                  ),
                                ),
                              )
                            : Container(),
                      ),
                    ],
                  ),
                ),
                Container(
                  color: Colors.white,
                  child: ExpansionTile(
                    title: Text(
                      'Timeline',
                      style: TextStyle(
                        fontSize: 14.0
                      ),
                    ),
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.fromLTRB(15.0, 12.0, 15.0, 6.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Flexible(
                                  child: Text(
                                    'Define',
                                    style: TextStyle(
                                        fontSize: 13.0, color: Colors.black54),
                                  ),
                                ),
                                Flexible(
                                  child: Text(
                                    define,
                                    style: TextStyle(
                                        fontSize: 12.0, color: Colors.black38),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(15.0, 12.0, 15.0, 6.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Flexible(
                                  child: Text(
                                    'Measure',
                                    style: TextStyle(
                                        fontSize: 13.0, color: Colors.black54),
                                  ),
                                ),
                                Flexible(
                                  child: Text(
                                    measure,
                                    style: TextStyle(
                                        fontSize: 12.0, color: Colors.black38),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(15.0, 12.0, 15.0, 6.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Flexible(
                                  child: Text(
                                    'Analysis',
                                    style: TextStyle(
                                        fontSize: 13.0, color: Colors.black54),
                                  ),
                                ),
                                Flexible(
                                  child: Text(
                                    analysis,
                                    style: TextStyle(
                                        fontSize: 12.0, color: Colors.black38),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(15.0, 12.0, 15.0, 6.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Flexible(
                                  child: Text(
                                    'Improve',
                                    style: TextStyle(
                                        fontSize: 13.0, color: Colors.black54),
                                  ),
                                ),
                                Flexible(
                                  child: Text(
                                    improve,
                                    style: TextStyle(
                                        fontSize: 12.0, color: Colors.black38),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(15.0, 12.0, 15.0, 12.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Flexible(
                                  child: Text(
                                    'Control',
                                    style: TextStyle(
                                        fontSize: 13.0, color: Colors.black54),
                                  ),
                                ),
                                Flexible(
                                  child: Text(
                                    control,
                                    style: TextStyle(
                                        fontSize: 12.0, color: Colors.black38),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  color: Colors.white,
                  child: ExpansionTile(
                    title: Text(
                      'Hasil',
                      style: TextStyle(
                        fontSize: 14.0
                      ),
                    ),
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.fromLTRB(15.0, 12.0, 15.0, 6.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Flexible(
                                  child: Text(
                                    'Financial Improvement',
                                    style: TextStyle(
                                        fontSize: 13.0, color: Colors.black54),
                                  ),
                                ),
                                Flexible(
                                  child: Text(
                                    financialImprovementDateHasil,
                                    style: TextStyle(
                                        fontSize: 12.0, color: Colors.black38),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 3.0,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Flexible(
                                  child: Text(
                                    'IDR ${formatter.format(int.tryParse(financialImprovementHasil))}',
                                    style: TextStyle(
                                        fontSize: 12.0, color: Colors.black38),
                                  ),
                                ),
                                Flexible(
                                  child: GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        _noteEmpat = !_noteEmpat;
                                      });
                                    },
                                    child: Text(
                                      'Note',
                                      style: TextStyle(
                                          fontSize: 13.5,
                                          color: AbubaPallate.menuBluebird),
                                    ),
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 3.0),
                        child: _noteEmpat
                            ? Container(
                                width: MediaQuery.of(context).size.width,
                                padding: const EdgeInsets.fromLTRB(12.0, 12.0, 12.0, 6.0),
                                color: Colors.white,
                                child: Container(
                                  child: Padding(
                                    padding: const EdgeInsets.only(top: 15.0, bottom: 15.0, left: 10.0),
                                    child: Text(
                                      noteFinancialImprovementHasil,
                                      style: TextStyle(color: Colors.black38),
                                    ),
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.grey[200],
                                    border: Border.all(color: Colors.black12, width: 2.0)
                                  ),
                                ),
                              )
                            : Container(),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(15.0, 12.0, 15.0, 6.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Flexible(
                                  child: Text(
                                    'Financial Saving',
                                    style: TextStyle(
                                        fontSize: 13.0, color: Colors.black54),
                                  ),
                                ),
                                Flexible(
                                  child: Text(
                                    financialSavingDateHasil,
                                    style: TextStyle(
                                        fontSize: 12.0, color: Colors.black38),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 3.0,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Flexible(
                                  child: Text(
                                    'IDR ${formatter.format(int.tryParse(financialSavingHasil))}',
                                    style: TextStyle(
                                        fontSize: 12.0, color: Colors.black38),
                                  ),
                                ),
                                Flexible(
                                  child: GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        _noteLima = !_noteLima;
                                      });
                                    },
                                    child: Text(
                                      'Note',
                                      style: TextStyle(
                                          fontSize: 13.5,
                                          color: AbubaPallate.menuBluebird),
                                    ),
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 3.0),
                        child: _noteLima
                            ? Container(
                                width: MediaQuery.of(context).size.width,
                                padding: const EdgeInsets.fromLTRB(12.0, 12.0, 12.0, 6.0),
                                color: Colors.white,
                                child: Container(
                                  child: Padding(
                                    padding: const EdgeInsets.only(top: 15.0, bottom: 15.0, left: 10.0),
                                    child: Text(
                                      noteFinancialSavingHasil,
                                      style: TextStyle(color: Colors.black38),
                                    ),
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.grey[200],
                                    border: Border.all(color: Colors.black12, width: 2.0)
                                  ),
                                ),
                              )
                            : Container(),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(15.0, 12.0, 15.0, 6.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Flexible(
                                  child: Text(
                                    'Quality',
                                    style: TextStyle(
                                        fontSize: 13.0, color: Colors.black54),
                                  ),
                                ),
                                Flexible(
                                  child: Text(
                                    qualityDateHasil,
                                    style: TextStyle(
                                        fontSize: 12.0, color: Colors.black38),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 3.0,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Flexible(
                                  child: Text(
                                    qualityHasil,
                                    style: TextStyle(
                                        fontSize: 12.0, color: Colors.black38),
                                  ),
                                ),
                                Flexible(
                                  child: GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        _noteEnam = !_noteEnam;
                                      });
                                    },
                                    child: Text(
                                      'Note',
                                      style: TextStyle(
                                          fontSize: 13.5,
                                          color: AbubaPallate.menuBluebird),
                                    ),
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 10.0),
                        child: _noteEnam
                            ? Container(
                                width: MediaQuery.of(context).size.width,
                                padding: const EdgeInsets.fromLTRB(12.0, 12.0, 12.0, 6.0),
                                color: Colors.white,
                                child: Container(
                                  child: Padding(
                                    padding: const EdgeInsets.only(top: 15.0, bottom: 15.0, left: 10.0),
                                    child: Text(
                                      noteQualityHasil,
                                      style: TextStyle(color: Colors.black38),
                                    ),
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.grey[200],
                                    border: Border.all(color: Colors.black12, width: 2.0)
                                  ),
                                ),
                              )
                            : Container(),
                      ),
                    ],
                  ),
                ),
                Container(
                  color: Colors.white,
                  child: ExpansionTile(
                    title: Text(
                      'Informasi Pengiriman',
                      style: TextStyle(
                        fontSize: 14.0
                      ),
                    ),
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.fromLTRB(15.0, 0.0, 15.0, 12.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Container(
                              width: 100.0,
                              child: Row(
                                children: <Widget>[
                                  Flexible(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Text(
                                          'Tanggal Kirim',
                                          style: TextStyle(
                                              color: Colors.grey[500], fontSize: 10.0),
                                        ),
                                        SizedBox(
                                          height: 3.0,
                                        ),
                                        Text(
                                          createdDate,
                                          style: TextStyle(color: Colors.black54, fontSize: 12.0),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              width: 100.0,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Flexible(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Text(
                                          'Dari',
                                          style: TextStyle(
                                              color: Colors.grey[500], fontSize: 10.0),
                                        ),
                                        SizedBox(
                                          height: 3.0,
                                        ),
                                        Text(
                                          '$userName . $userDepartment',
                                          style: TextStyle(color: Colors.black54, fontSize: 12.0),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              width: 100.0,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end ,
                                children: <Widget>[
                                  Flexible(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Text(
                                          'Kepada',
                                          style: TextStyle(
                                              color: Colors.grey[500], fontSize: 10.0),
                                        ),
                                        SizedBox(
                                          height: 3.0,
                                        ),
                                        Text(
                                          'Sony IT',
                                          style: TextStyle(color: Colors.black54, fontSize: 12.0),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(15.0, 0.0, 15.0, 0.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            ButtonTheme(
                              minWidth: 50.0,
                              height: 20.0,
                              child: OutlineButton(
                                borderSide: BorderSide(color: AbubaPallate.greenabuba),
                                child: Text(
                                  'Approve',
                                  style: TextStyle(fontSize: 12.0, color: AbubaPallate.greenabuba),
                                ),
                                onPressed: () {},
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                          ],
                        );
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
