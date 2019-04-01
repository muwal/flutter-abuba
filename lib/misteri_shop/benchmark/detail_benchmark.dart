import 'package:flutter/material.dart';
import 'package:flutter_abuba/constant.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class DetailBenchmark extends StatefulWidget {
  final int idUser;
  final List<String> selectedOutlet;
  final List<String> selectedOutletTanggal;
  final double hasilParking;
  final double hasilGreeting;
  final double hasilSeating;
  final double hasilTakingOrder;
  final double hasilServingProduct;
  final double hasilCleanliness;
  final double hasilPreBushing;
  final double hasilBilling;
  final double hasilThanking;
  final double hasilComplaint;
  final double hasilServingTime;

  final double hasilParking2;
  final double hasilGreeting2;
  final double hasilSeating2;
  final double hasilTakingOrder2;
  final double hasilServingProduct2;
  final double hasilCleanliness2;
  final double hasilPreBushing2;
  final double hasilBilling2;
  final double hasilThanking2;
  final double hasilComplaint2;
  final double hasilServingTime2;

  DetailBenchmark({this.selectedOutlet, this.selectedOutletTanggal, this.idUser, this.hasilThanking, this.hasilBilling, this.hasilComplaint, this.hasilPreBushing, this.hasilServingTime, this.hasilCleanliness, this.hasilParking, this.hasilSeating, this.hasilGreeting, this.hasilServingProduct, this.hasilTakingOrder, this.hasilBilling2, this.hasilCleanliness2, this.hasilComplaint2, this.hasilGreeting2, this.hasilParking2, this.hasilPreBushing2, this.hasilSeating2, this.hasilServingProduct2, this.hasilServingTime2, this.hasilTakingOrder2, this.hasilThanking2});

  @override
  _DetailBenchmarkState createState() => _DetailBenchmarkState();
}

