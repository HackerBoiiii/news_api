import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:news_api/helper/data.dart';
import 'package:news_api/helper/news.dart';
import 'package:news_api/models/article_model.dart';
import 'package:news_api/models/category_model.dart';
import 'package:news_api/views/articleview.dart';
import 'package:news_api/views/category_news.dart';

import 'aboutus.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<CategoryModel> categories = new List<CategoryModel>();
  List<ArticleModel> articles = new List<ArticleModel>();
  bool _loading = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    categories = getCategories();
    getNews();
  }

  getNews() async {
    News newsClass = News();
    await newsClass.getNews();
    articles = newsClass.news;
    setState(() {
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: <Widget>[
            UserAccountsDrawerHeader(

              accountName: Text("Rakesh Singh Rawat"),
              accountEmail: Text("rakeshrawat456@gmail.com"),
              currentAccountPicture: CircleAvatar(
                backgroundImage: new AssetImage('images/sgrrlogo.jpg'),
              ),
            ),
            ListTile(

              leading: Icon(Icons.home),
              title: Text("Home"),
              onTap: (
                  ) {
                setState(() {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Home()),
                  );
                });
              },
            ),

            ListTile(
              leading: Icon(Icons.contacts),
              title: Text("Contact Us"),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AboutUs()),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.exit_to_app),
              title: Text("Exit"),
              onTap: () {
                SystemChannels.platform.invokeMethod('SystemNavigator.pop');

              },
            ),
          ],
        ),
      ),
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Flutter'),
            Text(
              'News',
              style: TextStyle(color: Colors.blue),
            )
          ],
        ),
        elevation: 0.0,
        centerTitle: true,
      ),
      body: _loading
          ? Center(
              child: Container(
                child: CircularProgressIndicator(),
              ),
            )
          : Container(
              margin: EdgeInsets.only(left: 5, right: 5),
              child: Column(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(bottom: 10),
                    height: 80,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      padding: EdgeInsets.only(bottom: 15),
                      itemCount: categories.length,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return CategoryTile(
                          imageUrl: categories[index].imageUrl,
                          categoryname: categories[index].categoryName,
                        );
                      },
                    ),
                  ),
                  Flexible(
                    child: Container(
                      child: ListView.builder(
                        itemCount: articles.length,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return BlogTile(
                              articles[index].urlToImage,
                              articles[index].title,
                              articles[index].description,
                              articles[index].url);
                        },
                      ),
                    ),
                  )
                ],
              )),
    );
  }
}

class CategoryTile extends StatelessWidget {
  final imageUrl, categoryname;

  CategoryTile({this.imageUrl, this.categoryname});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => CategoryNews(
                      category: categoryname.toString().toLowerCase(),
                    )));
      },
      child: Container(
        margin: EdgeInsets.only(right: 10),
        child: Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(7),
              child: CachedNetworkImage(
                imageUrl: imageUrl,
                width: 120,
                height: 160,
                fit: BoxFit.cover,
              ),
            ),
            Container(
              alignment: Alignment.center,
              width: 120,
              height: 160,
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(7)),
              child: Text(
                categoryname,
                style: TextStyle(color: Colors.white),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class BlogTile extends StatelessWidget {
  final String imageUrl, title, desc, url;

  BlogTile(@required this.imageUrl, @required this.title, @required this.desc,
      @required this.url);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(
          builder: (context) {
            return ArticleView(
              blogUrl: url,
            );
          },
        ));
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 20),
        child: Column(
          children: [
            ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(imageUrl)),
            SizedBox(height: 8),
            Text(title,
                style: TextStyle(
                    fontWeight: FontWeight.w500,
                    color: Colors.black87,
                    fontSize: 17)),
            SizedBox(
              height: 5,
            ),
            Text(
              desc,
              style: TextStyle(color: Colors.black54),
            )
          ],
        ),
      ),
    );
  }
}



