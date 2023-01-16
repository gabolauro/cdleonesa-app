import 'package:cd_leonesa_app/constants/themes.dart';
import 'package:cd_leonesa_app/ui_components/main_frame.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:syncfusion_localizations/syncfusion_localizations.dart';


class CalendarListPage extends StatefulWidget {

  @override
  State<CalendarListPage> createState() => _CalendarListPageState();
}

class _CalendarListPageState extends State<CalendarListPage> {
  String _month = '1';
  String _year = '';
  List<Map> listOfMonth = [
    { 'num': 1, 'name': 'ENE' },
    { 'num': 2, 'name': 'FEB' },
    { 'num': 3, 'name': 'MAR' },
    { 'num': 4, 'name': 'ABR' },
    { 'num': 5, 'name': 'MAY' },
    { 'num': 6, 'name': 'JUN' },
    { 'num': 7, 'name': 'JUL' },
    { 'num': 8, 'name': 'AGO' },
    { 'num': 9, 'name': 'SEP' },
    { 'num': 10, 'name': 'OCT' },
    { 'num': 11, 'name': 'NOV' },
    { 'num': 12, 'name': 'DIC' },
  ];

  @override
  void initState() {
    super.initState();
    
    _year = DateTime.now().year.toString();
  }

  List<Widget> _buildMonthList() {
    List<Widget> list = [];
    if (_month.isNotEmpty) {
      listOfMonth.forEach((month) {
        list.add(
          GestureDetector(
            onTap: (() {
              setState(() {
                _month = month['num'].toString();
              });
            }),
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 10),
              child: Text(
                month['name'],
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: num.parse(_month) == month['num']
                    ? FontWeight.w800
                    : FontWeight.w400,
                ),
              ),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: num.parse(_month) == month['num']
                      ? Colors.black87
                      : Colors.transparent,
                    width: 1.5
                  ),
                )
              ),
            ),
          ),
        );
      });
    }
    return list;
  }

  @override
  Widget build(BuildContext context) {
    return MainFrame(
      background: Colors.white,
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.all(20),
            child: Row(
              children: [
                Expanded(
                  child: RichText(
                    text: TextSpan(
                      text: 'Partidos temp.',
                      style: TextStyle(
                          fontSize: 22,
                          color: MainTheme.mainColor,
                          fontWeight: FontWeight.w400,
                          decoration: TextDecoration.none
                        ),
                      children: [
                          TextSpan(
                            text: ' ${_year!}',
                            style: TextStyle(
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
                MaterialButton(
                  onPressed: (() {
                    Navigator.pushNamed(context, 'calendar-list');
                  }),
                  minWidth: 0,
                  padding: EdgeInsets.all(0),
                  child: SvgPicture.asset(
                    'assets/images/list.svg',
                    color: MainTheme.mainColor,
                    height: 20,
                    allowDrawingOutsideViewBox: true,
                  ),
                ),
                MaterialButton(
                  minWidth: 0,
                  onPressed: (() {
                    Navigator.pushNamed(context, 'calendar-grid');
                  }),
                  padding: EdgeInsets.all(0),
                  child: SvgPicture.asset(
                    'assets/images/grid.svg',
                    color: MainTheme.mainColor,
                    height: 20,
                    allowDrawingOutsideViewBox: true,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      decoration: BoxDecoration(
                        color: Colors.black12,
                        borderRadius: BorderRadius.circular(5)
                      ),
                      child: Column(
                        children: [
                          ..._buildMonthList()
                        ],
                      ),
                    ),
                    SizedBox(width: 20,),
                    Expanded(
                      child: Column(
                        children: [
                          EventCard(),
                          EventCard(),
                          EventCard(),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          
          
        ],
      ),
   );
  }


}

class EventCard extends StatelessWidget {
  const EventCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(5),
        border: Border.all(color: Colors.black12, width: 4)
      ),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(15),
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: Colors.black12,
                  width: 4
                ),
              )
            ),
            child: ConstrainedBox(
              constraints: BoxConstraints(minWidth: double.infinity),
              child: Column(
                children: [
                  RichText(
                    text: TextSpan(
                      text: 'VIERNES',
                      style: TextStyle(
                          fontSize: 16,
                          color: Colors.black87,
                          fontWeight: FontWeight.w200,
                          decoration: TextDecoration.none
                        ),
                      children: [
                          TextSpan(
                            text: ' 06 ENE',
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                      ],
                    ),
                  ),
                  Text(
                    '17:00 H.',
                    style: TextStyle(
                        fontSize: 16,
                        color: Colors.black87,
                        fontWeight: FontWeight.w200,
                        decoration: TextDecoration.none
                      ),
                  )
                ],
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.all(15),
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: Colors.black12,
                  width: 4
                ),
              )
            ),
            child: ConstrainedBox(
              constraints: BoxConstraints(minWidth: double.infinity),
              child: Column(
                children: [
                  Text(
                    'JORNADA 18',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.black87,
                      fontWeight: FontWeight.w200,
                      decoration: TextDecoration.none,
                      letterSpacing: 3
                    ),
                  ),
                  ConstrainedBox(
                    constraints: BoxConstraints(minWidth: double.infinity, maxHeight: 80),
                    child: Row(
                      children: [
                        Expanded(
                          child: Container(
                            padding: EdgeInsets.all(5),
                            child: Image.asset('assets/images/logo_01.png'),
                          ),
                        ),
                        Text(
                          'VS',
                          style: TextStyle(
                            fontFamily: 'Roboto',
                            fontSize: 60,
                            fontWeight: FontWeight.w600,
                            color: Colors.black12,
                            letterSpacing: -5
                          ),
                        ),
                        Expanded(
                          child: Container(
                            padding: EdgeInsets.all(5),
                            child: Image.network(
                              'https://cydleonesa.com/wp-content/uploads/2023/01/adceuta-logo.png'
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Text(
                    'Cultural',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black87,
                      fontWeight: FontWeight.w600,
                      decoration: TextDecoration.none,
                    ),
                  ),
                  Text(
                    'Unionista',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black87,
                      fontWeight: FontWeight.w600,
                      decoration: TextDecoration.none,
                    ),
                  ),
                  Text(
                    'Estadio Reino de Leon',
                    style: TextStyle(
                      fontSize: 16,
                      color: MainTheme.mainColor,
                      fontWeight: FontWeight.w200,
                      decoration: TextDecoration.none,
                    ),
                  )
                ],
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: MainTheme.mainColor,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(2),
                bottomRight: Radius.circular(2)
              ),
            ),
            child: ConstrainedBox(
              constraints: BoxConstraints(minWidth: double.infinity),
              child: MaterialButton(
                onPressed: () {
                  
                },
                child: Center(
                  child: Text(
                    'COMPRAR ENTRADA',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

