import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:reikodev_website/app/controller/projects_controller.dart';
import 'package:reikodev_website/app/data/repository/projects_repository_impl.dart';
import 'package:reikodev_website/app/routes/app_router.dart';
import 'package:reikodev_website/app/ui/pages/background/background_page.dart';
import 'package:reikodev_website/app/ui/theme.dart';
import 'package:reikodev_website/app/ui/utils/menu_controller.dart';
import 'package:reikodev_website/app/ui/utils/scroll_data_controller.dart';
import 'package:visibility_detector/visibility_detector.dart';

void main() {
  runApp(const MyApp());
}

final isDarkThemeNotifier = ValueNotifier<bool>(true);

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final a = Get.put(MenuController());
  final c = Get.put(ScrollDataController());

  final hc = Get.lazyPut(
    () => ProjectsController(ProjectsRepositoryWebImpl()),
  );

  void updateUiBars() {
    SystemChrome.setEnabledSystemUIMode(
      SystemUiMode.manual,
      overlays: [SystemUiOverlay.bottom],
    );
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        systemNavigationBarColor: Colors.transparent, // status bar color
      ),
    );
  }

  @override
  void initState() {
    VisibilityDetectorController.instance.updateInterval =
        const Duration(milliseconds: 35);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    updateUiBars();

    return ValueListenableBuilder<bool>(
        valueListenable: isDarkThemeNotifier,
        builder: (context, isDarkTheme, _) {
          return MaterialApp.router(
            debugShowCheckedModeBanner: false,
            routeInformationParser: router.routeInformationParser,
            routerDelegate: router.routerDelegate,
            theme: isDarkTheme ? darkTheme : lightTheme,
            localizationsDelegates: const [
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            builder: (context, child) => BGAnimator(
              child: Scaffold(
                backgroundColor: Colors.black,
                body: child!,
              ),
            ),
            supportedLocales: const [
              Locale('en', 'Us'),
              Locale('pt', ''),
            ],
          );
        });
  }
}

// class Test extends StatelessWidget {
//   const Test({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final size = MediaQuery.of(context).size;

//     return Scaffold(
//       body: SizedBox(
//         width: size.width * .9,
//         height: size.height * .9,
//         child: Center(
//           child: AspectRatio(
//             aspectRatio: 3 / 2,
//             child: LayoutBuilder(builder: (context, bc) {
//               print(bc);
//               return Image.asset(
//                 'assets/images/experiences/3.0x/ufac.jpg',
//                 filterQuality: FilterQuality.medium,
//               );
//             }),
//           ),
//         ),
//       ),
//     );
//   }
// }
