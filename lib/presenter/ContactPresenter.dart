
import 'package:binary_tasks/contracts/ContactContract.dart';

class ContactPresenter implements ContactListPresenterContract {

  ContactListModelContract _model;
  ContactListViewContract _view;

  ContactPresenter(this._model,this._view);

  @override
  Future viewDisplayed() async{
    List contactList = await _model.getContact();
    _view.showContactList(contactList);
  }

  @override
  saveContactDetails(contacts) {
    _model.setSharedPreference(contacts);
  }

  @override
  passSearchText(searchText,contactDetails) {
    return _model.search(searchText,contactDetails);
  }



}

class AddContactPresenter implements AddContactPresenterContract {

  AddContactModelContract _model;
  AddContactPresenter(this._model);

  @override
  addContact(Map contact) {
    _model.addContact(contact);
  }

}

class DeleteContactPresenter implements DeleteServerPresenterContract{

  DeleteContactModelContract _model;
  DeleteContactPresenter(this._model);

  @override
  deleteServer(userid) {
    _model.deleteContact(userid);
  }

}

class UpdateContactPresenter implements UpdateContactPresenterContract {

  UpdateContactModelContract _model;
  UpdateContactPresenter(this._model);

  @override
  updateContact(Map contacts) {
    _model.updateContact(contacts);
  }
}

class ContactDetailsPresenter implements ContactDetailsPresenterContract {

  ContactDetailsModelContract _model;
  ContactDetailsViewContract _view;

  ContactDetailsPresenter(this._model, this._view);

  @override
  Future viewDisplayed() async{
    Map contactDetails = await _model.getDetails();
    _view.showContactDetails(contactDetails);
  }
}