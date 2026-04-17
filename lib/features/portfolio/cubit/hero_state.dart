class HeroState {
  const HeroState({this.nameWidth});

  final double? nameWidth;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HeroState && other.nameWidth == nameWidth;

  @override
  int get hashCode => nameWidth.hashCode;
}
