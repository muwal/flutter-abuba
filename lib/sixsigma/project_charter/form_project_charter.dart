import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_abuba/constant.dart';
import 'package:intl/intl.dart';

class FormProjectCharter extends StatefulWidget {
  @override
  _FormProjectCharterState createState() => _FormProjectCharterState();
}

class _FormProjectCharterState extends State<FormProjectCharter> with TickerProviderStateMixin {
  List<Map> _listData = [ {'nomor': '1'}, {'nomor': '2'}, {'nomor': '3'}, {'nomor': '4'}, {'nomor': '5'}, {'nomor': '6'}, {'nomor': '7'}, {'nomor': '8'}, {'nomor': '9'}];

  String _projectSponsorSelection;
  String _projectSponsor;
  List<Map> _projectSponsorJson = [
    {"id": 1, "projectSponsor": "Sponsor 1"},
    {"id": 2, "projectSponsor": "Sponsor 2"},
  ];

  String _projectManagerSelection;
  String _projectManager;
  List<Map> _projectManagerJson = [
    {"id": 1, "projectManager": "Robert"},
    {"id": 2, "projectManager": "Jessica"},
  ];

  String _departmentSelection;
  String _department;
  List<Map> _departmentJson = [
    {"id": 1, "department": "HRD"},
    {"id": 2, "department": "Operation"},
  ];

  String _processImpactedSelection;
  String _processImpacted;
  List<Map> _processImpactedJson = [
    {"id": 1, "processImpacted": "Process Impacted 1"},
    {"id": 2, "processImpacted": "Process Impacted 2"},
  ];

  String _greenBeltSelection;
  String _greenBelt;
  List<Map> _greenBeltJson = [
    {"id": 1, "greenBelt": "Green Belt 1"},
    {"id": 2, "greenBelt": "Green Belt 2"},
  ];

  String _blackBeltSelection;
  String _blackBelt;
  List<Map> _blackBeltJson = [
    {"id": 1, "blackBelt": "Black Belt 1"},
    {"id": 2, "blackBelt": "Black Belt 2"},
  ];

  String _goalsSelection;
  String _goals;
  List<Map> _goalsJson = [
    {"id": 1, "goals": "IDR"},
    {"id": 2, "goals": "USD"},
    {"id": 3, "goals": "Ton"},
    {"id": 4, "goals": "Kg"},
  ];

  String _projectTeamSelection;
  String _projectTeam;
  List<Map> _projectTeamJson = [
    {"id": 1, "projectTeam": "Team 1"},
    {"id": 2, "projectTeam": "Team 2"},
    {"id": 3, "projectTeam": "Team 3"},
    {"id": 4, "projectTeam": "Team 4"},
  ];
  List<String> _projectTeamSelected = [];

  String _supportResourcesSelection;
  String _supportResources;
  List<Map> _supportResourcesJson = [
    {"id": 1, "supportResources": "Support 1"},
    {"id": 2, "supportResources": "Support 2"},
    {"id": 3, "supportResources": "Support 3"},
    {"id": 4, "supportResources": "Support 4"},
  ];
  List<String> _supportResourcesSelected = [];

  String _specialNeedsSelection;
  String _specialNeeds;
  List<Map> _specialNeedsJson = [
    {"id": 1, "specialNeeds": "Special Need 1"},
    {"id": 2, "specialNeeds": "Special Need 2"},
    {"id": 3, "specialNeeds": "Special Need 3"},
    {"id": 4, "specialNeeds": "Special Need 4"},
  ];
  List<String> _specialNeedsSelected = [];

  String _costTypeSelection;
  String _costType;
  List<Map> _costTypeJson = [
    {"id": 1, "costType": "Asset"},
    {"id": 2, "costType": "Transportation"},
    {"id": 3, "costType": "Labor"},
  ];

  String _vendorSelection;
  String _vendor;
  List<Map> _vendorJson = [
    {"id": 1, "vendor": "PT Vendor"},
    {"id": 2, "vendor": "PT Buyer"},
  ];

  String _processOwnerSelection;
  String _processOwner;
  List<Map> _processOwnerJson = [
    {"id": 1, "processOwner": "Ridwan"},
    {"id": 2, "processOwner": "Sony"},
    {"id": 3, "processOwner": "Rijal"},
  ];
  
  String _keyStakeholdersSelection;
  String _keyStakeholders;
  List<Map> _keyStakeholdersJson = [
    {"id": 1, "keyStakeholders": "Supplier"},
    {"id": 2, "keyStakeholders": "Customer"},
  ];
  
  String _finalCustomerSelection;
  String _finalCustomer;
  List<Map> _finalCustomerJson = [
    {"id": 1, "finalCustomer": "Department A"},
    {"id": 2, "finalCustomer": "Department B"},
  ];

  String _typeOfBenefitSelection;
  String _typeOfBenefit;
  List<Map> _typeOfBenefitJson = [
    {"id": 1, "typeOfBenefit": "Cost Savin"},
    {"id": 2, "typeOfBenefit": "Enhanced Revenue"},
    {"id": 3, "typeOfBenefit": "Productivity"},
    {"id": 4, "typeOfBenefit": "Improve Compliance"},
    {"id": 5, "typeOfBenefit": "Better Decision Making"},
    {"id": 6, "typeOfBenefit": "Less Maintenance"},
    {"id": 7, "typeOfBenefit": "Other Costs Avoided"},
  ];

  final dateFormat = DateFormat("MMMM d, yyyy");
  DateTime dateStart;
  DateTime dateCompletion;

  TabController _cardController;

