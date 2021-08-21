import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

showContactDialog({
  required BuildContext context,
  required Iterable<Contact> mContacts,
  required Function(Contact) onSelectContact,
}) {
  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    contentPadding: EdgeInsets.zero,
    title: Padding(
      padding: const EdgeInsets.only(bottom: 15.0),
      child: Text('My Contact List'),
    ),
    content: Container(
      height: 500,
      width: 300,
      child: ListView.builder(
          itemCount: mContacts.length,
          itemBuilder: (_, index) {
            Contact data = mContacts.elementAt(index);
            return Card(
              child: ListTile(
                onTap: () {
                  onSelectContact(data);
                  Navigator.pop(context);
                },
                title: Text('${data.displayName}'),
              ),
            );
          }),
    ),
  );

  // show the dialog
  return showDialog(
    context: context,
    barrierDismissible: true,
    builder: (BuildContext context) {
      return alert;
    },
  );
}
