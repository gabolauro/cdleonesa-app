import 'package:cd_leonesa_app/ui_components/main_frame.dart';
import 'package:cd_leonesa_app/ui_components/news_banner.dart';
import 'package:flutter/material.dart';


class CenturyPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MainFrame(
      background: Colors.black87,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(30),
              height: 150,
              width: double.infinity,
              alignment: Alignment.center,
              child: Image.asset('assets/images/centenario_logo.png')
            ),
            
            ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: 3,
              itemBuilder:(context, index) {
                return Container(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: NewsBanner(
                    id: 0,
                    image: Image.asset('assets/images/news_banner_05.png'),
                    title: 'Presentación del Reto Solidario'
                  ),
                );
              },
            )
          ],
        ),
      )
   );
  }
}