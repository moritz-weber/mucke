import 'package:audio_service/audio_service.dart';
import 'package:flutter/material.dart';

class AudioServiceWidget extends StatefulWidget {
  const AudioServiceWidget({@required this.child});

  final Widget child;

  @override
  _AudioServiceWidgetState createState() => _AudioServiceWidgetState();
}

class _AudioServiceWidgetState extends State<AudioServiceWidget>
    with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    AudioService.connect();
  }

  @override
  void dispose() {
    AudioService.disconnect();
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.resumed:
        AudioService.connect();
        break;
      case AppLifecycleState.paused:
        AudioService.disconnect();
        break;
      default:
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        AudioService.disconnect();
        return true;
      },
      child: widget.child,
    );
  }
}
