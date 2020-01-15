

abstract class ContactListModelContract {
  Future<List> getContact();
  setSharedPreference(contacts);
  search(searchText,contactDetails);
}

abstract class ContactListViewContract {
  void showContactList(List contactList);
}

abstract class ContactListPresenterContract {
  Future viewDisplayed();
  passSearchText(searchText,contactDetails);
  saveContactDetails(contacts);
}


abstract class ContactDetailsModelContract {
  Future<Map> getDetails();
}

abstract class ContactDetailsViewContract{
  void showContactDetails(Map contactDetails);
}

abstract class ContactDetailsPresenterContract {
  Future viewDisplayed();
}

abstract class AddContactModelContract {
  Future<Map> addContact(Map contact);
}

abstract class AddContactPresenterContract{
  addContact(Map contact);
}

abstract class DeleteContactModelContract {
  Future<Map> deleteContact(userid);
}

abstract class DeleteServerPresenterContract {
  deleteServer(userid);
}

abstract class UpdateContactModelContract {
  void updateContact(Map contacts);
}

abstract class UpdateContactPresenterContract {
  updateContact(Map contacts);
}
