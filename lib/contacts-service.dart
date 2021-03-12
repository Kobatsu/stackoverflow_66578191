import 'dart:convert';

import 'contact.dart';

class ContactsService {
  static Future<List<Contact>> fetchContactsPaged(
      int pageKey, int pageSize) async {
    // Here, you should get your data from your API

    // final response = await http.get(.....);
    // if (response.statusCode == 200) {
    //   return Contacts.fromJson(jsonDecode(response.body));
    // } else {
    //   throw Exception('Failed to load contacts');
    // }

    // I didn't do the backend part, so here is an example
    // with what I understand you get from your API:
    var responseBody =
        "{\"data\":[{\"name\":\"John\", \"isFavorite\":false},{\"name\":\"Rose\", \"isFavorite\":false}]}";
    Map<String, dynamic> decoded = json.decode(responseBody);
    List<dynamic> contactsDynamic = decoded["data"];

    List<Contact> listOfContacts =
        contactsDynamic.map((c) => Contact.fromJson(c)).toList();

    // you can return listOfContacts, for this example, I will add 
    // more Contacts for the Pagination plugin since my json only has 2 contacts
    for (int i = pageKey + listOfContacts.length; i < pageKey + pageSize; i++) {
      listOfContacts.add(Contact(name: "Name $i"));
    }
    return listOfContacts;
  }
}
