
import 'package:binary_tasks/contracts/ContactContract.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class ContactModel implements ContactListModelContract, AddContactModelContract, DeleteContactModelContract, UpdateContactModelContract, ContactDetailsModelContract{

  var userId;
  SharedPreferences prefs;
  List contactList = List();

  @override
  Future<List> getContact() async {
    var response = await http.get("https://mock-rest-api-server.herokuapp.com/api/v1/user");

    var convertToJson = json.decode(response.body);
    var contactdetails = convertToJson['data'];

    contactdetails.forEach((contactName) {
      contactList.add(contactName);
    });

    return contactList;
  }

  @override
  setSharedPreference(contacts) async{
    prefs = await SharedPreferences.getInstance();
    prefs.setString("userId", contacts['id']);
  }

  @override
  search(searchText,contactDetails) {
    List tempList = new List();
    contactDetails.forEach((item) {
      if(item["first_name"].toLowerCase().contains(searchText.toLowerCase())){
        tempList.add(item);
      }
    });

    //print(contactDetails);

    return tempList;
  }

  loadUserId() async{
    prefs = await SharedPreferences.getInstance();
    var userid = (prefs.getString("userId") ?? '');

    return userid;
  }

  @override
  Future<Map> addContact(Map contact) async{

    var response = await http.post("https://mock-rest-api-server.herokuapp.com/api/v1/user",
        body: {
          "id" : contact['id'],
          "first_name" : contact["first_name"],
          "last_name" : contact["last_name"],
          "email" : contact["email"],
          "gender" : contact["gender"],
          "date_of_birth" : contact["date_of_birth"],
          "phone_no" : contact["phone_number"]
        }
    );

    print(response.body);

  }

  @override
  Future<Map> deleteContact(userid) async{
    await http.delete("https://mock-rest-api-server.herokuapp.com/api/v1/user/" + userid.toString());
  }

  @override
  void updateContact(Map contacts) async{
    var response = await http.put("https://mock-rest-api-server.herokuapp.com/api/v1/user/" + userId.toString(),
        body: {
          "id" : contacts['id'],
          "first_name" : contacts["first_name"],
          "last_name" : contacts["last_name"],
          "email" : contacts["email"],
          "gender" : contacts["gender"],
          "date_of_birth" : contacts["date_of_birth"],
          "phone_no" : contacts["phone_number"]
        }
    );

    print(response.body);
  }

  @override
  Future<Map> getDetails() async{

    userId = await loadUserId();

    var response = await http.get("https://mock-rest-api-server.herokuapp.com/api/v1/user/"+ userId.toString());

    var convertToJson = json.decode(response.body);
    var contactdetail = convertToJson['data'];

    Map contactdetails = {
      "contactDetails" : contactdetail
    };

    return contactdetails;
  }

}
