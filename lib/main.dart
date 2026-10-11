import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

import 'app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Flutter handles the Android window; explicitly request edge-to-edge on
  // supported versions (API 29+). SafeAreas protect bars/cutouts on 15/16 too.
  await SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
  runApp(const FuzeVpnApp());
}
