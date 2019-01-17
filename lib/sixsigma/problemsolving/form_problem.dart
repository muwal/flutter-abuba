import 'package:flutter/material.dart';
import 'package:flutter_abuba/constant.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:datetime_picker_formfield/time_picker_formfield.dart';
import 'package:intl/intl.dart';

class FormProblem extends StatefulWidget {
  FormProblem({Key key}) : super(key: key);

  @override
  _FormProblemState createState() => _FormProblemState();
}

class _FormProblemState extends State<FormProblem>
    with SingleTickerProviderStateMixin {
  int _number = 1;
  int _itemCount;
  int _currentIndex;
  bool _autoplay;

  final timeFormat = DateFormat("h:mm a");
  TimeOfDay time;

  bool _notedua = false;
  TextEditingController controllerNoteDua = new TextEditingController();

  bool _notetiga = false;
  TextEditingController controllerNoteTiga = new TextEditingController();

  bool _noteempat = false;
  TextEditingController controllerNoteEmpat = new TextEditingController();

  bool _notelima = false;
  TextEditingController controllerNoteLima = new TextEditingController();

  bool _noteenam = false;
  TextEditingController controllerNoteEnam = new TextEditingController();

  bool _notetujuh = false;
  TextEditingController controllerNoteTujuh = new TextEditingController();

  bool _notedelapan = false;
  TextEditingController controllerNoteDelapan = new TextEditingController();

  bool _notesembilan = false;
  TextEditingController controllerNoteSembilan = new TextEditingController();

  bool _notesepuluh = false;
  TextEditingController controllerNoteSepuluh = new TextEditingController();

  bool _notesebelas = false;
  TextEditingController controllerNoteSebelas = new TextEditingController();

  final dateFormat = DateFormat("MMMM d, yyyy");
  DateTime dateStart;

  String _mySelection;
  String _shift;
  List<Map> _shiftJson = [
    {"id": 1, "shift": "Customer Complain"},
    {"id": 2, "shift": "Alat Rusak"}
  ];

  List<Map> _title = [
    {
      'title': '1. Identify Problem',
      'title_dalam': ' ',
      'isi':
          '1. Sebutkan dengan jelas masalah yang akan diselesaikan\n\n2. Gunakan metode 5W2H. Who ? What ? Why ? Where ? When ? How ? How Many ?',
      'select': 'false',
      'checkbox': 'false',
      'note': 'false',
      'paham': 'false',
      'image': 'false',
      'pilhan_yes_no': 'false'
    },
    {
      'title': '1. Identify Problem',
      'title_dalam': 'WHAT',
      'isi': 'Apa masalah yang sedang terjadi',
      'select': 'true',
      'checkbox': 'false',
      'note': 'true',
      'paham': 'false',
      'image': 'false',
      'pilhan_yes_no': 'false'
    },
    {
      'title': '1. Identify Problem',
      'title_dalam': 'WHO',
      'isi': 'Siapa yang terlibat dengan masalah ini',
      'select': 'true',
      'checkbox': 'false',
      'note': 'false',
      'paham': 'false',
      'image': 'false',
      'pilhan_yes_no': 'false'
    },
    {
      'title': '1. Identify Problem',
      'title_dalam': 'WHEN',
      'isi': 'Kapan masalah ini terjadi',
      'select': 'true',
      'checkbox': 'false',
      'note': 'true',
      'paham': 'false',
      'image': 'false',
      'pilhan_yes_no': 'false'
    },
    {
      'title': '1. Identify Problem',
      'title_dalam': 'WHERE',
      'isi': 'Dimana lokasi masalah ditemukan',
      'select': 'true',
      'checkbox': 'false',
      'note': 'true',
      'paham': 'false',
      'image': 'false',
      'pilhan_yes_no': 'false'
    },
    {
      'title': '1. Identify Problem',
      'title_dalam': 'WHY',
      'isi':
          'Mengapa temuan / issue ini bisa menjadi masalah ? Apa konsekuensi dari masalah ini',
      'select': 'true',
      'checkbox': 'false',
      'note': 'true',
      'paham': 'false',
      'image': 'false',
      'pilhan_yes_no': 'false'
    },
    {
      'title': '1. Identify Problem',
      'title_dalam': 'HOW SEVERE',
      'isi': 'Seberapa parah akibat yang ditimbulkan dari masalaha',
      'select': 'true',
      'checkbox': 'false',
      'note': 'true',
      'paham': 'false',
      'image': 'false',
      'pilhan_yes_no': 'false'
    },
    {
      'title': '2. Identify Team',
      'title_dalam': 'TEAM',
      'isi':
          'Apakah untuk menyelesaikan masalah ini perlu dibentuk tim khusus ?',
      'select': 'false',
      'checkbox': 'false',
      'note': 'false',
      'paham': 'false',
      'image': 'false',
      'pilhan_yes_no': 'true'
    },
    {
      'title': '2. Identify Team',
      'title_dalam': 'TEAM',
      'isi':
          'Pilih anggota tim dari berbagai departemen yang memiliki wewenang untuk menyelesaikan masalah',
      'select': 'false',
      'checkbox': 'false',
      'note': 'false',
      'paham': 'true',
      'image': 'false',
      'pilhan_yes_no': 'false'
    },
    {
      'title': '2. Identify Team',
      'title_dalam': 'TEAM',
      'isi':
          'Harus jelas siapa yang menjadi Champion, Leader, Record Keeper dan Participants',
      'select': 'false',
      'checkbox': 'false',
      'note': 'false',
      'paham': 'true',
      'image': 'false',
      'pilhan_yes_no': 'false'
    },
    {
      'title': '2. Identify Team',
      'title_dalam': 'CHAMPION',
      'isi':
          'Mentor, mengarahkan dan membantu tim menjelaskan ke pihak management',
      'select': 'false',
      'checkbox': 'false',
      'note': 'false',
      'paham': 'false',
      'image': 'false',
      'pilhan_yes_no': 'false'
    },
    {
      'title': '2. Identify Team',
      'title_dalam': 'LEADER',
      'isi':
          'Bertanggungjawab pada pelaksana teknis, mengadakan meeting, menyiapkan fasilitas pada team dan report kepada champion',
      'select': 'false',
      'checkbox': 'false',
      'note': 'false',
      'paham': 'false',
      'image': 'false',
      'pilhan_yes_no': 'false'
    },
    {
      'title': '2. Identify Team',
      'title_dalam': 'RECORD KEEPER',
      'isi':
          'Mencatat perkembangan penyelesaian masalah dan membuat minute of meeting',
      'select': 'false',
      'checkbox': 'false',
      'note': 'false',
      'paham': 'false',
      'image': 'false',
      'pilhan_yes_no': 'false'
    },
    {
      'title': '2. Identify Team',
      'title_dalam': 'PARTICIPANTS',
      'isi':
          'Memberi ide, menjalankan tugas dan melaporkan perkembangan kepada leader secara tepat waktu',
      'select': 'false',
      'checkbox': 'false',
      'note': 'false',
      'paham': 'false',
      'image': 'false',
      'pilhan_yes_no': 'false'
    },
    {
      'title': '3. Immediate Action',
      'title_dalam': 'WAKTU PELAKSANAAN',
      'isi': 'Kapan tindakan tersebut akan dilaksanakan',
      'select': 'true',
      'checkbox': 'false',
      'note': 'false',
      'paham': 'false',
      'image': 'false',
      'pilhan_yes_no': 'false'
    },
    {
      'title': '3. Immediate Action',
      'title_dalam': 'PELAKSANA',
      'isi': 'Siapa yang akan melakukan tindakan segera tersebut',
      'select': 'true',
      'checkbox': 'false',
      'note': 'false',
      'paham': 'false',
      'image': 'false',
      'pilhan_yes_no': 'false'
    },
    {
      'title': '3. Immediate Action',
      'title_dalam': 'INGAT !',
      'isi':
          'Tindakan segera hanyalah action sementara sebelum corrective action dilakukan',
      'select': 'false',
      'checkbox': 'false',
      'note': 'false',
      'paham': 'true',
      'image': 'false',
      'pilhan_yes_no': 'false'
    },
    {
      'title': '4. Root Cause',
      'title_dalam': 'BRAINSTORMING',
      'isi':
          'Gunakan Fishbone diagram, Pareto dan 5 Why method untuk mencari tahu akar masalah',
      'select': 'false',
      'checkbox': 'false',
      'note': 'false',
      'paham': 'true',
      'image': 'false',
      'pilhan_yes_no': 'false'
    },
    {
      'title': '4. Root Cause',
      'title_dalam': 'FISHBONE DIAGRAM',
      'isi':
          'Gunakan Fishbone diagram, Pareto dan 5 Why method untuk mencari tahu akar masalah',
      'select': 'false',
      'checkbox': 'false',
      'note': 'false',
      'paham': 'false',
      'image': 'false',
      'pilhan_yes_no': 'false'
    },
    {
      'title': '5. Corrective Action Plan',
      'title_dalam': 'WHAT',
      'isi':
          'Apa tindakan permanen yang akan dilakukan untuk menyelesaikan masalah tersebut ?',
      'select': 'true',
      'checkbox': 'false',
      'note': 'true',
      'paham': 'false',
      'image': 'false',
      'pilhan_yes_no': 'false'
    },
    {
      'title': '5. Corrective Action Plan',
      'title_dalam': 'WHO',
      'isi': 'Siapa penanggungjawab dari tindakan permanen tersbut',
      'select': 'true',
      'checkbox': 'false',
      'note': 'true',
      'paham': 'false',
      'image': 'false',
      'pilhan_yes_no': 'false'
    },
    {
      'title': '5. Corrective Action Plan',
      'title_dalam': 'WHEN',
      'isi': 'Kapan tindakan permanen itu akan dijalankan',
      'select': 'true',
      'checkbox': 'false',
      'note': 'true',
      'paham': 'false',
      'image': 'false',
      'pilhan_yes_no': 'false'
    },
    {
      'title': '5. Corrective Action Plan',
      'title_dalam': 'BUKTI',
      'isi':
          'Lampirkan dokumen atau foto yang menunjukan bahwa tindakan permanen sudah dilakukan',
      'select': 'false',
      'checkbox': 'false',
      'note': 'true',
      'paham': 'false',
      'image': 'true',
      'pilhan_yes_no': 'false'
    },
    {
      'title': '5. Corrective Action Plan',
      'title_dalam': 'EFFECTIVENESS',
      'isi':
          'Bagaimana cara mengukur efektifitas dari tindakan permanen tersebut',
      'select': 'true',
      'checkbox': 'false',
      'note': 'true',
      'paham': 'false',
      'imaga': 'true',
      'pilhan_yes_no': 'false'
    },
    {
      'title': '5. Corrective Action Plan',
      'title_dalam': 'VERIFICATION',
      'isi':
          'Tindakan untuk memastikan bahwa action plan sudah dijalankan dan efektif',
      'select': 'false',
      'checkbox': 'false',
      'note': 'false',
      'paham': 'true',
      'image': 'false',
      'pilhan_yes_no': 'false'
    },
    {
      'title': '5. Corrective Action Plan',
      'title_dalam': 'VERIFICATION - WHO',
      'isi': 'Siapa yang bertanggungjawab melakukan verifikasi',
      'select': 'true',
      'checkbox': 'false',
      'note': 'false',
      'paham': 'false',
      'image': 'false',
      'pilhan_yes_no': 'false'
    },
    {
      'title': '5. Corrective Action Plan',
      'title_dalam': 'VERIFICATION - WHEN',
      'isi':
          'Kapan verifikasi akan dilakukan ? Sebaiknya tidak lebih dari 7 hari setelah implementasi tindakan permanen',
      'select': 'true',
      'checkbox': 'false',
      'note': 'false',
      'paham': 'false',
      'image': 'false',
      'pilhan_yes_no': 'false'
    },
    {
      'title': '5. Corrective Action Plan',
      'title_dalam': 'VALIDATION',
      'isi':
          'Tindakan untuk memastikan bahwa action plan sudah berjalan sesuai rencana dan masalah tidak muncul lagi setelah minimal 6 bulan sejak implementasi',
      'select': 'false',
      'checkbox': 'false',
      'note': 'false',
      'paham': 'true',
      'image': 'false',
      'pilhan_yes_no': 'false'
    },
    {
      'title': '5. Corrective Action Plan',
      'title_dalam': 'VALIDATION - WHO',
      'isi': 'Siapa yang bertanggungjawab melakukan validasi',
      'select': 'true',
      'checkbox': 'false',
      'note': 'false',
      'paham': 'false',
      'image': 'false',
      'pilhan_yes_no': 'false'
    },
    {
      'title': '5. Corrective Action Plan',
      'title_dalam': 'VALIDATION - WHEN',
      'isi':
          'Kapan validasi akan dilakukan ? Sebaiknya dilakukan setelah 6 bulan pelaksanaan action palan',
      'select': 'true',
      'checkbox': 'false',
      'note': 'false',
      'paham': 'false',
      'image': 'false',
      'pilhan_yes_no': 'false'
    },
    {
      'title': '6. Complete Action Plan',
      'title_dalam': 'COMPLETE',
      'isi':
          'Pastikan semua action plan dijalankan sesuai recana,\n\nApabila ada action plan yang belum dijalankan, jangan dulu dilakukan verifikasi',
      'select': 'false',
      'checkbox': 'false',
      'note': 'false',
      'paham': 'true',
      'image': 'false',
      'pilhan_yes_no': 'false'
    },
    {
      'title': '6. Complete Action Plan',
      'title_dalam': 'LEADER - RIDWAN',
      'isi': ' ',
      'select': 'false',
      'checkbox': 'true',
      'note': 'false',
      'paham': 'false',
      'image': 'false',
      'pilhan_yes_no': 'false'
    },
    {
      'title': '6. Complete Action Plan',
      'title_dalam': 'RECORD KEEPER - YANI',
      'isi': ' ',
      'select': 'false',
      'checkbox': 'true',
      'note': 'false',
      'paham': 'false',
      'image': 'false',
      'pilhan_yes_no': 'false'
    },
    {
      'title': '6. Complete Action Plan',
      'title_dalam': 'PARTICIPANT - SONY',
      'isi': ' ',
      'select': 'false',
      'checkbox': 'true',
      'note': 'false',
      'paham': 'false',
      'image': 'false',
      'pilhan_yes_no': 'false'
    },
    {
      'title': '6. Complete Action Plan',
      'title_dalam': 'PARTICIPANT - SONY',
      'isi': ' ',
      'select': 'false',
      'checkbox': 'true',
      'note': 'false',
      'paham': 'false',
      'image': 'false',
      'pilhan_yes_no': 'false'
    },
  ];

  List<String> isiTujuan = [
    'a. Memastikan agar material dan produk diperiksa',
    'b. Menjamin spesifikasi produk yang diproses sesuai dengan standar perusahaan',
  ];

  List<String> isiRisiko = [
    'a. Risiko terjadinya ketidaksesuaian spesifikasi produk',
    'b. Penurunan kualitas produk yang akan ataupun yang sudah diproduksi',
  ];

  List<String> isiProsedurPage9 = [
    'Menerima produk',
    'Menandatangani dokument',
  ];

  List<String> textList = [
    'Action Plan 1',
    'Action Plan 2',
    'Action Plan 3',
  ];

  List<bool> textListValue = [
    false,
    false,
    false,
    false,
    false,
  ];

  int _indexBantu = 0;

  @override
  void initState() {
    _currentIndex = 0;
    _autoplay = false;
    _itemCount = _title.length;
    _controller = new SwiperController();
    super.initState();
  }

  SwiperController _controller;
  TextEditingController numberController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    void _showDialog() {
      // flutter defined function
      showDialog(
        context: context,
        builder: (BuildContext context) {
          // return object of type Dialog
          return AlertDialog(
            titlePadding: EdgeInsets.all(0.0),
            title: Container(
              color: Colors.blue,
              padding: EdgeInsets.all(12.0),
              child: new Text(
                "REVIEW",
                style: TextStyle(color: Colors.white),
              ),
            ),
            content: new Text("Alert Dialog body"),
            actions: <Widget>[
              // usually buttons at the bottom of the dialog
              ButtonTheme(
                minWidth: 50.0,
                child: OutlineButton(
                  child: Text(
                    'Cancel',
                    style: TextStyle(fontSize: 13.0, color: Colors.black54),
                  ),
                  borderSide: BorderSide(color: Colors.black54, width: 1.0),
                  highlightedBorderColor: Colors.black54,
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ),
              ButtonTheme(
                minWidth: 50.0,
                child: RaisedButton(
                  child: Text(
                    'Save',
                    style: TextStyle(fontSize: 13.0, color: Colors.white),
                  ),
                  color: AbubaPallate.greenabuba,
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ),
            ],
          );
        },
      );
    }

    return SafeArea(
      child: Scaffold(
        appBar: _appBar(),
        backgroundColor: Colors.white,
        body: GestureDetector(
          onTap: () {
            FocusScope.of(context).requestFocus(FocusNode());
          },
          child: ListView(
            shrinkWrap: true,
            children: <Widget>[
              Column(
                children: <Widget>[
                  Swiper(
                    itemBuilder: (BuildContext context, int index) {
                      _indexBantu = index - 1;

                      return new Container(
                        color: Colors.white,
                        alignment: Alignment.center,
                        child: Column(
                          children: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Flexible(
                                  child: Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 10.0),
                                    child: Text(
                                      _title[index]['title_dalam'],
                                      style: TextStyle(
                                          color: Color(0xFF2F592F),
                                          fontSize: 32.0,
                                          fontWeight: FontWeight.bold),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            index == 0
                                ? Column(
                                    children: <Widget>[
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: <Widget>[
                                          Flexible(
                                            child: Padding(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 10.0,
                                                  vertical: 20.0),
                                              child: Text(
                                                _title[index]['isi'],
                                                style: TextStyle(
                                                    color: Colors.black54,
                                                    fontSize: 18.0),
                                                textAlign: TextAlign.start,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  )
                                : Container(),
                            index == 1
                                ? Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      Flexible(
                                        child: Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 10.0, vertical: 20.0),
                                          child: Text(
                                            _title[index]['isi'],
                                            style: TextStyle(
                                                color: Colors.black54,
                                                fontSize: 28.0),
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(
                                            top: 10.0, bottom: 10.0),
                                        child: DropdownButtonFormField(
                                          hint: Text('Customer Complain',
                                              style: TextStyle(fontSize: 14.0)),
                                          value: _mySelection,
                                          onChanged: (String newValue) {
                                            setState(() {
                                              switch (int.tryParse(newValue)) {
                                                case 1:
                                                  _shift = 'Customer Complain';
                                                  break;
                                                case 2:
                                                  _shift = 'Alat Rusak';
                                                  break;
                                                default:
                                                  _shift = '-';
                                                  break;
                                              }
                                              _mySelection = newValue;
                                            });
                                          },
                                          items: _shiftJson.map((Map map) {
                                            return new DropdownMenuItem(
                                              value: map['id'].toString(),
                                              child: Text(map['shift']),
                                            );
                                          }).toList(),
                                        ),
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: <Widget>[
                                          ButtonTheme(
                                            minWidth: 30.0,
                                            height: 25.0,
                                            child: RaisedButton(
                                              color: AbubaPallate.menuBluebird,
                                              child: Text(
                                                'Note',
                                                style: TextStyle(
                                                    fontSize: 12.0,
                                                    color: Colors.white),
                                              ),
                                              onPressed: () {
                                                setState(() {
                                                  _notedua = !_notedua;
                                                });
                                              },
                                            ),
                                          ),
                                        ],
                                      ),
                                      _notedua
                                          ? Container(
                                              padding: const EdgeInsets.only(
                                                  top: 10.0),
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width,
                                              child: TextField(
                                                decoration: InputDecoration(
                                                    border:
                                                        OutlineInputBorder(),
                                                    hintText: 'Note',
                                                    hintStyle: TextStyle(
                                                        fontSize: 12.0)),
                                                maxLines: 3,
                                                controller: controllerNoteDua,
                                                style: TextStyle(
                                                  color: Colors.black,
                                                ),
                                              ),
                                            )
                                          : Container()
                                    ],
                                  )
                                : Container(),
                            index == 2
                                ? Column(
                                    children: <Widget>[
                                      Row(
                                        children: <Widget>[
                                          Flexible(
                                            child: Padding(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 10.0,
                                                  vertical: 20.0),
                                              child: Text(
                                                _title[index]['isi'],
                                                style: TextStyle(
                                                    color: Colors.black54,
                                                    fontSize: 28.0),
                                                textAlign: TextAlign.center,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(
                                            top: 10.0, bottom: 10.0),
                                        child: DropdownButtonFormField(
                                          hint: Text('Customer Complain',
                                              style: TextStyle(fontSize: 14.0)),
                                          value: _mySelection,
                                          onChanged: (String newValue) {
                                            setState(() {
                                              switch (int.tryParse(newValue)) {
                                                case 1:
                                                  _shift = 'A';
                                                  break;
                                                case 2:
                                                  _shift = 'B';
                                                  break;
                                                default:
                                                  _shift = '-';
                                                  break;
                                              }
                                              _mySelection = newValue;
                                            });
                                          },
                                          items: _shiftJson.map((Map map) {
                                            return new DropdownMenuItem(
                                              value: map['id'].toString(),
                                              child: Text(map['shift']),
                                            );
                                          }).toList(),
                                        ),
                                      ),
                                    ],
                                  )
                                : Container(),
                            index == 3
                                ? Column(
                                    children: <Widget>[
                                      Row(
                                        children: <Widget>[
                                          Flexible(
                                            child: Padding(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 10.0,
                                                  vertical: 20.0),
                                              child: Text(
                                                _title[index]['isi'],
                                                style: TextStyle(
                                                    color: Colors.black54,
                                                    fontSize: 28.0),
                                                textAlign: TextAlign.center,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Container(
                                        width:
                                            MediaQuery.of(context).size.width,
                                        child: DateTimePickerFormField(
                                          format: dateFormat,
                                          onChanged: (dt) =>
                                              setState(() => dateStart = dt),
                                          dateOnly: true,
                                          style: TextStyle(
                                              fontSize: 16.0,
                                              color: Colors.black),
                                          decoration: InputDecoration(
                                              border: UnderlineInputBorder(),
                                              labelStyle:
                                                  TextStyle(fontSize: 14.0),
                                              labelText: 'Calendar'),
                                        ),
                                      ),
                                      Container(
                                        width:
                                            MediaQuery.of(context).size.width,
                                        child: TimePickerFormField(
                                          format: timeFormat,
                                          onChanged: (t) =>
                                              setState(() => time = t),
                                          decoration: InputDecoration(
                                            border: UnderlineInputBorder(),
                                            hintText: 'Waktu',
                                            hintStyle:
                                                TextStyle(fontSize: 12.0),
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(
                                            top: 10.0, bottom: 10.0),
                                        child: DropdownButtonFormField(
                                          hint: Text('Shift',
                                              style: TextStyle(fontSize: 14.0)),
                                          value: _mySelection,
                                          onChanged: (String newValue) {
                                            setState(
                                              () {
                                                switch (
                                                    int.tryParse(newValue)) {
                                                  case 1:
                                                    _shift = 'A';
                                                    break;
                                                  case 2:
                                                    _shift = 'B';
                                                    break;
                                                  default:
                                                    _shift = '-';
                                                    break;
                                                }
                                                _mySelection = newValue;
                                              },
                                            );
                                          },
                                          items: _shiftJson.map(
                                            (Map map) {
                                              return new DropdownMenuItem(
                                                value: map['id'].toString(),
                                                child: Text(map['shift']),
                                              );
                                            },
                                          ).toList(),
                                        ),
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: <Widget>[
                                          ButtonTheme(
                                            minWidth: 30.0,
                                            height: 25.0,
                                            child: RaisedButton(
                                              color: AbubaPallate.menuBluebird,
                                              child: Text(
                                                'Note',
                                                style: TextStyle(
                                                    fontSize: 12.0,
                                                    color: Colors.white),
                                              ),
                                              onPressed: () {
                                                setState(
                                                  () {
                                                    _notetiga = !_notetiga;
                                                  },
                                                );
                                              },
                                            ),
                                          ),
                                        ],
                                      ),
                                      _notetiga
                                          ? Container(
                                              padding: const EdgeInsets.only(
                                                  top: 10.0),
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width,
                                              child: TextField(
                                                decoration: InputDecoration(
                                                    border:
                                                        OutlineInputBorder(),
                                                    hintText: 'Note',
                                                    hintStyle: TextStyle(
                                                        fontSize: 12.0)),
                                                maxLines: 3,
                                                controller: controllerNoteTiga,
                                                style: TextStyle(
                                                  color: Colors.black,
                                                ),
                                              ),
                                            )
                                          : Container()
                                    ],
                                  )
                                : Container(),
                            index == 4
                                ? Column(
                                    children: <Widget>[
                                      Row(
                                        children: <Widget>[
                                          Flexible(
                                            child: Padding(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 10.0,
                                                  vertical: 20.0),
                                              child: Text(
                                                _title[index]['isi'],
                                                style: TextStyle(
                                                    color: Colors.black54,
                                                    fontSize: 28.0),
                                                textAlign: TextAlign.center,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: <Widget>[
                                          ButtonTheme(
                                            minWidth: 30.0,
                                            height: 25.0,
                                            child: RaisedButton(
                                              color: AbubaPallate.menuBluebird,
                                              child: Text(
                                                'Note',
                                                style: TextStyle(
                                                    fontSize: 12.0,
                                                    color: Colors.white),
                                              ),
                                              onPressed: () {
                                                setState(
                                                  () {
                                                    _noteempat = !_noteempat;
                                                  },
                                                );
                                              },
                                            ),
                                          ),
                                        ],
                                      ),
                                      _noteempat
                                          ? Container(
                                              padding: const EdgeInsets.only(
                                                  top: 10.0),
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width,
                                              child: TextField(
                                                decoration: InputDecoration(
                                                    border:
                                                        OutlineInputBorder(),
                                                    hintText: 'Note',
                                                    hintStyle: TextStyle(
                                                        fontSize: 12.0)),
                                                maxLines: 3,
                                                controller: controllerNoteEmpat,
                                                style: TextStyle(
                                                  color: Colors.black,
                                                ),
                                              ),
                                            )
                                          : Container()
                                    ],
                                  )
                                : Container(),
                            index == 5
                                ? Column(
                                    children: <Widget>[
                                      Row(
                                        children: <Widget>[
                                          Flexible(
                                            child: Padding(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 10.0,
                                                  vertical: 20.0),
                                              child: Text(
                                                _title[index]['isi'],
                                                style: TextStyle(
                                                    color: Colors.black54,
                                                    fontSize: 28.0),
                                                textAlign: TextAlign.center,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(
                                            top: 10.0, bottom: 10.0),
                                        child: DropdownButtonFormField(
                                          hint: Text('Shift',
                                              style: TextStyle(fontSize: 14.0)),
                                          value: _mySelection,
                                          onChanged: (String newValue) {
                                            setState(
                                              () {
                                                switch (
                                                    int.tryParse(newValue)) {
                                                  case 1:
                                                    _shift = 'A';
                                                    break;
                                                  case 2:
                                                    _shift = 'B';
                                                    break;
                                                  default:
                                                    _shift = '-';
                                                    break;
                                                }
                                                _mySelection = newValue;
                                              },
                                            );
                                          },
                                          items: _shiftJson.map((Map map) {
                                            return new DropdownMenuItem(
                                              value: map['id'].toString(),
                                              child: Text(map['shift']),
                                            );
                                          }).toList(),
                                        ),
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: <Widget>[
                                          ButtonTheme(
                                            minWidth: 30.0,
                                            height: 25.0,
                                            child: RaisedButton(
                                              color: AbubaPallate.menuBluebird,
                                              child: Text(
                                                'Note',
                                                style: TextStyle(
                                                    fontSize: 12.0,
                                                    color: Colors.white),
                                              ),
                                              onPressed: () {
                                                setState(
                                                  () {
                                                    _notelima = !_notelima;
                                                  },
                                                );
                                              },
                                            ),
                                          ),
                                        ],
                                      ),
                                      _notelima
                                          ? Container(
                                              padding: const EdgeInsets.only(
                                                  top: 10.0),
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width,
                                              child: TextField(
                                                decoration: InputDecoration(
                                                    border:
                                                        OutlineInputBorder(),
                                                    hintText: 'Note',
                                                    hintStyle: TextStyle(
                                                        fontSize: 12.0)),
                                                maxLines: 3,
                                                controller: controllerNoteLima,
                                                style: TextStyle(
                                                  color: Colors.black,
                                                ),
                                              ),
                                            )
                                          : Container()
                                    ],
                                  )
                                : Container(),
                            index == 6
                                ? Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      Row(
                                        children: <Widget>[
                                          Flexible(
                                            child: Padding(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 10.0,
                                                  vertical: 20.0),
                                              child: Text(
                                                _title[index]['isi'],
                                                style: TextStyle(
                                                    color: Colors.black54,
                                                    fontSize: 28.0),
                                                textAlign: TextAlign.center,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(
                                            top: 10.0, bottom: 10.0),
                                        child: DropdownButtonFormField(
                                          hint: Text('Shift',
                                              style: TextStyle(fontSize: 14.0)),
                                          value: _mySelection,
                                          onChanged: (String newValue) {
                                            setState(
                                              () {
                                                switch (
                                                    int.tryParse(newValue)) {
                                                  case 1:
                                                    _shift = 'A';
                                                    break;
                                                  case 2:
                                                    _shift = 'B';
                                                    break;
                                                  default:
                                                    _shift = '-';
                                                    break;
                                                }
                                                _mySelection = newValue;
                                              },
                                            );
                                          },
                                          items: _shiftJson.map(
                                            (Map map) {
                                              return new DropdownMenuItem(
                                                value: map['id'].toString(),
                                                child: Text(map['shift']),
                                              );
                                            },
                                          ).toList(),
                                        ),
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: <Widget>[
                                          ButtonTheme(
                                            minWidth: 30.0,
                                            height: 25.0,
                                            child: RaisedButton(
                                              color: AbubaPallate.menuBluebird,
                                              child: Text(
                                                'Note',
                                                style: TextStyle(
                                                    fontSize: 12.0,
                                                    color: Colors.white),
                                              ),
                                              onPressed: () {
                                                setState(
                                                  () {
                                                    _noteenam = !_noteenam;
                                                  },
                                                );
                                              },
                                            ),
                                          ),
                                        ],
                                      ),
                                      _noteenam
                                          ? Container(
                                              padding: const EdgeInsets.only(
                                                  top: 10.0),
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width,
                                              child: TextField(
                                                decoration: InputDecoration(
                                                    border:
                                                        OutlineInputBorder(),
                                                    hintText: 'Note',
                                                    hintStyle: TextStyle(
                                                        fontSize: 12.0)),
                                                maxLines: 3,
                                                controller: controllerNoteEnam,
                                                style: TextStyle(
                                                  color: Colors.black,
                                                ),
                                              ),
                                            )
                                          : Container()
                                    ],
                                  )
                                : Container(),
                            index == 7
                                ? Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      Row(
                                        children: <Widget>[
                                          Flexible(
                                            child: Padding(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 10.0,
                                                  vertical: 20.0),
                                              child: Text(
                                                _title[index]['isi'],
                                                style: TextStyle(
                                                    color: Colors.black54,
                                                    fontSize: 28.0),
                                                textAlign: TextAlign.center,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(top: 30.0),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: <Widget>[
                                            ButtonTheme(
                                              height: 30.0,
                                              child: OutlineButton(
                                                child: Text(
                                                  'TIDAK',
                                                  style: TextStyle(
                                                      fontSize: 16.0,
                                                      color: Colors.redAccent),
                                                ),
                                                borderSide: BorderSide(
                                                    color: Colors.redAccent,
                                                    width: 1.0),
                                                highlightedBorderColor:
                                                    Colors.redAccent,
                                                onPressed: () {},
                                              ),
                                            ),
                                            ButtonTheme(
                                              height: 30.0,
                                              child: OutlineButton(
                                                child: Text(
                                                  'YA',
                                                  style: TextStyle(
                                                      fontSize: 16.0,
                                                      color: AbubaPallate
                                                          .greenabuba),
                                                ),
                                                borderSide: BorderSide(
                                                    color:
                                                        AbubaPallate.greenabuba,
                                                    width: 1.0),
                                                highlightedBorderColor:
                                                    AbubaPallate.greenabuba,
                                                onPressed: () {},
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  )
                                : Container(),
                            index == 8
                                ? Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: <Widget>[
                                          Flexible(
                                            child: Padding(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 10.0,
                                                  vertical: 20.0),
                                              child: Text(
                                                _title[index]['isi'],
                                                style: TextStyle(
                                                    color: Colors.black54,
                                                    fontSize: 28.0),
                                                textAlign: TextAlign.center,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(top: 20.0),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: <Widget>[
                                            ButtonTheme(
                                              height: 40.0,
                                              child: RaisedButton(
                                                child: Text(
                                                  'PAHAM',
                                                  style: TextStyle(
                                                      fontSize: 16.0,
                                                      color: Colors.white),
                                                ),
                                                color: Colors.blue,
                                                onPressed: () {
                                                  _controller.next(
                                                      animation: true);
                                                },
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  )
                                : Container(),
                            index == 9
                                ? Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: <Widget>[
                                          Flexible(
                                            child: Padding(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 10.0,
                                                  vertical: 20.0),
                                              child: Text(
                                                _title[index]['isi'],
                                                style: TextStyle(
                                                    color: Colors.black54,
                                                    fontSize: 28.0),
                                                textAlign: TextAlign.center,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(top: 20.0),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: <Widget>[
                                            ButtonTheme(
                                              height: 40.0,
                                              child: RaisedButton(
                                                child: Text(
                                                  'PAHAM',
                                                  style: TextStyle(
                                                      fontSize: 16.0,
                                                      color: Colors.white),
                                                ),
                                                color: Colors.blue,
                                                onPressed: () {
                                                  _controller.next(
                                                      animation: true);
                                                },
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  )
                                : Container(),
                            index == 10
                                ? Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: <Widget>[
                                          Flexible(
                                            child: Padding(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 10.0,
                                                  vertical: 20.0),
                                              child: Text(
                                                _title[index]['isi'],
                                                style: TextStyle(
                                                    color: Colors.black54,
                                                    fontSize: 28.0),
                                                textAlign: TextAlign.center,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(
                                            top: 10.0, bottom: 10.0),
                                        child: DropdownButtonFormField(
                                          hint: Text('Shift',
                                              style: TextStyle(fontSize: 14.0)),
                                          value: _mySelection,
                                          onChanged: (String newValue) {
                                            setState(() {
                                              switch (int.tryParse(newValue)) {
                                                case 1:
                                                  _shift = 'A';
                                                  break;
                                                case 2:
                                                  _shift = 'B';
                                                  break;
                                                default:
                                                  _shift = '-';
                                                  break;
                                              }
                                              _mySelection = newValue;
                                            });
                                          },
                                          items: _shiftJson.map((Map map) {
                                            return new DropdownMenuItem(
                                              value: map['id'].toString(),
                                              child: Text(map['shift']),
                                            );
                                          }).toList(),
                                        ),
                                      ),
                                    ],
                                  )
                                : Container(),
                            index == 11
                                ? Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: <Widget>[
                                          Flexible(
                                            child: Padding(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 10.0,
                                                  vertical: 20.0),
                                              child: Text(
                                                _title[index]['isi'],
                                                style: TextStyle(
                                                    color: Colors.black54,
                                                    fontSize: 28.0),
                                                textAlign: TextAlign.center,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(
                                            top: 10.0, bottom: 10.0),
                                        child: DropdownButtonFormField(
                                          hint: Text('Shift',
                                              style: TextStyle(fontSize: 14.0)),
                                          value: _mySelection,
                                          onChanged: (String newValue) {
                                            setState(() {
                                              switch (int.tryParse(newValue)) {
                                                case 1:
                                                  _shift = 'A';
                                                  break;
                                                case 2:
                                                  _shift = 'B';
                                                  break;
                                                default:
                                                  _shift = '-';
                                                  break;
                                              }
                                              _mySelection = newValue;
                                            });
                                          },
                                          items: _shiftJson.map((Map map) {
                                            return new DropdownMenuItem(
                                              value: map['id'].toString(),
                                              child: Text(map['shift']),
                                            );
                                          }).toList(),
                                        ),
                                      ),
                                    ],
                                  )
                                : Container(),
                            index == 12
                                ? Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: <Widget>[
                                          Flexible(
                                            child: Padding(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 10.0,
                                                  vertical: 20.0),
                                              child: Text(
                                                _title[index]['isi'],
                                                style: TextStyle(
                                                    color: Colors.black54,
                                                    fontSize: 28.0),
                                                textAlign: TextAlign.center,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(
                                            top: 10.0, bottom: 10.0),
                                        child: DropdownButtonFormField(
                                          hint: Text('Shift',
                                              style: TextStyle(fontSize: 14.0)),
                                          value: _mySelection,
                                          onChanged: (String newValue) {
                                            setState(() {
                                              switch (int.tryParse(newValue)) {
                                                case 1:
                                                  _shift = 'A';
                                                  break;
                                                case 2:
                                                  _shift = 'B';
                                                  break;
                                                default:
                                                  _shift = '-';
                                                  break;
                                              }
                                              _mySelection = newValue;
                                            });
                                          },
                                          items: _shiftJson.map((Map map) {
                                            return new DropdownMenuItem(
                                              value: map['id'].toString(),
                                              child: Text(map['shift']),
                                            );
                                          }).toList(),
                                        ),
                                      ),
                                    ],
                                  )
                                : Container(),
                            index == 13
                                ? Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: <Widget>[
                                          Flexible(
                                            child: Padding(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 10.0,
                                                  vertical: 20.0),
                                              child: Text(
                                                _title[index]['isi'],
                                                style: TextStyle(
                                                    color: Colors.black54,
                                                    fontSize: 28.0),
                                                textAlign: TextAlign.center,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(
                                            top: 10.0, bottom: 10.0),
                                        child: DropdownButtonFormField(
                                          hint: Text('Shift',
                                              style: TextStyle(fontSize: 14.0)),
                                          value: _mySelection,
                                          onChanged: (String newValue) {
                                            setState(() {
                                              switch (int.tryParse(newValue)) {
                                                case 1:
                                                  _shift = 'A';
                                                  break;
                                                case 2:
                                                  _shift = 'B';
                                                  break;
                                                default:
                                                  _shift = '-';
                                                  break;
                                              }
                                              _mySelection = newValue;
                                            });
                                          },
                                          items: _shiftJson.map((Map map) {
                                            return new DropdownMenuItem(
                                              value: map['id'].toString(),
                                              child: Text(map['shift']),
                                            );
                                          }).toList(),
                                        ),
                                      ),
                                    ],
                                  )
                                : Container(),
                            index == 14
                                ? Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: <Widget>[
                                          Flexible(
                                            child: Padding(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 10.0,
                                                  vertical: 20.0),
                                              child: Text(
                                                _title[index]['isi'],
                                                style: TextStyle(
                                                    color: Colors.black54,
                                                    fontSize: 28.0),
                                                textAlign: TextAlign.center,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Container(
                                        width:
                                            MediaQuery.of(context).size.width,
                                        child: DateTimePickerFormField(
                                          format: dateFormat,
                                          onChanged: (dt) =>
                                              setState(() => dateStart = dt),
                                          dateOnly: true,
                                          style: TextStyle(
                                              fontSize: 16.0,
                                              color: Colors.black),
                                          decoration: InputDecoration(
                                              border: UnderlineInputBorder(),
                                              labelStyle:
                                                  TextStyle(fontSize: 14.0),
                                              labelText: 'Start'),
                                        ),
                                      ),
                                    ],
                                  )
                                : Container(),
                            index == 15
                                ? Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: <Widget>[
                                          Flexible(
                                            child: Padding(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 10.0,
                                                  vertical: 20.0),
                                              child: Text(
                                                _title[index]['isi'],
                                                style: TextStyle(
                                                    color: Colors.black54,
                                                    fontSize: 28.0),
                                                textAlign: TextAlign.center,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(
                                            top: 10.0, bottom: 10.0),
                                        child: DropdownButtonFormField(
                                          hint: Text('Shift',
                                              style: TextStyle(fontSize: 14.0)),
                                          value: _mySelection,
                                          onChanged: (String newValue) {
                                            setState(() {
                                              switch (int.tryParse(newValue)) {
                                                case 1:
                                                  _shift = 'A';
                                                  break;
                                                case 2:
                                                  _shift = 'B';
                                                  break;
                                                default:
                                                  _shift = '-';
                                                  break;
                                              }
                                              _mySelection = newValue;
                                            });
                                          },
                                          items: _shiftJson.map((Map map) {
                                            return new DropdownMenuItem(
                                              value: map['id'].toString(),
                                              child: Text(map['shift']),
                                            );
                                          }).toList(),
                                        ),
                                      ),
                                    ],
                                  )
                                : Container(),
                            index == 16
                                ? Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: <Widget>[
                                          Flexible(
                                            child: Padding(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 10.0,
                                                  vertical: 20.0),
                                              child: Text(
                                                _title[index]['isi'],
                                                style: TextStyle(
                                                    color: Colors.black54,
                                                    fontSize: 28.0),
                                                textAlign: TextAlign.center,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(top: 20.0),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: <Widget>[
                                            ButtonTheme(
                                              height: 40.0,
                                              child: RaisedButton(
                                                child: Text(
                                                  'PAHAM',
                                                  style: TextStyle(
                                                      fontSize: 16.0,
                                                      color: Colors.white),
                                                ),
                                                color: Colors.blue,
                                                onPressed: () {
                                                  _controller.next(
                                                      animation: true);
                                                },
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  )
                                : Container(),
                            index == 17
                                ? Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: <Widget>[
                                          Flexible(
                                            child: Padding(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 10.0,
                                                  vertical: 20.0),
                                              child: Text(
                                                _title[index]['isi'],
                                                style: TextStyle(
                                                    color: Colors.black54,
                                                    fontSize: 28.0),
                                                textAlign: TextAlign.center,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(top: 20.0),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: <Widget>[
                                            ButtonTheme(
                                              height: 40.0,
                                              child: RaisedButton(
                                                child: Text(
                                                  'PAHAM',
                                                  style: TextStyle(
                                                      fontSize: 16.0,
                                                      color: Colors.white),
                                                ),
                                                color: Colors.blue,
                                                onPressed: () {
                                                  _controller.next(
                                                      animation: true);
                                                },
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  )
                                : Container(),
                            index == 18
                                ? Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: <Widget>[
                                          Flexible(
                                            child: Padding(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 10.0,
                                                  vertical: 20.0),
                                              child: Text(
                                                _title[index]['isi'],
                                                style: TextStyle(
                                                    color: Colors.black54,
                                                    fontSize: 28.0),
                                                textAlign: TextAlign.center,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  )
                                : Container(),
                            index == 19
                                ? Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: <Widget>[
                                          Flexible(
                                            child: Padding(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 10.0,
                                                  vertical: 20.0),
                                              child: Text(
                                                _title[index]['isi'],
                                                style: TextStyle(
                                                    color: Colors.black54,
                                                    fontSize: 28.0),
                                                textAlign: TextAlign.center,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(
                                            top: 10.0, bottom: 10.0),
                                        child: DropdownButtonFormField(
                                          hint: Text('Shift',
                                              style: TextStyle(fontSize: 14.0)),
                                          value: _mySelection,
                                          onChanged: (String newValue) {
                                            setState(() {
                                              switch (int.tryParse(newValue)) {
                                                case 1:
                                                  _shift = 'A';
                                                  break;
                                                case 2:
                                                  _shift = 'B';
                                                  break;
                                                default:
                                                  _shift = '-';
                                                  break;
                                              }
                                              _mySelection = newValue;
                                            });
                                          },
                                          items: _shiftJson.map((Map map) {
                                            return new DropdownMenuItem(
                                              value: map['id'].toString(),
                                              child: Text(map['shift']),
                                            );
                                          }).toList(),
                                        ),
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: <Widget>[
                                          ButtonTheme(
                                            minWidth: 30.0,
                                            height: 25.0,
                                            child: RaisedButton(
                                              color: AbubaPallate.menuBluebird,
                                              child: Text(
                                                'Note',
                                                style: TextStyle(
                                                    fontSize: 12.0,
                                                    color: Colors.white),
                                              ),
                                              onPressed: () {
                                                setState(() {
                                                  _notetujuh = !_notetujuh;
                                                });
                                              },
                                            ),
                                          ),
                                        ],
                                      ),
                                      _notetujuh
                                          ? Container(
                                              padding: const EdgeInsets.only(
                                                  top: 10.0),
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width,
                                              child: TextField(
                                                decoration: InputDecoration(
                                                    border:
                                                        OutlineInputBorder(),
                                                    hintText: 'Note',
                                                    hintStyle: TextStyle(
                                                        fontSize: 12.0)),
                                                maxLines: 3,
                                                controller: controllerNoteTujuh,
                                                style: TextStyle(
                                                  color: Colors.black,
                                                ),
                                              ),
                                            )
                                          : Container()
                                    ],
                                  )
                                : Container(),
                            index == 20
                                ? Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: <Widget>[
                                          Flexible(
                                            child: Padding(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 10.0,
                                                  vertical: 20.0),
                                              child: Text(
                                                _title[index]['isi'],
                                                style: TextStyle(
                                                    color: Colors.black54,
                                                    fontSize: 28.0),
                                                textAlign: TextAlign.center,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(
                                            top: 10.0, bottom: 10.0),
                                        child: DropdownButtonFormField(
                                          hint: Text('Shift',
                                              style: TextStyle(fontSize: 14.0)),
                                          value: _mySelection,
                                          onChanged: (String newValue) {
                                            setState(() {
                                              switch (int.tryParse(newValue)) {
                                                case 1:
                                                  _shift = 'A';
                                                  break;
                                                case 2:
                                                  _shift = 'B';
                                                  break;
                                                default:
                                                  _shift = '-';
                                                  break;
                                              }
                                              _mySelection = newValue;
                                            });
                                          },
                                          items: _shiftJson.map((Map map) {
                                            return new DropdownMenuItem(
                                              value: map['id'].toString(),
                                              child: Text(map['shift']),
                                            );
                                          }).toList(),
                                        ),
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: <Widget>[
                                          ButtonTheme(
                                            minWidth: 30.0,
                                            height: 25.0,
                                            child: RaisedButton(
                                              color: AbubaPallate.menuBluebird,
                                              child: Text(
                                                'Note',
                                                style: TextStyle(
                                                    fontSize: 12.0,
                                                    color: Colors.white),
                                              ),
                                              onPressed: () {
                                                setState(() {
                                                  _notedelapan = !_notedelapan;
                                                });
                                              },
                                            ),
                                          ),
                                        ],
                                      ),
                                      _notedelapan
                                          ? Container(
                                              padding: const EdgeInsets.only(
                                                  top: 10.0),
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width,
                                              child: TextField(
                                                decoration: InputDecoration(
                                                    border:
                                                        OutlineInputBorder(),
                                                    hintText: 'Note',
                                                    hintStyle: TextStyle(
                                                        fontSize: 12.0)),
                                                maxLines: 3,
                                                controller:
                                                    controllerNoteDelapan,
                                                style: TextStyle(
                                                  color: Colors.black,
                                                ),
                                              ),
                                            )
                                          : Container()
                                    ],
                                  )
                                : Container(),
                            index == 21
                                ? Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: <Widget>[
                                          Flexible(
                                            child: Padding(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 10.0,
                                                  vertical: 20.0),
                                              child: Text(
                                                _title[index]['isi'],
                                                style: TextStyle(
                                                    color: Colors.black54,
                                                    fontSize: 28.0),
                                                textAlign: TextAlign.center,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Container(
                                        width:
                                            MediaQuery.of(context).size.width,
                                        child: DateTimePickerFormField(
                                          format: dateFormat,
                                          onChanged: (dt) =>
                                              setState(() => dateStart = dt),
                                          dateOnly: true,
                                          style: TextStyle(
                                              fontSize: 16.0,
                                              color: Colors.black),
                                          decoration: InputDecoration(
                                              border: UnderlineInputBorder(),
                                              labelStyle:
                                                  TextStyle(fontSize: 14.0),
                                              labelText: 'Start'),
                                        ),
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: <Widget>[
                                          ButtonTheme(
                                            minWidth: 30.0,
                                            height: 25.0,
                                            child: RaisedButton(
                                              color: AbubaPallate.menuBluebird,
                                              child: Text(
                                                'Note',
                                                style: TextStyle(
                                                    fontSize: 12.0,
                                                    color: Colors.white),
                                              ),
                                              onPressed: () {
                                                setState(() {
                                                  _notesembilan =
                                                      !_notesembilan;
                                                });
                                              },
                                            ),
                                          ),
                                        ],
                                      ),
                                      _notesembilan
                                          ? Container(
                                              padding: const EdgeInsets.only(
                                                  top: 10.0),
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width,
                                              child: TextField(
                                                decoration: InputDecoration(
                                                    border:
                                                        OutlineInputBorder(),
                                                    hintText: 'Note',
                                                    hintStyle: TextStyle(
                                                        fontSize: 12.0)),
                                                maxLines: 3,
                                                controller:
                                                    controllerNoteSembilan,
                                                style: TextStyle(
                                                  color: Colors.black,
                                                ),
                                              ),
                                            )
                                          : Container()
                                    ],
                                  )
                                : Container(),
                            index == 22
                                ? Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: <Widget>[
                                          Flexible(
                                            child: Padding(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 10.0,
                                                  vertical: 20.0),
                                              child: Text(
                                                _title[index]['isi'],
                                                style: TextStyle(
                                                    color: Colors.black54,
                                                    fontSize: 28.0),
                                                textAlign: TextAlign.center,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: <Widget>[
                                          ButtonTheme(
                                            minWidth: 30.0,
                                            height: 25.0,
                                            child: RaisedButton(
                                              color: AbubaPallate.menuBluebird,
                                              child: Text(
                                                'Note',
                                                style: TextStyle(
                                                    fontSize: 12.0,
                                                    color: Colors.white),
                                              ),
                                              onPressed: () {
                                                setState(() {
                                                  _notesepuluh = !_notesepuluh;
                                                });
                                              },
                                            ),
                                          ),
                                        ],
                                      ),
                                      _notesepuluh
                                          ? Container(
                                              padding: const EdgeInsets.only(
                                                  top: 10.0),
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width,
                                              child: TextField(
                                                decoration: InputDecoration(
                                                    border:
                                                        OutlineInputBorder(),
                                                    hintText: 'Note',
                                                    hintStyle: TextStyle(
                                                        fontSize: 12.0)),
                                                maxLines: 3,
                                                controller:
                                                    controllerNoteSepuluh,
                                                style: TextStyle(
                                                  color: Colors.black,
                                                ),
                                              ),
                                            )
                                          : Container()
                                    ],
                                  )
                                : Container(),
                            index == 23
                                ? Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: <Widget>[
                                          Flexible(
                                            child: Padding(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 10.0,
                                                  vertical: 20.0),
                                              child: Text(
                                                _title[index]['isi'],
                                                style: TextStyle(
                                                    color: Colors.black54,
                                                    fontSize: 28.0),
                                                textAlign: TextAlign.center,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: <Widget>[
                                          ButtonTheme(
                                            minWidth: 30.0,
                                            height: 25.0,
                                            child: RaisedButton(
                                              color: AbubaPallate.menuBluebird,
                                              child: Text(
                                                'Note',
                                                style: TextStyle(
                                                    fontSize: 12.0,
                                                    color: Colors.white),
                                              ),
                                              onPressed: () {
                                                setState(() {
                                                  _notesebelas = !_notesebelas;
                                                });
                                              },
                                            ),
                                          ),
                                        ],
                                      ),
                                      _notesebelas
                                          ? Container(
                                              padding: const EdgeInsets.only(
                                                  top: 10.0),
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width,
                                              child: TextField(
                                                decoration: InputDecoration(
                                                    border:
                                                        OutlineInputBorder(),
                                                    hintText: 'Note',
                                                    hintStyle: TextStyle(
                                                        fontSize: 12.0)),
                                                maxLines: 3,
                                                controller:
                                                    controllerNoteSebelas,
                                                style: TextStyle(
                                                  color: Colors.black,
                                                ),
                                              ),
                                            )
                                          : Container()
                                    ],
                                  )
                                : Container(),
                            index == 24
                                ? Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: <Widget>[
                                          Flexible(
                                            child: Padding(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 10.0,
                                                  vertical: 20.0),
                                              child: Text(
                                                _title[index]['isi'],
                                                style: TextStyle(
                                                    color: Colors.black54,
                                                    fontSize: 28.0),
                                                textAlign: TextAlign.center,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(top: 20.0),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: <Widget>[
                                            ButtonTheme(
                                              height: 40.0,
                                              child: RaisedButton(
                                                child: Text(
                                                  'PAHAM',
                                                  style: TextStyle(
                                                      fontSize: 16.0,
                                                      color: Colors.white),
                                                ),
                                                color: Colors.blue,
                                                onPressed: () {
                                                  _controller.next(
                                                      animation: true);
                                                },
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  )
                                : Container(),
                            index == 25
                                ? Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: <Widget>[
                                          Flexible(
                                            child: Padding(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 10.0,
                                                  vertical: 20.0),
                                              child: Text(
                                                _title[index]['isi'],
                                                style: TextStyle(
                                                    color: Colors.black54,
                                                    fontSize: 28.0),
                                                textAlign: TextAlign.center,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(
                                            top: 10.0, bottom: 10.0),
                                        child: DropdownButtonFormField(
                                          hint: Text('Shift',
                                              style: TextStyle(fontSize: 14.0)),
                                          value: _mySelection,
                                          onChanged: (String newValue) {
                                            setState(() {
                                              switch (int.tryParse(newValue)) {
                                                case 1:
                                                  _shift = 'A';
                                                  break;
                                                case 2:
                                                  _shift = 'B';
                                                  break;
                                                default:
                                                  _shift = '-';
                                                  break;
                                              }
                                              _mySelection = newValue;
                                            });
                                          },
                                          items: _shiftJson.map((Map map) {
                                            return new DropdownMenuItem(
                                              value: map['id'].toString(),
                                              child: Text(map['shift']),
                                            );
                                          }).toList(),
                                        ),
                                      ),
                                    ],
                                  )
                                : Container(),
                            index == 26
                                ? Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: <Widget>[
                                          Flexible(
                                            child: Padding(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 10.0,
                                                  vertical: 20.0),
                                              child: Text(
                                                _title[index]['isi'],
                                                style: TextStyle(
                                                    color: Colors.black54,
                                                    fontSize: 28.0),
                                                textAlign: TextAlign.center,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Container(
                                        width:
                                            MediaQuery.of(context).size.width,
                                        child: DateTimePickerFormField(
                                          format: dateFormat,
                                          onChanged: (dt) =>
                                              setState(() => dateStart = dt),
                                          dateOnly: true,
                                          style: TextStyle(
                                              fontSize: 16.0,
                                              color: Colors.black),
                                          decoration: InputDecoration(
                                              border: UnderlineInputBorder(),
                                              labelStyle:
                                                  TextStyle(fontSize: 14.0),
                                              labelText: 'Start'),
                                        ),
                                      ),
                                    ],
                                  )
                                : Container(),
                            index == 27
                                ? Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: <Widget>[
                                          Flexible(
                                            child: Padding(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 10.0,
                                                  vertical: 20.0),
                                              child: Text(
                                                _title[index]['isi'],
                                                style: TextStyle(
                                                    color: Colors.black54,
                                                    fontSize: 28.0),
                                                textAlign: TextAlign.center,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(top: 20.0),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: <Widget>[
                                            ButtonTheme(
                                              height: 40.0,
                                              child: RaisedButton(
                                                child: Text(
                                                  'PAHAM',
                                                  style: TextStyle(
                                                      fontSize: 16.0,
                                                      color: Colors.white),
                                                ),
                                                color: Colors.blue,
                                                onPressed: () {
                                                  _controller.next(
                                                      animation: true);
                                                },
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  )
                                : Container(),
                            index == 28
                                ? Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: <Widget>[
                                          Flexible(
                                            child: Padding(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 10.0,
                                                  vertical: 20.0),
                                              child: Text(
                                                _title[index]['isi'],
                                                style: TextStyle(
                                                    color: Colors.black54,
                                                    fontSize: 28.0),
                                                textAlign: TextAlign.center,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(
                                            top: 10.0, bottom: 10.0),
                                        child: DropdownButtonFormField(
                                          hint: Text('Shift',
                                              style: TextStyle(fontSize: 14.0)),
                                          value: _mySelection,
                                          onChanged: (String newValue) {
                                            setState(() {
                                              switch (int.tryParse(newValue)) {
                                                case 1:
                                                  _shift = 'A';
                                                  break;
                                                case 2:
                                                  _shift = 'B';
                                                  break;
                                                default:
                                                  _shift = '-';
                                                  break;
                                              }
                                              _mySelection = newValue;
                                            });
                                          },
                                          items: _shiftJson.map((Map map) {
                                            return new DropdownMenuItem(
                                              value: map['id'].toString(),
                                              child: Text(map['shift']),
                                            );
                                          }).toList(),
                                        ),
                                      ),
                                    ],
                                  )
                                : Container(),
                            index == 29
                                ? Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: <Widget>[
                                          Flexible(
                                            child: Padding(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 10.0,
                                                  vertical: 20.0),
                                              child: Text(
                                                _title[index]['isi'],
                                                style: TextStyle(
                                                    color: Colors.black54,
                                                    fontSize: 28.0),
                                                textAlign: TextAlign.center,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Container(
                                        width:
                                            MediaQuery.of(context).size.width,
                                        child: DateTimePickerFormField(
                                          format: dateFormat,
                                          onChanged: (dt) =>
                                              setState(() => dateStart = dt),
                                          dateOnly: true,
                                          style: TextStyle(
                                              fontSize: 16.0,
                                              color: Colors.black),
                                          decoration: InputDecoration(
                                              border: UnderlineInputBorder(),
                                              labelStyle:
                                                  TextStyle(fontSize: 14.0),
                                              labelText: 'Start'),
                                        ),
                                      ),
                                    ],
                                  )
                                : Container(),
                            index == 30
                                ? Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: <Widget>[
                                          Flexible(
                                            child: Padding(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 10.0,
                                                  vertical: 20.0),
                                              child: Text(
                                                _title[index]['isi'],
                                                style: TextStyle(
                                                    color: Colors.black54,
                                                    fontSize: 28.0),
                                                textAlign: TextAlign.center,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(top: 20.0),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: <Widget>[
                                            ButtonTheme(
                                              height: 40.0,
                                              child: RaisedButton(
                                                child: Text(
                                                  'PAHAM',
                                                  style: TextStyle(
                                                      fontSize: 16.0,
                                                      color: Colors.white),
                                                ),
                                                color: Colors.blue,
                                                onPressed: () {
                                                  _controller.next(
                                                      animation: true);
                                                },
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  )
                                : Container(),
                            index == 31
                                ? Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      Flexible(
                                        child: ListView.builder(
                                          shrinkWrap: true,
                                          physics: ScrollPhysics(),
                                          itemCount: textList.length,
                                          itemBuilder: (BuildContext context,
                                              int index) {
                                            return Column(
                                              children: <Widget>[
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 10.0,
                                                          left: 10.0,
                                                          right: 10.0),
                                                  child: CheckboxListTile(
                                                    value: textListValue[index],
                                                    onChanged: (bool value) {
                                                      setState(() {
                                                        textListValue[index] =
                                                            !textListValue[
                                                                index];
                                                      });
                                                    },
                                                    title: new Text(
                                                        textList[index]),
                                                    controlAffinity:
                                                        ListTileControlAffinity
                                                            .leading,
                                                    activeColor:
                                                        AbubaPallate.green,
                                                    subtitle:
                                                        Text('07/01/2019'),
                                                  ),
                                                ),
                                              ],
                                            );
                                          },
                                        ),
                                      )
                                    ],
                                  )
                                : Container(),
                            index == 32
                                ? Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      Flexible(
                                        child: ListView.builder(
                                          shrinkWrap: true,
                                          physics: ScrollPhysics(),
                                          itemCount: textList.length,
                                          itemBuilder: (BuildContext context,
                                              int index) {
                                            return Column(
                                              children: <Widget>[
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 10.0,
                                                          left: 10.0,
                                                          right: 10.0),
                                                  child: CheckboxListTile(
                                                    value: textListValue[index],
                                                    onChanged: (bool value) {
                                                      setState(() {
                                                        textListValue[index] =
                                                            !textListValue[
                                                                index];
                                                      });
                                                    },
                                                    title: new Text(
                                                        textList[index]),
                                                    controlAffinity:
                                                        ListTileControlAffinity
                                                            .leading,
                                                    activeColor:
                                                        AbubaPallate.green,
                                                    subtitle:
                                                        Text('07/01/2019'),
                                                  ),
                                                ),
                                              ],
                                            );
                                          },
                                        ),
                                      )
                                    ],
                                  )
                                : Container(),
                            index == 33
                                ? Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      Flexible(
                                        child: ListView.builder(
                                          shrinkWrap: true,
                                          physics: ScrollPhysics(),
                                          itemCount: textList.length,
                                          itemBuilder: (BuildContext context,
                                              int index) {
                                            return Column(
                                              children: <Widget>[
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 10.0,
                                                          left: 10.0,
                                                          right: 10.0),
                                                  child: CheckboxListTile(
                                                    value: textListValue[index],
                                                    onChanged: (bool value) {
                                                      setState(() {
                                                        textListValue[index] =
                                                            !textListValue[
                                                                index];
                                                      });
                                                    },
                                                    title: new Text(
                                                        textList[index]),
                                                    controlAffinity:
                                                        ListTileControlAffinity
                                                            .leading,
                                                    activeColor:
                                                        AbubaPallate.green,
                                                    subtitle:
                                                        Text('07/01/2019'),
                                                  ),
                                                ),
                                              ],
                                            );
                                          },
                                        ),
                                      )
                                    ],
                                  )
                                : Container(),
                            index == 34
                                ? Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      Flexible(
                                        child: ListView.builder(
                                          shrinkWrap: true,
                                          physics: ScrollPhysics(),
                                          itemCount: textList.length,
                                          itemBuilder: (BuildContext context,
                                              int index) {
                                            return Column(
                                              children: <Widget>[
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 10.0,
                                                          left: 10.0,
                                                          right: 10.0),
                                                  child: CheckboxListTile(
                                                    value: textListValue[index],
                                                    onChanged: (bool value) {
                                                      setState(() {
                                                        textListValue[index] =
                                                            !textListValue[
                                                                index];
                                                      });
                                                    },
                                                    title: new Text(
                                                        textList[index]),
                                                    controlAffinity:
                                                        ListTileControlAffinity
                                                            .leading,
                                                    activeColor:
                                                        AbubaPallate.green,
                                                    subtitle:
                                                        Text('07/01/2019'),
                                                  ),
                                                ),
                                              ],
                                            );
                                          },
                                        ),
                                      )
                                    ],
                                  )
                                : Container(),
                          ],
                        ),
                      );
                    },
                    controller: _controller,
                    autoplay: _autoplay,
                    itemCount: _title.length,
                    itemWidth: MediaQuery.of(context).size.width,
                    itemHeight: MediaQuery.of(context).size.height - 250.0,
                    index: _currentIndex,
                    layout: SwiperLayout.TINDER,
                    onIndexChanged: (int index) {
                      setState(
                        () {
                          _currentIndex = index;
                          _number = index + 1;
                        },
                      );
                    },
                  ),
                  SizedBox(
                    height: 5.0,
                  ),
                ],
              ),
            ],
          ),
        ),
        bottomNavigationBar: _bottomBar(),
      ),
    );
  }

  _bottomBar() {
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
                        _controller.previous(animation: true);
                      },
                      tooltip: 'Previous',
                    ),
                    _currentIndex == 8 ||
                            _currentIndex == 9 ||
                            _currentIndex == 16 ||
                            _currentIndex == 17 ||
                            _currentIndex == 24 ||
                            _currentIndex == 27 ||
                            _currentIndex == 30
                        ? IconButton(
                            icon: Icon(Icons.arrow_forward_ios,
                                color: Color(0xFF2F592F)),
                            onPressed: () {},
                            tooltip: 'Next',
                          )
                        : IconButton(
                            icon: Icon(Icons.arrow_forward_ios,
                                color: Colors.white),
                            onPressed: () {
                              _controller.next(animation: true);
                            },
                            tooltip: 'Next',
                          ),
                  ],
                )
              ],
            ),
          ),
          decoration: BoxDecoration(color: Color(0xFF2F592F))),
    );
  }

  Widget _appBar() {
    int _ofAll = _title.length - 1;
    int _ofDepan = _number - 1;

    return AppBar(
      elevation: 0.25,
      backgroundColor: Colors.white,
      iconTheme: IconThemeData(color: Colors.black),
      title: Image.asset(
        'assets/images/logo.png',
        height: 100.0,
        width: 120.0,
      ),
      bottom: PreferredSize(
        preferredSize: Size.fromHeight(110.0),
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
                          _title[_currentIndex]['title'],
                          style: TextStyle(color: Colors.white, fontSize: 12.0),
                          textAlign: TextAlign.start,
                        ),
                        _ofDepan == 0
                            ? Container()
                            : Text(
                                '${_ofDepan.toString()} of ${_ofAll.toString()}',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 12.0),
                                textAlign: TextAlign.start,
                              ),
                      ],
                    ),
                  ),
                  decoration: BoxDecoration(color: Color(0xFF2F592F))),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: 55.0,
              child: Container(
                child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              'Detail Review',
                              style: TextStyle(
                                  color: Colors.black54, fontSize: 16.0),
                              textAlign: TextAlign.start,
                            ),
                            Text(
                              '',
                              style: TextStyle(
                                  color: Colors.black54, fontSize: 16.0),
                              textAlign: TextAlign.start,
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              'Document Control ',
                              style: TextStyle(
                                  color: Colors.black54, fontSize: 12.0),
                              textAlign: TextAlign.start,
                            ),
                            Text(
                              '',
                              style: TextStyle(
                                  color: Colors.black54, fontSize: 12.0),
                              textAlign: TextAlign.start,
                            ),
                          ],
                        ),
                      ],
                    )),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
