enum SpeedDialDirection { Up, Down, Left, Right }

extension EnumExtension on SpeedDialDirection {
  /// Get Value of The SpeedDialDirection Enum like Up, Down, etc. in String format
  String get value => toString().split(".")[1];
}