import 'package:at_contacts_flutter/at_contacts_flutter.dart';
import 'package:at_contacts_group_flutter/at_contacts_group_flutter.dart';
import 'package:at_contacts_group_flutter/screens/list/group_list.dart';
import 'package:at_contacts_group_flutter_example/constants.dart';
import 'package:flutter/material.dart';
import 'client_sdk_service.dart';
import 'package:at_contacts_flutter/screens/contacts_screen.dart';
import 'package:at_contacts_flutter/screens/blocked_screen.dart';

class SecondScreen extends StatefulWidget {
  @override
  _SecondScreenState createState() => _SecondScreenState();
}

class _SecondScreenState extends State<SecondScreen> {
  ClientSdkService clientSdkService = ClientSdkService.getInstance();
  String activeAtSign;
  @override
  void initState() {
    getAtSignAndInitializeContacts();
    super.initState();
  }

  @override
  void dispose() {
    disposeContactsControllers();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Second Screen'),
      ),
      body: Center(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
              child: Text(
                'Welcome $activeAtSign!',
                style: TextStyle(fontSize: 20),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                // any logic
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (BuildContext context) => ContactsScreen(),
                ));
              },
              child: Text('Show contacts'),
            ),
            ElevatedButton(
              onPressed: () {
                // any logic
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (BuildContext context) => BlockedScreen(),
                ));
              },
              child: Text('Show blocked contacts'),
            ),
            ElevatedButton(
              onPressed: () {
                // any logic
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (BuildContext context) => GroupList(),
                ));
              },
              child: Text('Show groups screen'),
            ),
          ],
        ),
      ),
    );
  }

  // ignore: always_declare_return_types
  getAtSignAndInitializeContacts() async {
    var currentAtSign = await clientSdkService.getAtSign();
    setState(() {
      activeAtSign = currentAtSign;
    });
    initializeContactsService(
        clientSdkService.atClientServiceInstance.atClient, currentAtSign,
        rootDomain: MixedConstants.ROOT_DOMAIN);
    initializeGroupService(
        clientSdkService.atClientServiceInstance.atClient, currentAtSign,
        rootDomain: MixedConstants.ROOT_DOMAIN);
  }
}
