import 'package:flutter/material.dart';
import '../styles.dart';

class LandingPage extends StatelessWidget {
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: TurfColors.bgColor,
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
              //backgroundColor: Color(0xff214489),
              title: Text(
                "TITLE",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w900,
                  fontSize: 20,
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
        body: Center(
          child: Text(
            "Hello World!",
          ),
        ),
      ),
    );
  }
}
