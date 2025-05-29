import 'package:fl_chart_example/pain_tracker/widgets/pain_chart_view.dart';
import 'package:fl_chart_example/pain_tracker/widgets/status_chart_view.dart';
import 'package:flutter/cupertino.dart';


import '../controller/pain_tracker_controller.dart';

class TabViewScreen extends StatelessWidget {
  final PainTrackerScreenController? controller;
  const TabViewScreen({super.key, this.controller});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        children: [
          const SizedBox(height: 30),
          AllStatusChartView(
            controller: controller,
          ),
          const SizedBox(
            height: 40,
          ),
          // SelectedChartView(
          //   controller: controller,
          // ),
          // const SizedBox(
          //   height: 60,
          // ),
        ],
      ),
    );
  }
}

/*
class BottomView extends StatelessWidget {
  final PainTrackerScreenController? controller;
  final String? image;
  final PainVideo? data;
  const BottomView({Key? key, this.image, this.controller, this.data})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width - 20,
      height: 209,
      // padding: const EdgeInsets.only(
      //   left: 20,
      //   right: 20,
      //   top: 20,
      //   bottom: 15,
      // ),
      // decoration: BoxDecoration(
      //   image: DecorationImage(
      //       fit: BoxFit.cover,
      //       image: data?.thumbnail != null
      //           ? NetworkImage(data?.thumbnail ?? "")
      //           : const AssetImage(AssetImages.painTrackerBlueBg)
      //       // image: AssetImage(image ?? ''),
      //       ),
      // ),
      child: Stack(
        children: [
          data?.thumbnail != null
              ? CustomImageView(
                  url: data?.thumbnail ?? "",
                  width: Get.width - 20,
                  height: 209,
                  fit: BoxFit.cover,
                )
              : CustomImageView(
                  imagePath: AssetImages.painTrackerBlueBg,
                  width: Get.width - 20,
                  height: 209,
                  fit: BoxFit.cover,
                ),
          Padding(
            padding: const EdgeInsets.only(
              left: 20,
              right: 20,
              top: 20,
              bottom: 15,
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    const CustomImageView(
                      imagePath: AssetIcons.heartWhiteIcons,
                      width: 20,
                      height: 20,
                      fit: BoxFit.cover,
                    ),
                    const SizedBox(width: 10),
                    Text(
                      // '2,335 people here today',
                      '${data?.favoriteCount ?? 0} people here today',
                      style: GoogleFonts.openSans(
                        fontSize: 15,
                        color: AppColorConstant.white,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),

                data?.planType == 'free'
                    ? const SizedBox()
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: 50,
                            height: 1,
                            color: AppColorConstant.white,
                          ),
                          const SizedBox(width: 10),
                          // data?.planType == 'free'
                          //     ? Text(
                          //         '',
                          //         style: GoogleFonts.openSans(
                          //           fontSize: 15,
                          //           color: AppColorConstant.white,
                          //           fontWeight: FontWeight.w400,
                          //         ),
                          //       )
                          //     :

                          Text(
                            'Unlock',
                            style: GoogleFonts.openSans(
                              fontSize: 15,
                              color: AppColorConstant.white,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          const SizedBox(width: 10),
                          Container(
                            width: 50,
                            height: 1,
                            color: AppColorConstant.white,
                          ),
                        ],
                      ),
                const SizedBox(height: 10),
                Text(
                  data?.category?.title ?? "",
                  // 'Clinical Somatics  Exercises',
                  style: GoogleFonts.poppins(
                    fontSize: 17,
                    color: AppColorConstant.white,
                    fontWeight: FontWeight.w700,
                    fontStyle: FontStyle.italic,
                  ),
                ),
                data?.planType == 'free'
                    ? Text(
                        '',
                        style: GoogleFonts.openSans(
                          fontSize: 17,
                          color: AppColorConstant.white,
                          fontWeight: FontWeight.w400,
                        ),
                      )
                    : Text(
                        'for just \$7 / month',
                        style: GoogleFonts.openSans(
                          fontSize: 17,
                          color: AppColorConstant.white,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                // const SizedBox(height: 10),

                const Spacer(),

                data?.planType == 'free'
                    ? const SizedBox()
                    : Row(
                        children: [
                          Text(
                            'Start Free Trial',
                            style: GoogleFonts.openSans(
                              fontSize: 16,
                              color: AppColorConstant.white,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          const SizedBox(width: 10),
                          Container(
                            width: 1,
                            height: 25,
                            color: AppColorConstant.white,
                          ),
                          const SizedBox(width: 10),
                          Text(
                            'first 3 days free',
                            style: GoogleFonts.openSans(
                              fontSize: 16,
                              color: AppColorConstant.white,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          const Spacer(),
                          const CustomImageView(
                            imagePath: AssetIcons.lockIcon,
                            width: 18,
                            height: 18,
                            fit: BoxFit.cover,
                          ),
                        ],
                      ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

 */
