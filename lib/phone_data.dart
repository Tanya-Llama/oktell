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

//   factory ServiceUnit.fromJson(Map<String, dynamic> json) {
//     return ServiceUnit(
//       phone: json['phone']
//     );
//   }
// }
//
// class ServiceData {
//   final List<ServiceUnit> list;
//
//   ServiceData({
//     required this.list,
//   });
//
//   factory ServiceData.fromJson(List<dynamic> jsc) {
//     return ServiceData(
//       list: List<ServiceUnit>.generate(
//           jsc.length, (index) => ServiceUnit.fromJson(jsc[index])
//       ),
//     );
//   }
 }