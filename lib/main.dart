import 'package:flutter/material.dart';
import 'package:movies_app/components/my_movie_list.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Movie App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
            seedColor: const Color.fromARGB(255, 54, 20, 114)),
        useMaterial3: true,
      ),
      home: MyHomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text("Movie"),
          centerTitle: true,
          actions: [
            IconButton(
              onPressed: () {},
              icon: Icon(Icons.search),
            ),
          ],
        ),
        drawer: Drawer(
          child: ListView(
            children: const [
              UserAccountsDrawerHeader(
                accountName: Text("accountName"),
                accountEmail: Text("accountEmail"),
                currentAccountPicture: CircleAvatar(
                  backgroundImage: NetworkImage(""),
                ),
              ),
              ListTile(
                title: Text("data"),
                trailing: Icon(Icons.percent),
              ),
              ListTile(
                title: Text("data"),
                trailing: Icon(Icons.percent),
              ),
              ListTile(
                title: Text("data"),
                trailing: Icon(Icons.percent),
              ),
              Divider(),
              ListTile(
                title: Text("data"),
                trailing: Icon(Icons.percent),
              ),
            ],
          ),
        ),
        bottomNavigationBar: Container(
          height: 50,
          child: const TabBar(
            tabs: [
              Tab(text: "0", icon: Icon(Icons.person)),
              Tab(text: "0", icon: Icon(Icons.person)),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            MyMovieList(),
            MyMovieList(),
          ],
        ),
      ),
    );
  }
}
