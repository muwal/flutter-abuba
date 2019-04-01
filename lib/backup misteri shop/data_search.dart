import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

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
    // final suggestionList = query.isEmpty
        // ? recentMaterials
        // : material.where((p) => p['outlet'].toLowerCase().startsWith(query.toLowerCase())).toList();

    return StreamBuilder(
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

        return GridList(document: snapshot.data.documents);
      },
    );
  }
}

class GridList extends StatelessWidget {
  GridList({this.document});
  final List<DocumentSnapshot> document;

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      shrinkWrap: true,
      crossAxisCount: 2,
      childAspectRatio: 2.0,
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 8.0),
      mainAxisSpacing: 10.0,
      crossAxisSpacing: 20.0,
      children: List.generate(document.length, (index) {
        return GridTile(
          child: GestureDetector(
            onTap: () {
              // Navigator.push(context,
              //   MyCustomRoute(
              //     builder: (context) => FormCheckIn(outlet: document[index].data['nama_outlet'], imageOutlet: document[index].data['image'], alamatOutlet: document[index].data['alamat'])
              //   )
              // );
            },
            child: Stack(
              children: <Widget>[
                Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(
                        document[index].data['image'],
                      ),
                      fit: BoxFit.cover
                    ),
                  ),
                ),
                new Positioned(
                  left: 0.0,
                  bottom: 0.0,
                  child: Container(
                    padding: EdgeInsets.all(6.0),
                    width: MediaQuery.of(context).size.width, 
                    color:  Color.fromRGBO(255, 255, 255, 0.5),
                    child: new Text(
                      document[index].data['nama_outlet'],
                      style: new TextStyle(
                        fontSize: 14.0,
                        color: Colors.white
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      })
    );
  }
}