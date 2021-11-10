import 'dart:convert';

import 'parent_data_model.dart';

class UMLParameter {
  late String type;
  late String id;
  late Parent parent;
  late String name;
  late String dataType;
  UMLParameter({
    required this.type,
    required this.id,
    required this.parent,
    required this.name,
    required this.dataType,
  });

  UMLParameter copyWith({
    String? type,
    String? id,
    Parent? parent,
    String? name,
    String? dataType,
  }) {
    return UMLParameter(
      type: type ?? this.type,
      id: id ?? this.id,
      parent: parent ?? this.parent,
      name: name ?? this.name,
      dataType: dataType ?? this.dataType,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      '_type': type,
      '_id': id,
      '_parent': parent,
      'name': name,
      'type': dataType,
    };
  }

  factory UMLParameter.fromMap(Map<String, dynamic> map) {
    return UMLParameter(
      type: map['UMLKind'] as String,
      id: map['_id'] as String,
      parent: Parent.fromMap(map['_parent']),
      name: (map['name'] ?? '') as String,
      dataType: (map['type']?.toString() ?? ''),
    );
  }

  String toJson() => json.encode(toMap());

  factory UMLParameter.fromJson(String source) =>
      UMLParameter.fromMap(json.decode(source));

  @override
  String toString() {
    return 'UMLParameter(_type: $type, _id: $id, _parent: $parent, name: $name, type: $dataType)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is UMLParameter &&
        other.type == type &&
        other.id == id &&
        other.parent == parent &&
        other.name == name &&
        other.dataType == dataType;
  }

  @override
  int get hashCode {
    return type.hashCode ^
        id.hashCode ^
        parent.hashCode ^
        name.hashCode ^
        dataType.hashCode;
  }
}
