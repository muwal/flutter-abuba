import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_abuba/constant.dart';
import 'package:flutter/services.dart';

class LostAsset extends StatefulWidget {
  final int idUser;
  final String namaUser;
  final String departmentUser;

  LostAsset({this.idUser, this.namaUser, this.departmentUser});

  @override
  _LostAssetState createState() => _LostAssetState();
}

class _LostAssetState extends State<LostAsset> with TickerProviderStateMixin {
  AnimationController animationController;
  List<dynamic> merek = [];
  List<dynamic> item = [];
  List<dynamic> itemNo = [];
  List<dynamic> pic = [];
  List<dynamic> tanggal = [];
  List<dynamic> outlet = [];
  List<dynamic> lokasi = [];

  List<dynamic> assetCount = [];
  List<dynamic> outletCount = [];

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(vsync: this, duration: Duration(seconds: 3));
    animationController.reverse(
      from: animationController.value == 0.0
        ? 1.0
        : animationController.value
    );

    CollectionReference ref = Firestore.instance.collection('maintenance_IT');
    ref.orderBy('itemNo', descending: false).snapshots().listen((data) {
      data.documentChanges.forEach((change) {
        setState(() {
          if (change.document.data['alasan'] == 6 && change.document.data['status'] == 'DONE') {
            item.add(change.document.data['item']);
            itemNo.add(change.document.data['itemNo']);
            merek.add(change.document.data['merek']);
            Timestamp convertDate = change.document.data['dueDate'];
            tanggal.add(convertDate.toDate());

            Firestore.instance.collection('user').where('id', isEqualTo: change.document.data['pic']).snapshots().listen((dataPIC) {
              pic.add(dataPIC.documents[0].data['nama']);
            });

            Firestore.instance.collection('outlet').where('id', isEqualTo: change.document.data['outlet']).snapshots().listen((dataOutlet) {
              outlet.add(dataOutlet.documents[0].data['nama_outlet']);
            });

            Firestore.instance.collection('lokasi').where('id', isEqualTo: change.document.data['lokasi']).snapshots().listen((dataLokasi) {
              pic.add(dataLokasi.documents[0].data['lokasi']);
            });
          }
        });
      });
    });

    for (int q = 0; q < itemNo.length; q++) {
      if (assetCount.length == 0) {
        assetCount.add(itemNo[q]);
      } else {
        if (assetCount.contains(itemNo[q]) == false) {
          assetCount.add(itemNo[q]);
        }
      }
    }

