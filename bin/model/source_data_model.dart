import 'dart:convert';

class UMLSource {
  String ref;
  UMLSource({
    required this.ref,
  });

  UMLSource copyWith({
    String? ref,
  }) {
    return UMLSource(
      ref: ref ?? this.ref,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      r"$" + 'ref': ref,
    };
  }

  factory UMLSource.fromMap(Map<String, dynamic> map) {
    return UMLSource(
      ref: map[r"$" + 'ref'],
    );
  }

  String toJson() => json.encode(toMap());

  factory UMLSource.fromJson(String source) =>
      UMLSource.fromMap(json.decode(source));

  @override
  String toString() => r'Source($' + 'ref: $ref)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is UMLSource && other.ref == ref;
  }

  @override
  int get hashCode => ref.hashCode;
}
