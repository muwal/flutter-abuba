import 'package:flutter/material.dart';
import 'package:flutter_abuba/constant.dart';

class FishBone extends StatefulWidget {
  @override
  _FishBoneState createState() => _FishBoneState();
}

class _FishBoneState extends State<FishBone> {
  TextEditingController _controller = TextEditingController();
  List<String> _list = [
    'Makanan Pokok',
    'Buah',
    'Sayur',
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: _appBar(),
        body: GestureDetector(
          onTap: () {
            FocusScope.of(context).requestFocus(FocusNode());
          },
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Container(
                padding: const EdgeInsets.all(20.0),
                width: MediaQuery.of(context).size.width,
                child: TextField(
                  textCapitalization: TextCapitalization.sentences,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Type Here',
                    labelStyle: TextStyle(fontSize: 14.0)
                  ),
                  controller: _controller,
                  style: TextStyle(color: Colors.black),
                  onEditingComplete: () {
                    setState(() {
                      _list.add(_controller.text);
                      _controller.clear();
                    });
                  },
                ),
              ),
              Expanded(
                child: ListView(
                  shrinkWrap: true,
                  physics: ScrollPhysics(),
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(left: 10.0, right: 10.0, top: 10.0, bottom: 20.0),
                      child: Wrap(
                        spacing: 8.0,
                        runSpacing: 4.0,
                        runAlignment: WrapAlignment.start,
                        direction: Axis.horizontal,
                        children: _list.map((String name) => Chip(
                          label: Text(name),
                          onDeleted: () {
                            setState(() {
                              _list.remove(name);
                            });
                          },
                        )).toList(),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
        bottomNavigationBar: _bottomBar(),
      ),
    );
  }

  Widget _bottomBar() {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: 55.0,
      child: Container(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              ButtonTheme(
                minWidth: 50.0,
                height: 35.0,
                child: RaisedButton(
                  color: Colors.green,
                  child: Text(
                    'CONFIRM',
                    style: TextStyle(
                      fontSize: 14.0,
                      color: Colors.white
                    ),
                  ),
                  onPressed: () {
                    Navigator.push(context,
                      MyCustomRoute(
                        builder: (context) => MaterialDetail(list: _list)
                      )
                    );
                  },
                ),
              ),
            ],
          ),
        ),
        decoration: BoxDecoration(color: Color(0xFF2F592F))
      ),
    );
  }
  
  Widget _appBar() {
    return AppBar(
      elevation: 0.25,
      backgroundColor: Colors.white,
      iconTheme: IconThemeData(color: Colors.black),
      title: Image.asset(
        'assets/images/logo2.png',
        height: 150.0,
        width: 120.0,
      ),
      bottom: PreferredSize(
        preferredSize: Size.fromHeight(55.0),
        child: Column(
          children: <Widget>[
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: 55.0,
              child: Container(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          'Material',
                          style: TextStyle(color: Colors.white, fontSize: 16.0),
                          textAlign: TextAlign.start,
                        ),
                      ],
                    ),
                  ),
                  decoration: BoxDecoration(color: Color(0xFF2F592F))),
            ),
          ],
        ),
      ),
    );
  }
}

class MaterialDetail extends StatefulWidget {
  final List<String> list;
  MaterialDetail({this.list});

  @override
  _MaterialDetailState createState() => _MaterialDetailState();
}

