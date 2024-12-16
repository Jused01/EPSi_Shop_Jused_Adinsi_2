import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/article.dart';
import 'package:flutter_application_1/main.dart';
import 'package:flutter_application_1/page/cart.dart';
import 'package:flutter_application_1/page/liste_article_page.dart';
import 'package:flutter_application_1/page/panier.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class DetailsArticlePage extends StatelessWidget {
  const DetailsArticlePage({super.key, required this.article});
  final article ;



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar :AppBar(
      title: const Text("Details"),
      backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      actions: [
          IconButton(onPressed: () => context.go("/panier"),
          icon: Badge(
          label:
          Text(context.watch<Cart>().getAll().length.toString()),
          child: const Icon(Icons.shopping_cart),
        ),        
        )
        ],
      ),
          body: SingleChildScrollView(
            child: Column(
              children :[Image.network(
                height:300,
                article.image,
                width:MediaQuery.of(context).size.width,
                ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment:MainAxisAlignment.spaceBetween,
                  children:[
                    Flexible(child:
                  Text(article.nom, 
                  style: Theme.of(context).textTheme.headlineMedium,
                  )
                  ),
                  Text(article.prixEuro(),
                  style: Theme.of(context).textTheme.titleLarge,),
                ],),
              ),

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Align(
                  alignment: Alignment.centerLeft,
                child: Text("Categorie : ${article.categorie}",
                ),
                ),
              ),

              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(article.descriptions,
                textAlign: TextAlign.start,
                ),
              ),
             // FutureBuilder(
                //future: wait5Seconds(), 
               // builder: (context, snapshot){
                  //if(snapshot.hasData){
                   // return Text("Donnée telecharger : ${snapshot.data}");
                 // }else{
                  // return CircularProgressIndicator();
                 // }
                //}
                //),
                OutlinedButton(onPressed: (){
                  context.read<Cart>().add(article);

                }, child: const Text("Ajouter au panier"))
              ],
            ),
          ),


      );
  }
  Future<bool> wait5Seconds() async{
    await Future.delayed(const Duration(seconds: 5));
    return true ;
  }
}