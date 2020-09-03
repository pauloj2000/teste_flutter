import 'package:alternative/model/modelo_autor.dart';
import 'package:alternative/model/modelo_noticia.dart';
import 'package:alternative/pages/inicio.dart';
import 'package:alternative/singleton/singleton_banco_dados.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:toast/toast.dart';

class NovaNoticiaPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _NovaNoticiaPageState();
}

class _NovaNoticiaPageState extends State<NovaNoticiaPage> {
  bool _loading = false;

  static TextEditingController _titulo = new TextEditingController();
  static TextEditingController _texto = new TextEditingController();
  static TextEditingController _nomeAutor = new TextEditingController();

  int current_step = 0;

  _sucessoNovaNoticia() {
    Toast.show("Notícia cadastrada com sucesso!", context,
        gravity: Toast.CENTER);
  }

  int _value = 1;

  List<Step> my_steps = [
    Step(
        title: Text("Escolha o título da notícia"),
        content: Container(
          child: TextField(
            controller: _titulo,
            decoration: new InputDecoration(labelText: 'Título'),
          ),
        ),
        isActive: true),
    Step(
        title: Text("Escreva a notícia"),
        content: Container(
          child: TextField(
            controller: _texto,
            decoration: new InputDecoration(labelText: 'Texto'),
          ),
        ),
        isActive: true),
    Step(
        title: Text("Escolha o autor"),
        content: Container(
            child: Column(
          children: <Widget>[
            TextField(
              controller: _nomeAutor,
              decoration: new InputDecoration(labelText: 'Autor'),
            ),
            SizedBox(
              height: 10,
            ),
            SingletonBD.instance.listaAutores.length > 0 ? DropdownButton<String>(
              items: SingletonBD.instance.listaAutores.toList().map((Autor autor) {
                return new DropdownMenuItem<String>(
                  value: autor.id.toString(),
                  child: new Text(autor.nome),
                );
              }).toList(),
            ) : Container()
          ],
        )),
        isActive: true),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Icon(
          Icons.done,
          size: MediaQuery.of(context).size.width * 0.1,
        ),
        onPressed: () {
          Autor autor;

          if (SingletonBD.instance.listaAutores.length > 0) {
            SingletonBD.instance.listaAutores.forEach((item) {
              if (item.nome == _nomeAutor.text) {
                autor = item;
              }
            });
          }

          if (autor == null) {
            autor = new Autor(nome: _nomeAutor.text);
            SingletonBD.instance.listaAutores.add(autor);
          }

          Noticia noticia = new Noticia(
              titulo: _titulo.text, texto: _texto.text, autor: autor);

          SingletonBD.instance.listaNoticia.add(noticia);
          _sucessoNovaNoticia();
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => InicioPage()),
          );
        },
        backgroundColor: Colors.blue.withOpacity(0.8),
        foregroundColor: Colors.white,
      ),
      appBar: _buildBar(context),
      body: ModalProgressHUD(
        inAsyncCall: _loading,
        child: Container(
          child: ListView(
            children: <Widget>[
              Stepper(
                currentStep: this.current_step,
                steps: my_steps,
                type: StepperType.vertical,
                onStepTapped: (step) {
                  setState(() {
                    current_step = step;
                  });
                  print("onStepTapped : " + step.toString());
                },
                onStepCancel: () {
                  setState(() {
                    if (current_step > 0) {
                      current_step = current_step - 1;
                    } else {
                      current_step = 0;
                    }
                  });
                },
                onStepContinue: () {
                  setState(() {
                    if (current_step < my_steps.length - 1) {
                      current_step = current_step + 1;
                    } else {
                      current_step = 0;
                    }
                  });
                  print("onStepContinue : " + current_step.toString());
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBar(BuildContext context) {
    return new AppBar(
      title: new Text(
        "Nova notícia",
        style: TextStyle(
          color: Colors.white,
        ),
      ),
      centerTitle: true,
      backgroundColor: Colors.blue,
      automaticallyImplyLeading: true,
    );
  }
}
