import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/article.dart';
import 'package:flutter_application_1/page/cart.dart';
import 'package:flutter_application_1/page/detail_article_page.dart';
import 'package:go_router/go_router.dart';
import 'package:http/http.dart';
import 'package:provider/provider.dart'; 


import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:flutter_application_1/article.dart';
import 'package:flutter_application_1/page/cart.dart';

class PanierArticlePage extends StatelessWidget {
  const PanierArticlePage({super.key});

  @override
  Widget build(BuildContext context) {
    final cart = context.watch<Cart>();
    final listArticles = cart.getAll();
    final double total = listArticles.fold(
      0.0,
      (previousValue, article) => previousValue + article.prix,
    );
    final double totalTTC = total * 1.2;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Panier"),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: listArticles.isEmpty
          ? const Center(
              child: Text(
                "Votre panier est vide.",
                style: TextStyle(fontSize: 18),
              ),
            )
          : Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: listArticles.length,
                    itemBuilder: (ctx, index) {
                      final article = listArticles[index];
                      return ListTile(
                        leading: Image.network(
                          article.image,
                          height: 80,
                          width: 80,
                        ),
                        title: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(article.nom),
                        ),
                        subtitle: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(article.prixEuro()),
                        ),
                        trailing: IconButton(
                          icon: const Icon(Icons.delete),
                          onPressed: () {
                            context.read<Cart>().remove(article);
                          },
                        ),
                      );
                    },
                  ),
                ),

          Padding(     
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        "Total HT : ${total.toStringAsFixed(2)} €",
                        style: const TextStyle(fontSize: 16),
                      ),
                      Text(
                        "Total TTC (Avec 20% de TVA) : ${totalTTC.toStringAsFixed(2)} €",
                        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
                 OutlinedButton(
                        onPressed: () {},
                        child: Text("Procéder au paiement : ${totalTTC.toStringAsFixed(2)} €"),
                      ),
              ],
            ),
            
    );
  }
}