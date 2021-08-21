import 'package:tracking_app/ContactListDialog.dart';
import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:tracking_app/pages/SignUpPage.dart';
import 'package:tracking_app/services/Auth_Service.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Contact> mList = [];
  AuthClass authClass = AuthClass();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("ADMIN HOME"),
          backgroundColor: Color(0xFFFF7643),
          actions: [
            IconButton(
              icon: Icon(Icons.logout),
              onPressed: () async {
                await authClass.logout();
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (builder) => SignUpPage()),
                    (route) => false);
              },
            ),
          ],
        ),
        body: ListView.builder(
            itemCount: mList.length,
            itemBuilder: (_, index) {
              Contact data = mList[index];
              return ListTile(
                title: Text('${data.displayName}'),
                subtitle: Text('${data.phones?.first.value}'),
              );
            }),
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            //check for permission
            bool permission = await Permission.contacts.isGranted;
            if (!permission) {
              PermissionStatus status = await Permission.contacts.request();
              if (status.isDenied) return;
            }
            //if permission is granted, retrieve contact list from the phone and put it in displayed dialog
            Iterable<Contact> myContacts = await ContactsService.getContacts();
            showContactDialog(
              context: context,
              mContacts: myContacts,
              //onSelectContact is to retrieve the item of choice to the current page
              onSelectContact: (selection) {
                setState(() {
                  //add the contact to the list
                  mList.add(selection);
                });
              },
            );
          },
          child: Icon(Icons.contact_phone),
          backgroundColor: Color(0xFFFF7643),
          foregroundColor: Colors.white,
        ),
      ),
    );
  }
}
