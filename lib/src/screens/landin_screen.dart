import 'package:flutter/material.dart';
import '../styles.dart';

class LandingPage extends StatelessWidget {
  Widget buildCircle(
      BuildContext context, double height, Widget child, String place) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 9.0),
      child: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(right: 10.0, bottom: 5.0),
            height: height * 0.78,
            width: height * 0.78,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white,
            ),
            child: child,
          ),
          Container(
            margin: EdgeInsets.only(right: 10.0),
            child: Text(
              place,
              style: TextStyle(
                color: Colors.white,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      )),
    );
  }

  Widget buildItemBox(String imgSrc) {
    return Container(
      margin: EdgeInsets.only(
        right: 10.0,
      ),
      child: Stack(
        children: <Widget>[
          Container(
            width: 180.0,
            height: 150.0,
            decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.all(
                Radius.circular(12.0),
              ),
              color: Colors.teal,
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.all(
                Radius.circular(12.0),
              ),
              child: Image.network(
                imgSrc,
                fit: BoxFit.cover,
                colorBlendMode: BlendMode.darken,
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(
              top: 120.0,
            ),
            width: 180.0,
            height: 30.0,
            decoration: BoxDecoration(
              color: TurfColors.blue,
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(12.0),
                bottomRight: Radius.circular(12.0),
              ),
            ),
            child: Center(
              child: Text(
                "Location",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildOfferCard(double width, Color color) {
    return Container(
      width: width,
      height: width * 0.57,
      margin: EdgeInsets.only(right: 5),
      decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.all(
            Radius.circular(12.0),
          ),
          color: color),
      child: Center(
        child: Text(
          "Offer Detail",
          style: TextStyle(
              fontWeight: FontWeight.w700, color: Colors.white, fontSize: 25.0),
        ),
      ),
    );
  }

  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height / 7;

    var circlesList = List<Widget>();
    circlesList.add(
      SizedBox(
        width: 10.0,
      ),
    );
    circlesList.add(
      buildCircle(
        context,
        height,
        Icon(
          Icons.my_location,
          size: 48,
          color: Colors.black,
        ),
        "Nearby",
      ),
    );
    for (int i = 0; i < 10; i++) {
      circlesList.add(
        buildCircle(
          context,
          height,
          Icon(
            Icons.security,
            size: 48.0,
            color: Colors.black,
          ),
          "Place $i",
        ),
      );
    }

    var itemList = List();
    itemList.add(
      SizedBox(
        width: 10.0,
      ),
    );
    final images = [
      "https://d1bvpoagx8hqbg.cloudfront.net/originals/27-best-football-stadiums-europe-b11d4697ae6b3413d719870dba44e1c8.jpg",
      "https://d1bvpoagx8hqbg.cloudfront.net/originals/27-best-football-stadiums-europe-27a61812bfbb0643b6cc72b31309d455.jpg",
      "https://www.grassrootscoaching.com/wp-content/uploads/2015/09/Old-Trafford.jpg",
      "https://www.stadiumguide.com/wp-content/gallery/anfield/anfield5.jpg",
    ];
    for (int i = 0; i < images.length; i++) {
      itemList.add(buildItemBox(images[i]));
    }

    var offerList = List();
    offerList.add(
      SizedBox(
        width: 10.0,
      ),
    );

    final colors = [
      Colors.yellow[700],
      TurfColors.blue,
      TurfColors.red,
    ];
    final width = MediaQuery.of(context).size.width;

    for (int i = 0; i < colors.length; i++) {
      offerList.add(buildOfferCard(0.8 * width, colors[i]));
    }

    return Scaffold(
      backgroundColor: TurfColors.bgColor,
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
              //backgroundColor: Color(0xff214489),
              title: Text(
                "goTurf",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w900,
                  fontSize: 22,
                ),
              ),
              expandedHeight:
                  (MediaQuery.of(context).size.height / 2) * (3 / 4),
              pinned: true,
              forceElevated: true,
              flexibleSpace: FlexibleSpaceBar(
                centerTitle: true,
                background: Image.network(
                  "https://www.makmax.com/dcms_media/image/news_wanda_2.jpg",
                  fit: BoxFit.cover,
                  colorBlendMode: BlendMode.darken,
                  filterQuality: FilterQuality.low,
                ),
              ),
            ),
          ];
        },
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 0.3,
              ),
              Container(
                margin: EdgeInsets.only(bottom: 5.0),
                height: MediaQuery.of(context).size.height / 5.8,
                color: Color(0xff214489),
                child: ListView.builder(
                  padding: EdgeInsets.all(0),
                  itemCount: circlesList.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return Center(
                      child: circlesList[index],
                    );
                  },
                ),
              ),
              Container(
//                  width: MediaQuery.of(context).size.width,
                height: 180,
                margin: EdgeInsets.only(bottom: 5.0),
                color: Colors.white,
                child: ListView.builder(
                  padding: EdgeInsets.only(
                    right: 5.0,
                  ),
                  itemCount: itemList.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return Center(
                      child: itemList[index],
                    );
                  },
                ),
              ),
              Container(
//                  width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.width * 0.50,
                color: Colors.white,
                child: ListView.builder(
                  padding: EdgeInsets.only(
                    right: 5.0,
                  ),
                  itemCount: offerList.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return Center(
                      child: offerList[index],
                    );
                  },
                ),
              ),
              Container(
                margin: EdgeInsets.only(
                  top: 5.0,
                  bottom: 5.0,
                ),
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.width * 0.57,
                color: Colors.white,
                child: Center(
                  child: LinearProgressIndicator(
                    backgroundColor: TurfColors.red,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
