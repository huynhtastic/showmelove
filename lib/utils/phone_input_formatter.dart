import 'package:flutter/services.dart';

class NumberTextInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(_, newVal) {
    int selectionIndex = newVal.selection.end;

    final newValText = newVal.text;
    final newValLength = newValText.length;
    final formattedVal = new StringBuffer();

    final hasArea = newValLength > 0;
    if (hasArea) {
      final isAreaShort = newValLength < 3;
      final endAreaIndex = isAreaShort ? newValLength : 3;
      final area = newValText.substring(0, endAreaIndex);
      formattedVal.write('($area)');
      selectionIndex++;
    }

    final hasPrefix = newValLength > 3;
    if (hasPrefix) {
      final isPrefixShort = newValLength < 6;
      final endPrefixIndex = isPrefixShort ? newValLength : 6;
      final prefix = newValText.substring(3, endPrefixIndex);
      formattedVal.write(' $prefix');
      selectionIndex += 2;
    }

    final hasLine = newValLength > 6;
    if (hasLine) {
      final line = newValText.substring(6, newValLength);
      formattedVal.write('-$line');
      selectionIndex++;
    }

    return new TextEditingValue(
      text: formattedVal.toString(),
      selection: new TextSelection.collapsed(offset: selectionIndex),
    );
  }
}
