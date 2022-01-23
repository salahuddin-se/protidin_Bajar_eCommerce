class AutoGenerate {
  AutoGenerate({
    required this.time,
    required this.disclaimer,
    required this.chartName,
    required this.bpi,
  });
  late final Time time;
  late final String disclaimer;
  late final String chartName;
  late final Bpi bpi;

  AutoGenerate.fromJson(Map<String, dynamic> json) {
    time = Time.fromJson(json['time']);
    disclaimer = json['disclaimer'];
    chartName = json['chartName'];
    bpi = Bpi.fromJson(json['bpi']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['time'] = time.toJson();
    _data['disclaimer'] = disclaimer;
    _data['chartName'] = chartName;
    _data['bpi'] = bpi.toJson();
    return _data;
  }
}

class Time {
  Time({
    required this.updated,
    required this.updatedISO,
    required this.updateduk,
  });
  late final String updated;
  late final String updatedISO;
  late final String updateduk;

  Time.fromJson(Map<String, dynamic> json) {
    updated = json['updated'];
    updatedISO = json['updatedISO'];
    updateduk = json['updateduk'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['updated'] = updated;
    _data['updatedISO'] = updatedISO;
    _data['updateduk'] = updateduk;
    return _data;
  }
}

class Bpi {
  Bpi({
    required this.GBP,
    required this.USD,
    required this.EUR,
  });
  late final USD;
  late final GBP;
  late final EUR;

  Bpi.fromJson(Map<String, dynamic> json) {
    //USD = USD.fromJson(json['USD']);
    GBP = GBP.fromJson(json['GBP']);
    EUR = EUR.fromJson(json['EUR']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['USD'] = USD.toJson();
    _data['GBP'] = GBP.toJson();
    _data['EUR'] = EUR.toJson();
    return _data;
  }
}

class USD {
  USD({
    required this.code,
    required this.symbol,
    required this.rate,
    required this.description,
    required this.rateFloat,
  });
  late final String code;
  late final String symbol;
  late final String rate;
  late final String description;
  late final double rateFloat;

  USD.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    symbol = json['symbol'];
    rate = json['rate'];
    description = json['description'];
    rateFloat = json['rate_float'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['code'] = code;
    _data['symbol'] = symbol;
    _data['rate'] = rate;
    _data['description'] = description;
    _data['rate_float'] = rateFloat;
    return _data;
  }
}

class GBP {
  GBP({
    required this.code,
    required this.symbol,
    required this.rate,
    required this.description,
    required this.rateFloat,
  });
  late final String code;
  late final String symbol;
  late final String rate;
  late final String description;
  late final double rateFloat;

  GBP.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    symbol = json['symbol'];
    rate = json['rate'];
    description = json['description'];
    rateFloat = json['rate_float'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['code'] = code;
    _data['symbol'] = symbol;
    _data['rate'] = rate;
    _data['description'] = description;
    _data['rate_float'] = rateFloat;
    return _data;
  }
}

class EUR {
  EUR({
    required this.code,
    required this.symbol,
    required this.rate,
    required this.description,
    required this.rateFloat,
  });
  late final String code;
  late final String symbol;
  late final String rate;
  late final String description;
  late final double rateFloat;

  EUR.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    symbol = json['symbol'];
    rate = json['rate'];
    description = json['description'];
    rateFloat = json['rate_float'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['code'] = code;
    _data['symbol'] = symbol;
    _data['rate'] = rate;
    _data['description'] = description;
    _data['rate_float'] = rateFloat;
    return _data;
  }
}
