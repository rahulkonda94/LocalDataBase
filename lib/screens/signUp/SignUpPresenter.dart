import 'package:anubavamtask/model/SignUpDetail.dart';
import 'package:sqflite/sqflite.dart';
import './SignUpAbstract.dart';
import './../../database/SignupDb_helper.dart';

class SignUpPresenter implements AbstractSignUpPresenter {
  AbstractSignUpPage _view;
  SignUpDatabaseHelper databaseHelper = SignUpDatabaseHelper();

  SignUpPresenter(AbstractSignUpPage view) {
    _view = view;
  }

  @override
  void onSignUp(SignUpDetail signUpDetail) async {
    final Future<Database> dbFuture = databaseHelper.initializeDatabase();
    try {
    int result = await databaseHelper.insertMember(signUpDetail);
      if (result != 0) {
      _view.onSignUpSuccess('account created Successfully');
    }
    else{
      _view.onSignUpSuccess('user already exist');
    }
    } catch (e) {
      _view.onSignUpSuccess('user already exist');
    }
    
  }
}
