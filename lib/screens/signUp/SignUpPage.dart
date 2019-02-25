import 'package:flutter/material.dart';
import '../../model/SignUpDetail.dart';
import './SignUpAbstract.dart';
import './SignUpPresenter.dart';
import './../login/LoginPage.dart';

class SignUpPage extends StatefulWidget {
  SignUpPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> implements AbstractSignUpPage {
  GlobalKey<ScaffoldState> scaffoldKey;

  SignUpDetail signUpDetail;
  AbstractSignUpPresenter presenter;

  GlobalKey<FormState> registrationFormKey;

  bool isPrivacy = false;

  _SignUpPageState() {
    presenter = SignUpPresenter(this);
    scaffoldKey = GlobalKey<ScaffoldState>();
    registrationFormKey = GlobalKey<FormState>();
    signUpDetail = new SignUpDetail();
  }

  @override
  void initState() {
    super.initState();
  }

  bool signUpValidateAndSave() {
    final form = registrationFormKey.currentState;

    if (form.validate()) {
      form.save();
      return true;
    }
    return false;
  }

  void signUpValidateAndSubmit() {
    if (signUpValidateAndSave()) {
      if (isPrivacy) {
        presenter.onSignUp(signUpDetail);
      } else {
        scaffoldKey.currentState.showSnackBar(
            SnackBar(content: Text('accept terms and condition')));
      }
    }
  }

  Widget registrationScreen() => Container(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Form(
        key: registrationFormKey,
        child: ListView(
          children: <Widget>[
            Container(
              child: TextFormField(
                decoration: InputDecoration(
                  hintText: 'name',
                  labelText: 'name',
                  icon: const Icon(Icons.person),
                ),
                validator: (val) => val.isEmpty ? 'name is empty' : null,
                onSaved: (val) => signUpDetail.name = val,
              ),
              padding: const EdgeInsets.only(right: 20.0),
            ),
            Container(
              child: TextFormField(
                decoration: InputDecoration(
                  hintText: 'Username',
                  labelText: 'Username',
                  icon: const Icon(Icons.person),
                ),
                validator: (val) => val.isEmpty ? 'username is empty' : null,
                onSaved: (val) => signUpDetail.username = val,
              ),
              padding: const EdgeInsets.only(right: 20.0),
            ),
            Container(
              child: Container(
                child: TextFormField(
                  decoration: InputDecoration(
                    icon: const Icon(Icons.mail),
                    hintText: 'xyz@gmail.com',
                    labelText: 'Email Id',
                  ),
                  validator: (val) =>
                      !val.contains('@') ? 'Invalid Email' : null,
                  onSaved: (val) => signUpDetail.email = val,
                  // onSaved: _signupState.setString_email,
                ),
                padding: const EdgeInsets.only(right: 20.0),
              ),
              padding: const EdgeInsets.only(top: 10.0),
            ),
            Container(
              child: Container(
                child: TextFormField(
                  decoration: InputDecoration(
                    hintText: 'password',
                    labelText: 'password',
                    icon: const Icon(Icons.lock_outline),
                  ),
                  validator: (val) =>
                      val.length < 6 ? 'Password too short' : null,
                  onSaved: (val) => signUpDetail.password = val,
                  obscureText: true,
                ),
                padding: const EdgeInsets.only(right: 20.0),
              ),
              padding: const EdgeInsets.only(top: 10.0),
            ),
            Container(
              child: Container(
                child: TextFormField(
                  decoration: InputDecoration(
                    hintText: 'Address',
                    labelText: 'Address',
                    icon: const Icon(Icons.home),
                  ),
                  validator: (val) =>
                      val.length < 5 ? 'address too short' : null,
                  onSaved: (val) => signUpDetail.location = val,
                ),
                padding: const EdgeInsets.only(right: 20.0),
              ),
              padding: const EdgeInsets.only(top: 10.0),
            ),
            Container(
              child: Container(
                child: TextFormField(
                  decoration: InputDecoration(
                    hintText: 'shipping Address',
                    labelText: 'shipping Address',
                    icon: const Icon(Icons.home),
                  ),
                  validator: (val) =>
                      val.length < 5 ? 'shipping address too short' : null,
                  onSaved: (val) => signUpDetail.shippingAddress = val,
                ),
                padding: const EdgeInsets.only(right: 20.0),
              ),
              padding: const EdgeInsets.only(top: 10.0),
            ),
            Container(
              child: Container(
                child: TextFormField(
                  keyboardType: TextInputType.datetime,
                  decoration: InputDecoration(
                    hintText: 'DD-MM-YYYY',
                    labelText: 'DOB',
                    icon: const Icon(Icons.date_range),
                  ),
                  validator: (val) =>
                      val.length == 0 ? 'Date of Birth is empty' : null,
                  onSaved: (val) => signUpDetail.dob = val,
                ),
                padding: const EdgeInsets.only(right: 20.0),
              ),
              padding: const EdgeInsets.only(top: 10.0),
            ),
            Container(
              child: Container(
                child: TextFormField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    hintText: 'Mobile No',
                    labelText: 'Mobile No',
                    icon: const Icon(Icons.mobile_screen_share),
                  ),
                  validator: (val) =>
                      val.length != 10 ? 'mobile number not valid' : null,
                  onSaved: (val) => signUpDetail.mobile = int.parse(val),
                ),
                padding: const EdgeInsets.only(right: 20.0),
              ),
              padding: const EdgeInsets.only(top: 10.0),
            ),
            Container(
              child: Row(
                children: <Widget>[
                  Checkbox(
                      value: isPrivacy,
                      onChanged: (val) {
                        setState(() {
                          isPrivacy = val;
                          val == true
                              ? signUpDetail.privacyPolicy = 1
                              : signUpDetail.privacyPolicy = 0;
                        });
                      }),
                  Text('Accept all terms and conditions')
                ],
              ),
            ),
            Container(
              padding:
                  const EdgeInsets.symmetric(vertical: 10.0, horizontal: 30.0),
              width: double.infinity,
              height: 70,
              child: RaisedButton(
                  shape: StadiumBorder(),
                  color: Theme.of(context).primaryColorDark,
                  child: Text(
                    'Sign Up',
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: signUpValidateAndSubmit),
            ),
          ],
        ),
      ));
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: Text(
          'SignUp Page',
          textAlign: TextAlign.center,
        ),
        backgroundColor: Color(0xFF3E1207),
      ),
      body: registrationScreen(),
    );
  }

  @override
  void onSignUpSuccess(String message) {
    Navigator.pop(context);
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => LoginPage()));
    scaffoldKey.currentState.showSnackBar(SnackBar(content: Text(message)));
  }
}
