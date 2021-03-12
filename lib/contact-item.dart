import 'package:flutter/material.dart';
import 'package:stackoverflow_66578657/contact-provider.dart';
import 'package:stackoverflow_66578657/contact.dart';
import 'package:provider/provider.dart';

class ContactItem extends StatefulWidget {
  final Contact contact;
  ContactItem({this.contact});

  @override
  _ContactItemState createState() => _ContactItemState();
}

class _ContactItemState extends State<ContactItem> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
        child: Padding(child: Row(children: [
          Expanded(child: Text(widget.contact.name)),
          if (widget.contact.isFavorite) Icon(Icons.favorite)
        ]), padding: EdgeInsets.symmetric(vertical: 8, horizontal: 10),),
        onTap: () {
          // the below code updates the item
          // BUT others parts of our app won't get updated because
          // we are not notifying the listeners of our ContactProvider !
          setState(() {
            widget.contact.isFavorite = !widget.contact.isFavorite;
          });

          // To update other parts, we need to use the provider
          context.read<ContactProvider>().notifyContactUpdated(widget.contact);
        });
  }
}
