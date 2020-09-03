import 'dart:convert';

Autor itemFromJson(String str) => Autor.fromJson(json.decode(str));

String itemToJson(Autor data) => json.encode(data.toJson());

class Autor {
  int id;
  String nome;

  Autor({
    this.id,
    this.nome,
  });

  factory Autor.fromJson(Map<String, dynamic> json) => Autor(
    id: json["id"],
    nome: json["nome"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "nome": nome,
  };
}