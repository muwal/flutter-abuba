import 'package:flutter/material.dart';

class DashboardKpiMonitoring extends StatefulWidget {
  DashboardKpiMonitoring({Key key}) : super(key: key);

  @override
  _DashboardKpiMonitoringState createState() => new _DashboardKpiMonitoringState();
}

class _DashboardKpiMonitoringState extends State<DashboardKpiMonitoring>{ 
  List<Widget> isi = [
    Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        children: <Widget>[
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            verticalDirection: VerticalDirection.up,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                'Sales per-shift',
                style: TextStyle(
                  color: Colors.green,
                ),
              ),
              Container(
                width: 150.0,
                child: TextField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    prefixText: 'Rp ',
                    hintStyle: TextStyle(fontSize: 12.0),
                  ),
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
              )
            ],
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            verticalDirection: VerticalDirection.up,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                'Customer',
                style: TextStyle(color: Colors.green),
              ),
              Container(
                width: 150.0,
                child: TextField(
                  keyboardType: TextInputType.number,
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
              )
            ],
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            verticalDirection: VerticalDirection.up,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                'Average Check',
                style: TextStyle(color: Colors.green),
              ),
              Container(
                width: 150.0,
                child: TextField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                      prefixText: 'Rp ', hintStyle: TextStyle(fontSize: 12.0)),
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
              )
            ],
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            verticalDirection: VerticalDirection.up,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                'Target Sales',
                style: TextStyle(color: Colors.green),
              ),
              Container(
                width: 150.0,
                child: TextField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                      prefixText: 'Rp ', hintStyle: TextStyle(fontSize: 12.0)),
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
              )
            ],
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            verticalDirection: VerticalDirection.up,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                'Hand Over Sales',
                style: TextStyle(color: Colors.green),
              ),
              Container(
                width: 150.0,
                child: TextField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                      prefixText: 'Rp ', hintStyle: TextStyle(fontSize: 12.0)),
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
              )
            ],
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            verticalDirection: VerticalDirection.up,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                'Sales Bulanan',
                style: TextStyle(color: Colors.green),
              ),
              Container(
                width: 150.0,
                child: TextField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                      prefixText: 'Rp ', hintStyle: TextStyle(fontSize: 12.0)),
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
              )
            ],
          ),
          SizedBox(
            height: 15.0,
          ),
          ButtonTheme(
            minWidth: 50.0,
            height: 30.0,
            child: RaisedButton(
              child: Text(
                'SAVE',
                style: TextStyle(fontSize: 13.0),
              ),
              textColor: Colors.white,
              color: Colors.green,
              onPressed: () {},
            ),
          ),
        ],
      ),
    ),
    Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        children: <Widget>[
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            verticalDirection: VerticalDirection.up,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                'Sales per-shift',
                style: TextStyle(
                  color: Colors.green,
                ),
              ),
              Container(
                width: 150.0,
                child: TextField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    prefixText: 'Rp ',
                    hintStyle: TextStyle(fontSize: 12.0),
                  ),
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
              )
            ],
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            verticalDirection: VerticalDirection.up,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                'Customer',
                style: TextStyle(color: Colors.green),
              ),
              Container(
                width: 150.0,
                child: TextField(
                  keyboardType: TextInputType.number,
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
              )
            ],
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            verticalDirection: VerticalDirection.up,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                'Average Check',
                style: TextStyle(color: Colors.green),
              ),
              Container(
                width: 150.0,
                child: TextField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                      prefixText: 'Rp ', hintStyle: TextStyle(fontSize: 12.0)),
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
              )
            ],
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            verticalDirection: VerticalDirection.up,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                'Target Sales',
                style: TextStyle(color: Colors.green),
              ),
              Container(
                width: 150.0,
                child: TextField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                      prefixText: 'Rp ', hintStyle: TextStyle(fontSize: 12.0)),
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
              )
            ],
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            verticalDirection: VerticalDirection.up,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                'Hand Over Sales',
                style: TextStyle(color: Colors.green),
              ),
              Container(
                width: 150.0,
                child: TextField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                      prefixText: 'Rp ', hintStyle: TextStyle(fontSize: 12.0)),
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
              )
            ],
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            verticalDirection: VerticalDirection.up,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                'Sales Bulanan',
                style: TextStyle(color: Colors.green),
              ),
              Container(
                width: 150.0,
                child: TextField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                      prefixText: 'Rp ', hintStyle: TextStyle(fontSize: 12.0)),
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
              )
            ],
          ),
          SizedBox(
            height: 15.0,
          ),
          ButtonTheme(
            minWidth: 50.0,
            height: 30.0,
            child: RaisedButton(
              child: Text(
                'SAVE',
                style: TextStyle(fontSize: 13.0),
              ),
              textColor: Colors.white,
              color: Colors.green,
              onPressed: () {},
            ),
          ),
        ],
      ),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: isi.length,
      child: Scaffold(
        appBar: _appBar(),
        body: GestureDetector(
          onTap: () {
            FocusScope.of(context).requestFocus(FocusNode());
          },
          child: Builder(
            builder: (BuildContext context) => Padding(
              padding: EdgeInsets.all(8.0),
              child: Column(
                children: <Widget>[
                  Expanded(
                    child: TabBarView(
                      children: isi
                    ),
                  ),
                  TabPageSelector(),
                  // RaisedButton(
                  //   child: Text('Next'),
                  //   onPressed: () {
                  //     final TabController controller = DefaultTabController.of(context);
                  //     if (!controller.indexIsChanging) {
                  //       controller.animateTo(controller.index + 1);
                  //     }
                  //   },
                  // )
                ],
              ),
            ),
          ),
        ),
      )
    );
  }

  Widget _appBar() {
    return AppBar(
      elevation: 0.25,
      backgroundColor: Colors.white,
      iconTheme: IconThemeData(color: Colors.black),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Image.asset(
            'assets/images/logo.png',
            height: 100.0,
            width: 120.0,
          ),
          new Container(
            child: Container(
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
            ),
          )
        ],
      ),
    );
  }
}