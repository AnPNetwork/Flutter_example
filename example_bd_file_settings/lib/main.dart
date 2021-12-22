import 'package:flutter/material.dart';
import 'dart:io';
import 'dart:async';
import 'class/AppFile.dart';
import './BdPage.dart';
import './SharedPage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const MyHomePage(),
      initialRoute: '/',
      routes: {
        '/second': (context) =>const BdPage(),
        '/settings': (context) => const SharedPage()
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String fileData = '';

  String savedData = '';

  AppFile appfile = AppFile();

  final _controller = TextEditingController();

  @override
  void initState() {
    _controller.text = '';

    _controller.addListener(() {
      fileData = _controller.text;
    });

    _readLocalData();
    super.initState();
  }

  _readLocalData() async {
    var readFile = await appfile.readLocalFile();
    setState(() {
      savedData = readFile;
    });
  }

  _addData() async {
    var writeFile = await appfile.writeLocalFile(fileData);
    _readLocalData();
  }

  _getData() async {}

  _cleanData() async {
    var writeFile = await appfile.writeLocalFile('');
    _readLocalData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Row(children: <Widget>[
          Expanded(
              flex: 1,
              child: Container(
                  child:const Text(
                  'файл',
                   textAlign: TextAlign.center,
               ),
              ),
          ),
          Expanded(
              flex: 1,
              child: GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, '/second');
                  },
                  child: Container(
                      child: Text(
                    'бд',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.black),
                  ),
                  ),
              ),
          ),
          Expanded(
              flex: 1,
              child: GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, '/settings');
                  },
                  child: Container(
                      child: Text(
                    'настройки',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.black),
                  ),
                  ),
              ),
          ),

        ],
        ),
        centerTitle: true,
      ),
      body: Center(
          child: Center(
        child: Column(
          children: [
            Container(
              height: 30,
              margin:const EdgeInsets.only(top: 10),
              width: double.infinity,
              child:const Text(
                'ФАЙЛ',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 25,
                    fontWeight:
                    FontWeight.bold,
                ),
              ),
            ),
            Expanded(
              child: Container(
                height: 100,
                margin:const EdgeInsets.all(10),
                padding:const EdgeInsets.all(10),
                width: double.infinity,
                decoration: BoxDecoration(
                    border: Border.all(
                        width: 1,
                    ),
                ),
                child: Text(
                  savedData,
                  softWrap: true,
                ),
              ),
            ),
            Flexible(
                child: Container(
              margin:const EdgeInsets.all(10),
              decoration: BoxDecoration(
                  border: Border.all(
                      color: Colors.blue,
                      width: 2
                  ),
              ),
              child: TextField(controller: _controller),
            )),
            Expanded(
                child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                  Expanded(
                    child: Container(
                      height: 100,
                      margin:const EdgeInsets.only(
                          top: 15, bottom: 15, left: 5, right: 5),
                      decoration: BoxDecoration(
                          border: Border.all(
                              color: Colors.green,
                              width: 1
                          ),
                      ),
                      child: Center(
                        child: TextButton(
                          onPressed: _addData,
                          child:const Text('Добавить'),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      margin:const EdgeInsets.only(
                          top: 15, bottom: 15, left: 5, right: 5),
                      height: 100,
                      decoration: BoxDecoration(
                          border: Border.all(
                              color: Colors.green,
                              width: 1
                          ),
                      ),
                      child: Center(
                        child: TextButton(
                          onPressed: _addData,
                          child:const Text('Получить'),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                      flex: 1,
                      child: Container(
                          margin:const EdgeInsets.only(
                              top: 15, bottom: 15, left: 5, right: 5
                          ),
                          height: 100,
                          decoration: BoxDecoration(
                              border:
                                  Border.all(
                                      color: Colors.black,
                                      width: 1
                                  ),
                          ),
                          child: Center(
                              child: TextButton(
                                  onPressed: _cleanData,
                                  child:const Text('Удалить'),
                              ),
                          ),
                      ),
                  ),
                ],
                ),
            ),
          ],
        ),
      ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
