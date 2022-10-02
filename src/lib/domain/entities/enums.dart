enum OrderDirection {
  ascending,
  descending,
}

extension OrderDirectionExtension on String {
  OrderDirection? toOrderDirection() {
    switch (this) {
      case 'OrderDirection.ascending':
        return OrderDirection.ascending;
      case 'OrderDirection.descending':
        return OrderDirection.descending;
      default:
        return null;
    }
  }
}