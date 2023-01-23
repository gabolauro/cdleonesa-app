import 'package:cd_leonesa_app/constants/themes.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class StoreSale extends StatelessWidget {
  const StoreSale({
    Key? key,
  }) : super(key: key);

  Future<void> _launchUrl(Uri url) async {
    if (!await launchUrl(url)) {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      // color: MainTheme.mainColorDark,
      margin: EdgeInsets.only(top: 30),
      height: MediaQuery.of(context).size.width * 0.7,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        // gradient: LinearGradient(
        //   begin: Alignment.topLeft,
        //   end: Alignment.bottomRight,
        //   colors: [
        //     MainTheme.mainColorDark,
        //     Colors.black
        //   ]
        // ),
        // color: MainTheme.mainColorDark,
        color: Color(0xFF291B1A)
      ),
      child: Stack(
        children: [
          Positioned(
            bottom: 10,
            left: -MediaQuery.of(context).size.width ,
            right: -10,
            child: ClipOval(
              child: Container(
                height: 200,
                color: MainTheme.mainColor,
              ),
            ),
          ),
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            bottom: 110,
            child: Container(
              color: MainTheme.mainColor,
            ),
          ),

          Row(
            children: [
              Container(
                padding: EdgeInsets.only(top: 10, bottom: 50, left: 20),
                // width: MediaQuery.of(context).size.width,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    RichText(
                      text: const TextSpan(
                        text: 'Promo',
                        style: TextStyle(
                            fontSize: 24,
                            color: Colors.white,
                            fontWeight: FontWeight.w300,
                            decoration: TextDecoration.none
                          ),
                        children: [
                            TextSpan(
                              text: 'tienda',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                        ],
                      ),
                    ),
                    Text(
                      'Primera equipación',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        decoration: TextDecoration.none
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 10),
                      width: 60,
                      height: 1,
                      color: Colors.white,
                    ),
                    Text(
                      'Mujer',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.white,
                        fontWeight: FontWeight.w400,
                        decoration: TextDecoration.none
                      ),
                    ),
                    Spacer(),
                    Text(
                      '\$40,50€',
                      style: TextStyle(
                        fontSize: 32,
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        decoration: TextDecoration.none
                      ),
                    ),
                    Spacer(),
                    MaterialButton(
                      onPressed: () {
                        Uri _url = Uri.parse('https://shop.cydleonesa.com/es/');
                        _launchUrl(_url);
                      },
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.zero,
                        side: BorderSide(color: Colors.white, width: 1)
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Text(
                          'COMPRAR',
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                            fontWeight: FontWeight.w400,
                            decoration: TextDecoration.none
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),

              Expanded(
                child: Align(
                  alignment: Alignment.centerRight,
                  child: Image.asset(
                    'assets/images/product_01.png',
                    fit: BoxFit.contain,
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}