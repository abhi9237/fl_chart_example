import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../common/color_constant.dart';
import '../controller/pain_tracker_controller.dart';

class PainTrackerTabBarView extends StatelessWidget {
  final PainTrackerScreenController? controller;
  const PainTrackerTabBarView({super.key, this.controller});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Stack(
      children: [
        DefaultTabController(
          length: 3,
          child: Container(
            decoration: BoxDecoration(
                color: AppColorConstant.colorE6E6E8,
                borderRadius: BorderRadius.circular(8.0)),
            margin: const EdgeInsets.symmetric(horizontal: 20),
            height: 33,
            child: TabBar(
              controller: controller?.tabController,
              indicatorSize: TabBarIndicatorSize.tab,
              dividerColor: Colors.transparent,
              onTap: (i) {
                controller?.onTapTabBarIndex(i);
              },
              isScrollable: false,
              tabs: [
                TabWidget(
                  index: 0,
                  controller: controller,
                  text: 'Week',
                ),
                TabWidget(
                  index: 1,
                  controller: controller,
                  text: 'Month',
                ),
                TabWidget(
                  index: 2,
                  controller: controller,
                  text: 'Year',
                ),
              ],
              indicator: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8.0),
                boxShadow: [
                  BoxShadow(
                    color: AppColorConstant.lightGrey.withOpacity(0.15),
                    spreadRadius: 1,
                    blurRadius: 3,
                    offset: const Offset(0, 1), // changes position of shadow
                  ),
                ],
              ),
              indicatorPadding: const EdgeInsets.all(2),
              labelColor: Colors.blue,
              unselectedLabelColor: Colors.grey,
              labelStyle: const TextStyle(fontWeight: FontWeight.bold),
              unselectedLabelStyle:
                  const TextStyle(fontWeight: FontWeight.normal),
            ),
          ),
        ),
        Positioned(
            left: size.width * 0.35,
            top: 10,
            child: Visibility(
              visible: controller?.selectedTabIndex.value != 0 &&
                  controller?.selectedTabIndex.value != 1,
              child: Container(
                height: 15,
                width: 1,
                color: AppColorConstant.colorA8A8A8,
              ),
            )),
        Positioned(
            right: size.width * 0.35,
            top: 10,
            child: Visibility(
              visible: controller?.selectedTabIndex.value != 2 &&
                  controller?.selectedTabIndex.value != 1,
              child: Container(
                height: 15,
                width: 1,
                color: AppColorConstant.colorA8A8A8,
              ),
            ))
      ],
    );
  }
}

class TabWidget extends StatelessWidget {
  final PainTrackerScreenController? controller;
  final int? index;
  final String? text;
  const TabWidget({super.key, this.controller, this.text, this.index});

  @override
  Widget build(BuildContext context) {
    return Tab(
      child: SizedBox(
        height: 15,
        width: double.infinity,
        child: Text(
          text ?? '',
          textAlign: TextAlign.center,
          style: GoogleFonts.openSans(
            fontSize: 14,
            color: controller?.selectedTabIndex.value == index
                ? AppColorConstant.color54A2DE
                : AppColorConstant.color676767,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
