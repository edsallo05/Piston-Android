// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// ignore_for_file: type=lint
class $ClientsTable extends Clients with TableInfo<$ClientsTable, Client> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ClientsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _phoneMeta = const VerificationMeta('phone');
  @override
  late final GeneratedColumn<String> phone = GeneratedColumn<String>(
      'phone', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _addressMeta =
      const VerificationMeta('address');
  @override
  late final GeneratedColumn<String> address = GeneratedColumn<String>(
      'address', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [id, name, phone, address];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'clients';
  @override
  VerificationContext validateIntegrity(Insertable<Client> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('phone')) {
      context.handle(
          _phoneMeta, phone.isAcceptableOrUnknown(data['phone']!, _phoneMeta));
    } else if (isInserting) {
      context.missing(_phoneMeta);
    }
    if (data.containsKey('address')) {
      context.handle(_addressMeta,
          address.isAcceptableOrUnknown(data['address']!, _addressMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Client map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Client(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      phone: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}phone'])!,
      address: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}address']),
    );
  }

  @override
  $ClientsTable createAlias(String alias) {
    return $ClientsTable(attachedDatabase, alias);
  }
}

class Client extends DataClass implements Insertable<Client> {
  final int id;
  final String name;
  final String phone;
  final String? address;
  const Client(
      {required this.id,
      required this.name,
      required this.phone,
      this.address});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    map['phone'] = Variable<String>(phone);
    if (!nullToAbsent || address != null) {
      map['address'] = Variable<String>(address);
    }
    return map;
  }

  ClientsCompanion toCompanion(bool nullToAbsent) {
    return ClientsCompanion(
      id: Value(id),
      name: Value(name),
      phone: Value(phone),
      address: address == null && nullToAbsent
          ? const Value.absent()
          : Value(address),
    );
  }

  factory Client.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Client(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      phone: serializer.fromJson<String>(json['phone']),
      address: serializer.fromJson<String?>(json['address']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'phone': serializer.toJson<String>(phone),
      'address': serializer.toJson<String?>(address),
    };
  }

  Client copyWith(
          {int? id,
          String? name,
          String? phone,
          Value<String?> address = const Value.absent()}) =>
      Client(
        id: id ?? this.id,
        name: name ?? this.name,
        phone: phone ?? this.phone,
        address: address.present ? address.value : this.address,
      );
  Client copyWithCompanion(ClientsCompanion data) {
    return Client(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      phone: data.phone.present ? data.phone.value : this.phone,
      address: data.address.present ? data.address.value : this.address,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Client(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('phone: $phone, ')
          ..write('address: $address')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name, phone, address);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Client &&
          other.id == this.id &&
          other.name == this.name &&
          other.phone == this.phone &&
          other.address == this.address);
}

class ClientsCompanion extends UpdateCompanion<Client> {
  final Value<int> id;
  final Value<String> name;
  final Value<String> phone;
  final Value<String?> address;
  const ClientsCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.phone = const Value.absent(),
    this.address = const Value.absent(),
  });
  ClientsCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    required String phone,
    this.address = const Value.absent(),
  })  : name = Value(name),
        phone = Value(phone);
  static Insertable<Client> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<String>? phone,
    Expression<String>? address,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (phone != null) 'phone': phone,
      if (address != null) 'address': address,
    });
  }

  ClientsCompanion copyWith(
      {Value<int>? id,
      Value<String>? name,
      Value<String>? phone,
      Value<String?>? address}) {
    return ClientsCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      phone: phone ?? this.phone,
      address: address ?? this.address,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (phone.present) {
      map['phone'] = Variable<String>(phone.value);
    }
    if (address.present) {
      map['address'] = Variable<String>(address.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ClientsCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('phone: $phone, ')
          ..write('address: $address')
          ..write(')'))
        .toString();
  }
}

class $VehiclesTable extends Vehicles with TableInfo<$VehiclesTable, Vehicle> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $VehiclesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _clientIdMeta =
      const VerificationMeta('clientId');
  @override
  late final GeneratedColumn<int> clientId = GeneratedColumn<int>(
      'client_id', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _plateMeta = const VerificationMeta('plate');
  @override
  late final GeneratedColumn<String> plate = GeneratedColumn<String>(
      'plate', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'));
  static const VerificationMeta _brandMeta = const VerificationMeta('brand');
  @override
  late final GeneratedColumn<String> brand = GeneratedColumn<String>(
      'brand', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _modelMeta = const VerificationMeta('model');
  @override
  late final GeneratedColumn<String> model = GeneratedColumn<String>(
      'model', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _yearMeta = const VerificationMeta('year');
  @override
  late final GeneratedColumn<int> year = GeneratedColumn<int>(
      'year', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _mileageMeta =
      const VerificationMeta('mileage');
  @override
  late final GeneratedColumn<int> mileage = GeneratedColumn<int>(
      'mileage', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns =>
      [id, clientId, plate, brand, model, year, mileage];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'vehicles';
  @override
  VerificationContext validateIntegrity(Insertable<Vehicle> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('client_id')) {
      context.handle(_clientIdMeta,
          clientId.isAcceptableOrUnknown(data['client_id']!, _clientIdMeta));
    } else if (isInserting) {
      context.missing(_clientIdMeta);
    }
    if (data.containsKey('plate')) {
      context.handle(
          _plateMeta, plate.isAcceptableOrUnknown(data['plate']!, _plateMeta));
    } else if (isInserting) {
      context.missing(_plateMeta);
    }
    if (data.containsKey('brand')) {
      context.handle(
          _brandMeta, brand.isAcceptableOrUnknown(data['brand']!, _brandMeta));
    } else if (isInserting) {
      context.missing(_brandMeta);
    }
    if (data.containsKey('model')) {
      context.handle(
          _modelMeta, model.isAcceptableOrUnknown(data['model']!, _modelMeta));
    } else if (isInserting) {
      context.missing(_modelMeta);
    }
    if (data.containsKey('year')) {
      context.handle(
          _yearMeta, year.isAcceptableOrUnknown(data['year']!, _yearMeta));
    } else if (isInserting) {
      context.missing(_yearMeta);
    }
    if (data.containsKey('mileage')) {
      context.handle(_mileageMeta,
          mileage.isAcceptableOrUnknown(data['mileage']!, _mileageMeta));
    } else if (isInserting) {
      context.missing(_mileageMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Vehicle map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Vehicle(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      clientId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}client_id'])!,
      plate: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}plate'])!,
      brand: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}brand'])!,
      model: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}model'])!,
      year: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}year'])!,
      mileage: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}mileage'])!,
    );
  }

  @override
  $VehiclesTable createAlias(String alias) {
    return $VehiclesTable(attachedDatabase, alias);
  }
}

class Vehicle extends DataClass implements Insertable<Vehicle> {
  final int id;
  final int clientId;
  final String plate;
  final String brand;
  final String model;
  final int year;
  final int mileage;
  const Vehicle(
      {required this.id,
      required this.clientId,
      required this.plate,
      required this.brand,
      required this.model,
      required this.year,
      required this.mileage});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['client_id'] = Variable<int>(clientId);
    map['plate'] = Variable<String>(plate);
    map['brand'] = Variable<String>(brand);
    map['model'] = Variable<String>(model);
    map['year'] = Variable<int>(year);
    map['mileage'] = Variable<int>(mileage);
    return map;
  }

  VehiclesCompanion toCompanion(bool nullToAbsent) {
    return VehiclesCompanion(
      id: Value(id),
      clientId: Value(clientId),
      plate: Value(plate),
      brand: Value(brand),
      model: Value(model),
      year: Value(year),
      mileage: Value(mileage),
    );
  }

  factory Vehicle.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Vehicle(
      id: serializer.fromJson<int>(json['id']),
      clientId: serializer.fromJson<int>(json['clientId']),
      plate: serializer.fromJson<String>(json['plate']),
      brand: serializer.fromJson<String>(json['brand']),
      model: serializer.fromJson<String>(json['model']),
      year: serializer.fromJson<int>(json['year']),
      mileage: serializer.fromJson<int>(json['mileage']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'clientId': serializer.toJson<int>(clientId),
      'plate': serializer.toJson<String>(plate),
      'brand': serializer.toJson<String>(brand),
      'model': serializer.toJson<String>(model),
      'year': serializer.toJson<int>(year),
      'mileage': serializer.toJson<int>(mileage),
    };
  }

  Vehicle copyWith(
          {int? id,
          int? clientId,
          String? plate,
          String? brand,
          String? model,
          int? year,
          int? mileage}) =>
      Vehicle(
        id: id ?? this.id,
        clientId: clientId ?? this.clientId,
        plate: plate ?? this.plate,
        brand: brand ?? this.brand,
        model: model ?? this.model,
        year: year ?? this.year,
        mileage: mileage ?? this.mileage,
      );
  Vehicle copyWithCompanion(VehiclesCompanion data) {
    return Vehicle(
      id: data.id.present ? data.id.value : this.id,
      clientId: data.clientId.present ? data.clientId.value : this.clientId,
      plate: data.plate.present ? data.plate.value : this.plate,
      brand: data.brand.present ? data.brand.value : this.brand,
      model: data.model.present ? data.model.value : this.model,
      year: data.year.present ? data.year.value : this.year,
      mileage: data.mileage.present ? data.mileage.value : this.mileage,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Vehicle(')
          ..write('id: $id, ')
          ..write('clientId: $clientId, ')
          ..write('plate: $plate, ')
          ..write('brand: $brand, ')
          ..write('model: $model, ')
          ..write('year: $year, ')
          ..write('mileage: $mileage')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, clientId, plate, brand, model, year, mileage);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Vehicle &&
          other.id == this.id &&
          other.clientId == this.clientId &&
          other.plate == this.plate &&
          other.brand == this.brand &&
          other.model == this.model &&
          other.year == this.year &&
          other.mileage == this.mileage);
}

