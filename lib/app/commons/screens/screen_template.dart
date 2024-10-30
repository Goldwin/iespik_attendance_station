import 'package:flutter/material.dart';
import 'package:iespik_attendance_station/app/commons/widgets/appbar_leading.dart';

import '../widgets/drawer.dart';

class ScreenTemplate extends StatelessWidget {
  final Widget body;
  final String title;

  const ScreenTemplate({required this.body, required this.title, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: AppBarLeading(),
          title: Row(
            children: [
              Text(title),
            ],
          ),
        ),
        drawer: AppDrawer(),
        body: body);
  }
}
