import 'package:flutter/material.dart';

class DynamicTextFieldSafe extends StatefulWidget {
  final TextEditingController controller;
  const DynamicTextFieldSafe({super.key, required this.controller});

  @override
  State<DynamicTextFieldSafe> createState() => _DynamicTextFieldSafeState();
}

class _DynamicTextFieldSafeState extends State<DynamicTextFieldSafe> {
  @override
  Widget build(BuildContext context) {
    final maxHeight = MediaQuery.of(context).size.height * 0.15;

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(
            top: 20,
            left: 10,
            right: 10,
            bottom: 2,
          ),
          child: ConstrainedBox(
            constraints: BoxConstraints(maxHeight: maxHeight),
            child: Scrollbar(
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                reverse: true,
                child: TextField(
                  controller: widget.controller,
                  minLines: 1,
                  style: TextStyle(
                    color: Colors.white, // Change this to your desired color
                    fontSize: 16,
                  ),
                  maxLines: null,
                  keyboardType: TextInputType.multiline,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
