class SignUpDetail {
  String name;
  String username;
  String password;
  String email;
  String location;
  String shippingAddress;
  int mobile;
  int dob;
  int privacyPolicy;

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();

    map['name'] = name;
    map['username'] = username;
    map['email'] = email;
    map['password'] = password;
    map['location'] = location;
    map['shippingAddress'] = shippingAddress;
    map['mobile'] = mobile;
    map['dob'] = dob;
    map['privacyPolicy'] = privacyPolicy;

    return map;
  }

  static SignUpDetail fromMapObject(Map<String, dynamic> map) {
    SignUpDetail signUpDetail = SignUpDetail();
    signUpDetail.name = map['name'];
    signUpDetail.username = map['username'];
    signUpDetail.password = map['password'];
    signUpDetail.email = map['email'];
    signUpDetail.location = map['location'];
    signUpDetail.shippingAddress = map['shippingAddress'];
    signUpDetail.mobile = map['mobile'];
    signUpDetail.dob = map['dob'];
    signUpDetail.privacyPolicy = map['privacyPolicy'];

    return signUpDetail;
  }
}
