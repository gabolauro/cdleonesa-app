import 'package:cd_leonesa_app/ui_components/gradient_text.dart';
import 'package:flutter/material.dart';


class LoadingPage extends StatefulWidget {

  @override
  State<LoadingPage> createState() => _LoadingPageState();
}

class _LoadingPageState extends State<LoadingPage> with TickerProviderStateMixin {

  bool startAnimation = false;
  late AnimationController controller;

  void initState() {
    
    controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 5),
    )..addListener(() {
        setState(() {});
      });
    controller.repeat(reverse: false, max: 1);

    WidgetsBinding.instance
        .addPostFrameCallback((_) {
          setState(() {
            startAnimation = true;
          });
        });

    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    WidgetsBinding.instance
        .addPostFrameCallback((_) {
          if (controller.value > 0.9) {
            // controller.dispose();
            Navigator.pushNamed(context, 'home');
          }
        });

    return Stack(
      alignment: AlignmentDirectional.center,
      children: [
        Container(
          height: double.infinity,
          width: double.infinity,
          decoration: BoxDecoration(
              gradient:  RadialGradient(
                radius: 0.9,
                colors: [
                  Color(0xFF910E1E),
                  Color(0xFFD00713),
                ],
              )
          )
        ),
        AnimatedPositioned(
          duration: Duration(seconds: 10),
          left: !startAnimation ? -50 : 50,
          curve: Curves.easeOut,
          top: MediaQuery.of(context).size.height * 0.4,
          child: const GradientText(
            '1923',
            style: TextStyle(
              fontFamily: 'Roboto',
              fontSize: 150,
              fontWeight: FontWeight.w800,
              color: Color(0xFFD00713),
              decoration: TextDecoration.none
            ),
            gradient: RadialGradient(
              radius: 5,
              colors: [
                Color(0xFFD00713),
                Color(0xFF910E1E),
              ],
            ),
          )
        ),
        AnimatedPositioned(
          duration: Duration(seconds: 10),
          left: !startAnimation ? 50 : 0,
          curve: Curves.easeOut,
          top: MediaQuery.of(context).size.height * 0.55,
          child: const GradientText(
            'C&DL',
            style: TextStyle(
              fontFamily: 'Roboto',
              fontSize: 150,
              fontWeight: FontWeight.w800,
              color: Color(0xFFD00713),
              decoration: TextDecoration.none
            ),
            gradient: RadialGradient(
              radius: 5,
              colors: [
                Color(0xFFD00713),
                Color(0xFF910E1E),
              ],
            ),
          )
        ),
        AnimatedPositioned(
          duration: Duration(seconds: 10),
          left: !startAnimation ? -20 : 20,
          curve: Curves.easeOut,
          top: MediaQuery.of(context).size.height * 0.7,
          child: const GradientText(
            'APP',
            style: TextStyle(
              fontFamily: 'Roboto',
              fontSize: 150,
              fontWeight: FontWeight.w800,
              decoration: TextDecoration.none
            ),
            gradient: RadialGradient(
              radius: 5,
              colors: [
                Color(0xFFD00713),
                Color(0xFF910E1E),
              ],
            ),
          ),
        ),
        Container(
          height: double.infinity,
          width: double.infinity,
          decoration: BoxDecoration(
              gradient:  RadialGradient(
                radius: 0.9,
                colors: [
                  Color(0x88330E1E),
                  Color(0x0000),
                ],
              )
          )
        ),
        Positioned(
          top: MediaQuery.of(context).size.height * 0.25,
          child: Container(
            height: 350,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Image.asset(
                  'assets/images/logo_01.png',
                  height: 200,
                ),
                RichText(
                  text: const TextSpan(
                    text: 'CULTURAL',
                    style: TextStyle(
                        fontFamily: 'Montserrat',
                        fontSize: 18,
                        color: Colors.white,
                        fontWeight: FontWeight.w800,
                        decoration: TextDecoration.none
                      ),
                    children: [
                        TextSpan(
                          text: ' Y ',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        TextSpan(
                          text: 'DEPORTIVA LEONESA',
                        ),
                    ],
                  ),
                ),
                const Text(
                  '1923',
                  style: TextStyle(
                    fontFamily: 'Montserrat',
                    fontSize: 18,
                    color: Colors.white,
                    fontWeight: FontWeight.w400,
                    decoration: TextDecoration.none
                  ),
                ),
              ],
            ),
          ),
        ),
        Positioned(
          bottom: 50,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(5),
            child: Container(
              width: MediaQuery.of(context).size.width -160,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
              ),
              child: LinearProgressIndicator(
                backgroundColor: Colors.white,
                color: Color(0xFF910E1E),
                minHeight: 8,
                value: controller.value,
              ),
            ),
          ),
        )
      ],
    );
  }
}