class Contact {
  String name;
  bool isFavorite;
  Contact({this.name}) : isFavorite = false;

  Contact.fromJson(Map<String, dynamic> json) {
    this.name = json["name"];
    this.isFavorite = json["isFavorite"];
  }
}
