import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:tesla_animation_app/constanins.dart';
import 'package:tesla_animation_app/controller/home_controller.dart';
import 'package:tesla_animation_app/models/tyre_psi.dart';
import 'package:tesla_animation_app/screens/components/tyre_psi_card.dart';

import 'components/battery_status.dart';
import 'components/door_lock.dart';
import 'components/temp_detail.dart';
import 'components/tesla_bottom_navigationbar.dart';
import 'components/tyers.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  final HomeController _controller = Get.put(HomeController());

  late AnimationController _battreyAnimationController;
  late Animation<double> _animationBattery;
  late Animation<double> _animationBatteryStatus;

  late AnimationController _tempAnimationController;
  late Animation<double> _animationCarShift;
  late Animation<double> _animationTempShowInfo;
  late Animation<double> _animationCoolGlow;

  late AnimationController _tyreAnimationController;
  late Animation<double> _animationTyre1Psi;
  late Animation<double> _animationTyre2Psi;
  late Animation<double> _animationTyre3Psi;
  late Animation<double> _animationTyre4Psi;

  late List<Animation<double>> _tyreAnimation;

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

  void setupTempAnimation() {
    _tempAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    );
    _animationCarShift = CurvedAnimation(
      parent: _tempAnimationController,
      curve: const Interval(0.2, 0.4),
    );
    _animationTempShowInfo = CurvedAnimation(
      parent: _tempAnimationController,
      curve: const Interval(0.45, 0.65),
    );
    _animationCoolGlow = CurvedAnimation(
      parent: _tempAnimationController,
      curve: const Interval(0.7, 1),
    );
  }

  void setupTyreAnimation() {
    _tyreAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(
        milliseconds: 1200,
      ),
    );
    _animationTyre1Psi = CurvedAnimation(
        parent: _tyreAnimationController, curve: const Interval(0.34, 0.5));
    _animationTyre2Psi = CurvedAnimation(
        parent: _tyreAnimationController, curve: const Interval(0.5, 0.66));
    _animationTyre3Psi = CurvedAnimation(
        parent: _tyreAnimationController, curve: const Interval(0.66, 0.82));
    _animationTyre4Psi = CurvedAnimation(
        parent: _tyreAnimationController, curve: const Interval(0.82, 1));
  }

  @override
  void initState() {
    setupBatteryAnimation();
    setupTempAnimation();
    setupTyreAnimation();
    _tyreAnimation = [
      _animationTyre1Psi,
      _animationTyre2Psi,
      _animationTyre3Psi,
      _animationTyre4Psi,
    ];
    super.initState();
  }

  @override
  void dispose() {
    _battreyAnimationController.dispose();
    _tempAnimationController.dispose();
    _tyreAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: Listenable.merge([
        _controller,
        _battreyAnimationController,
        _tempAnimationController,
        _tyreAnimationController,
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
              if (index == 2) {
                _tempAnimationController.forward();
                // ignore: unrelated_type_equality_checks
              } else if (_controller.selectedBottomTab == 2 && index != 2) {
                _tempAnimationController.reverse(from: 0.4);
              }
              if (index == 3) {
                _tyreAnimationController.forward();
                // ignore: unrelated_type_equality_checks
              } else if (_controller.selectedBottomTab == 3 && index != 3) {
                _tyreAnimationController.reverse();
              }

              _controller.tyreStatusController(index);
              _controller.showTyersController(index);
              // BottomNavigationBar
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
                    SizedBox(
                      width: constrains.maxWidth,
                      height: constrains.maxHeight,
                    ),
                    Positioned(
                      left: constrains.maxWidth / 2 * _animationCarShift.value,
                      width: constrains.maxWidth,
                      height: constrains.maxHeight,
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: constrains.maxHeight * 0.1,
                        ),
                        child: SvgPicture.asset(
                          'assets/icons/Car.svg',
                          width: double.infinity,
                        ),
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
                    ),
                    // Temp
                    Positioned(
                      width: constrains.maxWidth,
                      height: constrains.maxHeight,
                      top: 60 * (1 - _animationTempShowInfo.value),
                      child: Opacity(
                        opacity: _animationTempShowInfo.value,
                        child: TempDetail(controller: _controller),
                      ),
                    ),
                    Positioned(
                      right: -180 * (1 - _animationCoolGlow.value),
                      child: AnimatedSwitcher(
                        duration: defaultDuration,
                        child: _controller.isCoolSelected.value
                            ? Image.asset(
                                'assets/images/Cool_glow_2.png',
                                width: 200,
                                key: UniqueKey(),
                              )
                            : Image.asset(
                                'assets/images/Hot_glow_4.png',
                                width: 200,
                                key: UniqueKey(),
                              ),
                      ),
                    ),
                    // tyre
                    if (_controller.isShowTyers.value) ...tyres(constrains),
                    if (_controller.isShowTyerStatus.value)
                      GridView.builder(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: defaultPadding,
                          childAspectRatio:
                              constrains.maxWidth / constrains.maxHeight,
                          crossAxisSpacing: defaultPadding,
                        ),
                        itemCount: 4,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (BuildContext context, int index) {
                          return ScaleTransition(
                            scale:  _tyreAnimation[index],
                            child: TyrePsiCard(
                              isBottomTwoTyre: index > 1,
                              tyrePsi: demoPsiList[index],
                            ),
                          );
                        },
                      ),
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
