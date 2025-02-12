import 'package:chat_bot/chat/view/chat_view.dart';
import 'package:chat_bot/freezed/view/freezed_demo_view.dart';
import 'package:chat_bot/stability_ai/view/input_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: ChatView(),
    );
  }
}

