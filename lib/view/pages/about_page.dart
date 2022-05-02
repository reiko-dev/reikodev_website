import 'package:flutter/material.dart';

class AboutPage extends StatefulWidget {
  static const routeName = "/about";

  const AboutPage({Key? key}) : super(key: key);

  @override
  State<AboutPage> createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: const Color(0xFF0d0d0d),
      body: SizedBox.fromSize(
        size: size,
        child: const Center(
          child: Text("ABOUT"),
        ),
      ),
    );
  }
}
