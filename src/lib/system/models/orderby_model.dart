import '../../domain/entities/smart_list.dart';

class OrderByModel extends OrderBy {
  const OrderByModel({required super.orderCriteria, required super.orderDirections});

  Map<String, dynamic> toExportMap() => {
    'orderCriteria': orderCriteria.map((e) => e.toString()).toList(),
    'orderDirections': orderDirections.map((e) => e.toString()).toList(),
  };
}
