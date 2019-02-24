import 'package:anubavamtask/model/SignUpDetail.dart';
import 'package:sqflite/sqflite.dart';
import './LoginAbstract.dart';
import './../../database/SignupDb_helper.dart';

class LoginPresenter implements AbstractLoginPresenter {
  AbstractLoginPage _view;
  SignUpDatabaseHelper databaseHelper = SignUpDatabaseHelper();

  LoginPresenter(AbstractLoginPage view) {
    _view = view;
  }

  @override
  void onLogin(SignUpDetail signUpDetail) async {
    try {
      List<SignUpDetail> membersList = await databaseHelper.getMembersList();
      for (int i = 0; i < membersList.length; i++) {
        print(membersList[i].email + membersList[i].password);
        print(signUpDetail.email + signUpDetail.password);
        if (membersList[i].email == signUpDetail.email &&
            membersList[i].password == signUpDetail.password) {
          _view.onLoginSuccess();
          _view.showMessage('login Success');
        }
      }
    } catch (e) {
      _view.showMessage(e.toString());
    }
  }
}
