import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tesla_animation_app/controller/home_controller.dart';
import 'package:tesla_animation_app/screens/components/temp_btn.dart';

import '../../constanins.dart';


// ignore: must_be_immutable
class TempDetail extends StatelessWidget {

  var controller = Get.put(HomeController());

   TempDetail({
    Key? key,
    required HomeController controller,
  })  : _controller = controller,
        super(key: key);

  final HomeController _controller;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(defaultPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 120,
            child: Row(
              children: [
                TempBtn(
                  isActive: _controller.isCoolSelected.value,
                  press: _controller.updadeCoolSelectedTab,
                  svgSrc: 'assets/icons/coolShape.svg',
                  title: 'cool',
                ),
                const SizedBox(width: defaultPadding),
                TempBtn(
                  isActive: !_controller.isCoolSelected.value,
                  press: _controller.updadeCoolSelectedTab,
                  colorActive: redColor,
                  svgSrc: 'assets/icons/heatShape.svg',
                  title: 'heat',
                ),
              ],
            ),
          ),
          const Spacer(),
          Column(
            children: [
              IconButton(
                padding: EdgeInsets.zero,
                onPressed: () {
                  controller.increment();
                },
                icon: const Icon(Icons.arrow_drop_up, size: 48),
              ),
               Text(
               '${controller.isDegree.value.toString()}''\u2103',
                style: const TextStyle(fontSize: 86),
              ),
              IconButton(
                padding: EdgeInsets.zero,
                onPressed: () {
                  controller.decrement();
                },
                icon: const Icon(Icons.arrow_drop_down, size: 48),
              ),
            ],
          ),
          const Spacer(),
          Text('current temperature'.toUpperCase()),
          const SizedBox(height: defaultPadding),
          Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('inside'.toUpperCase()),
                  Text('29\u2103', style: Theme.of(context).textTheme.headline5)
                ],
              ),
              const SizedBox(width: defaultPadding),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'inside'.toUpperCase(),
                    style: const TextStyle(color: Colors.white54),
                  ),
                  Text(
                    '35\u2103',
                    style: Theme.of(context).textTheme.headline5!.copyWith(
                          color: Colors.white54,
                        ),
                  ),
                ],
              ),
            ],
          )
        ],
      ),
    );
  }
}
