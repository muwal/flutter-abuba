import 'package:flutter/material.dart';
import 'package:flutter_abuba/constant.dart';
import 'package:flutter_abuba/beranda/beranda_appbardua.dart';

class DetailReport extends StatefulWidget {
  @override
  _DetailReportState createState() => _DetailReportState();
}

class _DetailReportState extends State<DetailReport> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AbubaAppBar(),
        body: _formDetail(),
      ),
    );
  }

  Widget _formDetail() {
    return ListView(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Text(
                'Report',
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
                  'Detail',
                  style:
                      TextStyle(color: AbubaPallate.greenabuba, fontSize: 12.0),
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
                    const EdgeInsets.only(left: 12.0, right: 12.0, top: 12.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Container(
                      width: 150.0,
                      child: Row(
                        children: <Widget>[
                          Flexible(
                            child: Text(
                              'Stevani Miller',
                              style: TextStyle(
                                  fontSize: 12.0, color: Colors.black54),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: 150.0,
                      child: Row(
                        children: <Widget>[
                          Flexible(
                            child: Text(
                              '17 January 2018',
                              style: TextStyle(
                                  fontSize: 12.0, color: Colors.black54),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: 12.0, right: 12.0, bottom: 12.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Container(
                      width: 150.0,
                      child: Row(
                        children: <Widget>[
                          Flexible(
                            child: Text(
                              'Diinput oleh',
                              style: TextStyle(
                                  fontSize: 10.0, color: Colors.black38),
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      width: 150.0,
                      child: Row(
                        children: <Widget>[
                          Flexible(
                            child: Text(
                              'Department A',
                              style: TextStyle(
                                  fontSize: 10.0,
                                  color: Colors.black38,
                                  fontWeight: FontWeight.w700),
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 0.0),
                child: Divider(
                  height: 6.0,
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
                            '1. Identify Problem',
                            style: TextStyle(fontSize: 14.0),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                children: <Widget>[
                  GestureDetector(
                    onTap: () {},
                    child: Column(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 15.0, right: 15.0, bottom: 5.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Flexible(
                                child: Text(
                                  'WHAT',
                                  style: TextStyle(
                                      fontSize: 14.0,
                                      color: Colors.black54,
                                      fontWeight: FontWeight.w700),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 15.0, right: 15.0, bottom: 0.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Container(
                                width: 150.0,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: <Widget>[
                                    Flexible(
                                      child: Text(
                                        'Apa masalah yang sedang terjadi?',
                                        style: TextStyle(
                                            fontSize: 12.0,
                                            color: Colors.black54),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                width: 150.0,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: <Widget>[
                                    Flexible(
                                      child: Text(
                                        'Masalah 1',
                                        style: TextStyle(
                                            fontSize: 12.0,
                                            color: Colors.black87),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 15.0),
                          child: Divider(
                            height: 12.0,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 15.0, right: 15.0, bottom: 5.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Flexible(
                                child: Text(
                                  'WHO',
                                  style: TextStyle(
                                      fontSize: 14.0,
                                      color: Colors.black54,
                                      fontWeight: FontWeight.w700),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 15.0, right: 15.0, bottom: 0.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Container(
                                width: 150.0,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: <Widget>[
                                    Flexible(
                                      child: Text(
                                        'Siapa yang terlibat dengan masalah ini?',
                                        style: TextStyle(
                                            fontSize: 12.0,
                                            color: Colors.black54),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                width: 150.0,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: <Widget>[
                                    Flexible(
                                      child: Text(
                                        'Cashier',
                                        style: TextStyle(
                                            fontSize: 12.0,
                                            color: Colors.black87),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 15.0),
                          child: Divider(
                            height: 12.0,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 15.0, right: 15.0, bottom: 5.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Flexible(
                                child: Text(
                                  'WHEN',
                                  style: TextStyle(
                                      fontSize: 14.0,
                                      color: Colors.black54,
                                      fontWeight: FontWeight.w700),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 15.0, right: 15.0, bottom: 0.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Container(
                                width: 150.0,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: <Widget>[
                                    Flexible(
                                      child: Text(
                                        'Kapan masalah ini terjadi?',
                                        style: TextStyle(
                                            fontSize: 12.0,
                                            color: Colors.black54),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                width: 150.0,
                                child: Column(
                                  children: <Widget>[
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: <Widget>[
                                        Flexible(
                                          child: Text(
                                            '01 January 2019',
                                            style: TextStyle(
                                                fontSize: 12.0,
                                                color: Colors.black87),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: <Widget>[
                                        Flexible(
                                          child: Text(
                                            '08:00 - Shift A',
                                            style: TextStyle(
                                                fontSize: 12.0,
                                                color: Colors.black87),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 15.0),
                          child: Divider(
                            height: 12.0,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 15.0, right: 15.0, bottom: 5.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Flexible(
                                child: Text(
                                  'WHERE',
                                  style: TextStyle(
                                      fontSize: 14.0,
                                      color: Colors.black54,
                                      fontWeight: FontWeight.w700),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 15.0, right: 15.0, bottom: 0.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Container(
                                width: 150.0,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: <Widget>[
                                    Flexible(
                                      child: Text(
                                        'Dimana lokasi masalah ditemukan?',
                                        style: TextStyle(
                                            fontSize: 12.0,
                                            color: Colors.black54),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                width: 150.0,
                                child: Column(
                                  children: <Widget>[
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: <Widget>[
                                        Flexible(
                                          child: Text(
                                            'Department A',
                                            style: TextStyle(
                                                fontSize: 12.0,
                                                color: Colors.black87),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: <Widget>[
                                        Flexible(
                                          child: Text(
                                            'Divisi A - Area A',
                                            style: TextStyle(
                                                fontSize: 12.0,
                                                color: Colors.black87),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 15.0),
                          child: Divider(
                            height: 12.0,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 15.0, right: 15.0, bottom: 5.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Flexible(
                                child: Text(
                                  'WHY',
                                  style: TextStyle(
                                      fontSize: 14.0,
                                      color: Colors.black54,
                                      fontWeight: FontWeight.w700),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 15.0, right: 15.0, bottom: 0.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Container(
                                width: 150.0,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: <Widget>[
                                    Flexible(
                                      child: Text(
                                        'Mengapa temuan / issue ini bisa menjadi masalah. Apa konsekuensi dari masalah ini?',
                                        style: TextStyle(
                                            fontSize: 12.0,
                                            color: Colors.black54),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                width: 150.0,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: <Widget>[
                                    Flexible(
                                      child: Text(
                                        'Konsekuensi A',
                                        style: TextStyle(
                                            fontSize: 12.0,
                                            color: Colors.black87),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 15.0),
                          child: Divider(
                            height: 12.0,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 15.0, right: 15.0, bottom: 5.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Flexible(
                                child: Text(
                                  'HOW SEVERE',
                                  style: TextStyle(
                                      fontSize: 14.0,
                                      color: Colors.black54,
                                      fontWeight: FontWeight.w700),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 15.0, right: 15.0, bottom: 0.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Container(
                                width: 150.0,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: <Widget>[
                                    Flexible(
                                      child: Text(
                                        'Seberapa parah akibat yang ditimbulkan dari masalah ini?',
                                        style: TextStyle(
                                            fontSize: 12.0,
                                            color: Colors.black54),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                width: 150.0,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: <Widget>[
                                    Flexible(
                                      child: Text(
                                        'Low',
                                        style: TextStyle(
                                            fontSize: 12.0,
                                            color: Colors.black87),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
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
                            '2. Identify Team',
                            style: TextStyle(fontSize: 14.0),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                children: <Widget>[
                  GestureDetector(
                    onTap: () {},
                    child: Column(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 15.0, right: 15.0, bottom: 5.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Flexible(
                                child: Text(
                                  'TEAM',
                                  style: TextStyle(
                                      fontSize: 14.0,
                                      color: Colors.black54,
                                      fontWeight: FontWeight.w700),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 15.0, right: 15.0, bottom: 0.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Container(
                                width: 150.0,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: <Widget>[
                                    Flexible(
                                      child: Text(
                                        'Apakah untuk menyelesaikan masalah ini perlu dibentuk tim khusus?',
                                        style: TextStyle(
                                            fontSize: 12.0,
                                            color: Colors.black54),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                width: 150.0,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: <Widget>[
                                    Flexible(
                                      child: Text(
                                        'YES',
                                        style: TextStyle(
                                            fontSize: 12.0,
                                            color: Colors.green,
                                            fontWeight: FontWeight.w700
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 15.0),
                          child: Divider(
                            height: 12.0,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 15.0, right: 15.0, bottom: 5.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Flexible(
                                child: Text(
                                  'CHAMPION',
                                  style: TextStyle(
                                      fontSize: 14.0,
                                      color: Colors.black54,
                                      fontWeight: FontWeight.w700),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 15.0, right: 15.0, bottom: 0.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Container(
                                width: 150.0,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: <Widget>[
                                    Flexible(
                                      child: Text(
                                        'Mentor, mengarahkan dan membantu tim menjelaskan ke pihak management',
                                        style: TextStyle(
                                            fontSize: 12.0,
                                            color: Colors.black54),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                width: 150.0,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: <Widget>[
                                    Flexible(
                                      child: Text(
                                        'HRD',
                                        style: TextStyle(
                                            fontSize: 12.0,
                                            color: Colors.black87),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 15.0),
                          child: Divider(
                            height: 12.0,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 15.0, right: 15.0, bottom: 5.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Flexible(
                                child: Text(
                                  'LEADER',
                                  style: TextStyle(
                                      fontSize: 14.0,
                                      color: Colors.black54,
                                      fontWeight: FontWeight.w700),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 15.0, right: 15.0, bottom: 0.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Container(
                                width: 150.0,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: <Widget>[
                                    Flexible(
                                      child: Text(
                                        'Bertanggung jawab pada pelaksanaan teknis, mengadakan meeting, menyiapkan fasilitas pada team dan report kepada champion',
                                        style: TextStyle(
                                            fontSize: 12.0,
                                            color: Colors.black54),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                width: 150.0,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: <Widget>[
                                    Flexible(
                                      child: Text(
                                        'QA',
                                        style: TextStyle(
                                            fontSize: 12.0,
                                            color: Colors.black87),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 15.0),
                          child: Divider(
                            height: 12.0,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 15.0, right: 15.0, bottom: 5.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Flexible(
                                child: Text(
                                  'RECORD KEEPER',
                                  style: TextStyle(
                                      fontSize: 14.0,
                                      color: Colors.black54,
                                      fontWeight: FontWeight.w700),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 15.0, right: 15.0, bottom: 0.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Container(
                                width: 150.0,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: <Widget>[
                                    Flexible(
                                      child: Text(
                                        'Mencatat perkembangan penyelesaian masalah dan membuat minute of meeting',
                                        style: TextStyle(
                                            fontSize: 12.0,
                                            color: Colors.black54),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                width: 150.0,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: <Widget>[
                                    Flexible(
                                      child: Text(
                                        'QA',
                                        style: TextStyle(
                                            fontSize: 12.0,
                                            color: Colors.black87),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 15.0),
                          child: Divider(
                            height: 12.0,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 15.0, right: 15.0, bottom: 5.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Flexible(
                                child: Text(
                                  'PARTICIPANTS',
                                  style: TextStyle(
                                      fontSize: 14.0,
                                      color: Colors.black54,
                                      fontWeight: FontWeight.w700),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 15.0, right: 15.0, bottom: 0.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Container(
                                width: 150.0,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: <Widget>[
                                    Flexible(
                                      child: Text(
                                        'Memberi ide, menjalankan tugas dan melaporkan perkembangan kepada leader secara tepat waktu',
                                        style: TextStyle(
                                            fontSize: 12.0,
                                            color: Colors.black54),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                width: 150.0,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: <Widget>[
                                    Flexible(
                                      child: Text(
                                        'Sony - IT',
                                        style: TextStyle(
                                            fontSize: 12.0,
                                            color: Colors.black87),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
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
                            '3. Immediate Action',
                            style: TextStyle(fontSize: 14.0),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                children: <Widget>[
                  GestureDetector(
                    onTap: () {},
                    child: Column(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 15.0, right: 15.0, bottom: 5.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Flexible(
                                child: Text(
                                  'TINDAKAN SEGERA',
                                  style: TextStyle(
                                      fontSize: 14.0,
                                      color: Colors.black54,
                                      fontWeight: FontWeight.w700),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 15.0, right: 15.0, bottom: 0.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Container(
                                width: 150.0,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: <Widget>[
                                    Flexible(
                                      child: Text(
                                        'Tindakan apa yang harus dilakukan dengan segera agar masalah tidak membesar?',
                                        style: TextStyle(
                                            fontSize: 12.0,
                                            color: Colors.black54),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                width: 150.0,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: <Widget>[
                                    Flexible(
                                      child: Text(
                                        'Tindakan A',
                                        style: TextStyle(
                                            fontSize: 12.0,
                                            color: Colors.black87
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 15.0),
                          child: Divider(
                            height: 12.0,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 15.0, right: 15.0, bottom: 5.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Flexible(
                                child: Text(
                                  'WAKTU PELAKSANAAN',
                                  style: TextStyle(
                                      fontSize: 14.0,
                                      color: Colors.black54,
                                      fontWeight: FontWeight.w700),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 15.0, right: 15.0, bottom: 0.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Container(
                                width: 150.0,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: <Widget>[
                                    Flexible(
                                      child: Text(
                                        'Kapan tindakan tersebut akan dilaksanakan?',
                                        style: TextStyle(
                                            fontSize: 12.0,
                                            color: Colors.black54),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                width: 150.0,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: <Widget>[
                                    Flexible(
                                      child: Text(
                                        '01 January 2019',
                                        style: TextStyle(
                                            fontSize: 12.0,
                                            color: Colors.black87),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 15.0),
                          child: Divider(
                            height: 12.0,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 15.0, right: 15.0, bottom: 5.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Flexible(
                                child: Text(
                                  'PELAKSANA',
                                  style: TextStyle(
                                      fontSize: 14.0,
                                      color: Colors.black54,
                                      fontWeight: FontWeight.w700),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 15.0, right: 15.0, bottom: 0.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Container(
                                width: 150.0,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: <Widget>[
                                    Flexible(
                                      child: Text(
                                        'Siapa yang akan melakukan tindakan segera tersebut?',
                                        style: TextStyle(
                                            fontSize: 12.0,
                                            color: Colors.black54),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                width: 150.0,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: <Widget>[
                                    Flexible(
                                      child: Text(
                                        'Cashier',
                                        style: TextStyle(
                                            fontSize: 12.0,
                                            color: Colors.black87),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
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
                            '5. Corrective Action Plan',
                            style: TextStyle(fontSize: 14.0),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                children: <Widget>[
                  GestureDetector(
                    onTap: () {},
                    child: Column(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 15.0, right: 15.0, bottom: 5.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Flexible(
                                child: Text(
                                  'WHAT',
                                  style: TextStyle(
                                      fontSize: 14.0,
                                      color: Colors.black54,
                                      fontWeight: FontWeight.w700),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 15.0, right: 15.0, bottom: 0.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Container(
                                width: 150.0,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: <Widget>[
                                    Flexible(
                                      child: Text(
                                        'Apa tindakan permanen yang akan dilakukan untuk menyelesaikan masalah tersebut?',
                                        style: TextStyle(
                                            fontSize: 12.0,
                                            color: Colors.black54),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                width: 150.0,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: <Widget>[
                                    Flexible(
                                      child: Text(
                                        'Tindakan A',
                                        style: TextStyle(
                                            fontSize: 12.0,
                                            color: Colors.black87
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 15.0),
                          child: Divider(
                            height: 12.0,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 15.0, right: 15.0, bottom: 5.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Flexible(
                                child: Text(
                                  'WHO',
                                  style: TextStyle(
                                      fontSize: 14.0,
                                      color: Colors.black54,
                                      fontWeight: FontWeight.w700),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 15.0, right: 15.0, bottom: 0.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Container(
                                width: 150.0,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: <Widget>[
                                    Flexible(
                                      child: Text(
                                        'Siapa penanggung jawab dari tindakan permanen tersebut?',
                                        style: TextStyle(
                                            fontSize: 12.0,
                                            color: Colors.black54),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                width: 150.0,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: <Widget>[
                                    Flexible(
                                      child: Text(
                                        'QA',
                                        style: TextStyle(
                                            fontSize: 12.0,
                                            color: Colors.black87),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 15.0),
                          child: Divider(
                            height: 12.0,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 15.0, right: 15.0, bottom: 5.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Flexible(
                                child: Text(
                                  'WHEN',
                                  style: TextStyle(
                                      fontSize: 14.0,
                                      color: Colors.black54,
                                      fontWeight: FontWeight.w700),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 15.0, right: 15.0, bottom: 0.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Container(
                                width: 150.0,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: <Widget>[
                                    Flexible(
                                      child: Text(
                                        'Kapan tindakan permanen itu akan dijalankan?',
                                        style: TextStyle(
                                            fontSize: 12.0,
                                            color: Colors.black54),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                width: 150.0,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: <Widget>[
                                    Flexible(
                                      child: Text(
                                        '01 January 2019',
                                        style: TextStyle(
                                            fontSize: 12.0,
                                            color: Colors.black87),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),

                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 15.0),
                          child: Divider(
                            height: 12.0,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 15.0, right: 15.0, bottom: 5.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Flexible(
                                child: Text(
                                  'EFFECTIVENESS',
                                  style: TextStyle(
                                      fontSize: 14.0,
                                      color: Colors.black54,
                                      fontWeight: FontWeight.w700),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 15.0, right: 15.0, bottom: 0.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Container(
                                width: 150.0,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: <Widget>[
                                    Flexible(
                                      child: Text(
                                        'Bagaimana cara mengukur efektifitas dari tindakan permanen tersebut?',
                                        style: TextStyle(
                                            fontSize: 12.0,
                                            color: Colors.black54),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                width: 150.0,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: <Widget>[
                                    Flexible(
                                      child: Text(
                                        'Pareto',
                                        style: TextStyle(
                                            fontSize: 12.0,
                                            color: Colors.black87),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),

                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 15.0),
                          child: Divider(
                            height: 12.0,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 15.0, right: 15.0, bottom: 5.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Flexible(
                                child: Text(
                                  'VERIFICATION - WHO',
                                  style: TextStyle(
                                      fontSize: 14.0,
                                      color: Colors.black54,
                                      fontWeight: FontWeight.w700),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 15.0, right: 15.0, bottom: 0.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Container(
                                width: 150.0,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: <Widget>[
                                    Flexible(
                                      child: Text(
                                        'Siapa yang bertanggung jawab melakukan verifikasi?',
                                        style: TextStyle(
                                            fontSize: 12.0,
                                            color: Colors.black54),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                width: 150.0,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: <Widget>[
                                    Flexible(
                                      child: Text(
                                        'QA',
                                        style: TextStyle(
                                            fontSize: 12.0,
                                            color: Colors.black87),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),

                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 15.0),
                          child: Divider(
                            height: 12.0,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 15.0, right: 15.0, bottom: 5.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Flexible(
                                child: Text(
                                  'VERIFICATION - WHEN',
                                  style: TextStyle(
                                      fontSize: 14.0,
                                      color: Colors.black54,
                                      fontWeight: FontWeight.w700),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 15.0, right: 15.0, bottom: 0.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Container(
                                width: 150.0,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: <Widget>[
                                    Flexible(
                                      child: Text(
                                        'Kapan verifikasi akan dilakukan. Sebaiknya tidak lebih dari 7 hari setelah implementasi tindakan permanen',
                                        style: TextStyle(
                                            fontSize: 12.0,
                                            color: Colors.black54),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                width: 150.0,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: <Widget>[
                                    Flexible(
                                      child: Text(
                                        '01 January 2019',
                                        style: TextStyle(
                                            fontSize: 12.0,
                                            color: Colors.black87),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),

                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 15.0),
                          child: Divider(
                            height: 12.0,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 15.0, right: 15.0, bottom: 5.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Flexible(
                                child: Text(
                                  'VALIDATION - WHO',
                                  style: TextStyle(
                                      fontSize: 14.0,
                                      color: Colors.black54,
                                      fontWeight: FontWeight.w700),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 15.0, right: 15.0, bottom: 0.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Container(
                                width: 150.0,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: <Widget>[
                                    Flexible(
                                      child: Text(
                                        'Siapa yang bertanggung jawab melakukan validasi?',
                                        style: TextStyle(
                                            fontSize: 12.0,
                                            color: Colors.black54),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                width: 150.0,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: <Widget>[
                                    Flexible(
                                      child: Text(
                                        'QA',
                                        style: TextStyle(
                                            fontSize: 12.0,
                                            color: Colors.black87),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),

                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 15.0),
                          child: Divider(
                            height: 12.0,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 15.0, right: 15.0, bottom: 5.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Flexible(
                                child: Text(
                                  'VALIDATION - WHEN',
                                  style: TextStyle(
                                      fontSize: 14.0,
                                      color: Colors.black54,
                                      fontWeight: FontWeight.w700),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 15.0, right: 15.0, bottom: 0.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Container(
                                width: 150.0,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: <Widget>[
                                    Flexible(
                                      child: Text(
                                        'Kapan validasi akan dilakukan? dilakukan setelah 6 bulan pelaksanaan action plan',
                                        style: TextStyle(
                                            fontSize: 12.0,
                                            color: Colors.black54),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                width: 150.0,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: <Widget>[
                                    Flexible(
                                      child: Text(
                                        '01 January 2019',
                                        style: TextStyle(
                                            fontSize: 12.0,
                                            color: Colors.black87),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
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
                            '6. Complete Action Plan',
                            style: TextStyle(fontSize: 14.0),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                children: <Widget>[
                  GestureDetector(
                    onTap: () {},
                    child: Column(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 15.0, right: 15.0, bottom: 5.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Flexible(
                                child: Text(
                                  'RIDWAN',
                                  style: TextStyle(
                                      fontSize: 14.0,
                                      color: Colors.black54,
                                      fontWeight: FontWeight.w700),
                                ),
                              ),
                              Flexible(
                                child: Text(
                                  'LEADER',
                                  style: TextStyle(
                                      fontSize: 14.0,
                                      color: Colors.black54,
                                      fontWeight: FontWeight.w600),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 15.0, right: 15.0, bottom: 0.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Container(
                                width: 150.0,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: <Widget>[
                                    Flexible(
                                      child: Text(
                                        'Action Plan 1',
                                        style: TextStyle(
                                            fontSize: 12.0,
                                            color: Colors.black54),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                width: 150.0,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: <Widget>[
                                    Flexible(
                                      child: Text(
                                        '17 January 2019',
                                        style: TextStyle(
                                            fontSize: 12.0,
                                            color: Colors.black87
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),

                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 15.0),
                          child: Divider(
                            height: 12.0,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 15.0, right: 15.0, bottom: 5.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Flexible(
                                child: Text(
                                  'YANI',
                                  style: TextStyle(
                                      fontSize: 14.0,
                                      color: Colors.black54,
                                      fontWeight: FontWeight.w700),
                                ),
                              ),
                              Flexible(
                                child: Text(
                                  'RECORD KEEPER',
                                  style: TextStyle(
                                      fontSize: 14.0,
                                      color: Colors.black54,
                                      fontWeight: FontWeight.w600),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 15.0, right: 15.0, bottom: 8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Container(
                                width: 150.0,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: <Widget>[
                                    Flexible(
                                      child: Text(
                                        'Action Plan 1',
                                        style: TextStyle(
                                            fontSize: 12.0,
                                            color: Colors.black54),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                width: 150.0,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: <Widget>[
                                    Flexible(
                                      child: Text(
                                        '17 January 2019',
                                        style: TextStyle(
                                            fontSize: 12.0,
                                            color: Colors.black87
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        )
      ],
    );
  }
}
