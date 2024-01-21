class ContactModel {
  List<Results>? contact;

  ContactModel({List<Results>? results}) {
    if (results != null) {
      contact = results;
    }
  }

  List<Results>? get results => contact;
  set results(List<Results>? results) => contact = results;

  ContactModel.fromJson(Map<String, dynamic> json) {
    if (json['results'] != null) {
      contact = <Results>[];
      json['results'].forEach((v) {
        contact!.add(Results.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (contact != null) {
      data['results'] = contact!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Results {
  String? _name;
  int? _number;
  String? _imagePath;

  Results({String? name, int? number, String? imagePath}) {
    if (name != null) {
      _name = name;
    }
    if (number != null) {
      _number = number;
    }
    if (imagePath != null) {
      _imagePath = imagePath;
    }
  }

  String? get name => _name;
  set name(String? name) => _name = name;
  int? get number => _number;
  set number(int? number) => _number = number;
  String? get imagePath => _imagePath;
  set imagePath(String? imagePath) => _imagePath = imagePath;

  Results.fromJson(Map<String, dynamic> json) {
    _name = json['name'];
    _number = json['number'];
    _imagePath = json['imagePath'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = _name;
    data['number'] = _number;
    data['imagePath'] = _imagePath;
    return data;
  }
}
