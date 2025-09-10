import 'dart:io';

void openSystemCalculator() {
  if (Platform.isWindows) {
    Process.start('calc.exe', []);
  } else {
    throw UnsupportedError('Calculadora não suportada nesta plataforma.');
  }
}
