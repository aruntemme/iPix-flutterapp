import 'package:wallpaperapp/models/categorie_model.dart';

String apiKEY = "563492ad6f91700001000001c5424b5350314035ada09b77deb87932";

List<CategorieModel> getCategories() {
  List<CategorieModel> categories = new List();
  CategorieModel categorieModel = new CategorieModel();

  //

  categorieModel.imgUrl =
      "https://images.pexels.com/photos/917494/pexels-photo-917494.jpeg?auto=compress&cs=tinysrgb&dpr=2&w=500";
  categorieModel.categorieName = "Nature";
  categories.add(categorieModel);
  categorieModel = new CategorieModel();

  //
  categorieModel.imgUrl =
      "https://images.pexels.com/photos/373912/pexels-photo-373912.jpeg?auto=compress&cs=tinysrgb&dpr=2&w=500";
  categorieModel.categorieName = "City";
  categories.add(categorieModel);
  categorieModel = new CategorieModel();

  //
  categorieModel.imgUrl =
      "https://images.pexels.com/photos/3028961/pexels-photo-3028961.jpeg?auto=compress&cs=tinysrgb&dpr=2&w=500";
  categorieModel.categorieName = "Minimal";
  categories.add(categorieModel);
  categorieModel = new CategorieModel();

  //
  categorieModel.imgUrl =
      "https://images.pexels.com/photos/1149831/pexels-photo-1149831.jpeg?auto=compress&cs=tinysrgb&dpr=2&w=500";
  categorieModel.categorieName = "Cars";
  categories.add(categorieModel);
  categorieModel = new CategorieModel();

  categorieModel.imgUrl =
      "https://images.pexels.com/photos/3690511/pexels-photo-3690511.jpeg?auto=compress&cs=tinysrgb&dpr=2&w=500";
  categorieModel.categorieName = "Wildlife";
  categories.add(categorieModel);
  categorieModel = new CategorieModel();

  //
  categorieModel.imgUrl =
      "https://images.pexels.com/photos/1935370/pexels-photo-1935370.jpeg?&fm=jpg?auto=compress&cs=tinysrgb&h=750&w=1260";
  categorieModel.categorieName = "Motivation";

  categories.add(categorieModel);
  categorieModel = new CategorieModel();

  //
  categorieModel.imgUrl =
      "https://images.pexels.com/photos/2150/sky-space-dark-galaxy.jpg?auto=compress&cs=tinysrgb&dpr=2&w=500";
  categorieModel.categorieName = "Galaxy";
  categories.add(categorieModel);
  categorieModel = new CategorieModel();

  categorieModel.imgUrl =
  "https://images.pexels.com/photos/1440403/pexels-photo-1440403.jpeg?auto=compress&cs=tinysrgb&dpr=2&w=500";
  categorieModel.categorieName = "Cats";
  categories.add(categorieModel);
  categorieModel = new CategorieModel();

  categorieModel.imgUrl =
      "https://images.pexels.com/photos/1108099/pexels-photo-1108099.jpeg?auto=compress&cs=tinysrgb&dpr=2&w=500";
  categorieModel.categorieName = "Dogs";
  categories.add(categorieModel);
  categorieModel = new CategorieModel();


  return categories;
}
