import 'package:flutter/material.dart';
import 'package:logo_picker/dependency_injection.dart';
import 'package:logo_picker/models/company_logos/ui/home_screen.dart';

void main() async {
  await inject();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Home(),
    );
  }
}
