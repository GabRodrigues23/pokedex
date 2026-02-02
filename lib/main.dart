import 'package:flutter/material.dart';
import 'package:pokedex/app/setup/setup_get_it_injector.dart';
import 'package:pokedex/core/router/build_app.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  setupGetItInjector();
  runApp(const BuildApp());
}
