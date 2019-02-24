import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:anubavamtask/screens/offersList/OffersListAbsract.dart';
import 'package:anubavamtask/model/OffersList.dart';
import 'package:anubavamtask/model/OfferDetail.dart';
import 'package:sqflite/sqflite.dart';
import './../../database/Offersdb_helper.dart';

class OffersListPresenter implements AbstractOfferListPresenter {
  AbstractOfferListPage _view;
  http.Client client;
  OffersList offersList;
  OffersDatabaseHelper databaseHelper = OffersDatabaseHelper();

  OffersListPresenter(AbstractOfferListPage view) {
    _view = view;
    client = http.Client();
  }

  @override
  void getOffersFromDB() {
    final Future<Database> dbFuture = databaseHelper.initializeDatabase();

    dbFuture.then((database) {
      Future<List<OfferDetail>> offeerListFuture =
          databaseHelper.getOfferList();
      offeerListFuture.then((List<OfferDetail> offerList) {
        if (offerList.length == 0) {
          getOffers();
        } else {
          _view.setOffers(offerList, true);
        }
      });
    });
  }

  @override
  getOffers() async {
    http.Response response = await client.get(
        Uri.encodeFull('http://sas.shukranrewards.com/mobile/v3/OffersList'));
    // print(response.body);

    if (response.statusCode == 200) {
      offersList = OffersList.jsonToObject(json.decode(response.body));

      _view.setOffers(offersList.data, false);
      for (int i = 0; i < offersList.data.length; i++) {
        await databaseHelper.insertOfferDetail(offersList.data[i]);
      }

      print(offersList.data[1].description);
    }
  }

  @override
  void onClickDelete(String id) async {
    int i = await databaseHelper.deleteOffer(int.parse(id));
    if (i != 0) {
      getOffersFromDB();
      _view.showMessage('offer deleted successfully');
    }
  }
}
