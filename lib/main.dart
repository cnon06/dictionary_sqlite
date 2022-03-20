import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:untitled/Kelimeler.dart';
import 'package:untitled/detaySayfa.dart';
import 'package:untitled/kelimelerdao.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),

    );
  }
}

class MyHomePage extends StatefulWidget {


  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {


  bool aramaYapiliyorMu = false;
  String aramaKelimesi = "";

  var tfCont = TextEditingController();

  Future <List<Kelimeler>> tumKelimeleriGoster() async
  {
    var kelimelerListesi = await kelimelerdao().tumKelimeler();
    return kelimelerListesi;
  }

  Future <List<Kelimeler>> arananKelime(String arananKelimesi) async
  {
    var kelimelerListesi = await kelimelerdao().kelimeAra(arananKelimesi);
    return kelimelerListesi;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: aramaYapiliyorMu ? TextField(
          controller: tfCont,
          decoration: InputDecoration(
            hintText: "Arama için birşey yazın.",
          ),
          onChanged: (aramaSonucu)
          {
            setState(() {
              aramaKelimesi = tfCont.text;
            });
            print(aramaKelimesi);
                },


        ):Text(" Sözlük Uygulaması"),
        actions: [
          aramaYapiliyorMu ?

      IconButton(
      icon: Icon(Icons.cancel),
      onPressed: ()
      {
        setState(() {
          aramaYapiliyorMu = false;
          aramaKelimesi="";
        });
      },
    ) :
          IconButton(
            icon: Icon(Icons.search),
            onPressed: ()
            {
              setState(() {
                aramaYapiliyorMu = true;
              });
            },
          ),
        ],
      ),
      body: FutureBuilder<List<Kelimeler>>(
        future: aramaYapiliyorMu? arananKelime(aramaKelimesi): tumKelimeleriGoster(),
        builder: (context,snaphot)
        {

          if(snaphot.hasData)
            {
              var kelimeListesi = snaphot.data;
              return ListView.builder(
                  itemCount:kelimeListesi!.length,
                  itemBuilder: (context,indeks)
          {
            var kelime = kelimeListesi[indeks];
            return GestureDetector(
              onTap: ()
              {
                Navigator.push(context, MaterialPageRoute(builder: (context) => detaySayfa(ingilizce: kelime.ingilizce, turkce: kelime.turkce,)));
              },
              child: SizedBox(
                height: 60,
                child: Card(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(kelime.ingilizce, style: TextStyle(fontWeight: FontWeight.bold),),
                      Text(kelime.turkce),

                    ],
                  ),
                ),
              ),
            );
          });
            }
          else return Center();
        },

      ),

    );
  }
}
