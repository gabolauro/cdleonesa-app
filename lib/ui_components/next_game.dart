import 'dart:developer';

import 'package:cd_leonesa_app/constants/themes.dart';
import 'package:cd_leonesa_app/models/game_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NextGame extends StatelessWidget {
  final Game game;
  const NextGame({
    Key? key,
    required this.game,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Container(
      color: MainTheme.mainColor,
      margin: EdgeInsets.symmetric(vertical: 20),
      height: 250,
      child: Stack(
        children: [
          Positioned(
            top: 50,
            left: -MediaQuery.of(context).size.width * 0.2,
            child: ClipOval(
              child: Container(
                height: MediaQuery.of(context).size.width,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topRight,
                    end: Alignment.bottomLeft,
                    stops: [
                      0,
                      0.4
                    ],
                    colors: [
                      Color(0x66000000),
                      Colors.transparent
                    ]
                  )
                ),
              ),
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                RichText(
                  text: const TextSpan(
                    text: 'Próximo',
                    style: TextStyle(
                        fontSize: 24,
                        color: Colors.white,
                        fontWeight: FontWeight.w400,
                        decoration: TextDecoration.none
                      ),
                    children: [
                        TextSpan(
                          text: 'partido',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                    ],
                  ),
                ),
                Row(
                  children: [
                    Spacer(),
                    game.local!
                      ? _theTeam()
                      : _otherTeam(),
                    Text(
                      'VS',
                      style: TextStyle(
                        fontFamily: 'Roboto',
                        fontSize: 80,
                        fontWeight: FontWeight.w600,
                        decoration: TextDecoration.none,
                        color: MainTheme.mainColor,
                        letterSpacing: -5
                      ),
                    ),
                    game.local!
                      ? _otherTeam()
                      : _theTeam(),
                    Spacer(),
                  ],
                ),
                Column(
                  children: [
                    Text(
                      DateFormat('EEEE dd MMMM HH:mm', 'es').format(game.fecha!),
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.white,
                        fontWeight: FontWeight.w400,
                        decoration: TextDecoration.none
                      ),
                    ),
                    Text(
                      game.lugarDelParido!,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        decoration: TextDecoration.none
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 10),
                      color: Colors.white,
                      width: 60,
                      height: 1,
                    )
                  ],
                )
              ],
            ),
          )
        ],
      )
    );
  }

  Container _otherTeam() {
    return Container(
      child: 
      game.resourceMedia != null
        ? Image.network(
          game.resourceMedia ?? '',
          fit: BoxFit.contain,)
        : Icon(Icons.shield, size: 30, color: Colors.black26,),
      height: 80,
      width: 80,
    );
  }

  Container _theTeam() {
    return Container(
      child: Image.asset('assets/images/logo_01.png', fit: BoxFit.contain,),
      height: 80,
      width: 80,
    );
  }
}