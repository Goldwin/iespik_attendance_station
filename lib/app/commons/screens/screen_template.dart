import 'package:flutter/material.dart';
import 'package:iespik_attendance_station/app/commons/widgets/appbar_leading.dart';

import '../widgets/drawer.dart';

class ScreenTemplate extends StatelessWidget {
  final Widget body;
  final String title;
  final Widget leading;

  const ScreenTemplate(
      {required this.body,
      required this.title,
      this.leading = const AppBarLeading(),
      super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: leading,
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
