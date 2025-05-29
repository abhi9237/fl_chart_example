import 'dart:developer';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../common/color_constant.dart';
import '../../common/commonButton.dart';
import '../../common/string_constants.dart';
import '../controller/pain_tracker_controller.dart';

class SelectedChartView extends StatelessWidget {
  final PainTrackerScreenController? controller;
  const SelectedChartView({super.key, this.controller});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      width: size.width,
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // DropdownButton<String>(
              //   hint: const Text('Select an option'),
              //   value: controller?.status.value,
              //   items: controller?.changeStatusList.value.map((String value) {
              //     return DropdownMenuItem<String>(
              //       value: value,
              //       child: Text(
              //         value.capitalizeFirst!,
              //         textAlign: TextAlign.center,
              //         style: GoogleFonts.poppins(
              //           fontSize: 18,
              //           color: AppColorConstant.black,
              //           fontWeight: FontWeight.w400,
              //         ),
              //       ),
              //     );
              //   }).toList(),
              //   onChanged: (String? newValue) {
              //     controller?.changeStatus(newValue ?? "");
              //   },
              //   underline: const SizedBox(),
              // ),
              GestureDetector(
                onTap: () {
                  showModalBottomSheet(
                    context: context,
                    builder: (context) => Container(
                      decoration: BoxDecoration(
                        color: AppColorConstant.white,
                        borderRadius: const BorderRadius.only(
                          topRight: Radius.circular(15),
                          topLeft: Radius.circular(15),
                        ),
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const SizedBox(height: 10),
                          ListView.separated(
                              shrinkWrap: true,
                              primary: false,
                              itemCount:
                                  controller?.changeStatusList.value.length ??
                                      0,
                              separatorBuilder: (context, index) =>
                                  const Divider(),
                              itemBuilder: (context, index) {
                                var data =
                                    controller?.changeStatusList.value[index];
                                return GestureDetector(
                                  onTap: () {
                                    controller?.changeStatus(
                                        data ?? "", context);
                                  },
                                  child: Container(
                                    height: 50,
                                    alignment: Alignment.center,
                                    color: Colors.transparent,
                                    child: Text(
                                      (data ?? "").capitalizeFirst ??'',
                                      style: GoogleFonts.poppins(
                                        fontSize: 18,
                                        color: AppColorConstant.black,
                                        fontWeight:
                                            (controller?.status.value ?? "")
                                                        .toLowerCase() ==
                                                    (data ?? "").toLowerCase()
                                                ? FontWeight.w600
                                                : FontWeight.w400,
                                      ),
                                    ),
                                  ),
                                );
                              }),
                        ],
                      ),
                    ),
                  );
                },
                child: Container(
                  height: 55,
                  color: Colors.transparent,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Obx(
                        () => Text(
                          (controller?.status.value ?? "").capitalizeFirst!,
                          textAlign: TextAlign.center,
                          style: GoogleFonts.poppins(
                            fontSize: 18,
                            color: AppColorConstant.black,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                      const SizedBox(width: 15),
                      Icon(
                        Icons.arrow_drop_down,
                        color: AppColorConstant.black,
                      )
                    ],
                  ),
                ),
              ),

              const SizedBox(
                height: 5,
              ),