class VehiclesCompanion extends UpdateCompanion<Vehicle> {
  final Value<int> id;
  final Value<int> clientId;
  final Value<String> plate;
  final Value<String> brand;
  final Value<String> model;
  final Value<int> year;
  final Value<int> mileage;
  const VehiclesCompanion({
    this.id = const Value.absent(),
    this.clientId = const Value.absent(),
    this.plate = const Value.absent(),
    this.brand = const Value.absent(),
    this.model = const Value.absent(),
    this.year = const Value.absent(),
    this.mileage = const Value.absent(),
  });
  VehiclesCompanion.insert({
    this.id = const Value.absent(),
    required int clientId,
    required String plate,
    required String brand,
    required String model,
    required int year,
    required int mileage,
  })  : clientId = Value(clientId),
        plate = Value(plate),
        brand = Value(brand),
        model = Value(model),
        year = Value(year),
        mileage = Value(mileage);
  static Insertable<Vehicle> custom({
    Expression<int>? id,
    Expression<int>? clientId,
    Expression<String>? plate,
    Expression<String>? brand,
    Expression<String>? model,
    Expression<int>? year,
    Expression<int>? mileage,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (clientId != null) 'client_id': clientId,
      if (plate != null) 'plate': plate,
      if (brand != null) 'brand': brand,
      if (model != null) 'model': model,
      if (year != null) 'year': year,
      if (mileage != null) 'mileage': mileage,
    });
  }

  VehiclesCompanion copyWith(
      {Value<int>? id,
      Value<int>? clientId,
      Value<String>? plate,
      Value<String>? brand,
      Value<String>? model,
      Value<int>? year,
      Value<int>? mileage}) {
    return VehiclesCompanion(
      id: id ?? this.id,
      clientId: clientId ?? this.clientId,
      plate: plate ?? this.plate,
      brand: brand ?? this.brand,
      model: model ?? this.model,
      year: year ?? this.year,
      mileage: mileage ?? this.mileage,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (clientId.present) {
      map['client_id'] = Variable<int>(clientId.value);
    }
    if (plate.present) {
      map['plate'] = Variable<String>(plate.value);
    }
    if (brand.present) {
      map['brand'] = Variable<String>(brand.value);
    }
    if (model.present) {
      map['model'] = Variable<String>(model.value);
    }
    if (year.present) {
      map['year'] = Variable<int>(year.value);
    }
    if (mileage.present) {
      map['mileage'] = Variable<int>(mileage.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('VehiclesCompanion(')
          ..write('id: $id, ')
          ..write('clientId: $clientId, ')
          ..write('plate: $plate, ')
          ..write('brand: $brand, ')
          ..write('model: $model, ')
          ..write('year: $year, ')
          ..write('mileage: $mileage')
          ..write(')'))
        .toString();
  }
}

class $MechanicsTable extends Mechanics
    with TableInfo<$MechanicsTable, Mechanic> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $MechanicsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [id, name];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'mechanics';
  @override
  VerificationContext validateIntegrity(Insertable<Mechanic> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Mechanic map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Mechanic(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
    );
  }

  @override
  $MechanicsTable createAlias(String alias) {
    return $MechanicsTable(attachedDatabase, alias);
  }
}

class Mechanic extends DataClass implements Insertable<Mechanic> {
  final int id;
  final String name;
  const Mechanic({required this.id, required this.name});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    return map;
  }

  MechanicsCompanion toCompanion(bool nullToAbsent) {
    return MechanicsCompanion(
      id: Value(id),
      name: Value(name),
    );
  }

  factory Mechanic.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Mechanic(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
    };
  }

  Mechanic copyWith({int? id, String? name}) => Mechanic(
        id: id ?? this.id,
        name: name ?? this.name,
      );
  Mechanic copyWithCompanion(MechanicsCompanion data) {
    return Mechanic(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Mechanic(')
          ..write('id: $id, ')
          ..write('name: $name')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Mechanic && other.id == this.id && other.name == this.name);
}

class MechanicsCompanion extends UpdateCompanion<Mechanic> {
  final Value<int> id;
  final Value<String> name;
  const MechanicsCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
  });
  MechanicsCompanion.insert({
    this.id = const Value.absent(),
    required String name,
  }) : name = Value(name);
  static Insertable<Mechanic> custom({
    Expression<int>? id,
    Expression<String>? name,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
    });
  }

  MechanicsCompanion copyWith({Value<int>? id, Value<String>? name}) {
    return MechanicsCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('MechanicsCompanion(')
          ..write('id: $id, ')
          ..write('name: $name')
          ..write(')'))
        .toString();
  }
}

class $ServiceOrdersTable extends ServiceOrders
    with TableInfo<$ServiceOrdersTable, ServiceOrder> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ServiceOrdersTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _vehicleIdMeta =
      const VerificationMeta('vehicleId');
  @override
  late final GeneratedColumn<int> vehicleId = GeneratedColumn<int>(
      'vehicle_id', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _mechanicIdMeta =
      const VerificationMeta('mechanicId');
  @override
  late final GeneratedColumn<int> mechanicId = GeneratedColumn<int>(
      'mechanic_id', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _entryDateMeta =
      const VerificationMeta('entryDate');
  @override
  late final GeneratedColumn<DateTime> entryDate = GeneratedColumn<DateTime>(
      'entry_date', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _reportedProblemMeta =
      const VerificationMeta('reportedProblem');
  @override
  late final GeneratedColumn<String> reportedProblem = GeneratedColumn<String>(
      'reported_problem', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  @override
  late final GeneratedColumnWithTypeConverter<OrderStatus, int> status =
      GeneratedColumn<int>('status', aliasedName, false,
              type: DriftSqlType.int, requiredDuringInsert: true)
          .withConverter<OrderStatus>($ServiceOrdersTable.$converterstatus);
  @override
  List<GeneratedColumn> get $columns =>
      [id, vehicleId, mechanicId, entryDate, reportedProblem, status];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'service_orders';
  @override
  VerificationContext validateIntegrity(Insertable<ServiceOrder> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('vehicle_id')) {
      context.handle(_vehicleIdMeta,
          vehicleId.isAcceptableOrUnknown(data['vehicle_id']!, _vehicleIdMeta));
    } else if (isInserting) {
      context.missing(_vehicleIdMeta);
    }
    if (data.containsKey('mechanic_id')) {
      context.handle(
          _mechanicIdMeta,
          mechanicId.isAcceptableOrUnknown(
              data['mechanic_id']!, _mechanicIdMeta));
    } else if (isInserting) {
      context.missing(_mechanicIdMeta);
    }
    if (data.containsKey('entry_date')) {
      context.handle(_entryDateMeta,
          entryDate.isAcceptableOrUnknown(data['entry_date']!, _entryDateMeta));
    } else if (isInserting) {
      context.missing(_entryDateMeta);
    }
    if (data.containsKey('reported_problem')) {
      context.handle(
          _reportedProblemMeta,
          reportedProblem.isAcceptableOrUnknown(
              data['reported_problem']!, _reportedProblemMeta));
    } else if (isInserting) {
      context.missing(_reportedProblemMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ServiceOrder map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ServiceOrder(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      vehicleId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}vehicle_id'])!,
      mechanicId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}mechanic_id'])!,
      entryDate: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}entry_date'])!,
      reportedProblem: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}reported_problem'])!,
      status: $ServiceOrdersTable.$converterstatus.fromSql(attachedDatabase
          .typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}status'])!),
    );
  }

  @override
  $ServiceOrdersTable createAlias(String alias) {
    return $ServiceOrdersTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<OrderStatus, int, int> $converterstatus =
      const EnumIndexConverter<OrderStatus>(OrderStatus.values);
}

class ServiceOrder extends DataClass implements Insertable<ServiceOrder> {
  final int id;
  final int vehicleId;
  final int mechanicId;
  final DateTime entryDate;
  final String reportedProblem;
  final OrderStatus status;
  const ServiceOrder(
      {required this.id,
      required this.vehicleId,
      required this.mechanicId,
      required this.entryDate,
      required this.reportedProblem,
      required this.status});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['vehicle_id'] = Variable<int>(vehicleId);
    map['mechanic_id'] = Variable<int>(mechanicId);
    map['entry_date'] = Variable<DateTime>(entryDate);
    map['reported_problem'] = Variable<String>(reportedProblem);
    {
      map['status'] =
          Variable<int>($ServiceOrdersTable.$converterstatus.toSql(status));
    }
    return map;
  }

  ServiceOrdersCompanion toCompanion(bool nullToAbsent) {
    return ServiceOrdersCompanion(
      id: Value(id),
      vehicleId: Value(vehicleId),
      mechanicId: Value(mechanicId),
      entryDate: Value(entryDate),
      reportedProblem: Value(reportedProblem),
      status: Value(status),
    );
  }

  factory ServiceOrder.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ServiceOrder(
      id: serializer.fromJson<int>(json['id']),
      vehicleId: serializer.fromJson<int>(json['vehicleId']),
      mechanicId: serializer.fromJson<int>(json['mechanicId']),
      entryDate: serializer.fromJson<DateTime>(json['entryDate']),
      reportedProblem: serializer.fromJson<String>(json['reportedProblem']),
      status: $ServiceOrdersTable.$converterstatus
          .fromJson(serializer.fromJson<int>(json['status'])),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'vehicleId': serializer.toJson<int>(vehicleId),
      'mechanicId': serializer.toJson<int>(mechanicId),
      'entryDate': serializer.toJson<DateTime>(entryDate),
      'reportedProblem': serializer.toJson<String>(reportedProblem),
      'status': serializer
          .toJson<int>($ServiceOrdersTable.$converterstatus.toJson(status)),
    };
  }

  ServiceOrder copyWith(
          {int? id,
          int? vehicleId,
          int? mechanicId,
          DateTime? entryDate,
          String? reportedProblem,
          OrderStatus? status}) =>
      ServiceOrder(
        id: id ?? this.id,
        vehicleId: vehicleId ?? this.vehicleId,
        mechanicId: mechanicId ?? this.mechanicId,
        entryDate: entryDate ?? this.entryDate,
        reportedProblem: reportedProblem ?? this.reportedProblem,
        status: status ?? this.status,
      );
  ServiceOrder copyWithCompanion(ServiceOrdersCompanion data) {
    return ServiceOrder(
      id: data.id.present ? data.id.value : this.id,
      vehicleId: data.vehicleId.present ? data.vehicleId.value : this.vehicleId,
      mechanicId:
          data.mechanicId.present ? data.mechanicId.value : this.mechanicId,
      entryDate: data.entryDate.present ? data.entryDate.value : this.entryDate,
      reportedProblem: data.reportedProblem.present
          ? data.reportedProblem.value
          : this.reportedProblem,
      status: data.status.present ? data.status.value : this.status,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ServiceOrder(')
          ..write('id: $id, ')
          ..write('vehicleId: $vehicleId, ')
          ..write('mechanicId: $mechanicId, ')
          ..write('entryDate: $entryDate, ')
          ..write('reportedProblem: $reportedProblem, ')
          ..write('status: $status')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id, vehicleId, mechanicId, entryDate, reportedProblem, status);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ServiceOrder &&
          other.id == this.id &&
          other.vehicleId == this.vehicleId &&
          other.mechanicId == this.mechanicId &&
          other.entryDate == this.entryDate &&
          other.reportedProblem == this.reportedProblem &&
          other.status == this.status);
}

