// lib/data/models/country_model.dart

class Languages {
  Map<String, String>? lang;

  Languages({this.lang});

  Languages.fromJson(Map<String, dynamic> json) {
    lang = Map<String, String>.from(json);
  }

  Map<String, dynamic> toJson() {
    return lang ?? {};
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
}

class CountryModel {
  Flags? flags;
  Name? name;
  Currencies? currencies;
  List<String>? capital;
  Languages? languages;
  int? population;
  late bool isFavorite;

  CountryModel({
    this.flags,
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
    } if (currencies != null) {
      data['currencies'] = currencies!.toJson();
    }
    data['capital'] = capital;
    data['population'] = population;
    data['isFavorite'] = isFavorite;
    return data;
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






