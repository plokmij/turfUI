import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class LocationCard extends StatelessWidget {
  final String location;
  final Color color;

  LocationCard({this.location, this.color});

  Widget build(BuildContext context) {
    return card();
  }

  Widget card() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 5.0),
      child: Stack(
        children: <Widget>[colorBox()],
      ),
    );
  }

  Widget colorBox() {
    return Container(
      height: 80.0,
      width: 120.0,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(8.0),
        shape: BoxShape.rectangle,
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: color,
            blurRadius: 1.0,
            offset: (Offset(0.0, 2.0)),
          ),
        ],
      ),
      child: Center(child: locationName()),
    );
  }

  final textStyle = TextStyle(
    fontSize: 18.0,
    fontWeight: FontWeight.w400,
    color: Colors.white,
  );

  Widget locationName() {
    Text locationName = Text(
      location,
      style: textStyle,
    );

    return locationName;
  }
}

class ItemSearchTile extends StatelessWidget {
  final String name;
  final Color color;

  ItemSearchTile({this.name, this.color});

  Widget build(BuildContext context) {
    return tile();
  }

  Widget tile() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 5.0),
      child: Stack(
        children: <Widget>[
          colorBox(color),
        ],
      ),
    );
  }

  Widget colorBox(Color color) {
    return Container(
      height: 100.0,
      width: 140.0,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.circular(8.0),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Colors.black38,
            blurRadius: 2.0,
            offset: (Offset(0.0, 2.0)),
          ),
        ],
      ),
    );
  }
}

class SearchScreen extends StatelessWidget {
  Widget build(BuildContext context) {
    //print(MediaQuery.of(context).size);
    List<Widget> items = [
      CupertinoNavigationBar(
        leading: Icon(
          Icons.arrow_back,
          color: Colors.black,
        ),
        middle: CupertinoTextField(
          placeholder: 'Search',
          decoration: BoxDecoration(
              color: Colors.white10,
              border: Border.all(
                width: 1.0,
                color: Colors.grey,
              )),
        ),
        trailing: Icon(
          Icons.remove_red_eye,
          color: Colors.black,
        ),
      ),
      buildList(),
      SizedBox(
        height: 20,
      ),
      buildSearchTile(),
      buildSearchTile(),
      buildSearchTile(),
      buildSearchTile(),
    ];
    return CupertinoPageScaffold(
      resizeToAvoidBottomInset: false,
      /*navigationBar: CupertinoNavigationBar(
          leading: Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
          middle: CupertinoTextField(
            placeholder: 'Search',
            decoration: BoxDecoration(
                color: Colors.white10,
                border: Border.all(
                  width: 1.0,
                  color: Colors.grey,
                )),
          ),
          trailing: Icon(
            Icons.remove_red_eye,
            color: Colors.black,
          ),
        ),*/
      child: Container(
        child: ListView.builder(
          itemCount: items.length,
          padding: EdgeInsets.all(0),
          itemBuilder: (BuildContext context, int index) {
            return items[index];
          },
        ),
      ),
    );
  }

  Widget buildBody(BuildContext context) {
    List<Widget> items = [
      SizedBox(
        height: 20,
      ),
      buildSearchTile(),
      buildSearchTile(),
      buildSearchTile(),
      buildSearchTile(),
    ];
    return Container(
        /*decoration: BoxDecoration(
        border: Border(top: BorderSide(color: Colors.red, width: 10.0)),
      ),*/
        //alignment: Alignment.topCenter,
        height: 140.0 * items.length,
        child: ListView.builder(
          padding: EdgeInsets.all(0),
          itemCount: items.length,
          scrollDirection: Axis.vertical,
          itemBuilder: (context, index) {
            return items[index];
          },
        )

        /*ListView(
        padding: EdgeInsets.only(top: 17.5),
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        children: <Widget>[
          Column(
            children: <Widget>[],
          ),
        ],
      ),*/
        );
  }

  Widget buildList() {
    return Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: Colors.black26,
              blurRadius: 3.0,
              offset: (Offset(0.0, 3.0)),
            ),
          ],
        ),
        height: 100.0,
        //margin: EdgeInsets.only(top: 48.0),
        padding: EdgeInsets.only(top: 5.0, bottom: 5.0),
        child: ListView(
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          children: <Widget>[
            Row(
              children: <Widget>[
                SizedBox(
                  width: 10.0,
                ),
                LocationCard(
                  location: "Location 1",
                  color: Colors.grey,
                ),
                LocationCard(
                  location: "Location 2",
                  color: Colors.grey,
                ),
                LocationCard(
                  location: "Location 3",
                  color: Colors.grey,
                ),
                LocationCard(
                  location: "Location 4",
                  color: Colors.grey,
                )
              ],
            )
          ],
        ));
  }

  Widget buildSearchTile() {
    return Column(
      children: <Widget>[
        Container(
          padding: EdgeInsets.only(left: 10.0),
          child: Text(
            'Centres in Location 1',
            style: TextStyle(
              fontSize: 15.0,
              fontWeight: FontWeight.w700,
            ),
          ),
          alignment: Alignment.topLeft,
        ),
        Container(
          alignment: Alignment.topCenter,
          height: 120.0,
          //margin: EdgeInsets.only(left: 10.0),
          padding: EdgeInsets.only(top: 5.0, bottom: 5.0),
          child: ListView(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            children: <Widget>[
              Row(
                children: <Widget>[
                  SizedBox(
                    width: 5.0,
                  ),
                  ItemSearchTile(color: Colors.grey),
                  ItemSearchTile(color: Colors.grey),
                  ItemSearchTile(color: Colors.grey),
                  ItemSearchTile(color: Colors.grey),
                  ItemSearchTile(color: Colors.grey),
                  ItemSearchTile(color: Colors.grey),
                  ItemSearchTile(color: Colors.grey),
                  ItemSearchTile(color: Colors.grey),
                  ItemSearchTile(color: Colors.grey),
                  ItemSearchTile(color: Colors.grey),
                  ItemSearchTile(color: Colors.grey),
                  ItemSearchTile(color: Colors.grey),
                ],
              ),
            ],
          ),
        ),
        SizedBox(
          height: 10.0,
        ),
      ],
    );
  }
}
