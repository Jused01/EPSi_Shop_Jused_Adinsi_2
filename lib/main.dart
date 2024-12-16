import 'package:flutter/material.dart';
import 'package:flutter_application_1/article.dart';
import 'package:flutter_application_1/page/cart.dart';
import 'package:flutter_application_1/page/detail_article_page.dart';
import 'package:flutter_application_1/page/liste_article_page.dart';
import 'package:flutter_application_1/page/panier.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
} 
class MyApp extends StatelessWidget {
  MyApp({super.key});
  final router = GoRouter(routes:[
    GoRoute(path: "/",
    builder: (ctx, state)=>ListeArticlePage(),
    routes: [
      GoRoute(
      path: "details",
      builder : (ctx, state)=>DetailsArticlePage(article :state.extra as Article),
        routes: [
         GoRoute(
        path: "panier",
        builder : (ctx, state)=>PanierArticlePage())
        ]
),
      GoRoute(
      path: "panier",
      builder : (ctx, state)=>PanierArticlePage()
)
    ]
    )
  ]);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => Cart(),
      child: MaterialApp.router(
        routerConfig: router,
        title: 'Epsi Shop',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          // This is the theme of your application.
          //
          // TRY THIS: Try running your application with "flutter run". You'll see
          // the application has a purple toolbar. Then, without quitting the app,
          // try changing the seedColor in the colorScheme below to Colors.green
          // and then invoke "hot reload" (save your changes or press the "hot
          // reload" button in a Flutter-supported IDE, or press "r" if you used
          // the command line to start the app).
          //
          // Notice that the counter didn't reset back to zero; the application
          // state is not lost during the reload. To reset the state, use hot
          // restart instead.
          //
          // This works for code too, not just values: Most code changes can be
          // tested with just a hot reload.
          
          colorScheme: ColorScheme.fromSeed(seedColor: const Color.fromARGB(255, 3, 232, 239)),
          useMaterial3: true,
        ),
      ),
    );
  }
}

