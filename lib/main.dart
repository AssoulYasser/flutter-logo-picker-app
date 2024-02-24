import 'package:flutter/material.dart';
import 'package:logo_picker/core/data_state.dart';
import 'package:logo_picker/dependency_injection.dart';
import 'package:logo_picker/models/company_logos/domain/use_cases/get_company_logo.dart';

void main() async {
  await inject();
  final logo = di.get<GetCompanyLogo>();
  logo('Microsoft').then(
    (result) {
      if (result is Failed) 
        print(result.error);
      else
        print(result.data?.name);
    },
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(body: Center(child: Text("Hello World"))));
  }
}
