// ignore_for_file: public_member_api_docs, sort_constructors_first

class Article {
String nom;
String descriptions;
num prix;
String image;
String categorie;
  Article({
    required this.nom,
    required this.descriptions,
    required this.prix,
    required this.image,
    required this.categorie,
  });
String prixEuro()=>"$prix€";
}
