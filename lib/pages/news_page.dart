import 'package:cd_leonesa_app/constants/themes.dart';
import 'package:cd_leonesa_app/ui_components/main_frame.dart';
import 'package:cd_leonesa_app/ui_components/news_banner.dart';
import 'package:flutter/material.dart';


class NewsPage extends StatelessWidget {

  final PageController controller = PageController();

  @override
  Widget build(BuildContext context) {
    return MainFrame(
      background: Colors.white,
      body: Column(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.symmetric(vertical: 0),
            margin: EdgeInsets.symmetric(horizontal: 20),
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: Colors.black87,
                  width: 0.5,
                ),
              )
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                TextButton(
                  onPressed:() {
                    controller.animateToPage(0, duration: Duration(milliseconds: 500), curve: Curves.easeOut);
                  },
                  child: Text('Futbol')),
                TextButton(
                  onPressed:() {
                    controller.animateToPage(1, duration: Duration(milliseconds: 500), curve: Curves.easeOut);
                  },
                  child: Text('Futbol Femenino')),
                TextButton(
                  onPressed:() {
                    controller.animateToPage(2, duration: Duration(milliseconds: 500), curve: Curves.easeOut);
                  },
                  child: Text('Baloncesto')),
              ],
            ),
          ),

          SizedBox(height: 10,),

          Expanded(
            child: PageView(
              controller: controller,
              children: [
                ListView.builder(
                  shrinkWrap: true,
                  itemCount: 4,
                  itemBuilder:(_, i) {
                    return Container(
                      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      child: NewsBanner(
                        image: Image.asset(
                          'assets/images/news_banner_01.png',
                          fit: BoxFit.cover,
                        ),
                        title: 'Presentación del Reto Solidario',
                      ),
                    );
                  },
                ),
                ListView.builder(
                  shrinkWrap: true,
                  itemCount: 4,
                  itemBuilder:(_, i) {
                    return Container(
                      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      child: NewsBanner(
                        image: Image.asset(
                          'assets/images/news_banner_01.png',
                          fit: BoxFit.cover,
                        ),
                        title: 'Presentación del Reto Solidario',
                      ),
                    );
                  },
                ),
                ListView.builder(
                  shrinkWrap: true,
                  itemCount: 4,
                  itemBuilder:(_, i) {
                    return Container(
                      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      child: NewsBanner(
                        image: Image.asset(
                          'assets/images/news_banner_01.png',
                          fit: BoxFit.cover,
                        ),
                        title: 'Presentación del Reto Solidario',
                      ),
                    );
                  },
                ),

              ],
            ),
          ),


        ],
      ),
   );
  }
}