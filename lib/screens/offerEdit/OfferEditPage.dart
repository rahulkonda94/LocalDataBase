import 'package:flutter/material.dart';
import 'package:anubavamtask/model/OfferDetail.dart';
import 'package:intl/intl.dart';
import 'dart:convert';

import 'package:image_picker/image_picker.dart';
import './OfferEditAbstract.dart';
import './OfferEditPresenter.dart';

class OfferEditPage extends StatefulWidget {
  OfferEditPage(this.offerDetail, {Key key, this.title}) : super(key: key);

  final String title;
  final OfferDetail offerDetail;

  @override
  _OffersEditPageState createState() => _OffersEditPageState();
}

class _OffersEditPageState extends State<OfferEditPage>
    implements AbstractOfferEditPage {
  GlobalKey<ScaffoldState> scaffoldKey;
  GlobalKey<FormState> editFormKey;
  TextEditingController dateController = TextEditingController();
  AbstractOfferEditPresenter presenter;

  var _dateTime;
  var formatter = new DateFormat('dd-MM-yyyy');

  _OffersEditPageState() {
    scaffoldKey = GlobalKey<ScaffoldState>();
    editFormKey = GlobalKey<FormState>();
    presenter = OfferEditPresenter(this);
  }

  @override
  void initState() {
    super.initState();
  }

  void openGallery() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);
    List<int> imageBytes = image.readAsBytesSync();
    setState(() {
      widget.offerDetail.offerImage = base64Encode(imageBytes);
    });
    print(widget.offerDetail.offerImage);
  }

  void openCamera() async {
    var image = await ImagePicker.pickImage(source: ImageSource.camera);
    List<int> imageBytes = image.readAsBytesSync();
    setState(() {
      widget.offerDetail.offerImage = base64Encode(imageBytes);
    });
    print(widget.offerDetail.offerImage);
  }

  _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate:
            DateTime.fromMillisecondsSinceEpoch(widget.offerDetail.expiryDate),
        firstDate: DateTime(2000),
        lastDate: DateTime(2100));
    if (picked != null &&
        picked !=
            DateTime.fromMillisecondsSinceEpoch(widget.offerDetail.expiryDate))
      setState(() {
        dateController.text = formatter.format(picked).toString();
        print(_dateTime);
        widget.offerDetail.expiryDate =
            int.parse((picked.toUtc().millisecondsSinceEpoch).toString());
        print(widget.offerDetail.expiryDate);
      });
  }

  onSave() {
    final form = editFormKey.currentState;
    form.save();
    presenter.updateOffer(widget.offerDetail);
  }

  @override
  Widget build(BuildContext context) {
    dateController.text = formatter.format(
        DateTime.fromMillisecondsSinceEpoch(widget.offerDetail.expiryDate));

    return new Scaffold(
        key: scaffoldKey,
        appBar: AppBar(
          actions: <Widget>[
            IconButton(icon: Icon(Icons.save), onPressed: onSave),
          ],
          backgroundColor: Color(0xFF3E1207),
          title: Center(
            child: Text(
              'Offer Edit',
              textAlign: TextAlign.center,
            ),
          ),
        ),
        body: Form(
            key: editFormKey,
            child: ListView(children: <Widget>[
              Container(
                padding: const EdgeInsets.all(10.0),
                child: TextFormField(
                  initialValue: widget.offerDetail.title,
                  decoration: InputDecoration(
                    labelText: 'title',
                  ),
                  onSaved: (val) => widget.offerDetail.title = val,
                ),
              ),
              Container(
                padding: const EdgeInsets.all(10.0),
                child: TextFormField(
                  initialValue: widget.offerDetail.brandName,
                  decoration: InputDecoration(
                    labelText: 'Brand Name',
                  ),
                  onSaved: (val) => widget.offerDetail.brandName = val,
                ),
              ),
              Container(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    children: <Widget>[
                      Container(
                        width: MediaQuery.of(context).size.width * 0.8,
                        child: TextFormField(
                          controller: dateController,
                          decoration: InputDecoration(
                            labelText: 'Expiry date',
                          ),
                        ),
                      ),
                      Container(
                          width: MediaQuery.of(context).size.width * 0.15,
                          child: IconButton(
                            icon: Icon(Icons.date_range),
                            onPressed: () {
                              _selectDate(context);
                            },
                          )),
                    ],
                  )),
              Container(
                padding: const EdgeInsets.symmetric(
                    vertical: 10.0, horizontal: 30.0),
                width: double.infinity,
                height: 70,
                child: RaisedButton(
                    shape: StadiumBorder(),
                    color: Theme.of(context).primaryColorDark,
                    child: Text(
                      'Upload Image',
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: openGallery),
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
                      'Camera',
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: openCamera,
                  )),
              Container(
                  height: 200,
                  child: Image.memory(
                      base64.decode(widget.offerDetail.offerImage))),
            ])));
  }

  @override
  void showMessage(message) {
    scaffoldKey.currentState.showSnackBar(SnackBar(content: Text(message)));
  }
}
