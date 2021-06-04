import 'package:flutter/material.dart';
import 'package:my_app/models/recipe.dart';
import 'package:my_app/services/http.dart';

class Detail extends StatelessWidget {
  final Recipe recipe;
  final HttpService httpService = HttpService();

  Detail({this.recipe});

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: AppBar(),
        // floatingActionButton: FloatingActionButton(
        //   child: Icon(Icons.delete),
        //     onPressed: () async {
        //       await httpService.deleteRecipe(recipe.id);
        //       Navigator.of(context).pop();
        //     },
        // ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Card(
              child: Column(
                children: <Widget>[
                  SizedBox(height: 20.0),
                  Container(
                    height: 200.0,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                      image: NetworkImage(recipe.images),
                    )),
                  ),
                  Text(
                    recipe.title,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.black,
                        fontFamily: 'Quicksand',
                        fontSize: 22.0,
                        fontWeight: FontWeight.bold),
                  ),
                  ListTile(
                      title: Text("Description"),
                      subtitle: Text(recipe.description)),
                  ListTile(title: Text("วัตถุดิบ")),
                  Padding(
                    // left=10, top= 0, right = 2, bottom = 20)
                    padding: const EdgeInsets.fromLTRB(20, 0, 5, 0),
                    child: Container(
                      height: 150.0,
                      child: ListView.builder(
                          itemCount: recipe.ingredient.length,
                          itemBuilder: (context, index) {
                            var item = recipe.ingredient[index];
                            return Text("$item", softWrap: true);
                          }),
                    ),
                  ),
                  ListTile(title: Text("วิธีการทำ")),
                  Padding(
                    // left=10, top= 0, right = 2, bottom = 20)
                    padding: const EdgeInsets.fromLTRB(20, 0, 5, 10),
                    child: Container(
                      height: 200.0,
                      child: ListView.builder(
                          itemCount: recipe.method.length,
                          itemBuilder: (context, index) {
                            var item = recipe.method[index];
                            return Text("$item", softWrap: true);
                          }),
                    ),
                  )
                ],
              ),
            ),
          ),
        ));
  }
}
