
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Test extends StatefulWidget{
  @override
  TestState createState() => new TestState();
}

class TestState extends State<Test>{

   final TextEditingController _filter = new TextEditingController();
   String _searchText = "";
   List names = new List(); //names from API
   List filteredNames = new List(); //names filtered by search text

   void initState() {
     super.initState();
     this._getNames();
   }

   void _getNames() async {
     final response = await http.get("https://mock-rest-api-server.herokuapp.com/api/v1/user");
     var convertToJson = json.decode(response.body);
     var contactdetails = convertToJson['data'];

     contactdetails.forEach((contact) {
       names.add(contact);
     });

     setState(() {
       filteredNames = names;
     });
   }

   TestState() {
     _filter.addListener(() {
       if(_filter.text.isEmpty){
         setState(() {
           _searchText = "";
           filteredNames = names;
         });
       }
       else {
         setState(() {
           _searchText = _filter.text;
         });
       }
     });
   }

   Widget _buildList() {
     if(!(_searchText.isEmpty)) {
       List tempList = new List();
       filteredNames.forEach((item) {
         if(item["first_name"].toLowerCase().contains(_searchText.toLowerCase())){
           tempList.add(item);
         }
       });
       filteredNames = tempList;
     }
     return ListView.builder(
       shrinkWrap: true,
       itemCount: names == null ? 0 : filteredNames.length,
         itemBuilder: (BuildContext context, int index) {
         return new ListTile(
           title: Text(filteredNames[index]["first_name"]),
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
             child:Column(
               children: <Widget>[
                 Column(
                   children: <Widget>[
                     Container(
                       child: new TextField(
                         controller: _filter,
                         decoration: InputDecoration(
                           hintText: "Search Anything", hintStyle: TextStyle(fontWeight: FontWeight.w300),
                           suffixIcon: Icon(Icons.search),
                         ),
                       ),
                     ),
                   ],
                 ),
                 _buildList()
               ],
             )
           ),
         ),
         //resizeToAvoidBottomPadding: false,
       ),
     );
   }
}

