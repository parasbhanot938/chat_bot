import 'dart:io';

import 'package:chat_bot/api_client/network_exceptions_handler.dart';
import 'package:chat_bot/api_client/network_http.dart';
import 'package:chat_bot/stability_ai/controller/input_controller.dart';
import 'package:chat_bot/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

class InputView extends StatefulWidget {
  InputView({super.key});

  @override
  State<InputView> createState() => _InputViewState();
}

class _InputViewState extends State<InputView> {
  var controller = Get.put(InputController());

  var currentIndex = 0;

  List<Widget> list = [
    Container(
      height: Get.height,
      width: Get.width,
      decoration: const BoxDecoration(color: Colors.pink),
    ),
    Container(
      height: Get.height,
      width: Get.width,
      decoration: const BoxDecoration(color: Colors.orange),
    ),
    Container(
      height: Get.height,
      width: Get.width,
      decoration: const BoxDecoration(color: Colors.green),
    ),
    Container(
      height: Get.height,
      width: Get.width,
      decoration: const BoxDecoration(color: Colors.black),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: currentIndex,
          landscapeLayout: BottomNavigationBarLandscapeLayout.centered,
          type: BottomNavigationBarType.fixed,
          backgroundColor: const Color(0xFF6200EE),
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.white.withOpacity(.60),
          selectedFontSize: 14,
          unselectedFontSize: 14,
          elevation: 0.0,
          onTap: (value) {
            setState(() {
              currentIndex = value;
            });

            // Respond to item press.
          },
          items: [
            const BottomNavigationBarItem(
                icon: Icon(Icons.home), label: "Home", tooltip: "Go to home"),
            const BottomNavigationBarItem(icon: Icon(Icons.add), label: "Add"),
            const BottomNavigationBarItem(
              icon: Icon(Icons.notifications_active_outlined),
              label: "Notifications",
            ),
            const BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: "Profile",
            ),
          ],
        ),
        appBar: AppBar(
          title: Text(
            currentIndex == 0
                ? "Home"
                : currentIndex == 1
                    ? "Add"
                    : currentIndex == 2
                        ? "Notifications"
                        : "Profile",
            style: const TextStyle(color: Colors.blue),
          ),
          centerTitle: true,
        ),
        body: GetBuilder<InputController>(
          init: InputController(),
          builder: (controller) {
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Column(
                  // mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    controller.isLoading == true
                        ? const CircularProgressIndicator()
                        : controller.imageSource != null
                            ? Image.memory(
                                controller.imageSource!,
                                fit: BoxFit.cover,
                              )
                            : const SizedBox(),
                    const SizedBox(
                      height: 20,
                    ),
                    textFormField(
                        controller: controller.textController,
                        size: 14.0,
                        hintText: "Enter text"),
                    TextButton(
                        onPressed: () {
                          controller.generateImage(
                              text: controller.textController.text);
                        },
                        child: const Text(
                          "Generate Image",
                          style: TextStyle(
                              fontSize: 18.0,
                              color: Colors.blue,
                              fontWeight: FontWeight.normal),
                        )),
                    // TextButton(
                    //     onPressed: () async {
                    //       File? image = await getImage();
                    //       try {
                    //         var response = await DioClient.postMethod(
                    //             asFormData: true,
                    //             data: {
                    //               'file': await MultipartFile(image?.path,
                    //                   filename: "")
                    //             },
                    //             url:
                    //                 "https://images.unsplash.com/photo-1611095785020-1ba3dd228ea7?ixid=MXwxMjA3fDF8MHxlZGl0b3JpYWwtZmVlZHwxfHx8ZW58MHx8fA%3D%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=900&q=60");
                    //       } catch (e, s) {
                    //         NetworkExceptionsHandler.getException(e, s);
                    //       }
                    //     },
                    //     child: const Text(
                    //       "Upload image",
                    //       style: TextStyle(
                    //           fontSize: 18.0,
                    //           color: Colors.blue,
                    //           fontWeight: FontWeight.normal),
                    //     )),
                    flutterLogo(),
                    button(),
                  ],
                ),
              ),
            );
          },
        ));
  }

  Future<File?> getImage() async {
    await Permission.camera.request();

    var status = await Permission.camera.status;

    if (status.isGranted) {
      final ImagePicker _picker = ImagePicker();
      final XFile? image = await _picker.pickImage(source: ImageSource.camera);
      File file = File(image!.path);
      return file;
    }

    return null;
  }
}
