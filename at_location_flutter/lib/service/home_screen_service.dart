import 'package:at_location_flutter/location_modal/location_notification.dart';
import 'package:at_location_flutter/screens/map_screen/map_screen.dart';
import 'package:flutter/material.dart';

import 'at_location_notification_listener.dart';

class HomeScreenService {
  HomeScreenService._();
  static HomeScreenService _instance = HomeScreenService._();
  factory HomeScreenService() => _instance;

  onLocationModelTap(LocationNotificationModel locationNotificationModel) {
    String currentAtsign = AtLocationNotificationListener().currentAtSign;

    if (locationNotificationModel.key.contains('sharelocation'))
      locationNotificationModel.atsignCreator != currentAtsign
          ? (locationNotificationModel.isAccepted
              ? navigatorPushToMap(locationNotificationModel)
              : AtLocationNotificationListener().showMyDialog(
                  locationNotificationModel.atsignCreator,
                  locationNotificationModel))
          : navigatorPushToMap(locationNotificationModel);
    else if (locationNotificationModel.key.contains('requestlocation'))
      locationNotificationModel.atsignCreator == currentAtsign
          ? (locationNotificationModel.isAccepted
              ? navigatorPushToMap(locationNotificationModel)
              : AtLocationNotificationListener().showMyDialog(
                  locationNotificationModel.atsignCreator,
                  locationNotificationModel))
          : (locationNotificationModel.isAccepted
              ? navigatorPushToMap(locationNotificationModel)
              : null);
  }

  navigatorPushToMap(LocationNotificationModel locationNotificationModel) {
    Navigator.push(
      AtLocationNotificationListener().navKey.currentContext,
      MaterialPageRoute(
          builder: (context) => MapScreen(
                currentAtSign: AtLocationNotificationListener().currentAtSign,
                userListenerKeyword: locationNotificationModel,
              )),
    );
  }
}

getSubTitle(LocationNotificationModel locationNotificationModel) {
  DateTime to;
  String time;
  to = locationNotificationModel.to;
  if (to != null)
    time =
        'until ${timeOfDayToString(TimeOfDay.fromDateTime(locationNotificationModel.to))} today';
  else
    time = '';
  if (locationNotificationModel.key.contains('sharelocation')) {
    return locationNotificationModel.atsignCreator ==
            AtLocationNotificationListener().currentAtSign
        ? 'Can see my location $time'
        : 'Can see their location $time';
  } else {
    return locationNotificationModel.isAccepted
        ? (locationNotificationModel.atsignCreator ==
                AtLocationNotificationListener().currentAtSign
            ? 'Sharing my location $time'
            : 'Sharing their location $time')
        : (locationNotificationModel.atsignCreator ==
                AtLocationNotificationListener().currentAtSign
            ? 'Request Location received'
            : 'Request Location sent');
  }
}

getSemiTitle(LocationNotificationModel locationNotificationModel) {
  if (locationNotificationModel.key.contains('sharelocation'))
    return locationNotificationModel.atsignCreator !=
            AtLocationNotificationListener().currentAtSign
        ? (locationNotificationModel.isAccepted
            ? null
            : locationNotificationModel.isExited
                ? 'Received Share location rejected'
                : 'Action required')
        : (locationNotificationModel.isAccepted
            ? null
            : locationNotificationModel.isExited
                ? 'Sent Share location rejected'
                : 'Awaiting response');
  else
    return locationNotificationModel.atsignCreator ==
            AtLocationNotificationListener().currentAtSign
        ? (!locationNotificationModel.isExited
            ? (locationNotificationModel.isAccepted ? null : 'Action required')
            : 'Request rejected')
        : (!locationNotificationModel.isExited
            ? (locationNotificationModel.isAccepted
                ? null
                : 'Awaiting response')
            : 'Request rejected');
}

getTitle(LocationNotificationModel locationNotificationModel) {
  if (locationNotificationModel.key.contains('sharelocation'))
    return locationNotificationModel.atsignCreator ==
            AtLocationNotificationListener().currentAtSign
        ? locationNotificationModel.receiver
        : locationNotificationModel.atsignCreator;
  else
    return locationNotificationModel.atsignCreator ==
            AtLocationNotificationListener().currentAtSign
        ? locationNotificationModel.receiver
        : locationNotificationModel.atsignCreator;
}

String timeOfDayToString(TimeOfDay time) {
  String hhmm = '${time.hour}:${time.minute}';
  return hhmm;
}