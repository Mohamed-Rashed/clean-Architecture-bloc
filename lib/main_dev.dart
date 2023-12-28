import 'package:cleanex/core/services/services_locator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'app.dart';
import 'flavors.dart';

Future<void> main() async {
  F.appFlavor = Flavor.dev;
  WidgetsFlutterBinding.ensureInitialized();
  await ServicesLocator().init();
  SystemChrome.setPreferredOrientations(<DeviceOrientation>[
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  runApp(App());
}
