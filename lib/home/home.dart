import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:simplechoice/config/parentProvider.dart';
import 'package:simplechoice/config/themeController.dart';
import 'package:simplechoice/roling/roling.dart';
import 'package:simplechoice/setting/setting.dart';
import 'package:simplechoice/style/themeStyle.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String themeuse;
  Color warnaPrimary = primaryColor;
  Color warnaSecond = secondColor;
  Color warnaButton = primaryColor;
  bool isloading = false;
  bool isAvaible = false;
  final _myController = TextEditingController();
  List items = <String>[];

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
    if (_myController.text == null || _myController.text == '') {
      print("object");
    } else {
      setState(() {
        isloading = false;
        items.add(_myController.text);
      });
      _myController.clear();
    }
  }

  @override
  void initState() {
    this._checkUseTheme();
    super.initState();
  }

  @override
  void dispose() {
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
      body: ParentProvider(
        theme: themeuse,
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.all(15),
              child: Text(
                'Tambahkan Pilihan terlebih dahulu! Minimal 3 Pilihan  ',
                style: styleTitleList,
              ),
            ),
            _buildHeader(),
            _buildviewPilihan(),
            Container(
              margin: EdgeInsets.all(10),
              child: items.length > 2
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            if (items.length >= 3) {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Roling(
                                            theme: _themeUser,
                                            items: items,
                                          )));
                            } else {
                              print(
                                  'Tambahkan Pilihan harus lebih dari 3 pilihan');
                            }
                          },
                          child: Text(
                            'Mulai Putar',
                            style: styleTitleList,
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            setState(() {
                              items = [];
                            });
                          },
                          child: Text(
                            'Reset / ulangi',
                            style: styleTitleList,
                          ),
                        ),
                      ],
                    )
                  : Container(),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        height: 60,
        child: Center(child: Text('DI SIni Iklan')),
      ),
    );
  }

  _buildHeader() {
    _checkUseTheme();
    return Container(
      margin: EdgeInsets.symmetric(vertical: 3, horizontal: 10),
      //color: themeuse == 'light' ? Colors.grey.shade300 : Colors.black,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            width: MediaQuery.of(context).size.width / 1.4,
            child: _buildInput(),
          ),
          Container(
              child: TextButton(
                  child: Text(
                    'Tambah',
                    style: styleTitleList,
                  ),
                  onPressed: () {
                    if (isAvaible == true) {
                      setState(() {
                        isloading = true;
                      });
                      addPilihan();
                    }
                  })),
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
      onFieldSubmitted: (val) {
        addPilihan();
      },
      textInputAction: TextInputAction.done,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.all(15),
          hintText: 'Tambahkan Pilihan',
          border: outlineBorder,
          filled: true),
    );
  }

  _buildviewPilihan() {
    return Expanded(
      child: ListView(
        children: [
          for (var it in items)
            ListTile(
              title: Text(
                it,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              leading: Icon(Icons.list_alt_outlined),
              trailing: IconButton(
                  icon: Icon(
                    Icons.delete_forever,
                    size: 22,
                  ),
                  onPressed: () {
                    setState(() {
                      items.removeWhere((e) => e == it);
                    });
                  }),
            ),
        ],
      ),
    );
  }
}
