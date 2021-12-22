import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

class AppFile {
/*  независимый от системы путь к каталогу документов  */
  Future<String> get getLocalPath async {
    Directory appDocDir = await getApplicationDocumentsDirectory();
    return appDocDir.path;
  }

  /*  создание файла */
  Future<File> get getLocalFile async {
    final path = await getLocalPath;
    print('$path/file.txt');
    return File('$path/file.txt');
  }

  /*  запись в файл */
  Future<File> writeLocalFile(String text) async {
    final file = await getLocalFile;
    return file.writeAsString(text);
  }

  /*  чтение файла */
  Future<String> readLocalFile() async {
    String? data;
    try {
      final file = await getLocalFile;

      data = file.readAsStringSync();
    }
    /* в первый раз всегда будет ошибка */
    catch (e) {
      data = 'Ошибка $e';
    }
    return data;
  }
}
