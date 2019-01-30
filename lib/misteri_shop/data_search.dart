import 'package:flutter/material.dart';
import 'package:flutter_abuba/constant.dart';
import 'package:flutter_abuba/misteri_shop/form_carilokasi.dart';

class DataSearch extends SearchDelegate<String> {
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

  final recentMaterials = [
    {'image': 'assets/images/slide2.png', "outlet": "Abuba Paris"},
    {'image': 'assets/images/slide2.png', "outlet": "Abuba Jakarta"},
    {'image': 'assets/images/slide2.png', "outlet": "Abuba Bogor"},
  ];

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = "";
        },
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
      ),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return null;
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestionList = query.isEmpty
        ? recentMaterials
        : material.where((p) => p['outlet'].toLowerCase().startsWith(query.toLowerCase())).toList();

    return GridView.count(
      shrinkWrap: true,
      crossAxisCount: 2,
      childAspectRatio: 2.0,
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 8.0),
      mainAxisSpacing: 10.0,
      crossAxisSpacing: 20.0,
      children: suggestionList.map((Map map) {
        return new GridTile(
          child: GestureDetector(
            onTap: () {
              Navigator.pushReplacement(context,
                MyCustomRoute(
                  builder: (context) => FormCheckIn(outlet: map['outlet'], imageOutlet: map['image'])
                )
              );
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