class Song {

  late int _id;
  late String _name;

  Song(this._name);

  Song.fromMap(dynamic obj) {
    this._name = obj['name'];
  }

  int get id => _id;
  String get name => _name;
  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();
    map["name"] = _name;
    return map;
  }

}