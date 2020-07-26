import 'package:wallpaperapp/models/categorie_model.dart';

String apiKEY = "563492ad6f91700001000001c5424b5350314035ada09b77deb87932";

List<CategorieModel> getCategories() {
  List<CategorieModel> categories = new List();
  CategorieModel categorieModel = new CategorieModel();

  //
  categorieModel.imgUrl =
      "https://images.pexels.com/photos/3690511/pexels-photo-3690511.jpeg?auto=compress&cs=tinysrgb&dpr=2&w=900";
  categorieModel.categorieName = "Animals";
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
      "https://images.pexels.com/photos/34950/pexels-photo.jpg?auto=compress&cs=tinysrgb&dpr=2&w=500";
  categorieModel.categorieName = "Nature";
  categories.add(categorieModel);
  categorieModel = new CategorieModel();

  //
  categorieModel.imgUrl =
      "https://images.pexels.com/photos/466685/pexels-photo-466685.jpeg?auto=compress&cs=tinysrgb&dpr=2&w=500";
  categorieModel.categorieName = "City";
  categories.add(categorieModel);
  categorieModel = new CategorieModel();

  //
  categorieModel.imgUrl =
      "https://images.pexels.com/photos/1434819/pexels-photo-1434819.jpeg?auto=compress&cs=tinysrgb&h=750&w=1260";
  categorieModel.categorieName = "Motivation";

  categories.add(categorieModel);
  categorieModel = new CategorieModel();

  //
  categorieModel.imgUrl =
      "https://images.pexels.com/photos/2150/sky-space-dark-galaxy.jpg?auto=compress&cs=tinysrgb&dpr=2&w=500";
  categorieModel.categorieName = "Galaxy";
  categories.add(categorieModel);
  categorieModel = new CategorieModel();

  //
  categorieModel.imgUrl =
      "https://images.pexels.com/photos/1149137/pexels-photo-1149137.jpeg?auto=compress&cs=tinysrgb&dpr=2&w=500";
  categorieModel.categorieName = "Cars";
  categories.add(categorieModel);
  categorieModel = new CategorieModel();

  categorieModel.imgUrl =
  "https://images.pexels.com/photos/1108099/pexels-photo-1108099.jpeg?auto=compress&cs=tinysrgb&dpr=2&w=500";
  categorieModel.categorieName = "Dogs";
  categories.add(categorieModel);
  categorieModel = new CategorieModel();

  return categories;
}
