import 'package:flutter/material.dart';
import 'package:flutter_abuba/beranda/beranda_appbardua.dart';
import 'package:flutter_abuba/constant.dart';

import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:intl/intl.dart';

class FormCreate extends StatefulWidget {
  @override
  _FormCreateState createState() => _FormCreateState();
}

class _FormCreateState extends State<FormCreate> {
  bool _note = false;
  bool _notedua = false;
  bool _notetiga = false;
  bool _noteEmpat = false;
  bool _noteLima = false;
  bool _noteEnam = false;
  TextEditingController controllerNoteSatu = new TextEditingController();

  final dateFormat = DateFormat("MMMM d, yyyy");
  DateTime dateStart;
  DateTime dateEnd;
  DateTime dateSchedule;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AbubaAppBar(),
        body: GestureDetector(
          onTap: () {
            FocusScope.of(context).requestFocus(FocusNode());
          },
          child: _buildCreate(),
        ),
      ),
    );
  }

  Widget _buildCreate() {
    return Scrollbar(
      child: ListView(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Text(
                  'Creative Idea',
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
                    'Create',
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
                      const EdgeInsets.only(right: 20.0, left: 20.0, top: 16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Flexible(
                        child: Text(
                          'Creative Ideas',
                          style: TextStyle(color: AbubaPallate.green),
                        ),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(5.0, 0.0, 20.0, 8.0),
                  child: ListTile(
                    onTap: null,
                    leading: Container(
                      width: 50.0,
                      height: 50.0,
                      decoration: new BoxDecoration(
                        shape: BoxShape.circle,
                        image: new DecorationImage(
                          fit: BoxFit.fill,
                          image: NetworkImage(
                              "https://www.biography.com/.image/ar_1:1%2Cc_fill%2Ccs_srgb%2Cg_face%2Cq_auto:good%2Cw_300/MTE5NTU2MzE2NDE4MzExNjkx/jackie-chan-9542080-1-402.jpg"),
                        ),
                      ),
                    ),
                    title: Text(
                      'Meningkatkan sales sebanyak 25% lewat upselling',
                      style: TextStyle(color: Colors.black54, fontSize: 12.0),
                    ),
                    subtitle: Padding(
                      padding: const EdgeInsets.only(top: 5.0),
                      child: Text(
                        'Ridwan . Outlet Cipete . 2h',
                        style:
                            TextStyle(color: Colors.grey[500], fontSize: 10.0),
                      ),
                    ),
                    trailing: ButtonTheme(
                      minWidth: 50.0,
                      height: 20.0,
                      child: RaisedButton(
                        color: AbubaPallate.menuBluebird,
                        elevation: 0.0,
                        child: Text(
                          'Approved',
                          style: TextStyle(fontSize: 12.0, color: Colors.white),
                        ),
                        onPressed: () {},
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 15.0,
          ),
          Container(
            color: Colors.white,
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.fromLTRB(20.0, 12.0, 20.0, 0.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Flexible(
                        child: Text(
                          'Problem',
                          style: TextStyle(color: AbubaPallate.green),
                        ),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20.0, 8.0, 20.0, 12.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Flexible(
                        child: Text(
                            'Periode January – Maret 2018, sales di outlet A hanya 60% dari target. Hal ini membuat bonus karyawan menjadi berkurang 10%',
                            style: TextStyle(
                                fontSize: 12.0, color: Colors.black38)),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 15.0,
          ),
          Container(
            color: Colors.white,
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.fromLTRB(20.0, 12.0, 20.0, 0.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Flexible(
                        child: Text(
                          'Akar Masalah',
                          style: TextStyle(color: AbubaPallate.green),
                        ),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 0.0),
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    child: TextField(
                      maxLines: null,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        labelText: 'Man',
                        labelStyle: TextStyle(fontSize: 12.0),
                      ),
                      textCapitalization: TextCapitalization.sentences,
                      style: TextStyle(
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 0.0),
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    child: TextField(
                      maxLines: null,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        labelText: 'Material',
                        labelStyle: TextStyle(fontSize: 12.0),
                      ),
                      textCapitalization: TextCapitalization.sentences,
                      style: TextStyle(
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 0.0),
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    child: TextField(
                      maxLines: null,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        labelText: 'Method',
                        labelStyle: TextStyle(fontSize: 12.0),
                      ),
                      textCapitalization: TextCapitalization.sentences,
                      style: TextStyle(
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 20.0),
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    child: TextField(
                      maxLines: null,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        labelText: 'Environment',
                        labelStyle: TextStyle(fontSize: 12.0),
                      ),
                      textCapitalization: TextCapitalization.sentences,
                      style: TextStyle(
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 15.0,
          ),
          Container(
            color: Colors.white,
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.fromLTRB(20.0, 12.0, 20.0, 0.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Flexible(
                        child: Text(
                          'Ide',
                          style: TextStyle(color: AbubaPallate.green),
                        ),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 8.0),
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    child: TextField(
                      maxLines: null,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        labelText: 'Deskripsi',
                        labelStyle: TextStyle(fontSize: 12.0),
                      ),
                      textCapitalization: TextCapitalization.sentences,
                      style: TextStyle(
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 3.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Container(
                        width: 150.0,
                        child: TextField(
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            labelText: 'Financial Improvement',
                            labelStyle: TextStyle(fontSize: 12.0),
                          ),
                          textCapitalization: TextCapitalization.sentences,
                          style: TextStyle(
                            color: Colors.black,
                          ),
                        ),
                      ),
                      Container(
                        width: 150.0,
                        child: DateTimePickerFormField(
                          format: dateFormat,
                          onChanged: (dt) => setState(() => dateStart = dt),
                          dateOnly: true,
                          style: TextStyle(fontSize: 14.0, color: Colors.black),
                          decoration: InputDecoration(
                              border: UnderlineInputBorder(),
                              labelStyle: TextStyle(fontSize: 12.0),
                              labelText: 'Tanggal'),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      ButtonTheme(
                        minWidth: 30.0,
                        height: 25.0,
                        child: OutlineButton(
                          child: Text(
                            'Note',
                            style: TextStyle(
                                fontSize: 12.0,
                                color: AbubaPallate.menuBluebird),
                          ),
                          borderSide:
                              BorderSide(color: AbubaPallate.menuBluebird),
                          onPressed: () {
                            setState(() {
                              _note = !_note;
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 0.0),
                  child: _note
                      ? Container(
                          width: 330.0,
                          child: TextField(
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                            ),
                            controller: controllerNoteSatu,
                            maxLines: 3,
                            style: TextStyle(
                              color: Colors.black,
                            ),
                          ),
                        )
                      : Container(),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 3.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Container(
                        width: 150.0,
                        child: TextField(
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            labelText: 'Financial Saving',
                            labelStyle: TextStyle(fontSize: 12.0),
                          ),
                          textCapitalization: TextCapitalization.sentences,
                          style: TextStyle(
                            color: Colors.black,
                          ),
                        ),
                      ),
                      Container(
                        width: 150.0,
                        child: DateTimePickerFormField(
                          format: dateFormat,
                          onChanged: (dt) => setState(() => dateStart = dt),
                          dateOnly: true,
                          style: TextStyle(fontSize: 14.0, color: Colors.black),
                          decoration: InputDecoration(
                              border: UnderlineInputBorder(),
                              labelStyle: TextStyle(fontSize: 12.0),
                              labelText: 'Tanggal'),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      ButtonTheme(
                        minWidth: 30.0,
                        height: 25.0,
                        child: OutlineButton(
                          child: Text(
                            'Note',
                            style: TextStyle(
                                fontSize: 12.0,
                                color: AbubaPallate.menuBluebird),
                          ),
                          borderSide:
                              BorderSide(color: AbubaPallate.menuBluebird),
                          onPressed: () {
                            setState(() {
                              _notedua = !_notedua;
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 0.0),
                  child: _notedua
                      ? Container(
                          width: 330.0,
                          child: TextField(
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                            ),
                            controller: controllerNoteSatu,
                            maxLines: 3,
                            style: TextStyle(
                              color: Colors.black,
                            ),
                          ),
                        )
                      : Container(),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 3.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Container(
                        width: 150.0,
                        child: TextField(
                          maxLines: null,
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                            labelText: 'Quality',
                            labelStyle: TextStyle(fontSize: 12.0),
                          ),
                          textCapitalization: TextCapitalization.sentences,
                          style: TextStyle(
                            color: Colors.black,
                          ),
                        ),
                      ),
                      Container(
                        width: 150.0,
                        child: DateTimePickerFormField(
                          format: dateFormat,
                          onChanged: (dt) => setState(() => dateStart = dt),
                          dateOnly: true,
                          style: TextStyle(fontSize: 14.0, color: Colors.black),
                          decoration: InputDecoration(
                              border: UnderlineInputBorder(),
                              labelStyle: TextStyle(fontSize: 12.0),
                              labelText: 'Tanggal'),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      ButtonTheme(
                        minWidth: 30.0,
                        height: 25.0,
                        child: OutlineButton(
                          child: Text(
                            'Note',
                            style: TextStyle(
                                fontSize: 12.0,
                                color: AbubaPallate.menuBluebird),
                          ),
                          borderSide:
                              BorderSide(color: AbubaPallate.menuBluebird),
                          onPressed: () {
                            setState(() {
                              _notetiga = !_notetiga;
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 20.0),
                  child: _notetiga
                      ? Container(
                          width: 330.0,
                          child: TextField(
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                            ),
                            controller: controllerNoteSatu,
                            maxLines: 3,
                            style: TextStyle(
                              color: Colors.black,
                            ),
                          ),
                        )
                      : Container(),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 15.0,
          ),
          Container(
            color: Colors.white,
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.fromLTRB(20.0, 12.0, 20.0, 0.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Flexible(
                        child: Text(
                          'Timeline',
                          style: TextStyle(color: AbubaPallate.green),
                        ),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 0.0),
                  child: Container(
                    child: DateTimePickerFormField(
                      format: dateFormat,
                      onChanged: (dt) => setState(() => dateStart = dt),
                      dateOnly: true,
                      style: TextStyle(fontSize: 14.0, color: Colors.black),
                      decoration: InputDecoration(
                          border: UnderlineInputBorder(),
                          labelStyle: TextStyle(fontSize: 12.0),
                          labelText: 'Define'),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 0.0),
                  child: Container(
                    child: DateTimePickerFormField(
                      format: dateFormat,
                      onChanged: (dt) => setState(() => dateStart = dt),
                      dateOnly: true,
                      style: TextStyle(fontSize: 14.0, color: Colors.black),
                      decoration: InputDecoration(
                          border: UnderlineInputBorder(),
                          labelStyle: TextStyle(fontSize: 12.0),
                          labelText: 'Measure'),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 0.0),
                  child: Container(
                    child: DateTimePickerFormField(
                      format: dateFormat,
                      onChanged: (dt) => setState(() => dateStart = dt),
                      dateOnly: true,
                      style: TextStyle(fontSize: 14.0, color: Colors.black),
                      decoration: InputDecoration(
                          border: UnderlineInputBorder(),
                          labelStyle: TextStyle(fontSize: 12.0),
                          labelText: 'Analysis'),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 0.0),
                  child: Container(
                    child: DateTimePickerFormField(
                      format: dateFormat,
                      onChanged: (dt) => setState(() => dateStart = dt),
                      dateOnly: true,
                      style: TextStyle(fontSize: 14.0, color: Colors.black),
                      decoration: InputDecoration(
                          border: UnderlineInputBorder(),
                          labelStyle: TextStyle(fontSize: 12.0),
                          labelText: 'Improve'),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 20.0),
                  child: Container(
                    child: DateTimePickerFormField(
                      format: dateFormat,
                      onChanged: (dt) => setState(() => dateStart = dt),
                      dateOnly: true,
                      style: TextStyle(fontSize: 14.0, color: Colors.black),
                      decoration: InputDecoration(
                          border: UnderlineInputBorder(),
                          labelStyle: TextStyle(fontSize: 12.0),
                          labelText: 'Control'),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 15.0,
          ),
          Container(
            color: Colors.white,
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.fromLTRB(20.0, 12.0, 20.0, 0.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Flexible(
                        child: Text(
                          'Hasil',
                          style: TextStyle(color: AbubaPallate.green),
                        ),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 3.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Container(
                        width: 150.0,
                        child: TextField(
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            labelText: 'Financial Improvement',
                            labelStyle: TextStyle(fontSize: 12.0),
                          ),
                          textCapitalization: TextCapitalization.sentences,
                          style: TextStyle(
                            color: Colors.black,
                          ),
                        ),
                      ),
                      Container(
                        width: 150.0,
                        child: DateTimePickerFormField(
                          format: dateFormat,
                          onChanged: (dt) => setState(() => dateStart = dt),
                          dateOnly: true,
                          style: TextStyle(fontSize: 14.0, color: Colors.black),
                          decoration: InputDecoration(
                              border: UnderlineInputBorder(),
                              labelStyle: TextStyle(fontSize: 12.0),
                              labelText: 'Tanggal'),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      ButtonTheme(
                        minWidth: 30.0,
                        height: 25.0,
                        child: OutlineButton(
                          child: Text(
                            'Note',
                            style: TextStyle(
                                fontSize: 12.0,
                                color: AbubaPallate.menuBluebird),
                          ),
                          borderSide:
                              BorderSide(color: AbubaPallate.menuBluebird),
                          onPressed: () {
                            setState(() {
                              _noteEmpat = !_noteEmpat;
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 0.0),
                  child: _noteEmpat
                      ? Container(
                          width: 330.0,
                          child: TextField(
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                            ),
                            controller: controllerNoteSatu,
                            maxLines: 3,
                            style: TextStyle(
                              color: Colors.black,
                            ),
                          ),
                        )
                      : Container(),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 3.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Container(
                        width: 150.0,
                        child: TextField(
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            labelText: 'Financial Saving',
                            labelStyle: TextStyle(fontSize: 12.0),
                          ),
                          textCapitalization: TextCapitalization.sentences,
                          style: TextStyle(
                            color: Colors.black,
                          ),
                        ),
                      ),
                      Container(
                        width: 150.0,
                        child: DateTimePickerFormField(
                          format: dateFormat,
                          onChanged: (dt) => setState(() => dateStart = dt),
                          dateOnly: true,
                          style: TextStyle(fontSize: 14.0, color: Colors.black),
                          decoration: InputDecoration(
                              border: UnderlineInputBorder(),
                              labelStyle: TextStyle(fontSize: 12.0),
                              labelText: 'Tanggal'),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      ButtonTheme(
                        minWidth: 30.0,
                        height: 25.0,
                        child: OutlineButton(
                          child: Text(
                            'Note',
                            style: TextStyle(
                                fontSize: 12.0,
                                color: AbubaPallate.menuBluebird),
                          ),
                          borderSide:
                              BorderSide(color: AbubaPallate.menuBluebird),
                          onPressed: () {
                            setState(() {
                              _noteLima = !_noteLima;
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 0.0),
                  child: _noteLima
                      ? Container(
                          width: 330.0,
                          child: TextField(
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                            ),
                            controller: controllerNoteSatu,
                            maxLines: 3,
                            style: TextStyle(
                              color: Colors.black,
                            ),
                          ),
                        )
                      : Container(),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 3.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Container(
                        width: 150.0,
                        child: TextField(
                          maxLines: null,
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                            labelText: 'Quality',
                            labelStyle: TextStyle(fontSize: 12.0),
                          ),
                          textCapitalization: TextCapitalization.sentences,
                          style: TextStyle(
                            color: Colors.black,
                          ),
                        ),
                      ),
                      Container(
                        width: 150.0,
                        child: DateTimePickerFormField(
                          format: dateFormat,
                          onChanged: (dt) => setState(() => dateStart = dt),
                          dateOnly: true,
                          style: TextStyle(fontSize: 14.0, color: Colors.black),
                          decoration: InputDecoration(
                              border: UnderlineInputBorder(),
                              labelStyle: TextStyle(fontSize: 12.0),
                              labelText: 'Tanggal'),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      ButtonTheme(
                        minWidth: 30.0,
                        height: 25.0,
                        child: OutlineButton(
                          child: Text(
                            'Note',
                            style: TextStyle(
                                fontSize: 12.0,
                                color: AbubaPallate.menuBluebird),
                          ),
                          borderSide:
                              BorderSide(color: AbubaPallate.menuBluebird),
                          onPressed: () {
                            setState(() {
                              _noteEnam = !_noteEnam;
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 15.0),
                  child: _noteEnam
                      ? Container(
                          width: 330.0,
                          child: TextField(
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                            ),
                            controller: controllerNoteSatu,
                            maxLines: 3,
                            style: TextStyle(
                              color: Colors.black,
                            ),
                          ),
                        )
                      : Container(),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 15.0,
          ),
          Container(
            color: Colors.white,
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 0.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Flexible(
                        child: Text(
                          'Comments',
                          style: TextStyle(color: Colors.grey),
                        ),
                      ),
                      SizedBox(
                        width: 8.0,
                      ),
                      Flexible(
                        child: Text(
                          '200',
                          style: TextStyle(color: AbubaPallate.green),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(5.0, 8.0, 5.0, 8.0),
                  child: ListTile(
                    leading: Container(
                      width: 35.0,
                      height: 35.0,
                      decoration: new BoxDecoration(
                        shape: BoxShape.circle,
                        image: new DecorationImage(
                          fit: BoxFit.fill,
                          image: NetworkImage(
                              "https://www.biography.com/.image/ar_1:1%2Cc_fill%2Ccs_srgb%2Cg_face%2Cq_auto:good%2Cw_300/MTE5NTU2MzE2NDE4MzExNjkx/jackie-chan-9542080-1-402.jpg"),
                        ),
                      ),
                    ),
                    title: Container(
                      width: 150.0,
                      child: TextField(
                        maxLines: null,
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                          hintText: 'Sampaikan komentar Anda',
                          hintStyle: TextStyle(fontSize: 12.0),
                        ),
                        textCapitalization: TextCapitalization.sentences,
                        style: TextStyle(
                          color: Colors.black,
                        ),
                      ),
                    ),
                    trailing: ButtonTheme(
                      minWidth: 50.0,
                      height: 20.0,
                      child: RaisedButton(
                        color: AbubaPallate.greenabuba,
                        splashColor: AbubaPallate.greensatu,
                        child: Text(
                          'Kirim',
                          style: TextStyle(fontSize: 12.0, color: Colors.white),
                        ),
                        onPressed: () {},
                      ),
                    ),
                    onTap: null,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Divider(
                    height: 8.0,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(5.0, 8.0, 5.0, 0.0),
                  child: ListTile(
                    leading: Container(
                      width: 35.0,
                      height: 35.0,
                      decoration: new BoxDecoration(
                        shape: BoxShape.circle,
                        image: new DecorationImage(
                          fit: BoxFit.fill,
                          image: NetworkImage(
                              "https://www.biography.com/.image/ar_1:1%2Cc_fill%2Ccs_srgb%2Cg_face%2Cq_auto:good%2Cw_300/MTE5NTU2MzE2NDE4MzExNjkx/jackie-chan-9542080-1-402.jpg"),
                        ),
                      ),
                    ),
                    title: Text(
                      'OK Siap, saya pasti datang paling pagi sebelum yang laindating. Udah nggak sabar nih buat merayakan ultah ABUBA !',
                      style: TextStyle(color: Colors.black54, fontSize: 12.0),
                    ),
                    subtitle: Padding(
                      padding: const EdgeInsets.only(top: 5.0),
                      child: Text(
                        'Ridwan . IT . 3 months ago',
                        style:
                            TextStyle(color: Colors.grey[500], fontSize: 10.0),
                      ),
                    ),
                    onTap: null,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(5.0, 0.0, 5.0, 0.0),
                  child: ListTile(
                    leading: Container(
                      width: 35.0,
                      height: 35.0,
                      decoration: new BoxDecoration(
                        shape: BoxShape.circle,
                        image: new DecorationImage(
                          fit: BoxFit.fill,
                          image: NetworkImage(
                              "https://www.biography.com/.image/ar_1:1%2Cc_fill%2Ccs_srgb%2Cg_face%2Cq_auto:good%2Cw_300/MTE5NTU2MzE2NDE4MzExNjkx/jackie-chan-9542080-1-402.jpg"),
                        ),
                      ),
                    ),
                    title: Text(
                      'Mantap!',
                      style: TextStyle(color: Colors.black54, fontSize: 12.0),
                    ),
                    subtitle: Padding(
                      padding: const EdgeInsets.only(top: 5.0),
                      child: Text(
                        'Kurniawan . HRD . 3 months ago',
                        style:
                            TextStyle(color: Colors.grey[500], fontSize: 10.0),
                      ),
                    ),
                    onTap: null,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
