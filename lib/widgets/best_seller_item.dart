import 'package:flutter/material.dart';
import 'package:mechaku/theme.dart';

class BestSellerItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          width: 215,
          height: 278,
          margin: EdgeInsets.only(
            right: 20,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            image: DecorationImage(
              fit: BoxFit.cover,
              image: AssetImage(
                'assets/rg_wing_gundam.jpg',
              ),
            ),
          ),
        ),
        Positioned(
          bottom: 0,
          child: Container(
            width: 215,
            height: 84,
            padding: EdgeInsets.symmetric(
              vertical: 9,
              horizontal: 12,
            ),
            decoration: BoxDecoration(
              color: iconColor,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(16),
                bottomRight: Radius.circular(16),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Gundam',
                  style: whiteTextStyle.copyWith(fontSize: 12),
                ),
                SizedBox(
                  width: 140,
                  child: Text(
                    'Gundam Wing RG (MG - 1/144)',
                    maxLines: 2,
                    style: whiteTextStyle.copyWith(
                      fontSize: 16,
                      fontWeight: semiBold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        Positioned(
          right: 20.5,
          bottom: 54,
          child: Container(
            padding: EdgeInsets.symmetric(
              vertical: 5,
              horizontal: 14,
            ),
            decoration: BoxDecoration(
              color: orangeTextColor,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(16),
              ),
            ),
            child: Text(
              '\$50,00',
              style: whiteTextStyle.copyWith(
                fontWeight: medium,
              ),
            ),
          ),
        ),
        Positioned(
            top: 8,
            right: 28,
            child: Container(
              padding: EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: bgColor,
                borderRadius: BorderRadius.circular(50),
              ),
              child: Image.asset(
                'assets/love_white_icon.png',
                width: 12,
                height: 12,
                fit: BoxFit.cover,
              ),
            ))
      ],
    );
  }
}
