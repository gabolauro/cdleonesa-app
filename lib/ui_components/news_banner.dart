import 'package:flutter/material.dart';

class NewsBanner extends StatelessWidget {

  final int id;
  final Image image;
  final String title;

  const NewsBanner({
    Key? key, required this.image, required this.title, required this.id,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, 'single_news', arguments: this.id);
      },
      child: Stack(
        children: [
          Container(
            width: double.infinity,
            child: this.image
          ),
          Positioned(
            top: 0,
            bottom: 0,
            right: 0,
            left: 0,
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  stops: [
                    0.5,
                    0.8
                  ],
                  colors: [
                    Colors.transparent,
                    Color(0xCC000000)
                  ]
                )
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: 
            Container(
              child: Align(
                widthFactor: 10,
                alignment: Alignment.centerLeft,
                child: Container(
                  margin: EdgeInsets.only(bottom: 30,left: 30, right: 5),
                  child: 
                  Text(
                    this.title,
                    maxLines: 9,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w800,
                      color: Colors.white
                    ),
                  ),
                ),
              ),
            )
          )
        ],
      ),
    );
  }
}