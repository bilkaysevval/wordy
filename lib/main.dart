import 'package:flutter/material.dart';
import 'package:wordy/project_pages/temporary_page_view.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          scaffoldBackgroundColor: const Color.fromRGBO(249, 249, 249, 1)),
      home: const TemporaryPageView(),
    );
  }
}
