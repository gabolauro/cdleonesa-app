import 'dart:developer';

import 'package:cd_leonesa_app/models/game_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';


class LastGame extends StatelessWidget {
  final Color background;
  final Game game;
  const LastGame({
    Key? key,
    this.background = Colors.white,
    required this.game,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Container(
      color: this.background,
      padding: EdgeInsets.all(10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Expanded(
            child: Container(
              margin: EdgeInsets.all(10),
              child: Column(
                children: 
                game.local!
                ? [ theTeam(), otherTeam(), ]
                : [ otherTeam(), theTeam(), ],
              ),
            ),
          ),
          Container(
            color: Colors.black45,
            height: 70,
            width: 0.5,
            margin: EdgeInsets.all(10),
          ),
          Container(
            margin: EdgeInsets.all(10),
            child: Column(
              children: [
                Text('Fin', style: TextStyle(fontWeight: FontWeight.w600),),
                Text(
                  DateFormat('D/M', 'es').format(game.fecha!),
                  style: TextStyle(fontWeight: FontWeight.w300),)
              ],
            ),
          ),
        ],
      ),
    );
  }

  Row otherTeam() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Container(
          child: 
          game.resourceMedia != null
            ? Image.network(
              game.resourceMedia ?? '',
              fit: BoxFit.contain,)
            : Icon(Icons.shield, size: 30, color: Colors.black26,),
          height: 30,
          width: 30,
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Text(game.equipoContrario ?? '', style: TextStyle(fontWeight: FontWeight.w300),),
          )
        ),
        Text(
          game.resultado!.length == 2
            ? !game.local!
              ? game.resultado![0]
              : game.resultado![1]
            : '-'
          , style: TextStyle(fontWeight: FontWeight.w300),),
      ],
    );
  }

  Row theTeam() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Container(
          child: Image.asset('assets/images/logo_01.png', fit: BoxFit.contain,),
          height: 30,
          width: 30,
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Text('Cultural Leonesa', style: TextStyle(fontWeight: FontWeight.w600),),
          )
        ),
        Text(
          game.resultado!.length == 2
            ? game.local!
              ? game.resultado![0]
              : game.resultado![1]
            : '-'
          , style: TextStyle(fontWeight: FontWeight.w600),),
      ],
    );
  }
}