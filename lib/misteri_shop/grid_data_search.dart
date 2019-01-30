import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_abuba/constant.dart';
import 'package:flutter_abuba/misteri_shop/data_search.dart';
import 'package:flutter_abuba/misteri_shop/form_carilokasi.dart';

class FormCariLokasi extends StatefulWidget {
  @override
  _FormCariLokasiState createState() => _FormCariLokasiState();
}

class _FormCariLokasiState extends State<FormCariLokasi> {
  final TextEditingController _filter = new TextEditingController();
  final dio = new Dio();
  String _searchText = "";
  List names = new List();
  List filteredNames = new List();
  Icon _searchIcon = new Icon(Icons.search);
  Widget _appBarTitle = Image.asset(
    'assets/images/logo.png',
    height: 100.0,
    width: 120.0,
  );

  final material = [
    {'image': 'assets/images/slide2.png', "outlet": "Abuba Paris"},
    {'image': 'assets/images/slide2.png', "outlet": "Abuba Jakarta"},
    {'image': 'assets/images/slide2.png', "outlet": "Abuba Bogor"},
    {'image': 'assets/images/slide2.png', "outlet": "Abuba Bekasi"},
    {'image': 'assets/images/slide2.png', "outlet": "Abuba Bandung"},
    {'image': 'assets/images/slide2.png', "outlet": "Abuba Amerika"},
    {'image': 'assets/images/slide2.png', "outlet": "Abuba Jepang"},
    {'image': 'assets/images/slide2.png', "outlet": "Abuba Inggris"},
    {'image': 'assets/images/slide2.png', "outlet": "Abuba Surabaya"},
    {'image': 'assets/images/slide2.png', "outlet": "Abuba Palembang"},
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: _appBar(),
        body: _buildMenu(),
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
            icon: _searchIcon,
            onPressed:
                // _searchPressed,
                () {
              showSearch(context: context, delegate: DataSearch());
            })
      ],
      title: _appBarTitle,
    );
  }

  Widget _buildMenu() {
    return ListView(
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
        Container(
          padding: EdgeInsets.only(top: 15.0),
          child: _gridImage(),
        ),
      ],
    );
  }

  Widget _gridImage() {
    return GridView.count(
      shrinkWrap: true,
      crossAxisCount: 2,
      childAspectRatio: 2.0,
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 8.0),
      mainAxisSpacing: 10.0,
      crossAxisSpacing: 20.0,
      children: material.map((Map map) {
        return new GridTile(
          child: GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MyCustomRoute(
                      builder: (context) => FormCheckIn(
                          outlet: map['outlet'], imageOutlet: map['image'])));
            },
            child: Stack(
              children: <Widget>[
                Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage(
                          map['image'],
                        ),
                        fit: BoxFit.cover),
                  ),
                ),
                new Positioned(
                  left: 0.0,
                  bottom: 0.0,
                  child: Container(
                    padding: EdgeInsets.all(2.0),
                    width: MediaQuery.of(context).size.width,
                    color:  Color.fromRGBO(255, 255, 255, 0.5),
                    child: new Text(
                      map['outlet'],
                      style: new TextStyle(
                          fontSize: 14.0,
                          color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }
}
