import 'package:my_app/models/recipe.dart';
import 'dart:convert';
import 'package:http/http.dart';

class HttpService {
  final String recipeUrl = "http://localhost:3030";

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

  // Future<List<Recipe>> getRecipe() async {
  //   Response res = await get("$recipeUrl/recipe/user_id=");
  //   if(res.statusCode == 200){
  //     List<dynamic> body = jsonDecode(res.body);

  //     print(body);
  //     List<Recipe> recipe =
  //         body.map((dynamic item) => Recipe.fromJson(item)).toList();
  //     print(recipe);
  //     print('recipe');
  //     return recipe;
  //   } else {
  //     throw "can't get recipe";
  //   }
  // }

  Future<void> deleteRecipe(String id) async {
    Response res = await get(recipeUrl);
    if (res.statusCode == 200) {
      print('Deleted');
    } else {
      throw "can't get recipe";
    }
  }
}
