import '../blocs/booking_detail_provider.dart';
import 'package:flutter/material.dart';
import 'package:swipedetector/swipedetector.dart';
import '../styles.dart';

class TurfDetail extends StatelessWidget {
  final widgets = [
    TitleCard(
      name: "Product Name",
      address: "Small Decription  ",
    ),
    DateTimeCard(),
    SizeSelector(),
    PriceCard(),
  ];

  final List<String> photos = [
    "https://e00-marca.uecdn.es/assets/multimedia/imagenes/2018/12/25/15457730278274.jpg",
    "http://outsideoftheboot.com/wp-content/uploads/2015/07/Jose-Gimenez-2015-Atletico.png",
    "https://e00-marca.uecdn.es/assets/multimedia/imagenes/2017/12/03/15122952947600.jpg",
    "http://as01.epimg.net/futbol/imagenes/2017/06/04/primera/1496570307_204106_1496570423_noticia_normal.jpg",
    "https://akm-img-a-in.tosshub.com/indiatoday/images/story/201805/Diego-Costa.png",
    "https://shakarasquare.com/wp-content/uploads/2017/07/Saul-Niguez.jpg",
    "https://cdn-s3.si.com/s3fs-public/styles/marquee_large_2x/public/2018/09/28/koke-atletico-madrid-spain.jpg"
  ];

  Widget build(BuildContext context) {
    //final double statusBarHeight = MediaQuery.of(context).padding.top;
    return Scaffold(
      primary: true,
      appBar: EmptyAppBar(),
      bottomNavigationBar: BookButton(),
      backgroundColor: Color(0xffcad8e4),
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          //print(innerBoxIsScrolled);
          return <Widget>[
            SliverAppBar(
              backgroundColor: TurfColors.red,
              leading: Icon(Icons.arrow_back),
              centerTitle: true,
              title: innerBoxIsScrolled ? Text("Product Name") : Text(" "),
              actions: <Widget>[
                Container(
                  padding: EdgeInsets.only(right: 10.0),
                  child: Icon(
                    Icons.favorite,
                    color: TurfColors.bgColor,
                  ),
                ),
              ],
              expandedHeight:
                  (MediaQuery.of(context).size.height / 2) * (3 / 4),
              pinned: true,
              forceElevated: true,
              flexibleSpace: FlexibleSpaceBar(
                centerTitle: true,
                background: imageContainer(),
              ),
            ),
          ];
        },
        body: Container(
          child: ListView.builder(
            padding: EdgeInsets.all(0.0),
            itemCount: widgets.length,
            itemBuilder: (context, int index) {
              return widgets[index];
            },
          ),
        ),
      ),
    );
  }

  Widget imageContainer() {
    return Container(
      height: 200.0,
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        color: TurfColors.red,
      ),
      child: ImageCarousel(
        photos: photos,
      ),
    );
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
              style: HeaderStyles.dateTimePicker,
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(9.0),
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
              stream: dateTimeBloc.date,
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Text(
                    "Select",
                    style: HeaderStyles.buttonText,
                  );
                }
                return Text(
                  snapshot.data,
                  style: HeaderStyles.buttonText,
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
                    style: HeaderStyles.dateTimePicker,
                  ),
                ),
                Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 17.0, vertical: 10.0),
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black54,
                        offset: Offset(1.0, 2.0),
                      )
                    ],
                    borderRadius: BorderRadius.circular(9.0),
                    shape: BoxShape.rectangle,
                    color: TurfColors.blue,
                  ),
                  child: StreamBuilder(
                    stream: dateTimeBloc.startTime,
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        return Text(
                          "Select",
                          style: HeaderStyles.buttonText,
                        );
                      }
                      return Text(
                        snapshot.data,
                        style: HeaderStyles.buttonText,
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
                    style: HeaderStyles.dateTimePicker,
                  ),
                ),
                Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 17.0, vertical: 10.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(9.0),
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
                          style: HeaderStyles.buttonText,
                        );
                      }
                      return Text(
                        snapshot.data,
                        style: HeaderStyles.buttonText,
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
                            color: snapshot.hasData
                                ? (snapshot.data == id)
                                    ? TurfColors.white
                                    : TurfColors.blue
                                : TurfColors.blue,
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
            style: HeaderStyles.dateTimePicker,
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

class ImageCarousel extends StatelessWidget {
  final photos;

  ImageCarousel({this.photos});

  Widget build(BuildContext context) {
    final bloc = DateTimeProvider.of(context);

    void _previousImage(DateTimeBloc bloc, int index) {
      index = (index - 1) % photos.length;
      bloc.changeImage(index);
    }

    void _nextImage(DateTimeBloc bloc, int index) {
      index = (index + 1) % photos.length;
      bloc.changeImage(index);
    }

    return StreamBuilder(
      stream: bloc.image,
      builder: (context, snapshot) {
        return Stack(
          children: <Widget>[
            SwipeDetector(
              onSwipeLeft: () {
                _nextImage(bloc, snapshot.hasData ? snapshot.data : 0);
              },
              onSwipeRight: () {
                _previousImage(bloc, snapshot.hasData ? snapshot.data : 0);
              },
              swipeConfiguration: SwipeConfiguration(
                  horizontalSwipeMinDisplacement: 10.0,
                  horizontalSwipeMinVelocity: 150.0,
                  horizontalSwipeMaxHeightThreshold: 50.0),
              child: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(
                        photos[snapshot.hasData ? snapshot.data : 0]),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            Positioned(
              top: 225.0,
              left: 25.0,
              right: 25.0,
              child: SelectedPhoto(
                numberOfDots: photos.length,
                photoIndex: snapshot.hasData ? snapshot.data : 0,
              ),
            ),
          ],
        );
      },
    );
  }
}

class SelectedPhoto extends StatelessWidget {
  final int numberOfDots;
  final int photoIndex;

  SelectedPhoto({this.numberOfDots, this.photoIndex});

  Widget _inactivePhoto() {
    return Container(
      child: Padding(
        padding: EdgeInsets.only(left: 2.0, right: 3.0),
        child: Container(
          height: 8.0,
          width: 8.0,
          decoration: BoxDecoration(
              color: Colors.grey, borderRadius: BorderRadius.circular(4.0)),
        ),
      ),
    );
  }

  Widget _activePhoto() {
    return Container(
      child: Padding(
        padding: EdgeInsets.only(left: 3.0, right: 3.0),
        child: Container(
          height: 10.0,
          width: 10.0,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(5.0),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey,
                  spreadRadius: 0.0,
                  blurRadius: 2.0,
                )
              ]),
        ),
      ),
    );
  }

  List<Widget> _buildDots() {
    List<Widget> dots = [];
    for (int i = 0; i < numberOfDots; ++i) {
      dots.add(i == photoIndex ? _activePhoto() : _inactivePhoto());
    }

    return dots;
  }

  Widget build(BuildContext context) {
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: _buildDots(),
      ),
    );
  }
}

