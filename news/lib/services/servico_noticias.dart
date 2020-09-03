import '../model/modelo_noticia.dart';

class ServicoNoticias {

  static List<Noticia> noticias = new List<Noticia>();

  static void adicionaNoticia(Noticia noticia){
    noticias.add(noticia);
  }

  static bool contem(int id){
    return noticias.where((item) => item.id == id).length > 0;
  }

  static void removaNoticia(int id){
    noticias.removeWhere((item) => item.id == id);
  }

  static int quantidadeNoticias(){
    return noticias.length;
  }
}