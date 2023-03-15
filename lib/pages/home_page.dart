import 'package:carousel_slider/carousel_slider.dart';
import 'package:cd_leonesa_app/constants/themes.dart';
import 'package:cd_leonesa_app/pages/loading_page.dart';
import 'package:cd_leonesa_app/pages/team_page.dart';
import 'package:cd_leonesa_app/services/game_service.dart';
import 'package:cd_leonesa_app/services/news_service.dart';
import 'package:cd_leonesa_app/services/player_service.dart';
import 'package:cd_leonesa_app/services/preferences.dart';
import 'package:cd_leonesa_app/services/push_notifications_service.dart';
import 'package:cd_leonesa_app/services/store_service.dart';
import 'package:cd_leonesa_app/ui_components/century_slider.dart';
import 'package:cd_leonesa_app/ui_components/gradient_text.dart';
import 'package:cd_leonesa_app/ui_components/last_game.dart';
import 'package:cd_leonesa_app/ui_components/main_frame.dart';
import 'package:cd_leonesa_app/ui_components/new_slider.dart';
import 'package:cd_leonesa_app/ui_components/news_banner.dart';
import 'package:cd_leonesa_app/ui_components/next_game.dart';
import 'package:cd_leonesa_app/ui_components/partner_list.dart';
import 'package:cd_leonesa_app/ui_components/store_sale.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';



class HomePage extends StatelessWidget {

  int loadingProcess = 0;

  @override
  Widget build(BuildContext context) {

    final newsService = Provider.of<NewsService>(context);
    final storeService = Provider.of<StoreService>(context);
    final gameService = Provider.of<GameService>(context);
    final playerService = Provider.of<PlayerService>(context, listen: false);

    // print(newsService.headlines.length);
    // print(newsService.centuryNewsList.length);
    // print(storeService.saleList.length);
    // print(gameService.allGames.length);

    if (
      newsService.headlines.length == 0 ||
      newsService.centuryNewsList.length == 0 ||
      storeService.saleList.length == 0 ||
      gameService.allGames.length == 0
    ) {
      loadingProcess = loadingProcess+4;
      return LoadingPage(loadingProcess: loadingProcess,);
    }

    var data = PushNotificationService.initialPayload;
    if (data['forceRedirect']) {
      // return TeamPage();
      // PushNotificationService.initialPayload = {'forceRedirect':false};
      WidgetsBinding.instance.addPostFrameCallback((_){
        // Navigator.pushNamed(context, PushNotificationService.initialRoute);
        Navigator.popAndPushNamed(context, data['page'], arguments: int.parse(data['id']));
      });
    }

    GameService.section = 'Futbol';

    return MainFrame(
      body: SingleChildScrollView(
        child: Column(
          children: [
            NewsSlider(),

            gameService.getLastGame() !=null
              ? GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, 'calendar', arguments: 'Fútbol');
                },
                child: LastGame(
                  game: gameService.getLastGame()!,
                ),
              )
              :Container(),
            
            gameService.getNextGame() !=null
              ? NextGame(
                game: gameService.getNextGame()!,
              )
              :Container(),
        
            EventSlider(),
      
            StoreSale(),
      
            PartnerList(),
      
          ],
        ),
      ),
    );
  }
}
