import './../../model/OfferDetail.dart';

abstract class AbstractOfferEditPresenter {
  void updateOffer(OfferDetail offer);
}

abstract class AbstractOfferEditPage {
  void showMessage(message);
}
