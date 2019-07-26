import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_abuba/constant.dart';

class FormVoice extends StatefulWidget {
  final int idUser;
  final String namaUser;
  final String departmentUser;
  FormVoice({this.idUser, this.namaUser, this.departmentUser});

  @override
  _FormVoiceState createState() => _FormVoiceState();
}

class _FormVoiceState extends State<FormVoice> with TickerProviderStateMixin {
  List<Map> _listData = [{'nomor': '1'},{'nomor': '2'},{'nomor': '3'},{'nomor': '4'}];

  bool _isProccess = false;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _autoValidate = false;

  String _whoSelection;
  String _whoSelection2;
  List<String> _whoSelectedName = [];
  List<int> _whoSelectedID = [];

  TabController _cardController;
  TextEditingController customerSay = new TextEditingController();
  TextEditingController customerNeed = new TextEditingController();
  TextEditingController criticalCustomer = new TextEditingController();
  var maxid_voiceCustomer;
  var index_voiceCustomer;

  @override
  void initState() {
    super.initState();
    _cardController = new TabController(vsync: this, length: _listData.length);
    Firestore.instance.collection('dumper_voiceCustomer').snapshots().listen((data) {
      setState(() {
        maxid_voiceCustomer = data.documents[0].data['maxid'] + 1;
        index_voiceCustomer = data.documents[0].documentID;
      });
    });
  }

