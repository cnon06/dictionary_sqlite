


import 'package:untitled/Kelimeler.dart';


import 'VeritabaniYardimcisi.dart';


class kelimelerdao
{

  Future <List<Kelimeler>> tumKelimeler () async
  {
    var db = await VeriTabaniYardimcisi.veriTabaniErisim();
    List<Map<String,dynamic>> maps = await db.rawQuery("SELECT * FROM kelimeler");
    
    return List.generate(maps.length, (index){
      var satir = maps[index];
      return Kelimeler(satir["kelime_id"],satir["ingilizce"] , satir["turkce"],);
    });
  }

  Future <List<Kelimeler>> kelimeAra (String arananKelime) async
  {



    var db = await VeriTabaniYardimcisi.veriTabaniErisim();
    // List<Map<String,dynamic>> maps = await db.rawQuery("SELECT * FROM kelimeler ");
    List<Map<String,dynamic>> maps = await db.rawQuery("SELECT * FROM kelimeler WHERE ingilizce like '%$arananKelime%'");

    return List.generate(maps.length, (index){
      var satir = maps[index];
      return Kelimeler(satir["kelime_id"],satir["ingilizce"] , satir["turkce"],);
    });
  }


}