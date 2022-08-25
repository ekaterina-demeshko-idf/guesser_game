class BlocTile {
  dynamic data;
  BlocTile(
    this.data,
  );

  factory BlocTile.init() => BlocTile(
        null,
      );

  BlocTile copy() => BlocTile(
        data,
      );

  void updateParams(
    dynamic data,
  ) {
    if (data != null) this.data = data;
  }
}
