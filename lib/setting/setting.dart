import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:simplechoice/config/themeController.dart';
import 'package:simplechoice/style/themeStyle.dart';

class Setting extends StatefulWidget {
  final ValueChanged<String> theme;
  Setting({Key key, this.theme});

  @override
  _SettingState createState() => _SettingState();
}

class _SettingState extends State<Setting> {
  bool isActive = false;
  Color warnaPertama = primaryColor;
  Color warnaKedua = secondColor;
  Color warnaIcon = primaryColor;

  _checkUseTheme() async {
    final prefs = await SharedPreferences.getInstance();
    final themeController = ThemeController(prefs);
    var curent = themeController.currentTheme;
    if (curent == 'dark') {
      setState(() {
        isActive = true;
        warnaPertama = darkColor;
        warnaKedua = darkColor;
        warnaIcon = Colors.white;
      });
    } else {
      setState(() {
        isActive = false;
        warnaPertama = primaryColor;
        warnaKedua = secondColor;
        warnaIcon = primaryColor;
      });
    }
  }

  @override
  void initState() {
    this._checkUseTheme();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pengaturan'),
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(vertical: 5),
        physics: ScrollPhysics(),
        children: <Widget>[
          ListTile(
            leading: (isActive)
                ? Icon(Icons.brightness_3)
                : Icon(Icons.brightness_6),
            title: Text(
              "Gunakan Tema Dark",
              style: listStyle,
            ),
            subtitle: (isActive)
                ? Text(
                    "Tema Sekarang Gelap",
                    style: subListStyle,
                  )
                : Text("Tema Sekarang Terang", style: subListStyle),
            trailing: Switch(
                value: isActive,
                activeColor: primaryColor,
                onChanged: (changeTheme) {
                  if (isActive) {
                    setState(() {
                      isActive = false;
                      warnaPertama = primaryColor;
                      warnaKedua = secondColor;
                    });
                    ThemeController.of(context).setTheme('light');
                  } else {
                    setState(() {
                      isActive = true;
                      warnaPertama = darkColor;
                      warnaKedua = darkColor;
                    });
                    ThemeController.of(context).setTheme('dark');
                  }
                }),
          ),
          ListTile(
            leading: Icon(
              Icons.android,
              size: 30,
            ),
            title: Text(
              "Tentang Kami",
              style: listStyle,
            ),
            subtitle:
                Text("Tentang aplikasi Simple Choiche", style: subListStyle),
            onTap: () {},
          ),
          ListTile(
            leading: Icon(
              Icons.share_outlined,
              size: 30,
            ),
            title: Text(
              "Share Aplikasi",
              style: listStyle,
            ),
            subtitle: Text("Membagigan link aplikasi", style: subListStyle),
            onTap: () {},
          ),
        ],
      ),
      bottomNavigationBar: Container(
        height: 60,
        child: Center(child: Text('DI SIni Iklan')),
      ),
    );
  }
}
