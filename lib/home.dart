import 'package:binary_tasks/contracts/ContactContract.dart';
import 'package:binary_tasks/model/ContactModel.dart';
import 'package:binary_tasks/presenter/ContactPresenter.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class Home extends StatefulWidget {
  @override
  HomeState createState() => new HomeState();
}

class HomeState extends State<Home> implements ContactListViewContract{

  var contactDetails;
  ContactPresenter _presenter;
  DeleteContactPresenter _deletePresenter;
  ContactModel _model;
  //List items = new List();

  List contactLists;
  String _searchText = "";

  TextEditingController editingController = TextEditingController();

  void initState() {
    super.initState();
    _presenter = new ContactPresenter(new ContactModel(), this);
    _presenter.viewDisplayed();
    _model = new ContactModel();
    _deletePresenter = new DeleteContactPresenter(new ContactModel());
  }

  HomeState() {
    editingController.addListener(() {
      if(editingController.text.isEmpty){
        setState(() {
          _searchText = "";
          contactDetails = contactLists;
        });
      }
      else {
        setState(() {
          _searchText = editingController.text;
          _presenter.passSearchText(_searchText,contactDetails);
        });
      }
    });
  }

  Widget _buildList() {
    if(_searchText.isNotEmpty) {
      var availList = _presenter.passSearchText(_searchText, contactDetails);
      contactDetails = availList;
    }
    return ListView.builder(
        shrinkWrap: true,
        itemCount: contactLists == null ? 0 : contactDetails.length,
        itemBuilder: (BuildContext context, int index) {
          return new Slidable(
            actionPane: SlidableDrawerActionPane(),
            actionExtentRatio: 0.25,
            child: new Container(
              color: Colors.white,
              child: new ListTile(
                leading: new CircleAvatar(
                  backgroundColor: Colors.indigoAccent,
                  child: new Text(contactDetails[index]["first_name"][0]),
                  foregroundColor: Colors.white,
                ),
                title: new Text(contactDetails[index]["first_name"] + " " + contactDetails[index]["last_name"]),
                subtitle: new Text(contactDetails[index]["phone_no"]),
              ),
            ),
            secondaryActions: <Widget>[
              new IconSlideAction(
                caption: 'Update',
                color: Colors.black45,
                icon: Icons.edit,
                onTap: () {
                  _presenter.saveContactDetails(contactDetails[index]);
                  Navigator.of(context).pushNamed("contact:update");
                },
              ),
              new IconSlideAction(
                caption: 'Delete',
                color: Colors.red,
                icon: Icons.delete,
                onTap: () {
                  _deletePresenter.deleteServer(contactDetails[index]["id"]);
                  Navigator.of(context).pushNamedAndRemoveUntil('contact:list', (Route<dynamic> route) => true);
                },
              ),
            ],
          );
        }
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.all(10),
            child: Column(
              children: <Widget>[
                Container(
                  child: new TextField(
                    controller: editingController,
                    decoration: InputDecoration(
                      hintText: "Search Anything", hintStyle: TextStyle(fontWeight: FontWeight.w300),
                      suffixIcon: Icon(Icons.search),
                    ),
                  ),
                ),
                Container(
                  child: _buildList()
                )
              ],
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () {
            Navigator.pushNamed(context, "contact:add");
          },
        ),
      ),
    );
  }

  @override
  void showContactList(List contactList) {
    setState(() {
      contactLists = contactList;
      contactDetails = contactLists;
    });
  }
}