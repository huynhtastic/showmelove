import 'package:flutter/material.dart';

class RecipientLine extends StatelessWidget {
  final String recipient;
  const RecipientLine(this.recipient, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: Row(
        children: [
          Text(
            'To:',
            style: TextStyle(fontSize: 28.0),
          ),
          SizedBox(width: 16.0),
          Chip(
            label: Text(
              recipient,
              style: TextStyle(color: Colors.white),
            ),
            backgroundColor: Colors.blue,
          ),
        ],
      ),
    );
  }
}
