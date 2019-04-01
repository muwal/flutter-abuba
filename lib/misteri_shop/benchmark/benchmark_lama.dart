import 'package:flutter/material.dart';
import 'package:flutter_abuba/constant.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'search_service.dart';

import 'detail_benchmark.dart';

class FormBenchmark extends StatefulWidget {
  @override
  _FormBenchmarkState createState() => _FormBenchmarkState();
}

class _FormBenchmarkState extends State<FormBenchmark> {
  Widget _appBarTitle = Image.asset(
    'assets/images/logo.png',
    height: 100.0,
    width: 120.0,
  );

  var queryResultSet = [];
  var tempSearchStore = [];
  bool search = false;
  TextEditingController _controllerSearch = TextEditingController();
  List<String> selectedOutlet = [];
  List<DocumentSnapshot> document;

  initiateSearch(value) {
    if (value.length == 0) {
      setState(() {
        search = false;
        queryResultSet = [];
        tempSearchStore = [];
      });
    }

    var capitalizedValue =
        value.substring(0, 1).toUpperCase() + value.substring(1);

    if (queryResultSet.length == 0 && value.length == 1) {
      SearchService().searchByName(value).then((QuerySnapshot docs) {
        for (int i = 0; i < docs.documents.length; ++i) {
          queryResultSet.add(docs.documents[i].data);
        }
      });
    } else {
      tempSearchStore = [];
      queryResultSet.forEach(
        (element) {
          if (element['nama_outlet'].contains(capitalizedValue)) {
            setState(
              () {
                tempSearchStore.add(element);
              },
            );
          }
        },
      );
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomPadding: false,
        appBar: _appBar(),
        body: GestureDetector(
          onTap: () {
            FocusScope.of(context).requestFocus(FocusNode());
          },
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'Mystery Shopper',
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
                        'Location',
                        style: TextStyle(
                            color: AbubaPallate.greenabuba, fontSize: 12.0),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.all(10.0),
                child: TextField(
                  onChanged: (val) {
                    setState(
                      () {
                        search = true;
                      },
                    );
                    initiateSearch(val);
                  },
                  controller: _controllerSearch,
                  decoration: InputDecoration(
                      suffixIcon: !search
                          ? null
                          : IconButton(
                              onPressed: () {
                                setState(
                                  () {
                                    _controllerSearch.clear();
                                    queryResultSet = [];
                                    tempSearchStore = [];
                                    search = false;
                                  },
                                );
                              },
                              icon: Icon(Icons.close),
                              color: Colors.black,
                              iconSize: 20.0,
                            ),
                      prefixIcon: IconButton(
                        color: Colors.black,
                        icon: Icon(Icons.search),
                        iconSize: 20.0,
                        onPressed: null,
                      ),
                      contentPadding: EdgeInsets.only(left: 25.0),
                      hintText: 'Search by name',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(4.0))),
                ),
              ),
              SizedBox(
                height: 10.0,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.0),
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 10.0),
                  decoration: BoxDecoration(
                    border: Border.all(
                        style: BorderStyle.solid,
                        width: 1.0,
                        color: Colors.black),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Flexible(
                        child: Text(selectedOutlet.length == 0
                            ? ''
                            : selectedOutlet.join(', ')),
                      ),
                      RaisedButton(
                        child: Text('Next'),
                        onPressed: () {
                          setState(() {
                            _controllerSearch.clear();
                            queryResultSet = [];
                            tempSearchStore = [];
                            search = false;
                            Navigator.push(
                                context, MyCustomRoute(builder: (context) => DetailBenchmark()));
                          });
                        },
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 10.0,
              ),
              Expanded(
                child: ListView(
                  physics: ScrollPhysics(),
                  scrollDirection: Axis.vertical,
                  children: <Widget>[
                    !search
                        ? StreamBuilder(
                            stream: Firestore.instance
                                .collection('outlet')
                                .snapshots(),
                            builder: (BuildContext context,
                                AsyncSnapshot<QuerySnapshot> snapshot) {
                              if (!snapshot.hasData)
                                return Container(
                                  child: Center(
                                    child: CircularProgressIndicator(),
                                  ),
                                );

                              document = snapshot.data.documents;

                              return GridView.count(
                                padding:
                                    EdgeInsets.only(left: 10.0, right: 10.0),
                                crossAxisCount: 2,
                                crossAxisSpacing: 4.0,
                                mainAxisSpacing: 4.0,
                                primary: false,
                                shrinkWrap: true,
                                children: List.generate(document.length, (index) {
                                  return GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        _FormBenchmarkState()._controllerSearch.clear();
                                        _FormBenchmarkState().queryResultSet = [];
                                        _FormBenchmarkState().tempSearchStore = [];
                                        _FormBenchmarkState().search = false;
                                        setState(() {
                                          if (_FormBenchmarkState().selectedOutlet.length < 3) {
                                            selectedOutlet.add(document[index].data['nama_outlet']);
                                          }
                                        });
                                      });
                                    },
                                    child: Card(
                                      color: selectedOutlet.contains(document[index].data['nama_outlet'])
                                          ? Color.fromARGB(8, 255, 255, 255)
                                          : Colors.white,
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(10.0)),
                                      elevation: 1.0,
                                      child: Column(
                                        children: <Widget>[
                                          Container(
                                            child: Image.asset(
                                              document[index].data['image'],
                                              fit: BoxFit.fitWidth,
                                            ),
                                          ),
                                          SizedBox(
                                            height: 20.0,
                                          ),
                                          Container(
                                            alignment: Alignment.bottomCenter,
                                            child: Text(
                                              document[index]
                                                  .data['nama_outlet'],
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 16.0,
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  );
                                }).toList(),
                              );
                            },
                          )
                        : GridView.count(
                            padding: EdgeInsets.only(left: 10.0, right: 10.0),
                            crossAxisCount: 2,
                            crossAxisSpacing: 4.0,
                            mainAxisSpacing: 4.0,
                            primary: false,
                            shrinkWrap: true,
                            children: tempSearchStore.map((element) {
                              return buildResultCard(element);
                            }).toList(),
                          ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget buildResultCard(data) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _controllerSearch.clear();
          queryResultSet = [];
          tempSearchStore = [];
          search = false;
          Navigator.push(
              context, MyCustomRoute(builder: (context) => DetailBenchmark()));
        });
      },
      child: Card(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
        elevation: 1.0,
        child: Column(
          children: <Widget>[
            Container(
              child: Image.asset(
                data['image'],
                fit: BoxFit.fitWidth,
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            Container(
              alignment: Alignment.bottomCenter,
              child: Text(
                data['nama_outlet'],
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16.0,
                ),
              ),
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
      title: _appBarTitle,
    );
  }
}
