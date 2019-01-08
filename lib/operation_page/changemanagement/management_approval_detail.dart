import 'package:flutter/material.dart';
import 'package:flutter_abuba/constant.dart';
import 'package:flutter_abuba/beranda/beranda_appbardua.dart';

class ManagementApprovalDetail extends StatefulWidget {
  @override
  _ManagementApprovalDetailState createState() => _ManagementApprovalDetailState();
}

class _ManagementApprovalDetailState extends State<ManagementApprovalDetail> {
  bool _note = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AbubaAppBar(),
        body: GestureDetector(
          onTap: () {
            FocusScope.of(context).requestFocus(FocusNode());
          },
          child: _bodyForm(),
        ),
      ),
    );
  }

  Widget _bodyForm() {
    return Scrollbar(
      child: ListView(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Text(
                  'Change Management',
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
                    'Approval',
                    style: TextStyle(
                        color: AbubaPallate.greenabuba, fontSize: 12.0),
                  ),
                ),
              ],
            ),
          ),
          Container(
            color: Colors.white,
            width: MediaQuery.of(context).size.width,
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.fromLTRB(12.0, 12.0, 12.0, 6.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Flexible(
                        child: Text(
                          'Informasi Umum',
                          style: TextStyle(
                              fontSize: 15.0,
                              fontWeight: FontWeight.w600,
                              color: AbubaPallate.green),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(12.0, 6.0, 12.0, 6.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Flexible(
                        child: Text(
                          'Change #',
                          style: TextStyle(fontWeight: FontWeight.w400),
                        ),
                      ),
                      Flexible(
                        child: Text(
                          '0001',
                          style: TextStyle(color: Colors.black54, fontSize: 12.0),
                        ),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(12.0, 6.0, 12.0, 6.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Flexible(
                        child: Text(
                          'Nama Pengusul',
                          style: TextStyle(fontWeight: FontWeight.w400),
                        ),
                      ),
                      Flexible(
                        child: Text(
                          'Ridwan - Internal Audit',
                          style: TextStyle(color: Colors.black54, fontSize: 12.0),
                        ),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(12.0, 6.0, 12.0, 6.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Flexible(
                        child: Text(
                          'Tanggal Usulan',
                          style: TextStyle(fontWeight: FontWeight.w400),
                        ),
                      ),
                      Flexible(
                        child: Text(
                          '17.08/2018',
                          style: TextStyle(color: Colors.black54, fontSize: 12.0),
                          textAlign: TextAlign.right,
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.only(top: 5.0),
            color: Colors.white,
            child: Divider(
              height: 3.0,
            ),
          ),
          Container(
            color: Colors.white,
            width: MediaQuery.of(context).size.width,
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.fromLTRB(12.0, 12.0, 12.0, 6.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Flexible(
                        child: Text(
                          'Informasi Perubahan',
                          style: TextStyle(
                              fontSize: 15.0,
                              fontWeight: FontWeight.w600,
                              color: AbubaPallate.green),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(12.0, 6.0, 12.0, 6.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Flexible(
                        child: Text(
                          'Tanggal Implementasi',
                          style: TextStyle(fontWeight: FontWeight.w400),
                        ),
                      ),
                      Flexible(
                        child: Text(
                          '17/09/2018',
                          style: TextStyle(color: Colors.black54, fontSize: 12.0),
                        ),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(12.0, 6.0, 12.0, 6.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Flexible(
                        child: Text(
                          'Prioritas',
                          style: TextStyle(fontWeight: FontWeight.w400),
                        ),
                      ),
                      Flexible(
                        child: Text(
                          'High',
                          style: TextStyle(color: AbubaPallate.menuBluebird, fontSize: 12.0),
                        ),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(12.0, 6.0, 12.0, 6.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Flexible(
                        child: Text(
                          'Kategori',
                          style: TextStyle(fontWeight: FontWeight.w400),
                        ),
                      ),
                      Flexible(
                        child: Text(
                          'Food Safety',
                          style: TextStyle(color: AbubaPallate.menuBluebird, fontSize: 12.0),
                        ),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(12.0, 6.0, 12.0, 6.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Flexible(
                        child: Text(
                          'Alasan Perubahan',
                          style: TextStyle(fontWeight: FontWeight.w400),
                        ),
                      ),
                      Flexible(
                        child: Text(
                          'Permintaan customer',
                          style: TextStyle(color: Colors.black54, fontSize: 12.0),
                          textAlign: TextAlign.right,
                        ),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(12.0, 6.0, 12.0, 6.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Flexible(
                        child: Text(
                          'Deskripsi Perubahan',
                          style: TextStyle(fontWeight: FontWeight.w400),
                        ),
                      ),
                      Flexible(
                        child: Text(
                          'Perubahan layout di kitchen semua outlet.',
                          style: TextStyle(color: Colors.black54, fontSize: 12.0),
                          textAlign: TextAlign.right,
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.only(top: 5.0),
            color: Colors.white,
            child: Divider(
              height: 3.0,
            ),
          ),
          Container(
            color: Colors.white,
            width: MediaQuery.of(context).size.width,
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.fromLTRB(12.0, 12.0, 12.0, 6.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Flexible(
                        child: Text(
                          'Review',
                          style: TextStyle(
                              fontSize: 15.0,
                              fontWeight: FontWeight.w600,
                              color: AbubaPallate.green),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(12.0, 6.0, 12.0, 6.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Flexible(
                        child: Text(
                          'QC',
                          style: TextStyle(fontWeight: FontWeight.w400),
                        ),
                      ),
                      Flexible(
                        child: Text(
                          'Rejected',
                          style: TextStyle(color: Colors.redAccent, fontSize: 12.0),
                        ),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(12.0, 0.0, 12.0, 6.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Flexible(
                        child: Text(
                          'Ridwan - 17/08/2018',
                          style: TextStyle(fontWeight: FontWeight.w300, fontSize: 12.0),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(12.0, 6.0, 12.0, 6.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Flexible(
                        child: Text(
                          'HRD',
                          style: TextStyle(fontWeight: FontWeight.w400),
                        ),
                      ),
                      Flexible(
                        child: Text(
                          'Approved',
                          style: TextStyle(color: Colors.black54, fontSize: 12.0),
                        ),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(12.0, 0.0, 12.0, 6.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Flexible(
                        child: Text(
                          'Rizal - 17/08/2018',
                          style: TextStyle(fontWeight: FontWeight.w300, fontSize: 12.0),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(12.0, 6.0, 12.0, 6.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Flexible(
                        child: Text(
                          'Director',
                          style: TextStyle(fontWeight: FontWeight.w400),
                        ),
                      ),
                      Flexible(
                        child: Text(
                          'NA',
                          style: TextStyle(color: Colors.black54, fontSize: 12.0),
                        ),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(12.0, 0.0, 12.0, 6.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Flexible(
                        child: Text(
                          'Andi - 17/08/2018',
                          style: TextStyle(fontWeight: FontWeight.w300, fontSize: 12.0),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(12.0, 6.0, 12.0, 6.0),
                  child: Stack(
                    alignment: AlignmentDirectional
                        .centerStart,
                    children: <Widget>[
                      Container(
                        color: Colors.grey[300],
                        height: 40.0,
                      ),
                      Container(
                        padding: EdgeInsets.only(left: 10.0),
                        child: Text(
                          'Mohon pastikan tidak ada perubahan kualitas produk',
                          style: TextStyle(
                              color: Colors.black54,
                              fontSize: 12.0),
                        ),
                        alignment: Alignment.centerLeft,
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.only(top: 5.0),
            color: Colors.white,
            child: Divider(
              height: 3.0,
            ),
          ),
          Container(
            color: Colors.white,
            width: MediaQuery.of(context).size.width,
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.fromLTRB(12.0, 6.0, 12.0, 6.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Flexible(
                        child: Text(
                          'FSTL',
                          style: TextStyle(
                              fontSize: 15.0,
                              fontWeight: FontWeight.w600,
                              color: AbubaPallate.green),
                        ),
                      ),
                      Flexible(
                        child: ButtonTheme(
                          minWidth: 50.0,
                          height: 25.0,
                          child: OutlineButton(
                            child: Text(
                              'NOTE',
                              style:
                                  TextStyle(fontSize: 13.0, color: Colors.blue),
                            ),
                            borderSide: BorderSide(color: Colors.blue, width: 1.0),
                            highlightedBorderColor: Colors.blue,
                            onPressed: () {
                              setState(() {
                                _note = !_note;                            
                              });
                            },
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                _note
                  ? Padding(
                      padding: const EdgeInsets.fromLTRB(12.0, 0.0, 12.0, 12.0),
                      child: Container(
                        color: Colors.white,
                        child: TextField(
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: 'Note',
                            hintStyle: TextStyle(fontSize: 12.0),
                          ),
                          maxLines: 3,
                          style: TextStyle(
                            color: Colors.black,
                          ),
                        ),
                      ),
                    )
                  : Container()
              ],
            ),
          ),
          Container(
              padding: const EdgeInsets.fromLTRB(12.0, 12.0, 12.0, 6.0),
              color: Colors.white,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(right: 5.0, left: 5.0),
                    child: ButtonTheme(
                      minWidth: 50.0,
                      height: 30.0,
                      child: OutlineButton(
                        child: Text(
                          'REJECT',
                          style: TextStyle(
                              fontSize: 13.0, color: Colors.redAccent),
                        ),
                        borderSide:
                            BorderSide(color: Colors.redAccent, width: 1.0),
                        highlightedBorderColor: Colors.redAccent,
                        onPressed: () {},
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 5.0),
                    child: ButtonTheme(
                      minWidth: 50.0,
                      height: 30.0,
                      child: OutlineButton(
                        child: Text(
                          'APPROVE',
                          style:
                              TextStyle(fontSize: 13.0, color: Colors.blue),
                        ),
                        borderSide: BorderSide(color: Colors.blue, width: 1.0),
                        highlightedBorderColor: Colors.blue,
                        onPressed: () {},
                      ),
                    ),
                  )
                ],
              )),
        ],
      ),
    );
  }
}
