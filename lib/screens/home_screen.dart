import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:movies_app/providers/home_provider.dart';
import 'package:movies_app/widgets/movie_list.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);

  late List<dynamic> apiResult = [];
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Future<List<dynamic>> fetchAlbum() async {
    final response = await http
        .get(Uri.parse('https://jsonplaceholder.typicode.com/albums'));
    final extractedData = json.decode(response.body) as List<dynamic>;
    print(extractedData[1]);
    setState(() {
      widget.apiResult = extractedData;
    });
    return extractedData;
  }

  Future<Map<String, dynamic>> signIn() async {
    final response = await http.get(Uri.parse(
        'http://flutterspring-env.eba-m2wnsn9k.us-east-2.elasticbeanstalk.com/user/login'));
    final extractedData = json.decode(response.body) as Map<String, dynamic>;
    print(extractedData);
    // setState(() {
    //   widget.apiResult = extractedData;
    // });
    return extractedData;
  }

  List<dynamic> data = [
    {"title": "Action", "img": "assets/images/movies.jpg"},
    {"title": "Horor", "img": "assets/images/movies.jpg"},
    {"title": "Most watched", "img": "assets/images/movies.jpg"},
    {"title": "COmedy", "img": "assets/images/movies.jpg"},
    {"title": "Thriller", "img": "assets/images/movies.jpg"},
    {"title": "Drama", "img": "assets/images/movies.jpg"},
  ];

  @override
  Widget build(BuildContext context) {
    final double windowsHeight = MediaQuery.of(context).size.height;
    return Padding(
        padding: const EdgeInsets.only(left: 22.0, right: 22.0, top: 30.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            IconButton(
              icon: Icon(Icons.download, color: Colors.white),
              onPressed: () async =>
                  await Provider.of<HomeProvider>(context, listen: false)
                      .getContentById(1),
            ),
            SizedBox(
              height: windowsHeight * 0.05,
            ),
            FutureBuilder(
              future: Provider.of<HomeProvider>(context).getContentById(1),
              builder: (context, snapshot) =>
                  snapshot.connectionState == ConnectionState.waiting
                      ? CircularProgressIndicator()
                      : SizedBox(
                          height: 450,
                          child: ListView.builder(
                            itemCount: (snapshot.data as List<dynamic>).length,
                            itemBuilder: (context, index) => Text(
                              ((snapshot.data as List<dynamic>)[index]
                                  as Map<String, dynamic>)['title'],
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
            )
            // Expanded(
            //   child: ListView.builder(
            //       itemCount: data.length,
            //       itemBuilder: (BuildContext context, int index) {
            //         return MovieList(
            //             data.elementAt(index)["title"], widget.apiResult);
            //       }),
            // ),
          ],
        ));
  }
}
