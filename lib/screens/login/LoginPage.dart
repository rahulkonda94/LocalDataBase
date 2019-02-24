import 'package:flutter/material.dart';
import './../offersList/OffersListPage.dart';
import './LoginAbstract.dart';
import './LoginPresenter.dart';
import './../../model/SignUpDetail.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> implements AbstractLoginPage {
  GlobalKey<ScaffoldState> scaffoldKey;

  GlobalKey<FormState> loginFormKey;
  AbstractLoginPresenter presenter;
  SignUpDetail signUpDetail;

  _LoginPageState() {
    signUpDetail = SignUpDetail();
    presenter = LoginPresenter(this);
    scaffoldKey = GlobalKey<ScaffoldState>();
    loginFormKey = GlobalKey<FormState>();
  }

  @override
  void initState() {
    super.initState();
  }

  bool loginValidateAndSave() {
    final form = loginFormKey.currentState;

    if (form.validate()) {
      form.save();
      return true;
    }
    return false;
  }

  void loginValidateAndSubmit() {
    if (loginValidateAndSave()) {
      presenter.onLogin(signUpDetail);
    }
  }

  Widget loginScreen() => new Padding(
        padding: const EdgeInsets.all(20.0),
        child: new Form(
          key: loginFormKey,
          child: new ListView(
            children: <Widget>[
              new TextFormField(
                decoration: new InputDecoration(
                  hintText: 'sometext@gmail.com',
                  labelText: 'Email',
                  icon: const Icon(Icons.email),
                ),
                validator: (val) => !val.contains('@') ? 'Invalid Email' : null,
                onSaved: (val) => signUpDetail.email = val,
              ),
              new TextFormField(
                decoration: new InputDecoration(
                  labelText: 'Password',
                  icon: const Icon(Icons.lock_outline),
                ),
                validator: (val) =>
                    val.length < 6 ? 'Password too short' : null,
                onSaved: (val) => signUpDetail.password = val,
                obscureText: true,
              ),
              new Padding(
                padding: const EdgeInsets.only(top: 20.0),
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 0.0, horizontal: 30.0),
                width: double.infinity,
                height: 50,
                child: RaisedButton(
                  shape: StadiumBorder(),
                  color: Theme.of(context).primaryColorDark,
                  child: Text(
                    'Login',
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: loginValidateAndSubmit,
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                    vertical: 10.0, horizontal: 30.0),
                width: double.infinity,
                height: 70,
                child: RaisedButton(
                  shape: StadiumBorder(),
                  color: Theme.of(context).primaryColorDark,
                  child: Text(
                    'SignUp',
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () {
                    Navigator.pushNamed(context, '/signup');
                  },
                ),
              ),
            ],
          ),
        ),
      );

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: Text(
          'login page',
          textAlign: TextAlign.center,
        ),
      ),
      body: loginScreen(),
    );
  }

  @override
  void onLoginSuccess() {
    setState(() {
      Navigator.pop(context);
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => OffersListPage()));
    });
  }

  @override
  void showMessage(String message) {
    scaffoldKey.currentState.showSnackBar(SnackBar(content: Text(message)));
  }
}
