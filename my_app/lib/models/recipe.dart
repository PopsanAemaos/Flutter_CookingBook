class Recipe {
  final String id;
  final String title;
  final List  ingredient;
  final List  method;
  final String description;
  final String images;
  final String userId;

  Recipe({
    this.id,
    this.title,
    this.ingredient,
    this.method,
    this.description,
    this.userId,
    this.images
  });

  factory Recipe.fromJson(Map<String, dynamic> json){
    return Recipe(
      id: json['_id'] as String,
      title: json['title'] as String,
      ingredient: json['ingredient'] as List,
      method: json['method'] as List,
      description: json['descripttion'] as String,
      userId: json['user_id'] as String,
      images: json['images'] as String
    );
  }
}