  @override
  void dispose() {
    _cardController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xFF2F592F),
        appBar: _appBar(),
        body: GestureDetector(
          onTap: () {
            FocusScope.of(context).requestFocus(FocusNode());
          },
          child: Center(
            child: Form(
              autovalidate: _autoValidate,
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: TabBarView(
                      controller: _cardController,
                      physics: NeverScrollableScrollPhysics(),
                      children: <Widget>[
                        ListView(
                          physics: ScrollPhysics(),
                          shrinkWrap: true,
                          children: <Widget>[
                            PreferredSize(
                              preferredSize: Size.fromHeight(55.0),
                              child: Column(
                                children: <Widget>[
                                  SizedBox(
                                    width: MediaQuery.of(context).size.width,
                                    height: 55.0,
                                    child: Container(
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(horizontal: 10.0),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            Text(
                                              '1. Customer Identity',
                                              style: TextStyle(color: Colors.white, fontSize: 14.0),
                                              textAlign: TextAlign.start,
                                            ),
                                            Text(
                                              '1 of ${_listData.length.toString()}',
                                              style: TextStyle(
                                                  color: Colors.white, fontSize: 14.0),
                                              textAlign: TextAlign.start,
                                            ),
                                          ],
                                        ),
                                      ),
                                      decoration: BoxDecoration(color: Color(0xFF2F592F))
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.only(top: 50.0, bottom: 20.0),
                              color: Colors.white,
                              alignment: Alignment.center,
                              height: MediaQuery.of(context).size.height * 0.7,
                              child: Column(
                                children: <Widget>[
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Flexible(
                                        child: Padding(
                                          padding: EdgeInsets.symmetric(horizontal: 10.0),
                                          child: Text(
                                            'Who is the customer ?',
                                            style: TextStyle(
                                              color: Color(0xFF2F592F),
                                              fontSize: 32.0,
                                              fontWeight: FontWeight.bold
                                            ),
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                  ListTile(
                                    title: Padding(
                                      padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                                      child: StreamBuilder(
                                        stream: Firestore.instance.collection('user').orderBy('nama', descending: false).snapshots(),
                                        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                                          if (!snapshot.hasData)
                                            return Container(
                                              child: Center(
                                                child: CircularProgressIndicator(),
                                              ),
                                            );

                                          return DropdownButtonFormField<String>(
                                            decoration: InputDecoration(
                                              labelText: 'Who',
                                              labelStyle: TextStyle(fontSize: 16.0),
                                            ),
                                            validator: (value) {
                                              if (value == null || _whoSelectedID.length == 0 || _whoSelectedName.length == 0) {
                                                return 'Please select customer';
                                              } else {
                                                return null;
                                              }
                                            },
                                            value: _whoSelection,
                                            onChanged: (String value) {
                                              Firestore.instance.collection('user').where('id', isEqualTo: int.tryParse(value)).snapshots().listen((data) {
                                                setState(() {
                                                  _whoSelection2 = data.documents[0].data['nama'];
                                                  _whoSelection = value;
                                                });
                                              });
                                            },
                                            items: snapshot.data.documents.map((DocumentSnapshot document) {
                                              return DropdownMenuItem(
                                                value: document['id'].toString(),
                                                child: Padding(
                                                  padding: EdgeInsets.all(10.0),
                                                  child: RichText(
                                                    overflow: TextOverflow.visible,
                                                    text: TextSpan(
                                                      text: document['nama'].toString(),
                                                      style: TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 14.0
                                                      )
                                                    ),
                                                  ),
                                                ),
                                              );
                                            }).toList()
                                          );
                                        },
                                      )
                                    ),
                                    trailing: IconButton(
                                      icon: Icon(Icons.add, color: AbubaPallate.greenabuba),
                                      onPressed: () {
                                        setState(() {
                                          if (_whoSelectedID.contains(int.tryParse(_whoSelection))) {

                                          } else {
                                            _whoSelectedID.add(int.tryParse(_whoSelection));
                                          }
                                          if (_whoSelectedName.contains(_whoSelection2)) {

                                          } else {
                                            _whoSelectedName.add(_whoSelection2);
                                          }
                                        });
                                      },
                                    ),
                                  ),
                                  Container(
                                    height: _whoSelectedName.length == 0 ? null : MediaQuery.of(context).size.height * 0.4,
                                    alignment: Alignment.topLeft,
                                    padding: EdgeInsets.only(top: 10.0, left: 10.0, right: 20.0),
                                    child: ListView(
                                      shrinkWrap: true,
                                      physics: ScrollPhysics(),
                                      children: <Widget>[
                                        Wrap(
                                          spacing: 4.0,
                                          runSpacing: 2.0,
                                          runAlignment: WrapAlignment.start,
                                          direction: Axis.horizontal,
                                          children: _whoSelectedName.map((String name) => Chip(
                                            label: Text(name),
                                            onDeleted: () {
                                              setState(() {
                                                _whoSelectedName.remove(name);
                                              });
                                            },
                                          )).toList(),
                                        )
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                            PreferredSize(
                              preferredSize: Size.fromHeight(MediaQuery.of(context).size.height - 55.0 - (MediaQuery.of(context).size.height * 0.7)),
                              child: Column(
                                children: <Widget>[
                                  SizedBox(
                                    width: MediaQuery.of(context).size.width,
                                    height: 55.0,
                                    child: Container(
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(horizontal: 10.0),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.end,
                                          children: <Widget>[
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: <Widget>[
                                                IconButton(
                                                  splashColor: Colors.transparent,
                                                  disabledColor: Colors.transparent,
                                                  highlightColor: Colors.transparent,
                                                  icon: Icon(Icons.arrow_forward_ios, color: Colors.white),
                                                  onPressed: () {
                                                    if (_formKey.currentState.validate() && _whoSelectedID.length > 0 && _whoSelectedName.length > 0) {
                                                      setState(() {
                                                        _autoValidate = false;
                                                      });
                                                      _cardController.animateTo(_cardController.index + 1);
                                                      _formKey.currentState.save();
                                                    } else {
                                                      setState(() {
                                                        _autoValidate = true;
                                                      });
                                                    }
                                                  },
                                                  tooltip: 'Next',
                                                ),
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                      decoration: BoxDecoration(color: Color(0xFF2F592F))
                                    ),
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                        ListView(
                          shrinkWrap: true,
                          physics: ScrollPhysics(),
                          children: <Widget>[
                            PreferredSize(
                              preferredSize: Size.fromHeight(55.0),
                              child: Column(
                                children: <Widget>[
                                  SizedBox(
                                    width: MediaQuery.of(context).size.width,
                                    height: 55.0,
                                    child: Container(
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(horizontal: 10.0),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            Text(
                                              '2. Voice of The Customer',
                                              style: TextStyle(color: Colors.white, fontSize: 14.0),
                                              textAlign: TextAlign.start,
                                            ),
                                            Text(
                                              '2 of ${_listData.length.toString()}',
                                              style: TextStyle(
                                                  color: Colors.white, fontSize: 14.0),
                                              textAlign: TextAlign.start,
                                            ),
                                          ],
                                        ),
                                      ),
                                      decoration: BoxDecoration(color: Color(0xFF2F592F))
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.only(top: 50.0, bottom: 20.0),
                              color: Colors.white,
                              alignment: Alignment.center,
                              height: MediaQuery.of(context).size.height * 0.7,
                              child: Column(
                                children: <Widget>[
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Flexible(
                                        child: Padding(
                                          padding: EdgeInsets.symmetric(horizontal: 10.0),
                                          child: Text(
                                            'What did the customer say ?',
                                            style: TextStyle(
                                              color: Color(0xFF2F592F),
                                              fontSize: 32.0,
                                              fontWeight: FontWeight.bold
                                            ),
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                  Column(
                                    children: <Widget>[
                                      Container(
                                        padding: const EdgeInsets.only(top: 20.0, left: 20.0, right: 20.0),
                                        width: MediaQuery.of(context).size.width,
                                        child: TextFormField(
                                          decoration: InputDecoration(
                                            border: OutlineInputBorder(),
                                            labelText: 'Customer Say',
                                            labelStyle: TextStyle(fontSize: 16.0)
                                          ),
                                          validator: (value) {
                                            if (value.length < 5) {
                                              return 'Customer say must be more than 5 character';
                                            } else if (value.length > 250) {
                                              return 'Customer say must be less than 250 character';
                                            } else {
                                              return null;
                                            }
                                          },
                                          textCapitalization: TextCapitalization.sentences,
                                          maxLength: 250,
                                          maxLines: 3,
                                          controller: customerSay,
                                          style: TextStyle(color: Colors.black),
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                            PreferredSize(
                              preferredSize: Size.fromHeight(MediaQuery.of(context).size.height - 55.0 - (MediaQuery.of(context).size.height * 0.7)),
                              child: Column(
                                children: <Widget>[
                                  SizedBox(
                                    width: MediaQuery.of(context).size.width,
                                    height: 55.0,
                                    child: Container(
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(horizontal: 10.0),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.end,
                                          children: <Widget>[
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: <Widget>[
                                                IconButton(
                                                  splashColor: Colors.transparent,
                                                  disabledColor: Colors.transparent,
                                                  highlightColor: Colors.transparent,
                                                  icon: Icon(Icons.arrow_back_ios, color: Colors.white),
                                                  onPressed: () {
                                                    _cardController.animateTo(_cardController.index - 1);
                                                  },
                                                  tooltip: 'Previous',
                                                ),
                                                IconButton(
                                                  splashColor: Colors.transparent,
                                                  disabledColor: Colors.transparent,
                                                  highlightColor: Colors.transparent,
                                                  icon: Icon(Icons.arrow_forward_ios, color: Colors.white),
                                                  onPressed: () {
                                                    if (_formKey.currentState.validate()) {
                                                      setState(() {
                                                        _autoValidate = false;
                                                      });
                                                      _cardController.animateTo(_cardController.index + 1);
                                                      _formKey.currentState.save();
                                                    } else {
                                                      setState(() {
                                                        _autoValidate = true;
                                                      });
                                                    }
                                                  },
                                                  tooltip: 'Next',
                                                ),
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                      decoration: BoxDecoration(color: Color(0xFF2F592F))
                                    ),
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                        ListView(
                          shrinkWrap: true,
                          physics: ScrollPhysics(),
                          children: <Widget>[
                            PreferredSize(
                              preferredSize: Size.fromHeight(55.0),
                              child: Column(
                                children: <Widget>[
                                  SizedBox(
                                    width: MediaQuery.of(context).size.width,
                                    height: 55.0,
                                    child: Container(
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(horizontal: 10.0),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            Text(
                                              '3. Key Customer Issues',
                                              style: TextStyle(color: Colors.white, fontSize: 14.0),
                                              textAlign: TextAlign.start,
                                            ),
                                            Text(
                                              '3 of ${_listData.length.toString()}',
                                              style: TextStyle(
                                                  color: Colors.white, fontSize: 14.0),
                                              textAlign: TextAlign.start,
                                            ),
                                          ],
                                        ),
                                      ),
                                      decoration: BoxDecoration(color: Color(0xFF2F592F))
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.only(top: 50.0, bottom: 20.0),
                              color: Colors.white,
                              alignment: Alignment.center,
                              height: MediaQuery.of(context).size.height * 0.7,
                              child: Column(
                                children: <Widget>[
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Flexible(
                                        child: Padding(
                                          padding: EdgeInsets.symmetric(horizontal: 10.0),
                                          child: Text(
                                            'What does the customer need ?',
                                            style: TextStyle(
                                              color: Color(0xFF2F592F),
                                              fontSize: 32.0,
                                              fontWeight: FontWeight.bold
                                            ),
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                  Column(
                                    children: <Widget>[
                                      Container(
                                        padding: const EdgeInsets.only(top: 20.0, left: 20.0, right: 20.0),
                                        width: MediaQuery.of(context).size.width,
                                        child: TextFormField(
                                          decoration: InputDecoration(
                                            border: OutlineInputBorder(),
                                            labelText: 'Customer Need',
                                            labelStyle: TextStyle(fontSize: 16.0)
                                          ),
                                          validator: (value) {
                                            if (value.length < 5) {
                                              return 'Customer need must be more than 5 character';
                                            } else if (value.length > 250) {
                                              return 'Customer need must be less than 250 character';
                                            } else {
                                              return null;
                                            }
                                          },
                                          textCapitalization: TextCapitalization.sentences,
                                          maxLength: 250,
                                          maxLines: 3,
                                          controller: customerNeed,
                                          style: TextStyle(color: Colors.black),
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                            PreferredSize(
                              preferredSize: Size.fromHeight(MediaQuery.of(context).size.height - 55.0 - (MediaQuery.of(context).size.height * 0.7)),
                              child: Column(
                                children: <Widget>[
                                  SizedBox(
                                    width: MediaQuery.of(context).size.width,
                                    height: 55.0,
                                    child: Container(
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(horizontal: 10.0),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.end,
                                          children: <Widget>[
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: <Widget>[
                                                IconButton(
                                                  splashColor: Colors.transparent,
                                                  disabledColor: Colors.transparent,
                                                  highlightColor: Colors.transparent,
                                                  icon: Icon(Icons.arrow_back_ios, color: Colors.white),
                                                  onPressed: () {
                                                    _cardController.animateTo(_cardController.index - 1);
                                                  },
                                                  tooltip: 'Previous',
                                                ),
                                                IconButton(
                                                  splashColor: Colors.transparent,
                                                  disabledColor: Colors.transparent,
                                                  highlightColor: Colors.transparent,
                                                  icon: Icon(Icons.arrow_forward_ios, color: Colors.white),
                                                  onPressed: () {
                                                    if (_formKey.currentState.validate()) {
                                                      setState(() {
                                                        _autoValidate = false;
                                                      });
                                                      _cardController.animateTo(_cardController.index + 1);
                                                      _formKey.currentState.save();
                                                    } else {
                                                      setState(() {
                                                        _autoValidate = true;
                                                      });
                                                    }
                                                  },
                                                  tooltip: 'Next',
                                                ),
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                      decoration: BoxDecoration(color: Color(0xFF2F592F))
                                    ),
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                        ListView(
                          shrinkWrap: true,
                          physics: ScrollPhysics(),
                          children: <Widget>[
                            PreferredSize(
                              preferredSize: Size.fromHeight(55.0),
                              child: Column(
                                children: <Widget>[
                                  SizedBox(
                                    width: MediaQuery.of(context).size.width,
                                    height: 55.0,
                                    child: Container(
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(horizontal: 10.0),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            Text(
                                              '4. Critical Customer Requirement',
                                              style: TextStyle(color: Colors.white, fontSize: 14.0),
                                              textAlign: TextAlign.start,
                                            ),
                                            Text(
                                              '4 of ${_listData.length.toString()}',
                                              style: TextStyle(
                                                  color: Colors.white, fontSize: 14.0),
                                              textAlign: TextAlign.start,
                                            ),
                                          ],
                                        ),
                                      ),
                                      decoration: BoxDecoration(color: Color(0xFF2F592F))
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.only(top: 50.0, bottom: 20.0),
                              color: Colors.white,
                              alignment: Alignment.center,
                              height: MediaQuery.of(context).size.height * 0.7,
                              child: Column(
                                children: <Widget>[
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Flexible(
                                        child: Padding(
                                          padding: EdgeInsets.symmetric(horizontal: 10.0),
                                          child: Text(
                                            'What resulting action is required ?',
                                            style: TextStyle(
                                              color: Color(0xFF2F592F),
                                              fontSize: 32.0,
                                              fontWeight: FontWeight.bold
                                            ),
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                  Column(
                                    children: <Widget>[
                                      Container(
                                        padding: const EdgeInsets.only(top: 20.0, left: 20.0, right: 20.0),
                                        width: MediaQuery.of(context).size.width,
                                        child: TextFormField(
                                          decoration: InputDecoration(
                                            border: OutlineInputBorder(),
                                            labelText: 'Critical Customer Requirement',
                                            labelStyle: TextStyle(fontSize: 16.0)
                                          ),
                                          validator: (value) {
                                            if (value.length < 5) {
                                              return 'Critical customer requirement must be more than 5 character';
                                            } else if (value.length > 250) {
                                              return 'Critical customer requirement must be less than 250 character';
                                            } else {
                                              return null;
                                            }
                                          },
                                          textCapitalization: TextCapitalization.sentences,
                                          maxLength: 250,
                                          maxLines: 3,
                                          controller: criticalCustomer,
                                          style: TextStyle(color: Colors.black),
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                            PreferredSize(
                              preferredSize: Size.fromHeight(MediaQuery.of(context).size.height - 55.0 - (MediaQuery.of(context).size.height * 0.7)),
                              child: Column(
                                children: <Widget>[
                                  SizedBox(
                                    width: MediaQuery.of(context).size.width,
                                    height: 55.0,
                                    child: Container(
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(horizontal: 10.0),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.end,
                                          children: <Widget>[
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: <Widget>[
                                                IconButton(
                                                  splashColor: Colors.transparent,
                                                  disabledColor: Colors.transparent,
                                                  highlightColor: Colors.transparent,
                                                  icon: Icon(Icons.arrow_back_ios, color: Colors.white),
                                                  onPressed: () {
                                                    _cardController.animateTo(_cardController.index - 1);
                                                  },
                                                  tooltip: 'Previous',
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                                                  child: GestureDetector(
                                                    onTap: () {
                                                      if (_formKey.currentState.validate()) {
                                                        setState(() {
                                                          _isProccess = true;
                                                          _autoValidate = false;
                                                        });
                                                        _formKey.currentState.save();

                                                        DocumentReference docReference = Firestore.instance.collection('voiceCustomer').document();

                                                        docReference.setData({
                                                          'userCreated': widget.idUser,
                                                          'dateCreated': DateTime.now(),
                                                          'voiceCustomerNo':maxid_voiceCustomer,
                                                          'customerID':_whoSelectedID,
                                                          'customerName':_whoSelectedName,
                                                          'customerSay':customerSay.text,
                                                          'customerNeed':customerNeed.text,
                                                          'customerCritical':criticalCustomer.text,
                                                        }).then((doc) {
                                                          setState(() {
                                                            _isProccess = false;
                                                          });

                                                          DocumentReference documentReference =Firestore.instance.collection('dumper_voiceCustomer').document(index_voiceCustomer);

                                                          documentReference.updateData({
                                                            'maxid':maxid_voiceCustomer
                                                          }).then((doc2) {
                                                            print('success');
                                                          }).catchError((error2) {
                                                            print(error2);
                                                          });

                                                          showDialog(
                                                            barrierDismissible: false,
                                                            context: context,
                                                            builder: (context) => Dialog(
                                                              child: Container(
                                                                height: 180.0,
                                                                child: Column(
                                                                  children: <Widget>[
                                                                    Container(
                                                                      color: AbubaPallate.greenabuba,
                                                                      height: 50.0,
                                                                      child: Center(
                                                                        child: Text(
                                                                          'SUCCESSFUL!',
                                                                          style: TextStyle(
                                                                            color: Colors.white,
                                                                            fontSize: 17.0,
                                                                            fontWeight: FontWeight.w700),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    SizedBox(
                                                                      height: 20.0,
                                                                    ),
                                                                    Container(
                                                                      padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
                                                                      child: Text(
                                                                        'Voice of Customer No. VOC-${maxid_voiceCustomer.toString().padLeft(4, '0')}',
                                                                        style: TextStyle(
                                                                          fontSize: 16.0,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    Row(
                                                                      mainAxisAlignment: MainAxisAlignment.end,
                                                                      children: <Widget>[
                                                                        FlatButton(
                                                                          child: Text('OK'),
                                                                          onPressed: () {
                                                                            Navigator.pop(context);
                                                                          },
                                                                        )
                                                                      ],
                                                                    )
                                                                  ],
                                                                ),
                                                              ),
                                                            )
                                                          ).whenComplete(() {
                                                            Navigator.pop(context);
                                                          });
                                                        }).catchError((error) {
                                                          print(error);
                                                        });
                                                      } else {
                                                        setState(() {
                                                          _autoValidate = true;
                                                        });
                                                      }
                                                    },
                                                    child: Tooltip(
                                                      message: 'Save',
                                                      child: _isProccess
                                                        ? SizedBox(
                                                            child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Colors.white), strokeWidth: 2.0,),
                                                            height: 25.0,
                                                            width: 25.0,
                                                          )
                                                        : Icon(Icons.save, color: Colors.white)
                                                    ),
                                                  ),
                                                )
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                      decoration: BoxDecoration(color: Color(0xFF2F592F))
                                    ),
                                  )
                                ],
                              ),
                            )
                          ],
                        )
                      ]
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _appBar() {
    return AppBar(
      elevation: 0.25,
      backgroundColor: Colors.white,
      iconTheme: IconThemeData(color: Colors.black),
      title: Image.asset(
        'assets/images/logo2.png',
        height: 150.0,
        width: 120.0,
      ),
    );
  }
}