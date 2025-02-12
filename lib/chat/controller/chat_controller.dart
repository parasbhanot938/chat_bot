import 'package:chat_bot/chat/model/messages_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:intl/intl.dart';

class ChatController extends GetxController {
  var msgController = TextEditingController();
  final String apiKey = dotenv.env['GOOGLE_API_KEY'] ?? '';

  var messagesList = <MessagesModel>[].obs;


@override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
  }
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }

  var scrollcontroller = ScrollController();

  onSendMessage() async {

    try{
      if (msgController.text.isEmpty) return;
      Get.focusScope?.unfocus();
      final modal = GenerativeModel(model: 'gemini-pro', apiKey: apiKey);
      final prompt = msgController.text;
      msgController.clear();

      messagesList.value.add(
          MessagesModel(message: prompt, date: DateTime.now(), isUser: true));
      messagesList.refresh();
      // scrollcontroller.animateTo(scrollcontroller.position.maxScrollExtent,
      //     duration: Duration(milliseconds: 500), curve: Curves.easeOut);
      final content = [Content.text(prompt)];
      final response = await modal.generateContent(content);

      debugPrint("response : ${response.text}");

      messagesList.value.add(MessagesModel(
          message: response.text ?? "", date: DateTime.now(), isUser: false));
      messagesList.refresh();

      scrollcontroller.animateTo(scrollcontroller.position.maxScrollExtent,
          duration: Duration(milliseconds: 500), curve: Curves.easeOut);
    }
    catch(e){

    }


  }

  formatDate(DateTime date) {
    return DateFormat('hh:mm').format(date);
  }
}
