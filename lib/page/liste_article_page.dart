import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/article.dart';
import 'package:flutter_application_1/page/cart.dart';
import 'package:flutter_application_1/page/detail_article_page.dart';
import 'package:go_router/go_router.dart';
import 'package:http/http.dart';
import 'package:provider/provider.dart';
class ListeArticlePage  extends StatelessWidget {
  ListeArticlePage ({super.key});
 final article = Article(
  nom:"Sac a dos",
  descriptions:"Pour emporter des choses Pour emporter des choses Pour emporter des choses Pour emporter des choses Pour emporter des choses Pour emporter des choses Pour emporter des choses Pour emporter des choses",
  prix:125.0,
  image:"https://fakestoreapi.com/img/81fPKd-2AYL._AC_SL1500_.jpg",
  categorie:"Weareable"
  
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
    appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('EPSI Shop'),
        actions: [
        IconButton(
        onPressed: () => context.go("/panier"),
        icon: Badge(
          label:
          Text(context.watch<Cart>().getAll().length.toString()),
          child: const Icon(Icons.shopping_cart),
        ),
        )
        ],
      ),

      body: FutureBuilder<List<Article>>(
        future: fetchListArticle(),
        builder: (context, snapshot) {
          if(snapshot.hasData && snapshot.data != null) {
          return ListArticles(listArticles: snapshot.data!,);
          }else if(snapshot.hasError){
            return Text(snapshot.error.toString());
           }
          else{
          return const CircularProgressIndicator();
          }
        }
      ),
    );
  }

Future<List<Article>> fetchListArticle() async {
    //Récupérer les données depuis fakestore api
    final res = await get(Uri.parse("https://fakestoreapi.com/products"));
    if (res.statusCode == 200) {
      //Les transformer en Liste d'articles
      print("réponse ${res.body}");
      final listMapArticles = jsonDecode(res.body) as List<dynamic>;
      return listMapArticles
          .map((map) => Article(
          nom: map["title"],
          descriptions: map["description"],
          prix: map["price"],
          image : map["image"],
           categorie :map["category"]))
          .toList();
    }
    //Les renvoyer
    return Future.error("connxion impossible");
  }
}

class ListArticles extends StatelessWidget {
  final List<Article> listArticles;
  const ListArticles({
    super.key,
    required this.listArticles
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: listArticles.length,
    itemBuilder: (ctx, index)=>
    
    
         ListTile(
    onTap:() => ctx.go("/details",extra : listArticles[index]),
    leading: Image.network(
      listArticles[index].image,
      height:80,
      width: 80,
    ), 
    title : Text(listArticles[index].nom),
    )
    );
  }
}