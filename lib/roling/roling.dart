import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_fortune_wheel/flutter_fortune_wheel.dart';
import 'package:simplechoice/style/themeStyle.dart';

class Roling extends StatefulWidget {
  final items;
  final ValueChanged<String> theme;
  Roling({Key key, this.theme, this.items});

  @override
  _RolingState createState() => _RolingState();
}

class _RolingState extends State<Roling> {
  StreamController<int> selected = StreamController<int>();

  @override
  void dispose() {
    selected.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Rolling wheel"),
      ),
      body: Container(
        margin: EdgeInsets.all(10),
        child: Column(
          children: [
            Expanded(
              child: FortuneWheel(
                selected: selected.stream,
                items: [
                  for (var it in widget.items)
                    FortuneItem(
                        child: Text(
                      it,
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
                    )),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.all(25),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        selected.add(
                          Fortune.randomInt(0, widget.items.length),
                        );
                      });
                    },
                    child: Text(
                      'Ulangi Putar',
                      style: styleTitleList,
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text(
                      'Reset / Tambah Pilihan',
                      style: styleTitleList,
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
      bottomNavigationBar: Container(
        height: 60,
        child: Center(child: Text('DI SIni Iklan')),
      ),
    );
  }
}
