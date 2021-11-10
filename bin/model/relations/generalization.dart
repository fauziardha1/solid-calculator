import '../parent_data_model.dart';
import 'relation.dart';

class Generalization extends Relation {
  Generalization(
      {required String type,
      required String id,
      required Parent parent,
      required Parent source,
      required Parent target})
      : super(
          type: type,
          id: id,
          parent: parent,
          source: source,
          target: target,
        );

  fromJson(Map<String, dynamic> json) {
    super.type = json['_type'];
    super.id = json['_id'];
    super.parent = Parent.fromMap(json['_parent'] ?? {});
    super.source = Parent.fromMap(json['_parent'] ?? {});
    super.target = Parent.fromMap(json['_parent'] ?? {});
  }
}
