import 'package:flutter/material.dart';

import 'package:final_flutter/screens/AppLanguage.dart';
import 'package:final_flutter/screens/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:final_flutter/screen1.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  AppLanguage appLanguage = AppLanguage();
  await appLanguage.fetchLocale();
  runApp(FirstRoute(
    appLanguage: appLanguage,
  ));
}

class FirstRoute extends StatelessWidget {
  final AppLanguage appLanguage;

  FirstRoute({this.appLanguage});
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<AppLanguage>(
      create: (_) => appLanguage,
      child: Consumer<AppLanguage>(builder: (context, model, child) {
        return MaterialApp(
          title: 'FlutterDemo',
          locale: model.appLocal,
          supportedLocales: [
            Locale('en', ''),
            Locale('hi', ''),
          ],
          localizationsDelegates: [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
          ],
          home: main_screen1(),
        );
      }),
    );
  }
}
