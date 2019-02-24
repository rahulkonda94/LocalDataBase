import './../../model/OfferDetail.dart';

abstract class AbstractOfferListPresenter {
  void getOffers();
  void getOffersFromDB();
  void onClickDelete(String id);
}

abstract class AbstractOfferListPage {
  void setOffers(List<OfferDetail> offList, bool isfromDB);
  void showMessage(message);
}
