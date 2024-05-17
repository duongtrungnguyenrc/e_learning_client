import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:lexa/presentation/app/app.dart';
import 'package:flutter/material.dart';

void main() async {
  await dotenv.load(fileName: ".env");
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const App());
}
