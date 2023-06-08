import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:intl/intl.dart';

class CustomAlertDialog extends StatefulWidget {
  const CustomAlertDialog({super.key});

  @override
  _CustomAlertDialogState createState() => _CustomAlertDialogState();
}

class _CustomAlertDialogState extends State<CustomAlertDialog> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Enter Details'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: _nameController
              ..text =
                  DateFormat("yyyy-MM-dd").format(DateTime.now()).toString(),
            readOnly: true,
            decoration: const InputDecoration(
              labelText: 'Name',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 10),
          TextField(
            controller: _amountController,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              labelText: 'Amount',
              border: OutlineInputBorder(),
            ),
          ),
        ],
      ),
      actions: [
        ElevatedButton(
          onPressed: () async {
            // Perform actions on button click
            String name = _nameController.text;
            String amount = _amountController.text;
            // Do something with the entered details
            depositRefrence = depositRefrence.child("expenses").push();
            Map map = {
              "date": name.toString(),
              "amount": amount.toString(),
              "uid": depositRefrence.key.toString()
            };
            await adddepositRefrence
                .child("expenses")
                .child(depositRefrence.key.toString())
                .set(map);

            Navigator.of(context).pop(); // Close the dialog
          },
          child: const Text('Submit'),
        ),
      ],
    );
  }
}

DatabaseReference depositRefrence = FirebaseDatabase.instance.ref();
DatabaseReference adddepositRefrence = FirebaseDatabase.instance.ref();
