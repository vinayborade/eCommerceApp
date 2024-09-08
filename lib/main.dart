import 'package:ecommerce_app/common/locale_provider.dart';
import 'package:ecommerce_app/helpers/navigation_helper.dart';
import 'package:ecommerce_app/locator.dart';
import 'package:ecommerce_app/router/route_generator.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  setupLocator();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: LocaleProvider(),
        ),
      ],
      child: Consumer<void>(builder: (context, authData, _) {
        return MaterialApp(
          theme: ThemeData.dark(),
          navigatorObservers: const [],
          debugShowCheckedModeBanner: false,
          title: "Ecommerce App",
          initialRoute: '/',
          navigatorKey: locator<NavigationHelper>().navigatorKey,
          onGenerateRoute: RouteGenerator.generateRoute,
        );
      }),
    );
  }
}
