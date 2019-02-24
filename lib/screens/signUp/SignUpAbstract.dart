import './../../model/SignUpDetail.dart';

abstract class AbstractSignUpPresenter {
  void onSignUp(SignUpDetail signUpDetail);
}

abstract class AbstractSignUpPage {
  void onSignUpSuccess(String message);
}
