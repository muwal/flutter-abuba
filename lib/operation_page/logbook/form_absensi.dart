import 'package:flutter/material.dart';
import 'package:flutter_abuba/constant.dart';
// import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:flutter_abuba/beranda/beranda_appbardua.dart';

class FormAbsensi extends StatefulWidget {
  @override
  _FormAbsensiState createState() => _FormAbsensiState();
}

class _FormAbsensiState extends State<FormAbsensi> {
  List<String> isiCheckbox = [
    'Karyawan 1',
    'Karyawan 2',
    'Karyawan 3',
    'Karyawan 4',
    'Karyawan 5'
  ];
  List<String> valueCheckbox = ['1', '2', '3', '4', '5'];
  List<String> selectedValue = [];
  List<String> selectedAlasan = [];

  TextEditingController controller = new TextEditingController();
  List<String> textList = [];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AbubaAppBar(),
        body: GestureDetector(
            onTap: () {
              FocusScope.of(context).requestFocus(FocusNode());
            },
            child: _buildFormMenu()),
      ),
    );
  }

  Widget _buildFormMenu() {
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
                  'Absensi',
                  style:
                      TextStyle(color: AbubaPallate.greenabuba, fontSize: 12.0),
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
                    'Sakit',
                  ),
                  Container(
                    width: 150.0,
                    child: GestureDetector(
                      child: Text(
                        'Pilih Nama',
                        style: TextStyle(
                          color: Colors.green,
                        ),
                      ),
                      onTap: () {
                        showDialog(
                            context: context,
                            builder: (context) {
                              return Checkbox(
                                  alasan: isiCheckbox,
                                  valueCheck: valueCheckbox,
                                  selectedAlasan: selectedAlasan,
                                  selectedValue: selectedValue,
                                  onSelectedAlasanListChanged: (alasans) {
                                    selectedAlasan = alasans;
                                    print(selectedAlasan);
                                  });
                            });
                      },
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 10.0,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                verticalDirection: VerticalDirection.up,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    'Izin',
                  ),
                  Container(
                    width: 150.0,
                    child: GestureDetector(
                      child: Text(
                        'Pilih Nama',
                        style: TextStyle(
                          color: Colors.green,
                        ),
                      ),
                      onTap: () {},
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 10.0,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                verticalDirection: VerticalDirection.up,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text('Alpha'),
                  Container(
                    width: 150.0,
                    child: GestureDetector(
                      child: Text(
                        'Pilih Nama',
                        style: TextStyle(
                          color: Colors.green,
                        ),
                      ),
                      onTap: () {},
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 10.0,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                verticalDirection: VerticalDirection.up,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    'Libur',
                  ),
                  Container(
                    width: 150.0,
                    child: GestureDetector(
                      child: Text(
                        'Pilih Nama',
                        style: TextStyle(
                          color: Colors.green,
                        ),
                      ),
                      onTap: () {},
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
      ],
    );
  }
}

class Checkbox extends StatefulWidget {
  Checkbox({
    this.alasan,
    this.selectedAlasan,
    this.selectedValue,
    this.onSelectedAlasanListChanged,
    this.valueCheck,
  });

  final List<String> alasan;
  final List<String> valueCheck;
  final List<String> selectedAlasan;
  final List<String> selectedValue;
  final ValueChanged<List<String>> onSelectedAlasanListChanged;

  @override
  _CheckboxState createState() => new _CheckboxState();
}

class _CheckboxState extends State<Checkbox> {
  List<String> _tempSelectedAlasan = [];
  List<String> _tempSelectedValueAlasan = [];

  @override
  void initState() {
    _tempSelectedAlasan = widget.selectedAlasan;
    _tempSelectedValueAlasan = widget.selectedValue;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        constraints: BoxConstraints(
          minHeight: 150.0,
          maxHeight: 400.0,
        ),
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 20.0, left: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Flexible(
                    child: Text(
                      'Pilih Karyawan',
                      style: TextStyle(fontSize: 16.0, color: Colors.black),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Scrollbar(
                child: ListView.builder(
                    scrollDirection: Axis.vertical,
                    itemCount: widget.alasan.length,
                    itemBuilder: (BuildContext context, int index) {
                      final AlasanValue = widget.alasan[index];
                      final ValueFinal = widget.valueCheck[index];

                      return CheckboxListTile(
                          title: Text(
                            AlasanValue,
                            style: TextStyle(fontSize: 14.0),
                          ),
                          controlAffinity: ListTileControlAffinity.leading,
                          activeColor: Colors.green,
                          value: _tempSelectedAlasan.contains(AlasanValue),
                          onChanged: (bool value) {
                            if (value) {
                              if (!_tempSelectedAlasan.contains(AlasanValue)) {
                                setState(() {
                                  _tempSelectedValueAlasan.add(ValueFinal);
                                  _tempSelectedAlasan.add(AlasanValue);
                                });
                              }
                            } else {
                              if (_tempSelectedAlasan.contains(AlasanValue)) {
                                setState(() {
                                  _tempSelectedAlasan.removeWhere(
                                      (String city) => city == AlasanValue);
                                  _tempSelectedValueAlasan.removeWhere(
                                      (String city) => city == ValueFinal);
                                });
                              }
                            }
                            widget.onSelectedAlasanListChanged(
                                _tempSelectedValueAlasan);
                          });
                    }),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  FlatButton(
                    child: new Text(
                      'OK',
                      style: TextStyle(color: Colors.green),
                    ),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
