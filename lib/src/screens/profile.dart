import 'package:flutter/material.dart';
import '../styles.dart';

class ProfileScreen extends StatelessWidget {
  
  Widget build(BuildContext context) {
    return Scaffold(
        body: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              SliverAppBar(
                backgroundColor: TurfColors.red,
                title: Text("Profile"),
                expandedHeight: MediaQuery.of(context).size.height*0.5,
                pinned: true,
                flexibleSpace: FlexibleSpaceBar(
                  centerTitle: true,
                  background: ProfileCard(
                    fullName: 'Samfan',
                    phoneNo: '+91-8129127294',
                  ),
                ),

                /*flexibleSpace: FlexibleSpaceBar(
                  centerTitle: true,
                  title: Text("Collapsing Toolbar",
                  style:TextStyle(
                    color: Colors.white,
                    fontSize: 16.0
                  )),
                  background: Image.network(
                    "https://images.pexels.com/photos/396547/pexels-photo-396547.jpeg?auto=compress&cs=tinysrgb&h=350",
                    fit: BoxFit.cover,
                  ),
                ),*/
              ),
            ];
          },
          body: ListView(
            padding: EdgeInsets.all(0),
            children: <Widget>[
              OptionList(),
            ],
          ),
        ),
      );
  }
}

class ProfileCard extends StatelessWidget {
  final String fullName;
  final String phoneNo;

  ProfileCard({this.fullName, this.phoneNo});

  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[card(context)],
    );
  }

  Widget card(BuildContext context) {
    final height =(MediaQuery.of(context).size.height/2)*0.9;
    return Container(
      padding: EdgeInsets.all(40),
      child: Stack(
        children: <Widget>[
          colorBox(TurfColors.red,height),
          SizedBox(height: 10.0),
          profilePic(context),
          nameNnumber(),
        ],
      ),
    );
  }

  Widget colorBox(Color color, double height) {
    return Container(
      height: height,
      decoration: BoxDecoration(
          color: TurfColors.red,
          shape: BoxShape.rectangle,
          /*boxShadow: <BoxShadow>[
            BoxShadow(
              blurRadius: 2.0,
              offset: Offset(0.0, 10.0),
            )
          ]*/),
    );
  }

  Widget profilePic(BuildContext context) {
    //double width = MediaQuery.of(context).size.width / 2 - 64.0;
    return Container(
      alignment: Alignment.center,
      child: Icon(
        Icons.account_circle,
        size: 124.0,
        color: TurfColors.blue,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
      ),
    );
  }

  Widget nameNnumber() {
    Text name = Text(
      fullName,
      textAlign: TextAlign.center,
      style: TextStyle(
        color: Colors.white,
        fontSize: 21.0,
        fontWeight: FontWeight.w400,
      ),
    );

    Text number = Text(
      phoneNo,
      textAlign: TextAlign.center,
      style: TextStyle(
        color: Colors.white,
        fontSize: 15.0,
        fontWeight: FontWeight.w400,
      ),
    );
    return Container(
      //color: TurfColors.white,
      alignment: Alignment.center,
      margin: EdgeInsets.only(
        top: 155.0,
      ),
      child: Column(
        children: <Widget>[
          name,
          SizedBox(
            height: 1.0,
          ),
          number
        ],
      ),
    );
  }
}

class OptionList extends StatelessWidget {
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        SizedBox(
          height: 15.0,
        ),
        buildTile(context, "Contact Details", Icons.smartphone),
        buildTile(context, "Booking History", Icons.history),
        buildTile(context, "Send Feedback", Icons.feedback),
        buildTile(context, "Invite", Icons.supervisor_account),
        buildTile(
            context, "Notification Preferences", Icons.notification_important),
        SizedBox(
          height: 15.0,
        ),
      ],
    );
  }

  Widget buildTile(BuildContext context, String title, IconData icon) {
    return Column(
      children: <Widget>[
        ListTile(
          title: Text(title),
          leading: Icon(icon),
          trailing: Icon(Icons.navigate_next),
        ),
        Divider(
          height: 6.0,
        ),
      ],
    );
  }
}
