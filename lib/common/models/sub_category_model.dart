class SubCategoryModel {
  int? totalSize;
  int? limit;
  int? offset;
  List<SubCategories>? subCategoriesList;


  SubCategoryModel.fromJson(Map<String, dynamic> json) {
    totalSize = int.tryParse('${json['total']}');
    limit = int.parse(json['limit']);
    offset = int.parse(json['offset']);
    if (json['subCategories'] != null) {
      subCategoriesList = <SubCategories>[];
      json['subCategories'].forEach((v) {
        subCategoriesList!.add(SubCategories.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['total'] = totalSize;
    data['limit'] = limit;
    data['offset'] = offset;
    if (subCategoriesList != null) {
      data['subCategories'] =
          subCategoriesList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class SubCategories {
  int? _id;
  String? _name;
  int? _parentId;
  int? _position;
  int? _status;
  String? _image;
  String? _createdAt;
  String? _updatedAt;


  SubCategories(
      {int? id,
        String? name,
        int? parentId,
        int? position,
        int? status,
        String? image,
        String? createdAt,
        String? updatedAt}) {
    if (id != null) {
      _id = id;
    }
    if (name != null) {
      _name = name;
    }
    if (parentId != null) {
      _parentId = parentId;
    }
    if (position != null) {
      _position = position;
    }
    if (status != null) {
      _status = status;
    }
    if (image != null) {
      _image = image;
    }
    if (createdAt != null) {
      _createdAt = createdAt;
    }
    if (updatedAt != null) {
      _updatedAt = updatedAt;
    }

  }

  int? get id => _id;
  String? get name => _name;
  int? get parentId => _parentId;
  int? get position => _position;
  int? get status => _status;
  String? get image => _image;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;

  SubCategories.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _name = json['name'];
    if(json['parent_id'] != null){
      _parentId = int.parse(json['parent_id'].toString());
    }

    if(json['position'] != null){
      _position = int.parse(json['position'].toString());
    }
    if(json['status'] != null){
      _status = int.parse(json['status'].toString());
    }

    _image = json['image'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = _id;
    data['name'] = _name;
    data['parent_id'] = _parentId;
    data['position'] = _position;
    data['status'] = _status;
    data['image'] = _image;
    data['created_at'] = _createdAt;
    data['updated_at'] = _updatedAt;

    return data;
  }
}
