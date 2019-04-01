import 'package:flutter/material.dart';
import 'form_inspection.dart';

class DataSearch extends SearchDelegate<String> {
  final material = [
    {"resource": "1234567890", "material": "Daging Ayam", "supplier": "PT Abuba"},
    {"resource": "1234567891", "material": "Daging Sapi", "supplier": "PT Daging"},
    {"resource": "1234567892", "material": "Daging Kambing", "supplier": "PT Abuba"},
    {"resource": "1234567893", "material": "Telur", "supplier": "Peternakan Ayam Nasional"},
    {"resource": "1234567894", "material": "Tepung Terigu", "supplier": "PT Terigu"},
    {"resource": "1234567895", "material": "Gula Pasir", "supplier": "Gula Nasional"},
    {"resource": "1234567896", "material": "Kecap Manis", "supplier": "Bango"},
    {"resource": "1234567897", "material": "Wortel", "supplier": "PT Kebun"},
    {"resource": "1234567898", "material": "Kentang", "supplier": "PT Kebun"},
    {"resource": "1234567899", "material": "Garam", "supplier": "PT Laut"},
    {"resource": "1234567810", "material": "Jagung Manis Puncak", "supplier": "PT Kebun"}
  ];

  final recentMaterials = [
    {"resource": "1234567890", "material": "Daging Ayam", "supplier": "PT Abuba"},
    {"resource": "1234567891", "material": "Daging Sapi", "supplier": "PT Abuba"},
    {"resource": "1234567892", "material": "Daging Kambing", "supplier": "PT Abuba"}
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
        : material.where((p) => p['material'].toLowerCase().startsWith(query.toLowerCase())).toList();

    return ListView.builder(
      itemBuilder: (context, index) => Column(
        children: <Widget>[
          ListTile(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(
                        builder: (context) => Inspection(material: suggestionList[index]['material'])
                    )
                );
              },
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Expanded(
                    child: RichText(
                      overflow: TextOverflow.ellipsis,
                      text: TextSpan(
                          text: suggestionList[index]['resource'].substring(0, query.length),
                          style: TextStyle(
                              color: Colors.black87,
                              fontWeight: FontWeight.bold
                          ),
                          children: [
                            TextSpan(
                                text: suggestionList[index]['resource'].substring(query.length),
                                style: TextStyle(
                                  color: Colors.grey,
                                )
                            )
                          ]
                      ),
                    ),
                  ),
                  Expanded(
                    child: RichText(
                      overflow: TextOverflow.ellipsis,
                      text: TextSpan(
                          text: suggestionList[index]['material'].substring(0, query.length),
                          style: TextStyle(
                              color: Colors.black87,
                              fontWeight: FontWeight.bold
                          ),
                          children: [
                            TextSpan(
                                text: suggestionList[index]['material'].substring(query.length),
                                style: TextStyle(
                                  color: Colors.grey,
                                )
                            )
                          ]
                      ),
                    ),
                  ),
                  Expanded(
                    child: RichText(
                      overflow: TextOverflow.ellipsis,
                      text: TextSpan(
                          text: suggestionList[index]['supplier'].substring(0, query.length),
                          style: TextStyle(
                              color: Colors.black87,
                              fontWeight: FontWeight.bold
                          ),
                          children: [
                            TextSpan(
                                text: suggestionList[index]['supplier'].substring(query.length),
                                style: TextStyle(
                                  color: Colors.grey,
                                )
                            )
                          ]
                      ),
                    ),
                  ),
                ],
              )
          ),
        ],
      ),
      itemCount: suggestionList.length,
    );
  }
}