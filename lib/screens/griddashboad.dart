import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:moneymangement/screens/createQR.dart';
import 'package:moneymangement/screens/transaction.dart';
import 'package:qrscan/qrscan.dart' as scanner;

class GridDashboard extends StatelessWidget {
  Item item1 = new Item(
    title: 'Mã QR',
    img: 'images/qrcode.png',
  );

  Item item2 = new Item(
    title: 'Quét QR',
    img: 'images/qrscan.png',
  );

  Item item3 = new Item(
    title: 'Nạp tiền',
    img: 'images/coin.png',
  );

  Item item4 = new Item(
    title: 'Thẻ',
    img: 'images/wallet.png',
  );

  @override
  Widget build(BuildContext context) {
    List<Item> myItem = [item1, item2, item3, item4];
    return Flexible(
      child: GridView.count(
        childAspectRatio: 1.0,
        padding: EdgeInsets.only(left: 16, right: 16),
        crossAxisCount: 2,
        crossAxisSpacing: 18,
        mainAxisSpacing: 18,
        children: myItem.map((data) {
          return GestureDetector(
            onTap: () async {
              if (data.title == 'Mã QR')
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => CreateQR()));
              else if (data.title == 'Quét QR') {
                String result_qr = await scanner.scan();
                if (result_qr == null) {
                  print('null r');
                } else {
                  print('resulltnenenene$result_qr');
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Transaction(uid_receiver: result_qr,)));
                }
              }
//              else if (data.title == 'Top Up')
//                Navigator.push(context,MaterialPageRoute(builder: (context)=> Scanning()));
//              else if (data.title == 'Wallet')
//                Navigator.push(context,MaterialPageRoute(builder: (context)=> Scanning()));
            },
            child: Container(
                decoration: BoxDecoration(
                    color: Color(0xfff1d1d1),
                    borderRadius: BorderRadius.circular(10.0)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Image.asset(
                      data.img,
                      width: 42,
                    ),
                    SizedBox(
                      height: 14,
                    ),
                    Text(
                      data.title,
                      style: GoogleFonts.openSans(
                          textStyle: TextStyle(
                        color: Colors.brown[800],
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      )),
                    )
                  ],
                )),
          );
        }).toList(),
      ),
    );
  }
}

class Item {
  String title;
  String img;

  Item({this.title, this.img});
}
