import '../parent_data_model.dart';

abstract class Relation {
  late String type;
  late String id;
  late Parent parent;
  late Parent source;
  late Parent target;

  Relation(
      {required this.type,
      required this.id,
      required this.parent,
      required this.source,
      required this.target});
}
