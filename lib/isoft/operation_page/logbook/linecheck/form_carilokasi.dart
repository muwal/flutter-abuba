import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_abuba/constant.dart';
import 'package:flutter_abuba/isoft/operation_page/logbook/linecheck/form_checkin.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_abuba/isoft/operation_page/logbook/linecheck/search_service.dart';

class FormCariLokasi extends StatefulWidget {
  final int idUser;
  final String namaUser;
  final String departmentUser;
  FormCariLokasi({this.idUser, this.namaUser, this.departmentUser});

  @override
  _FormCariLokasiState createState() => _FormCariLokasiState();
}

class _FormCariLokasiState extends State<FormCariLokasi> {
  Widget _appBarTitle = Image.asset(
    'assets/images/logo2.png',
    height: 150.0,
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
      queryResultSet.forEach((element) {
        if (element['nama_outlet'].contains(capitalizedValue)) {
          setState(() {
            tempSearchStore.add(element);
          });
        }
      });
    }
  }

  final FirebaseAuth _auth = FirebaseAuth.instance;
  Future<FirebaseUser> getUser() async {
    return await _auth.currentUser();
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
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'QC Checklist',
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
                        'Location',
                        style:
                            TextStyle(color: AbubaPallate.greenabuba, fontSize: 12.0),
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
                      borderRadius: BorderRadius.circular(4.0)
                    )
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
                            .orderBy('nama_outlet', descending: false)
                            .snapshots(),
                          builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                            if (!snapshot.hasData)
                              return Container(
                                child: Center(
                                  child: CircularProgressIndicator(),
                                ),
                              );

                            return CardList(document: snapshot.data.documents, idUser: widget.idUser);
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
                          }).toList()
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
        });
        Navigator.push(context,
          MyCustomRoute(
            builder: (context) => FormCheckIn(outlet: data['nama_outlet'], imageOutlet: data['image'], alamatOutlet: data['alamat'], idOutlet: data['id'], idUser: widget.idUser, namaUser: widget.namaUser, departmentUser: widget.departmentUser,)
          )
        );
      },
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
        elevation: 1.0,
        child: Column(
          children: <Widget>[
            Container(
              child: Image.network(
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
              )
            )
          ],
        )
      ),
    );
  }

  Widget _appBar() {
    AppBar(
      elevation: 0.25,
      backgroundColor: Colors.white,
      title: Image.asset(
        'assets/images/logo2.png',
        height: 150.0,
        width: 120.0,
      ),
    );
  }
}

class CardList extends StatefulWidget {
  CardList({this.document, this.idUser, this.aksesStatus, this.namaUser, this.departmentUser});
  final List<DocumentSnapshot> document;
  final int idUser;
  final String aksesStatus;
  final String namaUser;
  final String departmentUser;

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
              _FormCariLokasiState()._controllerSearch.clear();
              _FormCariLokasiState().queryResultSet = [];
              _FormCariLokasiState().tempSearchStore = [];
              _FormCariLokasiState().search = false;
            });
            Navigator.push(context,
              MyCustomRoute(
                builder: (context) => FormCheckIn(outlet: widget.document[index].data['nama_outlet'], imageOutlet: widget.document[index].data['image'], alamatOutlet: widget.document[index].data['alamat'], idOutlet: widget.document[index].data['id'], idUser: widget.idUser, namaUser: widget.namaUser, departmentUser: widget.departmentUser)
              )
            );
          },
          child: Card(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
            elevation: 1.0,
            child: Column(
              children: <Widget>[
                Container(
                  child: Image.network(
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
                  )
                )
              ],
            )
          ),
        );
      }).toList()
    );
  }
}