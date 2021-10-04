import 'package:flutter/material.dart';

import '../../constanins.dart';

class BatteryStatus extends StatelessWidget {
  const BatteryStatus({
    Key? key,
    required this.constrains,
  }) : super(key: key);

  final BoxConstraints constrains;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          '220 mi',
          style: Theme.of(context)
              .textTheme
              .headline3!
              .copyWith(color: Colors.white),
        ),
        const Text(
          '62%',
          style: TextStyle(fontSize: 24),
        ),
        const Spacer(),
        Text(
          'Charging'.toUpperCase(),
          style: const TextStyle(fontSize: 22),
        ),
        const Text(
          '18 min remaining',
          style: TextStyle(fontSize: 22),
        ),
        SizedBox(height: constrains.maxHeight * 0.1),
        DefaultTextStyle(
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text('22 mi/hr'),
                Text('232 v'),
              ],
            ),
          ),
        ),
        const SizedBox(height: defaultPadding)
      ],
    );
  }
}
