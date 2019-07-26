import 'package:flutter/material.dart';
import 'package:flutter_abuba/constant.dart';
import 'package:flutter_abuba/isoft/operation_page/incoming/form_inspection.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class BerandaIncoming extends StatefulWidget {
  final int idUser;
  final String namaUser;
  final String departmentUser;
  BerandaIncoming({this.idUser, this.namaUser, this.departmentUser});

  @override
  _BerandaIncomingState createState() => _BerandaIncomingState();
}

class _BerandaIncomingState extends State<BerandaIncoming> with TickerProviderStateMixin {
  AnimationController animationController;

  List<dynamic> namaMaterial = [];
  List<dynamic> resourceNo = [];
  List<dynamic> supplier = [];

  List<dynamic> detailAttr = [];
  List<dynamic> stdAttr = [];
  List<dynamic> parameterAttr = [];
  List<dynamic> detailVar = [];
  List<dynamic> stdVar = [];
  List<dynamic> stdVarMax = [];
  List<dynamic> stdVarUnit = [];
  List<dynamic> stdVarAlat = [];
  List<dynamic> parameterVar = [];
  List<dynamic> idMaterial = [];
  List<dynamic> idSupplier = [];

  @override
  void initState() {
    super.initState();

    CollectionReference reference = Firestore.instance.collection('material');
    reference.snapshots().listen((data) {
      data.documentChanges.forEach((change) {
        setState(() {
          namaMaterial.add(change.document.data['material']);
          resourceNo.add(change.document.data['resource_code']);
          idMaterial.add(change.document.data['id']);

          detailAttr.add(change.document.data['detailAttr']);
          stdAttr.add(change.document.data['stdAttr']);
          parameterAttr.add(change.document.data['parameterAttr']);
          detailVar.add(change.document.data['detailVar']);
          stdVar.add(change.document.data['stdVar']);
          stdVarMax.add(change.document.data['stdVarMax']);
          stdVarUnit.add(change.document.data['stdVarUnit']);
          stdVarAlat.add(change.document.data['stdVarAlat']);
          parameterVar.add(change.document.data['parameterVar']);
          idSupplier.add(change.document.data['id_supplier']);

          Firestore.instance.collection('supplier').where('id', isEqualTo: change.document.data['id_supplier']).snapshots().listen((data3) {
            supplier.add(data3.documents[0].data['supplier']);
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
        body: ListView(
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
                      style: TextStyle(
                          color: AbubaPallate.greenabuba, fontSize: 12.0),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 15.0),
                    child: Text(
                      'Inspection',
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
                    : Container(
                    color: Colors.white,
                    width: width,
                    child: Column(
                      children: List.generate(namaMaterial.length, (index) {
                        return Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            index == 0
                                ? Padding(
                              padding: const EdgeInsets.fromLTRB(12.0, 12.0, 12.0, 0.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Container(
                                    width: width / 5,
                                    child: Row(
                                      children: <Widget>[
                                        Flexible(
                                          child: Text(
                                            'Resource #',
                                            style: TextStyle(color: Colors.green),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  Container(
                                    width: width / 5,
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: <Widget>[
                                        Flexible(
                                          child: Text(
                                            'Material',
                                            style: TextStyle(color: Colors.green),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  Container(
                                    width: width / 5,
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: <Widget>[
                                        Flexible(
                                          child: Text(
                                            'Supplier',
                                            style: TextStyle(color: Colors.green),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  Container(
                                    width: width / 5,
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: <Widget>[
                                        Flexible(
                                          child: Text(
                                            '',
                                            style: TextStyle(color: Colors.green),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            )
                                : Container(),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(12.0, 6.0, 12.0, 0.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Container(
                                    width: width / 5,
                                    child: Row(
                                      children: <Widget>[
                                        Flexible(
                                          child: Text(
                                            resourceNo[index],
                                            style: TextStyle(
                                                fontSize: 12.0, color: Colors.black38),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  Container(
                                    width: width / 5,
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: <Widget>[
                                        Flexible(
                                          child: Text(
                                            namaMaterial[index],
                                            style: TextStyle(
                                                fontSize: 12.0, color: Colors.black38),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  Container(
                                    width: width / 5,
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: <Widget>[
                                        Flexible(
                                          child: Text(
                                            supplier[index],
                                            style: TextStyle(
                                                fontSize: 12.0, color: Colors.black38),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  Container(
                                    width: width / 5,
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: <Widget>[
                                        Flexible(
                                          child: ButtonTheme(
                                            minWidth: 50.0,
                                            height: 30.0,
                                            splashColor: AbubaPallate.menuBluebird,
                                            child: OutlineButton(
                                              borderSide: BorderSide(
                                                  color: AbubaPallate.menuBluebird),
                                              child: Text(
                                                'VIEW',
                                                style: TextStyle(
                                                    fontSize: 12.0,
                                                    color: AbubaPallate.menuBluebird),
                                                textAlign: TextAlign.center,
                                              ),
                                              onPressed: () {
                                                Navigator.push(context,
                                                    MaterialPageRoute(
                                                        builder: (_) => Inspection(idUser: widget.idUser, namaUser: widget.namaUser, departmentUser: widget.departmentUser, idMaterial: idMaterial[index], namaMaterial: namaMaterial[index], parameterAttr: parameterAttr[index], parameterVar: parameterVar[index], detailAttr: detailAttr[index], detailVar: detailVar[index], stdAttr: stdAttr[index], stdVar: stdVar[index], stdVarMax: stdVarMax[index], stdVarUnit: stdVarUnit[index], stdVarAlat: stdVarAlat[index], idSupplier: idSupplier[index], supplier: supplier[index])
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
                        );
                      }).toList(),
                    )
                );
              },
            )
          ],
        ),
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