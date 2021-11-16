import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../constanins.dart';


class TempBtn extends StatelessWidget {
  const TempBtn({
    Key? key,
    required this.svgSrc,
    required this.title,
    this.isActive = true,
    required this.press, this.colorActive = primaryColor,
  }) : super(key: key);

  final String svgSrc, title;
  final bool isActive;
  final VoidCallback press;
  final Color colorActive;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: press,
      child: Column(
        children: [
          AnimatedContainer(
            duration: const Duration(milliseconds: 200 ),
            curve: Curves.easeInOutBack,
            height: isActive ? 76 : 50,
            width: isActive ? 76 : 50,
            child: SvgPicture.asset(
              svgSrc,
              color: isActive ? colorActive : Colors.white30,
            ),
          ),
          const SizedBox(height: defaultPadding / 2),
          AnimatedDefaultTextStyle(
            duration: const Duration(milliseconds: 200 ),
            style:  TextStyle(
                color: isActive ? colorActive : Colors.white30,
                fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
                fontSize: 16,
              ),
            child: Text(
              title.toUpperCase(),
            ),
          )
        ],
      ),
    );
  }
}
