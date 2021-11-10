import 'dart:convert';

import 'package:collection/collection.dart';

import 'class_data_model.dart';
import 'parent_data_model.dart';

class UMLProject {
  String type;
  String id;
  String name;
  List<UMLModel> ownedElements;
  UMLProject({
    required this.type,
    required this.id,
    required this.name,
    required this.ownedElements,
  });

  UMLProject copyWith({
    String? type,
    String? id,
    String? name,
    List<UMLModel>? ownedElements,
  }) {
    return UMLProject(
      type: type ?? this.type,
      id: id ?? this.id,
      name: name ?? this.name,
      ownedElements: ownedElements ?? this.ownedElements,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      '_type': type,
      '_id': id,
      'name': name,
      'ownedElements': ownedElements.map((x) => x.toMap()).toList(),
    };
  }

  factory UMLProject.fromMap(Map<String, dynamic> map) {
    return UMLProject(
      type: map['UMLKind'],
      id: map['_id'],
      name: map['name'],
      ownedElements: List<UMLModel>.from(
          map['ownedElements']?.map((x) => UMLModel.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  factory UMLProject.fromJson(String source) =>
      UMLProject.fromMap(json.decode(source));

  @override
  String toString() {
    return 'UMLProject(_type: $type, _id: $id, name: $name, ownedElements: $ownedElements)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    final listEquals = const DeepCollectionEquality().equals;

    return other is UMLProject &&
        other.type == type &&
        other.id == id &&
        other.name == name &&
        listEquals(other.ownedElements, ownedElements);
  }

  @override
  int get hashCode {
    return type.hashCode ^ id.hashCode ^ name.hashCode ^ ownedElements.hashCode;
  }
}

class UMLModel {
  String type;
  String id;
  Parent parent;
  String name;
  List<UMLClass> ownedElements;
  UMLModel({
    required this.type,
    required this.id,
    required this.parent,
    required this.name,
    required this.ownedElements,
  });

  UMLModel copyWith({
    String? type,
    String? id,
    Parent? parent,
    String? name,
    List<UMLClass>? ownedElements,
  }) {
    return UMLModel(
      type: type ?? this.type,
      id: id ?? this.id,
      parent: parent ?? this.parent,
      name: name ?? this.name,
      ownedElements: ownedElements ?? this.ownedElements,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      '_type': type,
      '_id': id,
      '_parent': parent.toMap(),
      'name': name,
      'ownedElements': ownedElements.map((x) => x.toMap()).toList(),
    };
  }

  factory UMLModel.fromMap(Map<String, dynamic> map) {
    return UMLModel(
      type: map['UMLKind'],
      id: map['_id'],
      parent: Parent.fromMap(map['_parent']),
      name: map['name'],
      ownedElements: List<UMLClass>.from(
          map['ownedElements']?.map((x) => UMLClass.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  factory UMLModel.fromJson(String source) =>
      UMLModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'UMLModel(_type: $type, _id: $id, _parent: $parent, name: $name, ownedElements: $ownedElements)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    final listEquals = const DeepCollectionEquality().equals;

    return other is UMLModel &&
        other.type == type &&
        other.id == id &&
        other.parent == parent &&
        other.name == name &&
        listEquals(other.ownedElements, ownedElements);
  }

  @override
  int get hashCode {
    return type.hashCode ^
        id.hashCode ^
        parent.hashCode ^
        name.hashCode ^
        ownedElements.hashCode;
  }
}
