class CompatibilityResponse {
  CompatibilityResponse({
    this.koeff,
    this.koeffSum,
    this.requestUrl,
  });

  CompatibilityResponse.fromJson(Map<String, dynamic> json) {
    koeff = json['koeff'] != null ? json['koeff'].cast<int>() : [];
    koeffSum = json['koeff_sum'];
    requestUrl = json['uri'];
  }
  List<int>? koeff;
  int? koeffSum;
  String? requestUrl;
  CompatibilityResponse copyWith({
    String? requestUrl,
    List<int>? koeff,
    int? koeffSum,
  }) =>
      CompatibilityResponse(
        koeff: koeff ?? this.koeff,
        koeffSum: koeffSum ?? this.koeffSum,
        requestUrl: requestUrl ?? this.requestUrl,
      );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['koeff'] = koeff;
    map['koeff_sum'] = koeffSum;
    map['uri'] = requestUrl;
    return map;
  }
}
