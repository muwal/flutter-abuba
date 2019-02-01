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
                    setState(() {
                      search = true;
                    });
                    initiateSearch(val);
                  },
                  controller: _controllerSearch,
                  decoration: InputDecoration(
                      suffixIcon: !search
                          ? null
                          : IconButton(
                              onPressed: () {
                                setState(() {
                                  _controllerSearch.clear();
                                  queryResultSet = [];
                                  tempSearchStore = [];
                                  search = false;
                                });
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

                              return CardList(
                                  document: snapshot.data.documents);
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
                            }).toList()),
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
              context,
              MyCustomRoute(
                  builder: (context) => DetailBenchmark()));
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
                  ))
            ],
          )),
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

class CardList extends StatefulWidget {
  CardList({this.document, this.idUser});
  final List<DocumentSnapshot> document;
  final int idUser;

  @override
  CardListState createState() {
    return CardListState();
  }
}

class CardListState extends State<CardList> {
  @override
  Widget build(BuildContext context) {
    return GridView.count(
        padding: EdgeInsets.only(left: 10.0, right: 10.0),
        crossAxisCount: 2,
        crossAxisSpacing: 4.0,
        mainAxisSpacing: 4.0,
        primary: false,
        shrinkWrap: true,
        children: List.generate(widget.document.length, (index) {
          return GestureDetector(
            onTap: () {
              setState(() {
                _FormBenchmarkState()._controllerSearch.clear();
                _FormBenchmarkState().queryResultSet = [];
                _FormBenchmarkState().tempSearchStore = [];
                _FormBenchmarkState().search = false;
                Navigator.push(
                    context,
                    MyCustomRoute(
                        builder: (context) => DetailBenchmark()));
              });
            },
            child: Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0)),
                elevation: 1.0,
                child: Column(
                  children: <Widget>[
                    Container(
                      child: Image.asset(
                        widget.document[index].data['image'],
                        fit: BoxFit.fitWidth,
                      ),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    Container(
                        alignment: Alignment.bottomCenter,
                        child: Text(
                          widget.document[index].data['nama_outlet'],
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 16.0,
                          ),
                        ))
                  ],
                )),
          );
        }).toList());
  }
}
