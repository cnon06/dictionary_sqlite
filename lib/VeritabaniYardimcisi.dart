
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class VeriTabaniYardimcisi
{
  static final String veriTabaniAdi = "kelimeler.db";

  static Future <Database> veriTabaniErisim() async
  {
    String veriTabaniYolu = join(await getDatabasesPath(),veriTabaniAdi);

   // String directory =
    
    if(await databaseExists(veriTabaniYolu))
      {
        print('Veritabanı zaten var. Kopyalamaya gerek yok.');
    }
    else
      {
        ByteData data = await rootBundle.load("database/$veriTabaniAdi");
        List<int> bytes = data.buffer.asUint8List(data.offsetInBytes,data.lengthInBytes);
        await File(veriTabaniYolu).writeAsBytes(bytes,flush: true);
        print('Veri tabanı kopyalandı.');
      // final File file =File(veriTabaniYolu);

      }

    return openDatabase(veriTabaniYolu);

  }

}