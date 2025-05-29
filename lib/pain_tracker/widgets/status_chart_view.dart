import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../common/color_constant.dart';
import '../../common/string_constants.dart';
import '../controller/pain_tracker_controller.dart';

class AllStatusChartView extends StatelessWidget {
  final PainTrackerScreenController? controller;
  const AllStatusChartView({super.key, this.controller});

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
              Text(
                'All stats',
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(
                  fontSize: 20,
                  color: AppColorConstant.black,
                  fontWeight: FontWeight.w400,
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              StatusChart(
                controller: controller,
              ),
            ],
          ),
          Positioned(
              bottom: 20,
              left: 40,
              child: Container(
                height: 20,
                width: 1,
                color: AppColorConstant.lightGrey.withOpacity(0.5),
              )),
          Positioned(
              top: size.height * 0.15,
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
}

class StatusChart extends StatelessWidget {
  final PainTrackerScreenController? controller;
  const StatusChart({super.key, this.controller});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 340,
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
        ],
      ),
      child: Column(
        children: [
          _buildHeader(
            index: controller?.selectedTabIndex.value,
            statusList: controller?.statusList ?? [],
            lastEndDate: controller?.lastEndDate.value ?? '',
            lastStartDate: controller?.lastStartDate.value ?? '',
            lastTimeDays: controller?.lastDayTime.value ?? '',
          ),
          const SizedBox(height: 30),
          _buildChart(controller?.selectedTabIndex.value ?? 0,
              spotsValueActivity: controller?.activityData ?? [],
              spotsValueMuscle: StringConstants.isVersionTwo == false
                  ? []
                  : controller?.muscleData ?? [],
              // controller?.selectedTabIndex.value == 0
              //     ? controller?.spotsActivityListWeek
              //     : controller?.selectedTabIndex.value == 1
              //         ? controller?.spotsActivityListMonth
              //         : controller?.spotsActivityListYear,
              spotsValueEnergy: controller?.energyData ?? [],
              // controller?.selectedTabIndex.value == 0
              //     ? controller?.spotsEnergyListWeek
              //     : controller?.selectedTabIndex.value == 1
              //         ? controller?.spotsEnergyListMonth
              //         : controller?.spotsEnergyListYear,
              spotsValueMood: controller?.moodData ?? [],
              // controller?.selectedTabIndex.value == 0
              //     ? controller?.spotsMoodListWeek
              //     : controller?.selectedTabIndex.value == 1
              //         ? controller?.spotsMoodListMonth
              //         : controller?.spotsMoodListYear,
              spotsValuePain: controller?.painData ?? [],
              // controller?.selectedTabIndex.value == 0
              //     ? controller?.spotsPainListWeek
              //     : controller?.selectedTabIndex.value == 1
              //         ? controller?.spotsPainListMonth
              //         : controller?.spotsPainListYear,
              spotsValueSleep: controller?.sleepData ?? [],
              // controller?.selectedTabIndex.value == 0
              //     ? controller?.spotsSleepListWeek
              //     : controller?.selectedTabIndex.value == 1
              //         ? controller?.spotsSleepListMonth
              //         : controller?.spotsSleepListYear,
              weekNameList: controller?.pastWeekDaysList.value ?? [],
              monthNameList: controller?.pastMonthsList.value ?? []),
        ],
      ),
    );
  }

  Widget _buildHeader(
      {required List<Status> statusList,
      int? index,
      String? lastTimeDays,
      String? lastStartDate,
      String? lastEndDate}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(child: _buildLegend(statusList: statusList, index: index)),
        const SizedBox(
          width: 40,
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
              '$lastStartDate ${lastStartDate == '' ? '' : '-'} $lastEndDate',
              style: GoogleFonts.openSans(
                color: AppColorConstant.lightGrey,
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildLegend({required List<Status> statusList, int? index}) {
    return GridView.count(
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.all(0),
      crossAxisCount: 2,
      childAspectRatio: (index ?? 0) == 1 ? 6 / 1.1 : 6.6 / 1,
      shrinkWrap: true,
      children: List.generate(statusList.length, (index) {
        return _buildLegendItem(statusList[index].text ?? '',
            statusList[index].color ?? Colors.white);
      }),
    );
  }

  Widget _buildLegendItem(String text, Color color) {
    return SizedBox(
      width: 80,
      child: Row(
        children: [
          const SizedBox(width: 10),
          Text(
            text,
            style: GoogleFonts.openSans(
              color: Colors.black,
              fontSize: 9,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(width: 3),
          Expanded(
            child: Container(
              height: 4,
              decoration: BoxDecoration(
                // borderRadius: BorderRadius.circular(5),
                color: color,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildChart(
    int index, {
    List<double>? spotsValuePain,
    List<double>? spotsValueMood,
    List<double>? spotsValueSleep,
    List<double>? spotsValueEnergy,
    List<double>? spotsValueActivity,
    List<double>? spotsValueMuscle,
    List<String>? weekNameList,
    List<String>? monthNameList,
  }) {
    return Expanded(
      child: LineChart(
        LineChartData(
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
                        axisSide: AxisSide.left,
                        child: Text(
                          titleIndex.toString(),
                          style: GoogleFonts.inter(
                            color: AppColorConstant.color3D3A3A,
                            fontSize: 12,
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
            _buildLineChartBarData(
              spotsValuePain ?? [],
              Colors.red,
            ),
            _buildLineChartBarData(
              spotsValueActivity ?? [],
              StringConstants.isVersionTwo == false
                  ? Colors.orange
                  : Colors.yellow,
            ),
            _buildLineChartBarData(
              spotsValueMuscle ?? [],
              Colors.orange,
            ),
            _buildLineChartBarData(
              spotsValueEnergy ?? [],
              Colors.green,
            ),
            _buildLineChartBarData(
              spotsValueMood ?? [],
              Colors.purple,
            ),
            _buildLineChartBarData(
              spotsValueSleep ?? [],
              Colors.blue,
            ),
          ],
        ),
      ),
    );
  }

  Widget _bottomTitleWeekWidgets(
      double value, TitleMeta meta, List<String> weekDaysList) {
    TextStyle style = GoogleFonts.inter(
      color: AppColorConstant.color3D3A3A,
      fontSize: 10,
      fontWeight: FontWeight.w500,
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

  Widget _bottomTitleMonthWidgets(double value, TitleMeta meta) {
    TextStyle style = GoogleFonts.inter(
      color: AppColorConstant.color3D3A3A,
      fontSize: 10,
      fontWeight: FontWeight.w500,
    );

    Widget text;
    switch (value.toInt()) {
      case 1:
        text = Text('Week 4', style: style);
        break;
      case 2:
        text = Text('Week 3', style: style);
        break;
      case 3:
        text = Padding(
          padding: const EdgeInsets.only(left: 0.0),
          child: Text('Week 2', style: style),
        );
        break;
      case 4:
        text = Padding(
          padding: const EdgeInsets.only(left: 120.0),
          child: Text('Active Week', style: style),
        );
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
      axisSide: meta.axisSide,
      space: 4,
      child: text,
    );
  }

  Widget _bottomTitleYearWidgets(
    double value,
    TitleMeta meta,
    List<String> monthNameList,
  ) {
    TextStyle style = GoogleFonts.inter(
      color: AppColorConstant.color3D3A3A,
      fontSize: 10,
      fontWeight: FontWeight.w500,
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
            margin: const EdgeInsets.only(right: 5),
            child: Text(monthNameList[10].substring(0, 3), style: style));
        break;
      case 12:
        text = Container(
            margin: const EdgeInsets.only(left: 125),
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

  LineChartBarData _buildLineChartBarData(List<double> spots, Color color) {
    return LineChartBarData(
      preventCurveOverShooting: true,
      isStrokeJoinRound: true,
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
