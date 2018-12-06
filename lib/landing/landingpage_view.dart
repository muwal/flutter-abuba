import 'package:flutter/material.dart';
import 'package:flutter_abuba/constant.dart';
import 'package:flutter_abuba/beranda/beranda_view.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class LandingPage extends StatefulWidget {
  @override
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  int _BottomNavCurrentIndex = 0;
  List<Widget> _container = [
    new BerandaPage(),
    new BerandaPage(),
    new BerandaPage(),
    new BerandaPage(),
  ];

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: _container[_BottomNavCurrentIndex],
      bottomNavigationBar: _buildBottomNavigation(),
    );
  }

  Widget _buildBottomNavigation() {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      onTap: (index) {
        setState(() {
          _BottomNavCurrentIndex = index;
        });
      },
      currentIndex: _BottomNavCurrentIndex,
      items: [
        BottomNavigationBarItem(
          activeIcon: new Icon(
            Icons.home,
            color: AbubaPallate.green,
          ),
          icon: new Icon(
            Icons.home,
            color: Colors.grey,
          ),
          title: new Text(
            'Home',
          ),
        ),
        BottomNavigationBarItem(
          activeIcon: new Icon(
            Icons.timeline,
            color: AbubaPallate.green,
          ),
          icon: new Icon(
            Icons.timeline,
            color: Colors.grey,
          ),
          title: new Text('What\'s New'),
        ),
        BottomNavigationBarItem(
          activeIcon: new Icon(
            Icons.mail,
            color: AbubaPallate.green,
          ),
          icon: new Icon(
            Icons.mail,
            color: Colors.grey,
          ),
          title: new Text('Inbox'),
        ),
        BottomNavigationBarItem(
          activeIcon: new Icon(
            Icons.person,
            color: AbubaPallate.green,
          ),
          icon: new Icon(
            Icons.person,
            color: Colors.grey,
          ),
          title: new Text('Account'),
        ),
      ],
    );
  }
}