    for (int w = 0; w < outlet.length; w++) {
      if (outletCount.length == 0) {
        outletCount.add(outlet[w]);
      } else {
        if (outletCount.contains(outlet[w]) == false) {
          outletCount.add(outlet[w]);
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.dark.copyWith(
        statusBarColor: Color(0xfff9f9f9),),
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            elevation: 0.25,
            backgroundColor: Colors.white,
            iconTheme: IconThemeData(color: Colors.black),
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Flexible(
                  child: Text('Lost Asset', style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w600, color: Colors.black),),
                )
              ],
            ),
            actions: <Widget>[
              IconButton(
                icon: Icon(Icons.search),
                onPressed: () {},
              )
            ],
          ),
          body: Scrollbar(
            child: AnimatedBuilder(
              animation: animationController,
              builder: (_, Widget child) {
                return animationController.isAnimating
                  ? Container(
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    )
                  : ListView(
                      children: <Widget>[
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          verticalDirection: VerticalDirection.down,
                          children: <Widget>[
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 10.0),
                              color: Colors.white,
                              child: Container(
                                child: Padding(
                                  padding: EdgeInsets.only(left: 25.0, right: 25.0, top: 15.0, bottom: 15.0),
                                  child: Column(
                                    children: <Widget>[
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Flexible(
                                            child: Column(
                                              children: <Widget>[
                                                Padding(
                                                  padding: const EdgeInsets.only(left: 5.0, right: 5.0, bottom: 5.0),
                                                  child: Row(
                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                    children: <Widget>[
                                                      Flexible(
                                                        child: Text(
                                                          assetCount.length == 0 ? '0' : assetCount.length.toString(),
                                                          style: TextStyle(
                                                            fontSize: 22.0,
                                                            fontWeight: FontWeight.w800,
                                                            color: Colors.black54,
                                                            letterSpacing: 1.0
                                                          ),
                                                          textAlign: TextAlign.center,
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets.only(left: 5.0, right: 5.0, bottom: 5.0),
                                                  child: Row(
                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                    children: <Widget>[
                                                      Flexible(
                                                        child: Text(
                                                          'Assets',
                                                          style: TextStyle(
                                                            fontSize: 16.0,
                                                            fontWeight: FontWeight.w500,
                                                            color: Colors.black54,
                                                          ),
                                                          textAlign: TextAlign.center,
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Flexible(
                                            child: Column(
                                              children: <Widget>[
                                                Padding(
                                                  padding: const EdgeInsets.only(left: 5.0, right: 5.0, bottom: 5.0),
                                                  child: Row(
                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                    children: <Widget>[
                                                      Flexible(
                                                        child: Text(
                                                          outletCount.length == 0 ? '0' : outletCount.length.toString(),
                                                          style: TextStyle(
                                                            fontSize: 22.0,
                                                            fontWeight: FontWeight.w800,
                                                            color: Colors.black54,
                                                            letterSpacing: 1.0
                                                          ),
                                                          textAlign: TextAlign.center,
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets.only(left: 5.0, right: 5.0, bottom: 5.0),
                                                  child: Row(
                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                    children: <Widget>[
                                                      Flexible(
                                                        child: Text(
                                                          'Outlets',
                                                          style: TextStyle(
                                                            fontSize: 16.0,
                                                            fontWeight: FontWeight.w500,
                                                            color: Colors.black54,
                                                          ),
                                                          textAlign: TextAlign.center,
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 15.0),
                          child: Divider(
                            height: 2.0,
                            color: Colors.black45,
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          verticalDirection: VerticalDirection.down,
                          children: item.length == 0
                            ? <Widget>[
                                Container(
                                  padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
                                  child: Center(
                                    child: Text(
                                      'Alhamdulilah , tidak ada asset yang hilang',
                                      style: TextStyle(
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.w500
                                      ),
                                    ),
                                  ),
                                )
                              ]
                            : List.generate(item.length, (index) {
                                return Container(
                                  padding: EdgeInsets.symmetric(horizontal: 10.0),
                                  color: Colors.white,
                                  child: Container(
                                    child: Padding(
                                      padding: EdgeInsets.all(15),
                                      child: Column(
                                        children: <Widget>[
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: <Widget>[
                                              Flexible(
                                                child: Column(
                                                  children: <Widget>[
                                                    Padding(
                                                      padding: const EdgeInsets.only(left: 5.0, right: 5.0, bottom: 5.0),
                                                      child: Row(
                                                        mainAxisAlignment: MainAxisAlignment.start,
                                                        children: <Widget>[
                                                          Flexible(
                                                            child: RichText(
                                                              textAlign: TextAlign.left,
                                                              overflow: TextOverflow.ellipsis,
                                                              text: TextSpan(
                                                                text: item[index] + ' - ' + merek[index],
                                                                style: TextStyle(
                                                                  fontSize: 14.0,
                                                                  fontWeight: FontWeight.w800,
                                                                  color: AbubaPallate.greenabuba,
                                                                ),
                                                              ),
                                                            )
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding: const EdgeInsets.only(left: 5.0, right: 5.0, bottom: 5.0),
                                                      child: Row(
                                                        mainAxisAlignment: MainAxisAlignment.start,
                                                        children: <Widget>[
                                                          Flexible(
                                                            child: RichText(
                                                              textAlign: TextAlign.left,
                                                              overflow: TextOverflow.ellipsis,
                                                              text: TextSpan(
                                                                text: '# ${itemNo[index]}',
                                                                style: TextStyle(
                                                                  fontSize: 13.0,
                                                                  fontWeight: FontWeight.w400,
                                                                  color: Colors.black38,
                                                                ),
                                                              ),
                                                            )
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Flexible(
                                                child: Column(
                                                  children: <Widget>[
                                                    Padding(
                                                      padding: const EdgeInsets.only(left: 5.0, right: 5.0, bottom: 5.0),
                                                      child: Row(
                                                        mainAxisAlignment: MainAxisAlignment.end,
                                                        children: <Widget>[
                                                          Flexible(
                                                            child: RichText(
                                                              textAlign: TextAlign.right,
                                                              overflow: TextOverflow.ellipsis,
                                                              text: TextSpan(
                                                                text: pic[index],
                                                                style: TextStyle(
                                                                  fontSize: 14.0,
                                                                  fontWeight: FontWeight.w400,
                                                                  color: Colors.black38,
                                                                ),
                                                              ),
                                                            )
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding: const EdgeInsets.only(left: 5.0, right: 5.0, bottom: 5.0),
                                                      child: Row(
                                                        mainAxisAlignment: MainAxisAlignment.end,
                                                        children: <Widget>[
                                                          Flexible(
                                                            child: RichText(
                                                              textAlign: TextAlign.right,
                                                              overflow: TextOverflow.ellipsis,
                                                              text: TextSpan(
                                                                text: tanggal[index].toString().substring(8, 10) + '/' + tanggal[index].toString().substring(5, 7) + '/' + tanggal[index].toString().substring(0, 4),
                                                                style: TextStyle(
                                                                  fontSize: 13.0,
                                                                  fontWeight: FontWeight.w400,
                                                                  color: Colors.black38,
                                                                ),
                                                              ),
                                                            )
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            children: <Widget>[
                                              Flexible(
                                                child: Column(
                                                  children: <Widget>[
                                                    Padding(
                                                      padding: const EdgeInsets.only(left: 5.0, right: 5.0, bottom: 5.0),
                                                      child: Row(
                                                        mainAxisAlignment: MainAxisAlignment.start,
                                                        children: <Widget>[
                                                          Flexible(
                                                            child: RichText(
                                                              textAlign: TextAlign.left,
                                                              overflow: TextOverflow.ellipsis,
                                                              text: TextSpan(
                                                                text: outlet[index] + ' - ' + lokasi[index],
                                                                style: TextStyle(
                                                                  fontSize: 14.0,
                                                                  fontWeight: FontWeight.w400,
                                                                  color: Colors.black38,
                                                                ),
                                                              ),
                                                            )
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              }).toList()
                        ),
                      ],
                    );
              },
            )
          ),
        ),
      ),
    );
  }
}