class PriceCard extends StatelessWidget {
  Widget build(BuildContext context) {
    return Container(
      //height: 100,
      color: Colors.white,
      padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
      margin: EdgeInsets.only(bottom: 5.0),
      child: buildContent(),
    );
  }

  Widget buildContent() {
    return Row(
      children: <Widget>[
        Container(
          child: Text(
            "Amount Payable",
            style: TextStyle(
              fontSize: 15.0,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        Spacer(),
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            Container(
              child: Text(
                "₹5000",
                style: TextStyle(
                  fontSize: 25.0,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ],
        )
      ],
    );
  }
}

class SizeSelector extends StatelessWidget {
  Widget build(BuildContext context) {
    final dateTimeBloc = DateTimeProvider.of(context);
    return Container(
      margin: EdgeInsets.only(bottom: 5.0),
      padding: EdgeInsets.symmetric(vertical: 20.0),
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        color: Colors.white,
      ),
      child: buildRow(dateTimeBloc),
    );
  }

  Widget buildRow(DateTimeBloc dateTimeBloc) {
    dateTimeBloc.changSize("30");
    return Column(
      children: <Widget>[
        Container(
          padding: EdgeInsets.only(bottom: 10.0),
          child: Text(
            'Select Size',
            style: HeaderStyles.dateTimePicker,
          ),
        ),
        Row(
          children: <Widget>[
            Expanded(
              child: Column(
                children: <Widget>[
                  StreamBuilder(
                    stream: dateTimeBloc.size,
                    builder: (context, snapshot) {
                      return GestureDetector(
                        onTap: () {
                          dateTimeBloc.changSize("5x5");
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 15.0,
                            vertical: 8.0,
                          ),
                          decoration: BoxDecoration(
                            //borderRadius: BorderRadius.circular(25.0),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black54,
                                offset: Offset(1.0, 2.0),
                              )
                            ],
                            shape: BoxShape.rectangle,
                            color: snapshot.data == "5x5"
                                ? TurfColors.blue
                                : TurfColors.bgColor,
                          ),
                          child: Text(
                            "5x5",
                            style: HeaderStyles.buttonText,
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
            Expanded(
              child: Column(
                children: <Widget>[
                  StreamBuilder(
                    stream: dateTimeBloc.size,
                    builder: (context, snapshot) {
                      return GestureDetector(
                        onTap: () {
                          dateTimeBloc.changSize("7x7");
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 15.0,
                            vertical: 8.0,
                          ),
                          decoration: BoxDecoration(
                            //borderRadius: BorderRadius.circular(25.0),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black54,
                                offset: Offset(1.0, 2.0),
                              )
                            ],
                            shape: BoxShape.rectangle,
                            color: snapshot.data == "7x7"
                                ? TurfColors.blue
                                : TurfColors.bgColor,
                          ),
                          child: Text(
                            "7x7",
                            style: HeaderStyles.buttonText,
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        )
      ],
    );
  }
}

class TitleCard extends StatelessWidget {
  final String name;
  final String address;

  TitleCard({this.name, this.address});

  final TextStyle header = TextStyle(
    fontWeight: FontWeight.bold,
    fontSize: 20.0,
  );

  final TextStyle subtitle = TextStyle(
    color: Colors.grey,
    fontSize: 14.0,
  );

  final Color iconColor = Color(0xffcad8e4);

  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
      child: Column(
        children: <Widget>[
          buildNameRow(),
          Divider(
            color: Colors.grey,
            height: 25.0,
          ),
          buildFeaturesRow(),
        ],
      ),
    );
  }

  Widget buildNameRow() {
    return Row(
      children: <Widget>[
        /*Container(
          padding: EdgeInsets.all(20.0),
          child: Center(child: Text("Logo")),
          margin: EdgeInsets.only(right: 10.0),
          decoration: BoxDecoration(
            color: Color(0xffff4c5d),
          ),
        ),*/
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              name,
              textAlign: TextAlign.left,
              style: header,
            ),
            Text(
              address,
              textAlign: TextAlign.left,
              style: subtitle,
            ),
          ],
        ),
        Spacer(),
        Icon(
          Icons.location_on,
          size: 48.0,
          color: iconColor,
        ),
      ],
    );
  }

  Widget buildFeaturesRow() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          padding: EdgeInsets.only(right: 5.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Icon(
                Icons.add_a_photo,
                size: 32.0,
                color: iconColor,
              ),
              Text("Feature")
            ],
          ),
        ),
        Container(
          padding: EdgeInsets.only(right: 5.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Icon(
                Icons.add_a_photo,
                size: 32.0,
                color: iconColor,
              ),
              Text("Feature")
            ],
          ),
        ),
        Container(
          padding: EdgeInsets.only(right: 5.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Icon(
                Icons.add_a_photo,
                size: 32.0,
                color: iconColor,
              ),
              Text("Feature")
            ],
          ),
        ),
        Container(
          padding: EdgeInsets.only(right: 5.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Icon(
                Icons.add_a_photo,
                size: 32.0,
                color: iconColor,
              ),
              Text("Feature")
            ],
          ),
        ),
        Container(
          padding: EdgeInsets.only(right: 5.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Icon(
                Icons.add_a_photo,
                size: 32.0,
                color: iconColor,
              ),
              Text("Feature")
            ],
          ),
        ),
      ],
    );
  }
}

class EmptyAppBar extends StatelessWidget implements PreferredSizeWidget {
  Widget build(BuildContext context) {
    return Container();
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size(0.0, 0.0);
  Color get bacgroundColor => TurfColors.red;
}
