import '../blocs/booking_detail_provider.dart';
import 'package:flutter/material.dart';
import '../styles.dart';

class TurfDetail extends StatelessWidget{
  Widget build(BuildContext context){
    return Text("Hello World!");
  }
}

class BookButton extends StatelessWidget {
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height / 12;
    final dateTimeBloc = DateTimeProvider.of(context);
    
    return GestureDetector(
      onTap: () {
        dateTimeBloc.getBookingDetails();
      },
      child: StreamBuilder(
        stream: dateTimeBloc.submitValid,
        builder: (context, snapshot) {
          return Container(
            padding: EdgeInsets.symmetric(horizontal: 25.0, vertical: 15.0),
            decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              //borderRadius: BorderRadius.all(Radius.circular(8.0)),
              border: BorderDirectional(
                top: BorderSide(width: 1.0, color: TurfColors.bgColor),
              ),
              color: snapshot.hasData ? TurfColors.red : TurfColors.bgColor,
            ),
            height: height,
            //color: Colors.white,
            child: Center(
              child: Text(
                "BOOK NOW",
                style: TextStyle(
                  fontSize: 22.0,
                  fontWeight: FontWeight.w500,
                  color: TurfColors.white,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class DateTimeCard extends StatelessWidget {
  final TextStyle header = TextStyle(
    fontWeight: FontWeight.w500,
    fontSize: 18.0,
    color: TurfColors.white,
  );

//Needs refactor
  DateTime selectedDate = DateTime.now();
  TimeOfDay initialTime = TimeOfDay.now();
  String s_electedDate = "";
  String selectedTime = "";
  Future<TimeOfDay> _selectTime(BuildContext context) async {
    final TimeOfDay picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay(hour: TimeOfDay.now().hour + 1, minute: 0),
    );
    initialTime = picked;
    selectedTime = picked.format(context);
    return picked;
  }

  Future<DateTime> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2016),
      lastDate: DateTime(2020),
    );
    selectedDate = picked;
    s_electedDate = picked.toString();
    return picked;
  }

//needs refactor
  final List<String> idToTimeRange = [
    "12:00 AM - 1:00 AM",
    "1:00 AM - 2:00 AM",
    "2:00 AM - 3:00 AM",
    "3:00 AM - 4:00 AM",
    "4:00 AM - 5:00 AM",
    "5:00 AM - 6:00 AM",
    "6:00 AM - 7:00 AM",
    "7:00 AM - 8:00 AM",
    "8:00 AM - 9:00 AM",
    "9:00 AM - 10:00 AM",
    "10:00 AM - 11:00 AM",
    "11:00 AM - 12:00 PM",
    "12:00 PM - 1:00 PM",
    "1:00 PM - 2:00 PM",
    "2:00 PM - 3:00 PM",
    "3:00 PM - 4:00 PM",
    "4:00 PM - 5:00 PM",
    "5:00 PM - 6:00 PM",
    "6:00 PM - 7:00 PM",
    "7:00 PM - 8:00 PM",
    "8:00 PM - 9:00 PM",
    "9:00 PM - 10:00 PM",
    "10:00 PM - 11:00 PM",
    "11:00 PM - 12:00 AM"
  ];

  Widget build(BuildContext context) {
    DateTimeBloc dateTimeBloc = DateTimeProvider.of(context);
    return Container(
      margin: EdgeInsets.symmetric(vertical: 5.0),
      //padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 10.0),
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        color: TurfColors.white,
      ),
      child: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(top: 20.0),
            child: buildDateText(context, dateTimeBloc),
          ),
          Divider(
            color: TurfColors.bgColor,
            height: 30.0,
          ),
          availability(context, dateTimeBloc),
          Divider(
            color: TurfColors.bgColor,
            height: 30.0,
          ),
          Padding(
            padding: EdgeInsets.only(left: 10.0, right: 10.0, bottom: 20.0),
            child: buildTimeText(context, dateTimeBloc),
          ),
        ],
      ),
    );
  }

  Widget buildDateText(BuildContext context, DateTimeBloc dateTimeBloc) {
    return GestureDetector(
      onTap: () {
        _selectDate(context).then((value) {
          if (selectedDate.day == DateTime.now().day &&
              selectedDate.month == DateTime.now().month) {
            dateTimeBloc.changeDate("Today");
          } else {
            var date = s_electedDate.split(" ")[0].split("-");
            dateTimeBloc.changeDate(date[2] + "-" + date[1] + "-" + date[0]);
          }
        });
      },
      child: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(bottom: 10.0),
            child: Text(
              "Date",
              //style: HeaderStyles.dateTimePicker,
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
            decoration: BoxDecoration(
              //borderRadius: BorderRadius.circular(25.0),
              boxShadow: [
                BoxShadow(
                  color: Colors.black54,
                  offset: Offset(1.0, 2.0),
                )
              ],
              shape: BoxShape.rectangle,
              color: Colors.blue,
            ),
            child: StreamBuilder(
              stream: dateTimeBloc.date,
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Text(
                    "Select",
                    //style: HeaderStyles.buttonText,
                  );
                }
                return Text(
                  snapshot.data,
                  //style: HeaderStyles.buttonText,
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget buildTimeText(BuildContext context, DateTimeBloc dateTimeBloc) {
    return Row(
      children: <Widget>[
        Expanded(
          child: GestureDetector(
            onTap: () {
              _selectTime(context).then((value) {
                dateTimeBloc.changeStartTime(selectedTime);
                dateTimeBloc.changeEndTime(initialTime
                    .replacing(hour: initialTime.hour + 1)
                    .format(context));
                dateTimeBloc.changeSlot(idToTimeRange.indexOf(selectedTime +
                    " - " +
                    initialTime
                        .replacing(hour: initialTime.hour + 1)
                        .format(context)));
              });
            },
            child: Column(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.only(bottom: 10.0),
                  child: Text(
                    "Start Time",
                    //style: HeaderStyles.dateTimePicker,
                  ),
                ),
                Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black54,
                        offset: Offset(1.0, 2.0),
                      )
                    ],
                    //borderRadius: BorderRadius.circular(25.0),
                    shape: BoxShape.rectangle,
                    color: TurfColors.blue,
                  ),
                  child: StreamBuilder(
                    stream: dateTimeBloc.startTime,
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        return Text(
                          "Select",
                          //style: HeaderStyles.buttonText,
                        );
                      }
                      return Text(
                        snapshot.data,
                        //style: HeaderStyles.buttonText,
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
        Spacer(),
        Expanded(
          child: GestureDetector(
            onTap: () {
              _selectTime(context).then((value) {
                dateTimeBloc.changeEndTime(selectedTime);
              });
            },
            child: Column(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.only(bottom: 10.0),
                  child: Text(
                    "End Time",
                    //style: HeaderStyles.dateTimePicker,
                  ),
                ),
                Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
                  decoration: BoxDecoration(
                    //borderRadius: BorderRadius.circular(25.0),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black54,
                        offset: Offset(1.0, 2.0),
                      )
                    ],
                    shape: BoxShape.rectangle,
                    color: TurfColors.blue,
                  ),
                  child: StreamBuilder(
                    stream: dateTimeBloc.endTime,
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        return Text(
                          "Select",
                          //style: HeaderStyles.buttonText,
                        );
                      }
                      return Text(
                        snapshot.data,
                        //style: HeaderStyles.buttonText,
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget availability(BuildContext context, DateTimeBloc dateTimeBloc) {
    Widget buildSlot(int id) {
      return GestureDetector(
        onTap: () {
          dateTimeBloc.changeSlot(id);
          dateTimeBloc.changeStartTime(idToTimeRange[id].split(" - ")[0]);
          dateTimeBloc.changeEndTime(idToTimeRange[id].split(" - ")[1]);
        },
        child: StreamBuilder(
          stream: dateTimeBloc.slot,
          builder: (context, snapshot) {
            return Stack(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                  margin: EdgeInsets.all(5.0),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: TurfColors.blue,
                      width: 2.0,
                    ),
                    color: snapshot.hasData
                        ? (snapshot.data == id
                            ? TurfColors.blue
                            : TurfColors.white)
                        : TurfColors.white,
                    borderRadius: BorderRadius.circular(25.0),
                    /*boxShadow: [
                      BoxShadow(
                        color: Colors.black54,
                        offset: Offset(0.5, 1.0),
                      )
                    ],*/
                    shape: BoxShape.rectangle,
                  ),
                  child: Center(
                    child: Row(
                      children: <Widget>[
                        Container(
                          //margin: EdgeInsets.only(top: 15, left: 15.0),
                          //padding: EdgeInsets.only(right: 20.0),
                          width: 18.0,
                          height: 18.0,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: snapshot.hasData?(snapshot.data == id)?TurfColors.white:TurfColors.blue:TurfColors.blue,
                          ),
                        ),
                        SizedBox(
                          width: 10.0,
                        ),
                        Text(
                          idToTimeRange[id],
                          style: TextStyle(
                            color: snapshot.hasData
                                ? (snapshot.data == id
                                    ? Colors.white
                                    : TurfColors.black)
                                : TurfColors.black,
                            fontSize: 14.0,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      );
    }

    List<Widget> slots = [];
    for (int i = 0; i < 24; i++) {
      slots.add(buildSlot(i));
    }
    return Column(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(bottom: 10.0),
          child: Text(
            "Available Slots",
            //style: HeaderStyles.dateTimePicker,
          ),
        ),
        SingleChildScrollView(
          padding: EdgeInsets.only(left: 5.0),
          scrollDirection: Axis.horizontal,
          child: Row(
            children: slots.sublist(0, 8),
          ),
        ),
        SingleChildScrollView(
          padding: EdgeInsets.only(left: 40.0),
          scrollDirection: Axis.horizontal,
          child: Row(
            children: slots.sublist(8, 16),
          ),
        ),
        SingleChildScrollView(
          padding: EdgeInsets.only(left: 5.0),
          scrollDirection: Axis.horizontal,
          child: Row(
            children: slots.sublist(16, 24),
          ),
        ),
      ],
    );
  }
}