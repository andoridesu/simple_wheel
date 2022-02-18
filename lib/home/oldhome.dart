import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_fortune_wheel/flutter_fortune_wheel.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:simplechoice/config/themeController.dart';
import 'package:simplechoice/setting/setting.dart';
import 'package:simplechoice/style/themeStyle.dart';

class OldHome extends StatefulWidget {
  @override
  _OldHomeState createState() => _OldHomeState();
}

class _OldHomeState extends State<OldHome> {
  StreamController<int> selected = StreamController<int>();
  String themeuse;
  Color warnaPrimary = primaryColor;
  Color warnaSecond = secondColor;
  Color warnaButton = primaryColor;
  bool isloading = false;
  bool isAvaible = false;
  final _myController = TextEditingController();

  final items = <String>[
    'Mie Rebus',
    'Bakso',
    'Sate',
    // 'Pecel Lele',
    // 'Nasi Padang',
    // 'Soto',
    // 'Nasi Warteg',
    // 'Mie Ayam',
  ];

  _checkUseTheme() async {
    final prefs = await SharedPreferences.getInstance();
    final themeController = ThemeController(prefs);
    setState(() {
      themeuse = themeController.currentTheme;
      warnaPrimary = themeuse == 'light' ? primaryColor : darkColor;
      warnaSecond = themeuse == 'light' ? secondColor : darkColor;
      warnaButton = themeuse == 'light' ? primaryColor : Colors.white;
    });
  }

  _themeUser(String themeku) {
    setState(() {
      themeuse = themeku;
      warnaPrimary = themeuse == 'light' ? primaryColor : darkColor;
      warnaSecond = themeuse == 'light' ? secondColor : darkColor;
    });
  }

  void addPilihan() {
    setState(() {
      isloading = false;
      items.add(_myController.text);
    });
    _myController.clear();
  }

  @override
  void initState() {
    this._checkUseTheme();
    super.initState();
  }

  @override
  void dispose() {
    selected.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Simple Choice'),
        actions: [
          IconButton(
              icon: Icon(Icons.settings),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => Setting(
                              theme: _themeUser,
                            )));
              }),
          IconButton(icon: Icon(Icons.info_outline), onPressed: () {}),
        ],
      ),
      body: Column(
        children: [
          _buildHeader(),
          isloading
              ? Container()
              : Expanded(
                  child: FortuneWheel(
                    selected: selected.stream,
                    items: [
                      for (var it in items)
                        FortuneItem(
                            child: Text(
                          it,
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20),
                        )),
                    ],
                  ),
                ),
          isloading
              ? Container()
              : Container(
                  margin: EdgeInsets.all(25),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          setState(() {
                            selected.add(
                              Fortune.randomInt(0, items.length),
                            );
                          });
                        },
                        child: Text(
                          'Mulai Putar',
                          style: styleTitleList,
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {},
                        child: Text(
                          'Reset',
                          style: styleTitleList,
                        ),
                      ),
                    ],
                  ),
                )
        ],
      ),
      bottomNavigationBar: Container(
        height: 60,
        child: Center(child: Text('DI SIni Iklan')),
      ),
    );
  }

  _buildHeader() {
    return Container(
      color: Colors.grey.shade300,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            margin: EdgeInsets.symmetric(vertical: 3, horizontal: 20),
            width: MediaQuery.of(context).size.width / 1.5,
            child: _buildInput(),
          ),
          Container(
              child: isAvaible == true
                  ? TextButton(
                      child: Text(
                        'Tambah',
                        style: styleTitleList,
                      ),
                      onPressed: () {
                        setState(() {
                          isloading = true;
                        });
                        addPilihan();
                      })
                  : Container()),
        ],
      ),
    );
  }

  _buildInput() {
    return TextFormField(
      controller: _myController,
      onChanged: (val) {
        if (val.length > 2) {
          setState(() {
            isAvaible = true;
          });
        } else {
          setState(() {
            isAvaible = false;
          });
        }
      },
      textInputAction: TextInputAction.done,
      decoration: InputDecoration(
          hintText: 'Tambahkan Pilihan', border: InputBorder.none),
    );
  }
}
