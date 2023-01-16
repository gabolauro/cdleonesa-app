import 'package:cd_leonesa_app/constants/themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';


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