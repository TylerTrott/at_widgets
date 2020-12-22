import 'package:at_client_mobile/at_client_mobile.dart';
import 'package:at_contacts_flutter/services/contact_service.dart';

void initializeContactsService(
    AtClientImpl atClientInstance, String currentAtSign,
    {rootDomain = 'root.atsign.wtf', rootPort = 64}) {
  ContactService().initContactsService(
      atClientInstance, currentAtSign, rootDomain, rootPort);
}

void disposeContactsControllers() {
  ContactService().disposeControllers();
}
