class User {
  final int? id;
  final String? firstName;
  final String? lastName;
  final String? maidenName;
  final int? age;
  final String? gender;
  final String? email;
  final String? phone;
  final String? username;
  final String? password;
  final String? birthDate;
  final String? image;
  final String? bloodGroup;
  final double? height;
  final double? weight;
  final String? eyeColor;
  final Hair? hair;
  final String? ip;
  final Address? address;
  final String? macAddress;
  final String? university;
  final Bank? bank;
  final Company? company;
  final String? ein;
  final String? ssn;
  final String? userAgent;
  final Crypto? crypto;
  final String? role;

  User({
    this.id,
    this.firstName,
    this.lastName,
    this.maidenName,
    this.age,
    this.gender,
    this.email,
    this.phone,
    this.username,
    this.password,
    this.birthDate,
    this.image,
    this.bloodGroup,
    this.height,
    this.weight,
    this.eyeColor,
    this.hair,
    this.ip,
    this.address,
    this.macAddress,
    this.university,
    this.bank,
    this.company,
    this.ein,
    this.ssn,
    this.userAgent,
    this.crypto,
    this.role,
  });

  Map<String, dynamic> toUpdateJson() {
    final data = <String, dynamic>{};
    if (username != null) data['username'] = username;
    if (email != null) data['email'] = email;
    if (password != null) data['password'] = password;
    if (image != null) data['image'] = image;
    return data;
  }

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] as int?,
      firstName: json['firstName'] as String?,
      lastName: json['lastName'] as String?,
      maidenName: json['maidenName'] as String?,
      age: json['age'] as int?,
      gender: json['gender'] as String?,
      email: json['email'] as String?,
      phone: json['phone'] as String?,
      username: json['username'] as String?,
      password: json['password'] as String?,
      birthDate: json['birthDate'] as String?,
      image: json['image'] as String?,
      bloodGroup: json['bloodGroup'] as String?,
      height: (json['height'] as num?)?.toDouble(),
      weight: (json['weight'] as num?)?.toDouble(),
      eyeColor: json['eyeColor'] as String?,
      hair: json['hair'] != null ? Hair.fromJson(json['hair']) : null,
      ip: json['ip'] as String?,
      address:
          json['address'] != null ? Address.fromJson(json['address']) : null,
      macAddress: json['macAddress'] as String?,
      university: json['university'] as String?,
      bank: json['bank'] != null ? Bank.fromJson(json['bank']) : null,
      company:
          json['company'] != null ? Company.fromJson(json['company']) : null,
      ein: json['ein'] as String?,
      ssn: json['ssn'] as String?,
      userAgent: json['userAgent'] as String?,
      crypto: json['crypto'] != null ? Crypto.fromJson(json['crypto']) : null,
      role: json['role'] as String?,
    );
  }
}

class Hair {
  final String? color;
  final String? type;

  Hair({this.color, this.type});

  factory Hair.fromJson(Map<String, dynamic> json) {
    return Hair(
      color: json['color'] as String?,
      type: json['type'] as String?,
    );
  }
}

class Address {
  final String? address;
  final String? city;
  final String? state;
  final String? stateCode;
  final String? postalCode;
  final Coordinates? coordinates;
  final String? country;

  Address({
    this.address,
    this.city,
    this.state,
    this.stateCode,
    this.postalCode,
    this.coordinates,
    this.country,
  });

  factory Address.fromJson(Map<String, dynamic> json) {
    return Address(
      address: json['address'] as String?,
      city: json['city'] as String?,
      state: json['state'] as String?,
      stateCode: json['stateCode'] as String?,
      postalCode: json['postalCode'] as String?,
      coordinates: json['coordinates'] != null
          ? Coordinates.fromJson(json['coordinates'])
          : null,
      country: json['country'] as String?,
    );
  }
}

class Coordinates {
  final double? lat;
  final double? lng;

  Coordinates({this.lat, this.lng});

  factory Coordinates.fromJson(Map<String, dynamic> json) {
    return Coordinates(
      lat: (json['lat'] as num?)?.toDouble(),
      lng: (json['lng'] as num?)?.toDouble(),
    );
  }
}

class Bank {
  final String? cardExpire;
  final String? cardNumber;
  final String? cardType;
  final String? currency;
  final String? iban;

  Bank({
    this.cardExpire,
    this.cardNumber,
    this.cardType,
    this.currency,
    this.iban,
  });

  factory Bank.fromJson(Map<String, dynamic> json) {
    return Bank(
      cardExpire: json['cardExpire'] as String?,
      cardNumber: json['cardNumber'] as String?,
      cardType: json['cardType'] as String?,
      currency: json['currency'] as String?,
      iban: json['iban'] as String?,
    );
  }
}

class Company {
  final String? department;
  final String? name;
  final String? title;
  final Address? address;

  Company({
    this.department,
    this.name,
    this.title,
    this.address,
  });

  factory Company.fromJson(Map<String, dynamic> json) {
    return Company(
      department: json['department'] as String?,
      name: json['name'] as String?,
      title: json['title'] as String?,
      address:
          json['address'] != null ? Address.fromJson(json['address']) : null,
    );
  }
}

class Crypto {
  final String? coin;
  final String? wallet;
  final String? network;

  Crypto({
    this.coin,
    this.wallet,
    this.network,
  });

  factory Crypto.fromJson(Map<String, dynamic> json) {
    return Crypto(
      coin: json['coin'] as String?,
      wallet: json['wallet'] as String?,
      network: json['network'] as String?,
    );
  }
}
