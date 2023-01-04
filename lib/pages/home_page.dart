import 'package:carousel_slider/carousel_slider.dart';
import 'package:cd_leonesa_app/constants/themes.dart';
import 'package:cd_leonesa_app/ui_components/gradient_text.dart';
import 'package:cd_leonesa_app/ui_components/main_frame.dart';
import 'package:cd_leonesa_app/ui_components/news_banner.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';



class HomePage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MainFrame(
      body: SingleChildScrollView(
        child: Column(
          children: [
            NewsSlider(),
        
            LastGame(),
      
            NextGame(),
        
            EventSlider(),
      
            StoreSale(),
      
            PartnerList(),
      
          ],
        ),
      ),
    );
  }
}

class Partner {
  Partner(
    this.title,
    this.logos,
    [this.isExpanded = false]
  );
  String title;
  List<String> logos;
  bool isExpanded;
}

List<Partner> getPartners() {
  return [
    Partner('Deportivos', [
      'assets/images/sponsor_05.png'
    ]),
    Partner('Oficiales', [
      'assets/images/sponsor_01.png',
      'assets/images/sponsor_02.png',
      'assets/images/sponsor_03.png',
      'assets/images/sponsor_04.png',
    ]),
    Partner('Institucionales', []),
    Partner('Otras definiciones', []),
    Partner('Otras definiciones', []),
  ];
}

class PartnerList extends StatefulWidget {

  @override
  State<PartnerList> createState() => _PartnerListState();
}

class _PartnerListState extends State<PartnerList> {
  final List<Partner> _partners = getPartners();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xFF291B1A),
      child: Stack(
        children: [
          Positioned(
            top: -MediaQuery.of(context).size.width/4,
            left: -MediaQuery.of(context).size.width/4,
            height: MediaQuery.of(context).size.width *2,
            width: MediaQuery.of(context).size.width *2,
            child: Container(
              decoration: BoxDecoration(
                gradient: RadialGradient(
                  colors: [
                    MainTheme.mainColorDark.withOpacity(0.5),
                    Colors.transparent
                  ]
                ),
              )
            ),
          ),
          Column(
            children: [
              Container(
                padding: EdgeInsets.only(left: 20, top: 40),
                alignment: Alignment.centerLeft,
                child: Text(
                  'Patrocinadores',
                  style: TextStyle(
                    fontSize: 24,
                    color: Colors.white,
                    fontWeight: FontWeight.w300,
                    decoration: TextDecoration.none
                  ),
                ),
              ),

              ..._partners.map<ExpansionTile>((Partner partner) {
                return ExpansionTile(           
                  title: Container(
                    padding: EdgeInsets.only(left: 8, bottom: 10),
                    child: Text(
                        partner.title,
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          decoration: TextDecoration.none
                        ),
                    ),
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          color: MainTheme.mainColor,
                          width: 0.5,
                        ),
                      )
                    ),
                  ),
                  trailing:
                    partner.isExpanded
                    ? SvgPicture.asset(
                      'assets/images/chevron_down.svg',
                      color: MainTheme.mainColor,
                      height: 10,
                      allowDrawingOutsideViewBox: true,
                    )
                    : SvgPicture.asset(
                      'assets/images/chevron_right.svg',
                      color: MainTheme.mainColor,
                      height: 18,
                      allowDrawingOutsideViewBox: true,
                    ),
                  // Icon(
                  //   partner.isExpanded
                  //     ? Icons.chevron_left
                  //     : Icons.chevron_right,
                  //   color: MainTheme.mainColor,),
                  onExpansionChanged: (value) {
                    setState(() {
                      partner.isExpanded = value;
                    });
                  },

                  children: [
                      Container(
                        height: MediaQuery.of(context).size.width / 4,
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: GridView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                            maxCrossAxisExtent: (MediaQuery.of(context).size.width - 40) / 4,
                            childAspectRatio: 1 / 1,
                            crossAxisSpacing: 20,
                            mainAxisSpacing: 20
                          ),
                          itemCount: partner.logos.length,
                          itemBuilder:(context, index) {
                            return Container(
                              child: Image.asset(
                                partner.logos[index],
                                fit: BoxFit.contain,
                              ),
                            );
                          },),
                      )
                  ],
                );
                }).toList(),
              ]
          ),
        ],
      ),
    );
  }
}



