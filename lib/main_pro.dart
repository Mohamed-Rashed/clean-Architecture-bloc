import 'package:cleanex/core/services/services_locator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'app.dart';
import 'flavors.dart';

void main() {
  F.appFlavor = Flavor.pro;
  WidgetsFlutterBinding.ensureInitialized();
  ServicesLocator().init();
  SystemChrome.setPreferredOrientations(<DeviceOrientation>[
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  runApp(App());
}
