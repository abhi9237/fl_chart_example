import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/pain_tracker_controller.dart';
import '../widgets/app_bar_view.dart';
import '../widgets/tab_bar.dart';
import '../widgets/tab_bar_screen.dart';

class PainTrackerScreen extends StatelessWidget {
  const PainTrackerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return PopScope(
      onPopInvoked: (didPop) async => false,
      canPop: false,
      child: GetBuilder<PainTrackerScreenController>(
        init: PainTrackerScreenController(),
        builder: (controller) {
          return Scaffold(
            backgroundColor: Colors.transparent,
            body:  SafeArea(
                child: SizedBox(
                  height: size.height,
                  width: size.width,
                  child: Column(
                    children: [
                      PainTrackerAppBarView(

                      ),
                      const SizedBox(
                        height: 0,
                      ),
                      Expanded(
                        child: Container(
                          color: const Color(0xffF6F6F6),
                          child: Column(
                            children: [
                              const SizedBox(height: 10),
                              PainTrackerTabBarView(
                                controller: controller,
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Expanded(
                                child: TabBarView(
                                    physics:
                                    const NeverScrollableScrollPhysics(),
                                    controller:
                                    controller.tabController,
                                    children: [
                                      TabViewScreen(
                                        controller: controller,
                                      ),
                                      TabViewScreen(
                                        controller: controller,
                                      ),
                                      TabViewScreen(
                                        controller: controller,
                                      ),
                                    ]),
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),

          );
        },
      ),
    );
  }
}
