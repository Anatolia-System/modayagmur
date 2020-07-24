class Category {
  int id;
  String name;
  String image;
  bool isSelected;
  Category({this.id, this.name, this.isSelected = true, this.image});

  Category.fromJson(Map<String, dynamic> json) {
    name = json['name'] as String;
    id = int.parse(json['id']);
    isSelected = false;
  }
}