              PainChart(
                controller: controller,
                onTapLogPain: controller?.status.value == 'pain'
                    ? () {
                        showRattingDialog(context,
                            size: size,
                            title: 'Log Pain',
                            desc:
                                'Rate your pain on a scale of 0-10, 0 being no pain and 10 being the worst pain.',
                            onTap: (value) async {
                          var data = {
                            "pain": int.parse(value),
                            "activity": "",
                            "energy": "",
                            "mood": "",
                            "sleep": "",
                            "muscle_tension": "",
                          };
                          // await controller?.addPainTrackerApi(
                          //   data: data,
                          //   context: context,
                          // );
                        }, itemColor: controller?.showSeparateSpotsColor());
                      }
                    : controller?.status.value == 'activity'
                        ? () {
                            showRattingDialog(context,
                                size: size,
                                title: 'Log Activity',
                                desc: StringConstants.isVersionTwo == false
                                    ? 'Rate your activity level on a scale of 0-10, 0 being no activity and 10 being the most active you have felt.'
                                    : 'Rate your activity level on a scale of 0-10, 0 being no activity and 10 being how active you have been.',
                                onTap: (value) async {
                              var data = {
                                "activity": int.parse(value),
                                "pain": "",
                                "energy": "",
                                "mood": "",
                                "sleep": "",
                                "muscle_tension": "",
                              };
                              // await controller?.addPainTrackerApi(
                              //   data: data,
                              //   context: context,
                              // );
                            }, itemColor: controller?.showSeparateSpotsColor());
                          }
                        : controller?.status.value == 'tension'
                            ? () {
                                showRattingDialog(context,
                                    size: size,
                                    // title: 'Log Muscle Tension',
                                    title: 'Log Tension',
                                    desc:
                                        // 'Rate your muscle tension on a scale of 0-10, 0 being the least tension and 10 being the most tension you have felt.',
                                        'Rate your tension on a scale of 0-10, 0 being the least tension and 10 being the most tension you have felt.',
                                    onTap: (value) async {
                                  var data = {
                                    "activity": "",
                                    "pain": "",
                                    "energy": "",
                                    "mood": "",
                                    "sleep": "",
                                    "muscle_tension": int.parse(value),
                                  };
                                  // await controller?.addPainTrackerApi(
                                  //   data: data,
                                  //   context: context,
                                  // );
                                },
                                    itemColor:
                                        controller?.showSeparateSpotsColor());
                              }
                            : controller?.status.value == 'energy'
                                ? () async {
                                    showRattingDialog(context,
                                        size: size,
                                        title: 'Log Energy',
                                        desc:
                                            'Rate your energy level on a scale of 0-10, 0 being no energy and 10 being the most energetic you have felt.',
                                        onTap: (value) async {
                                      var data = {
                                        "energy": int.parse(value),
                                        "activity": "",
                                        "pain": "",
                                        "mood": "",
                                        "sleep": "",
                                        "muscle_tension": "",
                                      };
                                      // await controller?.addPainTrackerApi(
                                      //   data: data,
                                      //   context: context,
                                      // );
                                    },
                                        itemColor: controller
                                            ?.showSeparateSpotsColor());
                                  }
                                : controller?.status.value == 'mood'
                                    ? () async {
                                        showRattingDialog(context,
                                            size: size,
                                            title: 'Log Mood',
                                            desc:
                                                'Rate your mood on a scale of 0-10, 0 being the worst mood and 10 being the best mood you have felt.',
                                            onTap: (value) async {
                                          var data = {
                                            "energy": "",
                                            "activity": "",
                                            "pain": "",
                                            "mood": int.parse(value),
                                            "sleep": "",
                                            "muscle_tension": "",
                                          };
                                          // await controller?.addPainTrackerApi(
                                          //   data: data,
                                          //   context: context,
                                          // );
                                        },
                                            itemColor: controller
                                                ?.showSeparateSpotsColor());
                                      }
                                    : controller?.status.value == 'sleep'
                                        ? () async {
                                            showRattingDialog(context,
                                                size: size,
                                                title: 'Log Sleep',
                                                desc:
                                                    // 'Rate your sleep on a scale of 0-10, 0 being no sleep and 10 being the worst sleep.',
                                                    'Rate your sleep on a scale of 0-10, 0 being no sleep and 10 being the best sleep.',
                                                onTap: (value) async {
                                              var data = {
                                                "energy": "",
                                                "activity": "",
                                                "pain": "",
                                                "mood": "",
                                                "sleep": int.parse(value),
                                                "muscle_tension": "",
                                              };
                                              // await controller
                                              //     ?.addPainTrackerApi(
                                              //   data: data,
                                              //   context: context,
                                              // );
                                            },
                                                itemColor: controller
                                                    ?.showSeparateSpotsColor());
                                          }
                                        : () {
                                            log('Working');
                                          },
              ),
            ],
          ),
          Positioned(
              bottom: 65,
              left: 40,
              child: Container(
                height: 20,
                width: 1,
                color: AppColorConstant.lightGrey.withOpacity(0.5),
              )),
          Positioned(
              top: 140,
              left: 40,
              child: Container(
                height: 20,
                width: 1,
                color: AppColorConstant.lightGrey.withOpacity(0.5),
              ))
        ],
      ),
    );
  }

  showRattingDialog(
    BuildContext context, {
    String? title,
    String? desc,
    int sliderValue = 0,
    Color? itemColor,
    Function(String)? onTap,
    required Size size,
  }) {
    TextEditingController controller = TextEditingController();
    GlobalKey<FormState> validKey = GlobalKey<FormState>();
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) => StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
        return Dialog(
          shape: BeveledRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          insetAnimationCurve: Curves.linear,
          insetAnimationDuration: const Duration(milliseconds: 400),
          child: Container(
            height: size.height * 0.8,
            width: size.width * 0.85,
            padding: const EdgeInsets.symmetric(
              horizontal: 10,
              vertical: 10,
            ),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                InkWell(
                  onTap: () {
                  Navigator.of(context).pop();
                    // Get.back();
                  },
                  child: const Align(
                    alignment: Alignment.topRight,
                    child: Icon(
                      Icons.cancel,
                      size: 30,
                    ),
                  ),
                ),
                Center(
                  child: Text(
                    title ?? '',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.inter(
                      fontSize: 20,
                      color: AppColorConstant.black,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Align(
                  alignment: Alignment.center,
                  child: Text(
                    desc ?? 'Rate your pain on a scale of 0 - 10',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.inter(
                      fontSize: 15,
                      color: AppColorConstant.black,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                const SizedBox(height: 15),
                // Form(
                //   key: validKey,
                //   child: SizedBox(
                //     width: Get.width * 0.85,
                //     // child: CommonTextFormFieldWithTitle(
                //     //   controller: controller,
                //     //   height:0,
                //     //   inputFormatters: <TextInputFormatter>[
                //     //     FilteringTextInputFormatter
                //     //         .digitsOnly, // Allow only digits
                //     //     LengthLimitingTextInputFormatter(
                //     //         2), // Limit input length to 2
                //     //   ],
                //     //   validator: (value) {
                //     //     if (value == null || value.isEmpty) {
                //     //       return 'Please enter a number';
                //     //     }
                //     //     int? number = int.tryParse(value);
                //     //     final regex = RegExp(r'^(10|[0-9])$');
                //     //     if (!regex.hasMatch(value)) {
                //     //       return 'Please enter a valid number between 0 and 10';
                //     //     }
                //     //     // if (number == null || number < 0 || number > 10) {
                //     //     //   return 'Please enter a valid number between 0 and 10';
                //     //     // }
                //     //     return null;
                //     //   },
                //     // ),
                //
                //     child: TextFormField(
                //       controller: controller,
                //       decoration: InputDecoration(
                //         hintText: 'Enter a number between 0 and 10',
                //         hintStyle: GoogleFonts.inter(
                //           fontSize: 15,
                //           color: AppColorConstant.black,
                //           fontWeight: FontWeight.w500,
                //         ),
                //         enabledBorder: commonTextFieldBorder(),
                //         errorBorder: commonTextFieldBorder(),
                //         focusedErrorBorder: commonTextFieldBorder(),
                //         focusedBorder: commonTextFieldBorder(),
                //         disabledBorder: commonTextFieldBorder(),
                //       ),
                //       keyboardType: TextInputType.number,
                //       inputFormatters: <TextInputFormatter>[
                //         FilteringTextInputFormatter.digitsOnly,
                //
                //         FilteringTextInputFormatter.allow(
                //           RegExp(
                //               r'^(10|[0-9])$'), // Allows only numbers between 0-10
                //         ), // Allow only digits
                //       ],
                //       validator: (value) {
                //         if (value == null || value.isEmpty) {
                //           return 'Please enter a number';
                //         }
                //         final regex = RegExp(r'^(10|[0-9])$');
                //         if (!regex.hasMatch(value)) {
                //           return 'Please enter a valid number between 0 and 10';
                //         }
                //         return null;
                //       },
                //     ),
                //   ),
                // ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.35, //0.5
                      child: Row(
                        children: <Widget>[
                          SizedBox(
                            height:
                                MediaQuery.of(context).size.height * 0.32, //0.5

                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                Container(
                                  child: Text(
                                    '10',
                                    style: TextStyle(
                                      color: sliderValue == 10
                                          ? itemColor
                                          : Colors.black,
                                      fontWeight: sliderValue == 10
                                          ? FontWeight.w700
                                          : FontWeight.normal,
                                      fontSize: sliderValue == 10 ? 14 : 14,
                                    ),
                                  ),
                                ),
                                Container(
                                  child: Text(
                                    '9',
                                    style: TextStyle(
                                      color: sliderValue == 9
                                          ? itemColor
                                          : Colors.black,
                                      fontWeight: sliderValue == 9
                                          ? FontWeight.w700
                                          : FontWeight.normal,
                                      fontSize: sliderValue == 9 ? 16 : 14,
                                    ),
                                  ),
                                ),
                                Container(
                                  child: Text(
                                    '8',
                                    style: TextStyle(
                                      color: sliderValue == 8
                                          ? itemColor
                                          : Colors.black,
                                      fontWeight: sliderValue == 8
                                          ? FontWeight.w700
                                          : FontWeight.normal,
                                      fontSize: sliderValue == 8 ? 16 : 14,
                                    ),
                                  ),
                                ),
                                Container(
                                  child: Text(
                                    '7',
                                    style: TextStyle(
                                      color: sliderValue == 7
                                          ? itemColor
                                          : Colors.black,
                                      fontWeight: sliderValue == 7
                                          ? FontWeight.w700
                                          : FontWeight.normal,
                                      fontSize: sliderValue == 7 ? 16 : 14,
                                    ),
                                  ),
                                ),
                                Container(
                                  child: Text(
                                    '6',
                                    style: TextStyle(
                                      color: sliderValue == 6
                                          ? itemColor
                                          : Colors.black,
                                      fontWeight: sliderValue == 6
                                          ? FontWeight.w700
                                          : FontWeight.normal,
                                      fontSize: sliderValue == 6 ? 16 : 14,
                                    ),
                                  ),
                                ),
                                Container(
                                  child: Text(
                                    '5',
                                    style: TextStyle(
                                      color: sliderValue == 5
                                          ? itemColor
                                          : Colors.black,
                                      fontWeight: sliderValue == 5
                                          ? FontWeight.w700
                                          : FontWeight.normal,
                                      fontSize: sliderValue == 5 ? 16 : 14,
                                    ),
                                  ),
                                ),
                                Container(
                                  child: Text(
                                    '4',
                                    style: TextStyle(
                                      color: sliderValue == 4
                                          ? itemColor
                                          : Colors.black,
                                      fontWeight: sliderValue == 4
                                          ? FontWeight.w700
                                          : FontWeight.normal,
                                      fontSize: sliderValue == 4 ? 16 : 14,
                                    ),
                                  ),
                                ),
                                Container(
                                  child: Text(
                                    '3',
                                    style: TextStyle(
                                      color: sliderValue == 3
                                          ? itemColor
                                          : Colors.black,
                                      fontWeight: sliderValue == 3
                                          ? FontWeight.w700
                                          : FontWeight.normal,
                                      fontSize: sliderValue == 3 ? 16 : 14,
                                    ),
                                  ),
                                ),
                                Container(
                                  child: Text(
                                    '2',
                                    style: TextStyle(
                                      color: sliderValue == 2
                                          ? itemColor
                                          : Colors.black,
                                      fontWeight: sliderValue == 2
                                          ? FontWeight.w700
                                          : FontWeight.normal,
                                      fontSize: sliderValue == 2 ? 16 : 14,
                                    ),
                                  ),
                                ),
                                Container(
                                  child: Text(
                                    '1',
                                    style: TextStyle(
                                      color: sliderValue == 1
                                          ? itemColor
                                          : Colors.black,
                                      fontWeight: sliderValue == 1
                                          ? FontWeight.w700
                                          : FontWeight.normal,
                                      fontSize: sliderValue == 1 ? 16 : 14,
                                    ),
                                  ),
                                ),
                                Container(
                                  child: const Text('0'),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            height:
                                MediaQuery.of(context).size.height * 0.36, //0.5
                            padding: const EdgeInsets.only(top: 5),
                            child: Center(
                              child: RotatedBox(
                                quarterTurns: 3,
                                child: Slider(
                                  thumbColor: itemColor,
                                  activeColor: itemColor,
                                  inactiveColor: Colors.grey.shade200,
                                  min: 0.0,
                                  max: 10.0,
                                  divisions: 10,
                                  value: sliderValue.toDouble(),
                                  onChanged: (double value) {
                                    setState(() {
                                      sliderValue = value.toInt();
                                      print(sliderValue);
                                    });
                                  },
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                // SizedBox(
                //   height: 20,
                // ),
                // const SizedBox(height: 40),
                const Spacer(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: size.width * 0.45,
                      height: 45,
                      child: CommonButton(
                        // backgroundColor: AppColorConstant.color3E7DC4,
                        backgroundColor: AppColorConstant.color6691bc,
                        borderRadius: 10000,
                        text: 'Save',
                        onPressed: () {
                          // if (validKey.currentState!.validate()) {
                          log('controller.text==>>>${controller.text}');
                          if (onTap != null) {
                            // onTap(controller.text.trim());
                            onTap(sliderValue.toString());
                          }
                          // }
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ).paddingAll(10),
          ),
        );
      }),
    );
  }
}

class PainChart extends StatelessWidget {
  final PainTrackerScreenController? controller;
  final VoidCallback? onTapLogPain;
  const PainChart({super.key, this.controller, this.onTapLogPain});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 395,
      padding: const EdgeInsets.all(15.0),
      decoration: BoxDecoration(
          color: AppColorConstant.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
                color: AppColorConstant.lightGrey.withOpacity(0.2),
                spreadRadius: 1,
                blurRadius: 1,
                offset: const Offset(1, 1))
          ]),
      child: Column(
        children: [
          _buildHeader(
            statusList: controller?.statusList ?? [],
            lastEndDate: controller?.lastEndDate.value ?? '',
            lastStartDate: controller?.lastStartDate.value ?? '',
            lastTimeDays: controller?.lastDayTime.value ?? '',
          ),
          const SizedBox(height: 30),
          _buildChart(
            controller?.selectedTabIndex.value ?? 0,
            weekNameList: controller?.pastWeekDaysList.value ?? [],
            spotsValuePain: controller?.showSeparateSpots(),
            // controller?.selectedChartData,
            // controller?.selectedTabIndex.value == 0
            //     ? controller?.showSeparateSpots()
            //     // ? controller?.spotsPainListWeek
            //     : controller?.selectedTabIndex.value == 1
            //         ? controller?.spotsPainListMonth
            //         : controller?.spotsPainListYear,
            monthNameList: controller?.pastMonthsList.value,
            color: controller?.showSeparateSpotsColor(),
          ),
          const SizedBox(height: 10),
          InkWell(
            splashColor: Colors.transparent,
            onTap: onTapLogPain,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 7),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                // color: AppColorConstant.color3E7DC4,
                color: AppColorConstant.color6691bc,
              ),
              child: Text(
                ('Log ${controller?.status.value}').capitalizeFirst ??'',
                style: GoogleFonts.inter(
                  color: AppColorConstant.white,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildHeader(
      {required List<Status> statusList,
      String? lastTimeDays,
      String? lastStartDate,
      String? lastEndDate}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(child: _buildLegend(statusList: statusList)),
        const SizedBox(
          width: 20,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Last $lastTimeDays ',
              style: GoogleFonts.poppins(
                color: Colors.grey,
                fontSize: 12,
                fontWeight: FontWeight.w400,
              ),
            ),
            Text(
              '$lastStartDate - $lastEndDate',
              style: GoogleFonts.openSans(
                color: AppColorConstant.lightGrey,
                fontSize: 15,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildLegend({required List<Status> statusList}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Average',
          style: GoogleFonts.inter(
              color: AppColorConstant.color676767,
              fontSize: 13,
              fontWeight: FontWeight.w400),
        ),
        Text(
          controller?.getAverageOfSelectedItem() == null
              ? ""
              : controller?.getAverageOfSelectedItem().toStringAsFixed(1) ?? "",
          style: GoogleFonts.openSans(
              color: Colors.black, fontSize: 22, fontWeight: FontWeight.w600),
        ),
      ],
    );
  }

  Widget _buildChart(
    int index, {
    List<double>? spotsValuePain,
    List<String>? weekNameList,
    List<String>? monthNameList,
    Color? color,
  }) {
    return Expanded(
      child: LineChart(
        LineChartData(
          // lineTouchData: LineTouchData(
          //   touchTooltipData: LineTouchTooltipData(
          //     // tooltipBgColor: Colors.black.withOpacity(0.8),
          //     tooltipRoundedRadius: 8,
          //     getTooltipItems: (touchedSpots) {
          //       return touchedSpots.map((spot) {
          //         return LineTooltipItem(
          //           '${spot.x}, ${spot.y}',
          //       const    TextStyle(
          //             color: Colors.white,
          //             fontWeight: FontWeight.bold,
          //             fontSize: 12,
          //           ),
          //         );
          //       }).toList();
          //     },
          //   ),
          // ),
          minY: 0,
          maxY: 10,
          minX: index == 1 ? -0.3 : -0.5,
          maxX: index == 0
              ? 7
              : index == 1
                  ? 4.0
                  : 12,
          gridData: const FlGridData(show: false),
          titlesData: FlTitlesData(
              leftTitles: AxisTitles(
                sideTitles: SideTitles(
                  showTitles: true,
                  reservedSize: 25,
                  interval: 1,
                  getTitlesWidget: (value, meta) {
                    final int titleIndex = value.toInt();

                    if (titleIndex >= 0 && titleIndex <= 10) {
                      return SideTitleWidget(
                        // space: ,
                        axisSide: AxisSide.left,
                        child: Text(
                          titleIndex.toString(),
                          style: GoogleFonts.inter(
                            color: AppColorConstant.color3D3A3A,
                            fontSize: 11,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      );
                    }
                    // Return an empty container if the value is not one of the numbers we want to show
                    return Container();
                  },
                ),
              ),
              topTitles: const AxisTitles(
                sideTitles: SideTitles(
                  showTitles: false, // Hide titles on the top side
                ),
              ),
              rightTitles: const AxisTitles(
                sideTitles: SideTitles(
                  showTitles: false, // Hide titles on the right side
                ),
              ),
              bottomTitles: AxisTitles(
                sideTitles: SideTitles(
                  interval: 1,
                  showTitles: true,
                  getTitlesWidget: (v, i) {
                    if (index == 0) {
                      return _bottomTitleWeekWidgets(v, i, weekNameList ?? []);
                    } else if (index == 1) {
                      return _bottomTitleMonthWidgets(v, i);
                    } else {
                      return _bottomTitleYearWidgets(v, i, monthNameList ?? []);
                    }
                  },
                ),
              )),
          borderData: FlBorderData(
              show: true,
              border: Border(
                left: BorderSide(
                  color: AppColorConstant.lightGrey
                      .withOpacity(0.5), // Border color
                  width: 1, // Border width
                ),
                bottom: BorderSide(
                  color: AppColorConstant.lightGrey.withOpacity(0.5),
                  width: 1, // Border width
                ),
                right: BorderSide.none, // No border on the right
                top: BorderSide.none,
              )),
          lineBarsData: [
            _buildLineChartBarData(spotsValuePain ?? [], color ?? Colors.red),
          ],
        ),
      ),
    );
  }

  Widget _bottomTitleWeekWidgets(
      double value, TitleMeta meta, List<String> weekDaysList) {
    TextStyle style = GoogleFonts.inter(
      color: AppColorConstant.color3D3A3A,
      fontWeight: FontWeight.w500,
      fontSize: 10,
    );
    Widget text;

    switch (value.toInt()) {
      case 1:
        text = Padding(
          padding: const EdgeInsets.only(right: 20.0),
          child: Text(weekDaysList[6].substring(0, 3).capitalizeFirst ??'',
              style: style),
        );
        break;
      case 2:
        text = Padding(
          padding: const EdgeInsets.only(right: 20.0),
          child: Text(weekDaysList[5].substring(0, 3).capitalizeFirst ??'',
              style: style),
        );
        break;
      case 3:
        text = Padding(
          padding: const EdgeInsets.only(right: 20.0),
          child: Text(weekDaysList[4].substring(0, 3).capitalizeFirst ??'',
              style: style),
        );
        break;
      case 4:
        text = Padding(
          padding: const EdgeInsets.only(right: 20.0),
          child: Text(weekDaysList[3].substring(0, 3).capitalizeFirst ??'',
              style: style),
        );
        break;
      case 5:
        text = Padding(
          padding: const EdgeInsets.only(right: 20.0),
          child: Text(weekDaysList[2].substring(0, 3).capitalizeFirst ??'',
              style: style),
        );
        break;
      case 6:
        text = Padding(
          padding: const EdgeInsets.only(right: 20.0),
          child: Text(weekDaysList[1].substring(0, 3).capitalizeFirst ??'',
              style: style),
        );
        break;
      case 7:
        text = Padding(
          padding: const EdgeInsets.only(right: 15.0),
          child: Text('Today', style: style),
        );
        break;

      default:
        text = Text('', style: style);
        break;
    }

    return SideTitleWidget(
      fitInside: const SideTitleFitInsideData(
          enabled: true,
          distanceFromEdge: 0,
          parentAxisSize: -10,
          axisPosition: 0),
      axisSide: meta.axisSide,
      space: 4,
      child: text,
    );
  }

  Widget _bottomTitleYearWidgets(
      double value, TitleMeta meta, List<String> monthNameList) {
    TextStyle style = GoogleFonts.inter(
      color: AppColorConstant.color3D3A3A,
      fontWeight: FontWeight.w500,
      fontSize: 10,
    );

    Widget text;
    switch (value.toInt()) {
      case 1:
        text = Container(
            margin: const EdgeInsets.only(right: 5),
            child: Text(monthNameList[0].substring(0, 3), style: style));
        break;
      case 2:
        text = Container(
            margin: const EdgeInsets.only(right: 5),
            child: Text(monthNameList[1].substring(0, 3), style: style));
        break;
      case 3:
        text = Container(
            margin: const EdgeInsets.only(right: 5),
            child: Text(monthNameList[2].substring(0, 3), style: style));
        break;
      case 4:
        text = Container(
            margin: const EdgeInsets.only(right: 5),
            child: Text(monthNameList[3].substring(0, 3), style: style));
        break;
      case 5:
        text = Container(
            margin: const EdgeInsets.only(right: 5),
            child: Text(monthNameList[4].substring(0, 3), style: style));
        break;
      case 6:
        text = Container(
            margin: const EdgeInsets.only(right: 5),
            child: Text(monthNameList[5].substring(0, 3), style: style));
        break;
      case 7:
        text = Container(
            margin: const EdgeInsets.only(right: 5),
            child: Text(monthNameList[6].substring(0, 3), style: style));
        break;
      case 8:
        text = Container(
            margin: const EdgeInsets.only(right: 5),
            child: Text(monthNameList[7].substring(0, 3), style: style));
        break;
      case 9:
        text = Container(
            margin: const EdgeInsets.only(right: 5),
            child: Text(monthNameList[8].substring(0, 3), style: style));
        break;
      case 10:
        text = Container(
            margin: const EdgeInsets.only(right: 5),
            child: Text(monthNameList[9].substring(0, 3), style: style));
        break;
      case 11:
        text = Container(
            margin: const EdgeInsets.only(right: 8),
            child: Text(monthNameList[10].substring(0, 3), style: style));
        break;
      case 12:
        text = Container(
            margin: const EdgeInsets.only(left: 110),
            child: Text(monthNameList[11].substring(0, 3), style: style));
        break;
      default:
        text = Text('', style: style);
        break;
    }
    return SideTitleWidget(
      fitInside: SideTitleFitInsideData(
          enabled: true,
          distanceFromEdge: value.toInt() == 12 ? -40 : -45,
          parentAxisSize: -50,
          axisPosition: 5),
      axisSide: meta.axisSide,
      space: 4,
      child: text,
    );
  }

  Widget _bottomTitleMonthWidgets(double value, TitleMeta meta) {
    TextStyle style = GoogleFonts.inter(
      color: AppColorConstant.color3D3A3A,
      fontWeight: FontWeight.w500,
      fontSize: 10,
    );

    Widget text;
    switch (value.toInt()) {
      case 1:
        text = Padding(
          padding: const EdgeInsets.only(left: 5.0),
          child: Text('Week 4', style: style),
        );
        break;
      case 2:
        text = Padding(
          padding: const EdgeInsets.only(left: 0.0),
          child: Text('Week 3', style: style),
        );
        break;
      case 3:
        text = Padding(
          padding: const EdgeInsets.only(left: 30.0),
          child: Text('Week 2', style: style),
        );
        break;
      case 4:
        text = Container(
            margin: const EdgeInsets.only(left: 120),
            child: Text('Active Week', style: style));
        break;
      default:
        text = Text('', style: style);
        break;
    }
    return SideTitleWidget(
      fitInside: SideTitleFitInsideData(
          enabled: true,
          distanceFromEdge: 0,
          parentAxisSize: value.toInt() == 4 ? -40 : -50,
          axisPosition: 0),
      axisSide: AxisSide.bottom,
      space: 4,
      child: text,
    );
  }

  LineChartBarData _buildLineChartBarData(List<double> spots, Color color) {
    return LineChartBarData(
      spots: spots
          .asMap()
          .entries
          .map((e) => FlSpot(double.parse(e.key.toStringAsFixed(1)),
              double.parse(e.value.toStringAsFixed(1))))
          .toList(),
      isCurved: false,
      color: color,
      dotData: const FlDotData(
        show: false, // Hide the dots
      ),
      barWidth: 2,
      belowBarData: BarAreaData(show: false),
    );
  }
}
