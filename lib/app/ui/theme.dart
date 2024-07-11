import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

final darkTheme = ThemeData(
  hoverColor: const Color.fromARGB(255, 255, 255, 255),
  buttonTheme: const ButtonThemeData(
    highlightColor: Colors.white,
    buttonColor: Colors.white,
  ),
  iconTheme: const IconThemeData(color: Color.fromARGB(255, 148, 147, 147)),
  dividerTheme: const DividerThemeData(
    color: Color.fromARGB(255, 238, 236, 236),
    space: 25,
    thickness: .3,
    endIndent: 3.5,
    indent: 3.5,
  ),
  textButtonTheme: TextButtonThemeData(
    style: TextButton.styleFrom(
      shadowColor: Colors.black87,
      backgroundColor: Colors.white,
    ),
  ),
  textTheme: selectedTextTheme,
  disabledColor: Colors.white.withOpacity(.3),
  extensions: const [
    ShadeStyle(
      primary: Color(0xFF202020),
      primaryLight: Color(0xFF8F8F8F),
      primaryMedium: Color(0xFF2c2c2c),
      secondary: Color(0xFFE89E4A),
      secondaryMedium: Color(0xFFD98C40),
      secondaryDark: Color(0xFFBD6629),
    ),
  ],
  colorScheme: ColorScheme.fromSwatch(
    primarySwatch: Colors.orange,
    errorColor: const Color(0xFFff2929),
    backgroundColor: Colors.white,
  )
      .copyWith(
        primary: Colors.orange,
        surface: const Color(0xFF151515),
      )
      .copyWith(error: const Color(0xFFff2929)),
);

final lightTheme = ThemeData(
    hoverColor: const Color(0xFF151515),
    buttonTheme: const ButtonThemeData(
      highlightColor: Colors.black,
      buttonColor: Colors.white,
    ),
    iconTheme: const IconThemeData(color: Color(0xFF0e1318)),
    dividerTheme: const DividerThemeData(
      color: Color.fromARGB(255, 238, 236, 236),
      space: 25,
      thickness: .3,
      endIndent: 3.5,
      indent: 3.5,
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        shadowColor: Colors.white70,
        backgroundColor: Colors.black,
      ),
    ),
    textTheme: selectedTextTheme,
    disabledColor: Colors.black.withOpacity(.3),
    extensions: const [
      ShadeStyle(
        primary: Color(0xFF202020),
        primaryLight: Color(0xFF8F8F8F),
        primaryMedium: Color(0xFF2c2c2c),
        secondary: Color(0xFFE89E4A),
        secondaryMedium: Color(0xFFD98C40),
        secondaryDark: Color(0xFFBD6629),
      ),
    ],
    colorScheme: ColorScheme.fromSwatch(
      primarySwatch: Colors.orange,
      errorColor: const Color(0xFFff2929),
      backgroundColor: Colors.black,
    )
        .copyWith(
          primary: Colors.orange,
          surface: const Color.fromARGB(255, 243, 243, 243),
        )
        .copyWith(error: const Color(0xFFff2929)));

class ShadeStyle extends ThemeExtension<ShadeStyle> {
  const ShadeStyle({
    required this.primary,
    required this.primaryLight,
    required this.primaryMedium,
    required this.secondary,
    required this.secondaryMedium,
    required this.secondaryDark,
  });

  final Color primary;
  final Color primaryLight;
  final Color primaryMedium;
  final Color secondary;
  final Color secondaryMedium;
  final Color secondaryDark;

  @override
  ShadeStyle copyWith({
    Color? primary,
    Color? primaryLight,
    Color? primaryMedium,
    Color? secondary,
    Color? secondaryMedium,
    Color? secondaryDark,
  }) {
    return ShadeStyle(
      primary: primary ?? this.primary,
      primaryMedium: primaryMedium ?? this.primaryMedium,
      secondary: secondary ?? this.secondary,
      secondaryMedium: secondaryMedium ?? this.secondaryMedium,
      secondaryDark: secondaryDark ?? this.secondaryDark,
      primaryLight: primaryLight ?? this.primaryLight,
    );
  }