class ServiceOrdersCompanion extends UpdateCompanion<ServiceOrder> {
  final Value<int> id;
  final Value<int> vehicleId;
  final Value<int> mechanicId;
  final Value<DateTime> entryDate;
  final Value<String> reportedProblem;
  final Value<OrderStatus> status;
  const ServiceOrdersCompanion({
    this.id = const Value.absent(),
    this.vehicleId = const Value.absent(),
    this.mechanicId = const Value.absent(),
    this.entryDate = const Value.absent(),
    this.reportedProblem = const Value.absent(),
    this.status = const Value.absent(),
  });
  ServiceOrdersCompanion.insert({
    this.id = const Value.absent(),
    required int vehicleId,
    required int mechanicId,
    required DateTime entryDate,
    required String reportedProblem,
    required OrderStatus status,
  })  : vehicleId = Value(vehicleId),
        mechanicId = Value(mechanicId),
        entryDate = Value(entryDate),
        reportedProblem = Value(reportedProblem),
        status = Value(status);
  static Insertable<ServiceOrder> custom({
    Expression<int>? id,
    Expression<int>? vehicleId,
    Expression<int>? mechanicId,
    Expression<DateTime>? entryDate,
    Expression<String>? reportedProblem,
    Expression<int>? status,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (vehicleId != null) 'vehicle_id': vehicleId,
      if (mechanicId != null) 'mechanic_id': mechanicId,
      if (entryDate != null) 'entry_date': entryDate,
      if (reportedProblem != null) 'reported_problem': reportedProblem,
      if (status != null) 'status': status,
    });
  }

  ServiceOrdersCompanion copyWith(
      {Value<int>? id,
      Value<int>? vehicleId,
      Value<int>? mechanicId,
      Value<DateTime>? entryDate,
      Value<String>? reportedProblem,
      Value<OrderStatus>? status}) {
    return ServiceOrdersCompanion(
      id: id ?? this.id,
      vehicleId: vehicleId ?? this.vehicleId,
      mechanicId: mechanicId ?? this.mechanicId,
      entryDate: entryDate ?? this.entryDate,
      reportedProblem: reportedProblem ?? this.reportedProblem,
      status: status ?? this.status,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (vehicleId.present) {
      map['vehicle_id'] = Variable<int>(vehicleId.value);
    }
    if (mechanicId.present) {
      map['mechanic_id'] = Variable<int>(mechanicId.value);
    }
    if (entryDate.present) {
      map['entry_date'] = Variable<DateTime>(entryDate.value);
    }
    if (reportedProblem.present) {
      map['reported_problem'] = Variable<String>(reportedProblem.value);
    }
    if (status.present) {
      map['status'] = Variable<int>(
          $ServiceOrdersTable.$converterstatus.toSql(status.value));
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ServiceOrdersCompanion(')
          ..write('id: $id, ')
          ..write('vehicleId: $vehicleId, ')
          ..write('mechanicId: $mechanicId, ')
          ..write('entryDate: $entryDate, ')
          ..write('reportedProblem: $reportedProblem, ')
          ..write('status: $status')
          ..write(')'))
        .toString();
  }
}

class $PartsTable extends Parts with TableInfo<$PartsTable, Part> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PartsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _codeMeta = const VerificationMeta('code');
  @override
  late final GeneratedColumn<String> code = GeneratedColumn<String>(
      'code', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'));
  static const VerificationMeta _salePriceMeta =
      const VerificationMeta('salePrice');
  @override
  late final GeneratedColumn<double> salePrice = GeneratedColumn<double>(
      'sale_price', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _stockMeta = const VerificationMeta('stock');
  @override
  late final GeneratedColumn<int> stock = GeneratedColumn<int>(
      'stock', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _lowStockThresholdMeta =
      const VerificationMeta('lowStockThreshold');
  @override
  late final GeneratedColumn<int> lowStockThreshold = GeneratedColumn<int>(
      'low_stock_threshold', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(3));
  @override
  List<GeneratedColumn> get $columns =>
      [id, name, code, salePrice, stock, lowStockThreshold];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'parts';
  @override
  VerificationContext validateIntegrity(Insertable<Part> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('code')) {
      context.handle(
          _codeMeta, code.isAcceptableOrUnknown(data['code']!, _codeMeta));
    } else if (isInserting) {
      context.missing(_codeMeta);
    }
    if (data.containsKey('sale_price')) {
      context.handle(_salePriceMeta,
          salePrice.isAcceptableOrUnknown(data['sale_price']!, _salePriceMeta));
    } else if (isInserting) {
      context.missing(_salePriceMeta);
    }
    if (data.containsKey('stock')) {
      context.handle(
          _stockMeta, stock.isAcceptableOrUnknown(data['stock']!, _stockMeta));
    } else if (isInserting) {
      context.missing(_stockMeta);
    }
    if (data.containsKey('low_stock_threshold')) {
      context.handle(
          _lowStockThresholdMeta,
          lowStockThreshold.isAcceptableOrUnknown(
              data['low_stock_threshold']!, _lowStockThresholdMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Part map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Part(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      code: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}code'])!,
      salePrice: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}sale_price'])!,
      stock: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}stock'])!,
      lowStockThreshold: attachedDatabase.typeMapping.read(
          DriftSqlType.int, data['${effectivePrefix}low_stock_threshold'])!,
    );
  }

  @override
  $PartsTable createAlias(String alias) {
    return $PartsTable(attachedDatabase, alias);
  }
}

class Part extends DataClass implements Insertable<Part> {
  final int id;
  final String name;
  final String code;
  final double salePrice;
  final int stock;
  final int lowStockThreshold;
  const Part(
      {required this.id,
      required this.name,
      required this.code,
      required this.salePrice,
      required this.stock,
      required this.lowStockThreshold});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    map['code'] = Variable<String>(code);
    map['sale_price'] = Variable<double>(salePrice);
    map['stock'] = Variable<int>(stock);
    map['low_stock_threshold'] = Variable<int>(lowStockThreshold);
    return map;
  }

  PartsCompanion toCompanion(bool nullToAbsent) {
    return PartsCompanion(
      id: Value(id),
      name: Value(name),
      code: Value(code),
      salePrice: Value(salePrice),
      stock: Value(stock),
      lowStockThreshold: Value(lowStockThreshold),
    );
  }

  factory Part.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Part(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      code: serializer.fromJson<String>(json['code']),
      salePrice: serializer.fromJson<double>(json['salePrice']),
      stock: serializer.fromJson<int>(json['stock']),
      lowStockThreshold: serializer.fromJson<int>(json['lowStockThreshold']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'code': serializer.toJson<String>(code),
      'salePrice': serializer.toJson<double>(salePrice),
      'stock': serializer.toJson<int>(stock),
      'lowStockThreshold': serializer.toJson<int>(lowStockThreshold),
    };
  }

  Part copyWith(
          {int? id,
          String? name,
          String? code,
          double? salePrice,
          int? stock,
          int? lowStockThreshold}) =>
      Part(
        id: id ?? this.id,
        name: name ?? this.name,
        code: code ?? this.code,
        salePrice: salePrice ?? this.salePrice,
        stock: stock ?? this.stock,
        lowStockThreshold: lowStockThreshold ?? this.lowStockThreshold,
      );
  Part copyWithCompanion(PartsCompanion data) {
    return Part(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      code: data.code.present ? data.code.value : this.code,
      salePrice: data.salePrice.present ? data.salePrice.value : this.salePrice,
      stock: data.stock.present ? data.stock.value : this.stock,
      lowStockThreshold: data.lowStockThreshold.present
          ? data.lowStockThreshold.value
          : this.lowStockThreshold,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Part(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('code: $code, ')
          ..write('salePrice: $salePrice, ')
          ..write('stock: $stock, ')
          ..write('lowStockThreshold: $lowStockThreshold')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, name, code, salePrice, stock, lowStockThreshold);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Part &&
          other.id == this.id &&
          other.name == this.name &&
          other.code == this.code &&
          other.salePrice == this.salePrice &&
          other.stock == this.stock &&
          other.lowStockThreshold == this.lowStockThreshold);
}

class PartsCompanion extends UpdateCompanion<Part> {
  final Value<int> id;
  final Value<String> name;
  final Value<String> code;
  final Value<double> salePrice;
  final Value<int> stock;
  final Value<int> lowStockThreshold;
  const PartsCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.code = const Value.absent(),
    this.salePrice = const Value.absent(),
    this.stock = const Value.absent(),
    this.lowStockThreshold = const Value.absent(),
  });
  PartsCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    required String code,
    required double salePrice,
    required int stock,
    this.lowStockThreshold = const Value.absent(),
  })  : name = Value(name),
        code = Value(code),
        salePrice = Value(salePrice),
        stock = Value(stock);
  static Insertable<Part> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<String>? code,
    Expression<double>? salePrice,
    Expression<int>? stock,
    Expression<int>? lowStockThreshold,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (code != null) 'code': code,
      if (salePrice != null) 'sale_price': salePrice,
      if (stock != null) 'stock': stock,
      if (lowStockThreshold != null) 'low_stock_threshold': lowStockThreshold,
    });
  }

  PartsCompanion copyWith(
      {Value<int>? id,
      Value<String>? name,
      Value<String>? code,
      Value<double>? salePrice,
      Value<int>? stock,
      Value<int>? lowStockThreshold}) {
    return PartsCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      code: code ?? this.code,
      salePrice: salePrice ?? this.salePrice,
      stock: stock ?? this.stock,
      lowStockThreshold: lowStockThreshold ?? this.lowStockThreshold,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (code.present) {
      map['code'] = Variable<String>(code.value);
    }
    if (salePrice.present) {
      map['sale_price'] = Variable<double>(salePrice.value);
    }
    if (stock.present) {
      map['stock'] = Variable<int>(stock.value);
    }
    if (lowStockThreshold.present) {
      map['low_stock_threshold'] = Variable<int>(lowStockThreshold.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PartsCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('code: $code, ')
          ..write('salePrice: $salePrice, ')
          ..write('stock: $stock, ')
          ..write('lowStockThreshold: $lowStockThreshold')
          ..write(')'))
        .toString();
  }
}

