class PositionData {
  final int x;
  final int y;

  PositionData({
    required this.x,
    required this.y,
  });

  factory PositionData.fromJson(Map<String, dynamic> json) {
    return PositionData(
      x: json['x'],
      y: json['y'],
    );
  }

  Map<String, String> positionToMap() {
    return {'x': x.toString(), 'y': y.toString()};
  }

  @override
  String toString() {
    return '($x,$y)';
  }
}
