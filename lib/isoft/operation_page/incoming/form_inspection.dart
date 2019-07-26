import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:datetime_picker_formfield/time_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_abuba/constant.dart';
import 'package:intl/intl.dart';

class Inspection extends StatefulWidget {
  Inspection({this.idUser, this.departmentUser, this.namaUser, this.idMaterial, this.namaMaterial, this.detailAttr, this.detailVar, this.parameterAttr, this.parameterVar, this.stdAttr, this.stdVar, this.stdVarMax, this.stdVarUnit, this.stdVarAlat, this.idSupplier, this.supplier});

  final int idUser;
  final String namaUser;
  final String departmentUser;
  final List<dynamic> detailAttr;
  final List<dynamic> stdAttr;
  final bool parameterAttr;
  final List<dynamic> detailVar;
  final List<dynamic> stdVar;
  final List<dynamic> stdVarMax;
  final List<dynamic> stdVarUnit;
  final List<dynamic> stdVarAlat;
  final bool parameterVar;
  final int idMaterial;
  final int idSupplier;
  final String namaMaterial;
  final String supplier;

  @override
  _InspectionState createState() => _InspectionState();
}

class _InspectionState extends State<Inspection> with TickerProviderStateMixin {
  AnimationController animationController;

  List<String> colorButton = ['abu','abu'];
  List<String> colorButton2 = ['abu','abu'];
  List<String> colorButton3 = ['abu','abu'];
  List<String> colorButton4 = ['abu','abu'];

  String barangWaktu = '';
  DateTime timeFormatBarang;
  String barangJumlah = '';
  TextEditingController qtySupplierEvaluation = TextEditingController();

  String coa = '';
  String konKemasan = '';
  TextEditingController suhu = TextEditingController();
  TextEditingController berat = TextEditingController();
  TextEditingController internalLot = TextEditingController();
  TextEditingController qty = TextEditingController();

  DateFormat dateFormat = DateFormat("MMMM d, yyyy");
  
  DateTime dateProduction;
  DateTime dateExpiry;
  DateTime tglDatang;

  List<String> parameterAttrView = [];
  List<String> colorButtonAttr = [];
  List<String> jawabanAttr = [];

  List<String> parameterVarView = [];
  List<String> jawabanVar = [];
  var jawabanVarBantu = <TextEditingController>[];

  bool processReject = false;
  bool processConcession = false;
  bool processApprove = false;

  String _mySelection;

  final now = DateTime.now();
  bool showError = false;

