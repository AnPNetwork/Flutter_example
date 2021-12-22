import 'package:flutter/material.dart';
import 'class/AppFile.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPage extends StatefulWidget {
  const SharedPage({Key? key}) : super(key: key);

  @override
  _SharedPageState createState() => _SharedPageState();
}

class _SharedPageState extends State<SharedPage> {
  SharedPreferences? prefs;
  int? count;

  String? textField;

  @override
  void initState() {
    void start() async {
      prefs = await SharedPreferences.getInstance();
      _getData();
    }

    start();

    super.initState();
  }

  _addText() async {
    await prefs?.setString('text', textField!);
    await prefs?.setInt('count', count! + 1);
    _getData();
  }

  _getData() async {
    setState(() {
      count = prefs?.getInt('count') ?? 0;
      textField = prefs?.getString('text') ?? '';
    });
  }

  _cleanData() async {
    await prefs?.setString('text', '');
    await prefs?.setInt('count', 0);
    _getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Row(children: <Widget>[
          Expanded(
            flex: 1,
            child: GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, '/');
                },
                child: Container(
                    child:const Text('файл',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.black
                        ),
                    ),
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
                      child:const Text(
                    'бд',
                    style: TextStyle(
                        color: Colors.black
                    ),
                    textAlign: TextAlign.center,
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
                          textAlign: TextAlign.center
                      ),
                  ),
              ),
          ),
        ],
        ),
        centerTitle: true,
      ),
      body: Center(
          child: Column(
        children: [
          Container(
            height: 30,
            margin:const  EdgeInsets.only(top: 10),
            width: double.infinity,
            child:const Text(
              'НАСТРОЙКИ',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold
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
                      width: 1
                  ),
              ),
              child: Text(
                'count - $count -- text - $textField',
                softWrap: true,
              ),
            ),
          ),
          Flexible(
              child: Container(
            margin:const EdgeInsets.all(10),
            decoration:
                BoxDecoration(border: Border.all(
                    color: Colors.blue,
                    width: 2,
                ),
                ),
            child: TextField(
              onChanged: (text) {
                setState(() {
                  textField = text;
                });
              },
            ),
          ),
          ),
          Expanded(
              child:
                  Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
            Expanded(
              child: Container(
                height: 100,
                margin:const EdgeInsets.only(top: 15, bottom: 15, left: 5, right: 5),
                decoration: BoxDecoration(
                    border: Border.all(
                        color: Colors.green,
                        width: 1,
                    ),
                ),
                child: Center(
                  child: TextButton(
                    onPressed: _addText,
                    child:const Text('Добавить'),
                  ),
                ),
              ),
            ),
            Expanded(
              child: Container(
                margin:const EdgeInsets.only(top: 15, bottom: 15, left: 5, right: 5),
                height: 100,
                decoration: BoxDecoration(
                    border: Border.all(
                        color: Colors.green,
                        width: 1
                    ),
                ),
                child: Center(
                  child: TextButton(
                    onPressed: () {},
                    child:const Text('Получить'),
                  ),
                ),
              ),
            ),
            Expanded(
                flex: 1,
                child: Container(
                    margin: const EdgeInsets.only(top: 15, bottom: 15, left: 5, right: 5),
                    height: 100,
                    decoration: BoxDecoration(
                        border: Border.all(
                            color: Colors.black,
                            width: 1
                        ),
                    ),
                    child: Center(
                        child: TextButton(
                            onPressed: _cleanData,
                            child:const Text('Удалить')
                        ),
                    ),
                ),
            ),

          ],
            ),
          ),
        ],
      ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
