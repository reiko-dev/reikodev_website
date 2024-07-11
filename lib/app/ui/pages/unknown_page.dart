import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';
import 'package:reikodev_website/app/ui/pages/page_template.dart';
import 'package:reikodev_website/app/ui/utils/extensions.dart';

class UnknownPage extends StatelessWidget {
  const UnknownPage({super.key, this.state});

  final GoRouterState? state;

  @override
  Widget build(BuildContext context) {
    final size = M.size(context);

    return PageTemplate(
      child: Center(
        child: SizedBox(
          height: size.height * .8,
          width: size.width * .7,
          child: const Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Spacer(flex: 3),
              Expanded(
                flex: 6,
                child: Error404Widget(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Error404Widget extends StatelessWidget {
  const Error404Widget({super.key});

  @override
  Widget build(BuildContext context) {
    return Lottie.asset(
      'assets/lottie/error_404.json',
      reverse: false,
      repeat: false,
    );
  }
}
