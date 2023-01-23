import 'package:cd_leonesa_app/constants/themes.dart';
import 'package:cd_leonesa_app/models/game_model.dart';
import 'package:cd_leonesa_app/services/game_service.dart';
import 'package:cd_leonesa_app/ui_components/main_frame.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:syncfusion_localizations/syncfusion_localizations.dart';


class CalendarGridPage extends StatefulWidget {

  @override
  State<CalendarGridPage> createState() => _CalendarGridPageState();
}

class _CalendarGridPageState extends State<CalendarGridPage> {
  String _month = '';
  String _year = '';
  final CalendarController _calendarController= CalendarController();
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

  List<Widget> _buildMonthList() {
    List<Widget> list = [];
    if (_month.isNotEmpty) {
      listOfMonth.forEach((month) {
        list.add(
          Expanded(
            child: GestureDetector(
              onTap: (() {
                num.parse(_month!) < month['num']
                ? _calendarController.forward!()
                : num.parse(_month!) > month['num']
                ? _calendarController.backward!()
                : null;
              }),
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 10),
                child: Text(
                  month['name'],
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: num.parse(_month) == month['num']
                      ? FontWeight.w800
                      : FontWeight.w400,
                  ),
                ),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: Colors.black87,
                      width: num.parse(_month) == month['num']
                        ? 1.5
                        : 0.5,
                    ),
                  )
                ),
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

    final gameService = Provider.of<GameService>(context);

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
                            text: ' ${_year}',
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
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: [
                ..._buildMonthList()
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.all(20),
            color: Colors.black12,
            child: SfCalendar(
              controller: _calendarController,
              view: CalendarView.month,
              firstDayOfWeek: 1,
              headerHeight: 0,
              selectionDecoration: BoxDecoration(
                border: Border.all(color: Colors.black12, width: 3),
              ),
              monthCellBuilder:
                  (BuildContext buildContext, MonthCellDetails details) {
                if (details.appointments.isNotEmpty) {
                  Appointment appointment=details.appointments[0] as Appointment;
                  return Container(
                    decoration: BoxDecoration(
                      color: Color(0xFFefdbde),
                      border: Border.all(color: Colors.black12, width: 3)
                    ),
                    child: Stack(
                      children: [
                        Positioned(
                          top: 5,
                          right: 5,
                          child: Text(
                            details.date.day.toString(),
                            style: TextStyle(color: Colors.black87, fontSize: 8, fontWeight: FontWeight.w600),
                          ),
                        ),
                        Positioned(
                          top: 0,
                          right: 20,
                          bottom: 0,
                          left: 0,
                          child: Container(
                            child: 
                            appointment.notes != null
                              ? Image.network(
                                appointment.notes.toString()
                              )
                              : Icon(Icons.shield, size: 20, color: Colors.black26,),
                            
                          )
                        ),
                      ],
                    ),
                  );
                }
                return Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: Colors.black12, width: 3)),
                  child: Stack(
                    children: [
                      Positioned(
                        top: 5,
                        right: 5,
                        child: Text(
                          details.date.day.toString(),
                          style: TextStyle(color: Colors.black87, fontSize: 8, fontWeight: FontWeight.w600),
                        ),
                      ),
                    ],
                  ),
                );
              },
              onViewChanged: viewChanged,
              dataSource: _getCalendarDataSource(context, gameService.allGames),
              showDatePickerButton: true,
              monthViewSettings: MonthViewSettings(
                showTrailingAndLeadingDates: false,
                appointmentDisplayMode: MonthAppointmentDisplayMode.none,
                dayFormat: 'E'
              )),
          ),
        ],
      ),
   );
  }

  void viewChanged(ViewChangedDetails viewChangedDetails) {
    SchedulerBinding.instance.addPostFrameCallback((Duration duration) {
      setState(() {
        _month = DateFormat('M', 'es').format(viewChangedDetails
            .visibleDates[viewChangedDetails.visibleDates.length ~/ 2]).toString();
        _year = DateFormat('yyyy', 'es').format(viewChangedDetails
            .visibleDates[viewChangedDetails.visibleDates.length ~/ 2]).toString();
      });
    });
  }
}

_AppointmentDataSource _getCalendarDataSource(
  BuildContext context,
  List<Game> gameList
) {
  List<Appointment> appointments = <Appointment>[];
  gameList.forEach((game) {
    appointments.add(Appointment(
      startTime: game.fecha!,
      endTime: game.fecha!.add(Duration(minutes: 90)),
      subject: 'Cultural VS ${game.equipoContrario}',
      notes: game.resourceMedia,
      color: MainTheme.mainColor,
    ));
  });

  // appointments.add(Appointment(
  //   startTime: DateTime.parse('2023-01-21 16:15:00'),
  //   endTime: DateTime.parse('2023-01-07 16:15:00').add(Duration(minutes: 90)),
  //   subject: 'Meeting',
  //   notes: 'https://cydleonesa.com/wp-content/uploads/2023/01/adceuta-logo.png',
  //   color: Colors.green,
  //   startTimeZone: '',
  //   endTimeZone: '',
  // ));

  return _AppointmentDataSource(appointments);
}

class _AppointmentDataSource extends CalendarDataSource {
  _AppointmentDataSource(List<Appointment> source){
  appointments = source; 
  }
}