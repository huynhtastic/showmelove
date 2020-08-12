import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Authenticate extends StatefulWidget {
  @override
  _AuthenticateState createState() => _AuthenticateState();
}

class NumberTextInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(_, newVal) {
    print('text ${newVal.text}');
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

final _mobileFormatter = NumberTextInputFormatter();

class _AuthenticateState extends State<Authenticate> {
  String currentPhone = '+1';

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 400,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          // crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextFormField(
              keyboardType: TextInputType.phone,
              inputFormatters: [
                WhitelistingTextInputFormatter.digitsOnly,
                _mobileFormatter
              ],
              decoration: InputDecoration(
                hintText: 'Phone number',
                prefix: Text('+1 '),
              ),
              maxLength: 14,
            ),
            SizedBox(height: 24),
            RaisedButton(
              color: Colors.lightGreen,
              onPressed: () {},
              child: Text('Verify'),
            ),
          ],
        ),
      ),
    );
  }
}
