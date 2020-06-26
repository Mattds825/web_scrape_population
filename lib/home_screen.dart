import 'package:flutter/material.dart';
import 'package:web_scraper/web_scraper.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  WebScraper webScraper;
  bool loaded = false;
  String popNum;

  @override
  void initState() {
    super.initState();
    _getData();
  }

  _getData() async {
    webScraper = WebScraper('https://worldpopulationreview.com');
    if (await webScraper.loadWebPage('/')) {
      List<Map<String, dynamic>> results =
          webScraper.getElement('div.center', ['title']);
      setState(() {
        loaded = true;
        popNum = results[0]['title'];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: (loaded)?Text(popNum):CircularProgressIndicator(),
      ),
    );
  }
}
