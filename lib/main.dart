import 'package:fl_chart_example/pain_tracker/presentation/pain_tracker_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get_storage/get_storage.dart';

import 'local_storage/pref_utils.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();

  await GetStorage.init();
  var localStorage = Get.put(GetStorageController());
  await localStorage.init();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const PainTrackerScreen(),
    );
  }
}


