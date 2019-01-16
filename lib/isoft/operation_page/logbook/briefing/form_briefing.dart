import 'package:flutter/material.dart';
import 'package:flutter_abuba/constant.dart';
import 'package:flutter_abuba/beranda/beranda_appbardua.dart';

class FormBriefing extends StatefulWidget {
  @override
  _FormBriefingState createState() => _FormBriefingState();
}

class _FormBriefingState extends State<FormBriefing> {
  String _textButton = 'Start';
  bool _start = true;
  Color _colorButton = Colors.green;

  TextEditingController controller = new TextEditingController();
  List<String> textList = [
    'Menu Baru',
    'Event',
    'Upselling',
    'Hasil Audit',
    'Pengumuman',
  ];

  List<bool> textListValue = [
    false,
    false,
    false,
    false,
    false,
  ];

  List<bool> textListNote = [
    false,
    false,
    false,
    false,
    false,
  ];

  TextEditingController _controller = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;

    return SafeArea(
      child: Scaffold(
        appBar: AbubaAppBar(),
        body: GestureDetector(
            onTap: () {
              FocusScope.of(context).requestFocus(FocusNode());
            },
            child: _buildFormMenu(width)),
      ),
    );
  }

  Widget _buildFormMenu(double width) {
    return ListView(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Text(
                'Log Book MOD',
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
                  'Briefing',
                  style:
                      TextStyle(color: AbubaPallate.greenabuba, fontSize: 12.0),
                ),
              ),
            ],
          ),
        ),
        Container(
          padding: EdgeInsets.fromLTRB(12.0, 12.0, 12.0, 12.0),
          child: ListTile(
            title: _start
                ? Container()
                : Container(
                    width: 150.0,
                    child: TextFormField(
                      textCapitalization: TextCapitalization.words,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        border: UnderlineInputBorder(),
                        labelText: 'Jumlah Peserta',
                        labelStyle: TextStyle(fontSize: 14.0),
                      ),
                      style: TextStyle(
                        fontStyle: FontStyle.normal,
                        color: Colors.black87,
                        fontSize: 14.0
                      ),
                    ),
                  ),
            trailing: ButtonTheme(
              minWidth: 50.0,
              height: 25.0,
              child: RaisedButton(
                color: _colorButton,
                child: Text(
                  _textButton,
                  style: TextStyle(
                      fontSize: 13.0, color: Colors.white),
                ),
                onPressed: () {
                  setState(() {
                    _start = !_start;
                    if (_start) {
                      _textButton = 'START';
                      _colorButton = Colors.green;
                    } else {
                      _textButton = 'END';
                      _colorButton = Colors.redAccent;
                    }
                  });
                },
              ),
            ),
            onTap: null,
          ),
        ),
        Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Flexible(
              child: ListView.builder(
                shrinkWrap: true,
                physics: ScrollPhysics(),
                itemCount: textList.length,
                itemBuilder: (BuildContext context, int index) {
                  return Column(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(top: 10.0, left: 10.0, right: 10.0),
                        child: CheckboxListTile(
                          value: textListValue[index],
                          onChanged: (bool value) {
                            setState(() {
                              textListValue[index] = !textListValue[index];
                            });
                          },
                          title: new Text(textList[index]),
                          controlAffinity: ListTileControlAffinity.leading,
                          secondary: ButtonTheme(
                            minWidth: 50.0,
                            height: 25.0,
                            child: OutlineButton(
                              child: Text(
                                'NOTE',
                                style: TextStyle(
                                  fontSize: 12.0,
                                  color: AbubaPallate.menuBluebird
                                ),
                              ),
                              borderSide: BorderSide(color: AbubaPallate.menuBluebird, width: 1.0),
                              highlightedBorderColor: AbubaPallate.menuBluebird,
                              onPressed: () {
                                setState(() {
                                  textListNote[index] = !textListNote[index];
                                });
                              },
                            ),
                          ),
                          activeColor: AbubaPallate.green,
                        ),
                      ),
                      textListNote[index]
                        ? Container(
                            width: 300.0,
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
                          )
                        : Container()
                    ],
                  );
                },
              ),
            )
          ],
        ),
        _start
          ? Container()
          : Container(
              padding: const EdgeInsets.fromLTRB(12.0, 12.0, 12.0, 12.0),
              child: ListTile(
                leading: Container(
                  width: width / 2,
                  child: TextFormField(
                    textCapitalization: TextCapitalization.words,
                    controller: _controller,
                    decoration: InputDecoration(
                      border: UnderlineInputBorder(),
                      labelText: 'New Data',
                      labelStyle: TextStyle(fontSize: 14.0),
                    ),
                    style: TextStyle(
                      fontStyle: FontStyle.normal,
                      color: Colors.black87,
                      fontSize: 14.0
                    ),
                    onSaved: null,
                  ),
                ),
                title: Padding(
                  padding: const EdgeInsets.only(right: 5.0),
                  child: IconButton(
                    icon: Icon(
                      Icons.add_circle,
                      color: Colors.green,
                      size: 30.0,
                    ),
                    onPressed: () {
                      setState(() {
                        textList.add(_controller.text);
                        textListValue.add(false);
                        textListNote.add(false);
                        _controller.clear();
                      });
                    },
                  ),
                ),
                trailing: Padding(
                  padding: const EdgeInsets.only(left: 5.0),
                  child: ButtonTheme(
                    minWidth: 50.0,
                    height: 30.0,
                    child: OutlineButton(
                      child: Text(
                        'SAVE',
                        style: TextStyle(
                          fontSize: 13.0,
                          color: Colors.green
                        ),
                      ),
                      borderSide: BorderSide(color: Colors.green, width: 1.0),
                      highlightedBorderColor: Colors.green,
                      onPressed: () {},
                    ),
                  ),
                )
              ),
            ),
      ],
    );
  }
}