class _MaterialDetailState extends State<MaterialDetail> {
  List<String> _listDetail = [];
  TextEditingController _controllerDetail = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: _appBar(),
        body: GestureDetector(
          onTap: () {
            FocusScope.of(context).requestFocus(FocusNode());
          },
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Expanded(
                child: ListView.builder(
                  shrinkWrap: true,
                  physics: ScrollPhysics(),
                  itemCount: widget.list.length,
                  itemBuilder: (context, index) {
                    return Container(
                      padding: EdgeInsets.symmetric(horizontal: 10.0),
                      color: Colors.white,
                      child: ExpansionTile(
                        title: Text(
                          widget.list[index],
                          style: TextStyle(
                            fontSize: 14.0
                          ),
                        ),
                        children: <Widget>[
                          Container(
                            padding: const EdgeInsets.only(left: 20.0, right: 20.0, top: 5.0, bottom: 10.0),
                            width: MediaQuery.of(context).size.width,
                            child: TextField(
                              textCapitalization: TextCapitalization.sentences,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: 'Type Here',
                                labelStyle: TextStyle(fontSize: 14.0)
                              ),
                              controller: _controllerDetail,
                              style: TextStyle(color: Colors.black),
                              onEditingComplete: () {
                                setState(() {
                                  _listDetail.add(_controllerDetail.text);
                                  _controllerDetail.clear();
                                });
                              },
                            ),
                          ),
                          Container(
                            alignment: Alignment.topLeft,
                            padding: EdgeInsets.only(left: 20.0, right: 20.0, bottom: 20.0),
                            child: Wrap(
                              spacing: 8.0,
                              runSpacing: 4.0,
                              runAlignment: WrapAlignment.start,
                              direction: Axis.horizontal,
                              children: _listDetail.map((String nameDetail) => Chip(
                                label: Text(nameDetail),
                                onDeleted: () {
                                  setState(() {
                                    _listDetail.remove(nameDetail);
                                  });
                                },
                              )).toList(),
                            ),
                          )
                        ],
                      ),
                    );
                  },
                ),
              )
            ],
          ),
        ),
        bottomNavigationBar: _bottomBar(widget.list),
      ),
    );
  }

  Widget _bottomBar(List<String> listBantu) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: 55.0,
      child: Container(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              ButtonTheme(
                minWidth: 50.0,
                height: 35.0,
                child: RaisedButton(
                  color: Colors.green,
                  child: Text(
                    'CONFIRM',
                    style: TextStyle(
                      fontSize: 14.0,
                      color: Colors.white
                    ),
                  ),
                  onPressed: () {
                    Navigator.push(context,
                      MyCustomRoute(
                        builder: (context) => MaterialDetailAkhir(motherList: listBantu, childList: _listDetail)
                      )
                    );
                  },
                ),
              ),
            ],
          ),
        ),
        decoration: BoxDecoration(color: Color(0xFF2F592F))
      ),
    );
  }
  
  Widget _appBar() {
    return AppBar(
      elevation: 0.25,
      backgroundColor: Colors.white,
      iconTheme: IconThemeData(color: Colors.black),
      title: Image.asset(
        'assets/images/logo.png',
        height: 100.0,
        width: 120.0,
      ),
      bottom: PreferredSize(
        preferredSize: Size.fromHeight(55.0),
        child: Column(
          children: <Widget>[
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: 55.0,
              child: Container(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          'Material',
                          style: TextStyle(color: Colors.white, fontSize: 16.0),
                          textAlign: TextAlign.start,
                        ),
                      ],
                    ),
                  ),
                  decoration: BoxDecoration(color: Color(0xFF2F592F))),
            ),
          ],
        ),
      ),
    );
  }
}

class MaterialDetailAkhir extends StatefulWidget {
  final List<String> motherList;
  final List<String> childList;
  MaterialDetailAkhir({this.motherList, this.childList});

  @override
  _MaterialDetailAkhirState createState() => _MaterialDetailAkhirState();
}

class _MaterialDetailAkhirState extends State<MaterialDetailAkhir> {
  Color _opening = Colors.green;
  Color _middle = Colors.grey;
  Color _closing = Colors.grey;

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;

