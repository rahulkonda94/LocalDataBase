import './../model/OfferDetail.dart';

class OffersList {

String tsNow;
List<OfferDetail> data;
String success;

static OffersList jsonToObject(Map<String, dynamic> json) {
    OffersList offerDetails = new OffersList();
    offerDetails.tsNow = json['tsNow'];
    offerDetails.data = jsonToData(json['data']);
    offerDetails.success = json['success'];
    
    return offerDetails;
  }

static List<OfferDetail> jsonToData(dynamic json) {
  List<OfferDetail> offerDetailList=List<OfferDetail>();

  for(var res in json){
    offerDetailList.add(OfferDetail.jsonToObject(res));
  }
  return offerDetailList;
}

}