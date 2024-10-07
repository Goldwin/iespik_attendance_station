import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(MaterialApp(
    home: Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text(
            'I Am Rich',
            style: TextStyle(color: Colors.white,),
            textAlign: TextAlign.center,
          ),
        ),
        backgroundColor: Colors.blueGrey[900],
      ),
      body: const Center(
        child: Image(image: AssetImage('images/IES.webp')),
      )
    ),
  ));
}

