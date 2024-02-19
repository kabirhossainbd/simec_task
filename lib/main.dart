import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_task/controller/controller.dart';
import 'package:test_task/model/repo.dart';
import 'package:test_task/remote_service/api_client.dart';
import 'package:test_task/view/home_screen.dart';

void main() {
  Get.lazyPut(() => ApiClient(appBaseUrl: 'https://api.github.com/'));
  Get.lazyPut(() => HomeRepo(apiSource: Get.find()));
  Get.lazyPut(() => HomeController(homeRepo: Get.find()));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const HomeScreen()
    );
  }
}