    return SafeArea(
      child: Scaffold(
        appBar: _appBar(),
        backgroundColor: Colors.white,
        body: GestureDetector(
          onTap: () {
            FocusScope.of(context).requestFocus(FocusNode());
          },
          child: ListView(
            shrinkWrap: true,
            physics: ScrollPhysics(),
            children: <Widget>[
              // Container(
              //   alignment: Alignment.centerLeft,
              //   padding: const EdgeInsets.only(right: 20.0, left: 20.0, bottom: 5.0, top: 20.0),
              //   child: Row(
              //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              //     children: <Widget>[
              //       GestureDetector(
              //         onTap: () {
              //           setState(() {
              //             _opening = Colors.green;
              //             _middle = Colors.grey;
              //             _closing = Colors.grey;
              //           });
              //         },
              //         child: Container(
              //           width: width / 4,
              //           child: Column(
              //             children: <Widget>[
              //               Text(
              //                 'OPENING',
              //                 style: TextStyle(
              //                   fontWeight: FontWeight.bold,
              //                   color: _opening
              //                 ),
              //               ),
              //               Padding(
              //                 padding: const EdgeInsets.symmetric(vertical: 5.0),
              //                 child: Divider(
              //                   height: 10.0,
              //                   color: _opening,
              //                 ),
              //               )
              //             ],
              //           ),
              //         ),
              //       ),
              //       GestureDetector(
              //         onTap: () {
              //           setState(() {
              //             _opening = Colors.grey;
              //             _middle = Colors.green;
              //             _closing = Colors.grey;
              //           });
              //         },
              //         child: Container(
              //           width: width / 4,
              //           child: Column(
              //             children: <Widget>[
              //               Text(
              //                 'MIDDLE',
              //                 style: TextStyle(
              //                   fontWeight: FontWeight.bold,
              //                   color: _middle
              //                 ),
              //               ),
              //               Padding(
              //                 padding: const EdgeInsets.symmetric(vertical: 5.0),
              //                 child: Divider(
              //                   height: 10.0,
              //                   color: _middle,
              //                 ),
              //               )
              //             ],
              //           ),
              //         ),
              //       ),
              //       GestureDetector(
              //         onTap: () {
              //           setState(() {
              //             _opening = Colors.grey;
              //             _middle = Colors.grey;
              //             _closing = Colors.green;
              //           });
              //         },
              //         child: Container(
              //           width: width / 4,
              //           child: Column(
              //             children: <Widget>[
              //               Text(
              //                 'CLOSING',
              //                 style: TextStyle(
              //                   fontWeight: FontWeight.bold,
              //                   color: _closing
              //                 ),
              //               ),
              //               Padding(
              //                 padding: const EdgeInsets.symmetric(vertical: 5.0),
              //                 child: Divider(
              //                   height: 10.0,
              //                   color: _closing,
              //                 ),
              //               )
              //             ],
              //           ),
              //         ),
              //       ),
              //     ],
              //   )
              // ),
            ],
          )
        ),
        bottomNavigationBar: _bottomBar(),
      ),
    );
  }

  Widget _bottomBar() {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: 55.0,
      child: Container(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              ButtonTheme(
                minWidth: 50.0,
                height: 35.0,
                child: RaisedButton(
                  color: Colors.green,
                  child: Text(
                    'CONFIRM',
                    style: TextStyle(
                      fontSize: 14.0,
                      color: Colors.white
                    ),
                  ),
                  onPressed: () {},
                ),
              ),
            ],
          ),
        ),
        decoration: BoxDecoration(color: Color(0xFF2F592F))
      ),
    );
  }
  
  Widget _appBar() {
    return AppBar(
      elevation: 0.25,
      backgroundColor: Colors.white,
      iconTheme: IconThemeData(color: Colors.black),
      title: Image.asset(
        'assets/images/logo.png',
        height: 100.0,
        width: 120.0,
      ),
      bottom: PreferredSize(
        preferredSize: Size.fromHeight(55.0),
        child: Column(
          children: <Widget>[
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: 55.0,
              child: Container(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          'Material',
                          style: TextStyle(color: Colors.white, fontSize: 16.0),
                          textAlign: TextAlign.start,
                        ),
                      ],
                    ),
                  ),
                  decoration: BoxDecoration(color: Color(0xFF2F592F))),
            ),
          ],
        ),
      ),
    );
  }
}