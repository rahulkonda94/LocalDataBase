import 'package:flutter/material.dart';
import './../../model/OfferDetail.dart';
import 'dart:convert';

class OfferDetailPage extends StatefulWidget {
  OfferDetailPage(this.offerDetail, this.isfrombd, {Key key, this.title})
      : super(key: key);
  OfferDetail offerDetail;
  bool isfrombd;
  final String title;

  @override
  _OfferDetailPageState createState() =>
      _OfferDetailPageState(offerDetail, isfrombd);
}

class _OfferDetailPageState extends State<OfferDetailPage> {
  GlobalKey<ScaffoldState> scaffoldKey;
  OfferDetail offerDetail;
  bool isfrombd;

  _OfferDetailPageState(OfferDetail offerDetail, bool isfrombd) {
    this.offerDetail = offerDetail;
    this.isfrombd = isfrombd;
    scaffoldKey = GlobalKey<ScaffoldState>();
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        key: scaffoldKey,
        appBar: AppBar(
          backgroundColor: Color(0xFF3E1207),
          title: Center(
            child: Text(
              'Part Salesx`',
              textAlign: TextAlign.center,
            ),
          ),
          actions: <Widget>[
            Icon(
              Icons.exit_to_app,
            ),
            SizedBox(
              width: 20,
            ),
          ],
        ),
        body: GestureDetector(
          child: ListView(
            children: <Widget>[
              Container(
                height: MediaQuery.of(context).size.height * 0.3,
                child: isfrombd
                    ? Image.memory(base64.decode(offerDetail.offerImage))
                    : Image.network(offerDetail.offerImage),
              ),
              Row(
                children: <Widget>[
                  Container(
                    padding:
                        EdgeInsets.symmetric(vertical: 5.0, horizontal: 16),
                    child: Text(
                      offerDetail.brandName,
                      textAlign: TextAlign.start,
                    ),
                  ),
                ],
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  children: <Widget>[
                    Icon(
                      Icons.access_time,
                      size: 15,
                    ),
                    Text(
                      'Valid until ' +
                          DateTime.fromMillisecondsSinceEpoch(
                                  offerDetail.expiryDate)
                              .toString(),
                      style: TextStyle(fontSize: 10),
                    )
                  ],
                ),
              ),
              Container(
                height: 2.0,
                margin: EdgeInsets.fromLTRB(0.0, 05.0, 0.0, 0.0),
                color: Color(0XFFC7C7C7),
              ),
              Row(
                children: <Widget>[
                  Container(
                    width: MediaQuery.of(context).size.width * 01,
                    padding:
                        EdgeInsets.symmetric(vertical: 5.0, horizontal: 16),
                    child: Text(
                      offerDetail.terms,
                      textDirection: TextDirection.ltr,
                    ),
                  ),
                ],
              ),
              Container(
                color: Colors.brown,
                margin: EdgeInsets.fromLTRB(20, 0, 20, 0),
                padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 16),
                child: Text(
                  offerDetail.title,
                  textAlign: TextAlign.center,
                  textDirection: TextDirection.ltr,
                ),
              ),
              Column(
                children: <Widget>[
                  Container(
                    padding:
                        EdgeInsets.symmetric(vertical: 5.0, horizontal: 16),
                    child: Text(
                      offerDetail.description,
                    ),
                  ),
                ],
              ),
              Text(
                'Terms and Conditions',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16),
              )
            ],
          ),
        ));
  }
}
