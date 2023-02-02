// ignore_for_file: non_constant_identifier_names

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:news_app/article.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'News App',
      theme: ThemeData(
        primarySwatch: Colors.yellow,
      ),
      debugShowCheckedModeBanner: false,
      home: const MyHomePage(title: 'Bitcoin News App'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String APIKey = "463675d049e44f9f9f89aef38c59d737";

  bool onLoad = false;
  late Articles articles;
  bool isListView = true;

  void getHttp() async {
    try {
      setState(() {
        onLoad = true;
      });
      var response = await Dio()
          .get('https://newsapi.org/v2/everything?q=bitcoin&apiKey=$APIKey');
      var data = response.data;
      articles = Articles.fromMap(data);
      setState(() {
        onLoad = false;
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    getHttp();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Container(
        child: onLoad
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : articles.articles.isEmpty
                ? const Center(
                    child: Text("No articles found"),
                  )
                : isListView
                    ? ListView.builder(
                        itemCount: articles.articles.length,
                        itemBuilder: (context, index) {
                          return ListTile(
                            title: Text(
                              articles.articles[index].title ?? "No Title",
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                            subtitle: Column(
                              children: [
                                const Divider(),
                                Text(
                                  articles.articles[index].description ??
                                      "No Description",
                                  style: const TextStyle(
                                    fontSize: 12,
                                    color: Colors.black,
                                  ),
                                ),
                              ],
                            ),
                            contentPadding: const EdgeInsets.all(15),
                          );
                        },
                      )
                    : GridView.count(
                        crossAxisCount: 2,
                        childAspectRatio: 0.6,
                        controller: ScrollController(keepScrollOffset: false),
                        shrinkWrap: true,
                        scrollDirection: Axis.vertical,
                        children: articles.articles.map((dynamic item) {
                          return Container(
                            margin: const EdgeInsets.all(10.0),
                            child: Column(
                              children: [
                                Text(
                                  item.title,
                                  style: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                                const Divider(),
                                Text(
                                  item.description,
                                  style: const TextStyle(
                                    fontSize: 12,
                                    color: Colors.black,
                                  ),
                                ),
                              ],
                            ),
                          );
                        }).toList(),
                      ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => {
          setState(() => {isListView = !isListView})
        },
        child: Icon(isListView ? Icons.list : Icons.grid_view),
      ),
    );
  }
}
