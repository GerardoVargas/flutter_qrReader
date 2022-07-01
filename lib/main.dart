import 'package:flutter/material.dart';

import 'package:qr_reader/src/pages/home_page.dart';
import 'package:qr_reader/src/pages/map_page.dart';

import 'package:provider/provider.dart';
import 'package:qr_reader/src/providers/ui_providers.dart';
import 'package:qr_reader/src/providers/scan_list_provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UiProvider()),
        ChangeNotifierProvider(create: (_) => ScanListProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'QR Reader App',
        initialRoute: 'home',
        routes: {
          'home': ( _ ) => HomePage(),
          'map': ( _ ) => MapPage(),
        },
        theme: ThemeData(
          primarySwatch: Colors.deepPurple
        ),
      ),
    );
  }
}