import 'package:flutter/material.dart';
import 'package:flutter_abuba/constant.dart';
// import 'package:flutter_abuba/misteri_shop/form_carilokasi.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter_abuba/misteri_shop/search_service.dart';

class FormCariLokasi extends StatefulWidget {
  final int idUser;
  FormCariLokasi({this.idUser});

  @override
  _FormCariLokasiState createState() => _FormCariLokasiState();
}

class _FormCariLokasiState extends State<FormCariLokasi> {
  Widget _appBarTitle = Image.asset(
    'assets/images/logo.png',
    height: 100.0,
    width: 120.0,
  );

  var queryResultSet = [];
  var tempSearchStore = [];
  bool search = false;
  TextEditingController _controllerSearch = TextEditingController();

  // initiateSearch(value) {
  //   if (value.length == 0) {
  //     setState(() {
  //       search = false;
  //       queryResultSet = [];
  //       tempSearchStore = [];
  //     });
  //   }

  //   var capitalizedValue =
  //       value.substring(0, 1).toUpperCase() + value.substring(1);

  //   if (queryResultSet.length == 0 && value.length == 1) {
  //     SearchService().searchByName(value).then((QuerySnapshot docs) {
  //       for (int i = 0; i < docs.documents.length; ++i) {
  //         queryResultSet.add(docs.documents[i].data);
  //       }
  //     });
  //   } else {
  //     tempSearchStore = [];
  //     queryResultSet.forEach((element) {
  //       if (element['nama_outlet'].contains(capitalizedValue)) {
  //         setState(() {
  //           tempSearchStore.add(element);
  //         });
  //       }
  //     });
  //   }
  // }

  @override
  void initState() {
    super.initState();
    Firestore.instance
      .collection('mystery_shopper')
      .where('user', isEqualTo: widget.idUser)
      .snapshots()
      .listen((data) => data.documents.forEach((doc) {
        if (doc['checkout'] == null) {
          Firestore.instance
            .collection('outlet')
            .where('id', isEqualTo: doc['id_outlet'])
            .snapshots()
            .listen((data2) => data2.documents.forEach((doc2) {
              // Navigator.pushReplacement(context,
              //   MyCustomRoute(
              //     builder: (context) => FormSuasanaResto(outlet: doc2['nama_outlet'], imageOutlet: doc2['image'], alamatOutlet: doc2['alamat'], idOutlet: doc2['id'])
              //   )
              // );
            }));
        }
      }));
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
                    // initiateSearch(val);
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
        // Navigator.push(context,
        //   MyCustomRoute(
        //     builder: (context) => FormCheckIn(outlet: data['nama_outlet'], imageOutlet: data['image'], alamatOutlet: data['alamat'], idOutlet: data['id'], idUser: widget.idUser)
        //   )
        // );
      },
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
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
              )
            )
          ],
        )
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
          tooltip: 'Add Outlet',
          icon: Icon(Icons.add),
          onPressed:() {
            setState(() {
              _controllerSearch.clear();
              queryResultSet = [];
              tempSearchStore = [];
              search = false;
            });
            Navigator.push(context,
              MaterialPageRoute(
                builder: (_) => AddOutlet()
              )
            );
          }
        ),
      ],
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
              _FormCariLokasiState()._controllerSearch.clear();
              _FormCariLokasiState().queryResultSet = [];
              _FormCariLokasiState().tempSearchStore = [];
              _FormCariLokasiState().search = false;
            });
            // Navigator.push(context,
            //   MyCustomRoute(
            //     builder: (context) => FormCheckIn(outlet: widget.document[index].data['nama_outlet'], imageOutlet: widget.document[index].data['image'], alamatOutlet: widget.document[index].data['alamat'], idOutlet: widget.document[index].data['id'], idUser: widget.idUser,)
            //   )
            // );
          },
          child: Card(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
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

class AddOutlet extends StatefulWidget {
  @override
  _AddOutletState createState() => _AddOutletState();
}

class _AddOutletState extends State<AddOutlet> {
  TextEditingController _controllerOutlet = TextEditingController();
  TextEditingController _controllerAlamat = TextEditingController();
  TextEditingController _controllerSearchKey = TextEditingController();
  var maxid = 0;
  var index;

  void addOutlet() {
    Firestore.instance
      .collection('dumper_outlet')
      .snapshots()
      .listen((data) => data.documents.forEach((doc) {
        var maxid_bantu = doc['max_id'];
        var index_bantu = data.documents[0].reference;

        setState(() {
          maxid = maxid_bantu + 1;
          index = index_bantu;
        });
      }));
    Firestore.instance.runTransaction((Transaction transaction) async {
      CollectionReference reference = Firestore.instance.collection('outlet');
      await reference.add({
        'id': maxid,
        'nama_outlet': _controllerOutlet.text,
        'alamat': _controllerAlamat.text,
        'image': 'assets/images/slide2.png',
        'searchKey': _controllerSearchKey.text.substring(0,1).toUpperCase(),
      });

      DocumentSnapshot snapshot = await transaction.get(index);
      await transaction.update(snapshot.reference, {
        'max_id': maxid,
      });
    });
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: Text('Add Outlet'),
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: ListView(
          physics: ScrollPhysics(),
          children: <Widget>[
            Container(
              width: width,
              margin: const EdgeInsets.only(left: 40.0, right: 40.0, top: 10.0),
              alignment: Alignment.center,
              padding: const EdgeInsets.only(left: 0.0, right: 10.0),
              child: TextField(
                decoration: InputDecoration(
                  border: UnderlineInputBorder(),
                  labelStyle: TextStyle(fontSize: 14.0),
                  labelText: 'Nama Outlet'
                ),
                controller: _controllerOutlet,
                keyboardType: TextInputType.text,
                textCapitalization: TextCapitalization.sentences,
                style: TextStyle(fontSize: 15.0, color: Colors.black),
              ),
            ),
            Container(
              width: width,
              margin: const EdgeInsets.only(left: 40.0, right: 40.0, top: 10.0),
              alignment: Alignment.center,
              padding: const EdgeInsets.only(left: 0.0, right: 10.0),
              child: TextField(
                decoration: InputDecoration(
                  border: UnderlineInputBorder(),
                  labelStyle: TextStyle(fontSize: 14.0),
                  labelText: 'Search Key'
                ),
                controller: _controllerSearchKey,
                maxLength: 1,
                keyboardType: TextInputType.text,
                textCapitalization: TextCapitalization.characters,
                style: TextStyle(fontSize: 15.0, color: Colors.black),
              ),
            ),
            Container(
              width: width,
              margin: const EdgeInsets.only(left: 40.0, right: 40.0, top: 10.0),
              alignment: Alignment.center,
              padding: const EdgeInsets.only(left: 0.0, right: 10.0),
              child: TextField(
                decoration: InputDecoration(
                  border: UnderlineInputBorder(),
                  labelStyle: TextStyle(fontSize: 14.0),
                  labelText: 'Alamat Outlet'
                ),
                controller: _controllerAlamat,
                maxLines: 3,
                textCapitalization: TextCapitalization.sentences,
                keyboardType: TextInputType.multiline,
                style: TextStyle(fontSize: 15.0, color: Colors.black),
              ),
            ),
            Container(
              width: width,
              margin: const EdgeInsets.only(left: 30.0, right: 30.0, top: 30.0),
              alignment: Alignment.center,
              child: FlatButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ),
                color: AbubaPallate.greenabuba,
                onPressed: addOutlet,
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 20.0,horizontal: 20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Expanded(
                        child: Text(
                          "SAVE",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            )
          ],
        ),
      ),
    );
  }
}