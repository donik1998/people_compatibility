class CompatibilityResponse {
  CompatibilityResponse({
    this.koeff,
    this.koeffSum,
  });

  CompatibilityResponse.fromJson(Map<String, dynamic> json) {
    koeff = json['koeff'] != null ? json['koeff'].cast<int>() : [];
    koeffSum = json['koeff_sum'];
  }
  List<int>? koeff;
  int? koeffSum;
  CompatibilityResponse copyWith({
    List<int>? koeff,
    int? koeffSum,
  }) =>
      CompatibilityResponse(
        koeff: koeff ?? this.koeff,
        koeffSum: koeffSum ?? this.koeffSum,
      );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['koeff'] = koeff;
    map['koeff_sum'] = koeffSum;
    return map;
  }
}
