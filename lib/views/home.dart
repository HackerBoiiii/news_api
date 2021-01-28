import 'package:flutter/material.dart';
import 'package:news_api/helper/data.dart';
import 'package:news_api/models/category_model.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<CategoryModel> categories= new List<CategoryModel>();


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
categories=getCategories();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Flutter'),
            Text('News',style: TextStyle(
              color: Colors.blue
            ),)
          ],
        ),
        elevation: 0.0,
        centerTitle: true,
      ),
      body: Container(

        child: Column(

          children: <Widget>[
            Container(

              height: 70,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: categories.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return CategoryTile(
                      imageUrl: categories[index].imageUrl,
                      categoryname: categories[index].categoryName,
                    );
                  },
              ),
            )
          ],
        )
      ),

    );
  }
}

class CategoryTile extends StatelessWidget {
  final imageUrl,categoryname;

  CategoryTile({this.imageUrl,this.categoryname});
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 10),
      child: Stack(
        children: [
          ClipRRect(
           borderRadius: BorderRadius.circular(7),
              child: Image.network(imageUrl,width: 120,height: 160, fit: BoxFit.cover,
              ),

          ),
          Container(
            alignment: Alignment.center,
            width: 120,
            height: 160,
            decoration: BoxDecoration(

              borderRadius: BorderRadius.circular(7)
            ),


            child: Text(categoryname,style: TextStyle(
              color: Colors.white
            ),),
          )
        ],
      ),
    );
  }
}
