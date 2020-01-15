
import 'dart:convert';
import 'dart:io';

import 'package:binary_tasks/model/ContactModel.dart';
import 'package:binary_tasks/presenter/ContactPresenter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AddContact extends StatefulWidget {
  @override
  AddContactState createState() => new AddContactState();
}

class AddContactState extends State<AddContact> {

  Future<File> file;
  String status = '';
  String base64Image;
  File tmpFile;
  String errMessage = 'Error Uploading Image';

  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _DOBController = TextEditingController();
  final _mobileController = TextEditingController();
  final _genderController = TextEditingController();
  final _emailController = TextEditingController();

  AddContactPresenter _presenter;

  void initState() {
    super.initState();
    _presenter = new AddContactPresenter(new ContactModel());
  }

  chooseImage() {
    setState(() {
      file = ImagePicker.pickImage(source: ImageSource.gallery);
    });
    setStatus('');
  }

  setStatus(String message) {
    setState(() {
      status = message;
    });
  }

  startUpload() {
    setStatus('Uploading Image...');
    if (null == tmpFile) {
      setStatus(errMessage);
      return;
    }
    String fileName = tmpFile.path.split('/').last;
  }

  Map addContacts() {
    Map contact = {
      "id":"38d322f2-290b-4a75-9778-989ca2705483",
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
                      padding: EdgeInsets.only(bottom: 20),
                      child: RaisedButton(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        onPressed: chooseImage,
                        child: showImage(),
                      ),
                    ),
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
                            child: TextField(
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
                        child: Text("save"),
                        onPressed: () {
                          if (_firstNameController == "" || _lastNameController.text == "" || _DOBController.text == "" || _mobileController == "") {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                    title: Text("Failed"),
                                    content: Text("Wrong Credentials")
                                );
                              },
                            );
                          }
                          else {
                            _presenter.addContact(addContacts());
                            Navigator.pushNamed(context, "contact:list");
                          }
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

  Widget showImage() {
    return FutureBuilder<File>(
      future: file,
      builder: (BuildContext context, AsyncSnapshot<File> snapshot) {
        OutlineButton(
          onPressed: chooseImage,
          child: Text('Choose Image'),
        );
        if (snapshot.connectionState == ConnectionState.done &&
            null != snapshot.data) {
          tmpFile = snapshot.data;
          base64Image = base64Encode(snapshot.data.readAsBytesSync());
          return Container(
            child: Image.file(
              snapshot.data,
              fit: BoxFit.fill,
            ),
          );
        } else if (null != snapshot.error) {
          return const Text(
            'Error Picking Image',
            textAlign: TextAlign.center,
          );
        } else {
          return const Text(
            'No Image Selected',
            textAlign: TextAlign.center,
          );
        }
      },
    );
  }

}