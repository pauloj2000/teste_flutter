import 'package:alternative/components/card_noticia.dart';
import 'package:alternative/model/modelo_noticia.dart';
import 'package:alternative/pages/nova_noticia.dart';
import 'package:alternative/singleton/singleton_banco_dados.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class InicioPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _InicioPageState();
}

class _InicioPageState extends State<InicioPage> {

  List<CardNoticia> listaCards = new List<CardNoticia>();

  iniciaCards() async {
    if(listaCards.length < 0){
      listaCards.clear();
    }

    if(SingletonBD.instance.listaNoticia.length > 0) {
      SingletonBD.instance.listaNoticia.forEach((item) {
        listaCards.add(new CardNoticia(item));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    iniciaCards();

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Icon(
          Icons.add,
          size: MediaQuery.of(context).size.width * 0.1,
        ),
        onPressed: () async {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => NovaNoticiaPage()),
            );
        },
        backgroundColor: Colors.blue.withOpacity(0.8),
        foregroundColor: Colors.white,
      ),
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Notícias",
          style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontFamily: "Ubuntu"),
        ),
      ),
      body: ListView(
        children: listaCards,
      ),
    );
  }
}
