import 'package:flutter/material.dart';

class contain1 extends StatelessWidget {
  const contain1({
    super.key,
    required this.TextButton,
  });
  final String TextButton;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(color: Theme.of(context).primaryColor),
      child: Center(
        child: Text(
          TextButton,
          style: const TextStyle(
              color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}

class padding1 extends StatelessWidget {
  const padding1({
    super.key,
    required TextEditingController textController,
    required this.hintText,
    required this.obscureText,
  }) : _textController = textController;

  final TextEditingController _textController;
  final String hintText;
  final bool obscureText;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: Colors.white),
      ),
      child: TextField(
        obscureText: obscureText,
        controller: _textController,
        decoration:
            InputDecoration(border: InputBorder.none, hintText: hintText),
      ),
    );
  }
}

class Applogo extends StatelessWidget {
  const Applogo({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Icon(Icons.audiotrack, size: 100, color: Colors.deepPurple[300]);
  }
}

class CustomSpinner extends StatelessWidget {
  const CustomSpinner({
    super.key,
    required this.size,
  });

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: size.height,
      width: size.width,
      color: Colors.deepPurple.withOpacity(0.5),
      child: const Center(
        child: Image(
          width: 50,
          image: AssetImage('loading.gif'),
        ),
      ),
    );
  }
}
