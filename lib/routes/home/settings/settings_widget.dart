import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:rolobox/main.dart';

class SettingsWidget extends StatefulWidget {
  @override
  State createState() {
    return SettingsWidgetState();
  }
}

class SettingsWidgetState extends State<SettingsWidget> {
  @override
  Widget build(BuildContext context) {
    return Consumer<User>(
      builder: (context, user, child) => CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: <Widget>[
          SliverAppBar(
            stretch: true,
            onStretchTrigger: () {
              // Function callback for stretch
              return;
            },
            pinned: true,
            floating: false,
            snap: false,
            actions: <Widget>[
              IconButton(
                icon: Icon(Icons.edit),
//              color: Colors.white,
              ),
            ],
            expandedHeight: 300.0,
            flexibleSpace: FlexibleSpaceBar(
              stretchModes: <StretchMode>[
                StretchMode.zoomBackground,
                StretchMode.blurBackground,
                StretchMode.fadeTitle,
              ],
              centerTitle: true,
              title: Text(user.userData.data.profile.name.full),
              background: AvatarBackground(
                imageUrl: user.avatarUrl(),
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate([
              SettingSection(
                title: "Account",
                items: <Widget>[
                  SettingItem(
                    iconData: Icons.email,
                    iconColor: Colors.blue,
                    title: user.userData.data.email,
                  ),
                  SettingItem(
                    iconData: Icons.phone,
                    iconColor: Colors.green,
                    title: user.userData.data.profile.phones[0].number,
                  ),
                ],
              ),
              SettingSection(
                title: "Appearance",
                items: <Widget>[
                  SettingItem(
                    iconData: Icons.color_lens,
                    iconColor: Colors.deepOrange,
                    title: 'App theme',
                  ),
                ],
              ),
              SettingSection(
                title: "Security",
                items: <Widget>[
                  SettingItem(
                    iconData: Icons.lock,
                    iconColor: Colors.blueAccent,
                    title: 'Password',
                  ),
                  SettingItem(
                    iconData: Icons.link,
                    iconColor: Colors.cyan,
                    title: 'Account Connection',
                  ),
                  SettingItem(
                    iconData: Icons.close,
                    iconColor: Colors.red,
                    title: 'Close Account',
                  ),
                ],
              ),
              SettingSection(
                title: "privacy",
                items: <Widget>[
                  SettingItem(
                    iconData: Icons.block,
                    iconColor: Colors.black,
                    title: "Blacklist",
                  ),
                ],
              ),
              SettingSection(
                title: 'Membership & Payments',
                items: <Widget>[
                  SettingItem(
                    title: "Pro Membership",
                    iconData: Icons.stars,
                    iconColor: Colors.amber,
                  ),
                  SettingItem(
                    title: "Payment",
                    iconData: Icons.credit_card,
                    iconColor: Colors.indigo,
                  ),
                ],
              ),
            ]),
          ),
        ],
      )
    );
  }
}

class AvatarBackground extends StatelessWidget {
  final String imageUrl;

  AvatarBackground({this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        Image.network(
          imageUrl,
          fit: BoxFit.cover,
        ),
        const DecoratedBox(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment(0.0, 0.8),
              end: Alignment(0.0, 0.4),
              colors: <Color>[
                Color(0x60000000),
                Color(0x00000000),
              ],
            ),
          ),
        ),
      ],
    );
  }
}



class SettingSection extends StatelessWidget {
  final String title;
  final List<Widget> items;

  SettingSection({this.title, this.items});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 16),
      child: Column(
        children: <Widget>[
          SectionTitle(title),
          Divider(),
          ListView(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            shrinkWrap: true,
            physics: ClampingScrollPhysics(),
            children: items
          ),
          Divider(),
        ],
      ),
    );
  }
}

class SectionTitle extends StatelessWidget {
  final String title;

  SectionTitle(this.title);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(
        title,
        style: TextStyle(
          color: Theme.of(context).primaryColor,
          fontWeight: FontWeight.w500,
          fontSize: 16,
        ),
      ),
      padding: EdgeInsets.only(left: 16),
      alignment: Alignment.centerLeft,
    );
  }
}


class SettingItem extends StatelessWidget {
  final String title;
  final IconData iconData;
  final Color iconColor;
  final GestureTapCallback onTap;

  SettingItem({this.title, this.iconData, this.iconColor, this.onTap});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(
        iconData,
        color: iconColor,
      ),
      title: Text(title),
      trailing: Icon(Icons.chevron_right),
      onTap: onTap,
    );
  }
}
