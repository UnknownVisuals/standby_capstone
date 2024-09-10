import 'package:flutter/material.dart';
import 'package:standby_capstone/constants.dart';

class AddRemoveStaff extends StatefulWidget {
  const AddRemoveStaff({super.key});

  @override
  State<AddRemoveStaff> createState() => _AddRemoveStaffState();
}

class _AddRemoveStaffState extends State<AddRemoveStaff> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: kGray,
        child: const Center(
          child: Text('Add/Remove Staff'),
        ),
      ),
    );
  }
}
