class OfferDetail {
  String id;
  String title;
  int startDate;
  String terms;
  String offerImage;
  List<int> stores = null;
  String description;
  String status;
  String brandName;
  String brandId;
  int expiryDate;
  String forLoyal;
  String tnid;
  String isSubBrand;
  String offerUrlEnglish;
  OfferDetail() {}

  static OfferDetail jsonToObject(Map<String, dynamic> json) {
    OfferDetail offerDetails = OfferDetail();
    offerDetails.id = json['id'];
    offerDetails.title = json['title'];
    offerDetails.startDate = json['start_date'];
    offerDetails.terms = json['terms'];
    offerDetails.offerImage = json['offer_image'];
    offerDetails.description = json['description'];
    offerDetails.status = json['status'];
    offerDetails.brandName = json['brand_name'];
    offerDetails.brandId = json['brand_id'];
    offerDetails.expiryDate = json['expiry_date'];
    offerDetails.forLoyal = json['for_loyal'];
    offerDetails.tnid = json['tnid'];
    offerDetails.isSubBrand = json['isSubBrand'];
    offerDetails.offerUrlEnglish = json['offerUrlEnglish'];

    return offerDetails;
  }

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();

    if (id != null) {
      map['id'] = id;
    }
    map['title'] = title;
    map['start_date'] = startDate;
    map['terms'] = terms;
    map['offer_image'] = offerImage;
    map['description'] = description;
    map['brand_name'] = brandName;
    map['expiry_date'] = expiryDate;

    return map;
  }

  static OfferDetail fromMapObject(Map<String, dynamic> map) {
    OfferDetail offerDetail = OfferDetail();
    offerDetail.id = map['id'].toString();
    offerDetail.title = map['title'];
    offerDetail.startDate = map['start_date'];
    offerDetail.terms = map['terms'];
    offerDetail.offerImage = map['offer_image'];
    offerDetail.description = map['description'];
    offerDetail.brandName = map['brand_name'];
    offerDetail.expiryDate = map['expiry_date'];
    return offerDetail;
  }
}
