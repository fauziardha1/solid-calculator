import 'dart:convert';

import 'parent_data_model.dart';

class UMLAttribute {
  String type;
  String id;
  Parent parent;
  String name;
  String visibility;
  String dataType;
  UMLAttribute({
    required this.type,
    required this.id,
    required this.parent,
    required this.name,
    required this.visibility,
    required this.dataType,
  });

  UMLAttribute copyWith({
    String? type,
    String? id,
    Parent? parent,
    String? name,
    String? visibility,
    String? dataType,
  }) {
    return UMLAttribute(
      type: type ?? this.type,
      id: id ?? this.id,
      parent: parent ?? this.parent,
      name: name ?? this.name,
      visibility: visibility ?? this.visibility,
      dataType: dataType ?? this.dataType,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      '_type': type,
      '_id': id,
      '_parent': parent.toMap(),
      'name': name,
      'visibility': visibility,
      'type': dataType,
    };
  }

  factory UMLAttribute.fromMap(Map<String, dynamic> map) {
    return UMLAttribute(
      type: (map['UMLKind'] ?? ''),
      id: map['_id'],
      parent: Parent.fromMap(map['_parent']),
      name: map['name'],
      visibility: (map['visibility'] ?? '') as String,
      dataType: map['type'].toString(),
    );
  }

  String toJson() => json.encode(toMap());

  factory UMLAttribute.fromJson(String source) =>
      UMLAttribute.fromMap(json.decode(source));

  @override
  String toString() {
    return 'UMLAttribute(_type: $type, _id: $id, _parent: $parent, name: $name, visibility: $visibility, type: $dataType)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is UMLAttribute &&
        other.type == type &&
        other.id == id &&
        other.parent == parent &&
        other.name == name &&
        other.visibility == visibility &&
        other.dataType == dataType;
  }

  @override
  int get hashCode {
    return type.hashCode ^
        id.hashCode ^
        parent.hashCode ^
        name.hashCode ^
        visibility.hashCode ^
        dataType.hashCode;
  }
}
