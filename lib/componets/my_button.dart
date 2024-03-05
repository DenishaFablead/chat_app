import 'package:flutter/material.dart';

class My_button extends StatelessWidget {
  const My_button({super.key, required this.onTap, required this.text});
  final VoidCallback onTap;
  final String text;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
            color: Colors.black, borderRadius: BorderRadius.circular(16)),
        child: Center(
          child: Text("${text}",
              style:
                  TextStyle(fontWeight: FontWeight.bold, fontSize: 20,color: Colors.white)),
        ),
      ),
    );
  }
}
