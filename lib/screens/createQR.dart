import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:moneymangement/module/user.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';

class CreateQR extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    String userId = Provider.of<UserData>(context).currentUserId;
    return Scaffold(
        appBar: AppBar(
          title: Text('Mã QR',
              style: TextStyle(color: Color(0xff7d5a5a), fontSize: 18)),
          backgroundColor: Color(0xfff1d1d1),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'Đưa mã này cho thu ngân để thanh toán',
                style: GoogleFonts.openSans(
                    textStyle: TextStyle(
                  color: Color(0xff7d5a5a),
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                )),
              ),
              SizedBox(height: 20.0),
              Container(
                color: Colors.white,
                child: QrImage(
                  data: userId,
                  version: QrVersions.auto,
                  size: 250.0,
//                  embeddedImage: AssetImage('images/test.jpg'),
//                  embeddedImageStyle: QrEmbeddedImageStyle(
//                    size: Size(80, 80),
//                  ),
                ),
              ),
              FlatButton.icon(
                onPressed: null,
                icon: Icon(Icons.share),
                label: Text(
                  'Chia sẻ mã QR',
                  style: GoogleFonts.openSans(
                      textStyle: TextStyle(
                    color: Color(0xff7d5a5a),
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  )),
                ),
              ),
            ],
          ),
        ));
  }
}
