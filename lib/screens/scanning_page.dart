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
  TextEditingController _inputController;
  TextEditingController _outputController;

  @override
  initState() {
    super.initState();
    this._inputController = new TextEditingController();
    this._outputController = new TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Builder(
          builder: (BuildContext context) {
            return ListView(
              children: <Widget>[
                Container(
                  color: Color(0xfffaf2f2),
                  child: Column(
                    children: <Widget>[
                      SizedBox(height: 50),
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
                      SizedBox(height: 150),
                      this._buttonScan(),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buttonScan() {
    return SizedBox(
      height: 500,
      child: InkWell(
        onTap: _scan,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(0, 80, 0, 280),
          child: Container(
            width: 200,
            decoration: BoxDecoration(color: Color(0xfff1d1d1), borderRadius: BorderRadius.circular(10.0)),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(0, 25, 0, 0),
              child: Column(children: <Widget>[
                Image.asset('assets/noti.png'),
                Text(
                  "Tap to Scan",
                  style: TextStyle(fontSize: 26, fontWeight: FontWeight.w400,color:Color(0xff7d5a5a)),
                )
              ]),
            ),
          ),
        ),
      ),
    );
  }

  Future _scan() async {
    String barcode = await scanner.scan();
    if (barcode == null) {
      print('nothing return.');
    } else {
      this._outputController.text = barcode;
    }
  }

  Future _scanPhoto() async {
    String barcode = await scanner.scanPhoto();
    this._outputController.text = barcode;
  }

  Future _scanPath(String path) async {
    String barcode = await scanner.scanPath(path);
    this._outputController.text = barcode;
  }
}