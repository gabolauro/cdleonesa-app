import 'package:flutter/material.dart';


class LastGame extends StatelessWidget {
  final Color background;
  const LastGame({
    Key? key,
    this.background = Colors.white,
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
                children: [
                  Row(
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
                      Text('3', style: TextStyle(fontWeight: FontWeight.w600),),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Container(
                        child: Image.asset('assets/images/adversary_02.png', fit: BoxFit.contain,),
                        height: 30,
                        width: 30,
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: Text('Unionistas', style: TextStyle(fontWeight: FontWeight.w300),),
                        )
                      ),
                      Text('1', style: TextStyle(fontWeight: FontWeight.w300),),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Container(
            color: Colors.black87,
            height: 40,
            width: 1,
            margin: EdgeInsets.all(10),
          ),
          Container(
            margin: EdgeInsets.all(10),
            child: Column(
              children: [
                Text('Fin', style: TextStyle(fontWeight: FontWeight.w600),),
                Text('6/11', style: TextStyle(fontWeight: FontWeight.w300),)
              ],
            ),
          ),
        ],
      ),
    );
  }
}