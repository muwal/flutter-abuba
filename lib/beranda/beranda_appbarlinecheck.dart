import 'package:flutter/material.dart';
// import 'package:flutter_abuba/constant.dart';

class AbubaAppBar extends AppBar {
  AbubaAppBar() : super(
      elevation: 0.25,
      backgroundColor: Colors.white,
      flexibleSpace: _buildAbubaAppBar(),
      iconTheme: IconThemeData(
        color: Colors.black
      )
  );

  static Widget _buildAbubaAppBar() {
    return Container(
      padding: EdgeInsets.only(right: 16.0, left: 40.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Image.asset(
            'assets/images/logo.png',
            height: 100.0,
            width: 120.0,
          ),
          new Container(
            child: new Row(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.only(right: 15.0),
                  child: Row(
                    children: [
                      Icon(
                        Icons.favorite,
                        color: Colors.red[500],
                        size: 20.0,
                      ),
                      SizedBox(
                        width: 5.0,
                      ),
                      Text(
                        '41 pts',
                        style: TextStyle(fontSize: 12.0, color: Colors.grey),
                      ),
                    ],
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}