class $OrderJobsTable extends OrderJobs
    with TableInfo<$OrderJobsTable, OrderJob> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $OrderJobsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _orderIdMeta =
      const VerificationMeta('orderId');
  @override
  late final GeneratedColumn<int> orderId = GeneratedColumn<int>(
      'order_id', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _descriptionMeta =
      const VerificationMeta('description');
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
      'description', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _laborPriceMeta =
      const VerificationMeta('laborPrice');
  @override
  late final GeneratedColumn<double> laborPrice = GeneratedColumn<double>(
      'labor_price', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [id, orderId, description, laborPrice];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'order_jobs';
  @override
  VerificationContext validateIntegrity(Insertable<OrderJob> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('order_id')) {
      context.handle(_orderIdMeta,
          orderId.isAcceptableOrUnknown(data['order_id']!, _orderIdMeta));
    } else if (isInserting) {
      context.missing(_orderIdMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
          _descriptionMeta,
          description.isAcceptableOrUnknown(
              data['description']!, _descriptionMeta));
    } else if (isInserting) {
      context.missing(_descriptionMeta);
    }
    if (data.containsKey('labor_price')) {
      context.handle(
          _laborPriceMeta,
          laborPrice.isAcceptableOrUnknown(
              data['labor_price']!, _laborPriceMeta));
    } else if (isInserting) {
      context.missing(_laborPriceMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  OrderJob map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return OrderJob(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      orderId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}order_id'])!,
      description: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}description'])!,
      laborPrice: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}labor_price'])!,
    );
  }

  @override
  $OrderJobsTable createAlias(String alias) {
    return $OrderJobsTable(attachedDatabase, alias);
  }
}

class OrderJob extends DataClass implements Insertable<OrderJob> {
  final int id;
  final int orderId;
  final String description;
  final double laborPrice;
  const OrderJob(
      {required this.id,
      required this.orderId,
      required this.description,
      required this.laborPrice});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['order_id'] = Variable<int>(orderId);
    map['description'] = Variable<String>(description);
    map['labor_price'] = Variable<double>(laborPrice);
    return map;
  }

  OrderJobsCompanion toCompanion(bool nullToAbsent) {
    return OrderJobsCompanion(
      id: Value(id),
      orderId: Value(orderId),
      description: Value(description),
      laborPrice: Value(laborPrice),
    );
  }

  factory OrderJob.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return OrderJob(
      id: serializer.fromJson<int>(json['id']),
      orderId: serializer.fromJson<int>(json['orderId']),
      description: serializer.fromJson<String>(json['description']),
      laborPrice: serializer.fromJson<double>(json['laborPrice']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'orderId': serializer.toJson<int>(orderId),
      'description': serializer.toJson<String>(description),
      'laborPrice': serializer.toJson<double>(laborPrice),
    };
  }

  OrderJob copyWith(
          {int? id, int? orderId, String? description, double? laborPrice}) =>
      OrderJob(
        id: id ?? this.id,
        orderId: orderId ?? this.orderId,
        description: description ?? this.description,
        laborPrice: laborPrice ?? this.laborPrice,
      );
  OrderJob copyWithCompanion(OrderJobsCompanion data) {
    return OrderJob(
      id: data.id.present ? data.id.value : this.id,
      orderId: data.orderId.present ? data.orderId.value : this.orderId,
      description:
          data.description.present ? data.description.value : this.description,
      laborPrice:
          data.laborPrice.present ? data.laborPrice.value : this.laborPrice,
    );
  }

  @override
  String toString() {
    return (StringBuffer('OrderJob(')
          ..write('id: $id, ')
          ..write('orderId: $orderId, ')
          ..write('description: $description, ')
          ..write('laborPrice: $laborPrice')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, orderId, description, laborPrice);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is OrderJob &&
          other.id == this.id &&
          other.orderId == this.orderId &&
          other.description == this.description &&
          other.laborPrice == this.laborPrice);
}

