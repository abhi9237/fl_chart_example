

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../common/pain_tracker_model.dart';
import '../../common/string_constants.dart';
import '../../local_storage/pref_utils.dart';
import '../modal/add_pain_tracker_modal.dart';
import '../modal/get_all_pain_tracker.dart';

class PainTrackerScreenController extends GetxController
    with GetSingleTickerProviderStateMixin {
  // GlobalKey<SliderDrawerState> key = GlobalKey<SliderDrawerState>(
  //   debugLabel: math.Random().nextInt(999).toString(),
  // );
  GetStorageController localStorage = Get.find<GetStorageController>();
  RxBool isLoading = false.obs;

  RxInt selectedTabIndex = 0.obs;
  TabController? tabController;
  RxString lastDayTime = '7 days'.obs;
  RxString lastStartDate = ''.obs;
  RxString lastEndDate = ''.obs;
  RxList<String> pastWeekDaysList = <String>[].obs;
  RxList<String> pastMonthsList = <String>[].obs;
  RxString previousYear = ''.obs;
  RxString currentYear = ''.obs;
  RxString currentMonth = ''.obs;
  RxString previousMonth = ''.obs;
  RxString lastDay = ''.obs;
  RxString startDay = ''.obs;
  //show charts

  RxBool painChart = false.obs;
  RxBool moodChart = false.obs;
  RxBool energyChart = false.obs;
  RxBool sleepChart = false.obs;
  RxBool activityChart = false.obs;

  RxList<Status> statusList = StringConstants.isVersionTwo == false
      ? [
          Status(color: Colors.red, text: 'Pain'),
          Status(color: Colors.purple, text: 'Mood'),
          Status(text: 'Activity', color: Colors.orange),
          Status(text: 'Sleep', color: Colors.blue),
          Status(text: 'Energy', color: Colors.green),
        ].obs
      : [
          Status(color: Colors.red, text: 'Pain'),
          // Status(text: 'Muscle\nTension', color: Colors.orange),
          Status(text: 'Tension', color: Colors.orange),
          Status(color: Colors.purple, text: 'Mood'),
          Status(text: 'Activity', color: Colors.yellow),
          Status(text: 'Sleep', color: Colors.blue),
          Status(text: 'Energy', color: Colors.green),
        ].obs;


  @override
  Future<void> onInit() async {
    super.onInit();
    tabController = TabController(length: 3, vsync: this);
    getGraphDaysData();
    dummyData();
    // await getPainTrackerApi();
    // getSevenDaysData();
    // await getPainTrackerApi(true);
  }

  RxString status = 'pain'.obs;

  changeStatus(String value, BuildContext context) {
    status.value = value;
    Navigator.of(context).pop();
    update();
  }

  List<double> showSeparateSpots() {
    if (status.value == 'pain') {
      return painData;
    } else if (status.value == 'activity') {
      return activityData;
    } else if (status.value == 'tension') {
      return muscleData;
    } else if (status.value == 'energy') {
      return energyData;
    } else if (status.value == 'mood') {
      return moodData;
    } else if (status.value == 'sleep') {
      return sleepData;
    } else {
      return [];
    }
  }

  Color showSeparateSpotsColor() {
    if (status.value == 'pain') {
      return Color(0xffD7100D);
    } else if (status.value == 'activity') {
      // return Color(0xffFEB645);
      return StringConstants.isVersionTwo == false
          ? Colors.orange
          : Colors.yellow;
    } else if (status.value == 'tension') {
      return Colors.orange;
    } else if (status.value == 'energy') {
      return Color(0xff27D14E);
    } else if (status.value == 'mood') {
      return Color(0xff9A3CC7);
    } else if (status.value == 'sleep') {
      return Color(0xff227AEB);
    } else {
      return Colors.transparent;
    }
  }

  Color showSeparateStatus() {
    if (status.value == 'pain') {
      return Color(0xffD7100D);
    }

    // else if (status.value == 'activity') {
    //   return Color(0xffFEB645);
    // }
    else if (status.value == 'activity') {
      // return Color(0xffFEB645);
      return Colors.orange;
    } else if (status.value == 'muscle') {
      return Colors.yellow;
    } else if (status.value == 'energy') {
      return Color(0xff27D14E);
    } else if (status.value == 'mood') {
      return Color(0xff9A3CC7);
    } else if (status.value == 'sleep') {
      return Color(0xff227AEB);
    } else {
      return Colors.transparent;
    }
  }

  Rx<GetPainTrackerModal> getPainTrackerModal = GetPainTrackerModal().obs;
//   Future<void> getPainTrackerApi() async {
//     isLoading(true);
//
//     final response = await AppApiCall.getMethod(
//       endPoint: AppApiConstant.baseUrl + AppApiConstant.allPainTracker,
//       token: localStorage.token,
//     );
//     log('pain tracker ==>>>>${response}');
//     // Logger.responseBody(response);
//     if (response != null) {
//       try {
//         var result = GetPainTrackerModal.fromMap(response);
//         //may
//
// //         result.data?.add(
// //             Datum(
// //           id: 2,
// //               pain: 0,
// //               activity: 4,
// //               energy: 3,
// //               mood: 7,
// //               sleep: 6,
// //               userId: 2,
// //               datetime: DateTime.parse("2024-05-19 00:00:00")
// //         ));
// //         result.data?.add(
// //             Datum(
// //                 id: 3,
// //                 pain: 0,
// //                 activity: 7,
// //                 energy: 3,
// //                 mood: 4,
// //                 sleep: 6,
// //                 userId: 2,
// //                 datetime: DateTime.parse("2024-05-18 00:00:00")
// //             ));
// //         result.data?.add(
// //             Datum(
// //                 id: 4,
// //                 pain: 0,
// //                 activity: 6,
// //                 energy: 3,
// //                 mood: 8,
// //                 sleep: 5,
// //                 userId: 2,
// //                 datetime: DateTime.parse("2024-05-17 00:00:00")
// //             ));
// //         result.data?.add(
// //             Datum(
// //                 id: 5,
// //                 pain: 0,
// //                 activity: 4,
// //                 energy: 8,
// //                 mood: 4,
// //                 sleep: 6,
// //                 userId: 2,
// //                 datetime: DateTime.parse("2024-05-16 00:00:00")
// //             ));
// //
// //         result.data?.add(
// //             Datum(
// //                 id: 6,
// //                 pain: 0,
// //                 activity: 10,
// //                 energy: 8,
// //                 mood: 7,
// //                 sleep: 4,
// //                 userId: 2,
// //                 datetime: DateTime.parse("2024-05-05 00:00:00")
// //             ));
// //
// // ///// june
// //         result.data?.add(
// //             Datum(
// //                 id: 2,
// //                 pain: 9,
// //                 activity: 5,
// //                 energy: 0,
// //                 mood: 7,
// //                 sleep: 9,
// //                 userId: 2,
// //                 datetime: DateTime.parse("2024-06-09 00:00:00")
// //             ));
// //         result.data?.add(
// //             Datum(
// //                 id: 3,
// //                 pain: 7,
// //                 activity: 7,
// //                 energy: 0,
// //                 mood: 4,
// //                 sleep: 6,
// //                 userId: 2,
// //                 datetime: DateTime.parse("2024-06-08 00:00:00")
// //             ));
// //         result.data?.add(
// //             Datum(
// //                 id: 4,
// //                 pain: 3,
// //                 activity: 6,
// //                 energy: 0,
// //                 mood: 8,
// //                 sleep: 5,
// //                 userId: 2,
// //                 datetime: DateTime.parse("2024-06-27 00:00:00")
// //             ));
// //         result.data?.add(
// //             Datum(
// //                 id: 5,
// //                 pain: 6,
// //                 activity: 2,
// //                 energy: 0,
// //                 mood: 8,
// //                 sleep: 6,
// //                 userId: 2,
// //                 datetime: DateTime.parse("2024-06-18 00:00:00")
// //             ));
// //
// //         result.data?.add(
// //             Datum(
// //                 id: 6,
// //                 pain: 4,
// //                 activity: 10,
// //                 energy: 0,
// //                 mood: 5,
// //                 sleep: 9,
// //                 userId: 2,
// //                 datetime: DateTime.parse("2024-06-10 00:00:00")
// //             ));
// //         result.data?.add(
// //             Datum(
// //                 id: 6,
// //                 pain: 9,
// //                 activity: 0,
// //                 energy: 0,
// //                 mood: 6,
// //                 sleep: 10,
// //                 userId: 2,
// //                 datetime: DateTime.parse("2024-06-05 00:00:00")
// //             ));
// //
// //         ///// july
// //         result.data?.add(
// //             Datum(
// //                 id: 2,
// //                 pain: 9,
// //                 activity: 5,
// //                 energy: 7,
// //                 mood: 7,
// //                 sleep: 9,
// //                 userId: 2,
// //                 datetime: DateTime.parse("2024-07-09 00:00:00")
// //             ));
// //         result.data?.add(
// //             Datum(
// //                 id: 3,
// //                 pain: 7,
// //                 activity: 7,
// //                 energy: 3,
// //                 mood: 4,
// //                 sleep: 6,
// //                 userId: 2,
// //                 datetime: DateTime.parse("2024-07-18 00:00:00")
// //             ));
// //         result.data?.add(
// //             Datum(
// //                 id: 4,
// //                 pain: 3,
// //                 activity: 6,
// //                 energy: 3,
// //                 mood: 8,
// //                 sleep: 5,
// //                 userId: 2,
// //                 datetime: DateTime.parse("2024-07-27 00:00:00")
// //             ));
// //         result.data?.add(
// //             Datum(
// //                 id: 5,
// //                 pain: 6,
// //                 activity: 2,
// //                 energy: 8,
// //                 mood: 8,
// //                 sleep: 6,
// //                 userId: 2,
// //                 datetime: DateTime.parse("2024-07-10 00:00:00")
// //             ));
// //
// //         result.data?.add(
// //             Datum(
// //                 id: 6,
// //                 pain: 4,
// //                 activity: 10,
// //                 energy: 8,
// //                 mood: 5,
// //                 sleep: 9,
// //                 userId: 2,
// //                 datetime: DateTime.parse("2024-07-15 00:00:00")
// //             ));
// //         result.data?.add(
// //             Datum(
// //                 id: 6,
// //                 pain: 9,
// //                 activity: 0,
// //                 energy: 8,
// //                 mood: 6,
// //                 sleep: 10,
// //                 userId: 2,
// //                 datetime: DateTime.parse("2024-07-05 00:00:00")
// //             ));
// //
// //         ///// august
// //         result.data?.add(
// //             Datum(
// //                 id: 2,
// //                 pain: 9,
// //                 activity: 5,
// //                 energy: 7,
// //                 mood: 7,
// //                 sleep: 9,
// //                 userId: 2,
// //                 datetime: DateTime.parse("2024-08-09 00:00:00")
// //             ));
// //         result.data?.add(
// //             Datum(
// //                 id: 3,
// //                 pain: 7,
// //                 activity: 7,
// //                 energy: 3,
// //                 mood: 4,
// //                 sleep: 6,
// //                 userId: 2,
// //                 datetime: DateTime.parse("2024-08-20 00:00:00")
// //             ));
// //         result.data?.add(
// //             Datum(
// //                 id: 4,
// //                 pain: 3,
// //                 activity: 6,
// //                 energy: 3,
// //                 mood: 8,
// //                 sleep: 5,
// //                 userId: 2,
// //                 datetime: DateTime.parse("2024-08-17 00:00:00")
// //             ));
// //         result.data?.add(
// //             Datum(
// //                 id: 5,
// //                 pain: 6,
// //                 activity: 2,
// //                 energy: 8,
// //                 mood: 8,
// //                 sleep: 6,
// //                 userId: 2,
// //                 datetime: DateTime.parse("2024-08-12 00:00:00")
// //             ));
// //
// //         result.data?.add(
// //             Datum(
// //                 id: 6,
// //                 pain: 4,
// //                 activity: 10,
// //                 energy: 8,
// //                 mood: 5,
// //                 sleep: 9,
// //                 userId: 2,
// //                 datetime: DateTime.parse("2024-08-25 00:00:00")
// //             ));
// //         result.data?.add(
// //             Datum(
// //                 id: 6,
// //                 pain: 9,
// //                 activity: 0,
// //                 energy: 8,
// //                 mood: 6,
// //                 sleep: 10,
// //                 userId: 2,
// //                 datetime: DateTime.parse("2024-08-16 00:00:00")
// //             ));
// //         result.data?.add(
// //             Datum(
// //                 id: 6,
// //                 pain: 9,
// //                 activity: 0,
// //                 energy: 8,
// //                 mood: 6,
// //                 sleep: 10,
// //                 userId: 2,
// //                 datetime: DateTime.parse("2024-08-15 00:00:00")
// //             ));
// //         result.data?.add(
// //             Datum(
// //                 id: 6,
// //                 pain: 9,
// //                 activity: 0,
// //                 energy: 2,
// //                 mood: 6,
// //                 sleep: 10,
// //                 userId: 2,
// //                 datetime: DateTime.parse("2024-08-14 00:00:00")
// //             ));
//
//         if (result.success == true) {
//           if (result.data != null) {
//             getPainTrackerModal(result);
//
//             getPainTrackerModal.refresh();
//
//             getSevenDaysData();
//
//             isLoading(false);
//             update();
//           }
//           // }
//         } else {
//           isLoading(false);
//           CustomToast.showToast(result.message!);
//         }
//       } on d.DioException catch (e) {
//         isLoading(false);
//       }
//     } else {
//       isLoading(false);
//     }
//
//     update();
//   }

  RxBool isPainLoading = false.obs;
  Rx<AddPainTrackerModal> addPainTrackerModal = AddPainTrackerModal().obs;

  RxList<String> changeStatusList = StringConstants.isVersionTwo == false
      ? [
          'pain',
          'activity',
          'energy',
          'mood',
          'sleep',
        ].obs
      : [
          'pain',
          'tension',
          'activity',
          'energy',
          'mood',
          'sleep',
        ].obs;

  // Future<void> addPainTrackerApi({
  //   String? rate,
  //   var data,
  //   required BuildContext context,
  // }) async {
  //   isPainLoading(true);
  //
  //   // var data = {
  //   //   "pain": 2,
  //   //   "activity": 4,
  //   //   "energy": 5,
  //   //   "mood": 7,
  //   //   "sleep": 5,
  //   // };
  //   final response = await AppApiCall.postMethod(
  //     endPoint: AppApiConstant.baseUrl + AppApiConstant.addPainTracker,
  //     token: localStorage.token,
  //     data: data,
  //   );
  //
  //   // Logger.responseBody(response);
  //   if (response != null) {
  //     try {
  //       print(response);
  //       var result = AddPainTrackerModal.fromMap(response);
  //
  //       if (result.success == true) {
  //         await addPainTrackerModal(result);
  //
  //         addPainTrackerModal.refresh();
  //         getPainTrackerModal.value.data?.removeWhere((value) {
  //           return value.datetime?.day == result.data?.datetime?.day &&
  //               value.datetime?.month == result.data?.datetime?.month &&
  //               value.datetime?.year == result.data?.datetime?.year;
  //         });
  //         getPainTrackerModal.value.data?.add(result.data ?? Datum());
  //         getPainTrackerModal.refresh();
  //         getPainTrackerModal.refresh();
  //         refreshChartData();
  //         refresh();
  //         // Navigator.pop(context);
  //
  //         // if(mounted){
  //         context.pop();
  //         // }
  //
  //         isPainLoading(false);
  //         update();
  //       } else {
  //         isPainLoading(false);
  //         CustomToast.showToast(result.message!);
  //       }
  //     } on d.DioException catch (e) {
  //       isPainLoading(false);
  //     }
  //   } else {
  //     isLoading(false);
  //   }
  //
  //   update();
  // }

  getGraphDaysData() {
    pastWeekDaysList.value = getPastWeekdays(7);
    pastMonthsList.value = getPast12Months();
    getWeekDays();
    getMonths();
    getYears();
  }

  /// **** Get Past And Current Year  *****

  getYears() {
    DateTime now = DateTime.now();
    int latestYear = now.year;
    int pastYear = latestYear - 1;
    currentYear.value = latestYear.toString();
    previousYear.value = pastYear.toString();
  }

  /// **** Get Past And Current Month  *****

  getMonths() {
    DateTime now = DateTime.now();

    List<String> monthNames = [
      "January",
      "February",
      "March",
      "April",
      "May",
      "June",
      "July",
      "August",
      "September",
      "October",
      "November",
      "December"
    ];

    int currentMonthIndex = now.month; // Get the current month index (1-12)
    String currentMonthName =
        monthNames[currentMonthIndex - 1]; // Get the current month name
    String previousMonthName;
    if (currentMonthIndex == 1) {
      previousMonthName = monthNames[11]; // December of the previous year
    } else {
      previousMonthName =
          monthNames[currentMonthIndex - 2]; // Get the previous month name
    }

    currentMonth.value = currentMonthName;
    previousMonth.value = previousMonthName;
    update();
  }

  /// **** Get Past And Current Week Day  *****

  getWeekDays() {
    DateTime now = DateTime.now(); // Current date
    DateTime endDate = now;
    DateTime startDate = now.subtract(const Duration(days: 6)); // Last 7 days

    // Date format for displaying month and day (e.g., "May 9")
    DateFormat dateFormat = DateFormat("MMM d");
    // Format the start and end dates
    String startDateFormatted = dateFormat.format(startDate);
    String endDateFormatted = dateFormat.format(endDate);

    startDay.value = startDateFormatted;
    lastDay.value = endDateFormatted;
    lastStartDate.value = startDay.value;
    lastEndDate.value = lastDay.value;
    update();
  }

  String getGreeting() {
    final hour = DateTime.now().hour;
    if (hour < 12) {
      return 'Good Morning';
    } else if (hour < 18) {
      return 'Good Afternoon';
    } else {
      return 'Good Night';
    }
  }

  RxList<double> painData = <double>[].obs;
  RxList<double> moodData = <double>[].obs;
  RxList<double> sleepData = <double>[].obs;
  RxList<double> energyData = <double>[].obs;
  RxList<double> muscleData = <double>[].obs;
  RxList<double> activityData = <double>[].obs;

  List<String> getPastWeekdays(int numberOfDays) {
    DateTime now = DateTime.now();
    List<String> weekdays = [];
    int daysCount = 0;

    while (daysCount < numberOfDays) {
      weekdays.add(DateFormat('EEEE').format(now));
      now = now.subtract(const Duration(days: 1));
      daysCount++;
    }
    return weekdays;
  }

  List<String> getPast12Months() {
    DateTime now = DateTime.now();
    List<String> months = [];
    for (int i = 0; i < 12; i++) {
      DateTime month = DateTime(now.year, now.month - i, 1);
      months.add(DateFormat('MMMM').format(month));
    }
    return months.reversed
        .toList(); // Reversed to show the most recent month first
  }

  onTapTabBarIndex(int value) {
    selectedTabIndex.value = value;
    switch (value) {
      case 0:
        {
          lastDayTime.value = '7 days';
          lastStartDate.value = startDay.value;
          lastEndDate.value = lastDay.value;
          getSevenDaysData();
          dummyData();
        }
      case 1:
        {
          // print("tabmonth" );
          // print(DateTime.now().subtract(Duration(days: 28)).month == DateTime.now().month);
          lastDayTime.value = '28 days';
          lastStartDate.value =
              (DateTime.now().subtract(const Duration(days: 28)).month ==
                      DateTime.now().month)
                  ? ""
                  : previousMonth.value;
          lastEndDate.value = currentMonth.value;
          // getChartData(days: 30);
          get28DadysData();
          dummyData();
        }
      case 2:
        {
          lastDayTime.value = 'Year';
          lastStartDate.value = previousYear.value;
          lastEndDate.value = currentYear.value;
          getYearData();
          dummyData();
        }
    }
    update();
  }

  getSevenDaysData() {
    RxList<Datum>? sevendayData = <Datum>[].obs;
    DateTime now = DateTime.now(); // Current date
    DateTime endDate = now;
    DateTime startDate = now.subtract(const Duration(days: 6));
    // getPainTrackerModal
    // if (result.success == true) {
    List<DateTime> dateList = [];
    for (int i = 0; i <= endDate.difference(startDate).inDays; i++) {
      dateList.add(startDate.add(Duration(days: i)));
    }
    print("datesofLastWeek.. ${dateList}");
    // List<Datum> dataa = <Datum>[];
    sevendayData.clear();
    if (getPainTrackerModal.value.data != null) {
      for (DateTime date in dateList) {
        // Check if there is data for this date in the original list
        Datum? existingData = getPainTrackerModal.value.data?.firstWhere(
          (datum) =>
              datum?.datetime?.year == date.year &&
              datum.datetime?.month == date.month &&
              datum.datetime?.day == date.day,
          orElse: () => Datum(
            pain: null,
            activity: null,
            energy: null,
            mood: null,
            sleep: null,
            muscleTension: null,
            datetime: date,
            userId: null,
          ),
        );
        sevendayData.add(existingData ?? Datum());
      }
    }
    for (var a in sevendayData) {
      print("jsonEncode(a)");
      print(a.datetime);
      print(a.pain);

      // print(a);
    }

    painData.clear();
    moodData.clear();
    sleepData.clear();
    energyData.clear();
    muscleData.clear();
    activityData.clear();
    for (var a in sevendayData) {
      bool isCurrentDay = a.datetime?.year == now.year &&
          a.datetime?.month == now.month &&
          a.datetime?.day == now.day;

      isCurrentDay
          ? (a.pain.toString().isEmpty || a.pain == null)
              ? null
              : painData.add(double.parse(a.pain.toString()))
          : painData.add(double.parse(
              (a.pain.toString().isEmpty || a.pain == null)
                  ? "0"
                  : a.pain.toString()));

      isCurrentDay
          ? (a.mood.toString().isEmpty || a.mood == null)
              ? null
              : moodData.add(double.parse(a.mood.toString()))
          : moodData.add(double.parse(
              (a.mood.toString().isEmpty || a.mood == null)
                  ? "0"
                  : a.mood.toString()));

      isCurrentDay
          ? (a.sleep.toString().isEmpty || a.sleep == null)
              ? null
              : sleepData.add(double.parse(a.sleep.toString()))
          : sleepData.add(double.parse(
              (a.sleep.toString().isEmpty || a.sleep == null)
                  ? "0"
                  : a.sleep.toString()));
      isCurrentDay
          ? (a.energy.toString().isEmpty || a.energy == null)
              ? null
              : energyData.add(double.parse(a.energy.toString()))
          : energyData.add(double.parse(
              (a.energy.toString().isEmpty || a.energy == null)
                  ? "0"
                  : a.energy.toString()));
      isCurrentDay
          ? (a.activity.toString().isEmpty || a.activity == null)
              ? null
              : activityData.add(double.parse(a.activity.toString()))
          : activityData.add(double.parse(
              (a.activity.toString().isEmpty || a.activity == null)
                  ? "0"
                  : a.activity.toString()));

      isCurrentDay
          ? (a.muscleTension.toString().isEmpty || a.muscleTension == null)
              ? null
              : muscleData.add(double.parse(a.muscleTension.toString()))
          : muscleData.add(double.parse(
              (a.muscleTension.toString().isEmpty || a.muscleTension == null)
                  ? "0"
                  : a.muscleTension.toString()));
    }

    // log('pain Data==>>>>$painData');
    // log('moodData Data==>>>>$moodData');
    // log('sleepData Data==>>>>$sleepData');
    // log('energyData Data==>>>>$energyData');
    // log('activity Data==>>>>$activityData');
  }

  /////// GET 28 DAYS DATA BLOCK START //////////
  get28DadysData() {
    // Get the last 30 days
    DateTime now = DateTime.now(); // Current date
    DateTime endDate = now;
    DateTime startDate = now.subtract(const Duration(days: 27));
    // getPainTrackerModal
    // if (result.success == true) {
    List<DateTime> dateList = [];
    for (int i = 0; i <= endDate.difference(startDate).inDays; i++) {
      dateList.add(startDate.add(Duration(days: i)));
    }
    print("datesofLast28Days.. ${dateList}");
    // Fill missing dates with default data
    List<Datum> filledData = filterAndAddMissingDates(
        getPainTrackerModal.value.data ?? [], dateList);

    // Group the data into 4 weeks
    List<List<Datum>> groupedWeeks = groupDataIntoWeeks(filledData);

    // Print the grouped weekly data
    for (int i = 0; i < groupedWeeks.length; i++) {
      print("Week ${i + 1}:");
      for (var data in groupedWeeks[i]) {
        print(
            "Date: ${data.datetime}, Pain: ${data.pain}, Activity: ${data.activity}, sleep: ${data.sleep}");
      }
    }

    painData.clear();
    moodData.clear();
    sleepData.clear();
    energyData.clear();
    activityData.clear();
    muscleData.clear();

    // Calculate the averages pain and other value for each week
    for (var week in groupedWeeks) {
      double totalPain = 0;
      double totalMood = 0;
      double totalSleep = 0;
      double totalEnergy = 0;
      double totalActivity = 0;
      double totalMuscleTension = 0;
      for (var data in week) {
        totalPain += data.pain ?? 0;
        totalMood += data.mood ?? 0;
        totalSleep += data.sleep ?? 0;
        totalEnergy += data.energy ?? 0;
        totalActivity += data.activity ?? 0;
        totalMuscleTension += data.muscleTension ?? 0;
      }
      // Calculate average and add to the list
      // double averagePain = totalPain / week.length;
      painData.add(totalPain / week.length);
      moodData.add(totalMood / week.length);
      sleepData.add(totalSleep / week.length);
      energyData.add(totalEnergy / week.length);
      activityData.add(totalActivity / week.length);
      muscleData.add(totalMuscleTension / week.length);
    }

    // // Print the weekly averages
    // for (int i = 0; i < weeklyPainAverages.length; i++) {
    //   print("Week ${i + 1} Average Pain: ${weeklyPainAverages[i]}");
    // }
  }

// Function to group data into 4 weeks
  List<List<Datum>> groupDataIntoWeeks(List<Datum> data) {
    List<List<Datum>> weeklyData = [];

    for (int i = 0; i < 4; i++) {
      int startIndex = i * 7;
      print("startIndex");
      print(startIndex);
      int endIndex = startIndex + 7;
      print("endIndex");
      print(endIndex);
      // Handle cases where there might be fewer than 7 days in the last week
      List<Datum> week = data.sublist(
          startIndex, endIndex > data.length ? data.length : endIndex);
      weeklyData.add(week);
    }

    return weeklyData;
  }

/////// GET 28 DAYS DATA FUNCTIONS BLOCK ENDS //////////

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////

  /////// GET  YEAR DATA BLOCK START //////////

  void getYearData() {
    // Get the last year
    DateTime now = DateTime.now(); // Current date
    DateTime endDate = now;
    DateTime startDate = now.subtract(const Duration(days: 365));

    // Generate date list for the past year
    List<DateTime> dateList = [];
    for (int i = 0; i <= endDate.difference(startDate).inDays; i++) {
      dateList.add(startDate.add(Duration(days: i)));
    }

    print("Dates of the last year: $dateList");
    print("Total days: ${dateList.length}");

    // Fill missing dates with default data
    List<Datum> filledData = filterAndAddMissingDates(
        getPainTrackerModal.value.data ?? [], dateList);

    // Get the last 12 months
    List<String> last12Months = getPast12Months();
    print("Last 12 Months: $last12Months");

    // Grouping data by the last 12 months
    Map<String, List<Datum>> groupedDataByMonth = {};
    for (var month in last12Months) {
      groupedDataByMonth[month] = [];
    }

    for (var datum in filledData) {
      String monthKey = DateFormat('MMMM').format(datum.datetime!);
      if (groupedDataByMonth.containsKey(monthKey)) {
        groupedDataByMonth[monthKey]?.add(datum);
      }
    }

    // Printing grouped data for each month
    groupedDataByMonth.forEach((month, data) {
      print("Month: $month");
      for (var datum in data) {
        print("  Pain: ${datum.pain}, Date: ${datum.datetime}");
      }
    });

    // Calculate the average pain for each month
    painData.clear();
    moodData.clear();
    sleepData.clear();
    energyData.clear();
    activityData.clear();
    muscleData.clear();

    groupedDataByMonth.forEach((month, data) {
      if (data.isNotEmpty) {
        // double averagePain = data.map((datum) => datum.pain).reduce((a, b) => a + b) / data.length;
        double averagePain = data
                .map((datum) => datum.pain ?? 0)
                .reduce((a, b) => (a ?? 0) + (b ?? 0)) /
            (data.length > 0 ? data.length : 1);
        double averageMood = data
                .map((datum) => datum.mood ?? 0)
                .reduce((a, b) => (a ?? 0) + (b ?? 0)) /
            (data.length > 0 ? data.length : 1);
        double averageSleep = data
                .map((datum) => datum.sleep ?? 0)
                .reduce((a, b) => (a ?? 0) + (b ?? 0)) /
            (data.length > 0 ? data.length : 1);
        double averageEnergy = data
                .map((datum) => datum.energy ?? 0)
                .reduce((a, b) => (a ?? 0) + (b ?? 0)) /
            (data.length > 0 ? data.length : 1);
        double averageAcivity = data
                .map((datum) => datum.activity ?? 0)
                .reduce((a, b) => (a ?? 0) + (b ?? 0)) /
            (data.length > 0 ? data.length : 1);

        double averageMuscleTension = data
                .map((datum) => datum.muscleTension ?? 0)
                .reduce((a, b) => (a ?? 0) + (b ?? 0)) /
            (data.length > 0 ? data.length : 1);

        painData.add(averagePain);
        moodData.add(averageMood);
        sleepData.add(averageSleep);
        energyData.add(averageEnergy);
        activityData.add(averageAcivity);
        muscleData.add(averageMuscleTension);
      } else {
        painData.add(0.0); // If no data for a month, average is 0
        moodData.add(0.0); // If no data for a month, average is 0
        sleepData.add(0.0); // If no data for a month, average is 0
        energyData.add(0.0); // If no data for a month, average is 0
        activityData.add(0.0); // If no data for a month, average is 0
        muscleData.add(0.0); // If no data for a month, average is 0
      }
    });

    // Printing the average pain for each month
    for (int i = 0; i < last12Months.length; i++) {
      print("Month: ${last12Months[i]}, Average Pain: ${painData[i]}");
    }
  }

  /////// GET  YEAR DATA BLOCK ENDS //////////

////// HELPER FUNCTIONS /////////
// Function to filter and add missing dates
  List<Datum> filterAndAddMissingDates(
      List<Datum> originalData, List<DateTime> dates) {
    List<Datum> result = [];

    for (DateTime date in dates) {
      // Check if there is data for this date in the original list
      Datum existingData = originalData.firstWhere(
        (datum) =>
            datum.datetime?.year == date.year &&
            datum.datetime?.month == date.month &&
            datum.datetime?.day == date.day,
        orElse: () => Datum(
          pain: 0,
          activity: 0,
          energy: 0,
          mood: 0,
          sleep: 0,
          muscleTension: 0,
          datetime: date,
          // userId: ,
        ),
      );

      result.add(existingData);
    }

    return result;
  }

  double getAverageOfSelectedItem() {
    // Make sure the status variable is defined and available in the current scope
    if (status.toLowerCase() == "pain") {
      // Calculate average for painData
      return painData.isEmpty
          ? 0.0
          : painData.reduce((a, b) => a + b) / painData.length;
    } else if (status.toLowerCase() == "mood") {
      // Calculate average for moodData (assuming moodData is an RxList<double>)
      return moodData.isEmpty
          ? 0.0
          : moodData.reduce((a, b) => a + b) / moodData.length;
    } else if (status.toLowerCase() == "sleep") {
      // Calculate average for sleepData (assuming sleepData is an RxList<double>)
      return sleepData.isEmpty
          ? 0.0
          : sleepData.reduce((a, b) => a + b) / sleepData.length;
    } else if (status.toLowerCase() == "energy") {
      // Calculate average for energyData (assuming energyData is an RxList<double>)
      return energyData.isEmpty
          ? 0.0
          : energyData.reduce((a, b) => a + b) / energyData.length;
    } else if (status.toLowerCase() == "activity") {
      // Calculate average for activityData (assuming activityData is an RxList<double>)
      return activityData.isEmpty
          ? 0.0
          : activityData.reduce((a, b) => a + b) / activityData.length;
    } else if (status.toLowerCase() == "muscle tension") {
      // Calculate average for activityData (assuming activityData is an RxList<double>)
      return muscleData.isEmpty
          ? 0.0
          : muscleData.reduce((a, b) => a + b) / muscleData.length;
    } else {
      // Return 0.0 if status does not match any known category
      return 0.0;
    }
  }

  refreshChartData() {
    if (selectedTabIndex.value == 0) {
      getSevenDaysData();
    } else if (selectedTabIndex.value == 1) {
      get28DadysData();
    } else if (selectedTabIndex.value == 2) {
      getYearData();
    }
  }


  dummyData(){
    painData.value = [2.0,3.0,4.0,3.0];
    moodData.value = [1.0,2.0,3.0,6.0,5.0];
    sleepData.value = [3.0,4.0,5.0,2.0];
    energyData.value = [2.0,4.0,5.0,6.0,1.0];
    muscleData.value = [1.0,3.0,4.0,5.0,8.0];
    activityData.value = [1.0,2.0,3.0,4.0,5.0,6.0];
    // RxList<double> painData = <double>[].obs;
    // RxList<double> moodData = <double>[].obs;
    // RxList<double> sleepData = <double>[].obs;
    // RxList<double> energyData = <double>[].obs;
    // RxList<double> muscleData = <double>[].obs;
    // RxList<double> activityData = <double>[].obs;
  }

}

class Status {
  String? text;
  Color? color;
  Status({this.color, this.text});
}
