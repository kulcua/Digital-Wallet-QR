import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'history_page.dart';
import 'scanning_page.dart';

class GridDashboard extends StatelessWidget {

  Item item1 = new Item(
    title: "Create",
    img: "assets/qrcode.png",
  );

  Item item2 = new Item(
    title: "Scan",
    img: "assets/qrscan.png",
  );

  Item item3 = new Item(
    title: "Top Up",
    img: "assets/coin.png",
  );

  Item item4 = new Item(
    title: "Wallet",
    img: "assets/wallet.png",
  );

  @override
  Widget build(BuildContext context) {
    List<Item> myItem = [item1,item2,item3,item4];
    return Flexible(
      child: GridView.count(
        childAspectRatio: 1.0,
        padding: EdgeInsets.only(left: 16, right: 16),
        crossAxisCount: 2,
        crossAxisSpacing: 18,
        mainAxisSpacing: 8,
        children: myItem.map((data){
          return GestureDetector(
            onTap: () async {
              Navigator.push(context,MaterialPageRoute(builder: (context)=> Scanning()));
            },
            child: Container(
                decoration: BoxDecoration(color: Color(0xfff1d1d1), borderRadius: BorderRadius.circular(10.0)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Image.asset(data.img,width: 42,),
                    SizedBox(height: 14,),
                    Text(data.title, style: GoogleFonts.openSans(
                        textStyle: TextStyle(
                          color: Color(0xff7d5a5a),
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        )
                    ),)
                  ],
                )
            ),
          );
        }).toList(),
      ),
    );
  }
}

class Item{
  String title;
  String img;

  Item({this.title,this.img});
}