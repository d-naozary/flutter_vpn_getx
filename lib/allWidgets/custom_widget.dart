import 'package:flutter/material.dart';
import 'package:flutter_vpn/main.dart';

class CustomWidget extends StatelessWidget {
  final String titleText;
  final String subtitleText;
  final Widget roundWidgetWithIcon;

  CustomWidget({
    super.key,
    required this.titleText,
    required this.subtitleText,
    required this.roundWidgetWithIcon,
  });

  @override
  Widget build(BuildContext context) {
    sizeScreen = MediaQuery.of(context).size;

    return SizedBox(
      width: sizeScreen.width * 0.46,
      child: Column(
        children: [
          roundWidgetWithIcon,
          SizedBox(height: 7),
          Text(
            titleText,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 7),
          Text(
            subtitleText,
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
