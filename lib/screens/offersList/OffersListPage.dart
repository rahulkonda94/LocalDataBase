import 'package:flutter/material.dart';
import './OffersListPresenter.dart';
import 'package:anubavamtask/model/OfferDetail.dart';
import './../offersDetail/OfferDetailPage.dart';
import 'dart:convert';

import './OffersListAbsract.dart';
import './../offerEdit/OfferEditPage.dart';

class OffersListPage extends StatefulWidget {
  OffersListPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _OffersListPageState createState() => _OffersListPageState();
}

class _OffersListPageState extends State<OffersListPage>
    implements AbstractOfferListPage {
  GlobalKey<ScaffoldState> scaffoldKey;
  AbstractOfferListPresenter _presenter;
  bool isfrombd = false;

  List<OfferDetail> offerslist;

  _OffersListPageState() {
    scaffoldKey = GlobalKey<ScaffoldState>();
    _presenter = OffersListPresenter(this);
    offerslist = List<OfferDetail>();
  }

  @override
  void initState() {
    super.initState();
    _presenter.getOffersFromDB();
  }

  @override
  Widget build(BuildContext context) {
    Widget listItem(OfferDetail offerDetail) {
      return GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => OfferDetailPage(offerDetail, isfrombd)),
          );
        },
        child: Column(
          children: <Widget>[
            Container(
              height: 200,
              child: isfrombd
                  ? Image.memory(base64.decode(offerDetail.offerImage))
                  : Image.network(offerDetail.offerImage),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                    padding: EdgeInsets.fromLTRB(16.0, 5.0, 0.0, 5.0),
                    width: MediaQuery.of(context).size.width * 0.5,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          offerDetail.title,
                          maxLines: 1,
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        Row(
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
                        )
                      ],
                    )),
                Container(
                  padding: EdgeInsets.fromLTRB(0.0, 5.0, 16.0, 5.0),
                  child: Text(
                    offerDetail.brandName,
                    maxLines: 1,
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.edit),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => OfferEditPage(offerDetail)),
                    );
                  },
                ),
                IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () {
                    _presenter.onClickDelete(offerDetail.id);
                  },
                ),
                SizedBox(
                  width: 10,
                )
              ],
            )
          ],
        ),
      );
    }

    return new Scaffold(
      key: scaffoldKey,
      drawer: Drawer(),
      appBar: AppBar(
        backgroundColor: Color(0xFF3E1207),
        title: Center(
          child: Text(
            'Offers',
            textAlign: TextAlign.center,
          ),
        ),
      ),
      body: offerslist.length > 0
          ? Container(
              child: ListView.builder(
                itemCount: offerslist.length,
                itemBuilder: (BuildContext context, int index) {
                  return listItem(offerslist[index]);
                },
              ),
            )
          : Center(
              child: CircularProgressIndicator(),
            ),
    );
  }

  onItemClick(OfferDetail offerDetail) {}

  @override
  void setOffers(List<OfferDetail> offList, bool isfromDB) {
    setState(() {
      this.isfrombd = isfromDB;
      this.offerslist = offList;
    });
  }

  @override
  void showMessage(message) {
    scaffoldKey.currentState.showSnackBar(SnackBar(content: Text(message)));
  }
}
