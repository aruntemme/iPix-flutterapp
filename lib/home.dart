import 'package:cached_network_image/cached_network_image.dart';
import 'package:dynamic_theme/dynamic_theme.dart';
import 'package:flutter/cupertino.dart';
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
import 'package:day_night_switch/day_night_switch.dart';
import 'package:permission_handler/permission_handler.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<CategorieModel> categories = new List();

  int noOfImageToLoad = 30;
  List<PhotosModel> photos = new List();

  var quote = "";

  bool isSwitched = false;

  void toggleTheme() {
    if (Theme.of(context).brightness == Brightness.dark) {
      DynamicTheme.of(context).setBrightness(Brightness.light);
    } else if (Theme.of(context).brightness == Brightness.light)
      DynamicTheme.of(context).setBrightness(Brightness.dark);
  }

  getQuote() {
    var list = [
      "“The supreme happiness of life consists in the conviction that one is loved.”",
      "“We accept the love we think we deserve.”",
      "“Get busy living or get busy dying.”",
      "“If you want to be happy, be.”",
      "“The opposite of love is not hate; it’s indifference.”",
      "“When you reach the end of your rope, tie a knot in it and hang on.“",
      "“Whoever is happy will make others happy too.“",
      "“The purpose of our lives is to be happy.“",
      "“Those who realize their folly are not true fools“"
    ];
    var randomItem = (list..shuffle()).first;
    quote = randomItem;
    return quote;
  }

  permission () async{
    final PermissionHandler _permissionHandler = PermissionHandler();
    var result = await _permissionHandler.requestPermissions(
        [PermissionGroup.storage]);
  }
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


  var dayColor = Color(0xFF51b9ff);
  var nightColor = Color(0xFF1e2230);

  TextEditingController searchController = new TextEditingController();

  ScrollController _scrollController = new ScrollController();

  @override
  void initState() {
    //getWallpaper();
    getTrendingWallpaper();
    getQuote();
    permission();
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
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  SizedBox(
                    height: 1,
                  ),
           Text(
                      quote,
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontFamily: 'Pacifico'),
                    ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      Text(
                        "Made with 💛 by ",
                        style: TextStyle(
                            color: Colors.black,
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
                              color: Colors.white,
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
            Transform.scale(
              scale: 0.45,
              child: DayNightSwitch(
                value: isSwitched,
                dayColor: dayColor,
                nightColor: nightColor,
                onChanged: (val) {
                  toggleTheme();
                  setState(() {
                    isSwitched = val;
                  });
                },
              ),
            ),
            Text("Categories", style: TextStyle(fontSize: 20)),
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
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 16,
              ),
              Container(
                decoration: BoxDecoration(
                  color: Color(0xffb2b2b2),
                  borderRadius: BorderRadius.circular(15),
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
                          hintStyle: TextStyle(),
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
        margin: EdgeInsets.only(right: 8, bottom: 15),
        child: kIsWeb
            ? Column(
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
