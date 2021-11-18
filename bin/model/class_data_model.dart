import 'dart:convert';

import 'package:collection/collection.dart';

import '../SOLID/DIP/mixin_dip.dart';
import '../SOLID/ISP/mixin_isp.dart';
import '../SOLID/LSP/mixin_lsp.dart';
import 'attribute_data_model.dart';
import 'dependency_data_model.dart';
import 'operation_data_model.dart';
import 'parent_data_model.dart';

class UMLClass with LSPAttributes, ISPAttributes, DIPAttributes {
  String type;
  String id;
  Parent parent;
  String name;
  List<UMLOperation> operations;
  List<UMLAttribute> attributes;
  List<UMLDependency> ownedElements;
  bool isAbstract;
  UMLClass({
    required this.type,
    required this.id,
    required this.parent,
    required this.name,
    required this.operations,
    required this.attributes,
    required this.ownedElements,
    required this.isAbstract,
  });

  UMLClass copyWith({
    String? type,
    String? id,
    Parent? parent,
    String? name,
    List<UMLOperation>? operations,
    List<UMLAttribute>? attributes,
    List<UMLDependency>? ownedElements,
    bool? isAbstract,
  }) {
    return UMLClass(
      type: type ?? this.type,
      id: id ?? this.id,
      parent: parent ?? this.parent,
      name: name ?? this.name,
      operations: operations ?? this.operations,
      attributes: attributes ?? this.attributes,
      ownedElements: ownedElements ?? this.ownedElements,
      isAbstract: isAbstract ?? this.isAbstract,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      '_type': type,
      '_id': id,
      '_parent': parent.toMap(),
      'name': name,
      'operations': operations.map((x) => x.toMap()).toList(),
      'attributes': attributes.map((x) => x.toMap()).toList(),
      'ownedElements': ownedElements.map((x) => x.toMap()).toList(),
      'isAbstract': isAbstract,
    };
  }

  factory UMLClass.fromMap(Map<String, dynamic> map) {
    return UMLClass(
      type: map['UMLKind'],
      id: map['_id'],
      parent: Parent.fromMap(map['_parent'] ?? {}),
      name: map['name'] ?? "",
      operations: List<UMLOperation>.from(
          map['operations']?.map((x) => UMLOperation.fromMap(x)) ?? []),
      attributes: List<UMLAttribute>.from(
          map['attributes']?.map((x) => UMLAttribute.fromMap(x)) ?? []),
      ownedElements: List<UMLDependency>.from(
          map['ownedElements']?.map((x) => UMLDependency.fromMap(x)) ?? []),
      isAbstract: map['isAbstract'] ?? false,
    );
  }

  String toJson() => json.encode(toMap());

  factory UMLClass.fromJson(String source) =>
      UMLClass.fromMap(json.decode(source));

  @override
  String toString() {
    return 'UMLClass(_type: $type, _id: $id, _parent: $parent, name: $name, operations: $operations, attributes: $attributes, ownedElements: $ownedElements, isAbstract: $isAbstract)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    final listEquals = const DeepCollectionEquality().equals;

    return other is UMLClass &&
        other.type == type &&
        other.id == id &&
        other.parent == parent &&
        other.name == name &&
        other.isAbstract == isAbstract &&
        listEquals(other.operations, operations) &&
        listEquals(other.attributes, attributes) &&
        listEquals(other.ownedElements, ownedElements);
  }

  @override
  int get hashCode {
    return type.hashCode ^
        id.hashCode ^
        parent.hashCode ^
        name.hashCode ^
        isAbstract.hashCode ^
        operations.hashCode ^
        attributes.hashCode ^
        ownedElements.hashCode;
  }
}