class StoreSale extends StatelessWidget {
  const StoreSale({
    Key? key,
  }) : super(key: key);

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
                padding: EdgeInsets.only(top: 50, bottom: 20, left: 20),
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
                      onPressed: () {},
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

class EventSlider extends StatefulWidget {
  const EventSlider({
    Key? key,
  }) : super(key: key);

  @override
  State<EventSlider> createState() => _EventSliderState();
}

class _EventSliderState extends State<EventSlider> {

  int _current = 0;
  final CarouselController _controller = CarouselController();
  List<String> imgList = ['', '', ''];

  @override
  Widget build(BuildContext context) {
    return Container(
      color: MainTheme.mainColor,
      height: MediaQuery.of(context).size.width ,
      width: MediaQuery.of(context).size.width,
      child: Column(
        children: [
          Expanded(
            child: CarouselSlider(
              items: [
                Container(
                  width: MediaQuery.of(context).size.width * 0.9,
                  child: Image.asset(
                    'assets/images/event_01.png',
                    fit: BoxFit.contain,
                  )
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.9,
                  child: Image.asset(
                    'assets/images/event_01.png',
                    fit: BoxFit.contain,
                  )
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.9,
                  child: Image.asset(
                    'assets/images/event_01.png',
                    fit: BoxFit.contain,
                  )
                ),
              ],
              options: CarouselOptions(
                  height: MediaQuery.of(context).size.width ,
                  initialPage: 0,
                  enableInfiniteScroll: true,
                  reverse: false,
                  autoPlay: true,
                  autoPlayInterval: Duration(seconds: 3),
                  autoPlayAnimationDuration: Duration(milliseconds: 800),
                  autoPlayCurve: Curves.fastOutSlowIn,
                  viewportFraction: 1,
                  enlargeCenterPage: false,
                  scrollDirection: Axis.horizontal,
                  onPageChanged: (index, reason) {
                    setState(() {
                      _current = index;
                    });
                  }
                )
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: imgList.asMap().entries.map((entry) {
              return GestureDetector(
                onTap: () => _controller.animateToPage(entry.key),
                child: Container(
                  width: 12.0,
                  height: 12.0,
                  margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white.withOpacity(_current == entry.key ? 0.9 : 0.4)),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}

class NextGame extends StatelessWidget {
  const NextGame({
    Key? key,
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
                    Container(
                      child: Image.asset('assets/images/adversary_01.png', fit: BoxFit.contain,),
                      height: 80,
                      width: 80,
                    ),
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
                    Container(
                      child: Image.asset('assets/images/logo_01.png', fit: BoxFit.contain,),
                      height: 80,
                      width: 80,
                    ),
                    Spacer(),
                  ],
                ),
                Column(
                  children: [
                    Text(
                      'Sábado 15 enero. 22:00 h.',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.white,
                        fontWeight: FontWeight.w400,
                        decoration: TextDecoration.none
                      ),
                    ),
                    Text(
                      'Estadio de Riazor',
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
}

class LastGame extends StatelessWidget {
  const LastGame({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
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

class NewsSlider extends StatelessWidget {
  const NewsSlider({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      items: [
        NewsBanner(
          image: Image.asset(
            'assets/images/news_banner_01.png',
            fit: BoxFit.cover,
          ),
          title: 'Presentación del Reto Solidario',
        ),
      ],
      options: CarouselOptions(
          initialPage: 0,
          enableInfiniteScroll: true,
          reverse: false,
          autoPlay: true,
          autoPlayInterval: Duration(seconds: 3),
          autoPlayAnimationDuration: Duration(milliseconds: 800),
          autoPlayCurve: Curves.fastOutSlowIn,
          viewportFraction: 1.0,
          enlargeCenterPage: false,
          scrollDirection: Axis.horizontal,
      )
    );
  }
}
