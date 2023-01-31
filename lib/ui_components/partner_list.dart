import 'dart:developer';

import 'package:cd_leonesa_app/constants/themes.dart';
import 'package:cd_leonesa_app/models/partners_model.dart';
import 'package:cd_leonesa_app/services/partenrs_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';


class PartnerGroup {
  PartnerGroup(
    this.title,
    this.partnerList,
    this.isExpanded
  );
  String title;
  List<Partner> partnerList;
  bool isExpanded = false;
}

// List<PartnerGroup> getPartnerGroups() {

//   return [
//     PartnerGroup('Deportivos', [
//       'assets/images/sponsor_05.png'
//     ],
//     true),
//     PartnerGroup('Oficiales', [
//       'assets/images/sponsor_01.png',
//       'assets/images/sponsor_02.png',
//       'assets/images/sponsor_03.png',
//       'assets/images/sponsor_04.png',
//     ],
//     true),
//     PartnerGroup('Institucionales', [], false),
//     PartnerGroup('Otras definiciones', [], false),
//     PartnerGroup('Otras definiciones', [], false),
//   ];
// }

class PartnerList extends StatefulWidget {

  @override
  State<PartnerList> createState() => _PartnerListState();
}

class _PartnerListState extends State<PartnerList> {

  List<PartnerGroup> _partnersGroup = [];

  @override
  Widget build(BuildContext context) {

    final partnerService = Provider.of<PartnerService>(context);

    // _partnersGroup = getPartnerGroups();

    List<PartnerGroup> getPartnerGroups() {
      List<PartnerGroup> list = [];
      Partner.categories.forEach((key, value) {
        PartnerGroup _partnerGroup = new PartnerGroup(
          value['name'],
          partnerService.allPartners.where((i) => (i.category == value['name'])).toList(),
          value['isExpanded']
        );
        list.add(_partnerGroup);
      });

      return list;
    }

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
                padding: EdgeInsets.only(left: 20, top: 60),
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

              ...getPartnerGroups().map<ExpansionTile>((PartnerGroup partnerGroup) {
                return ExpansionTile(           
                  title: Container(
                    padding: EdgeInsets.only(left: 8, bottom: 10),
                    child: Text(
                        partnerGroup.title,
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.white,
                          fontWeight: FontWeight.w400,
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
                    partnerGroup.isExpanded
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
                  initiallyExpanded: partnerGroup.isExpanded,
                  onExpansionChanged: (value) {
                    setState(() {
                      partnerGroup.isExpanded = value;
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
                          itemCount: partnerGroup.partnerList.length,
                          itemBuilder:(context, index) {
                            return Container(
                              child: Image.network(
                                partnerGroup.partnerList[index].resourceMedia
                                ?? MainTheme.noPhoto,
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