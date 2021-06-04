import 'package:my_app/models/recipe.dart';
import 'dart:convert';
import 'package:http/http.dart';

class HttpService {
  final String recipeUrl = "http://localhost:30301";

  Future<List<Recipe>> getRecipe() async {
    Response res = await get("$recipeUrl/recipe");
    if (res.statusCode == 200) {
      List<dynamic> body = jsonDecode(res.body);
      List<Recipe> recipe =
          body.map((dynamic item) => Recipe.fromJson(item)).toList();
      return recipe;
    } else {
      throw "can't get recipe";
    }
  }
// https://storage.googleapis.com/another_pic/12.jpeg
  Future<List<Recipe>> findRecipe(String name) async {
    Response res = await get("$recipeUrl/findrecipe?name=$name");
    if (res.statusCode == 200) {
      List<dynamic> body = jsonDecode(res.body);
      List<Recipe> recipe =
          body.map((dynamic item) => Recipe.fromJson(item)).toList();
      return recipe;
    } else {
      throw "can't get recipe";
    }
  }

    Future<List<Recipe>> findRecipeByUser(String data) async {
    Response res = await get("$recipeUrl/findrecipeuser?user_id=$data");
    if (res.statusCode == 200) {
      List<dynamic> body = jsonDecode(res.body);
      List<Recipe> recipe =
          body.map((dynamic item) => Recipe.fromJson(item)).toList();
      return recipe;
    } else {
      throw "can't get recipe";
    }
  }


  Future<void> deleteRecipe(String id) async {
    print(id);
    Response res = await get("$recipeUrl/deleteRecipe?recipe_id=$id");
    if (res.statusCode == 200) {
      print('Deleted');
    } else {
      throw "can't get recipe";
    }
  }
}
