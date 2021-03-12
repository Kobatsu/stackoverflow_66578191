import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stackoverflow_66578657/contact-provider.dart';
import 'package:stackoverflow_66578657/contacts-body.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'StackOverflow 66578191',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: Scaffold(
            appBar: AppBar(
              title: Text("StackOverflow 66578191"),
            ),
            body: ChangeNotifierProvider(
              create: (_) => ContactProvider(),
              child: Column(children: [
                Consumer<ContactProvider>(
                    builder: (_, foo, __) => Container(
                          child: Text(
                              "${foo.contacts.length} contacts - ${foo.contacts.where((c) => c.isFavorite).length} favorites"),
                          padding: EdgeInsets.symmetric(
                              horizontal: 20, vertical: 10),
                          color: Colors.amber,
                        )),
                Expanded(child: ContactsBody())
              ]),
            )));
  }
}
