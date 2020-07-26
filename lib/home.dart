import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';
import 'package:wallpaperapp/data/data.dart';
import 'dart:convert';
import 'package:wallpaperapp/models/categorie_model.dart';
import 'package:wallpaperapp/models/photos_model.dart';
import 'package:wallpaperapp/view/categorie_screen.dart';
import 'package:wallpaperapp/view/search_view.dart';
import 'package:wallpaperapp/widget/widget.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<CategorieModel> categories = new List();

  int noOfImageToLoad = 30;
  List<PhotosModel> photos = new List();

  getTrendingWallpaper() async {
    await http.get(
        "https://api.pexels.com/v1/curated?per_page=30&query=cats&page=1",
        headers: {"Authorization": apiKEY}).then((value) {
      //print(value.body);

      Map<String, dynamic> jsonData = jsonDecode(value.body);
      jsonData["photos"].forEach((element) {
        //print(element);
        PhotosModel photosModel = new PhotosModel();
        photosModel = PhotosModel.fromMap(element);
        photos.add(photosModel);
        //print(photosModel.toString()+ "  "+ photosModel.src.portrait);
      });

      setState(() {});
    });
  }

  TextEditingController searchController = new TextEditingController();

  ScrollController _scrollController = new ScrollController();

  @override
  void initState() {
    //getWallpaper();
    getTrendingWallpaper();
    categories = getCategories();
    super.initState();

    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        noOfImageToLoad = noOfImageToLoad + 30;
        getTrendingWallpaper();
      }
    });
  }

  _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: Column(
          children: <Widget>[
            DrawerHeader(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        "Made By ",
                        style: TextStyle(
                            color: Colors.black54,
                            fontSize: 12,
                            fontFamily: 'Overpass'),
                      ),
                      GestureDetector(
                        onTap: () {
                          _launchURL("https://www.github.com/aruntemme/");
                        },
                        child: Container(
                            child: Text(
                              "Arun",
                              style: TextStyle(
                                  color: Colors.blue,
                                  fontSize: 12,
                                  fontFamily: 'Overpass'),
                            )),
                      ),
                    ],
                  ),
                ],
              ),
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
            ),
            Text(
              "Categories",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontFamily: 'Overpass'),
            ),
            SizedBox(
              height: 16,
            ),
            Expanded(
              child: ListView.builder(
                  padding: EdgeInsets.all(10.0),
                  itemCount: categories.length,
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  itemBuilder: (context, index) {
                    /// Create List Item tile
                    return CategoriesTile(
                      imgUrls: categories[index].imgUrl,
                      categorie: categories[index].categorieName,
                    );
                  }),
            ),
          ],
        ),
      ),
      appBar: AppBar(
        title: brandName(),
        elevation: 0.0,
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 16,
              ),
              Container(
                decoration: BoxDecoration(
                  color: Color(0xfff5f8fd),
                  borderRadius: BorderRadius.circular(30),
                ),
                margin: EdgeInsets.symmetric(horizontal: 24),
                padding: EdgeInsets.symmetric(horizontal: 24),
                child: Row(
                  children: <Widget>[

                    Expanded(
                        child: TextField(
                      controller: searchController,
                      decoration: InputDecoration(
                          hintText: "search wallpapers",
                          border: InputBorder.none),
                    )),
                    InkWell(
                        onTap: () {
                          if (searchController.text != "") {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => SearchView(
                                          search: searchController.text,
                                        )));
                          }
                        },
                        child: Container(child: Icon(Icons.search)))
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),


              wallPaper(photos, context),
              SizedBox(
                height: 24,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    "Photos provided By ",
                    style: TextStyle(
                        color: Colors.black54,
                        fontSize: 12,
                        fontFamily: 'Overpass'),
                  ),
                  GestureDetector(
                    onTap: () {
                      _launchURL("https://www.pexels.com/");
                    },
                    child: Container(
                        child: Text(
                      "Pexels",
                      style: TextStyle(
                          color: Colors.blue,
                          fontSize: 12,
                          fontFamily: 'Overpass'),
                    )),
                  )
                ],
              ),
              SizedBox(
                height: 24,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CategoriesTile extends StatelessWidget {
  final String imgUrls, categorie;

  CategoriesTile({@required this.imgUrls, @required this.categorie});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => CategorieScreen(
                      categorie: categorie,
                    )));
      },
      child: Container(
        margin: EdgeInsets.only(right: 8,bottom: 15),
        child: kIsWeb
            ? Column(
                children: <Widget>[
                  ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: kIsWeb
                          ? Image.network(
                              imgUrls,
                              height:150,
                              width: 300,
                              fit: BoxFit.cover,
                            )
                          : CachedNetworkImage(
                              imageUrl: imgUrls,
                              height: 150,
                              width: 300,
                              fit: BoxFit.cover,
                            )),
                  SizedBox(
                    height: 4,
                  ),
                  Container(
                      width: 300,
                      alignment: Alignment.center,
                      child: Text(
                        categorie,
                        style: TextStyle(
                            color: Colors.black54,
                            fontSize: 13,
                            fontWeight: FontWeight.w400,
                            fontFamily: 'Overpass'),
                      )),
                ],
              )
            : Stack(
                children: <Widget>[
                  ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: kIsWeb
                          ? Image.network(
                              imgUrls,
                              height: 150,
                              width: 300,
                              fit: BoxFit.cover,
                            )
                          : CachedNetworkImage(
                              imageUrl: imgUrls,
                              height: 150,
                              width: 300,
                              fit: BoxFit.cover,
                            )),
                  Container(
                    height: 150,
                    width: 300,
                    decoration: BoxDecoration(
                      color: Colors.black26,
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  Container(
                      height: 150,
                      width: 300,
                      alignment: Alignment.center,
                      child: Text(
                        categorie ?? "Yo Yo",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                            fontFamily: 'Overpass'),
                      ))
                ],
              ),
      ),
    );
  }
}
