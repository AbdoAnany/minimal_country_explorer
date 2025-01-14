class Country {
  Flags? flags;
  Name? name;
  Currencies? currencies;
  List<String>? capital;
  Languages? languages;
  int? population;
  late bool isFavorite;

  Country(
      {this.flags,
        this.name,
        this.currencies,
        this.capital,
        this.isFavorite=false,
        this.languages,
        this.population});

  Country.fromJson(Map<String, dynamic> json) {
    flags = json['flags'] != null ? new Flags.fromJson(json['flags']) : null;
    name = json['name'] != null ? new Name.fromJson(json['name']) : null;
    currencies = json['currencies'] != null
        ? new Currencies.fromJson(json['currencies'])
        : null;
    capital = json['capital'].cast<String>();
    languages = json['languages'] != null
        ? new Languages.fromJson(json['languages'])
        : null;
    population = json['population'];
    isFavorite = json['isFavorite']??false;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.flags != null) {
      data['flags'] = this.flags!.toJson();
    }
    if (this.name != null) {
      data['name'] = this.name!.official;
    }
    // if (this.currencies != null) {
    //   data['currencies'] = this.currencies!.toJson();
    // }
    data['capital'] = this.capital;
    if (this.languages != null) {
      data['languages'] = this.languages!.toJson();
    }
    data['population'] = this.population;
    return data;
  }
  Country copyWith({
    Flags? flags,
    Name? name,
    Currencies? currencies,
    List<String>? capital,
    Languages? languages,
    int? population,
    bool? isFavorite,
  }) {
    return Country(
      flags: flags ?? this.flags,
      name: name ?? this.name,
      currencies: currencies ?? this.currencies,
      capital: capital ?? this.capital,
      languages: languages ?? this.languages,
      population: population ?? this.population,
      isFavorite: isFavorite ?? this.isFavorite,
    );
}}

class Flags {
  String? png;
  String? svg;
  String? alt;

  Flags({this.png, this.svg, this.alt});

  Flags.fromJson(Map<String, dynamic> json) {
    png = json['png'];
    svg = json['svg'];
    alt = json['alt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['png'] = this.png;
    data['svg'] = this.svg;
    data['alt'] = this.alt;
    return data;
  }
}

class Name {
  String? common;
  String? official;
  NativeName? nativeName;

  Name({this.common, this.official, this.nativeName});

  Name.fromJson(Map<String, dynamic> json) {
    common = json['common'];
    official = json['official'];
    nativeName = json['nativeName'] != null
        ? new NativeName.fromJson(json['nativeName'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['common'] = this.common;
    data['official'] = this.official;
    if (this.nativeName != null) {
      data['nativeName'] = this.nativeName!.toJson();
    }
    return data;
  }
}

class NativeName {
  Eng? eng;

  NativeName({this.eng});

  NativeName.fromJson(Map<String, dynamic> json) {
    eng = json['eng'] != null ? new Eng.fromJson(json['eng']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.eng != null) {
      data['eng'] = this.eng!.toJson();
    }
    return data;
  }
}

class Eng {
  String? official;
  String? common;

  Eng({this.official, this.common});

  Eng.fromJson(Map<String, dynamic> json) {
    official = json['official'];
    common = json['common'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['official'] = this.official;
    data['common'] = this.common;
    return data;
  }
}

class Currencies {
  SHP? sHP;

  Currencies({this.sHP});

  Currencies.fromJson(Map<String, dynamic> json) {
    sHP = json['SHP'] != null ? new SHP.fromJson(json['SHP']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.sHP != null) {
      data['SHP'] = this.sHP!.toJson();
    }
    return data;
  }
}

class SHP {
  String? name;
  String? symbol;

  SHP({this.name, this.symbol});

  SHP.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    symbol = json['symbol'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['symbol'] = this.symbol;
    return data;
  }
}

class Languages {
  String? eng;

  Languages({this.eng});

  Languages.fromJson(Map<String, dynamic> json) {
    eng = json['eng'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['eng'] = this.eng;
    return data;
  }
}



class Country1 {
  final String name;
  final String capital;
  final int population;
  final String currency;
  final String languages;
  final String flag;

  Country1({
    required this.name,
    required this.capital,
    required this.population,
    required this.currency,
    required this.languages,
    required this.flag,
  });

  factory Country1.fromJson(Map<String, dynamic> json) {
    final currencies = json['currencies']?.values.first['name'] ?? 'Unknown';
    final languages = (json['languages'] as Map<String, dynamic>?)?.values.join(', ') ?? 'Unknown';

    return Country1(
      name: json['name']['common'],
      capital: (json['capital'] ?? ['Unknown'])[0],
      population: json['population'],
      currency: currencies,
      languages: languages,
      flag: json['flags']['png'],
    );
  }

  // Convert to JSON
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'capital': capital,
      'population': population,
      'currency': currency,
      'languages': languages,
      'flag': flag,
    };
  }

  // Override == operator
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Country1 &&
        other.name == name &&
        other.capital == capital &&
        other.population == population &&
        other.currency == currency &&
        other.languages == languages &&
        other.flag == flag;
  }

  // Override hashCode
  @override
  int get hashCode {
    return name.hashCode ^
    capital.hashCode ^
    population.hashCode ^
    currency.hashCode ^
    languages.hashCode ^
    flag.hashCode;
  }
}
