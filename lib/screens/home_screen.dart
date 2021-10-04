import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:tesla_animation_app/constanins.dart';
import 'package:tesla_animation_app/controller/home_controller.dart';

import 'components/battery_status.dart';
import 'components/door_lock.dart';
import 'components/tesla_bottom_navigationbar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  final HomeController _controller = Get.put(HomeController());

  late AnimationController _battreyAnimationController;
  late Animation<double> _animationBattery;
  late Animation<double> _animationBatteryStatus;

  void setupBatteryAnimation() {
    _battreyAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );
    _animationBattery = CurvedAnimation(
      parent: _battreyAnimationController,
      curve: const Interval(0.0, 0.5),
    );

    _animationBatteryStatus = CurvedAnimation(
      parent: _battreyAnimationController,
      curve: const Interval(0.6, 1),
    );
  }

  @override
  void initState() {
    setupBatteryAnimation();
    super.initState();
  }

  @override
  void dispose() {
    _battreyAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: Listenable.merge([
        _controller,
        _battreyAnimationController,
      ]),
      builder: (context, _) {
        return Scaffold(
          bottomNavigationBar: TeslaBottomNavigationBar(
            onTap: (index) {
              if (index == 1) {
                _battreyAnimationController.forward();
              } else if (_controller.selectedBottomTab.value == 1 &&
                  index != 1) {
                _battreyAnimationController.reverse(from: 0.7);
              }
              _controller.onBottomNavigationBar(index);
            },
            selectedTab: _controller.selectedBottomTab.value,
          ),
          body: SafeArea(
            child: LayoutBuilder(
              builder: (context, constrains) {
                return Stack(
                  alignment: Alignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: constrains.maxHeight * 0.1,
                      ),
                      child: SvgPicture.asset(
                        'assets/icons/Car.svg',
                        width: double.infinity,
                      ),
                    ),
                    AnimatedPositioned(
                      duration: defaultDuration,
                      right: _controller.selectedBottomTab.value == 0
                          ? constrains.maxWidth * 0.05
                          : constrains.maxWidth * 0.5,
                      child: AnimatedOpacity(
                        duration: defaultDuration,
                        opacity:
                            _controller.selectedBottomTab.value == 0 ? 1 : 0,
                        child: DoorLock(
                          press: () {
                            _controller.updateRightDoorLock();
                          },
                          isLock: _controller.isRightDoorLock.value,
                        ),
                      ),
                    ),
                    AnimatedPositioned(
                      duration: defaultDuration,
                      left: _controller.selectedBottomTab.value == 0
                          ? constrains.maxWidth * 0.05
                          : constrains.maxWidth * 0.5,
                      child: AnimatedOpacity(
                        duration: defaultDuration,
                        opacity:
                            _controller.selectedBottomTab.value == 0 ? 1 : 0,
                        child: DoorLock(
                          press: () {
                            _controller.updateLeftDoorLock();
                          },
                          isLock: _controller.isLefttDoorLock.value,
                        ),
                      ),
                    ),
                    AnimatedPositioned(
                      duration: defaultDuration,
                      top: _controller.selectedBottomTab.value == 0
                          ? constrains.maxHeight * 0.1
                          : constrains.maxHeight / 2,
                      child: AnimatedOpacity(
                        duration: defaultDuration,
                        opacity:
                            _controller.selectedBottomTab.value == 0 ? 1 : 0,
                        child: DoorLock(
                          press: () {
                            _controller.updateBonnetLock();
                          },
                          isLock: _controller.isBonnetLock.value,
                        ),
                      ),
                    ),
                    AnimatedPositioned(
                      duration: defaultDuration,
                      bottom: _controller.selectedBottomTab.value == 0
                          ? constrains.maxHeight * 0.15
                          : constrains.maxHeight / 2,
                      child: AnimatedOpacity(
                        duration: defaultDuration,
                        opacity:
                            _controller.selectedBottomTab.value == 0 ? 1 : 0,
                        child: DoorLock(
                          press: () {
                            _controller.updateTrunkLock();
                          },
                          isLock: _controller.isTrunkLock.value,
                        ),
                      ),
                    ),
                    // Battery
                    Opacity(
                      opacity: _animationBattery.value,
                      child: SvgPicture.asset(
                        'assets/icons/Battery.svg',
                        width: constrains.maxWidth * 0.4,
                      ),
                    ),
                    Positioned(
                      top: 50 * (1 - _animationBatteryStatus.value),
                      width: constrains.maxWidth,
                      height: constrains.maxHeight,
                      child: Opacity(
                        opacity: _animationBatteryStatus.value,
                        child: BatteryStatus(constrains: constrains),
                      ),
                    )
                  ],
                );
              },
            ),
          ),
        );
      },
    );
  }
}
