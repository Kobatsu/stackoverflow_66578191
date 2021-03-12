import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:stackoverflow_66578657/contact-item.dart';
import 'package:stackoverflow_66578657/contact-provider.dart';
import 'package:stackoverflow_66578657/contact.dart';
import 'package:stackoverflow_66578657/contacts-service.dart';
import 'package:provider/provider.dart';

class ContactsBody extends StatefulWidget {
  @override
  _ContactsBodyState createState() => _ContactsBodyState();
}

class _ContactsBodyState extends State<ContactsBody> {
  static const _pageSize = 10;

  final PagingController<int, Contact> _pagingController =
      PagingController(firstPageKey: 0);

  @override
  void initState() {
    _pagingController.addPageRequestListener((pageKey) {
      _fetchPage(pageKey);
    });
    super.initState();
  }

  Future<void> _fetchPage(int pageKey) async {
    try {
      // Note : no need to make a ContactsService, this can be a static method if you only need what's done in the fetchContactsPaged method
      final newItems =
          await ContactsService.fetchContactsPaged(pageKey, _pageSize);
      final isLastPage = newItems.length < _pageSize;
      if (isLastPage) {
        _pagingController.appendLastPage(newItems);
      } else {
        final nextPageKey = pageKey + newItems.length;
        _pagingController.appendPage(newItems, nextPageKey);
      }

      // Important : we add the contacts to our provider so we can get
      // them in other parts of our app
      context.read<ContactProvider>().addContacts(newItems);
    } catch (error) {
      print(error);
      _pagingController.error = error;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Expanded(
          child: PagedListView<int, Contact>(
        pagingController: _pagingController,
        builderDelegate: PagedChildBuilderDelegate<Contact>(
          itemBuilder: (context, item, index) => ContactItem(contact: item),
        ),
      )),
      ElevatedButton(
          child: Text("How much contacts ?"),
          onPressed: () {
            // You can access the list of contacts from the _pagingController
            showDialog(
                context: context,
                builder: (context) => AlertDialog(
                      content:
                          Text("${_pagingController.itemList?.length} items"),
                      actions: [
                        ElevatedButton(
                          child: Text("Close"),
                          onPressed: () => Navigator.pop(context),
                        )
                      ],
                    ));
          })
    ]);
  }

  @override
  void dispose() {
    _pagingController.dispose();
    super.dispose();
  }
}
