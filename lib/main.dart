import 'package:deskpulse/pages/pair_key_verification_page.dart';
import 'package:deskpulse/services/deskpulse_service.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  final http.Client client = http.Client();
  final DeskpulseService deskpulseService = DeskpulseService(client);

  runApp(MyApp(
    deskpulseService: deskpulseService,
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({
    super.key,
    required this.deskpulseService,
  });

  final DeskpulseService deskpulseService;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: PairKeyVerificationPage(
        deskpulseService: deskpulseService,
      ),
    );
  }
}
