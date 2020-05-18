import 'dart:async';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:qrscan/qrscan.dart' as scanner;

class Scanning extends StatefulWidget {
  @override
  _ScanningState createState() => _ScanningState();
}

class _ScanningState extends State<Scanning> {
  Uint8List bytes = Uint8List(0);
  TextEditingController _outputController;

  @override
  initState() {
    super.initState();
    this._outputController = new TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: SafeArea(
          child: Container(
            color: Color(0xfffaf2f2),
            child: Column(
              children: <Widget>[
                //SizedBox(height: 50),
                TextField(
                  controller: this._outputController,
                  maxLines: 2,
                  decoration: InputDecoration(
                    enabled: false,
                    prefixIcon: Icon(Icons.priority_high),
                    hintText:
                    'The barcode or qrcode you scan will be displayed in this area.',
                    hintStyle: TextStyle(fontSize: 16),
                    contentPadding:
                    EdgeInsets.symmetric(horizontal: 7, vertical: 15),
                  ),
                ),
                FlatButton.icon(onPressed: _scan,
                  icon: Icon(Icons.announcement),
                  label: Text('Tap to Scan'),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }


  Future _scan() async {
    String qrcode = await scanner.scan();
    if (qrcode == null) {
      print('nothing return.');
    } else {
      this._outputController.text = qrcode;
    }
  }
}