class OrderJobsCompanion extends UpdateCompanion<OrderJob> {
  final Value<int> id;
  final Value<int> orderId;
  final Value<String> description;
  final Value<double> laborPrice;
  const OrderJobsCompanion({
    this.id = const Value.absent(),
    this.orderId = const Value.absent(),
    this.description = const Value.absent(),
    this.laborPrice = const Value.absent(),
  });
  OrderJobsCompanion.insert({
    this.id = const Value.absent(),
    required int orderId,
    required String description,
    required double laborPrice,
  })  : orderId = Value(orderId),
        description = Value(description),
        laborPrice = Value(laborPrice);
  static Insertable<OrderJob> custom({
    Expression<int>? id,
    Expression<int>? orderId,
    Expression<String>? description,
    Expression<double>? laborPrice,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (orderId != null) 'order_id': orderId,
      if (description != null) 'description': description,
      if (laborPrice != null) 'labor_price': laborPrice,
    });
  }

  OrderJobsCompanion copyWith(
      {Value<int>? id,
      Value<int>? orderId,
      Value<String>? description,
      Value<double>? laborPrice}) {
    return OrderJobsCompanion(
      id: id ?? this.id,
      orderId: orderId ?? this.orderId,
      description: description ?? this.description,
      laborPrice: laborPrice ?? this.laborPrice,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (orderId.present) {
      map['order_id'] = Variable<int>(orderId.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (laborPrice.present) {
      map['labor_price'] = Variable<double>(laborPrice.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('OrderJobsCompanion(')
          ..write('id: $id, ')
          ..write('orderId: $orderId, ')
          ..write('description: $description, ')
          ..write('laborPrice: $laborPrice')
          ..write(')'))
        .toString();
  }
}

class $OrderPartsTable extends OrderParts
    with TableInfo<$OrderPartsTable, OrderPart> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $OrderPartsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _orderIdMeta =
      const VerificationMeta('orderId');
  @override
  late final GeneratedColumn<int> orderId = GeneratedColumn<int>(
      'order_id', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _partIdMeta = const VerificationMeta('partId');
  @override
  late final GeneratedColumn<int> partId = GeneratedColumn<int>(
      'part_id', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _quantityMeta =
      const VerificationMeta('quantity');
  @override
  late final GeneratedColumn<int> quantity = GeneratedColumn<int>(
      'quantity', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _unitPriceMeta =
      const VerificationMeta('unitPrice');
  @override
  late final GeneratedColumn<double> unitPrice = GeneratedColumn<double>(
      'unit_price', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns =>
      [id, orderId, partId, quantity, unitPrice];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'order_parts';
  @override
  VerificationContext validateIntegrity(Insertable<OrderPart> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('order_id')) {
      context.handle(_orderIdMeta,
          orderId.isAcceptableOrUnknown(data['order_id']!, _orderIdMeta));
    } else if (isInserting) {
      context.missing(_orderIdMeta);
    }
    if (data.containsKey('part_id')) {
      context.handle(_partIdMeta,
          partId.isAcceptableOrUnknown(data['part_id']!, _partIdMeta));
    } else if (isInserting) {
      context.missing(_partIdMeta);
    }
    if (data.containsKey('quantity')) {
      context.handle(_quantityMeta,
          quantity.isAcceptableOrUnknown(data['quantity']!, _quantityMeta));
    } else if (isInserting) {
      context.missing(_quantityMeta);
    }
    if (data.containsKey('unit_price')) {
      context.handle(_unitPriceMeta,
          unitPrice.isAcceptableOrUnknown(data['unit_price']!, _unitPriceMeta));
    } else if (isInserting) {
      context.missing(_unitPriceMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  OrderPart map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return OrderPart(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      orderId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}order_id'])!,
      partId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}part_id'])!,
      quantity: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}quantity'])!,
      unitPrice: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}unit_price'])!,
    );
  }

  @override
  $OrderPartsTable createAlias(String alias) {
    return $OrderPartsTable(attachedDatabase, alias);
  }
}

class OrderPart extends DataClass implements Insertable<OrderPart> {
  final int id;
  final int orderId;
  final int partId;
  final int quantity;
  final double unitPrice;
  const OrderPart(
      {required this.id,
      required this.orderId,
      required this.partId,
      required this.quantity,
      required this.unitPrice});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['order_id'] = Variable<int>(orderId);
    map['part_id'] = Variable<int>(partId);
    map['quantity'] = Variable<int>(quantity);
    map['unit_price'] = Variable<double>(unitPrice);
    return map;
  }

  OrderPartsCompanion toCompanion(bool nullToAbsent) {
    return OrderPartsCompanion(
      id: Value(id),
      orderId: Value(orderId),
      partId: Value(partId),
      quantity: Value(quantity),
      unitPrice: Value(unitPrice),
    );
  }

  factory OrderPart.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return OrderPart(
      id: serializer.fromJson<int>(json['id']),
      orderId: serializer.fromJson<int>(json['orderId']),
      partId: serializer.fromJson<int>(json['partId']),
      quantity: serializer.fromJson<int>(json['quantity']),
      unitPrice: serializer.fromJson<double>(json['unitPrice']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'orderId': serializer.toJson<int>(orderId),
      'partId': serializer.toJson<int>(partId),
      'quantity': serializer.toJson<int>(quantity),
      'unitPrice': serializer.toJson<double>(unitPrice),
    };
  }

  OrderPart copyWith(
          {int? id,
          int? orderId,
          int? partId,
          int? quantity,
          double? unitPrice}) =>
      OrderPart(
        id: id ?? this.id,
        orderId: orderId ?? this.orderId,
        partId: partId ?? this.partId,
        quantity: quantity ?? this.quantity,
        unitPrice: unitPrice ?? this.unitPrice,
      );
  OrderPart copyWithCompanion(OrderPartsCompanion data) {
    return OrderPart(
      id: data.id.present ? data.id.value : this.id,
      orderId: data.orderId.present ? data.orderId.value : this.orderId,
      partId: data.partId.present ? data.partId.value : this.partId,
      quantity: data.quantity.present ? data.quantity.value : this.quantity,
      unitPrice: data.unitPrice.present ? data.unitPrice.value : this.unitPrice,
    );
  }

  @override
  String toString() {
    return (StringBuffer('OrderPart(')
          ..write('id: $id, ')
          ..write('orderId: $orderId, ')
          ..write('partId: $partId, ')
          ..write('quantity: $quantity, ')
          ..write('unitPrice: $unitPrice')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, orderId, partId, quantity, unitPrice);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is OrderPart &&
          other.id == this.id &&
          other.orderId == this.orderId &&
          other.partId == this.partId &&
          other.quantity == this.quantity &&
          other.unitPrice == this.unitPrice);
}

class OrderPartsCompanion extends UpdateCompanion<OrderPart> {
  final Value<int> id;
  final Value<int> orderId;
  final Value<int> partId;
  final Value<int> quantity;
  final Value<double> unitPrice;
  const OrderPartsCompanion({
    this.id = const Value.absent(),
    this.orderId = const Value.absent(),
    this.partId = const Value.absent(),
    this.quantity = const Value.absent(),
    this.unitPrice = const Value.absent(),
  });
  OrderPartsCompanion.insert({
    this.id = const Value.absent(),
    required int orderId,
    required int partId,
    required int quantity,
    required double unitPrice,
  })  : orderId = Value(orderId),
        partId = Value(partId),
        quantity = Value(quantity),
        unitPrice = Value(unitPrice);
  static Insertable<OrderPart> custom({
    Expression<int>? id,
    Expression<int>? orderId,
    Expression<int>? partId,
    Expression<int>? quantity,
    Expression<double>? unitPrice,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (orderId != null) 'order_id': orderId,
      if (partId != null) 'part_id': partId,
      if (quantity != null) 'quantity': quantity,
      if (unitPrice != null) 'unit_price': unitPrice,
    });
  }

  OrderPartsCompanion copyWith(
      {Value<int>? id,
      Value<int>? orderId,
      Value<int>? partId,
      Value<int>? quantity,
      Value<double>? unitPrice}) {
    return OrderPartsCompanion(
      id: id ?? this.id,
      orderId: orderId ?? this.orderId,
      partId: partId ?? this.partId,
      quantity: quantity ?? this.quantity,
      unitPrice: unitPrice ?? this.unitPrice,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (orderId.present) {
      map['order_id'] = Variable<int>(orderId.value);
    }
    if (partId.present) {
      map['part_id'] = Variable<int>(partId.value);
    }
    if (quantity.present) {
      map['quantity'] = Variable<int>(quantity.value);
    }
    if (unitPrice.present) {
      map['unit_price'] = Variable<double>(unitPrice.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('OrderPartsCompanion(')
          ..write('id: $id, ')
          ..write('orderId: $orderId, ')
          ..write('partId: $partId, ')
          ..write('quantity: $quantity, ')
          ..write('unitPrice: $unitPrice')
          ..write(')'))
        .toString();
  }
}

class $PaymentsTable extends Payments with TableInfo<$PaymentsTable, Payment> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PaymentsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _orderIdMeta =
      const VerificationMeta('orderId');
  @override
  late final GeneratedColumn<int> orderId = GeneratedColumn<int>(
      'order_id', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _amountMeta = const VerificationMeta('amount');
  @override
  late final GeneratedColumn<double> amount = GeneratedColumn<double>(
      'amount', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _paidDateMeta =
      const VerificationMeta('paidDate');
  @override
  late final GeneratedColumn<DateTime> paidDate = GeneratedColumn<DateTime>(
      'paid_date', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [id, orderId, amount, paidDate];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'payments';
  @override
  VerificationContext validateIntegrity(Insertable<Payment> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('order_id')) {
      context.handle(_orderIdMeta,
          orderId.isAcceptableOrUnknown(data['order_id']!, _orderIdMeta));
    } else if (isInserting) {
      context.missing(_orderIdMeta);
    }
    if (data.containsKey('amount')) {
      context.handle(_amountMeta,
          amount.isAcceptableOrUnknown(data['amount']!, _amountMeta));
    } else if (isInserting) {
      context.missing(_amountMeta);
    }
    if (data.containsKey('paid_date')) {
      context.handle(_paidDateMeta,
          paidDate.isAcceptableOrUnknown(data['paid_date']!, _paidDateMeta));
    } else if (isInserting) {
      context.missing(_paidDateMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Payment map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Payment(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      orderId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}order_id'])!,
      amount: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}amount'])!,
      paidDate: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}paid_date'])!,
    );
  }

  @override
  $PaymentsTable createAlias(String alias) {
    return $PaymentsTable(attachedDatabase, alias);
  }
}

class Payment extends DataClass implements Insertable<Payment> {
  final int id;
  final int orderId;
  final double amount;
  final DateTime paidDate;
  const Payment(
      {required this.id,
      required this.orderId,
      required this.amount,
      required this.paidDate});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['order_id'] = Variable<int>(orderId);
    map['amount'] = Variable<double>(amount);
    map['paid_date'] = Variable<DateTime>(paidDate);
    return map;
  }

  PaymentsCompanion toCompanion(bool nullToAbsent) {
    return PaymentsCompanion(
      id: Value(id),
      orderId: Value(orderId),
      amount: Value(amount),
      paidDate: Value(paidDate),
    );
  }

  factory Payment.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Payment(
      id: serializer.fromJson<int>(json['id']),
      orderId: serializer.fromJson<int>(json['orderId']),
      amount: serializer.fromJson<double>(json['amount']),
      paidDate: serializer.fromJson<DateTime>(json['paidDate']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'orderId': serializer.toJson<int>(orderId),
      'amount': serializer.toJson<double>(amount),
      'paidDate': serializer.toJson<DateTime>(paidDate),
    };
  }

  Payment copyWith(
          {int? id, int? orderId, double? amount, DateTime? paidDate}) =>
      Payment(
        id: id ?? this.id,
        orderId: orderId ?? this.orderId,
        amount: amount ?? this.amount,
        paidDate: paidDate ?? this.paidDate,
      );
  Payment copyWithCompanion(PaymentsCompanion data) {
    return Payment(
      id: data.id.present ? data.id.value : this.id,
      orderId: data.orderId.present ? data.orderId.value : this.orderId,
      amount: data.amount.present ? data.amount.value : this.amount,
      paidDate: data.paidDate.present ? data.paidDate.value : this.paidDate,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Payment(')
          ..write('id: $id, ')
          ..write('orderId: $orderId, ')
          ..write('amount: $amount, ')
          ..write('paidDate: $paidDate')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, orderId, amount, paidDate);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Payment &&
          other.id == this.id &&
          other.orderId == this.orderId &&
          other.amount == this.amount &&
          other.paidDate == this.paidDate);
}

class PaymentsCompanion extends UpdateCompanion<Payment> {
  final Value<int> id;
  final Value<int> orderId;
  final Value<double> amount;
  final Value<DateTime> paidDate;
  const PaymentsCompanion({
    this.id = const Value.absent(),
    this.orderId = const Value.absent(),
    this.amount = const Value.absent(),
    this.paidDate = const Value.absent(),
  });
  PaymentsCompanion.insert({
    this.id = const Value.absent(),
    required int orderId,
    required double amount,
    required DateTime paidDate,
  })  : orderId = Value(orderId),
        amount = Value(amount),
        paidDate = Value(paidDate);
  static Insertable<Payment> custom({
    Expression<int>? id,
    Expression<int>? orderId,
    Expression<double>? amount,
    Expression<DateTime>? paidDate,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (orderId != null) 'order_id': orderId,
      if (amount != null) 'amount': amount,
      if (paidDate != null) 'paid_date': paidDate,
    });
  }

  PaymentsCompanion copyWith(
      {Value<int>? id,
      Value<int>? orderId,
      Value<double>? amount,
      Value<DateTime>? paidDate}) {
    return PaymentsCompanion(
      id: id ?? this.id,
      orderId: orderId ?? this.orderId,
      amount: amount ?? this.amount,
      paidDate: paidDate ?? this.paidDate,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (orderId.present) {
      map['order_id'] = Variable<int>(orderId.value);
    }
    if (amount.present) {
      map['amount'] = Variable<double>(amount.value);
    }
    if (paidDate.present) {
      map['paid_date'] = Variable<DateTime>(paidDate.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PaymentsCompanion(')
          ..write('id: $id, ')
          ..write('orderId: $orderId, ')
          ..write('amount: $amount, ')
          ..write('paidDate: $paidDate')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $ClientsTable clients = $ClientsTable(this);
  late final $VehiclesTable vehicles = $VehiclesTable(this);
  late final $MechanicsTable mechanics = $MechanicsTable(this);
  late final $ServiceOrdersTable serviceOrders = $ServiceOrdersTable(this);
  late final $PartsTable parts = $PartsTable(this);
  late final $OrderJobsTable orderJobs = $OrderJobsTable(this);
  late final $OrderPartsTable orderParts = $OrderPartsTable(this);
  late final $PaymentsTable payments = $PaymentsTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
        clients,
        vehicles,
        mechanics,
        serviceOrders,
        parts,
        orderJobs,
        orderParts,
        payments
      ];
}

typedef $$ClientsTableCreateCompanionBuilder = ClientsCompanion Function({
  Value<int> id,
  required String name,
  required String phone,
  Value<String?> address,
});
typedef $$ClientsTableUpdateCompanionBuilder = ClientsCompanion Function({
  Value<int> id,
  Value<String> name,
  Value<String> phone,
  Value<String?> address,
});

class $$ClientsTableFilterComposer
    extends Composer<_$AppDatabase, $ClientsTable> {
  $$ClientsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get phone => $composableBuilder(
      column: $table.phone, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get address => $composableBuilder(
      column: $table.address, builder: (column) => ColumnFilters(column));
}

class $$ClientsTableOrderingComposer
    extends Composer<_$AppDatabase, $ClientsTable> {
  $$ClientsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get phone => $composableBuilder(
      column: $table.phone, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get address => $composableBuilder(
      column: $table.address, builder: (column) => ColumnOrderings(column));
}

class $$ClientsTableAnnotationComposer
    extends Composer<_$AppDatabase, $ClientsTable> {
  $$ClientsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get phone =>
      $composableBuilder(column: $table.phone, builder: (column) => column);

  GeneratedColumn<String> get address =>
      $composableBuilder(column: $table.address, builder: (column) => column);
}

class $$ClientsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $ClientsTable,
    Client,
    $$ClientsTableFilterComposer,
    $$ClientsTableOrderingComposer,
    $$ClientsTableAnnotationComposer,
    $$ClientsTableCreateCompanionBuilder,
    $$ClientsTableUpdateCompanionBuilder,
    (Client, BaseReferences<_$AppDatabase, $ClientsTable, Client>),
    Client,
    PrefetchHooks Function()> {
  $$ClientsTableTableManager(_$AppDatabase db, $ClientsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ClientsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ClientsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ClientsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> name = const Value.absent(),
            Value<String> phone = const Value.absent(),
            Value<String?> address = const Value.absent(),
          }) =>
              ClientsCompanion(
            id: id,
            name: name,
            phone: phone,
            address: address,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String name,
            required String phone,
            Value<String?> address = const Value.absent(),
          }) =>
              ClientsCompanion.insert(
            id: id,
            name: name,
            phone: phone,
            address: address,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$ClientsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $ClientsTable,
    Client,
    $$ClientsTableFilterComposer,
    $$ClientsTableOrderingComposer,
    $$ClientsTableAnnotationComposer,
    $$ClientsTableCreateCompanionBuilder,
    $$ClientsTableUpdateCompanionBuilder,
    (Client, BaseReferences<_$AppDatabase, $ClientsTable, Client>),
    Client,
    PrefetchHooks Function()>;
typedef $$VehiclesTableCreateCompanionBuilder = VehiclesCompanion Function({
  Value<int> id,
  required int clientId,
  required String plate,
  required String brand,
  required String model,
  required int year,
  required int mileage,
});
typedef $$VehiclesTableUpdateCompanionBuilder = VehiclesCompanion Function({
  Value<int> id,
  Value<int> clientId,
  Value<String> plate,
  Value<String> brand,
  Value<String> model,
  Value<int> year,
  Value<int> mileage,
});

class $$VehiclesTableFilterComposer
    extends Composer<_$AppDatabase, $VehiclesTable> {
  $$VehiclesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get clientId => $composableBuilder(
      column: $table.clientId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get plate => $composableBuilder(
      column: $table.plate, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get brand => $composableBuilder(
      column: $table.brand, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get model => $composableBuilder(
      column: $table.model, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get year => $composableBuilder(
      column: $table.year, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get mileage => $composableBuilder(
      column: $table.mileage, builder: (column) => ColumnFilters(column));
}

class $$VehiclesTableOrderingComposer
    extends Composer<_$AppDatabase, $VehiclesTable> {
  $$VehiclesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get clientId => $composableBuilder(
      column: $table.clientId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get plate => $composableBuilder(
      column: $table.plate, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get brand => $composableBuilder(
      column: $table.brand, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get model => $composableBuilder(
      column: $table.model, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get year => $composableBuilder(
      column: $table.year, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get mileage => $composableBuilder(
      column: $table.mileage, builder: (column) => ColumnOrderings(column));
}

class $$VehiclesTableAnnotationComposer
    extends Composer<_$AppDatabase, $VehiclesTable> {
  $$VehiclesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get clientId =>
      $composableBuilder(column: $table.clientId, builder: (column) => column);

  GeneratedColumn<String> get plate =>
      $composableBuilder(column: $table.plate, builder: (column) => column);

  GeneratedColumn<String> get brand =>
      $composableBuilder(column: $table.brand, builder: (column) => column);

  GeneratedColumn<String> get model =>
      $composableBuilder(column: $table.model, builder: (column) => column);

  GeneratedColumn<int> get year =>
      $composableBuilder(column: $table.year, builder: (column) => column);

  GeneratedColumn<int> get mileage =>
      $composableBuilder(column: $table.mileage, builder: (column) => column);
}

class $$VehiclesTableTableManager extends RootTableManager<
    _$AppDatabase,
    $VehiclesTable,
    Vehicle,
    $$VehiclesTableFilterComposer,
    $$VehiclesTableOrderingComposer,
    $$VehiclesTableAnnotationComposer,
    $$VehiclesTableCreateCompanionBuilder,
    $$VehiclesTableUpdateCompanionBuilder,
    (Vehicle, BaseReferences<_$AppDatabase, $VehiclesTable, Vehicle>),
    Vehicle,
    PrefetchHooks Function()> {
  $$VehiclesTableTableManager(_$AppDatabase db, $VehiclesTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$VehiclesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$VehiclesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$VehiclesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<int> clientId = const Value.absent(),
            Value<String> plate = const Value.absent(),
            Value<String> brand = const Value.absent(),
            Value<String> model = const Value.absent(),
            Value<int> year = const Value.absent(),
            Value<int> mileage = const Value.absent(),
          }) =>
              VehiclesCompanion(
            id: id,
            clientId: clientId,
            plate: plate,
            brand: brand,
            model: model,
            year: year,
            mileage: mileage,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required int clientId,
            required String plate,
            required String brand,
            required String model,
            required int year,
            required int mileage,
          }) =>
              VehiclesCompanion.insert(
            id: id,
            clientId: clientId,
            plate: plate,
            brand: brand,
            model: model,
            year: year,
            mileage: mileage,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$VehiclesTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $VehiclesTable,
    Vehicle,
    $$VehiclesTableFilterComposer,
    $$VehiclesTableOrderingComposer,
    $$VehiclesTableAnnotationComposer,
    $$VehiclesTableCreateCompanionBuilder,
    $$VehiclesTableUpdateCompanionBuilder,
    (Vehicle, BaseReferences<_$AppDatabase, $VehiclesTable, Vehicle>),
    Vehicle,
    PrefetchHooks Function()>;
typedef $$MechanicsTableCreateCompanionBuilder = MechanicsCompanion Function({
  Value<int> id,
  required String name,
});
typedef $$MechanicsTableUpdateCompanionBuilder = MechanicsCompanion Function({
  Value<int> id,
  Value<String> name,
});

class $$MechanicsTableFilterComposer
    extends Composer<_$AppDatabase, $MechanicsTable> {
  $$MechanicsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnFilters(column));
}

class $$MechanicsTableOrderingComposer
    extends Composer<_$AppDatabase, $MechanicsTable> {
  $$MechanicsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnOrderings(column));
}

class $$MechanicsTableAnnotationComposer
    extends Composer<_$AppDatabase, $MechanicsTable> {
  $$MechanicsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);
}

class $$MechanicsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $MechanicsTable,
    Mechanic,
    $$MechanicsTableFilterComposer,
    $$MechanicsTableOrderingComposer,
    $$MechanicsTableAnnotationComposer,
    $$MechanicsTableCreateCompanionBuilder,
    $$MechanicsTableUpdateCompanionBuilder,
    (Mechanic, BaseReferences<_$AppDatabase, $MechanicsTable, Mechanic>),
    Mechanic,
    PrefetchHooks Function()> {
  $$MechanicsTableTableManager(_$AppDatabase db, $MechanicsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$MechanicsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$MechanicsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$MechanicsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> name = const Value.absent(),
          }) =>
              MechanicsCompanion(
            id: id,
            name: name,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String name,
          }) =>
              MechanicsCompanion.insert(
            id: id,
            name: name,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$MechanicsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $MechanicsTable,
    Mechanic,
    $$MechanicsTableFilterComposer,
    $$MechanicsTableOrderingComposer,
    $$MechanicsTableAnnotationComposer,
    $$MechanicsTableCreateCompanionBuilder,
    $$MechanicsTableUpdateCompanionBuilder,
    (Mechanic, BaseReferences<_$AppDatabase, $MechanicsTable, Mechanic>),
    Mechanic,
    PrefetchHooks Function()>;
typedef $$ServiceOrdersTableCreateCompanionBuilder = ServiceOrdersCompanion
    Function({
  Value<int> id,
  required int vehicleId,
  required int mechanicId,
  required DateTime entryDate,
  required String reportedProblem,
  required OrderStatus status,
});
typedef $$ServiceOrdersTableUpdateCompanionBuilder = ServiceOrdersCompanion
    Function({
  Value<int> id,
  Value<int> vehicleId,
  Value<int> mechanicId,
  Value<DateTime> entryDate,
  Value<String> reportedProblem,
  Value<OrderStatus> status,
});

class $$ServiceOrdersTableFilterComposer
    extends Composer<_$AppDatabase, $ServiceOrdersTable> {
  $$ServiceOrdersTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get vehicleId => $composableBuilder(
      column: $table.vehicleId, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get mechanicId => $composableBuilder(
      column: $table.mechanicId, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get entryDate => $composableBuilder(
      column: $table.entryDate, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get reportedProblem => $composableBuilder(
      column: $table.reportedProblem,
      builder: (column) => ColumnFilters(column));

  ColumnWithTypeConverterFilters<OrderStatus, OrderStatus, int> get status =>
      $composableBuilder(
          column: $table.status,
          builder: (column) => ColumnWithTypeConverterFilters(column));
}

class $$ServiceOrdersTableOrderingComposer
    extends Composer<_$AppDatabase, $ServiceOrdersTable> {
  $$ServiceOrdersTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get vehicleId => $composableBuilder(
      column: $table.vehicleId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get mechanicId => $composableBuilder(
      column: $table.mechanicId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get entryDate => $composableBuilder(
      column: $table.entryDate, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get reportedProblem => $composableBuilder(
      column: $table.reportedProblem,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get status => $composableBuilder(
      column: $table.status, builder: (column) => ColumnOrderings(column));
}

class $$ServiceOrdersTableAnnotationComposer
    extends Composer<_$AppDatabase, $ServiceOrdersTable> {
  $$ServiceOrdersTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get vehicleId =>
      $composableBuilder(column: $table.vehicleId, builder: (column) => column);

  GeneratedColumn<int> get mechanicId => $composableBuilder(
      column: $table.mechanicId, builder: (column) => column);

  GeneratedColumn<DateTime> get entryDate =>
      $composableBuilder(column: $table.entryDate, builder: (column) => column);

  GeneratedColumn<String> get reportedProblem => $composableBuilder(
      column: $table.reportedProblem, builder: (column) => column);

  GeneratedColumnWithTypeConverter<OrderStatus, int> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);
}

class $$ServiceOrdersTableTableManager extends RootTableManager<
    _$AppDatabase,
    $ServiceOrdersTable,
    ServiceOrder,
    $$ServiceOrdersTableFilterComposer,
    $$ServiceOrdersTableOrderingComposer,
    $$ServiceOrdersTableAnnotationComposer,
    $$ServiceOrdersTableCreateCompanionBuilder,
    $$ServiceOrdersTableUpdateCompanionBuilder,
    (
      ServiceOrder,
      BaseReferences<_$AppDatabase, $ServiceOrdersTable, ServiceOrder>
    ),
    ServiceOrder,
    PrefetchHooks Function()> {
  $$ServiceOrdersTableTableManager(_$AppDatabase db, $ServiceOrdersTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ServiceOrdersTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ServiceOrdersTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ServiceOrdersTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<int> vehicleId = const Value.absent(),
            Value<int> mechanicId = const Value.absent(),
            Value<DateTime> entryDate = const Value.absent(),
            Value<String> reportedProblem = const Value.absent(),
            Value<OrderStatus> status = const Value.absent(),
          }) =>
              ServiceOrdersCompanion(
            id: id,
            vehicleId: vehicleId,
            mechanicId: mechanicId,
            entryDate: entryDate,
            reportedProblem: reportedProblem,
            status: status,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required int vehicleId,
            required int mechanicId,
            required DateTime entryDate,
            required String reportedProblem,
            required OrderStatus status,
          }) =>
              ServiceOrdersCompanion.insert(
            id: id,
            vehicleId: vehicleId,
            mechanicId: mechanicId,
            entryDate: entryDate,
            reportedProblem: reportedProblem,
            status: status,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$ServiceOrdersTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $ServiceOrdersTable,
    ServiceOrder,
    $$ServiceOrdersTableFilterComposer,
    $$ServiceOrdersTableOrderingComposer,
    $$ServiceOrdersTableAnnotationComposer,
    $$ServiceOrdersTableCreateCompanionBuilder,
    $$ServiceOrdersTableUpdateCompanionBuilder,
    (
      ServiceOrder,
      BaseReferences<_$AppDatabase, $ServiceOrdersTable, ServiceOrder>
    ),
    ServiceOrder,
    PrefetchHooks Function()>;
typedef $$PartsTableCreateCompanionBuilder = PartsCompanion Function({
  Value<int> id,
  required String name,
  required String code,
  required double salePrice,
  required int stock,
  Value<int> lowStockThreshold,
});
typedef $$PartsTableUpdateCompanionBuilder = PartsCompanion Function({
  Value<int> id,
  Value<String> name,
  Value<String> code,
  Value<double> salePrice,
  Value<int> stock,
  Value<int> lowStockThreshold,
});

class $$PartsTableFilterComposer extends Composer<_$AppDatabase, $PartsTable> {
  $$PartsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get code => $composableBuilder(
      column: $table.code, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get salePrice => $composableBuilder(
      column: $table.salePrice, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get stock => $composableBuilder(
      column: $table.stock, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get lowStockThreshold => $composableBuilder(
      column: $table.lowStockThreshold,
      builder: (column) => ColumnFilters(column));
}

class $$PartsTableOrderingComposer
    extends Composer<_$AppDatabase, $PartsTable> {
  $$PartsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get code => $composableBuilder(
      column: $table.code, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get salePrice => $composableBuilder(
      column: $table.salePrice, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get stock => $composableBuilder(
      column: $table.stock, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get lowStockThreshold => $composableBuilder(
      column: $table.lowStockThreshold,
      builder: (column) => ColumnOrderings(column));
}

class $$PartsTableAnnotationComposer
    extends Composer<_$AppDatabase, $PartsTable> {
  $$PartsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get code =>
      $composableBuilder(column: $table.code, builder: (column) => column);

  GeneratedColumn<double> get salePrice =>
      $composableBuilder(column: $table.salePrice, builder: (column) => column);

  GeneratedColumn<int> get stock =>
      $composableBuilder(column: $table.stock, builder: (column) => column);

  GeneratedColumn<int> get lowStockThreshold => $composableBuilder(
      column: $table.lowStockThreshold, builder: (column) => column);
}

class $$PartsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $PartsTable,
    Part,
    $$PartsTableFilterComposer,
    $$PartsTableOrderingComposer,
    $$PartsTableAnnotationComposer,
    $$PartsTableCreateCompanionBuilder,
    $$PartsTableUpdateCompanionBuilder,
    (Part, BaseReferences<_$AppDatabase, $PartsTable, Part>),
    Part,
    PrefetchHooks Function()> {
  $$PartsTableTableManager(_$AppDatabase db, $PartsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PartsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$PartsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$PartsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> name = const Value.absent(),
            Value<String> code = const Value.absent(),
            Value<double> salePrice = const Value.absent(),
            Value<int> stock = const Value.absent(),
            Value<int> lowStockThreshold = const Value.absent(),
          }) =>
              PartsCompanion(
            id: id,
            name: name,
            code: code,
            salePrice: salePrice,
            stock: stock,
            lowStockThreshold: lowStockThreshold,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String name,
            required String code,
            required double salePrice,
            required int stock,
            Value<int> lowStockThreshold = const Value.absent(),
          }) =>
              PartsCompanion.insert(
            id: id,
            name: name,
            code: code,
            salePrice: salePrice,
            stock: stock,
            lowStockThreshold: lowStockThreshold,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$PartsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $PartsTable,
    Part,
    $$PartsTableFilterComposer,
    $$PartsTableOrderingComposer,
    $$PartsTableAnnotationComposer,
    $$PartsTableCreateCompanionBuilder,
    $$PartsTableUpdateCompanionBuilder,
    (Part, BaseReferences<_$AppDatabase, $PartsTable, Part>),
    Part,
    PrefetchHooks Function()>;
typedef $$OrderJobsTableCreateCompanionBuilder = OrderJobsCompanion Function({
  Value<int> id,
  required int orderId,
  required String description,
  required double laborPrice,
});
typedef $$OrderJobsTableUpdateCompanionBuilder = OrderJobsCompanion Function({
  Value<int> id,
  Value<int> orderId,
  Value<String> description,
  Value<double> laborPrice,
});

class $$OrderJobsTableFilterComposer
    extends Composer<_$AppDatabase, $OrderJobsTable> {
  $$OrderJobsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get orderId => $composableBuilder(
      column: $table.orderId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get description => $composableBuilder(
      column: $table.description, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get laborPrice => $composableBuilder(
      column: $table.laborPrice, builder: (column) => ColumnFilters(column));
}

class $$OrderJobsTableOrderingComposer
    extends Composer<_$AppDatabase, $OrderJobsTable> {
  $$OrderJobsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get orderId => $composableBuilder(
      column: $table.orderId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get description => $composableBuilder(
      column: $table.description, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get laborPrice => $composableBuilder(
      column: $table.laborPrice, builder: (column) => ColumnOrderings(column));
}

class $$OrderJobsTableAnnotationComposer
    extends Composer<_$AppDatabase, $OrderJobsTable> {
  $$OrderJobsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get orderId =>
      $composableBuilder(column: $table.orderId, builder: (column) => column);

  GeneratedColumn<String> get description => $composableBuilder(
      column: $table.description, builder: (column) => column);

  GeneratedColumn<double> get laborPrice => $composableBuilder(
      column: $table.laborPrice, builder: (column) => column);
}

class $$OrderJobsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $OrderJobsTable,
    OrderJob,
    $$OrderJobsTableFilterComposer,
    $$OrderJobsTableOrderingComposer,
    $$OrderJobsTableAnnotationComposer,
    $$OrderJobsTableCreateCompanionBuilder,
    $$OrderJobsTableUpdateCompanionBuilder,
    (OrderJob, BaseReferences<_$AppDatabase, $OrderJobsTable, OrderJob>),
    OrderJob,
    PrefetchHooks Function()> {
  $$OrderJobsTableTableManager(_$AppDatabase db, $OrderJobsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$OrderJobsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$OrderJobsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$OrderJobsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<int> orderId = const Value.absent(),
            Value<String> description = const Value.absent(),
            Value<double> laborPrice = const Value.absent(),
          }) =>
              OrderJobsCompanion(
            id: id,
            orderId: orderId,
            description: description,
            laborPrice: laborPrice,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required int orderId,
            required String description,
            required double laborPrice,
          }) =>
              OrderJobsCompanion.insert(
            id: id,
            orderId: orderId,
            description: description,
            laborPrice: laborPrice,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$OrderJobsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $OrderJobsTable,
    OrderJob,
    $$OrderJobsTableFilterComposer,
    $$OrderJobsTableOrderingComposer,
    $$OrderJobsTableAnnotationComposer,
    $$OrderJobsTableCreateCompanionBuilder,
    $$OrderJobsTableUpdateCompanionBuilder,
    (OrderJob, BaseReferences<_$AppDatabase, $OrderJobsTable, OrderJob>),
    OrderJob,
    PrefetchHooks Function()>;
typedef $$OrderPartsTableCreateCompanionBuilder = OrderPartsCompanion Function({
  Value<int> id,
  required int orderId,
  required int partId,
  required int quantity,
  required double unitPrice,
});
typedef $$OrderPartsTableUpdateCompanionBuilder = OrderPartsCompanion Function({
  Value<int> id,
  Value<int> orderId,
  Value<int> partId,
  Value<int> quantity,
  Value<double> unitPrice,
});

class $$OrderPartsTableFilterComposer
    extends Composer<_$AppDatabase, $OrderPartsTable> {
  $$OrderPartsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get orderId => $composableBuilder(
      column: $table.orderId, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get partId => $composableBuilder(
      column: $table.partId, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get quantity => $composableBuilder(
      column: $table.quantity, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get unitPrice => $composableBuilder(
      column: $table.unitPrice, builder: (column) => ColumnFilters(column));
}

class $$OrderPartsTableOrderingComposer
    extends Composer<_$AppDatabase, $OrderPartsTable> {
  $$OrderPartsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get orderId => $composableBuilder(
      column: $table.orderId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get partId => $composableBuilder(
      column: $table.partId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get quantity => $composableBuilder(
      column: $table.quantity, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get unitPrice => $composableBuilder(
      column: $table.unitPrice, builder: (column) => ColumnOrderings(column));
}

class $$OrderPartsTableAnnotationComposer
    extends Composer<_$AppDatabase, $OrderPartsTable> {
  $$OrderPartsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get orderId =>
      $composableBuilder(column: $table.orderId, builder: (column) => column);

  GeneratedColumn<int> get partId =>
      $composableBuilder(column: $table.partId, builder: (column) => column);

  GeneratedColumn<int> get quantity =>
      $composableBuilder(column: $table.quantity, builder: (column) => column);

  GeneratedColumn<double> get unitPrice =>
      $composableBuilder(column: $table.unitPrice, builder: (column) => column);
}

class $$OrderPartsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $OrderPartsTable,
    OrderPart,
    $$OrderPartsTableFilterComposer,
    $$OrderPartsTableOrderingComposer,
    $$OrderPartsTableAnnotationComposer,
    $$OrderPartsTableCreateCompanionBuilder,
    $$OrderPartsTableUpdateCompanionBuilder,
    (OrderPart, BaseReferences<_$AppDatabase, $OrderPartsTable, OrderPart>),
    OrderPart,
    PrefetchHooks Function()> {
  $$OrderPartsTableTableManager(_$AppDatabase db, $OrderPartsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$OrderPartsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$OrderPartsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$OrderPartsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<int> orderId = const Value.absent(),
            Value<int> partId = const Value.absent(),
            Value<int> quantity = const Value.absent(),
            Value<double> unitPrice = const Value.absent(),
          }) =>
              OrderPartsCompanion(
            id: id,
            orderId: orderId,
            partId: partId,
            quantity: quantity,
            unitPrice: unitPrice,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required int orderId,
            required int partId,
            required int quantity,
            required double unitPrice,
          }) =>
              OrderPartsCompanion.insert(
            id: id,
            orderId: orderId,
            partId: partId,
            quantity: quantity,
            unitPrice: unitPrice,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$OrderPartsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $OrderPartsTable,
    OrderPart,
    $$OrderPartsTableFilterComposer,
    $$OrderPartsTableOrderingComposer,
    $$OrderPartsTableAnnotationComposer,
    $$OrderPartsTableCreateCompanionBuilder,
    $$OrderPartsTableUpdateCompanionBuilder,
    (OrderPart, BaseReferences<_$AppDatabase, $OrderPartsTable, OrderPart>),
    OrderPart,
    PrefetchHooks Function()>;
typedef $$PaymentsTableCreateCompanionBuilder = PaymentsCompanion Function({
  Value<int> id,
  required int orderId,
  required double amount,
  required DateTime paidDate,
});
typedef $$PaymentsTableUpdateCompanionBuilder = PaymentsCompanion Function({
  Value<int> id,
  Value<int> orderId,
  Value<double> amount,
  Value<DateTime> paidDate,
});

class $$PaymentsTableFilterComposer
    extends Composer<_$AppDatabase, $PaymentsTable> {
  $$PaymentsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get orderId => $composableBuilder(
      column: $table.orderId, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get amount => $composableBuilder(
      column: $table.amount, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get paidDate => $composableBuilder(
      column: $table.paidDate, builder: (column) => ColumnFilters(column));
}

class $$PaymentsTableOrderingComposer
    extends Composer<_$AppDatabase, $PaymentsTable> {
  $$PaymentsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get orderId => $composableBuilder(
      column: $table.orderId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get amount => $composableBuilder(
      column: $table.amount, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get paidDate => $composableBuilder(
      column: $table.paidDate, builder: (column) => ColumnOrderings(column));
}

class $$PaymentsTableAnnotationComposer
    extends Composer<_$AppDatabase, $PaymentsTable> {
  $$PaymentsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get orderId =>
      $composableBuilder(column: $table.orderId, builder: (column) => column);

  GeneratedColumn<double> get amount =>
      $composableBuilder(column: $table.amount, builder: (column) => column);

  GeneratedColumn<DateTime> get paidDate =>
      $composableBuilder(column: $table.paidDate, builder: (column) => column);
}

class $$PaymentsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $PaymentsTable,
    Payment,
    $$PaymentsTableFilterComposer,
    $$PaymentsTableOrderingComposer,
    $$PaymentsTableAnnotationComposer,
    $$PaymentsTableCreateCompanionBuilder,
    $$PaymentsTableUpdateCompanionBuilder,
    (Payment, BaseReferences<_$AppDatabase, $PaymentsTable, Payment>),
    Payment,
    PrefetchHooks Function()> {
  $$PaymentsTableTableManager(_$AppDatabase db, $PaymentsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PaymentsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$PaymentsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$PaymentsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<int> orderId = const Value.absent(),
            Value<double> amount = const Value.absent(),
            Value<DateTime> paidDate = const Value.absent(),
          }) =>
              PaymentsCompanion(
            id: id,
            orderId: orderId,
            amount: amount,
            paidDate: paidDate,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required int orderId,
            required double amount,
            required DateTime paidDate,
          }) =>
              PaymentsCompanion.insert(
            id: id,
            orderId: orderId,
            amount: amount,
            paidDate: paidDate,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$PaymentsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $PaymentsTable,
    Payment,
    $$PaymentsTableFilterComposer,
    $$PaymentsTableOrderingComposer,
    $$PaymentsTableAnnotationComposer,
    $$PaymentsTableCreateCompanionBuilder,
    $$PaymentsTableUpdateCompanionBuilder,
    (Payment, BaseReferences<_$AppDatabase, $PaymentsTable, Payment>),
    Payment,
    PrefetchHooks Function()>;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$ClientsTableTableManager get clients =>
      $$ClientsTableTableManager(_db, _db.clients);
  $$VehiclesTableTableManager get vehicles =>
      $$VehiclesTableTableManager(_db, _db.vehicles);
  $$MechanicsTableTableManager get mechanics =>
      $$MechanicsTableTableManager(_db, _db.mechanics);
  $$ServiceOrdersTableTableManager get serviceOrders =>
      $$ServiceOrdersTableTableManager(_db, _db.serviceOrders);
  $$PartsTableTableManager get parts =>
      $$PartsTableTableManager(_db, _db.parts);
  $$OrderJobsTableTableManager get orderJobs =>
      $$OrderJobsTableTableManager(_db, _db.orderJobs);
  $$OrderPartsTableTableManager get orderParts =>
      $$OrderPartsTableTableManager(_db, _db.orderParts);
  $$PaymentsTableTableManager get payments =>
      $$PaymentsTableTableManager(_db, _db.payments);
}
