import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MainTheme {
  static const Color mainColor = Color(0xFFD00713);
  static const Color mainColorLight = Color.fromARGB(255, 254, 90, 101);
  static const Color mainColorDark = Color(0xFF910E1E);
  static const Color softGrey = Color(0xFFF5F5F5);
  static const Color darkGrey = Color.fromARGB(255, 95, 95, 95);
  static const String noPhoto = 'http://www.tea-tron.com/antorodriguez/blog/wp-content/uploads/2016/04/image-not-found-4a963b95bf081c3ea02923dceaeb3f8085e1a654fc54840aac61a57a60903fef.png';
  static const String apiBaseUrl = 'https://cydleonesa.com/wp-json/wp/v2';

  // Main Theme
  static Map<int, Color> _colors = {
    50: mainColor,
    100: mainColor,
    200: mainColor,
    300: mainColor,
    400: mainColor,
    500: mainColor,
    600: mainColor,
    700: mainColor,
  };

  static MaterialColor materialColorCustom = MaterialColor(mainColor.value, _colors);

  static ThemeData theme() {
    return ThemeData(
        primarySwatch: materialColorCustom,
        primaryColor: mainColor,
        primaryColorDark: mainColor,
        // primaryColorLight: Color(mainColorLight),
        scaffoldBackgroundColor: mainColor,
        appBarTheme: const AppBarTheme(
          elevation: 0,
          backgroundColor: softGrey,
          systemOverlayStyle: SystemUiOverlayStyle(
            systemNavigationBarColor: Colors.white,
            statusBarColor: softGrey,
            statusBarIconBrightness: Brightness.dark,
            statusBarBrightness: Brightness.dark,
          )
        ),
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          backgroundColor: Colors.transparent
        ),
        fontFamily: 'Roboto',
        iconTheme: const IconThemeData(color: Color(0xff434300)),
        );
  }

  static SnackBar message(context, {required Map<String, dynamic> data, void Function()? action}) =>
    SnackBar(
      duration: Duration(seconds: 15),
      backgroundColor: Color(0xFFFFFFFF),
      content: GestureDetector(
        onTap: action,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 100,
              alignment: Alignment.center,
              child: Container(
                width: 50,
                height: 50,
                child: SvgPicture.asset(
                  'assets/images/logo_01.svg',
                  color: mainColor,
                  height: 50,
                  allowDrawingOutsideViewBox: true,
                ),
              ),
            ),
            Expanded(
              child: Container(
                height: 100,
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      data['title'],
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w400,
                        color: mainColor
                      ),
                    ),
                    Text(
                      data['body'],
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w300,
                        color: mainColor
                      ),
                    ),
                  ],
                ),
              )
            )
          ],
        ),
      ),
      behavior: SnackBarBehavior.floating,
    );


}