  @override
  void initState() {
    super.initState();
    _cardController = new TabController(vsync: this, length: _listData.length);
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
        backgroundColor: Colors.white,
        appBar: _appBar(),
        body: GestureDetector(
          onTap: () {
            FocusScope.of(context).requestFocus(FocusNode());
          },
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  child: TabBarView(
                    controller: _cardController,
                    physics: ScrollPhysics(),
                    children: <Widget>[
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
                                            '1. General Information',
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
                          Padding(
                            padding: const EdgeInsets.only(top: 20.0, left: 20.0, right: 20.0),
                            child: TextFormField(
                              textCapitalization: TextCapitalization.sentences,
                              decoration: InputDecoration(
                                border: UnderlineInputBorder(),
                                labelText: 'Project Name',
                                labelStyle: TextStyle(fontSize: 16.0),
                              ),
                              style: TextStyle(
                                fontStyle: FontStyle.normal,
                                color: Colors.black87,
                                fontSize: 16.0),
                              onSaved: null,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 10.0, left: 20.0, right: 20.0),
                            child: DropdownButtonFormField<String>(
                              decoration: InputDecoration(
                                labelText: 'Project Sponsor',
                                labelStyle: TextStyle(fontSize: 16.0),
                              ),
                              value: _projectSponsorSelection,
                              onChanged: (String value) {
                                setState(() {
                                  switch (int.tryParse(value)) {
                                    case 1:
                                      _projectSponsor = 'Sponsor 1';
                                      break;
                                    case 2:
                                      _projectSponsor = 'Sponsor 2';
                                      break;
                                    default:
                                      _projectSponsor = '-';
                                      break;
                                  }
                                  _projectSponsorSelection = value;
                                });
                              },
                              items: _projectSponsorJson.map((Map map) {
                                return DropdownMenuItem(
                                  value: map['id'].toString(),
                                  child: Text(map['projectSponsor'], style: TextStyle(fontSize: 16.0, color: Colors.black87, fontStyle: FontStyle.normal)),
                                );
                              }).toList(),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 10.0, left: 20.0, right: 20.0),
                            child: DropdownButtonFormField<String>(
                              decoration: InputDecoration(
                                labelText: 'Project Manager',
                                labelStyle: TextStyle(fontSize: 16.0),
                              ),
                              value: _projectManagerSelection,
                              onChanged: (String value) {
                                setState(() {
                                  switch (int.tryParse(value)) {
                                    case 1:
                                      _projectManager = 'Robert';
                                      break;
                                    case 2:
                                      _projectManager = 'Jessica';
                                      break;
                                    default:
                                      _projectManager = '-';
                                      break;
                                  }
                                  _projectManagerSelection = value;
                                });
                              },
                              items: _projectManagerJson.map((Map map) {
                                return DropdownMenuItem(
                                  value: map['id'].toString(),
                                  child: Text(map['projectManager'], style: TextStyle(fontSize: 16.0, color: Colors.black87, fontStyle: FontStyle.normal)),
                                );
                              }).toList(),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 10.0, left: 20.0, right: 20.0),
                            child: DropdownButtonFormField<String>(
                              decoration: InputDecoration(
                                labelText: 'Department',
                                labelStyle: TextStyle(fontSize: 16.0),
                              ),
                              value: _departmentSelection,
                              onChanged: (String value) {
                                setState(() {
                                  switch (int.tryParse(value)) {
                                    case 1:
                                      _department = 'HRD';
                                      break;
                                    case 2:
                                      _department = 'Operation';
                                      break;
                                    default:
                                      _department = '-';
                                      break;
                                  }
                                  _departmentSelection = value;
                                });
                              },
                              items: _departmentJson.map((Map map) {
                                return DropdownMenuItem(
                                  value: map['id'].toString(),
                                  child: Text(map['department'], style: TextStyle(fontSize: 16.0, color: Colors.black87, fontStyle: FontStyle.normal)),
                                );
                              }).toList(),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 10.0, left: 20.0, right: 20.0),
                            child: DropdownButtonFormField<String>(
                              decoration: InputDecoration(
                                labelText: 'Process Impacted',
                                labelStyle: TextStyle(fontSize: 16.0),
                              ),
                              value: _processImpactedSelection,
                              onChanged: (String value) {
                                setState(() {
                                  switch (int.tryParse(value)) {
                                    case 1:
                                      _processImpacted = 'Process Impacted 1';
                                      break;
                                    case 2:
                                      _processImpacted = 'Process Impacted 2';
                                      break;
                                    default:
                                      _processImpacted = '-';
                                      break;
                                  }
                                  _processImpactedSelection = value;
                                });
                              },
                              items: _processImpactedJson.map((Map map) {
                                return DropdownMenuItem(
                                  value: map['id'].toString(),
                                  child: Text(map['processImpacted'], style: TextStyle(fontSize: 16.0, color: Colors.black87, fontStyle: FontStyle.normal)),
                                );
                              }).toList(),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 10.0, left: 20.0, right: 20.0),
                            child: DateTimePickerFormField(
                              format: dateFormat,
                              onChanged: (dt) =>
                                  setState(() => dateStart = dt),
                              dateOnly: true,
                              style: TextStyle(
                                fontSize: 16.0,
                                color: Colors.black87,
                              ),
                              decoration: InputDecoration(
                                border: UnderlineInputBorder(),
                                labelStyle: TextStyle(fontSize: 16.0),
                                labelText: 'Expected Start Date'
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 10.0, left: 20.0, right: 20.0),
                            child: DateTimePickerFormField(
                              format: dateFormat,
                              onChanged: (dc) =>
                                  setState(() => dateCompletion = dc),
                              dateOnly: true,
                              style: TextStyle(
                                fontSize: 16.0,
                                color: Colors.black87,
                              ),
                              decoration: InputDecoration(
                                border: UnderlineInputBorder(),
                                labelStyle: TextStyle(fontSize: 16.0),
                                labelText: 'Expected Completion Date'
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 20.0, left: 20.0, right: 20.0),
                            child: TextFormField(
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                border: UnderlineInputBorder(),
                                labelText: 'Expected Savings',
                                labelStyle: TextStyle(fontSize: 16.0),
                              ),
                              style: TextStyle(
                                fontStyle: FontStyle.normal,
                                color: Colors.black87,
                                fontSize: 16.0),
                              onSaved: null,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 20.0, left: 20.0, right: 20.0),
                            child: TextFormField(
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                border: UnderlineInputBorder(),
                                labelText: 'Estimated Cost',
                                labelStyle: TextStyle(fontSize: 16.0),
                              ),
                              style: TextStyle(
                                fontStyle: FontStyle.normal,
                                color: Colors.black87,
                                fontSize: 16.0),
                              onSaved: null,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 10.0, left: 20.0, right: 20.0),
                            child: DropdownButtonFormField<String>(
                              decoration: InputDecoration(
                                labelText: 'Green Belt Assigned',
                                labelStyle: TextStyle(fontSize: 16.0),
                              ),
                              value: _greenBeltSelection,
                              onChanged: (String value) {
                                setState(() {
                                  switch (int.tryParse(value)) {
                                    case 1:
                                      _greenBelt = 'Green Belt 1';
                                      break;
                                    case 2:
                                      _greenBelt = 'Green Belt 2';
                                      break;
                                    default:
                                      _greenBelt = '-';
                                      break;
                                  }
                                  _greenBeltSelection = value;
                                });
                              },
                              items: _greenBeltJson.map((Map map) {
                                return DropdownMenuItem(
                                  value: map['id'].toString(),
                                  child: Text(map['greenBelt'], style: TextStyle(fontSize: 16.0, color: Colors.black87, fontStyle: FontStyle.normal)),
                                );
                              }).toList(),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 10.0, left: 20.0, right: 20.0, bottom: 20.0),
                            child: DropdownButtonFormField<String>(
                              decoration: InputDecoration(
                                labelText: 'Black Belt Assigned',
                                labelStyle: TextStyle(fontSize: 16.0),
                              ),
                              value: _blackBeltSelection,
                              onChanged: (String value) {
                                setState(() {
                                  switch (int.tryParse(value)) {
                                    case 1:
                                      _blackBelt = 'Black Belt 1';
                                      break;
                                    case 2:
                                      _blackBelt = 'Black Belt 2';
                                      break;
                                    default:
                                      _blackBelt = '-';
                                      break;
                                  }
                                  _blackBeltSelection = value;
                                });
                              },
                              items: _blackBeltJson.map((Map map) {
                                return DropdownMenuItem(
                                  value: map['id'].toString(),
                                  child: Text(map['blackBelt'], style: TextStyle(fontSize: 16.0, color: Colors.black87, fontStyle: FontStyle.normal)),
                                );
                              }).toList(),
                            ),
                          ),
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
                                            '2. Problem, Goals, Objectives, and Deliverable',
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
                          Padding(
                            padding: const EdgeInsets.only(top: 20.0, left: 20.0, right: 20.0),
                            child: TextFormField(
                              textCapitalization: TextCapitalization.sentences,
                              decoration: InputDecoration(
                                border: UnderlineInputBorder(),
                                labelText: 'Problem or Issue',
                                labelStyle: TextStyle(fontSize: 16.0),
                              ),
                              maxLines: 3,
                              keyboardType: TextInputType.multiline,
                              style: TextStyle(
                                fontStyle: FontStyle.normal,
                                color: Colors.black87,
                                fontSize: 16.0),
                              onSaved: null,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 20.0, left: 20.0, right: 20.0),
                            child: TextFormField(
                              textCapitalization: TextCapitalization.sentences,
                              decoration: InputDecoration(
                                border: UnderlineInputBorder(),
                                labelText: 'Purpose or Project',
                                labelStyle: TextStyle(fontSize: 16.0),
                              ),
                              maxLines: 3,
                              keyboardType: TextInputType.multiline,
                              style: TextStyle(
                                fontStyle: FontStyle.normal,
                                color: Colors.black87,
                                fontSize: 16.0),
                              onSaved: null,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 20.0, left: 20.0, right: 20.0),
                            child: TextFormField(
                              textCapitalization: TextCapitalization.sentences,
                              decoration: InputDecoration(
                                border: UnderlineInputBorder(),
                                labelText: 'Business Case',
                                labelStyle: TextStyle(fontSize: 16.0),
                              ),
                              maxLines: 3,
                              keyboardType: TextInputType.multiline,
                              style: TextStyle(
                                fontStyle: FontStyle.normal,
                                color: Colors.black87,
                                fontSize: 16.0),
                              onSaved: null,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 10.0, left: 20.0, right: 20.0),
                            child: DropdownButtonFormField<String>(
                              decoration: InputDecoration(
                                labelText: 'Goals  Metric',
                                labelStyle: TextStyle(fontSize: 16.0),
                              ),
                              value: _goalsSelection,
                              onChanged: (String value) {
                                setState(() {
                                  switch (int.tryParse(value)) {
                                    case 1:
                                      _goals = 'IDR';
                                      break;
                                    case 2:
                                      _goals = 'USD';
                                      break;
                                    case 3:
                                      _goals = 'Ton';
                                      break;
                                    case 4:
                                      _goals = 'Kg';
                                      break;
                                    default:
                                      _goals = '-';
                                      break;
                                  }
                                  _goalsSelection = value;
                                });
                              },
                              items: _goalsJson.map((Map map) {
                                return DropdownMenuItem(
                                  value: map['id'].toString(),
                                  child: Text(map['goals'], style: TextStyle(fontSize: 16.0, color: Colors.black87, fontStyle: FontStyle.normal)),
                                );
                              }).toList(),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 20.0, left: 20.0, right: 20.0),
                            child: TextFormField(
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                border: UnderlineInputBorder(),
                                labelText: 'Expected Deliverables',
                                labelStyle: TextStyle(fontSize: 16.0),
                              ),
                              style: TextStyle(
                                fontStyle: FontStyle.normal,
                                color: Colors.black87,
                                fontSize: 16.0),
                              onSaved: null,
                            ),
                          ),
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
                                            '3. Project Scope',
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
                          Padding(
                            padding: const EdgeInsets.only(top: 20.0, left: 20.0, right: 20.0),
                            child: TextFormField(
                              textCapitalization: TextCapitalization.sentences,
                              decoration: InputDecoration(
                                border: UnderlineInputBorder(),
                                labelText: 'Within Scope',
                                labelStyle: TextStyle(fontSize: 16.0),
                              ),
                              style: TextStyle(
                                fontStyle: FontStyle.normal,
                                color: Colors.black87,
                                fontSize: 16.0),
                              onSaved: null,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 20.0, left: 20.0, right: 20.0),
                            child: TextFormField(
                              textCapitalization: TextCapitalization.sentences,
                              decoration: InputDecoration(
                                border: UnderlineInputBorder(),
                                labelText: 'Outside of Scope',
                                labelStyle: TextStyle(fontSize: 16.0),
                              ),
                              style: TextStyle(
                                fontStyle: FontStyle.normal,
                                color: Colors.black87,
                                fontSize: 16.0),
                              onSaved: null,
                            ),
                          ),
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
                                            '4. Tentative Schedule',
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
                          Padding(
                            padding: const EdgeInsets.only(top: 20.0, left: 20.0, right: 20.0),
                            child: Column(
                              children: <Widget>[
                                Container(
                                  padding: EdgeInsets.only(left: 10.0),
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    'From Project Team',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 16.0),
                                    textAlign: TextAlign.start,
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.only(top: 5.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                                    children: <Widget>[
                                      Container(
                                        width: MediaQuery.of(context).size.width / 2.5,
                                        child: DateTimePickerFormField(
                                          format: dateFormat,
                                          onChanged: (dt) =>
                                              setState(() => dateStart = dt),
                                          dateOnly: true,
                                          style: TextStyle(
                                            fontSize: 16.0,
                                            color: Colors.black87,
                                          ),
                                          decoration: InputDecoration(
                                            border: UnderlineInputBorder(),
                                            labelStyle: TextStyle(fontSize: 16.0),
                                            labelText: 'Start'
                                          ),
                                        ),
                                      ),
                                      Container(
                                        width: MediaQuery.of(context).size.width / 2.5,
                                        child: DateTimePickerFormField(
                                          format: dateFormat,
                                          onChanged: (dt) =>
                                              setState(() => dateStart = dt),
                                          dateOnly: true,
                                          style: TextStyle(
                                            fontSize: 16.0,
                                            color: Colors.black87,
                                          ),
                                          decoration: InputDecoration(
                                            border: UnderlineInputBorder(),
                                            labelStyle: TextStyle(fontSize: 16.0),
                                            labelText: 'Complete'
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                )
                              ],
                            )
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 20.0, left: 20.0, right: 20.0),
                            child: Column(
                              children: <Widget>[
                                Container(
                                  padding: EdgeInsets.only(left: 10.0),
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    'Preliminary Review',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 16.0),
                                    textAlign: TextAlign.start,
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.only(top: 5.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                                    children: <Widget>[
                                      Container(
                                        width: MediaQuery.of(context).size.width / 2.5,
                                        child: DateTimePickerFormField(
                                          format: dateFormat,
                                          onChanged: (dt) =>
                                              setState(() => dateStart = dt),
                                          dateOnly: true,
                                          style: TextStyle(
                                            fontSize: 16.0,
                                            color: Colors.black87,
                                          ),
                                          decoration: InputDecoration(
                                            border: UnderlineInputBorder(),
                                            labelStyle: TextStyle(fontSize: 16.0),
                                            labelText: 'Start'
                                          ),
                                        ),
                                      ),
                                      Container(
                                        width: MediaQuery.of(context).size.width / 2.5,
                                        child: DateTimePickerFormField(
                                          format: dateFormat,
                                          onChanged: (dt) =>
                                              setState(() => dateStart = dt),
                                          dateOnly: true,
                                          style: TextStyle(
                                            fontSize: 16.0,
                                            color: Colors.black87,
                                          ),
                                          decoration: InputDecoration(
                                            border: UnderlineInputBorder(),
                                            labelStyle: TextStyle(fontSize: 16.0),
                                            labelText: 'Complete'
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                )
                              ],
                            )
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 20.0, left: 20.0, right: 20.0),
                            child: Column(
                              children: <Widget>[
                                Container(
                                  padding: EdgeInsets.only(left: 10.0),
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    'Define Scope',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 16.0),
                                    textAlign: TextAlign.start,
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.only(top: 5.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                                    children: <Widget>[
                                      Container(
                                        width: MediaQuery.of(context).size.width / 2.5,
                                        child: DateTimePickerFormField(
                                          format: dateFormat,
                                          onChanged: (dt) =>
                                              setState(() => dateStart = dt),
                                          dateOnly: true,
                                          style: TextStyle(
                                            fontSize: 16.0,
                                            color: Colors.black87,
                                          ),
                                          decoration: InputDecoration(
                                            border: UnderlineInputBorder(),
                                            labelStyle: TextStyle(fontSize: 16.0),
                                            labelText: 'Start'
                                          ),
                                        ),
                                      ),
                                      Container(
                                        width: MediaQuery.of(context).size.width / 2.5,
                                        child: DateTimePickerFormField(
                                          format: dateFormat,
                                          onChanged: (dt) =>
                                              setState(() => dateStart = dt),
                                          dateOnly: true,
                                          style: TextStyle(
                                            fontSize: 16.0,
                                            color: Colors.black87,
                                          ),
                                          decoration: InputDecoration(
                                            border: UnderlineInputBorder(),
                                            labelStyle: TextStyle(fontSize: 16.0),
                                            labelText: 'Complete'
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                )
                              ],
                            )
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 20.0, left: 20.0, right: 20.0),
                            child: Column(
                              children: <Widget>[
                                Container(
                                  padding: EdgeInsets.only(left: 10.0),
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    'Measurement Phase',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 16.0),
                                    textAlign: TextAlign.start,
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.only(top: 5.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                                    children: <Widget>[
                                      Container(
                                        width: MediaQuery.of(context).size.width / 2.5,
                                        child: DateTimePickerFormField(
                                          format: dateFormat,
                                          onChanged: (dt) =>
                                              setState(() => dateStart = dt),
                                          dateOnly: true,
                                          style: TextStyle(
                                            fontSize: 16.0,
                                            color: Colors.black87,
                                          ),
                                          decoration: InputDecoration(
                                            border: UnderlineInputBorder(),
                                            labelStyle: TextStyle(fontSize: 16.0),
                                            labelText: 'Start'
                                          ),
                                        ),
                                      ),
                                      Container(
                                        width: MediaQuery.of(context).size.width / 2.5,
                                        child: DateTimePickerFormField(
                                          format: dateFormat,
                                          onChanged: (dt) =>
                                              setState(() => dateStart = dt),
                                          dateOnly: true,
                                          style: TextStyle(
                                            fontSize: 16.0,
                                            color: Colors.black87,
                                          ),
                                          decoration: InputDecoration(
                                            border: UnderlineInputBorder(),
                                            labelStyle: TextStyle(fontSize: 16.0),
                                            labelText: 'Complete'
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                )
                              ],
                            )
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 20.0, left: 20.0, right: 20.0),
                            child: Column(
                              children: <Widget>[
                                Container(
                                  padding: EdgeInsets.only(left: 10.0),
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    'Analysis Phase',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 16.0),
                                    textAlign: TextAlign.start,
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.only(top: 5.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                                    children: <Widget>[
                                      Container(
                                        width: MediaQuery.of(context).size.width / 2.5,
                                        child: DateTimePickerFormField(
                                          format: dateFormat,
                                          onChanged: (dt) =>
                                              setState(() => dateStart = dt),
                                          dateOnly: true,
                                          style: TextStyle(
                                            fontSize: 16.0,
                                            color: Colors.black87,
                                          ),
                                          decoration: InputDecoration(
                                            border: UnderlineInputBorder(),
                                            labelStyle: TextStyle(fontSize: 16.0),
                                            labelText: 'Start'
                                          ),
                                        ),
                                      ),
                                      Container(
                                        width: MediaQuery.of(context).size.width / 2.5,
                                        child: DateTimePickerFormField(
                                          format: dateFormat,
                                          onChanged: (dt) =>
                                              setState(() => dateStart = dt),
                                          dateOnly: true,
                                          style: TextStyle(
                                            fontSize: 16.0,
                                            color: Colors.black87,
                                          ),
                                          decoration: InputDecoration(
                                            border: UnderlineInputBorder(),
                                            labelStyle: TextStyle(fontSize: 16.0),
                                            labelText: 'Complete'
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                )
                              ],
                            )
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 20.0, left: 20.0, right: 20.0),
                            child: Column(
                              children: <Widget>[
                                Container(
                                  padding: EdgeInsets.only(left: 10.0),
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    'Improvement Phase',
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 16.0),
                                    textAlign: TextAlign.start,
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.only(top: 5.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                                    children: <Widget>[
                                      Container(
                                        width: MediaQuery.of(context).size.width / 2.5,
                                        child: DateTimePickerFormField(
                                          format: dateFormat,
                                          onChanged: (dt) =>
                                              setState(() => dateStart = dt),
                                          dateOnly: true,
                                          style: TextStyle(
                                            fontSize: 16.0,
                                            color: Colors.black87,
                                          ),
                                          decoration: InputDecoration(
                                            border: UnderlineInputBorder(),
                                            labelStyle: TextStyle(fontSize: 16.0),
                                            labelText: 'Start'
                                          ),
                                        ),
                                      ),
                                      Container(
                                        width: MediaQuery.of(context).size.width / 2.5,
                                        child: DateTimePickerFormField(
                                          format: dateFormat,
                                          onChanged: (dt) =>
                                              setState(() => dateStart = dt),
                                          dateOnly: true,
                                          style: TextStyle(
                                            fontSize: 16.0,
                                            color: Colors.black87,
                                          ),
                                          decoration: InputDecoration(
                                            border: UnderlineInputBorder(),
                                            labelStyle: TextStyle(fontSize: 16.0),
                                            labelText: 'Complete'
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                )
                              ],
                            )
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 20.0, left: 20.0, right: 20.0),
                            child: Column(
                              children: <Widget>[
                                Container(
                                  padding: EdgeInsets.only(left: 10.0),
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    'Control Phase',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 16.0),
                                    textAlign: TextAlign.start,
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.only(top: 5.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                                    children: <Widget>[
                                      Container(
                                        width: MediaQuery.of(context).size.width / 2.5,
                                        child: DateTimePickerFormField(
                                          format: dateFormat,
                                          onChanged: (dt) =>
                                              setState(() => dateStart = dt),
                                          dateOnly: true,
                                          style: TextStyle(
                                            fontSize: 16.0,
                                            color: Colors.black87,
                                          ),
                                          decoration: InputDecoration(
                                            border: UnderlineInputBorder(),
                                            labelStyle: TextStyle(fontSize: 16.0),
                                            labelText: 'Start'
                                          ),
                                        ),
                                      ),
                                      Container(
                                        width: MediaQuery.of(context).size.width / 2.5,
                                        child: DateTimePickerFormField(
                                          format: dateFormat,
                                          onChanged: (dt) =>
                                              setState(() => dateStart = dt),
                                          dateOnly: true,
                                          style: TextStyle(
                                            fontSize: 16.0,
                                            color: Colors.black87,
                                          ),
                                          decoration: InputDecoration(
                                            border: UnderlineInputBorder(),
                                            labelStyle: TextStyle(fontSize: 16.0),
                                            labelText: 'Complete'
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                )
                              ],
                            )
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 20.0, left: 20.0, right: 20.0),
                            child: Column(
                              children: <Widget>[
                                Container(
                                  padding: EdgeInsets.only(left: 10.0),
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    'Project Summary Report',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 16.0),
                                    textAlign: TextAlign.start,
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.only(top: 5.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                                    children: <Widget>[
                                      Container(
                                        width: MediaQuery.of(context).size.width / 2.5,
                                        child: DateTimePickerFormField(
                                          format: dateFormat,
                                          onChanged: (dt) =>
                                              setState(() => dateStart = dt),
                                          dateOnly: true,
                                          style: TextStyle(
                                            fontSize: 16.0,
                                            color: Colors.black87,
                                          ),
                                          decoration: InputDecoration(
                                            border: UnderlineInputBorder(),
                                            labelStyle: TextStyle(fontSize: 16.0),
                                            labelText: 'Start'
                                          ),
                                        ),
                                      ),
                                      Container(
                                        width: MediaQuery.of(context).size.width / 2.5,
                                        child: DateTimePickerFormField(
                                          format: dateFormat,
                                          onChanged: (dt) =>
                                              setState(() => dateStart = dt),
                                          dateOnly: true,
                                          style: TextStyle(
                                            fontSize: 16.0,
                                            color: Colors.black87,
                                          ),
                                          decoration: InputDecoration(
                                            border: UnderlineInputBorder(),
                                            labelStyle: TextStyle(fontSize: 16.0),
                                            labelText: 'Complete'
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                )
                              ],
                            )
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 20.0, left: 20.0, right: 20.0, bottom: 20.0),
                            child: Column(
                              children: <Widget>[
                                Container(
                                  padding: EdgeInsets.only(left: 10.0),
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    'Close Out',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 16.0),
                                    textAlign: TextAlign.start,
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.only(top: 5.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                                    children: <Widget>[
                                      Container(
                                        width: MediaQuery.of(context).size.width / 2.5,
                                        child: DateTimePickerFormField(
                                          format: dateFormat,
                                          onChanged: (dt) =>
                                              setState(() => dateStart = dt),
                                          dateOnly: true,
                                          style: TextStyle(
                                            fontSize: 16.0,
                                            color: Colors.black87,
                                          ),
                                          decoration: InputDecoration(
                                            border: UnderlineInputBorder(),
                                            labelStyle: TextStyle(fontSize: 16.0),
                                            labelText: 'Start'
                                          ),
                                        ),
                                      ),
                                      Container(
                                        width: MediaQuery.of(context).size.width / 2.5,
                                        child: DateTimePickerFormField(
                                          format: dateFormat,
                                          onChanged: (dt) =>
                                              setState(() => dateStart = dt),
                                          dateOnly: true,
                                          style: TextStyle(
                                            fontSize: 16.0,
                                            color: Colors.black87,
                                          ),
                                          decoration: InputDecoration(
                                            border: UnderlineInputBorder(),
                                            labelStyle: TextStyle(fontSize: 16.0),
                                            labelText: 'Complete'
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                )
                              ],
                            )
                          ),
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
                                            '5. Project Resources and Costs',
                                            style: TextStyle(color: Colors.white, fontSize: 14.0),
                                            textAlign: TextAlign.start,
                                          ),
                                          Text(
                                            '5 of ${_listData.length.toString()}',
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
                          ListTile(
                            title: Padding(
                              padding: const EdgeInsets.only(top: 10.0, left: 10.0),
                              child: DropdownButtonFormField<String>(
                                decoration: InputDecoration(
                                  labelText: 'Project Team',
                                  labelStyle: TextStyle(fontSize: 16.0),
                                ),
                                value: _projectTeamSelection,
                                onChanged: (String value) {
                                  setState(() {
                                    switch (int.tryParse(value)) {
                                      case 1:
                                        _projectTeam = 'Team 1';
                                        break;
                                      case 2:
                                        _projectTeam = 'Team 2';
                                        break;
                                      case 3:
                                        _projectTeam = 'Team 3';
                                        break;
                                      case 4:
                                        _projectTeam = 'Team 4';
                                        break;
                                      default:
                                        _projectTeam = '-';
                                        break;
                                    }
                                    _projectTeamSelection = value;
                                  });
                                },
                                items: _projectTeamJson.map((Map map) {
                                  return DropdownMenuItem(
                                    value: map['id'].toString(),
                                    child: Text(map['projectTeam'], style: TextStyle(fontSize: 16.0, color: Colors.black87, fontStyle: FontStyle.normal)),
                                  );
                                }).toList(),
                              ),
                            ),
                            trailing: IconButton(
                              icon: Icon(Icons.add, color: AbubaPallate.greenabuba),
                              onPressed: () {
                                setState(() {
                                  _projectTeamSelected.add(_projectTeam);
                                });
                              },
                            ),
                          ),
                          ListTile(
                            title: Padding(
                              padding: const EdgeInsets.only(top: 10.0, left: 10.0),
                              child: DropdownButtonFormField<String>(
                                decoration: InputDecoration(
                                  labelText: 'Support Resources',
                                  labelStyle: TextStyle(fontSize: 16.0),
                                ),
                                value: _supportResourcesSelection,
                                onChanged: (String value) {
                                  setState(() {
                                    switch (int.tryParse(value)) {
                                      case 1:
                                        _supportResources = 'Support 1';
                                        break;
                                      case 2:
                                        _supportResources = 'Support 2';
                                        break;
                                      case 3:
                                        _supportResources = 'Support 3';
                                        break;
                                      case 4:
                                        _supportResources = 'Support 4';
                                        break;
                                      default:
                                        _supportResources = '-';
                                        break;
                                    }
                                    _supportResourcesSelection = value;
                                  });
                                },
                                items: _supportResourcesJson.map((Map map) {
                                  return DropdownMenuItem(
                                    value: map['id'].toString(),
                                    child: Text(map['supportResources'], style: TextStyle(fontSize: 16.0, color: Colors.black87, fontStyle: FontStyle.normal)),
                                  );
                                }).toList(),
                              ),
                            ),
                            trailing: IconButton(
                              icon: Icon(Icons.add, color: AbubaPallate.greenabuba),
                              onPressed: () {
                                setState(() {
                                  _supportResourcesSelected.add(_supportResources);
                                });
                              },
                            ),
                          ),
                          ListTile(
                            title: Padding(
                              padding: const EdgeInsets.only(top: 10.0, left: 10.0),
                              child: DropdownButtonFormField<String>(
                                decoration: InputDecoration(
                                  labelText: 'Special Needs',
                                  labelStyle: TextStyle(fontSize: 16.0),
                                ),
                                value: _specialNeedsSelection,
                                onChanged: (String value) {
                                  setState(() {
                                    switch (int.tryParse(value)) {
                                      case 1:
                                        _specialNeeds = 'Special Needs 1';
                                        break;
                                      case 2:
                                        _specialNeeds = 'Special Needs 2';
                                        break;
                                      case 3:
                                        _specialNeeds = 'Special Needs 3';
                                        break;
                                      case 4:
                                        _specialNeeds = 'Special Needs 4';
                                        break;
                                      default:
                                        _specialNeeds = '-';
                                        break;
                                    }
                                    _specialNeedsSelection = value;
                                  });
                                },
                                items: _specialNeedsJson.map((Map map) {
                                  return DropdownMenuItem(
                                    value: map['id'].toString(),
                                    child: Text(map['specialNeeds'], style: TextStyle(fontSize: 16.0, color: Colors.black87, fontStyle: FontStyle.normal)),
                                  );
                                }).toList(),
                              ),
                            ),
                            trailing: IconButton(
                              icon: Icon(Icons.add, color: AbubaPallate.greenabuba),
                              onPressed: () {
                                setState(() {
                                  _specialNeedsSelected.add(_specialNeeds);
                                });
                              },
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
                                            '6. Costing',
                                            style: TextStyle(color: Colors.white, fontSize: 14.0),
                                            textAlign: TextAlign.start,
                                          ),
                                          Text(
                                            '6 of ${_listData.length.toString()}',
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
                          ListTile(
                            title: Padding(
                              padding: const EdgeInsets.only(top: 10.0, left: 10.0),
                              child: DropdownButtonFormField<String>(
                                decoration: InputDecoration(
                                  labelText: 'Cost Type',
                                  labelStyle: TextStyle(fontSize: 16.0),
                                ),
                                value: _costTypeSelection,
                                onChanged: (String value) {
                                  setState(() {
                                    switch (int.tryParse(value)) {
                                      case 1:
                                        _costType = 'Asset';
                                        break;
                                      case 2:
                                        _costType = 'Transportation';
                                        break;
                                      case 3:
                                        _costType = 'Labor';
                                        break;
                                      default:
                                        _costType = '-';
                                        break;
                                    }
                                    _costTypeSelection = value;
                                  });
                                },
                                items: _costTypeJson.map((Map map) {
                                  return DropdownMenuItem(
                                    value: map['id'].toString(),
                                    child: Text(map['costType'], style: TextStyle(fontSize: 16.0, color: Colors.black87, fontStyle: FontStyle.normal)),
                                  );
                                }).toList(),
                              ),
                            ),
                            trailing: IconButton(
                              icon: Icon(Icons.add, color: Colors.white),
                              onPressed: null,
                            ),
                          ),
                          ListTile(
                            title: Padding(
                              padding: const EdgeInsets.only(top: 10.0, left: 10.0),
                              child: DropdownButtonFormField<String>(
                                decoration: InputDecoration(
                                  labelText: 'Vendor / Labor Names',
                                  labelStyle: TextStyle(fontSize: 16.0),
                                ),
                                value: _vendorSelection,
                                onChanged: (String value) {
                                  setState(() {
                                    switch (int.tryParse(value)) {
                                      case 1:
                                        _vendor = 'PT Vendor';
                                        break;
                                      case 2:
                                        _vendor = 'PT Buyer';
                                        break;
                                      default:
                                        _vendor = '-';
                                        break;
                                    }
                                    _vendorSelection = value;
                                  });
                                },
                                items: _vendorJson.map((Map map) {
                                  return DropdownMenuItem(
                                    value: map['id'].toString(),
                                    child: Text(map['vendor'], style: TextStyle(fontSize: 16.0, color: Colors.black87, fontStyle: FontStyle.normal)),
                                  );
                                }).toList(),
                              ),
                            ),
                            trailing: IconButton(
                              icon: Icon(Icons.add, color: Colors.white),
                              onPressed: null,
                            ),
                          ),
                          ListTile(
                            title: Padding(
                              padding: const EdgeInsets.only(top: 10.0, left: 10.0),
                              child: TextFormField(
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                  border: UnderlineInputBorder(),
                                  labelText: 'Rate (IDR)',
                                  labelStyle: TextStyle(fontSize: 16.0),
                                ),
                                style: TextStyle(
                                  fontStyle: FontStyle.normal,
                                  color: Colors.black87,
                                  fontSize: 16.0),
                                onSaved: null,
                              ),
                            ),
                            trailing: IconButton(
                              icon: Icon(Icons.add, color: Colors.white),
                              onPressed: null,
                            ),
                          ),
                          ListTile(
                            title: Padding(
                              padding: const EdgeInsets.only(top: 10.0, left: 10.0),
                              child: TextFormField(
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                  border: UnderlineInputBorder(),
                                  labelText: 'Quantity',
                                  labelStyle: TextStyle(fontSize: 16.0),
                                ),
                                style: TextStyle(
                                  fontStyle: FontStyle.normal,
                                  color: Colors.black87,
                                  fontSize: 16.0),
                                onSaved: null,
                              ),
                            ),
                            trailing: IconButton(
                              icon: Icon(Icons.add, color: Colors.white),
                              onPressed: null,
                            ),
                          ),
                          ListTile(
                            title: Padding(
                              padding: const EdgeInsets.only(top: 10.0, left: 10.0),
                              child: TextFormField(
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                  border: UnderlineInputBorder(),
                                  labelText: 'Amount',
                                  labelStyle: TextStyle(fontSize: 16.0),
                                ),
                                style: TextStyle(
                                  fontStyle: FontStyle.normal,
                                  color: Colors.black87,
                                  fontSize: 16.0),
                                onSaved: null,
                              ),
                            ),
                            trailing: IconButton(
                              icon: Icon(Icons.add, color: AbubaPallate.greenabuba),
                              onPressed: () {},
                            ),
                          ),
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
                                            '7. Project Benefits and Customers',
                                            style: TextStyle(color: Colors.white, fontSize: 14.0),
                                            textAlign: TextAlign.start,
                                          ),
                                          Text(
                                            '7 of ${_listData.length.toString()}',
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
                          Padding(
                            padding: const EdgeInsets.only(top: 20.0, left: 20.0, right: 20.0),
                            child: DropdownButtonFormField<String>(
                              decoration: InputDecoration(
                                labelText: 'Process Owner',
                                labelStyle: TextStyle(fontSize: 16.0),
                              ),
                              value: _processOwnerSelection,
                              onChanged: (String value) {
                                setState(() {
                                  switch (int.tryParse(value)) {
                                    case 1:
                                      _processOwner = 'Ridwan';
                                      break;
                                    case 2:
                                      _processOwner = 'Sony';
                                      break;
                                    case 3:
                                      _processOwner = 'Rijal';
                                      break;
                                    default:
                                      _processOwner = '-';
                                      break;
                                  }
                                  _processOwnerSelection = value;
                                });
                              },
                              items: _processOwnerJson.map((Map map) {
                                return DropdownMenuItem(
                                  value: map['id'].toString(),
                                  child: Text(map['processOwner'], style: TextStyle(fontSize: 16.0, color: Colors.black87, fontStyle: FontStyle.normal)),
                                );
                              }).toList(),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 10.0, left: 20.0, right: 20.0),
                            child: DropdownButtonFormField<String>(
                              decoration: InputDecoration(
                                labelText: 'Key Stakeholders',
                                labelStyle: TextStyle(fontSize: 16.0),
                              ),
                              value: _keyStakeholdersSelection,
                              onChanged: (String value) {
                                setState(() {
                                  switch (int.tryParse(value)) {
                                    case 1:
                                      _keyStakeholders = 'Supplier';
                                      break;
                                    case 2:
                                      _keyStakeholders = 'Customer';
                                      break;
                                    default:
                                      _keyStakeholders = '-';
                                      break;
                                  }
                                  _keyStakeholdersSelection = value;
                                });
                              },
                              items: _keyStakeholdersJson.map((Map map) {
                                return DropdownMenuItem(
                                  value: map['id'].toString(),
                                  child: Text(map['keyStakeholders'], style: TextStyle(fontSize: 16.0, color: Colors.black87, fontStyle: FontStyle.normal)),
                                );
                              }).toList(),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 10.0, left: 20.0, right: 20.0),
                            child: DropdownButtonFormField<String>(
                              decoration: InputDecoration(
                                labelText: 'Final Customer',
                                labelStyle: TextStyle(fontSize: 16.0),
                              ),
                              value: _finalCustomerSelection,
                              onChanged: (String value) {
                                setState(() {
                                  switch (int.tryParse(value)) {
                                    case 1:
                                      _finalCustomer = 'Department A';
                                      break;
                                    case 2:
                                      _finalCustomer = 'Department B';
                                      break;
                                    default:
                                      _finalCustomer = '-';
                                      break;
                                  }
                                  _finalCustomerSelection = value;
                                });
                              },
                              items: _finalCustomerJson.map((Map map) {
                                return DropdownMenuItem(
                                  value: map['id'].toString(),
                                  child: Text(map['finalCustomer'], style: TextStyle(fontSize: 16.0, color: Colors.black87, fontStyle: FontStyle.normal)),
                                );
                              }).toList(),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 20.0, left: 20.0, right: 20.0),
                            child: TextFormField(
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                border: UnderlineInputBorder(),
                                labelText: 'Expected Benefits',
                                labelStyle: TextStyle(fontSize: 16.0),
                              ),
                              style: TextStyle(
                                fontStyle: FontStyle.normal,
                                color: Colors.black87,
                                fontSize: 16.0),
                              onSaved: null,
                            ),
                          ),
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
                                            '8. Estimated Benefit',
                                            style: TextStyle(color: Colors.white, fontSize: 14.0),
                                            textAlign: TextAlign.start,
                                          ),
                                          Text(
                                            '8 of ${_listData.length.toString()}',
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
                          ListTile(
                            title: Padding(
                              padding: const EdgeInsets.only(top: 10.0, left: 10.0),
                              child: DropdownButtonFormField<String>(
                                decoration: InputDecoration(
                                  labelText: 'Type of Benefit',
                                  labelStyle: TextStyle(fontSize: 16.0),
                                ),
                                value: _typeOfBenefitSelection,
                                onChanged: (String value) {
                                  setState(() {
                                    switch (int.tryParse(value)) {
                                      case 1:
                                        _typeOfBenefit = 'Cost Saving';
                                        break;
                                      case 2:
                                        _typeOfBenefit = 'Enhanced Revenue';
                                        break;
                                      case 3:
                                        _typeOfBenefit = 'Productivity';
                                        break;
                                      case 4:
                                        _typeOfBenefit = 'Improve Compliance';
                                        break;
                                      case 5:
                                        _typeOfBenefit = 'Better Decision Making';
                                        break;
                                      case 6:
                                        _typeOfBenefit = 'Less Maintenance';
                                        break;
                                      case 7:
                                        _typeOfBenefit = 'Other Costs Avoided';
                                        break;
                                      default:
                                        _typeOfBenefit = '-';
                                        break;
                                    }
                                    _typeOfBenefitSelection = value;
                                  });
                                },
                                items: _typeOfBenefitJson.map((Map map) {
                                  return DropdownMenuItem(
                                    value: map['id'].toString(),
                                    child: Text(map['typeOfBenefit'], style: TextStyle(fontSize: 16.0, color: Colors.black87, fontStyle: FontStyle.normal)),
                                  );
                                }).toList(),
                              ),
                            ),
                            trailing: IconButton(
                              icon: Icon(Icons.add, color: Colors.white),
                              onPressed: () {},
                            ),
                          ),
                          ListTile(
                            title: Padding(
                              padding: const EdgeInsets.only(top: 10.0, left: 10.0),
                              child: TextFormField(
                                textCapitalization: TextCapitalization.sentences,
                                decoration: InputDecoration(
                                  border: UnderlineInputBorder(),
                                  labelText: 'Describe Basis of Estimate',
                                  labelStyle: TextStyle(fontSize: 16.0),
                                ),
                                maxLines: 3,
                                keyboardType: TextInputType.multiline,
                                style: TextStyle(
                                  fontStyle: FontStyle.normal,
                                  color: Colors.black87,
                                  fontSize: 16.0),
                                onSaved: null,
                              ),
                            ),
                            trailing: IconButton(
                              icon: Icon(Icons.add, color: Colors.white),
                              onPressed: () {},
                            ),
                          ),
                          ListTile(
                            title: Padding(
                              padding: const EdgeInsets.only(top: 10.0, left: 10.0),
                              child: TextFormField(
                                decoration: InputDecoration(
                                  border: UnderlineInputBorder(),
                                  labelText: 'Estimated Benefit',
                                  labelStyle: TextStyle(fontSize: 16.0),
                                ),
                                keyboardType: TextInputType.number,
                                style: TextStyle(
                                  fontStyle: FontStyle.normal,
                                  color: Colors.black87,
                                  fontSize: 16.0),
                                onSaved: null,
                              ),
                            ),
                            trailing: IconButton(
                              icon: Icon(Icons.add, color: AbubaPallate.greenabuba),
                              onPressed: () {},
                            ),
                          ),
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
                                            '9. Risk, Constraints and Assumption',
                                            style: TextStyle(color: Colors.white, fontSize: 14.0),
                                            textAlign: TextAlign.start,
                                          ),
                                          Text(
                                            '9 of ${_listData.length.toString()}',
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
                          Padding(
                            padding: const EdgeInsets.only(top: 20.0, left: 20.0, right: 20.0),
                            child: TextFormField(
                              textCapitalization: TextCapitalization.sentences,
                              decoration: InputDecoration(
                                border: UnderlineInputBorder(),
                                labelText: 'Risks',
                                labelStyle: TextStyle(fontSize: 16.0),
                              ),
                              style: TextStyle(
                                fontStyle: FontStyle.normal,
                                color: Colors.black87,
                                fontSize: 16.0),
                              onSaved: null,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 20.0, left: 20.0, right: 20.0),
                            child: TextFormField(
                              textCapitalization: TextCapitalization.sentences,
                              decoration: InputDecoration(
                                border: UnderlineInputBorder(),
                                labelText: 'Constraints',
                                labelStyle: TextStyle(fontSize: 16.0),
                              ),
                              style: TextStyle(
                                fontStyle: FontStyle.normal,
                                color: Colors.black87,
                                fontSize: 16.0),
                              onSaved: null,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 20.0, left: 20.0, right: 20.0),
                            child: TextFormField(
                              textCapitalization: TextCapitalization.sentences,
                              decoration: InputDecoration(
                                border: UnderlineInputBorder(),
                                labelText: 'Assumption',
                                labelStyle: TextStyle(fontSize: 16.0),
                              ),
                              style: TextStyle(
                                fontStyle: FontStyle.normal,
                                color: Colors.black87,
                                fontSize: 16.0),
                              onSaved: null,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 30.0, left: 20.0, right: 20.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: <Widget>[
                                RaisedButton(
                                  onPressed: () {},
                                  child: Text(
                                    'SAVE',
                                    style: TextStyle(
                                      fontSize: 14.0,
                                    ),
                                  ),
                                  textColor: Colors.white,
                                  color: AbubaPallate.greenabuba,
                                )
                              ],
                            )
                          ),
                        ],
                      ),
                    ]
                  ),
                ),
              ],
            ),
          ),
        ),
        bottomNavigationBar: _bottomBar(),
      ),
    );
  }

  Widget _bottomBar() {
    return SizedBox(
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
                    icon: Icon(Icons.arrow_back_ios, color: Colors.white),
                    onPressed: () {
                      _cardController.animateTo(_cardController.index - 1);
                    },
                    tooltip: 'Previous',
                  ),
                  IconButton(
                    icon: Icon(Icons.arrow_forward_ios, color: Colors.white),
                    onPressed: () {
                      _cardController.animateTo(_cardController.index + 1);
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
    );
  }

  Widget _appBar() {
    return AppBar(
      elevation: 0.25,
      backgroundColor: Colors.white,
      iconTheme: IconThemeData(color: Colors.black),
      title: Image.asset(
        'assets/images/logo.png',
        height: 100.0,
        width: 120.0,
      ),
    );
  }
}