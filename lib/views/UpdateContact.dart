

import 'package:binary_tasks/contracts/ContactContract.dart';
import 'package:binary_tasks/model/ContactModel.dart';
import 'package:binary_tasks/presenter/ContactPresenter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class UpdateContact extends StatefulWidget {
  @override
  UpdateContactState createState() => new UpdateContactState();
}

class UpdateContactState extends State<UpdateContact> implements ContactDetailsViewContract{

  var contactDetail;

  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _DOBController = TextEditingController();
  final _mobileController = TextEditingController();
  final _genderController = TextEditingController();
  final _emailController = TextEditingController();

  UpdateContactPresenter _presenter;
  ContactDetailsPresenter _contactPresenter;

  void initState() {
    super.initState();
    _presenter = new UpdateContactPresenter(new ContactModel());
    _contactPresenter = new ContactDetailsPresenter(new ContactModel(),this);
    _contactPresenter.viewDisplayed();

  }

  //new TextEditingController.fromValue(new TextEditingValue(text: "My String")).value;

  Map updateContacts() {
    Map contact = {
      "id":contactDetail[0]["id"],
      "first_name":_firstNameController.text,
      "last_name":_lastNameController.text,
      "email":_emailController.text != null ? _emailController.text : "-",
      "gender":_genderController.text != null ? _genderController.text : "-",
      "date_of_birth":_DOBController.text,
      "phone_number":_mobileController.text,
    };

    return contact;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
            body: SafeArea(
              child: SingleChildScrollView(
                  child: Container(
                    margin: EdgeInsets.all(30),
                    child: Column (
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.only(top: 10, bottom: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Container(
                                width: 60,
                                child: Text("First Name"),
                              ),
                              Container(
                                width: 290,
                                height: 20,
                                child: TextFormField(
                                  controller: _firstNameController,
                                  decoration: InputDecoration(
                                    fillColor: Colors.transparent,
                                    filled: true,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.only(top: 10, bottom: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Container(
                                width: 60,
                                child: Text("Last Name"),
                              ),
                              Container(
                                width: 290,
                                height: 20,
                                child: TextField(
                                  controller: _lastNameController,
                                  decoration: InputDecoration(
                                    fillColor: Colors.transparent,
                                    filled: true,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.only(top: 10, bottom: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Container(
                                width: 60,
                                child: Text("Gender"),
                              ),
                              Container(
                                width: 290,
                                height: 20,
                                child: TextField(
                                  controller: _genderController,
                                  decoration: InputDecoration(
                                    fillColor: Colors.transparent,
                                    filled: true,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                        //Name, DOB, Profile photo, Mobile number.
                        Container(
                          padding: EdgeInsets.only(top: 10, bottom: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Container(
                                width: 60,
                                child: Text("DOB"),
                              ),
                              Container(
                                width: 290,
                                height: 20,
                                child: TextField(
                                  controller: _DOBController,
                                  decoration: InputDecoration(
                                    fillColor: Colors.transparent,
                                    filled: true,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.only(top: 10, bottom: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Container(
                                width: 60,
                                child: Text("Mobile Number"),
                              ),
                              Container(
                                width: 290,
                                height: 20,
                                child: TextField(
                                  controller: _mobileController,
                                  decoration: InputDecoration(
                                    fillColor: Colors.transparent,
                                    filled: true,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.only(top: 10, bottom: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Container(
                                width: 60,
                                child: Text("Email"),
                              ),
                              Container(
                                width: 290,
                                height: 20,
                                child: TextField(
                                  controller: _emailController,
                                  decoration: InputDecoration(
                                    fillColor: Colors.transparent,
                                    filled: true,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                        Container(
                          child: RaisedButton(
                            child: Text("Save"),
                            onPressed: () {
                              _presenter.updateContact(updateContacts());
                              Navigator.of(context).pushNamedAndRemoveUntil('contact:list', (Route<dynamic> route) => true);
                            },
                          ),
                        )
                      ],
                    ),
                  )
              ),
            )
        )
    );
  }

  @override
  void showContactDetails(Map contactDetails) {
    setState(() {
      contactDetail = contactDetails['contactDetails'];
      _firstNameController.text = contactDetail[0]["first_name"];
      _lastNameController.text = contactDetail[0]["last_name"];
      _DOBController.text = contactDetail[0]["date_of_birth"];
      _mobileController.text = contactDetail[0]["phone_no"];
      _genderController.text = contactDetail[0]["gender"];
      _emailController.text = contactDetail[0]["email"];
    });
  }

}