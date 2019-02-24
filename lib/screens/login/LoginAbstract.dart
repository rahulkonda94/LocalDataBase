import './../../model/SignUpDetail.dart';

abstract class AbstractLoginPresenter {
  void onLogin(SignUpDetail signUpDetail);
}

abstract class AbstractLoginPage {
  void onLoginSuccess();
  void showMessage(String message);
}
