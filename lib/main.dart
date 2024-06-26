import 'package:advanced_flutter/app/dependancy_injection.dart';
import 'package:advanced_flutter/presentation/resources/language_manager.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';

import 'app/app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await initAppModule();
  runApp(EasyLocalization(
    supportedLocales: const [ARABIC_LOCAL, ENGLISH_LOCAL],
    path: ASSET_PATH_LOCALISATIONS,
    child: Phoenix(child: MyApp()),
  ));
}
