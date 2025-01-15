class Languages {
  Map<String, String>? lang;

  Languages({this.lang});

  Languages.fromJson(Map<String, dynamic> json) {
    lang = Map<String, String>.from(json);
  }

  Map<String, dynamic> toJson() {
    return lang ?? {};
  }

  Languages copyWith({Map<String, String>? lang}) {
    return Languages(
      lang: lang ?? this.lang,
    );
  }
}

class NativeName {
  Map<String, dynamic>? date;

  NativeName({this.date});

  NativeName.fromJson(Map<String, dynamic> json) {
    date = Map<String, dynamic>.from(json);
  }

  Map<String, dynamic> toJson() {
    return date ?? {};
  }

  NativeName copyWith({Map<String, dynamic>? date}) {
    return NativeName(
      date: date ?? this.date,
    );
  }
}

class Currencies {
  Map<String, dynamic>? date;

  Currencies({this.date});

  Currencies.fromJson(Map<String, dynamic> json) {
    date = Map<String, dynamic>.from(json);
  }

  Map<String, dynamic> toJson() {
    return date ?? {};
  }

  Currencies copyWith({Map<String, dynamic>? date}) {
    return Currencies(
      date: date ?? this.date,
    );
  }
}

class CountryModel {
  // int? id;
  Flags? flags;
  Name? name;
  Currencies? currencies;
  List<String>? capital;
  Languages? languages;
  int? population;
  late bool isFavorite;

  CountryModel({
    this.flags,
    // this.id,
    this.name,
    this.currencies,
    this.capital,
    this.isFavorite = false,
    this.languages,
    this.population,
  });

  CountryModel.fromJson(Map<String, dynamic> json) {
    flags = json['flags'] != null ? Flags.fromJson(json['flags']) : null;
    name = json['name'] != null ? Name.fromJson(json['name']) : null;
    currencies = json['currencies'] != null
        ? Currencies.fromJson(json['currencies'])
        : null;
    capital = json['capital']?.cast<String>();
    languages = json['languages'] != null
        ? Languages.fromJson(json['languages'])
        : null;
    population = json['population'];
    // id = json['id'];
    isFavorite = json['isFavorite'] ?? false;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (flags != null) {
      data['flags'] = flags!.toJson();
    }
    if (name != null) {
      data['name'] = name!.toJson();
    }
    if (languages != null) {
      data['languages'] = languages!.toJson();
    }
    if (currencies != null) {
      data['currencies'] = currencies!.toJson();
    }
    data['capital'] = capital;
    data['population'] = population;
    // data['id'] = id;
    data['isFavorite'] = isFavorite;
    return data;
  }

  CountryModel copyWith({
    int? id,
    Flags? flags,
    Name? name,
    Currencies? currencies,
    List<String>? capital,
    Languages? languages,
    int? population,
    bool? isFavorite,
  }) {
    return CountryModel(
      // id: id ?? this.id,
      flags: flags ?? this.flags,
      name: name ?? this.name,
      currencies: currencies ?? this.currencies,
      capital: capital ?? this.capital,
      languages: languages ?? this.languages,
      population: population ?? this.population,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }
}

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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['png'] = png;
    data['svg'] = svg;
    data['alt'] = alt;
    return data;
  }

  Flags copyWith({String? png, String? svg, String? alt}) {
    return Flags(
      png: png ?? this.png,
      svg: svg ?? this.svg,
      alt: alt ?? this.alt,
    );
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
        ? NativeName.fromJson(json['nativeName'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['common'] = common;
    data['official'] = official;
    if (nativeName != null) {
      data['nativeName'] = nativeName!.toJson();
    }
    return data;
  }

  Name copyWith({String? common, String? official, NativeName? nativeName}) {
    return Name(
      common: common ?? this.common,
      official: official ?? this.official,
      nativeName: nativeName ?? this.nativeName,
    );
  }
}
