import 'package:flutter/material.dart';
import 'package:mechaku/theme.dart';

class Homepage extends StatelessWidget {
  final TextEditingController query = TextEditingController(text: '');

  Widget header() {
    return Container(
      margin: EdgeInsets.only(
        bottom: 30,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Image.asset(
            'assets/logo_landscape.png',
            width: 154,
          ),
          GestureDetector(
              child: Image.asset(
                'assets/cart_white_icon.png',
                width: 24,
              ),
              onTap: () {}),
        ],
      ),
    );
  }

  Widget searchField() {
    return Container(
      margin: EdgeInsets.only(
        bottom: 30,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
            child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 14,
              ),
              decoration: BoxDecoration(
                color: secondaryColor,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Center(
                child: TextFormField(
                  controller: query,
                  cursorColor: orangeTextColor,
                  autofocus: false,
                  style: primaryTextStyle,
                  decoration: InputDecoration.collapsed(
                    hintText: 'Find your own hobby',
                    hintStyle: subtitleTextStyle,
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            width: 16,
          ),
          GestureDetector(
            onTap: () {},
            child: Container(
              padding: EdgeInsets.symmetric(
                vertical: 13,
                horizontal: 12,
              ),
              decoration: BoxDecoration(
                color: iconColor,
                borderRadius: BorderRadius.circular(16),
              ),
              child:
                  Image.asset('assets/search_icon.png', width: 24, height: 24),
            ),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        header(),
        searchField(),
        Center(
          child: Text('Homepage'),
        ),
      ],
    );
  }
}
