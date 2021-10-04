import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../constanins.dart';



class DoorLock extends StatelessWidget {
  const DoorLock({
    Key? key,
    required this.isLock,required this.press,
  })  :
        super(key: key);

 
  final bool isLock;
  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: press,
      child: AnimatedSwitcher(
        duration: defaultDuration,
        switchInCurve: Curves.easeInOutBack,
        transitionBuilder: (child, animation) => ScaleTransition(
          scale: animation,
          child: child,
        ),
        child: isLock
            ? SvgPicture.asset(
                'assets/icons/door_lock.svg',
                key: const ValueKey('lock'),
              )
            : SvgPicture.asset(
                'assets/icons/door_unlock.svg',
                key: const ValueKey('unlock'),
              ),
      ),
    );
  }
}
