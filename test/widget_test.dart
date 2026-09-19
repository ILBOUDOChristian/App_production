import 'package:flutter_test/flutter_test.dart';

// Importation de l ensemble des tests unitaires et de widgets
import 'unit/app_unit_test.dart' as unit_tests;
import 'widget/app_widget_test.dart' as widget_tests;

void main() {
  group('Unit Tests Suite', unit_tests.main);
  group('Widget Tests Suite', widget_tests.main);
}
