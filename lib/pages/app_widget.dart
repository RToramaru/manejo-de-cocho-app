import 'package:flutter/material.dart';
import 'package:leitura_cocho/pages/search.dart';
import 'package:leitura_cocho/pages/settings.dart';

import 'calculate.dart';
import 'history_page.dart';
import 'home_page.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: {
        '/': (context) => const HomePage(),
        '/search': (context) => const SearchPage(),
        '/calculate': (context) => const CalculatePage(),
        '/history': (context) => const HistoryPage(),
        '/settings': (context) => const SetttingPage(),
      },
    );
  }
}