  @override
  void initState() {
    super.initState();

    if (widget.parameterAttr) {
      for (int i = 0; i < widget.detailAttr.length; i++) {
        Firestore.instance.collection('materialParameter').where('id', isEqualTo: widget.detailAttr[i]).snapshots().listen((data) {
          setState(() {
            parameterAttrView.add(data.documents[0].data['parameter']);
            colorButtonAttr.add('abu');
            jawabanAttr.add(null);
          });
        });
      }
    } else {
      setState(() {
        parameterAttrView = [];
        jawabanAttr = [];
        colorButtonAttr = [];
      });
    }

    if (widget.parameterVar) {
      for (int i = 0; i < widget.detailVar.length; i++) {
        Firestore.instance.collection('materialParameter').where('id', isEqualTo: widget.detailVar[i]).snapshots().listen((data2) {
          setState(() {
            parameterVarView.add(data2.documents[0].data['parameter']);
            jawabanVar.add(null);
            jawabanVarBantu.add(TextEditingController());
          });
        });
      }
    } else {
      setState(() {
        parameterVarView = [];
        jawabanVar = [];
        jawabanVarBantu = [];
      });
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
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomPadding: true,
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
            child: _buildFormInspection()),
      ),
    );
  }

  Widget _buildFormInspection() {
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
                  'Inspection',
                  style:
                      TextStyle(color: AbubaPallate.greenabuba, fontSize: 12.0),
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
              : Container(
                padding: EdgeInsets.symmetric(vertical: 10.0),
                color: Colors.white,
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Flexible(
                              child: Text(
                                widget.namaMaterial,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15.0
                                ),
                              ),
                            ),
                            Flexible(
                              child: Text(
                                widget.supplier,
                                style: TextStyle(
                                  color: Colors.black54,
                                    fontSize: 14.0
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 15.0,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 0.0),
                        child: Column(
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 20.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text(
                                    'Supplier Evaluation',
                                    style: TextStyle(color: AbubaPallate.green, fontSize: 16.0, fontWeight: FontWeight.w700),
                                    textAlign: TextAlign.start,
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 5.0),
                              child: ListTile(
                                title: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Flexible(
                                      child: Text(
                                        'Barang datang tepat waktu',
                                        style: TextStyle(color: Colors.grey, fontSize: 14.0),
                                        overflow: TextOverflow.clip,
                                      ),
                                    ),
                                    Row(
                                      children: <Widget>[
                                        Padding(
                                          padding: EdgeInsets.all(5.0),
                                          child: ButtonTheme(
                                            minWidth: 40.0,
                                            height: 30.0,
                                            child: RaisedButton(
                                              child: Text('NO', style: TextStyle(
                                                color: colorButton[0].length == 0
                                                  ? Colors.white
                                                  : colorButton[0] == 'merah'
                                                      ? Colors.white
                                                      : Colors.red,
                                              )),

                                              color: colorButton[0].length == 0
                                                ? Colors.white
                                                : colorButton[0] == 'merah'
                                                    ? Color.fromARGB(170, 255, 40, 0)
                                                    : Colors.white,
                                              onPressed: () {
                                                showDialog(
                                                  barrierDismissible: false,
                                                  context: context,
                                                  builder: (context) => Dialog(
                                                    child: Container(
                                                      height: MediaQuery.of(context).size.height * 0.35,
                                                      child: Column(
                                                        children: <Widget>[
                                                          Container(
                                                            color: AbubaPallate.greenabuba,
                                                            height: 50.0,
                                                            child: Center(
                                                              child: Text(
                                                                'Actual Time',
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
                                                            width: 180.0,
                                                            child: TimePickerFormField(
                                                              format: DateFormat('h mm:a'),
                                                              onChanged: (t) {
                                                                setState(() {
                                                                  timeFormatBarang = DateTime(now.year, now.month, now.day, t.hour, t.minute);
                                                                });
                                                              },
                                                              editable: false,
                                                              resetIcon: null,
                                                            ),
                                                          ),
                                                          Row(
                                                            mainAxisAlignment: MainAxisAlignment.end,
                                                            children: <Widget>[
                                                              FlatButton(
                                                                child: Text(
                                                                  'CANCEL',
                                                                  style: TextStyle(
                                                                    color: Colors.black45
                                                                  ),
                                                                ),
                                                                onPressed: () {
                                                                  setState(() {
                                                                    barangWaktu = '';
                                                                    colorButton.removeAt(0);
                                                                    colorButton.insert(0, 'abu');
                                                                  });
                                                                  Navigator.pop(context);
                                                                },
                                                              ),
                                                              FlatButton(
                                                                child: Text(
                                                                  'OK',
                                                                  style: TextStyle(
                                                                    color: AbubaPallate.greenabuba
                                                                  )
                                                                ),
                                                                onPressed: () {
                                                                  setState(() {
                                                                    barangWaktu = 'NO';
                                                                    colorButton.removeAt(0);
                                                                    colorButton.insert(0, 'merah');
                                                                  });
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
                                              },
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.all(5.0),
                                          child: ButtonTheme(
                                            minWidth: 40.0,
                                            height: 30.0,
                                            child: RaisedButton(
                                              child: Text('OK', style: TextStyle(
                                                color: colorButton[0].length == 0
                                                  ? Colors.white
                                                  : colorButton[0] == 'hijau'
                                                      ? Colors.white
                                                      : Colors.green,
                                              )),
                                              color: colorButton[0].length == 0
                                                ? Colors.white
                                                : colorButton[0] == 'hijau'
                                                    ? Color.fromARGB(170, 50, 205, 50)
                                                    : Colors.white,
                                              onPressed: () {
                                                setState(() {
                                                  barangWaktu = 'YES';
                                                  timeFormatBarang = null;

                                                  colorButton.removeAt(0);
                                                  colorButton.insert(0, 'hijau');
                                                });
                                              },
                                            ),
                                          ),
                                        ),
                                        IconButton(
                                          icon: Icon(Icons.help_outline,
                                              color: Colors.transparent),
                                          onPressed: null,
                                        )
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 5.0),
                              child: ListTile(
                                title: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Flexible(
                                      child: Text(
                                        'Barang datang tepat jumlah',
                                        style: TextStyle(color: Colors.grey, fontSize: 14.0),
                                        overflow: TextOverflow.clip,
                                      ),
                                    ),
                                    Row(
                                      children: <Widget>[
                                        Padding(
                                          padding: EdgeInsets.all(5.0),
                                          child: ButtonTheme(
                                            minWidth: 40.0,
                                            height: 30.0,
                                            child: RaisedButton(
                                              child: Text('NO', style: TextStyle(
                                                color: colorButton2[0].length == 0
                                                  ? Colors.white
                                                  : colorButton2[0] == 'merah'
                                                      ? Colors.white
                                                      : Colors.red,
                                              )),

                                              color: colorButton2[0].length == 0
                                                ? Colors.white
                                                : colorButton2[0] == 'merah'
                                                    ? Color.fromARGB(170, 255, 40, 0)
                                                    : Colors.white,
                                              onPressed: () {
                                                setState(() {
                                                  showDialog(
                                                    barrierDismissible: false,
                                                    context: context,
                                                    builder: (context) => Dialog(
                                                      child: Container(
                                                        height: 200.0,
                                                        child: Column(
                                                          children: <Widget>[
                                                            Container(
                                                              color: AbubaPallate.greenabuba,
                                                              height: 50.0,
                                                              child: Center(
                                                                child: Text(
                                                                  'Actual Qty',
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
                                                              width: 100.0,
                                                              child: new ListTile(
                                                                title: new TextFormField(
                                                                  textAlign: TextAlign.center,
                                                                  keyboardType: TextInputType.number,
                                                                  controller: qtySupplierEvaluation,
                                                                ),
                                                              )
                                                            ),
                                                            Row(
                                                              mainAxisAlignment: MainAxisAlignment.end,
                                                              children: <Widget>[
                                                                FlatButton(
                                                                  child: Text(
                                                                    'CANCEL',
                                                                    style: TextStyle(
                                                                      color: Colors.black45
                                                                    ),
                                                                  ),
                                                                  onPressed: () {
                                                                    setState(() {
                                                                      barangJumlah = '';
                                                                      colorButton2.removeAt(0);
                                                                      colorButton2.insert(0, 'abu');
                                                                    });
                                                                    Navigator.pop(context);
                                                                  },
                                                                ),
                                                                FlatButton(
                                                                  child: Text(
                                                                    'OK',
                                                                    style: TextStyle(
                                                                      color: AbubaPallate.greenabuba
                                                                    )
                                                                  ),
                                                                  onPressed: () {
                                                                    setState(() {
                                                                      barangJumlah = 'NO';
                                                                      colorButton2.removeAt(0);
                                                                      colorButton2.insert(0, 'merah');
                                                                    });
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

                                                });
                                              },
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.symmetric(horizontal: 5.0),
                                          child: ButtonTheme(
                                            minWidth: 40.0,
                                            height: 30.0,
                                            child: RaisedButton(
                                              child: Text('OK', style: TextStyle(
                                                color: colorButton2[0].length == 0
                                                  ? Colors.white
                                                  : colorButton2[0] == 'hijau'
                                                    ? Colors.white
                                                    : Colors.green,
                                              )),
                                              color: colorButton2[0].length == 0
                                                ? Colors.white
                                                : colorButton2[0] == 'hijau'
                                                  ? Color.fromARGB(170, 50, 205, 50)
                                                  : Colors.white,
                                              onPressed: () {
                                                setState(() {
                                                  barangJumlah = 'YES';
                                                  qtySupplierEvaluation.clear();

                                                  colorButton2.removeAt(0);
                                                  colorButton2.insert(0, 'hijau');
                                                });
                                              },
                                            ),
                                          ),
                                        ),
                                        IconButton(
                                          icon: Icon(Icons.help_outline,
                                              color: Colors.transparent),
                                          onPressed: null,
                                        )
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ),
                            widget.parameterAttr
                              ? Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Text(
                                        'Parameter Attribut',
                                        style: TextStyle(color: AbubaPallate.green, fontSize: 16.0, fontWeight: FontWeight.w700),
                                        textAlign: TextAlign.start,
                                      ),
                                    ],
                                  )
                                )
                              : Container(),
                            widget.parameterAttr
                              ? Column(
                                  children: List.generate(parameterAttrView.length, (index) {
                                    return Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 5.0),
                                      child: ListTile(
                                        title: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            Flexible(
                                              child: Text(
                                                parameterAttrView[index],
                                                style: TextStyle(color: Colors.grey, fontSize: 14.0),
                                                overflow: TextOverflow.clip,
                                              ),
                                            ),
                                            Row(
                                              children: <Widget>[
                                                Padding(
                                                  padding: EdgeInsets.all(5.0),
                                                  child: ButtonTheme(
                                                    minWidth: 40.0,
                                                    height: 30.0,
                                                    child: RaisedButton(
                                                      child: Text('NO', style: TextStyle(
                                                        color: colorButtonAttr[index].length == 0
                                                          ? Colors.white
                                                          : colorButtonAttr[index] == 'merah'
                                                              ? Colors.white
                                                              : Colors.red,
                                                        )),
                                                        color: colorButtonAttr[index].length == 0
                                                          ? Colors.white
                                                          : colorButtonAttr[index] == 'merah'
                                                            ? Color.fromARGB(170, 255, 40, 0)
                                                            : Colors.white,
                                                      onPressed: () {
                                                        setState(() {
                                                          jawabanAttr.removeAt(index);
                                                          jawabanAttr.insert(index, 'NO');

                                                          colorButtonAttr.removeAt(index);
                                                          colorButtonAttr.insert(index, 'merah');
                                                        });
                                                      },
                                                    ),
                                                  ),
                                                ),
                                                Padding(
                                                  padding: EdgeInsets.all(5.0),
                                                  child: ButtonTheme(
                                                    minWidth: 40.0,
                                                    height: 30.0,
                                                    child: RaisedButton(
                                                      child: Text('OK', style: TextStyle(
                                                        color: colorButtonAttr[index].length == 0
                                                          ? Colors.white
                                                          : colorButtonAttr[index] == 'hijau'
                                                            ? Colors.white
                                                            : Colors.green,
                                                      )),
                                                      color: colorButtonAttr[index].length == 0
                                                        ? Colors.white
                                                        : colorButtonAttr[index] == 'hijau'
                                                          ? Color.fromARGB(170, 50, 205, 50)
                                                          : Colors.white,
                                                      onPressed: () {
                                                        setState(() {
                                                          jawabanAttr.removeAt(index);
                                                          jawabanAttr.insert(index, 'YES');

                                                          colorButtonAttr.removeAt(index);
                                                          colorButtonAttr.insert(index, 'hijau');
                                                        });
                                                      },
                                                    ),
                                                  ),
                                                ),
                                                IconButton(
                                                  icon: Icon(
                                                    Icons.help_outline,
                                                  ),
                                                  tooltip: widget.stdAttr[index],
                                                  onPressed: null,
                                                )
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                    );
                                  }).toList()
                                )
                              : Container(),
                            widget.parameterVar
                              ? Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 20.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Text(
                                        'Parameter Variabel',
                                        style: TextStyle(color: AbubaPallate.green, fontSize: 16.0, fontWeight: FontWeight.w700),
                                        textAlign: TextAlign.start,
                                      ),
                                    ],
                                  ),
                                )
                              : Container(),
                            widget.parameterVar
                              ? Column(
                                  children: List.generate(parameterVarView.length, (index) {
                                    return Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 5.0),
                                      child: ListTile(
                                        title: Container(
                                          width: MediaQuery.of(context).size.width / 1.5,
                                          child: TextField(
                                            onChanged: (value) {
                                              setState(() {
                                                jawabanVar.removeAt(index);
                                                jawabanVar.insert(index, jawabanVarBantu[index].text);
                                              });
                                            },
                                            keyboardType: TextInputType.number,
                                            controller: jawabanVarBantu[index],
                                            decoration: InputDecoration(
                                              labelText: parameterVarView[index],
                                              labelStyle: TextStyle(fontSize: 14.0)),
                                            style: TextStyle(
                                              color: Colors.black,
                                            ),
                                          ),
                                        ),
                                        trailing: IconButton(
                                          icon: Icon(Icons.help_outline),
                                          tooltip: widget.stdVar[index],
                                          onPressed: () {
                                            showModalBottomSheet(
                                                context: context,
                                                builder: (builder){
                                                  return Container(
                                                    child: Wrap(
                                                      children: <Widget>[
                                                        Padding(
                                                          padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 20.0),
                                                          child: Row(
                                                            mainAxisAlignment: MainAxisAlignment.start,
                                                            children: <Widget>[
                                                              Flexible(
                                                                child: Text(
                                                                  parameterVarView[index],
                                                                  style: TextStyle(
                                                                    fontSize: 18.0,
                                                                    color: Colors.black54,
                                                                    fontWeight: FontWeight.bold
                                                                  ),
                                                                  textAlign: TextAlign.center,
                                                                ),
                                                              )
                                                            ],
                                                          ),
                                                        ),
                                                        Container(
                                                          height: MediaQuery.of(context).size.height * 0.3 - 40.0,
                                                          padding: EdgeInsets.only(top: 15.0),
                                                          child: Column(
                                                            children: <Widget>[
                                                              Expanded(
                                                                child: Scrollbar(
                                                                  child: ListView(
                                                                    children: <Widget>[
                                                                      Padding(
                                                                        padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 75.0),
                                                                        child: Column(
                                                                          mainAxisAlignment: MainAxisAlignment.center,
                                                                          crossAxisAlignment: CrossAxisAlignment.center,
                                                                          children: <Widget>[
                                                                            Row(
                                                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                              children: <Widget>[
                                                                                Flexible(
                                                                                  child: Text('Minimum',
                                                                                    style: TextStyle(
                                                                                      color: Colors.black54, fontWeight: FontWeight.w600
                                                                                    ),
                                                                                    textAlign: TextAlign.left,
                                                                                  ),
                                                                                ),
                                                                                Flexible(
                                                                                  child: Text(widget.stdVar[index],
                                                                                    style: TextStyle(
                                                                                        color: Colors.black54,
                                                                                    ),
                                                                                    textAlign: TextAlign.right,
                                                                                  ),
                                                                                )
                                                                              ],
                                                                            ),
                                                                            SizedBox(
                                                                              height: 5.0,
                                                                            ),
                                                                            Row(
                                                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                              children: <Widget>[
                                                                                Flexible(
                                                                                  child: Text('Maximum',
                                                                                    style: TextStyle(
                                                                                        color: Colors.black54, fontWeight: FontWeight.w600
                                                                                    ),
                                                                                    textAlign: TextAlign.left,
                                                                                  ),
                                                                                ),
                                                                                Flexible(
                                                                                  child: Text(widget.stdVarMax[index],
                                                                                    style: TextStyle(
                                                                                      color: Colors.black54,
                                                                                    ),
                                                                                    textAlign: TextAlign.right,
                                                                                  ),
                                                                                )
                                                                              ],
                                                                            ),
                                                                            SizedBox(
                                                                              height: 5.0,
                                                                            ),
                                                                            Row(
                                                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                              children: <Widget>[
                                                                                Flexible(
                                                                                  child: Text('Unit',
                                                                                    style: TextStyle(
                                                                                        color: Colors.black54, fontWeight: FontWeight.w600
                                                                                    ),
                                                                                    textAlign: TextAlign.left,
                                                                                  ),
                                                                                ),
                                                                                Flexible(
                                                                                  child: Text(widget.stdVarUnit[index],
                                                                                    style: TextStyle(
                                                                                      color: Colors.black54,
                                                                                    ),
                                                                                    textAlign: TextAlign.right,
                                                                                  ),
                                                                                )
                                                                              ],
                                                                            ),
                                                                            SizedBox(
                                                                              height: 5.0,
                                                                            ),
                                                                            Row(
                                                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                              children: <Widget>[
                                                                                Flexible(
                                                                                  child: Text('Alat Ukur',
                                                                                    style: TextStyle(
                                                                                        color: Colors.black54, fontWeight: FontWeight.w600
                                                                                    ),
                                                                                    textAlign: TextAlign.left,
                                                                                  ),
                                                                                ),
                                                                                Flexible(
                                                                                  child: Text(widget.stdVarAlat[index],
                                                                                    style: TextStyle(
                                                                                      color: Colors.black54,
                                                                                    ),
                                                                                    textAlign: TextAlign.right,
                                                                                  ),
                                                                                )
                                                                              ],
                                                                            ),
                                                                          ],
                                                                        ),
                                                                      )
                                                                    ],
                                                                  ),
                                                                )
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  );
                                                }
                                            );
                                          },
                                        ),
                                      ),
                                    );
                                  }).toList()
                                )
                              : Container(),
                            Padding(
                              padding: const EdgeInsets.only(top: 15.0, left: 20.0, right: 20.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text(
                                    'Traceability',
                                    style: TextStyle(color: AbubaPallate.green, fontSize: 16.0, fontWeight: FontWeight.w700),
                                    textAlign: TextAlign.start,
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 5.0),
                              child: ListTile(
                                title: Container(
                                  width: MediaQuery.of(context).size.width / 1.5,
                                    decoration: BoxDecoration(
                                      border: Border(
                                        bottom: BorderSide(color: Colors.black87),
                                      ),
                                    ),
                                    child: FlatButton(
                                      onPressed: () async {
                                        final DateTime picked = await showDatePicker(
                                            context: context,
                                            initialDate: DateTime.now(),
                                            firstDate: DateTime(2019, 1),
                                            lastDate: DateTime(2101));
                                        if (picked != null && picked != dateProduction)
                                          setState(() {
                                            dateProduction = picked;
                                          });
                                      },
                                      child: Text(
                                        dateProduction == null ? 'Production Date' : dateProduction.toString().substring(8, 10) + '/' + dateProduction.toString().substring(5, 7) + '/' + dateProduction.toString().substring(0, 4),
                                        style: TextStyle(
                                            color: Colors.black45
                                        ),
                                        textAlign: TextAlign.left,
                                      ),
                                    )
                                  /*child: DateTimePickerFormField(
                                    format: dateFormat,
                                    onChanged: (dt) => setState(() => dateProduction = dt),
                                    dateOnly: true,
                                    editable: false,
                                    resetIcon: null,
                                    style: TextStyle(
                                      fontSize: 14.0,
                                      color: Colors.black
                                    ),
                                    decoration: InputDecoration(
                                      border: UnderlineInputBorder(),
                                      labelText: 'Production Date',
                                      labelStyle: TextStyle(
                                        fontSize: 14.0
                                      )
                                    ),
                                  ),*/
                                ),
                                trailing: IconButton(
                                    icon: Icon(Icons.help_outline),
                                    onPressed: () {
                                      showModalBottomSheet(
                                          context: context,
                                          builder: (builder){
                                            return Container(
                                              child: Wrap(
                                                children: <Widget>[
                                                  Padding(
                                                    padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 20.0),
                                                    child: Row(
                                                      mainAxisAlignment: MainAxisAlignment.start,
                                                      children: <Widget>[
                                                        Flexible(
                                                          child: Text(
                                                            'Production Date',
                                                            style: TextStyle(
                                                              fontSize: 18.0,
                                                              color: Colors.black54,
                                                              fontWeight: FontWeight.bold
                                                            ),
                                                            textAlign: TextAlign.center,
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                  Container(
                                                    height: MediaQuery.of(context).size.height * 0.3 - 40.0,
                                                    padding: EdgeInsets.only(top: 15.0),
                                                    child: Column(
                                                      children: <Widget>[
                                                        Expanded(
                                                          child: Scrollbar(
                                                            child: ListView(
                                                              children: <Widget>[
                                                                Container(
                                                                  padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 75.0),
                                                                    height: MediaQuery.of(context).size.height * 0.28 - 55.0,
                                                                    width: MediaQuery.of(context).size.width,
                                                                    child: ListView(
                                                                      children: <Widget>[
                                                                        Row(
                                                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                          children: <Widget>[
                                                                            Flexible(
                                                                              child: Text('Format',
                                                                                style: TextStyle(
                                                                                    color: Colors.black54, fontWeight: FontWeight.w600
                                                                                ),
                                                                                textAlign: TextAlign.left,
                                                                              ),
                                                                            ),
                                                                            Flexible(
                                                                              child: Text('DD/MM/YYYY',
                                                                                style: TextStyle(
                                                                                  color: Colors.black54,
                                                                                ),
                                                                                textAlign: TextAlign.right,
                                                                              ),
                                                                            ),
                                                                          ],
                                                                        ),
                                                                        SizedBox(
                                                                          height: 5.0,
                                                                        ),
                                                                        Row(
                                                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                          children: <Widget>[
                                                                            Flexible(
                                                                              child: Text('Contoh',
                                                                                style: TextStyle(
                                                                                    color: Colors.black54, fontWeight: FontWeight.w600
                                                                                ),
                                                                                textAlign: TextAlign.left,
                                                                              ),
                                                                            ),
                                                                            Flexible(
                                                                              child: Text('17/08/2019',
                                                                                style: TextStyle(
                                                                                  color: Colors.black54,
                                                                                ),
                                                                                textAlign: TextAlign.right,
                                                                              ),
                                                                            )
                                                                          ],
                                                                        ),
                                                                        SizedBox(
                                                                          height: 5.0,
                                                                        ),
                                                                        Row(
                                                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                          children: <Widget>[
                                                                            Flexible(
                                                                              child: Text('Sumber data',
                                                                                style: TextStyle(
                                                                                    color: Colors.black54, fontWeight: FontWeight.w600
                                                                                ),
                                                                                textAlign: TextAlign.left,
                                                                              ),
                                                                            ),
                                                                            Flexible(
                                                                              child: Text('Lihat label produk',
                                                                                style: TextStyle(
                                                                                  color: Colors.black54,
                                                                                ),
                                                                                textAlign: TextAlign.right,
                                                                              ),
                                                                            )
                                                                          ],
                                                                        ),
                                                                      ],
                                                                    )
                                                                  ),
                                                              ],
                                                            ),
                                                          )
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            );
                                          }
                                      );
                                    }
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 5.0),
                              child: ListTile(
                                title: Container(
                                  width: MediaQuery.of(context).size.width / 1.5,
                                    decoration: BoxDecoration(
                                      border: Border(
                                        bottom: BorderSide(color: Colors.black87),
                                      ),
                                    ),
                                    child: FlatButton(
                                      onPressed: () async {
                                        final DateTime picked = await showDatePicker(
                                            context: context,
                                            initialDate: DateTime.now(),
                                            firstDate: DateTime(2019, 1),
                                            lastDate: DateTime(2101));
                                        if (picked != null && picked != dateExpiry)
                                          setState(() {
                                            dateExpiry = picked;
                                          });
                                      },
                                      child: Text(
                                        dateExpiry == null ? 'Expiry Date' : dateExpiry.toString().substring(8, 10) + '/' + dateExpiry.toString().substring(5, 7) + '/' + dateExpiry.toString().substring(0, 4),
                                        style: TextStyle(
                                            color: Colors.black45
                                        ),
                                        textAlign: TextAlign.left,
                                      ),
                                    )
                                  /*child: DateTimePickerFormField(
                                    format: dateFormat,
                                    onChanged: (dt) => setState(() => dateExpiry = dt),
                                    editable: false,
                                    resetIcon: null,
                                    dateOnly: true,
                                    style: TextStyle(
                                      fontSize: 14.0,
                                      color: Colors.black
                                    ),
                                    decoration: InputDecoration(
                                      border: UnderlineInputBorder(),
                                      labelText: 'Expiry Date',
                                      labelStyle: TextStyle(
                                        fontSize: 14.0
                                      )
                                    ),
                                  ),*/
                                ),
                                trailing: IconButton(
                                    icon: Icon(Icons.help_outline),
                                    onPressed: () {
                                      showModalBottomSheet(
                                          context: context,
                                          builder: (builder){
                                            return Container(
                                              child: Wrap(
                                                children: <Widget>[
                                                  Padding(
                                                    padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 20.0),
                                                    child: Row(
                                                      mainAxisAlignment: MainAxisAlignment.start,
                                                      children: <Widget>[
                                                        Flexible(
                                                          child: Text(
                                                            'Expiry Date',
                                                            style: TextStyle(
                                                              fontSize: 18.0,
                                                              color: Colors.black54,
                                                              fontWeight: FontWeight.bold
                                                            ),
                                                            textAlign: TextAlign.center,
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                  Container(
                                                    height: MediaQuery.of(context).size.height * 0.3 - 40.0,
                                                    padding: EdgeInsets.only(top: 15.0),
                                                    child: Column(
                                                      children: <Widget>[
                                                        Expanded(
                                                          child: Scrollbar(
                                                            child: ListView(
                                                              children: <Widget>[
                                                                Container(
                                                                  padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 75.0),
                                                                  height: MediaQuery.of(context).size.height * 0.28 - 55.0,
                                                                  width: MediaQuery.of(context).size.width,
                                                                  child: ListView(
                                                                    children: <Widget>[
                                                                      Row(
                                                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                        children: <Widget>[
                                                                          Flexible(
                                                                            child: Text('Format',
                                                                              style: TextStyle(
                                                                                  color: Colors.black54, fontWeight: FontWeight.w600
                                                                              ),
                                                                              textAlign: TextAlign.left,
                                                                            ),
                                                                          ),
                                                                          Flexible(
                                                                            child: Text('DD/MM/YYYY',
                                                                              style: TextStyle(
                                                                                color: Colors.black54,
                                                                              ),
                                                                              textAlign: TextAlign.right,
                                                                            ),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                      SizedBox(
                                                                        height: 5.0,
                                                                      ),
                                                                      Row(
                                                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                        children: <Widget>[
                                                                          Flexible(
                                                                            child: Text('Contoh',
                                                                              style: TextStyle(
                                                                                  color: Colors.black54, fontWeight: FontWeight.w600
                                                                              ),
                                                                              textAlign: TextAlign.left,
                                                                            ),
                                                                          ),
                                                                          Flexible(
                                                                            child: Text('17/08/2019',
                                                                              style: TextStyle(
                                                                                color: Colors.black54,
                                                                              ),
                                                                              textAlign: TextAlign.right,
                                                                            ),
                                                                          )
                                                                        ],
                                                                      ),
                                                                      SizedBox(
                                                                        height: 5.0,
                                                                      ),
                                                                      Row(
                                                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                        children: <Widget>[
                                                                          Flexible(
                                                                            child: Text('Sumber data',
                                                                              style: TextStyle(
                                                                                  color: Colors.black54, fontWeight: FontWeight.w600
                                                                              ),
                                                                              textAlign: TextAlign.left,
                                                                            ),
                                                                          ),
                                                                          Flexible(
                                                                            child: Text('Lihat label produk',
                                                                              style: TextStyle(
                                                                                color: Colors.black54,
                                                                              ),
                                                                              textAlign: TextAlign.right,
                                                                            ),
                                                                          )
                                                                        ],
                                                                      ),
                                                                    ],
                                                                  )
                                                                ),
                                                              ],
                                                            ),
                                                          )
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            );
                                          }
                                      );
                                    }
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 5.0),
                              child: ListTile(
                                title: Container(
                                  width: MediaQuery.of(context).size.width / 1.5,
                                    decoration: BoxDecoration(
                                      border: Border(
                                        bottom: BorderSide(color: Colors.black87),
                                      ),
                                    ),
                                    child: FlatButton(
                                      onPressed: () async {
                                        final DateTime picked = await showDatePicker(
                                            context: context,
                                            initialDate: DateTime.now(),
                                            firstDate: DateTime(2019, 1),
                                            lastDate: DateTime(2101));
                                        if (picked != null && picked != tglDatang)
                                          setState(() {
                                            tglDatang = picked;
                                          });
                                      },
                                      child: Text(
                                        tglDatang == null ? 'Tanggal Kedatangan' : tglDatang.toString().substring(8, 10) + '/' + tglDatang.toString().substring(5, 7) + '/' + tglDatang.toString().substring(0, 4),
                                        style: TextStyle(
                                            color: Colors.black45
                                        ),
                                        textAlign: TextAlign.start,
                                      ),
                                    )
                                  /*child: DateTimePickerFormField(
                                    format: DateFormat('MMMM d, yyyy h mm:a'),
                                    onChanged: (dt) => setState(() => tglDatang = dt),
                                    editable: false,
                                    resetIcon: null,
                                    dateOnly: false,
                                    style: TextStyle(
                                      fontSize: 14.0,
                                      color: Colors.black
                                    ),
                                    decoration: InputDecoration(
                                      border: UnderlineInputBorder(),
                                      labelText: 'Tanggal Kedatangan',
                                      labelStyle: TextStyle(
                                        fontSize: 14.0
                                      )
                                    ),
                                  ),*/
                                ),
                                trailing: IconButton(
                                    icon: Icon(Icons.help_outline),
                                    onPressed: () {
                                      showModalBottomSheet(
                                          context: context,
                                          builder: (builder){
                                            return Container(
                                              child: Wrap(
                                                children: <Widget>[
                                                  Padding(
                                                    padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 20.0),
                                                    child: Row(
                                                      mainAxisAlignment: MainAxisAlignment.start,
                                                      children: <Widget>[
                                                        Flexible(
                                                          child: Text(
                                                            'Tanggal Kedatangan',
                                                            style: TextStyle(
                                                              fontSize: 18.0,
                                                              color: Colors.black54,
                                                              fontWeight: FontWeight.bold
                                                            ),
                                                            textAlign: TextAlign.center,
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                  Container(
                                                    height: MediaQuery.of(context).size.height * 0.3 - 40.0,
                                                    padding: EdgeInsets.only(top: 15.0),
                                                    child: Column(
                                                      children: <Widget>[
                                                        Expanded(
                                                          child: Scrollbar(
                                                            child: ListView(
                                                              children: <Widget>[
                                                                Container(
                                                                  padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 75.0),
                                                                  height: MediaQuery.of(context).size.height * 0.28 - 55.0,
                                                                  width: MediaQuery.of(context).size.width,
                                                                  child: ListView(
                                                                    children: <Widget>[
                                                                      Row(
                                                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                        children: <Widget>[
                                                                          Flexible(
                                                                            child: Text('Format',
                                                                              style: TextStyle(
                                                                                  color: Colors.black54, fontWeight: FontWeight.w600
                                                                              ),
                                                                              textAlign: TextAlign.left,
                                                                            ),
                                                                          ),
                                                                          Flexible(
                                                                            child: Text('DD/MM/YYYY',
                                                                              style: TextStyle(
                                                                                color: Colors.black54,
                                                                              ),
                                                                              textAlign: TextAlign.right,
                                                                            ),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                      SizedBox(
                                                                        height: 5.0,
                                                                      ),
                                                                      Row(
                                                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                        children: <Widget>[
                                                                          Flexible(
                                                                            child: Text('Contoh',
                                                                              style: TextStyle(
                                                                                  color: Colors.black54, fontWeight: FontWeight.w600
                                                                              ),
                                                                              textAlign: TextAlign.left,
                                                                            ),
                                                                          ),
                                                                          Flexible(
                                                                            child: Text('17/08/2019',
                                                                              style: TextStyle(
                                                                                color: Colors.black54,
                                                                              ),
                                                                              textAlign: TextAlign.right,
                                                                            ),
                                                                          )
                                                                        ],
                                                                      ),
                                                                      SizedBox(
                                                                        height: 5.0,
                                                                      ),
                                                                      Row(
                                                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                        children: <Widget>[
                                                                          Flexible(
                                                                            child: Text('Sumber data',
                                                                              style: TextStyle(
                                                                                  color: Colors.black54, fontWeight: FontWeight.w600
                                                                              ),
                                                                              textAlign: TextAlign.left,
                                                                            ),
                                                                          ),
                                                                          Flexible(
                                                                            child: Text('Sesuai tanggal kedatangan',
                                                                              style: TextStyle(
                                                                                color: Colors.black54,
                                                                              ),
                                                                              textAlign: TextAlign.right,
                                                                            ),
                                                                          )
                                                                        ],
                                                                      ),
                                                                    ],
                                                                  )
                                                                ),
                                                              ],
                                                            ),
                                                          )
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            );
                                          }
                                      );
                                    }
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 5.0),
                              child: ListTile(
                                title: Container(
                                  width: MediaQuery.of(context).size.width / 1.5,
                                  child: TextFormField(
                                    keyboardType: TextInputType.number,
                                    controller: internalLot,
                                    decoration: InputDecoration(
                                        labelText: 'Internal Lot #',
                                        labelStyle: TextStyle(fontSize: 14.0)),
                                    style: TextStyle(
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                                trailing: IconButton(
                                    icon: Icon(Icons.help_outline),
                                    onPressed: () {
                                      showModalBottomSheet(
                                          context: context,
                                          builder: (builder){
                                            return Container(
                                              child: Wrap(
                                                children: <Widget>[
                                                  Padding(
                                                    padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 20.0),
                                                    child: Row(
                                                      mainAxisAlignment: MainAxisAlignment.start,
                                                      children: <Widget>[
                                                        Flexible(
                                                          child: Text(
                                                            'Internal Lot #',
                                                            style: TextStyle(
                                                              fontSize: 18.0,
                                                              color: Colors.black54,
                                                              fontWeight: FontWeight.bold
                                                            ),
                                                            textAlign: TextAlign.center,
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                  Container(
                                                    height: MediaQuery.of(context).size.height * 0.3 - 40.0,
                                                    padding: EdgeInsets.only(top: 15.0),
                                                    child: Column(
                                                      children: <Widget>[
                                                        Expanded(
                                                          child: Scrollbar(
                                                            child: ListView(
                                                              children: <Widget>[
                                                                Container(
                                                                  padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 75.0),
                                                                  height: MediaQuery.of(context).size.height * 0.28 - 55.0,
                                                                  width: MediaQuery.of(context).size.width,
                                                                  child: ListView(
                                                                    children: <Widget>[
                                                                      Row(
                                                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                        children: <Widget>[
                                                                          Flexible(
                                                                            child: Text('Format',
                                                                              style: TextStyle(
                                                                                  color: Colors.black54, fontWeight: FontWeight.w600
                                                                              ),
                                                                              textAlign: TextAlign.left,
                                                                            ),
                                                                          ),
                                                                          Flexible(
                                                                            child: Text('DDMMYYYY A',
                                                                              style: TextStyle(
                                                                                color: Colors.black54,
                                                                              ),
                                                                              textAlign: TextAlign.right,
                                                                            ),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                      SizedBox(
                                                                        height: 5.0,
                                                                      ),
                                                                      Row(
                                                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                        children: <Widget>[
                                                                          Flexible(
                                                                            child: Text('Contoh',
                                                                              style: TextStyle(
                                                                                  color: Colors.black54, fontWeight: FontWeight.w600
                                                                              ),
                                                                              textAlign: TextAlign.left,
                                                                            ),
                                                                          ),
                                                                          Flexible(
                                                                            child: Text('17082019 A',
                                                                              style: TextStyle(
                                                                                color: Colors.black54,
                                                                              ),
                                                                              textAlign: TextAlign.right,
                                                                            ),
                                                                          )
                                                                        ],
                                                                      ),
                                                                      SizedBox(
                                                                        height: 5.0,
                                                                      ),
                                                                      Row(
                                                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                        children: <Widget>[
                                                                          Flexible(
                                                                            child: Text('Keterangan',
                                                                              style: TextStyle(
                                                                                  color: Colors.black54, fontWeight: FontWeight.w600
                                                                              ),
                                                                              textAlign: TextAlign.left,
                                                                            ),
                                                                          ),
                                                                          Flexible(
                                                                            child: Text('Kode A,B,C menunjukkan urutan kedatangan barang',
                                                                              style: TextStyle(
                                                                                color: Colors.black54,
                                                                              ),
                                                                              textAlign: TextAlign.right,
                                                                            ),
                                                                          )
                                                                        ],
                                                                      ),
                                                                    ],
                                                                  )
                                                                ),
                                                              ],
                                                            ),
                                                          )
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            );
                                          }
                                      );
                                    }
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 5.0),
                              child: ListTile(
                                title: Container(
                                  width: 70.0,
                                  child: TextFormField(
                                    keyboardType: TextInputType.number,
                                    controller: qty,
                                    decoration: InputDecoration(
                                        labelText: 'Quantity',
                                        labelStyle: TextStyle(fontSize: 14.0)),
                                    style: TextStyle(
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                                trailing: Container(
                                  width: 150.0,
                                  child: StreamBuilder(
                                    stream: Firestore.instance.collection('unitIncoming').orderBy('unit', descending: false).snapshots(),
                                    builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                                      if (!snapshot.hasData)
                                        return Container(
                                          child: Center(
                                            child: CircularProgressIndicator(),
                                          ),
                                        );

                                      return DropdownButtonFormField<String>(
                                          decoration: InputDecoration(
                                            labelText: 'Unit',
                                            labelStyle: TextStyle(fontSize: 12.0),
                                          ),
                                          validator: (value) {
                                            if (value == null) {
                                              return 'Please select unit';
                                            } else {
                                              return null;
                                            }
                                          },
                                          value: _mySelection,
                                          onChanged: (String value) {
                                            setState(() {
                                              _mySelection = value;
                                            });
                                          },
                                          items: snapshot.data.documents.map((DocumentSnapshot document) {
                                            return DropdownMenuItem(
                                              value: document['unit'].toString(),
                                              child: Padding(
                                                padding: EdgeInsets.all(10.0),
                                                child: RichText(
                                                  overflow: TextOverflow.visible,
                                                  text: TextSpan(
                                                      text: document['unit'].toString(),
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
                                  ),
                                ),
                              ),
                            ),
                            showError
                              ? Container(
                                  padding: EdgeInsets.only(left: 15.0, top: 10.0),
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    'Lengkapi Data',
                                    style: TextStyle(
                                      fontSize: 12.0, fontStyle: FontStyle.italic, color: Colors.redAccent
                                    ),
                                  ),
                                )
                              : Container(),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 15.0, top: 10.0, left: 5.0, right: 5.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: <Widget>[
                                  ButtonTheme(
                                    minWidth: 50.0,
                                    height: 30.0,
                                    child: OutlineButton(
                                      child: processReject
                                        ? Container(
                                            padding: EdgeInsets.symmetric(vertical: 5.0),
                                            child: Center(
                                              child: SizedBox(
                                                height: 15.0,
                                                width: 15.0,
                                                child: CircularProgressIndicator(
                                                  valueColor: AlwaysStoppedAnimation(AbubaPallate.menuDeals),
                                                  strokeWidth: 2.0,
                                                ),
                                              ),
                                            ),
                                          )
                                        : Text(
                                            'REJECT',
                                            style: TextStyle(fontSize: 13.0),
                                          ),
                                      textColor: AbubaPallate.menuDeals,
                                      borderSide: BorderSide(color: AbubaPallate.menuDeals),
                                      onPressed: () {
                                        // sini
                                        if (dateProduction == null || dateExpiry == null || tglDatang == null || internalLot.text == '' || qty.text == '') {
                                          setState(() {
                                            showError = true;
                                          });
                                        } else {
                                          setState(() {
                                            showError = false;
                                            processReject = true;
                                          });
                                          DocumentReference documentReference = Firestore.instance.collection('incoming').document();

                                          documentReference.setData({
                                            'alasan_supplier_evaluation': [timeFormatBarang, qtySupplierEvaluation.text == '' ? null : qtySupplierEvaluation.text],
                                            'jawaban_supplier_evaluation': [barangWaktu, barangJumlah],
                                            'jawaban_parameter_atribut': jawabanAttr,
                                            'jawaban_parameter_variable': jawabanVar,
                                            'production_date': dateProduction,
                                            'expired_date': dateExpiry,
                                            'tglDatang': tglDatang,
                                            'internal_lot': internalLot.text,
                                            'qty': int.tryParse(qty.text),
                                            'status': 'REJECTED',
                                            'id_material': widget.idMaterial,
                                            'id_supplier': widget.idSupplier,
                                            'date_created': now,
                                            'pic': widget.idUser,
                                            'user_created': widget.idUser,
                                            'detailAttr': widget.detailAttr,
                                            'detailVar': widget.detailVar,
                                            'detailAttrName': parameterAttrView,
                                            'detailVarName': parameterVarView,
                                            'stdAttr': widget.stdAttr,
                                            'stdVar': widget.stdVar,
                                            'unit': _mySelection,
                                          }).then((doc2) {
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
                                                            'Notification',
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
                                                          'Data Saved Successfully!',
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
                                            setState(() {
                                              processReject = false;
                                            });
                                          }).catchError((error2) {
                                            print(error2);
                                          });
                                        }  
                                      },
                                    ),
                                  ),
                                  ButtonTheme(
                                    minWidth: 50.0,
                                    height: 30.0,
                                    child: OutlineButton(
                                      child: processConcession
                                        ? Container(
                                            padding: EdgeInsets.symmetric(vertical: 5.0),
                                            child: Center(
                                              child: SizedBox(
                                                height: 15.0,
                                                width: 15.0,
                                                child: CircularProgressIndicator(
                                                  valueColor: AlwaysStoppedAnimation(AbubaPallate.menuBluebird),
                                                  strokeWidth: 2.0,
                                                ),
                                              ),
                                            ),
                                          )
                                        : Text(
                                            'CONCESSION',
                                            style: TextStyle(fontSize: 13.0),
                                          ),
                                      textColor: AbubaPallate.menuBluebird,
                                      borderSide:
                                          BorderSide(color: AbubaPallate.menuBluebird),
                                      onPressed: () {
                                        if (dateProduction == null || dateExpiry == null || tglDatang == null || internalLot.text == '' || qty.text == '') {
                                          setState(() {
                                            showError = true;
                                          });
                                        } else {
                                          setState(() {
                                            showError = false;
                                            processConcession = true;
                                          });
                                          DocumentReference documentReference = Firestore.instance.collection('incoming').document();

                                          documentReference.setData({
                                            'alasan_supplier_evaluation': [timeFormatBarang, qtySupplierEvaluation.text == '' ? null : qtySupplierEvaluation.text],
                                            'jawaban_supplier_evaluation': [barangWaktu, barangJumlah],
                                            'jawaban_parameter_atribut': jawabanAttr,
                                            'jawaban_parameter_variable': jawabanVar,
                                            'production_date': dateProduction,
                                            'expired_date': dateExpiry,
                                            'tglDatang': tglDatang,
                                            'internal_lot': internalLot.text,
                                            'qty': int.tryParse(qty.text),
                                            'status': 'CONCESSION',
                                            'id_material': widget.idMaterial,
                                            'id_supplier': widget.idSupplier,
                                            'date_created': now,
                                            'pic': widget.idUser,
                                            'user_created': widget.idUser,
                                            'detailAttr': widget.detailAttr,
                                            'detailVar': widget.detailVar,
                                            'detailAttrName': parameterAttrView,
                                            'detailVarName': parameterVarView,
                                            'stdAttr': widget.stdAttr,
                                            'stdVar': widget.stdVar,
                                            'unit': _mySelection,
                                          }).then((doc2) {
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
                                                            'Notification',
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
                                                          'Data Saved Successfully!',
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
                                            setState(() {
                                              processConcession = false;
                                            });
                                          }).catchError((error2) {
                                            print(error2);
                                          });
                                        }
                                      },
                                    ),
                                  ),
                                  ButtonTheme(
                                    minWidth: 50.0,
                                    height: 30.0,
                                    child: OutlineButton(
                                      child: processApprove
                                        ? Container(
                                            padding: EdgeInsets.symmetric(vertical: 5.0),
                                            child: Center(
                                              child: SizedBox(
                                                height: 15.0,
                                                width: 15.0,
                                                child: CircularProgressIndicator(
                                                  valueColor: AlwaysStoppedAnimation(AbubaPallate.greenabuba),
                                                  strokeWidth: 2.0,
                                                ),
                                              ),
                                            ),
                                          )
                                        : Text(
                                            'APPROVE',
                                            style: TextStyle(fontSize: 13.0),
                                          ),
                                      textColor: Colors.green,
                                      borderSide: BorderSide(color: AbubaPallate.greenabuba),
                                      onPressed: () {
                                        if (dateProduction == null || dateExpiry == null || tglDatang == null || internalLot.text == '' || qty.text == '') {
                                          setState(() {
                                            showError = true;
                                          });
                                        } else {
                                          setState(() {
                                            showError = false;
                                            processApprove = true;
                                          });
                                          DocumentReference documentReference = Firestore.instance.collection('incoming').document();

                                          documentReference.setData({
                                            'alasan_supplier_evaluation': [timeFormatBarang, qtySupplierEvaluation.text == '' ? null : qtySupplierEvaluation.text],
                                            'jawaban_supplier_evaluation': [barangWaktu, barangJumlah],
                                            'jawaban_parameter_atribut': jawabanAttr,
                                            'jawaban_parameter_variable': jawabanVar,
                                            'production_date': dateProduction,
                                            'expired_date': dateExpiry,
                                            'tglDatang': tglDatang,
                                            'internal_lot': internalLot.text,
                                            'qty': int.tryParse(qty.text),
                                            'status': 'APPROVED',
                                            'id_material': widget.idMaterial,
                                            'id_supplier': widget.idSupplier,
                                            'date_created': now,
                                            'pic': widget.idUser,
                                            'user_created': widget.idUser,
                                            'detailAttr': widget.detailAttr,
                                            'detailVar': widget.detailVar,
                                            'detailAttrName': parameterAttrView,
                                            'detailVarName': parameterVarView,
                                            'stdAttr': widget.stdAttr,
                                            'stdVar': widget.stdVar,
                                            'unit': _mySelection,
                                          }).then((doc2) {
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
                                                            'Notification',
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
                                                          'Data Saved Successfully!',
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
                                            setState(() {
                                              processApprove = false;
                                            });
                                          }).catchError((error2) {
                                            print(error2);
                                          });
                                        }
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
          },
        )
      ],
    );
  }
}
