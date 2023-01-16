import 'package:cd_leonesa_app/ui_components/main_frame.dart';
import 'package:cd_leonesa_app/ui_components/partner_list.dart';
import 'package:flutter/material.dart';


class PartnersPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MainFrame(
      body: PartnerList()
   );
  }
}