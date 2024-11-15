enum Types {
  CLAIM,
  SUGGESTION,
  INFORMATION
}

extension TypesExtension on Types {
  String get name {
    switch (this) {
      case Types.CLAIM:
        return 'CLAIM';
      case Types.SUGGESTION:
        return 'SUGGESTION';
      case Types.INFORMATION:
        return 'INFORMATION';
      default:
        return '';
    }
  }

  static Types fromString(String type) {
    switch (type) {
      case 'CLAIM':
        return Types.CLAIM;
      case 'SUGGESTION':
        return Types.SUGGESTION;
      case 'INFORMATION':
        return Types.INFORMATION;
      default:
        throw Exception('Invalid type: $type');
    }
  }

  int get index {
    return this.index;
  }

  static Types fromIndex(int index) {
    return Types.values[index];
  }

  static List<String> get names {
    return Types.values.map((type) => type.name).toList();
  }

  static bool isValid(String type) {
    return Types.values.any((element) => element.name == type);
  }
}