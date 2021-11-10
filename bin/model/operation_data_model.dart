import 'dart:convert';

import 'package:collection/collection.dart';
import 'parameter_data_model.dart';
import 'parent_data_model.dart';

class UMLOperation {
  String type;
  String id;
  Parent parent;
  String name;
  List<UMLParameter> parameters;
  UMLOperation({
    required this.type,
    required this.id,
    required this.parent,
    required this.name,
    required this.parameters,
  });

  UMLOperation copyWith({
    String? type,
    String? id,
    Parent? parent,
    String? name,
    List<UMLParameter>? parameters,
  }) {
    return UMLOperation(
      type: type ?? this.type,
      id: id ?? this.id,
      parent: parent ?? this.parent,
      name: name ?? this.name,
      parameters: parameters ?? this.parameters,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      '_type': type,
      '_id': id,
      '_parent': parent.toMap(),
      'name': name,
      'parameters': parameters.map((x) => x.toMap()).toList(),
    };
  }

  factory UMLOperation.fromMap(Map<String, dynamic> map) {
    return UMLOperation(
      type: map['UMLKind'],
      id: map['_id'],
      parent: Parent.fromMap(map['_parent']),
      name: map['name'],
      parameters: map['parameters'] == null
          ? <UMLParameter>[]
          : List<UMLParameter>.from(
              map['parameters']?.map((x) => UMLParameter.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  factory UMLOperation.fromJson(String source) =>
      UMLOperation.fromMap(json.decode(source));

  @override
  String toString() {
    return 'UMLOperation(_type: $type, _id: $id, _parent: $parent, name: $name, parameters: $parameters)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    final listEquals = const DeepCollectionEquality().equals;

    return other is UMLOperation &&
        other.type == type &&
        other.id == id &&
        other.parent == parent &&
        other.name == name &&
        listEquals(other.parameters, parameters);
  }

  @override
  int get hashCode {
    return type.hashCode ^
        id.hashCode ^
        parent.hashCode ^
        name.hashCode ^
        parameters.hashCode;
  }
}
