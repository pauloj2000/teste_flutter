import 'dart:convert';
import 'modelo_autor.dart';


class Noticia {
  int id;
  String titulo;
  Autor autor;
  String texto;

  Noticia({
    this.id,
    this.titulo,
    this.autor,
    this.texto,
  });
}

class NoticiaList {
  final List<Noticia> listaNoticias;

  NoticiaList({
    this.listaNoticias,
  });
}