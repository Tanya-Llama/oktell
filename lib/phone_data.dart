class  ServiceUnit {
  final String phone;

  ServiceUnit(
      {required this.phone,
      });

  @override
  String toString() {
    return "$phone";
  }

  Map<String, dynamic> toJson() {
    return {
      'phone': phone,
    };
  }
 }