class _DetailBenchmarkState extends State<DetailBenchmark> {
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
          child: Scrollbar(
            child: ListView(
              shrinkWrap: true,
              physics: ScrollPhysics(),
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
                          'Benchmark',
                          style: TextStyle(
                              color: AbubaPallate.greenabuba, fontSize: 12.0),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  color: Colors.white,
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding:
                            const EdgeInsets.only(left: 13.0, right: 15.0, top: 10.0),
                        child: Row(
                          children: <Widget>[
                            Flexible(
                              child: Text(
                                'OUTLET BENCHMARK',
                                style: TextStyle(
                                    fontSize: 14.0,
                                    fontWeight: FontWeight.w700,
                                    color: AbubaPallate.greenabuba),
                              ),
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 13.0),
                        child: Row(
                          children: <Widget>[
                            Flexible(
                              child: Text(
                                '${widget.selectedOutletTanggal[0]} - ${widget.selectedOutletTanggal[1]}',
                                style:
                                    TextStyle(fontSize: 12.0, color: Colors.black38),
                              ),
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 13.0),
                        child: Row(
                          children: <Widget>[
                            Flexible(
                              child: Text(
                                '${widget.selectedOutlet[0]} VS ${widget.selectedOutlet[1]}',
                                style:
                                    TextStyle(fontSize: 12.0, color: Colors.black38),
                              ),
                            )
                          ],
                        ),
                      ),
                      ExpansionTile(
                        title: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Flexible(
                                  child: Text(
                                    'Parking',
                                    style: TextStyle(
                                        fontSize: 14.0, fontWeight: FontWeight.w700),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        children: <Widget>[
                          Column(
                            children: <Widget>[
                              Container(
                                alignment: Alignment.centerLeft,
                                child: Column(
                                  children: <Widget>[
                                    Container(
                                      padding: const EdgeInsets.symmetric(horizontal: 17.0, vertical: 0.0),
                                      width: MediaQuery.of(context).size.width,
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        widget.selectedOutlet[0],
                                        style: TextStyle(
                                          fontSize: 14.0,
                                          color: Colors.black54
                                        ),
                                      ),
                                    ),
                                    LinearPercentIndicator(
                                      padding: const EdgeInsets.symmetric(horizontal: 17.0, vertical: 0.0),
                                      width: MediaQuery.of(context).size.width,
                                      animation: true,
                                      lineHeight: 20.0,
                                      percent: widget.hasilParking * 100 > 100.0 ? 1.0 : widget.hasilParking,
                                      center: Text(
                                        widget.hasilParking * 100 >= 100.0 ? '100%' : '${(widget.hasilParking * 100).toString().substring(0, 2)}%'
                                      ),
                                      animationDuration: 1000,
                                      linearStrokeCap: LinearStrokeCap.butt,
                                      progressColor: widget.hasilParking * 100 > 85.0 ? Colors.green : widget.hasilParking * 100 < 70.0 ? Colors.redAccent : Colors.orangeAccent,
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                alignment: Alignment.centerLeft,
                                child: Column(
                                  children: <Widget>[
                                    Container(
                                      padding: const EdgeInsets.symmetric(horizontal: 17.0, vertical: 0.0),
                                      width: MediaQuery.of(context).size.width,
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        widget.selectedOutlet[1],
                                        style: TextStyle(
                                          fontSize: 14.0,
                                          color: Colors.black54
                                        ),
                                      ),
                                    ),
                                    LinearPercentIndicator(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 17.0),
                                      width: MediaQuery.of(context).size.width,
                                      animation: true,
                                      lineHeight: 20.0,
                                      percent: widget.hasilParking2 * 100 > 100.0 ? 1.0 : widget.hasilParking2,
                                      center: Text(
                                        widget.hasilParking2 * 100 >= 100.0 ? '100%' : '${(widget.hasilParking2 * 100).toString().substring(0, 2)}%'
                                      ),
                                      animationDuration: 1000,
                                      linearStrokeCap: LinearStrokeCap.butt,
                                      progressColor: widget.hasilParking2 * 100 > 85.0 ? Colors.green : widget.hasilParking2 * 100 < 70.0 ? Colors.redAccent : Colors.orangeAccent,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      ExpansionTile(
                        title: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Flexible(
                                  child: Text(
                                    'Greeting',
                                    style: TextStyle(
                                        fontSize: 14.0, fontWeight: FontWeight.w700),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        children: <Widget>[
                          Column(
                            children: <Widget>[
                              Container(
                                alignment: Alignment.centerLeft,
                                child: Column(
                                  children: <Widget>[
                                    Container(
                                      padding: const EdgeInsets.symmetric(horizontal: 17.0, vertical: 0.0),
                                      width: MediaQuery.of(context).size.width,
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        widget.selectedOutlet[0],
                                        style: TextStyle(
                                          fontSize: 14.0,
                                          color: Colors.black54
                                        ),
                                      ),
                                    ),
                                    LinearPercentIndicator(
                                      padding: const EdgeInsets.symmetric(horizontal: 17.0, vertical: 0.0),
                                      width: MediaQuery.of(context).size.width,
                                      animation: true,
                                      lineHeight: 20.0,
                                      percent: widget.hasilGreeting * 100 > 100.0 ? 1.0 : widget.hasilGreeting,
                                      center: Text(
                                        widget.hasilGreeting * 100 >= 100.0 ? '100%' : '${(widget.hasilGreeting * 100).toString().substring(0, 2)}%'
                                      ),
                                      animationDuration: 1000,
                                      linearStrokeCap: LinearStrokeCap.butt,
                                      progressColor: widget.hasilGreeting * 100 > 85.0 ? Colors.green : widget.hasilGreeting * 100 < 70.0 ? Colors.redAccent : Colors.orangeAccent,
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                alignment: Alignment.centerLeft,
                                child: Column(
                                  children: <Widget>[
                                    Container(
                                      padding: const EdgeInsets.symmetric(horizontal: 17.0, vertical: 0.0),
                                      width: MediaQuery.of(context).size.width,
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        widget.selectedOutlet[1],
                                        style: TextStyle(
                                          fontSize: 14.0,
                                          color: Colors.black54
                                        ),
                                      ),
                                    ),
                                    LinearPercentIndicator(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 17.0),
                                      width: MediaQuery.of(context).size.width,
                                      animation: true,
                                      lineHeight: 20.0,
                                      percent: widget.hasilGreeting2 * 100 > 100.0 ? 1.0 : widget.hasilGreeting2,
                                      center: Text(
                                        widget.hasilGreeting2 * 100 >= 100.0 ? '100%' : '${(widget.hasilGreeting2 * 100).toString().substring(0, 2)}%'
                                      ),
                                      animationDuration: 1000,
                                      linearStrokeCap: LinearStrokeCap.butt,
                                      progressColor: widget.hasilGreeting2 * 100 > 85.0 ? Colors.green : widget.hasilGreeting2 * 100 < 70.0 ? Colors.redAccent : Colors.orangeAccent,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      ExpansionTile(
                        title: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Flexible(
                                  child: Text(
                                    'Seating',
                                    style: TextStyle(
                                        fontSize: 14.0, fontWeight: FontWeight.w700),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        children: <Widget>[
                          Column(
                            children: <Widget>[
                              Container(
                                alignment: Alignment.centerLeft,
                                child: Column(
                                  children: <Widget>[
                                    Container(
                                      padding: const EdgeInsets.symmetric(horizontal: 17.0, vertical: 0.0),
                                      width: MediaQuery.of(context).size.width,
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        widget.selectedOutlet[0],
                                        style: TextStyle(
                                          fontSize: 14.0,
                                          color: Colors.black54
                                        ),
                                      ),
                                    ),
                                    LinearPercentIndicator(
                                      padding: const EdgeInsets.symmetric(horizontal: 17.0, vertical: 0.0),
                                      width: MediaQuery.of(context).size.width,
                                      animation: true,
                                      lineHeight: 20.0,
                                      percent: widget.hasilSeating * 100 > 100.0 ? 1.0 : widget.hasilSeating,
                                      center: Text(
                                        widget.hasilSeating * 100 >= 100.0 ? '100%' : '${(widget.hasilSeating * 100).toString().substring(0, 2)}%'
                                      ),
                                      animationDuration: 1000,
                                      linearStrokeCap: LinearStrokeCap.butt,
                                      progressColor: widget.hasilSeating * 100 > 85.0 ? Colors.green : widget.hasilSeating * 100 < 70.0 ? Colors.redAccent : Colors.orangeAccent,
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                alignment: Alignment.centerLeft,
                                child: Column(
                                  children: <Widget>[
                                    Container(
                                      padding: const EdgeInsets.symmetric(horizontal: 17.0, vertical: 0.0),
                                      width: MediaQuery.of(context).size.width,
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        widget.selectedOutlet[1],
                                        style: TextStyle(
                                          fontSize: 14.0,
                                          color: Colors.black54
                                        ),
                                      ),
                                    ),
                                    LinearPercentIndicator(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 17.0),
                                      width: MediaQuery.of(context).size.width,
                                      animation: true,
                                      lineHeight: 20.0,
                                      percent: widget.hasilSeating2 * 100 > 100.0 ? 1.0 : widget.hasilSeating2,
                                      center: Text(
                                        widget.hasilSeating2 * 100 >= 100.0 ? '100%' : '${(widget.hasilSeating2 * 100).toString().substring(0, 2)}%'
                                      ),
                                      animationDuration: 1000,
                                      linearStrokeCap: LinearStrokeCap.butt,
                                      progressColor: widget.hasilSeating2 * 100 > 85.0 ? Colors.green : widget.hasilSeating2 * 100 < 70.0 ? Colors.redAccent : Colors.orangeAccent,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      ExpansionTile(
                        title: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Flexible(
                                  child: Text(
                                    'Taking Order',
                                    style: TextStyle(
                                        fontSize: 14.0, fontWeight: FontWeight.w700),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        children: <Widget>[
                          Column(
                            children: <Widget>[
                              Container(
                                alignment: Alignment.centerLeft,
                                child: Column(
                                  children: <Widget>[
                                    Container(
                                      padding: const EdgeInsets.symmetric(horizontal: 17.0, vertical: 0.0),
                                      width: MediaQuery.of(context).size.width,
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        widget.selectedOutlet[0],
                                        style: TextStyle(
                                          fontSize: 14.0,
                                          color: Colors.black54
                                        ),
                                      ),
                                    ),
                                    LinearPercentIndicator(
                                      padding: const EdgeInsets.symmetric(horizontal: 17.0, vertical: 0.0),
                                      width: MediaQuery.of(context).size.width,
                                      animation: true,
                                      lineHeight: 20.0,
                                      percent: widget.hasilTakingOrder * 100 > 100.0 ? 1.0 : widget.hasilTakingOrder,
                                      center: Text(
                                        widget.hasilTakingOrder * 100 >= 100.0 ? '100%' : '${(widget.hasilTakingOrder * 100).toString().substring(0, 2)}%'
                                      ),
                                      animationDuration: 1000,
                                      linearStrokeCap: LinearStrokeCap.butt,
                                      progressColor: widget.hasilTakingOrder * 100 > 85.0 ? Colors.green : widget.hasilTakingOrder * 100 < 70.0 ? Colors.redAccent : Colors.orangeAccent,
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                alignment: Alignment.centerLeft,
                                child: Column(
                                  children: <Widget>[
                                    Container(
                                      padding: const EdgeInsets.symmetric(horizontal: 17.0, vertical: 0.0),
                                      width: MediaQuery.of(context).size.width,
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        widget.selectedOutlet[1],
                                        style: TextStyle(
                                          fontSize: 14.0,
                                          color: Colors.black54
                                        ),
                                      ),
                                    ),
                                    LinearPercentIndicator(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 17.0),
                                      width: MediaQuery.of(context).size.width,
                                      animation: true,
                                      lineHeight: 20.0,
                                      percent: widget.hasilTakingOrder2 * 100 > 100.0 ? 1.0 : widget.hasilTakingOrder2,
                                      center: Text(
                                        widget.hasilTakingOrder2 * 100 >= 100.0 ? '100%' : '${(widget.hasilTakingOrder2 * 100).toString().substring(0, 2)}%'
                                      ),
                                      animationDuration: 1000,
                                      linearStrokeCap: LinearStrokeCap.butt,
                                      progressColor: widget.hasilTakingOrder2 * 100 > 85.0 ? Colors.green : widget.hasilTakingOrder2 * 100 < 70.0 ? Colors.redAccent : Colors.orangeAccent,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      ExpansionTile(
                        title: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Flexible(
                                  child: Text(
                                    'Serving Product',
                                    style: TextStyle(
                                        fontSize: 14.0, fontWeight: FontWeight.w700),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        children: <Widget>[
                          Column(
                            children: <Widget>[
                              Container(
                                alignment: Alignment.centerLeft,
                                child: Column(
                                  children: <Widget>[
                                    Container(
                                      padding: const EdgeInsets.symmetric(horizontal: 17.0, vertical: 0.0),
                                      width: MediaQuery.of(context).size.width,
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        widget.selectedOutlet[0],
                                        style: TextStyle(
                                          fontSize: 14.0,
                                          color: Colors.black54
                                        ),
                                      ),
                                    ),
                                    LinearPercentIndicator(
                                      padding: const EdgeInsets.symmetric(horizontal: 17.0, vertical: 0.0),
                                      width: MediaQuery.of(context).size.width,
                                      animation: true,
                                      lineHeight: 20.0,
                                      percent: widget.hasilServingProduct * 100 > 100.0 ? 1.0 : widget.hasilServingProduct,
                                      center: Text(
                                        widget.hasilServingProduct * 100 >= 100.0 ? '100%' : '${(widget.hasilServingProduct * 100).toString().substring(0, 2)}%'
                                      ),
                                      animationDuration: 1000,
                                      linearStrokeCap: LinearStrokeCap.butt,
                                      progressColor: widget.hasilServingProduct * 100 > 85.0 ? Colors.green : widget.hasilServingProduct * 100 < 70.0 ? Colors.redAccent : Colors.orangeAccent,
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                alignment: Alignment.centerLeft,
                                child: Column(
                                  children: <Widget>[
                                    Container(
                                      padding: const EdgeInsets.symmetric(horizontal: 17.0, vertical: 0.0),
                                      width: MediaQuery.of(context).size.width,
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        widget.selectedOutlet[1],
                                        style: TextStyle(
                                          fontSize: 14.0,
                                          color: Colors.black54
                                        ),
                                      ),
                                    ),
                                    LinearPercentIndicator(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 17.0),
                                      width: MediaQuery.of(context).size.width,
                                      animation: true,
                                      lineHeight: 20.0,
                                      percent: widget.hasilServingProduct2 * 100 > 100.0 ? 1.0 : widget.hasilServingProduct2,
                                      center: Text(
                                        widget.hasilServingProduct2 * 100 >= 100.0 ? '100%' : '${(widget.hasilServingProduct2 * 100).toString().substring(0, 2)}%'
                                      ),
                                      animationDuration: 1000,
                                      linearStrokeCap: LinearStrokeCap.butt,
                                      progressColor: widget.hasilServingProduct2 * 100 > 85.0 ? Colors.green : widget.hasilServingProduct2 * 100 < 70.0 ? Colors.redAccent : Colors.orangeAccent,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      ExpansionTile(
                        title: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Flexible(
                                  child: Text(
                                    'Serving Time',
                                    style: TextStyle(
                                        fontSize: 14.0, fontWeight: FontWeight.w700),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        children: <Widget>[
                          Column(
                            children: <Widget>[
                              Container(
                                alignment: Alignment.centerLeft,
                                child: Column(
                                  children: <Widget>[
                                    Container(
                                      padding: const EdgeInsets.symmetric(horizontal: 17.0, vertical: 0.0),
                                      width: MediaQuery.of(context).size.width,
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        widget.selectedOutlet[0],
                                        style: TextStyle(
                                          fontSize: 14.0,
                                          color: Colors.black54
                                        ),
                                      ),
                                    ),
                                    LinearPercentIndicator(
                                      padding: const EdgeInsets.symmetric(horizontal: 17.0, vertical: 0.0),
                                      width: MediaQuery.of(context).size.width,
                                      animation: true,
                                      lineHeight: 20.0,
                                      percent: widget.hasilServingTime * 100 > 100.0 ? 1.0 : widget.hasilServingTime,
                                      center: Text(
                                        widget.hasilServingTime * 100 >= 100.0 ? '100%' : '${(widget.hasilServingTime * 100).toString().substring(0, 2)}%'
                                      ),
                                      animationDuration: 1000,
                                      linearStrokeCap: LinearStrokeCap.butt,
                                      progressColor: widget.hasilServingTime * 100 > 85.0 ? Colors.green : widget.hasilServingTime * 100 < 70.0 ? Colors.redAccent : Colors.orangeAccent,
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                alignment: Alignment.centerLeft,
                                child: Column(
                                  children: <Widget>[
                                    Container(
                                      padding: const EdgeInsets.symmetric(horizontal: 17.0, vertical: 0.0),
                                      width: MediaQuery.of(context).size.width,
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        widget.selectedOutlet[1],
                                        style: TextStyle(
                                          fontSize: 14.0,
                                          color: Colors.black54
                                        ),
                                      ),
                                    ),
                                    LinearPercentIndicator(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 17.0),
                                      width: MediaQuery.of(context).size.width,
                                      animation: true,
                                      lineHeight: 20.0,
                                      percent: widget.hasilServingTime2 * 100 > 100.0 ? 1.0 : widget.hasilServingTime2,
                                      center: Text(
                                        widget.hasilServingTime2 * 100 >= 100.0 ? '100%' : '${(widget.hasilServingTime2 * 100).toString().substring(0, 2)}%'
                                      ),
                                      animationDuration: 1000,
                                      linearStrokeCap: LinearStrokeCap.butt,
                                      progressColor: widget.hasilServingTime2 * 100 > 85.0 ? Colors.green : widget.hasilServingTime2 * 100 < 70.0 ? Colors.redAccent : Colors.orangeAccent,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      ExpansionTile(
                        title: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Flexible(
                                  child: Text(
                                    'Cleanliness',
                                    style: TextStyle(
                                        fontSize: 14.0, fontWeight: FontWeight.w700),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        children: <Widget>[
                          Column(
                            children: <Widget>[
                              Container(
                                alignment: Alignment.centerLeft,
                                child: Column(
                                  children: <Widget>[
                                    Container(
                                      padding: const EdgeInsets.symmetric(horizontal: 17.0, vertical: 0.0),
                                      width: MediaQuery.of(context).size.width,
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        widget.selectedOutlet[0],
                                        style: TextStyle(
                                          fontSize: 14.0,
                                          color: Colors.black54
                                        ),
                                      ),
                                    ),
                                    LinearPercentIndicator(
                                      padding: const EdgeInsets.symmetric(horizontal: 17.0, vertical: 0.0),
                                      width: MediaQuery.of(context).size.width,
                                      animation: true,
                                      lineHeight: 20.0,
                                      percent: widget.hasilCleanliness * 100 > 100.0 ? 1.0 : widget.hasilCleanliness,
                                      center: Text(
                                        widget.hasilCleanliness * 100 >= 100.0 ? '100%' : '${(widget.hasilCleanliness * 100).toString().substring(0, 2)}%'
                                      ),
                                      animationDuration: 1000,
                                      linearStrokeCap: LinearStrokeCap.butt,
                                      progressColor: widget.hasilCleanliness * 100 > 85.0 ? Colors.green : widget.hasilCleanliness * 100 < 70.0 ? Colors.redAccent : Colors.orangeAccent,
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                alignment: Alignment.centerLeft,
                                child: Column(
                                  children: <Widget>[
                                    Container(
                                      padding: const EdgeInsets.symmetric(horizontal: 17.0, vertical: 0.0),
                                      width: MediaQuery.of(context).size.width,
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        widget.selectedOutlet[1],
                                        style: TextStyle(
                                          fontSize: 14.0,
                                          color: Colors.black54
                                        ),
                                      ),
                                    ),
                                    LinearPercentIndicator(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 17.0),
                                      width: MediaQuery.of(context).size.width,
                                      animation: true,
                                      lineHeight: 20.0,
                                      percent: widget.hasilCleanliness2 * 100 > 100.0 ? 1.0 : widget.hasilCleanliness2,
                                      center: Text(
                                        widget.hasilCleanliness2 * 100 >= 100.0 ? '100%' : '${(widget.hasilCleanliness2 * 100).toString().substring(0, 2)}%'
                                      ),
                                      animationDuration: 1000,
                                      linearStrokeCap: LinearStrokeCap.butt,
                                      progressColor: widget.hasilCleanliness2 * 100 > 85.0 ? Colors.green : widget.hasilCleanliness2 * 100 < 70.0 ? Colors.redAccent : Colors.orangeAccent,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      ExpansionTile(
                        title: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Flexible(
                                  child: Text(
                                    'Pre-Bushing',
                                    style: TextStyle(
                                        fontSize: 14.0, fontWeight: FontWeight.w700),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        children: <Widget>[
                          Column(
                            children: <Widget>[
                              Container(
                                alignment: Alignment.centerLeft,
                                child: Column(
                                  children: <Widget>[
                                    Container(
                                      padding: const EdgeInsets.symmetric(horizontal: 17.0, vertical: 0.0),
                                      width: MediaQuery.of(context).size.width,
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        widget.selectedOutlet[0],
                                        style: TextStyle(
                                          fontSize: 14.0,
                                          color: Colors.black54
                                        ),
                                      ),
                                    ),
                                    LinearPercentIndicator(
                                      padding: const EdgeInsets.symmetric(horizontal: 17.0, vertical: 0.0),
                                      width: MediaQuery.of(context).size.width,
                                      animation: true,
                                      lineHeight: 20.0,
                                      percent: widget.hasilPreBushing * 100 > 100.0 ? 1.0 : widget.hasilPreBushing,
                                      center: Text(
                                        widget.hasilPreBushing * 100 >= 100.0 ? '100%' : '${(widget.hasilPreBushing * 100).toString().substring(0, 2)}%'
                                      ),
                                      animationDuration: 1000,
                                      linearStrokeCap: LinearStrokeCap.butt,
                                      progressColor: widget.hasilPreBushing * 100 > 85.0 ? Colors.green : widget.hasilPreBushing * 100 < 70.0 ? Colors.redAccent : Colors.orangeAccent,
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                alignment: Alignment.centerLeft,
                                child: Column(
                                  children: <Widget>[
                                    Container(
                                      padding: const EdgeInsets.symmetric(horizontal: 17.0, vertical: 0.0),
                                      width: MediaQuery.of(context).size.width,
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        widget.selectedOutlet[1],
                                        style: TextStyle(
                                          fontSize: 14.0,
                                          color: Colors.black54
                                        ),
                                      ),
                                    ),
                                    LinearPercentIndicator(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 17.0),
                                      width: MediaQuery.of(context).size.width,
                                      animation: true,
                                      lineHeight: 20.0,
                                      percent: widget.hasilPreBushing2 * 100 > 100.0 ? 1.0 : widget.hasilPreBushing2,
                                      center: Text(
                                        widget.hasilPreBushing2 * 100 >= 100.0 ? '100%' : '${(widget.hasilPreBushing2 * 100).toString().substring(0, 2)}%'
                                      ),
                                      animationDuration: 1000,
                                      linearStrokeCap: LinearStrokeCap.butt,
                                      progressColor: widget.hasilPreBushing2 * 100 > 85.0 ? Colors.green : widget.hasilPreBushing2 * 100 < 70.0 ? Colors.redAccent : Colors.orangeAccent,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      ExpansionTile(
                        title: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Flexible(
                                  child: Text(
                                    'Billing',
                                    style: TextStyle(
                                        fontSize: 14.0, fontWeight: FontWeight.w700),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        children: <Widget>[
                          Column(
                            children: <Widget>[
                              Container(
                                alignment: Alignment.centerLeft,
                                child: Column(
                                  children: <Widget>[
                                    Container(
                                      padding: const EdgeInsets.symmetric(horizontal: 17.0, vertical: 0.0),
                                      width: MediaQuery.of(context).size.width,
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        widget.selectedOutlet[0],
                                        style: TextStyle(
                                          fontSize: 14.0,
                                          color: Colors.black54
                                        ),
                                      ),
                                    ),
                                    LinearPercentIndicator(
                                      padding: const EdgeInsets.symmetric(horizontal: 17.0, vertical: 0.0),
                                      width: MediaQuery.of(context).size.width,
                                      animation: true,
                                      lineHeight: 20.0,
                                      percent: widget.hasilBilling * 100 > 100.0 ? 1.0 : widget.hasilBilling,
                                      center: Text(
                                        widget.hasilBilling * 100 >= 100.0 ? '100%' : '${(widget.hasilBilling * 100).toString().substring(0, 2)}%'
                                      ),
                                      animationDuration: 1000,
                                      linearStrokeCap: LinearStrokeCap.butt,
                                      progressColor: widget.hasilBilling * 100 > 85.0 ? Colors.green : widget.hasilBilling * 100 < 70.0 ? Colors.redAccent : Colors.orangeAccent,
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                alignment: Alignment.centerLeft,
                                child: Column(
                                  children: <Widget>[
                                    Container(
                                      padding: const EdgeInsets.symmetric(horizontal: 17.0, vertical: 0.0),
                                      width: MediaQuery.of(context).size.width,
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        widget.selectedOutlet[1],
                                        style: TextStyle(
                                          fontSize: 14.0,
                                          color: Colors.black54
                                        ),
                                      ),
                                    ),
                                    LinearPercentIndicator(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 17.0),
                                      width: MediaQuery.of(context).size.width,
                                      animation: true,
                                      lineHeight: 20.0,
                                      percent: widget.hasilBilling2 * 100 > 100.0 ? 1.0 : widget.hasilBilling2,
                                      center: Text(
                                        widget.hasilBilling2 * 100 >= 100.0 ? '100%' : '${(widget.hasilBilling2 * 100).toString().substring(0, 2)}%'
                                      ),
                                      animationDuration: 1000,
                                      linearStrokeCap: LinearStrokeCap.butt,
                                      progressColor: widget.hasilBilling2 * 100 > 85.0 ? Colors.green : widget.hasilBilling2 * 100 < 70.0 ? Colors.redAccent : Colors.orangeAccent,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      ExpansionTile(
                        title: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Flexible(
                                  child: Text(
                                    'Thanking',
                                    style: TextStyle(
                                        fontSize: 14.0, fontWeight: FontWeight.w700),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        children: <Widget>[
                          Column(
                            children: <Widget>[
                              Container(
                                alignment: Alignment.centerLeft,
                                child: Column(
                                  children: <Widget>[
                                    Container(
                                      padding: const EdgeInsets.symmetric(horizontal: 17.0, vertical: 0.0),
                                      width: MediaQuery.of(context).size.width,
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        widget.selectedOutlet[0],
                                        style: TextStyle(
                                          fontSize: 14.0,
                                          color: Colors.black54
                                        ),
                                      ),
                                    ),
                                    LinearPercentIndicator(
                                      padding: const EdgeInsets.symmetric(horizontal: 17.0, vertical: 0.0),
                                      width: MediaQuery.of(context).size.width,
                                      animation: true,
                                      lineHeight: 20.0,
                                      percent: widget.hasilThanking * 100 > 100.0 ? 1.0 : widget.hasilThanking,
                                      center: Text(
                                        widget.hasilThanking * 100 >= 100.0 ? '100%' : '${(widget.hasilThanking * 100).toString().substring(0, 2)}%'
                                      ),
                                      animationDuration: 1000,
                                      linearStrokeCap: LinearStrokeCap.butt,
                                      progressColor: widget.hasilThanking * 100 > 85.0 ? Colors.green : widget.hasilThanking * 100 < 70.0 ? Colors.redAccent : Colors.orangeAccent,
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                alignment: Alignment.centerLeft,
                                child: Column(
                                  children: <Widget>[
                                    Container(
                                      padding: const EdgeInsets.symmetric(horizontal: 17.0, vertical: 0.0),
                                      width: MediaQuery.of(context).size.width,
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        widget.selectedOutlet[1],
                                        style: TextStyle(
                                          fontSize: 14.0,
                                          color: Colors.black54
                                        ),
                                      ),
                                    ),
                                    LinearPercentIndicator(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 17.0),
                                      width: MediaQuery.of(context).size.width,
                                      animation: true,
                                      lineHeight: 20.0,
                                      percent: widget.hasilThanking2 * 100 > 100.0 ? 1.0 : widget.hasilThanking2,
                                      center: Text(
                                        widget.hasilThanking2 * 100 >= 100.0 ? '100%' : '${(widget.hasilThanking2 * 100).toString().substring(0, 2)}%'
                                      ),
                                      animationDuration: 1000,
                                      linearStrokeCap: LinearStrokeCap.butt,
                                      progressColor: widget.hasilThanking2 * 100 > 85.0 ? Colors.green : widget.hasilThanking2 * 100 < 70.0 ? Colors.redAccent : Colors.orangeAccent,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      ExpansionTile(
                        title: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Flexible(
                                  child: Text(
                                    'Complaint',
                                    style: TextStyle(
                                        fontSize: 14.0, fontWeight: FontWeight.w700),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        children: <Widget>[
                          Column(
                            children: <Widget>[
                              Container(
                                alignment: Alignment.centerLeft,
                                child: Column(
                                  children: <Widget>[
                                    Container(
                                      padding: const EdgeInsets.symmetric(horizontal: 17.0, vertical: 0.0),
                                      width: MediaQuery.of(context).size.width,
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        widget.selectedOutlet[0],
                                        style: TextStyle(
                                          fontSize: 14.0,
                                          color: Colors.black54
                                        ),
                                      ),
                                    ),
                                    LinearPercentIndicator(
                                      padding: const EdgeInsets.symmetric(horizontal: 17.0, vertical: 0.0),
                                      width: MediaQuery.of(context).size.width,
                                      animation: true,
                                      lineHeight: 20.0,
                                      percent: widget.hasilComplaint * 100 > 100.0 ? 1.0 : widget.hasilComplaint,
                                      center: Text(
                                        widget.hasilComplaint * 100 >= 100.0 ? '100%' : '${(widget.hasilComplaint * 100).toString().substring(0, 2)}%'
                                      ),
                                      animationDuration: 1000,
                                      linearStrokeCap: LinearStrokeCap.butt,
                                      progressColor: widget.hasilComplaint * 100 > 85.0 ? Colors.green : widget.hasilComplaint * 100 < 70.0 ? Colors.redAccent : Colors.orangeAccent,
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                alignment: Alignment.centerLeft,
                                child: Column(
                                  children: <Widget>[
                                    Container(
                                      padding: const EdgeInsets.symmetric(horizontal: 17.0, vertical: 0.0),
                                      width: MediaQuery.of(context).size.width,
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        widget.selectedOutlet[1],
                                        style: TextStyle(
                                          fontSize: 14.0,
                                          color: Colors.black54
                                        ),
                                      ),
                                    ),
                                    LinearPercentIndicator(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 17.0),
                                      width: MediaQuery.of(context).size.width,
                                      animation: true,
                                      lineHeight: 20.0,
                                      percent: widget.hasilComplaint2 * 100 > 100.0 ? 1.0 : widget.hasilComplaint2,
                                      center: Text(
                                        widget.hasilComplaint2 * 100 >= 100.0 ? '100%' : '${(widget.hasilComplaint2 * 100).toString().substring(0, 2)}%'
                                      ),
                                      animationDuration: 1000,
                                      linearStrokeCap: LinearStrokeCap.butt,
                                      progressColor: widget.hasilComplaint2 * 100 > 85.0 ? Colors.green : widget.hasilComplaint2 * 100 < 70.0 ? Colors.redAccent : Colors.orangeAccent,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
      //        itemCount: 10,
            ),
          ),
        ),
      ),
    );
  }
}
