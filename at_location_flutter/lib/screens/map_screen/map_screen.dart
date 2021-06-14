import 'package:at_location_flutter/at_location_flutter.dart';
import 'package:at_location_flutter/common_components/collapsed_content.dart';
import 'package:at_location_flutter/common_components/floating_icon.dart';
import 'package:at_location_flutter/location_modal/location_notification.dart';
import 'package:at_location_flutter/service/at_location_notification_listener.dart';
import 'package:flutter/material.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:at_common_flutter/services/size_config.dart';

// ignore: must_be_immutable
class MapScreen extends StatefulWidget {
  final LocationNotificationModel userListenerKeyword;
  String currentAtSign;

  MapScreen({this.currentAtSign, this.userListenerKeyword});

  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  final PanelController pc = PanelController();
  GlobalKey<ScaffoldState> scaffoldKey;
  List<String> atsignsToTrack;

  @override
  void initState() {
    super.initState();
    scaffoldKey = GlobalKey<ScaffoldState>();
    atsignsToTrack =
        widget.userListenerKeyword.atsignCreator == widget.currentAtSign
            ? []
            : [widget.userListenerKeyword.atsignCreator];

    if (!widget.userListenerKeyword.atsignCreator.contains('@')) {
      widget.userListenerKeyword.atsignCreator =
          '@' + widget.userListenerKeyword.atsignCreator;
    }

    if (!widget.currentAtSign.contains('@')) {
      widget.currentAtSign = '@' + widget.currentAtSign;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          key: scaffoldKey,
          body: Stack(
            children: [
              AtLocationFlutterPlugin(
                atsignsToTrack,
                calculateETA: true,
                addCurrentUserMarker: true,
                // etaFrom: LatLng(44, -112),
                // textForCenter: 'Final',
              ),
              Positioned(
                top: 0,
                left: 0,
                child: FloatingIcon(
                  icon: Icons.arrow_back,
                  isTopLeft: true,
                  onPressed: () => Navigator.pop(context),
                ),
              ),
              SlidingUpPanel(
                controller: pc,
                minHeight: widget.userListenerKeyword != null
                    ? 130.toHeight < 130
                        ? 130
                        : 130.toHeight
                    : 205.toHeight,
                maxHeight: widget.userListenerKeyword != null
                    ? ((widget.userListenerKeyword.atsignCreator ==
                            widget.currentAtSign)
                        ? 291.toHeight
                        : 130.toHeight < 130
                            ? 130
                            : 130.toHeight)
                    : 431.toHeight,
                panel: CollapsedContent(
                    true, AtLocationNotificationListener().atClientInstance,
                    userListenerKeyword: widget.userListenerKeyword,
                    currentAtSign: widget.currentAtSign),
              )
            ],
          )),
    );
  }
}
