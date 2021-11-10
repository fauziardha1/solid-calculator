import 'dart:convert';

class UMLTarget {
  String ref;
  UMLTarget({
    required this.ref,
  });

  UMLTarget copyWith({
    String? ref,
  }) {
    return UMLTarget(
      ref: ref ?? this.ref,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      r"$" + 'ref': ref,
    };
  }

  factory UMLTarget.fromMap(Map<String, dynamic> map) {
    return UMLTarget(
      ref: map[r"$" + 'ref'],
    );
  }

  String toJson() => json.encode(toMap());

  factory UMLTarget.fromJson(String source) =>
      UMLTarget.fromMap(json.decode(source));

  @override
  String toString() => r'UMLTarget($' + 'ref: $ref)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is UMLTarget && other.ref == ref;
  }

  @override
  int get hashCode => ref.hashCode;
}
