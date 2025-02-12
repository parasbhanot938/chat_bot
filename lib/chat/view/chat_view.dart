import 'package:chat_bot/chat/controller/chat_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/instance_manager.dart';

class ChatView extends StatelessWidget {
  ChatView({super.key});

  @override
  var controller = Get.put(ChatController());

  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        final shouldPop = await showDialog<bool>(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text('Exit'),
              content: const Text('Are you sure you want to exit the app?'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context, true);
                  },
                  child: const Text('Yes'),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pop(context, false);
                  },
                  child: const Text(
                    'No',
                    style: TextStyle(color: Colors.red),
                  ),
                ),
              ],
            );
          },
        );
        return shouldPop!;
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            "Chat Bot",
            style: TextStyle(fontSize: 18.0),
          ),
          centerTitle: true,
        ),
        body: Column(
          children: [
            chat(),
            msgField(),
          ],
        ),
      ),
    );
  }

  msgField() {
    return Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50),
          color: Colors.purple.withOpacity(0.1),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: Row(
          children: [
            const SizedBox(width: 10),
            Expanded(
              child: TextField(
                controller: controller.msgController,
                maxLines: 4,
                style: const TextStyle(fontWeight: FontWeight.normal),
                minLines: 1,
                decoration: const InputDecoration.collapsed(
                  hintStyle: TextStyle(fontWeight: FontWeight.normal),
                  hintText: "Type message here....",
                ),
              ),
            ),
            IconButton(
                onPressed: () {
                  controller.onSendMessage();
                },
                icon: const CircleAvatar(
                    child: Center(
                        child: Icon(
                  Icons.send,
                  color: Colors.purple,
                )))),
          ],
        ));
  }

  chat() {
    return Expanded(
      child: Obx(
        () => ListView.separated(
          controller: controller.scrollcontroller,
          separatorBuilder: (context, index) {
            return const SizedBox(
              height: 15,
            );
          },
          // shrinkWrap: true,
          itemCount: controller.messagesList.value.length ?? 0,
          itemBuilder: (context, index) {
            var messages = controller.messagesList.value[index];
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Flexible(
                    child: Align(
                      alignment: messages.isUser
                          ? Alignment.topRight
                          : Alignment.topLeft,
                      child: Container(
                          decoration: BoxDecoration(
                              color: messages.isUser
                                  ? Colors.purple.withOpacity(0.2)
                                  : Colors.grey.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(10)),
                          padding: const EdgeInsets.all(14),
                          child: Text(messages.message ?? "")),
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.only(left: 4.0, bottom: 4),
                    child: Text(controller.formatDate(messages.date).toString(),
                        style: const TextStyle(
                            color: Colors.black, fontSize: 9.0)),
                  ),
                  // messages.isUser==false? SizedBox(
                  //   width: 150,
                  // ):SizedBox()
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
