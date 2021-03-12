import 'package:flutter/material.dart';
import 'package:stackoverflow_66578657/contact.dart';

class ContactProvider extends ChangeNotifier {
  final List<Contact> _contacts = [];
  List<Contact> get contacts => _contacts;

  void addContacts(List<Contact> newContacts) {
    _contacts.addAll(newContacts);
    notifyListeners();
  }

  void notifyContactUpdated(Contact contact) {
    // You might want to update the contact in your database,
    // send it to your backend, etc...
    // Here we don't have these so we just notify our listeners :
    notifyListeners();
  }
}
