import 'package:cd_leonesa_app/constants/themes.dart';
import 'package:cd_leonesa_app/models/news_model.dart';
import 'package:cd_leonesa_app/services/news_service.dart';
import 'package:cd_leonesa_app/ui_components/main_frame.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:styled_text/styled_text.dart';


class SingleNewsPage extends StatelessWidget {

//   final String newsText = '''Este jueves ha sido presentado un nuevo acto organizado por la Cultural y Deportiva Leonesa dentro de su centenario. Se trata de un evento deportivo de carácter benéfico que tendrá lugar el próximo 27 de diciembre en el Palacio de los Deportes de León, a las 18:30 horas, y que contará con la presencia de jugadores de equipos de los principales clubes de fútbol, balonmano y baloncesto de la ciudad de León.
// Se pretende que sea, además, un acto de hermandad entre los clubes y sus aficiones. Los equipos que estarán presentes serán la Cultural y Deportiva Leonesa de fútbol masculino y femenino, el Ademar y el Cleba de balonmano y el Baloncesto Femenino León y la Cultural y Deportiva Leonesa de baloncesto.
// Estos equipos se enfrentarán entre sí, con el aliciente de que lo harán en los deportes que no son los suyos, por lo que se podrá ver a los futbolistas jugando a baloncesto y a balonmano, y viceversa. Además, los equipos estarán reforzados por personas conocidas y relevantes de la sociedad leonesa.
// El precio de las entradas será de 2 euros y todo lo recaudado irá destinado a la “Asociación Down-León Amidown”, cuyo fin y objetivo es la integración social de las personas con síndrome de Down. Además, los chicos y chicas de la asociación también se integrarán dentro del diferentes equipos.
// En el descanso de los partidos, se realizarán sorteos de regalos para todos los niños asistentes al partido, que además podrán fotografiarse o retarse con sus ídolos. El evento será retransmitido por La 8 León.
// Al acto de presentación han acudido Goyo Chamorro, presidente del Comité Organizador del Centenario de la Cultural, Álvaro Pola y Lourdes González, concejales de Ayuntamiento de León, María del Carme Pardo, presidenta de Amidown y Juan Francisco Martín, director de La 8 León, que han estado acompañados por representantes de todos los clubes presentes en el evento.
// Las entradas se podrán a la venta en la Tienda Oficial de la Cultural, así como en la tienda de Carrefour Express en la calle Ancha.''';

  @override
  Widget build(BuildContext context) {

    final newsServide = Provider.of<NewsService>(context);
    final id = ModalRoute.of(context)!.settings.arguments as int;
    News article = newsServide.getSingleHeadline(id);
    String newsText = article.content ?? '';
    List<String> paragraphs = newsText.split('\n');

    return MainFrame(
      background: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(30),
              width: double.infinity,
              child: Text(
                article.title ?? '',
                maxLines: 9,
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w800,
                  color: Colors.black87
                ),
              ),
            ),
            Container(
              width: double.infinity,
              child: Image.network(
                article.resourceMedia ?? MainTheme.noPhoto,
                fit: BoxFit.cover,
              )
            ),
            Container(
              padding: EdgeInsets.all(20),
              child: ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: paragraphs.length,
                itemBuilder:(_, i) {
                  return Container(
                    padding: EdgeInsets.only(bottom: 20),
                    child:
                    StyledText(
                      text: paragraphs[i],
                      textAlign: TextAlign.justify,
                      style: TextStyle(
                        fontSize: 14,
                        height: 2,
                        fontWeight: i == 0
                          ? FontWeight.w600
                          : FontWeight.w400,
                        color: Colors.black87
                      ),
                      tags: {
                        'strong': StyledTextTag(
                            style: TextStyle(fontWeight: FontWeight.w600)),
                      },
                    ),
                    // Text(
                    //   paragraphs[i],
                    //   textAlign: TextAlign.justify,
                    //   style: TextStyle(
                    //     fontSize: 14,
                    //     height: 2,
                    //     fontWeight: i == 0
                    //       ? FontWeight.w600
                    //       : FontWeight.w400,
                    //     color: Colors.black87
                    //   ),
                    // ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
   );
  }
}