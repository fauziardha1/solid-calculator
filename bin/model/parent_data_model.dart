import 'dart:convert';

// Implement start from small component

class Parent {
  late String ref;
  Parent({
    required this.ref,
  });

  Parent copyWith({
    String? ref,
  }) {
    return Parent(
      ref: ref ?? this.ref,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      r"$" + "ref": ref,
    };
  }

  factory Parent.fromMap(Map<String, dynamic> map) {
    return Parent(
      ref: map[r"$" + "ref"] ?? "" as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Parent.fromJson(String source) => Parent.fromMap(json.decode(source));

  @override
  String toString() => 'Parent(ref: $ref)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Parent && other.ref == ref;
  }

  @override
  int get hashCode => ref.hashCode;
}