  @override
  ThemeExtension<ShadeStyle> lerp(ThemeExtension<ShadeStyle>? other, double t) {
    if (other is! ShadeStyle) return this;

    return ShadeStyle(
      primary: Color.lerp(primary, other.primary, t) ?? primary,
      primaryLight:
          Color.lerp(primaryLight, other.primaryLight, t) ?? primaryLight,
      primaryMedium:
          Color.lerp(primaryMedium, other.primaryMedium, t) ?? primaryMedium,
      secondary: Color.lerp(secondary, other.secondary, t) ?? secondary,
      secondaryMedium: Color.lerp(secondaryMedium, other.secondaryMedium, t) ??
          secondaryMedium,
      secondaryDark:
          Color.lerp(secondaryDark, other.secondaryDark, t) ?? secondaryDark,
    );
  }
}

final selectedTextTheme = latoTextTheme;

final robotoTextTheme = TextTheme(
  displayLarge:
      GoogleFonts.roboto(color: const Color(0xFFFAFAFA), fontSize: 40),
  displayMedium:
      GoogleFonts.roboto(color: const Color(0xFFFAFAFA), fontSize: 30),
  displaySmall:
      GoogleFonts.roboto(color: const Color(0xFFFAFAFA), fontSize: 20),
  headlineMedium:
      GoogleFonts.roboto(color: const Color(0xFFFAFAFA), fontSize: 16),
  headlineSmall:
      GoogleFonts.roboto(color: const Color(0xFFFAFAFA), fontSize: 14),
  titleLarge: GoogleFonts.roboto(color: const Color(0xFFFAFAFA), fontSize: 12),
  titleMedium: GoogleFonts.roboto(color: const Color(0xFF9a9a9a), fontSize: 16),
  labelLarge:
      GoogleFonts.roboto(color: Colors.black, fontWeight: FontWeight.w700),
);

final playfairTextTheme = TextTheme(
  displayLarge:
      GoogleFonts.playfairDisplay(color: const Color(0xFFFAFAFA), fontSize: 40),
  displayMedium:
      GoogleFonts.playfairDisplay(color: const Color(0xFFFAFAFA), fontSize: 30),
  displaySmall:
      GoogleFonts.playfairDisplay(color: const Color(0xFFFAFAFA), fontSize: 20),
  headlineMedium:
      GoogleFonts.playfairDisplay(color: const Color(0xFFFAFAFA), fontSize: 16),
  headlineSmall:
      GoogleFonts.playfairDisplay(color: const Color(0xFFFAFAFA), fontSize: 14),
  titleLarge:
      GoogleFonts.playfairDisplay(color: const Color(0xFFFAFAFA), fontSize: 12),
  titleMedium:
      GoogleFonts.playfairDisplay(color: const Color(0xFF9a9a9a), fontSize: 16),
  labelLarge: GoogleFonts.playfairDisplay(
      color: Colors.black, fontWeight: FontWeight.w700),
);

final latoTextTheme = TextTheme(
  displayLarge: GoogleFonts.lato(color: const Color(0xFFFAFAFA), fontSize: 40),
  displayMedium: GoogleFonts.lato(color: const Color(0xFFFAFAFA), fontSize: 30),
  displaySmall: GoogleFonts.lato(color: const Color(0xFFFAFAFA), fontSize: 20),
  headlineMedium:
      GoogleFonts.lato(color: const Color(0xFFFAFAFA), fontSize: 16),
  headlineSmall: GoogleFonts.lato(color: const Color(0xFFFAFAFA), fontSize: 14),
  titleLarge: GoogleFonts.lato(color: const Color(0xFFFAFAFA), fontSize: 12),
  titleMedium: GoogleFonts.lato(color: const Color(0xFF9a9a9a), fontSize: 16),
  labelLarge:
      GoogleFonts.lato(color: Colors.black, fontWeight: FontWeight.w700),
);
