import 'package:chat_bot/freezed/person_model.dart';
import 'package:flutter/material.dart';

class FreezedDemoView extends StatefulWidget {
  const FreezedDemoView({super.key});

  @override
  State<FreezedDemoView> createState() => _FreezedDemoViewState();
}

class _FreezedDemoViewState extends State<FreezedDemoView> {
  var controller = TextEditingController();
  var model = PersonModel(name: null);
  List pList = [];
  var list = [
    {
      'id': 0,
      'name': null,
    },
    {'id': null, 'name': 'Paras'},
    {'id': 2, 'name': 'Rajat'},
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    for (int i = 0; i < list.length; i++) {
      setState(() {
        pList.add(PersonModel.fromJson(list[i]));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Freezed Demo View')),
      body: Column(
        children: [
          DynamicTextFormField(
            labelText: 'Enter your name',
            initialValue: 'John Doe', // Initial value
            controller: controller,
          ),
          Center(
            child: HoverButton(
              onPressed: () {
                print('Button tapped!');
              },
              child: Text(
                'Hover Button',
                style: TextStyle(fontSize: 18),
              ),
            ),
          ),
        ],
      ),

      /*ListView.builder(
        itemCount: pList.length,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(pList[index].name),
            leading: Text(pList[index].id.toString()),
          );
        },
      ),*/
    );
  }
}

class DynamicTextFormField extends StatelessWidget {
  final String labelText;
  final String initialValue;
  final TextEditingController controller;

  DynamicTextFormField({
    required this.labelText,
    required this.initialValue,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: labelText,
        border: OutlineInputBorder(),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter some text';
        }
        return null;
      },
    );
  }
}

class HoverButton extends StatefulWidget {
  final VoidCallback onPressed;
  final Widget child;
  final Color hoverColor;

  HoverButton({
    required this.onPressed,
    required this.child,
    this.hoverColor = Colors.grey,
  });

  @override
  _HoverButtonState createState() => _HoverButtonState();
}

class _HoverButtonState extends State<HoverButton> {
  bool _isHovering = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovering = true),
      onExit: (_) => setState(() => _isHovering = false),
      child: InkWell(
        onTap: widget.onPressed,
        child: Container(
          decoration: BoxDecoration(
            color: _isHovering ? widget.hoverColor : Colors.transparent,
            borderRadius: BorderRadius.circular(8.0),
            border: Border.all(color: Colors.grey),
          ),
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          child: widget.child,
        ),
      ),
    );
  }
}
