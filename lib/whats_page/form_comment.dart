import 'package:flutter/material.dart';
import 'package:flutter_abuba/constant.dart';
import 'package:flutter_abuba/beranda/beranda_appbardua.dart';

class FormComment extends StatefulWidget {
  @override
  _FormCommentState createState() => _FormCommentState();
}

class _FormCommentState extends State<FormComment> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AbubaAppBar(),
        body: GestureDetector(
          onTap: () {
            FocusScope.of(context).requestFocus(FocusNode());
          },
          child: _buildFormComment(),
        ),
      ),
    );
  }

  Widget _buildFormComment() {
    return ListView(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Text(
                'What\'s New',
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
                  'Comments',
                  style:
                      TextStyle(color: AbubaPallate.greenabuba, fontSize: 12.0),
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 8.0),
          child: Container(
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15.0), color: Colors.white),
            child: Padding(
              padding: EdgeInsets.all(12.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Container(
                    width: 50.0,
                    height: 50.0,
                    margin: EdgeInsets.only(bottom: 10.0),
                    decoration: new BoxDecoration(
                      shape: BoxShape.circle,
                      image: new DecorationImage(
                        fit: BoxFit.fill,
                        image: NetworkImage(
                            "https://www.biography.com/.image/ar_1:1%2Cc_fill%2Ccs_srgb%2Cg_face%2Cq_auto:good%2Cw_300/MTE5NTU2MzE2NDE4MzExNjkx/jackie-chan-9542080-1-402.jpg"),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 12.0,
                  ),
                  Flexible(
                    child: Text(
                        'Jangan lupa besok tanggal 17 Agustus 2018 kita merayakan ulang tahun ABUBA yang ke 100. Datang dengan kostum yang seru ya !',
                        style:
                            TextStyle(fontSize: 12.0, color: Colors.black38)),
                  ),
                ],
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(20.0, 8.0, 20.0, 8.0),
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
          padding: const EdgeInsets.fromLTRB(20.0, 8.0, 20.0, 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                width: 50.0,
                height: 50.0,
                margin: EdgeInsets.only(bottom: 10.0, right: 8.0),
                decoration: new BoxDecoration(
                  shape: BoxShape.circle,
                  image: new DecorationImage(
                    fit: BoxFit.fill,
                    image: NetworkImage(
                        "https://www.biography.com/.image/ar_1:1%2Cc_fill%2Ccs_srgb%2Cg_face%2Cq_auto:good%2Cw_300/MTE5NTU2MzE2NDE4MzExNjkx/jackie-chan-9542080-1-402.jpg"),
                  ),
                ),
              ),
              Container(
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
              ButtonTheme(
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
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Divider(
            height: 8.0,
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(20.0, 8.0, 20.0, 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Container(
                width: 50.0,
                height: 50.0,
                margin: EdgeInsets.only(bottom: 10.0),
                decoration: new BoxDecoration(
                  shape: BoxShape.circle,
                  image: new DecorationImage(
                    fit: BoxFit.fill,
                    image: NetworkImage(
                        "https://www.biography.com/.image/ar_1:1%2Cc_fill%2Ccs_srgb%2Cg_face%2Cq_auto:good%2Cw_300/MTE5NTU2MzE2NDE4MzExNjkx/jackie-chan-9542080-1-402.jpg"),
                  ),
                ),
              ),
              SizedBox(
                width: 12.0,
              ),
              Container(
                width: 250.0,
                child: Row(
                  children: <Widget>[
                    Flexible(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            'Ridwan . IT . 3 months ago',
                            style: TextStyle(
                                color: Colors.grey[500], fontSize: 10.0),
                          ),
                          SizedBox(height: 5.0,),
                          Text(
                            'OK Siap, saya pasti datang paling pagi sebelum yang laindating. Udah nggak sabar nih buat merayakan ultah ABUBA !',
                            style: TextStyle(color: Colors.black54, fontSize: 12.0),
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
    );
  }
}