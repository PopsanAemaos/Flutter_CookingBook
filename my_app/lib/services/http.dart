import 'package:my_app/models/recipe.dart';
import 'dart:convert';
import 'package:http/http.dart';

class HttpService {
    final String recipeUrl = "http://localhost:3030/recipe";
    
    Future<List<Recipe>> getRecipe() async {
      Response res = await get(recipeUrl);
      if(res.statusCode == 200){
        List<dynamic> body = jsonDecode(res.body);

        print(body);
        List<Recipe> recipe = 
            body.map((dynamic item) => Recipe.fromJson(item)).toList();
        print(recipe);
        print('recipe');
        return recipe;
      } else {
        throw "can't get recipe";
      }
    }
}