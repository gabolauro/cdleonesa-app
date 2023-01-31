import 'package:carousel_slider/carousel_slider.dart';
import 'package:cd_leonesa_app/constants/themes.dart';
import 'package:cd_leonesa_app/pages/loading_page.dart';
import 'package:cd_leonesa_app/services/game_service.dart';
import 'package:cd_leonesa_app/services/news_service.dart';
import 'package:cd_leonesa_app/services/player_service.dart';
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
    final gameService = Provider.of<GameService>(context);
    final playerService = Provider.of<PlayerService>(context, listen: false);

    if (
      newsService.headlines.length == 0 ||
      newsService.centuryNewsList.length == 0 ||
      gameService.allGames.length == 0
    ) {
      loadingProcess = loadingProcess+3;
      return LoadingPage(loadingProcess: loadingProcess,);
    }

    return MainFrame(
      body: SingleChildScrollView(
        child: Column(
          children: [
            NewsSlider(),

            gameService.getLastGame() !=null
              ? LastGame(
                game: gameService.getLastGame()!,
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
