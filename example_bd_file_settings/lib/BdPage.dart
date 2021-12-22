import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'class/AppFile.dart';
import 'class/AppBd.dart';

AppBd rawDb = AppBd();

class BdPage extends StatefulWidget {
  const BdPage({Key? key}) : super(key: key);

  @override
  _BdPageState createState() => _BdPageState();
}

class _BdPageState extends State<BdPage> {
  String name = '';

  String userName = '';

  @override
  void initState() {
    _getDb();

    super.initState();
  }

  _addDb() async {
    var insertDb = await rawDb.insertSettings(name: name, userName: userName);

    _getDb();
  }

  _getDb() async {
    var data = await rawDb.getSettingsList();

    print(data);

    setState(() {
      name = data[0]['name'];
      userName = data[0]['userName'];
    });
  }

  _remove() async {
    var data = await rawDb.clearSettings();
    _getDb();
  }

  @override
  Widget build(BuildContext context) {
    print(MediaQuery.of(context).size.height);
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title:  Row(children: <Widget>[
          Expanded(
              flex: 1,
              child: GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, '/');
                },
                child: Container(
                    child: const Text(
                      'файл',
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
                  child: Container(
                      child:const Text(
                        'бд',
                        textAlign: TextAlign.center,
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
                      child:const Text(
                        'настройки',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.black
                        ),
                      ),
                  ),
              ),
          ),
        ],
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
             children: [
                    Container(
                          margin:const EdgeInsets.only(top: 10),
                          width: double.infinity,
                          child:const Text(
                            'БАЗА ДАННЫХ',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 25, fontWeight: FontWeight.bold
                            ),
                          ),
                      ),
                      SizedBox(
                        height: 70,
                        child: Container(
                          margin:const EdgeInsets.all(10),
                          padding:const EdgeInsets.all(10),
                          width: double.infinity,
                          decoration: BoxDecoration(
                              border: Border.all(
                                  width: 1
                              ),
                          ),
                          child: Text(
                            name,
                            softWrap: true,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 70,
                        child: Container(
                          margin:const EdgeInsets.all(10),
                          padding:const EdgeInsets.all(10),
                          width: double.infinity,
                          decoration: BoxDecoration(
                              border: Border.all(width: 1),
                          ),
                          child: Text(
                            userName,
                            softWrap: true,
                          ),
                        ),
                      ),
                      SizedBox(
                        height:55 ,
                        child: Container(
                          margin:const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              border: Border.all(
                                  color: Colors.blue,
                                  width: 2,
                              ),
                          ),
                          child: TextField(
                            decoration:const InputDecoration(
                              hintText: 'name',
                            ),
                            onChanged: (text) {
                              setState(() {
                                name = text.toString();
                              });
                            },
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 55,
                        child: Container(
                          height: 50,
                          margin:const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.blue, width: 2)),
                          child: TextField(
                            decoration:const InputDecoration(
                              hintText: 'userName',
                            ),
                            onChanged: (text) {
                              setState(() {
                                userName = text.toString();
                              });
                            },
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 70,
                          child: Container(
                            child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                              Expanded(
                                child: Container(
                                  height: 100,
                                  margin:const EdgeInsets.only(
                                      top: 15, bottom: 15, left: 5, right: 5
                                  ),
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          color: Colors.green,
                                          width: 1
                                      ),
                                  ),
                                  child: Center(
                                    child: TextButton(
                                      onPressed: _addDb,
                                      child:const Text('Добавить'),
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Container(
                                  margin:const EdgeInsets.only(
                                      top: 15, bottom: 15, left: 5, right: 5
                                  ),
                                  height: 100,
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          color: Colors.green,
                                          width: 1
                                      ),
                                  ),
                                  child: Center(
                                    child: TextButton(
                                      onPressed: _getDb,
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
                                              onPressed: _remove,
                                              child:const Text('Удалить'),
                                          ),
                                      ),
                                  ),
                              ),
                            ],
                            ),
                          ),
                      ),
                    ],
                  ),
        ),
      ),
    );
  }
}
