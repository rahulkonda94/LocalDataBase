import './OfferEditAbstract.dart';
import './../../model/OfferDetail.dart';
import './../../database/Offersdb_helper.dart';

class OfferEditPresenter implements AbstractOfferEditPresenter {
  AbstractOfferEditPage _view;

  OffersDatabaseHelper databaseHelper = OffersDatabaseHelper();

  OfferEditPresenter(AbstractOfferEditPage view) {
    _view = view;
  }

  @override
  void updateOffer(OfferDetail offer) async {
    int i = await databaseHelper.updateOffer(offer);
    if (i != 0) {
      _view.showMessage('offer Updated successfully');
    }
  }
}
