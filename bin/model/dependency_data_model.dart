import 'dart:convert';

import 'parent_data_model.dart';
import 'source_data_model.dart';
import 'target_data_model.dart';

class UMLDependency {
  String type;
  String id;
  Parent parent;
  String name;
  UMLSource source;
  UMLTarget target;
  UMLDependency({
    required this.type,
    required this.id,
    required this.parent,
    required this.name,
    required this.source,
    required this.target,
  });

  UMLDependency copyWith({
    String? type,
    String? id,
    Parent? parent,
    String? name,
    UMLSource? source,
    UMLTarget? target,
  }) {
    return UMLDependency(
      type: type ?? this.type,
      id: id ?? this.id,
      parent: parent ?? this.parent,
      name: name ?? this.name,
      source: source ?? this.source,
      target: target ?? this.target,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      '_type': type,
      '_id': id,
      '_parent': parent.toMap(),
      'name': name,
      'source': source.toMap(),
      'target': target.toMap(),
    };
  }

  factory UMLDependency.fromMap(Map<String, dynamic> map) {
    return UMLDependency(
      type: map['UMLKind'],
      id: map['_id'],
      parent: Parent.fromMap(map['_parent']),
      name: (map['name'] ?? '') as String,
      source: UMLSource.fromMap(map['source']),
      target: UMLTarget.fromMap(map['target']),
    );
  }

  String toJson() => json.encode(toMap());

  factory UMLDependency.fromJson(String source) =>
      UMLDependency.fromMap(json.decode(source));

  @override
  String toString() {
    return 'UMLDependency(_type: $type, _id: $id, _parent: $parent, name: $name, source: $source, target: $target)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is UMLDependency &&
        other.type == type &&
        other.id == id &&
        other.parent == parent &&
        other.name == name &&
        other.source == source &&
        other.target == target;
  }

  @override
  int get hashCode {
    return type.hashCode ^
        id.hashCode ^
        parent.hashCode ^
        name.hashCode ^
        source.hashCode ^
        target.hashCode;
  }
}
