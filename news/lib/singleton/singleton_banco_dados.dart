import 'package:alternative/model/modelo_autor.dart';
import '../model/modelo_noticia.dart';

class SingletonBD {

  SingletonBD._();

  static SingletonBD _instance = new SingletonBD._();

  static SingletonBD get instance => _instance;

  List<Noticia> listaNoticia = new List<Noticia>();

  List<Autor> listaAutores = new List<Autor>();

}