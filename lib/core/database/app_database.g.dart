// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $ClientsTable extends Clients with TableInfo<$ClientsTable, Client> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ClientsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _remoteIdMeta = const VerificationMeta(
    'remoteId',
  );
  @override
  late final GeneratedColumn<int> remoteId = GeneratedColumn<int>(
    'remote_id',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  late final GeneratedColumnWithTypeConverter<List<String>?, String> phone =
      GeneratedColumn<String>(
        'phone',
        aliasedName,
        true,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
      ).withConverter<List<String>?>($ClientsTable.$converterphonen);
  static const VerificationMeta _emailMeta = const VerificationMeta('email');
  @override
  late final GeneratedColumn<String> email = GeneratedColumn<String>(
    'email',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _categoryMeta = const VerificationMeta(
    'category',
  );
  @override
  late final GeneratedColumn<String> category = GeneratedColumn<String>(
    'category',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _agentIdMeta = const VerificationMeta(
    'agentId',
  );
  @override
  late final GeneratedColumn<int> agentId = GeneratedColumn<int>(
    'agent_id',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _branchIdMeta = const VerificationMeta(
    'branchId',
  );
  @override
  late final GeneratedColumn<int> branchId = GeneratedColumn<int>(
    'branch_id',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _addressMeta = const VerificationMeta(
    'address',
  );
  @override
  late final GeneratedColumn<String> address = GeneratedColumn<String>(
    'address',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _gpsLocationMeta = const VerificationMeta(
    'gpsLocation',
  );
  @override
  late final GeneratedColumn<String> gpsLocation = GeneratedColumn<String>(
    'gps_location',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  late final GeneratedColumnWithTypeConverter<List<String>?, String> images =
      GeneratedColumn<String>(
        'images',
        aliasedName,
        true,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
      ).withConverter<List<String>?>($ClientsTable.$converterimagesn);
  static const VerificationMeta _profileImageMeta = const VerificationMeta(
    'profileImage',
  );
  @override
  late final GeneratedColumn<String> profileImage = GeneratedColumn<String>(
    'profile_image',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _importanceMeta = const VerificationMeta(
    'importance',
  );
  @override
  late final GeneratedColumn<String> importance = GeneratedColumn<String>(
    'importance',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _provinceMeta = const VerificationMeta(
    'province',
  );
  @override
  late final GeneratedColumn<String> province = GeneratedColumn<String>(
    'province',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _districtMeta = const VerificationMeta(
    'district',
  );
  @override
  late final GeneratedColumn<String> district = GeneratedColumn<String>(
    'district',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
    'notes',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _isAgentMeta = const VerificationMeta(
    'isAgent',
  );
  @override
  late final GeneratedColumn<bool> isAgent = GeneratedColumn<bool>(
    'is_agent',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_agent" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _lastVisitMeta = const VerificationMeta(
    'lastVisit',
  );
  @override
  late final GeneratedColumn<DateTime> lastVisit = GeneratedColumn<DateTime>(
    'last_visit',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _loyaltyLevelMeta = const VerificationMeta(
    'loyaltyLevel',
  );
  @override
  late final GeneratedColumn<String> loyaltyLevel = GeneratedColumn<String>(
    'loyalty_level',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _isDraftMeta = const VerificationMeta(
    'isDraft',
  );
  @override
  late final GeneratedColumn<bool> isDraft = GeneratedColumn<bool>(
    'is_draft',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_draft" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    remoteId,
    name,
    phone,
    email,
    category,
    agentId,
    branchId,
    address,
    gpsLocation,
    images,
    profileImage,
    importance,
    province,
    district,
    notes,
    isAgent,
    lastVisit,
    loyaltyLevel,
    isDraft,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'clients';
  @override
  VerificationContext validateIntegrity(
    Insertable<Client> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('remote_id')) {
      context.handle(
        _remoteIdMeta,
        remoteId.isAcceptableOrUnknown(data['remote_id']!, _remoteIdMeta),
      );
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('email')) {
      context.handle(
        _emailMeta,
        email.isAcceptableOrUnknown(data['email']!, _emailMeta),
      );
    }
    if (data.containsKey('category')) {
      context.handle(
        _categoryMeta,
        category.isAcceptableOrUnknown(data['category']!, _categoryMeta),
      );
    }
    if (data.containsKey('agent_id')) {
      context.handle(
        _agentIdMeta,
        agentId.isAcceptableOrUnknown(data['agent_id']!, _agentIdMeta),
      );
    }
    if (data.containsKey('branch_id')) {
      context.handle(
        _branchIdMeta,
        branchId.isAcceptableOrUnknown(data['branch_id']!, _branchIdMeta),
      );
    }
    if (data.containsKey('address')) {
      context.handle(
        _addressMeta,
        address.isAcceptableOrUnknown(data['address']!, _addressMeta),
      );
    }
    if (data.containsKey('gps_location')) {
      context.handle(
        _gpsLocationMeta,
        gpsLocation.isAcceptableOrUnknown(
          data['gps_location']!,
          _gpsLocationMeta,
        ),
      );
    }
    if (data.containsKey('profile_image')) {
      context.handle(
        _profileImageMeta,
        profileImage.isAcceptableOrUnknown(
          data['profile_image']!,
          _profileImageMeta,
        ),
      );
    }
    if (data.containsKey('importance')) {
      context.handle(
        _importanceMeta,
        importance.isAcceptableOrUnknown(data['importance']!, _importanceMeta),
      );
    }
    if (data.containsKey('province')) {
      context.handle(
        _provinceMeta,
        province.isAcceptableOrUnknown(data['province']!, _provinceMeta),
      );
    }
    if (data.containsKey('district')) {
      context.handle(
        _districtMeta,
        district.isAcceptableOrUnknown(data['district']!, _districtMeta),
      );
    }
    if (data.containsKey('notes')) {
      context.handle(
        _notesMeta,
        notes.isAcceptableOrUnknown(data['notes']!, _notesMeta),
      );
    }
    if (data.containsKey('is_agent')) {
      context.handle(
        _isAgentMeta,
        isAgent.isAcceptableOrUnknown(data['is_agent']!, _isAgentMeta),
      );
    }
    if (data.containsKey('last_visit')) {
      context.handle(
        _lastVisitMeta,
        lastVisit.isAcceptableOrUnknown(data['last_visit']!, _lastVisitMeta),
      );
    }
    if (data.containsKey('loyalty_level')) {
      context.handle(
        _loyaltyLevelMeta,
        loyaltyLevel.isAcceptableOrUnknown(
          data['loyalty_level']!,
          _loyaltyLevelMeta,
        ),
      );
    }
    if (data.containsKey('is_draft')) {
      context.handle(
        _isDraftMeta,
        isDraft.isAcceptableOrUnknown(data['is_draft']!, _isDraftMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Client map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Client(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      remoteId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}remote_id'],
      ),
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      phone: $ClientsTable.$converterphonen.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}phone'],
        ),
      ),
      email: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}email'],
      ),
      category: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}category'],
      ),
      agentId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}agent_id'],
      ),
      branchId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}branch_id'],
      ),
      address: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}address'],
      ),
      gpsLocation: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}gps_location'],
      ),
      images: $ClientsTable.$converterimagesn.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}images'],
        ),
      ),
      profileImage: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}profile_image'],
      ),
      importance: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}importance'],
      ),
      province: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}province'],
      ),
      district: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}district'],
      ),
      notes: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}notes'],
      ),
      isAgent: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_agent'],
      )!,
      lastVisit: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}last_visit'],
      ),
      loyaltyLevel: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}loyalty_level'],
      ),
      isDraft: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_draft'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $ClientsTable createAlias(String alias) {
    return $ClientsTable(attachedDatabase, alias);
  }

  static TypeConverter<List<String>, String> $converterphone =
      const JsonConverter();
  static TypeConverter<List<String>?, String?> $converterphonen =
      NullAwareTypeConverter.wrap($converterphone);
  static TypeConverter<List<String>, String> $converterimages =
      const JsonConverter();
  static TypeConverter<List<String>?, String?> $converterimagesn =
      NullAwareTypeConverter.wrap($converterimages);
}

class Client extends DataClass implements Insertable<Client> {
  final int id;
  final int? remoteId;
  final String name;
  final List<String>? phone;
  final String? email;
  final String? category;
  final int? agentId;
  final int? branchId;
  final String? address;
  final String? gpsLocation;
  final List<String>? images;
  final String? profileImage;
  final String? importance;
  final String? province;
  final String? district;
  final String? notes;
  final bool isAgent;
  final DateTime? lastVisit;
  final String? loyaltyLevel;
  final bool isDraft;
  final DateTime createdAt;
  final DateTime updatedAt;
  const Client({
    required this.id,
    this.remoteId,
    required this.name,
    this.phone,
    this.email,
    this.category,
    this.agentId,
    this.branchId,
    this.address,
    this.gpsLocation,
    this.images,
    this.profileImage,
    this.importance,
    this.province,
    this.district,
    this.notes,
    required this.isAgent,
    this.lastVisit,
    this.loyaltyLevel,
    required this.isDraft,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    if (!nullToAbsent || remoteId != null) {
      map['remote_id'] = Variable<int>(remoteId);
    }
    map['name'] = Variable<String>(name);
    if (!nullToAbsent || phone != null) {
      map['phone'] = Variable<String>(
        $ClientsTable.$converterphonen.toSql(phone),
      );
    }
    if (!nullToAbsent || email != null) {
      map['email'] = Variable<String>(email);
    }
    if (!nullToAbsent || category != null) {
      map['category'] = Variable<String>(category);
    }
    if (!nullToAbsent || agentId != null) {
      map['agent_id'] = Variable<int>(agentId);
    }
    if (!nullToAbsent || branchId != null) {
      map['branch_id'] = Variable<int>(branchId);
    }
    if (!nullToAbsent || address != null) {
      map['address'] = Variable<String>(address);
    }
    if (!nullToAbsent || gpsLocation != null) {
      map['gps_location'] = Variable<String>(gpsLocation);
    }
    if (!nullToAbsent || images != null) {
      map['images'] = Variable<String>(
        $ClientsTable.$converterimagesn.toSql(images),
      );
    }
    if (!nullToAbsent || profileImage != null) {
      map['profile_image'] = Variable<String>(profileImage);
    }
    if (!nullToAbsent || importance != null) {
      map['importance'] = Variable<String>(importance);
    }
    if (!nullToAbsent || province != null) {
      map['province'] = Variable<String>(province);
    }
    if (!nullToAbsent || district != null) {
      map['district'] = Variable<String>(district);
    }
    if (!nullToAbsent || notes != null) {
      map['notes'] = Variable<String>(notes);
    }
    map['is_agent'] = Variable<bool>(isAgent);
    if (!nullToAbsent || lastVisit != null) {
      map['last_visit'] = Variable<DateTime>(lastVisit);
    }
    if (!nullToAbsent || loyaltyLevel != null) {
      map['loyalty_level'] = Variable<String>(loyaltyLevel);
    }
    map['is_draft'] = Variable<bool>(isDraft);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  ClientsCompanion toCompanion(bool nullToAbsent) {
    return ClientsCompanion(
      id: Value(id),
      remoteId: remoteId == null && nullToAbsent
          ? const Value.absent()
          : Value(remoteId),
      name: Value(name),
      phone: phone == null && nullToAbsent
          ? const Value.absent()
          : Value(phone),
      email: email == null && nullToAbsent
          ? const Value.absent()
          : Value(email),
      category: category == null && nullToAbsent
          ? const Value.absent()
          : Value(category),
      agentId: agentId == null && nullToAbsent
          ? const Value.absent()
          : Value(agentId),
      branchId: branchId == null && nullToAbsent
          ? const Value.absent()
          : Value(branchId),
      address: address == null && nullToAbsent
          ? const Value.absent()
          : Value(address),
      gpsLocation: gpsLocation == null && nullToAbsent
          ? const Value.absent()
          : Value(gpsLocation),
      images: images == null && nullToAbsent
          ? const Value.absent()
          : Value(images),
      profileImage: profileImage == null && nullToAbsent
          ? const Value.absent()
          : Value(profileImage),
      importance: importance == null && nullToAbsent
          ? const Value.absent()
          : Value(importance),
      province: province == null && nullToAbsent
          ? const Value.absent()
          : Value(province),
      district: district == null && nullToAbsent
          ? const Value.absent()
          : Value(district),
      notes: notes == null && nullToAbsent
          ? const Value.absent()
          : Value(notes),
      isAgent: Value(isAgent),
      lastVisit: lastVisit == null && nullToAbsent
          ? const Value.absent()
          : Value(lastVisit),
      loyaltyLevel: loyaltyLevel == null && nullToAbsent
          ? const Value.absent()
          : Value(loyaltyLevel),
      isDraft: Value(isDraft),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory Client.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Client(
      id: serializer.fromJson<int>(json['id']),
      remoteId: serializer.fromJson<int?>(json['remoteId']),
      name: serializer.fromJson<String>(json['name']),
      phone: serializer.fromJson<List<String>?>(json['phone']),
      email: serializer.fromJson<String?>(json['email']),
      category: serializer.fromJson<String?>(json['category']),
      agentId: serializer.fromJson<int?>(json['agentId']),
      branchId: serializer.fromJson<int?>(json['branchId']),
      address: serializer.fromJson<String?>(json['address']),
      gpsLocation: serializer.fromJson<String?>(json['gpsLocation']),
      images: serializer.fromJson<List<String>?>(json['images']),
      profileImage: serializer.fromJson<String?>(json['profileImage']),
      importance: serializer.fromJson<String?>(json['importance']),
      province: serializer.fromJson<String?>(json['province']),
      district: serializer.fromJson<String?>(json['district']),
      notes: serializer.fromJson<String?>(json['notes']),
      isAgent: serializer.fromJson<bool>(json['isAgent']),
      lastVisit: serializer.fromJson<DateTime?>(json['lastVisit']),
      loyaltyLevel: serializer.fromJson<String?>(json['loyaltyLevel']),
      isDraft: serializer.fromJson<bool>(json['isDraft']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'remoteId': serializer.toJson<int?>(remoteId),
      'name': serializer.toJson<String>(name),
      'phone': serializer.toJson<List<String>?>(phone),
      'email': serializer.toJson<String?>(email),
      'category': serializer.toJson<String?>(category),
      'agentId': serializer.toJson<int?>(agentId),
      'branchId': serializer.toJson<int?>(branchId),
      'address': serializer.toJson<String?>(address),
      'gpsLocation': serializer.toJson<String?>(gpsLocation),
      'images': serializer.toJson<List<String>?>(images),
      'profileImage': serializer.toJson<String?>(profileImage),
      'importance': serializer.toJson<String?>(importance),
      'province': serializer.toJson<String?>(province),
      'district': serializer.toJson<String?>(district),
      'notes': serializer.toJson<String?>(notes),
      'isAgent': serializer.toJson<bool>(isAgent),
      'lastVisit': serializer.toJson<DateTime?>(lastVisit),
      'loyaltyLevel': serializer.toJson<String?>(loyaltyLevel),
      'isDraft': serializer.toJson<bool>(isDraft),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  Client copyWith({
    int? id,
    Value<int?> remoteId = const Value.absent(),
    String? name,
    Value<List<String>?> phone = const Value.absent(),
    Value<String?> email = const Value.absent(),
    Value<String?> category = const Value.absent(),
    Value<int?> agentId = const Value.absent(),
    Value<int?> branchId = const Value.absent(),
    Value<String?> address = const Value.absent(),
    Value<String?> gpsLocation = const Value.absent(),
    Value<List<String>?> images = const Value.absent(),
    Value<String?> profileImage = const Value.absent(),
    Value<String?> importance = const Value.absent(),
    Value<String?> province = const Value.absent(),
    Value<String?> district = const Value.absent(),
    Value<String?> notes = const Value.absent(),
    bool? isAgent,
    Value<DateTime?> lastVisit = const Value.absent(),
    Value<String?> loyaltyLevel = const Value.absent(),
    bool? isDraft,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => Client(
    id: id ?? this.id,
    remoteId: remoteId.present ? remoteId.value : this.remoteId,
    name: name ?? this.name,
    phone: phone.present ? phone.value : this.phone,
    email: email.present ? email.value : this.email,
    category: category.present ? category.value : this.category,
    agentId: agentId.present ? agentId.value : this.agentId,
    branchId: branchId.present ? branchId.value : this.branchId,
    address: address.present ? address.value : this.address,
    gpsLocation: gpsLocation.present ? gpsLocation.value : this.gpsLocation,
    images: images.present ? images.value : this.images,
    profileImage: profileImage.present ? profileImage.value : this.profileImage,
    importance: importance.present ? importance.value : this.importance,
    province: province.present ? province.value : this.province,
    district: district.present ? district.value : this.district,
    notes: notes.present ? notes.value : this.notes,
    isAgent: isAgent ?? this.isAgent,
    lastVisit: lastVisit.present ? lastVisit.value : this.lastVisit,
    loyaltyLevel: loyaltyLevel.present ? loyaltyLevel.value : this.loyaltyLevel,
    isDraft: isDraft ?? this.isDraft,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  Client copyWithCompanion(ClientsCompanion data) {
    return Client(
      id: data.id.present ? data.id.value : this.id,
      remoteId: data.remoteId.present ? data.remoteId.value : this.remoteId,
      name: data.name.present ? data.name.value : this.name,
      phone: data.phone.present ? data.phone.value : this.phone,
      email: data.email.present ? data.email.value : this.email,
      category: data.category.present ? data.category.value : this.category,
      agentId: data.agentId.present ? data.agentId.value : this.agentId,
      branchId: data.branchId.present ? data.branchId.value : this.branchId,
      address: data.address.present ? data.address.value : this.address,
      gpsLocation: data.gpsLocation.present
          ? data.gpsLocation.value
          : this.gpsLocation,
      images: data.images.present ? data.images.value : this.images,
      profileImage: data.profileImage.present
          ? data.profileImage.value
          : this.profileImage,
      importance: data.importance.present
          ? data.importance.value
          : this.importance,
      province: data.province.present ? data.province.value : this.province,
      district: data.district.present ? data.district.value : this.district,
      notes: data.notes.present ? data.notes.value : this.notes,
      isAgent: data.isAgent.present ? data.isAgent.value : this.isAgent,
      lastVisit: data.lastVisit.present ? data.lastVisit.value : this.lastVisit,
      loyaltyLevel: data.loyaltyLevel.present
          ? data.loyaltyLevel.value
          : this.loyaltyLevel,
      isDraft: data.isDraft.present ? data.isDraft.value : this.isDraft,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Client(')
          ..write('id: $id, ')
          ..write('remoteId: $remoteId, ')
          ..write('name: $name, ')
          ..write('phone: $phone, ')
          ..write('email: $email, ')
          ..write('category: $category, ')
          ..write('agentId: $agentId, ')
          ..write('branchId: $branchId, ')
          ..write('address: $address, ')
          ..write('gpsLocation: $gpsLocation, ')
          ..write('images: $images, ')
          ..write('profileImage: $profileImage, ')
          ..write('importance: $importance, ')
          ..write('province: $province, ')
          ..write('district: $district, ')
          ..write('notes: $notes, ')
          ..write('isAgent: $isAgent, ')
          ..write('lastVisit: $lastVisit, ')
          ..write('loyaltyLevel: $loyaltyLevel, ')
          ..write('isDraft: $isDraft, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hashAll([
    id,
    remoteId,
    name,
    phone,
    email,
    category,
    agentId,
    branchId,
    address,
    gpsLocation,
    images,
    profileImage,
    importance,
    province,
    district,
    notes,
    isAgent,
    lastVisit,
    loyaltyLevel,
    isDraft,
    createdAt,
    updatedAt,
  ]);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Client &&
          other.id == this.id &&
          other.remoteId == this.remoteId &&
          other.name == this.name &&
          other.phone == this.phone &&
          other.email == this.email &&
          other.category == this.category &&
          other.agentId == this.agentId &&
          other.branchId == this.branchId &&
          other.address == this.address &&
          other.gpsLocation == this.gpsLocation &&
          other.images == this.images &&
          other.profileImage == this.profileImage &&
          other.importance == this.importance &&
          other.province == this.province &&
          other.district == this.district &&
          other.notes == this.notes &&
          other.isAgent == this.isAgent &&
          other.lastVisit == this.lastVisit &&
          other.loyaltyLevel == this.loyaltyLevel &&
          other.isDraft == this.isDraft &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class ClientsCompanion extends UpdateCompanion<Client> {
  final Value<int> id;
  final Value<int?> remoteId;
  final Value<String> name;
  final Value<List<String>?> phone;
  final Value<String?> email;
  final Value<String?> category;
  final Value<int?> agentId;
  final Value<int?> branchId;
  final Value<String?> address;
  final Value<String?> gpsLocation;
  final Value<List<String>?> images;
  final Value<String?> profileImage;
  final Value<String?> importance;
  final Value<String?> province;
  final Value<String?> district;
  final Value<String?> notes;
  final Value<bool> isAgent;
  final Value<DateTime?> lastVisit;
  final Value<String?> loyaltyLevel;
  final Value<bool> isDraft;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  const ClientsCompanion({
    this.id = const Value.absent(),
    this.remoteId = const Value.absent(),
    this.name = const Value.absent(),
    this.phone = const Value.absent(),
    this.email = const Value.absent(),
    this.category = const Value.absent(),
    this.agentId = const Value.absent(),
    this.branchId = const Value.absent(),
    this.address = const Value.absent(),
    this.gpsLocation = const Value.absent(),
    this.images = const Value.absent(),
    this.profileImage = const Value.absent(),
    this.importance = const Value.absent(),
    this.province = const Value.absent(),
    this.district = const Value.absent(),
    this.notes = const Value.absent(),
    this.isAgent = const Value.absent(),
    this.lastVisit = const Value.absent(),
    this.loyaltyLevel = const Value.absent(),
    this.isDraft = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  ClientsCompanion.insert({
    this.id = const Value.absent(),
    this.remoteId = const Value.absent(),
    required String name,
    this.phone = const Value.absent(),
    this.email = const Value.absent(),
    this.category = const Value.absent(),
    this.agentId = const Value.absent(),
    this.branchId = const Value.absent(),
    this.address = const Value.absent(),
    this.gpsLocation = const Value.absent(),
    this.images = const Value.absent(),
    this.profileImage = const Value.absent(),
    this.importance = const Value.absent(),
    this.province = const Value.absent(),
    this.district = const Value.absent(),
    this.notes = const Value.absent(),
    this.isAgent = const Value.absent(),
    this.lastVisit = const Value.absent(),
    this.loyaltyLevel = const Value.absent(),
    this.isDraft = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  }) : name = Value(name);
  static Insertable<Client> custom({
    Expression<int>? id,
    Expression<int>? remoteId,
    Expression<String>? name,
    Expression<String>? phone,
    Expression<String>? email,
    Expression<String>? category,
    Expression<int>? agentId,
    Expression<int>? branchId,
    Expression<String>? address,
    Expression<String>? gpsLocation,
    Expression<String>? images,
    Expression<String>? profileImage,
    Expression<String>? importance,
    Expression<String>? province,
    Expression<String>? district,
    Expression<String>? notes,
    Expression<bool>? isAgent,
    Expression<DateTime>? lastVisit,
    Expression<String>? loyaltyLevel,
    Expression<bool>? isDraft,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (remoteId != null) 'remote_id': remoteId,
      if (name != null) 'name': name,
      if (phone != null) 'phone': phone,
      if (email != null) 'email': email,
      if (category != null) 'category': category,
      if (agentId != null) 'agent_id': agentId,
      if (branchId != null) 'branch_id': branchId,
      if (address != null) 'address': address,
      if (gpsLocation != null) 'gps_location': gpsLocation,
      if (images != null) 'images': images,
      if (profileImage != null) 'profile_image': profileImage,
      if (importance != null) 'importance': importance,
      if (province != null) 'province': province,
      if (district != null) 'district': district,
      if (notes != null) 'notes': notes,
      if (isAgent != null) 'is_agent': isAgent,
      if (lastVisit != null) 'last_visit': lastVisit,
      if (loyaltyLevel != null) 'loyalty_level': loyaltyLevel,
      if (isDraft != null) 'is_draft': isDraft,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  ClientsCompanion copyWith({
    Value<int>? id,
    Value<int?>? remoteId,
    Value<String>? name,
    Value<List<String>?>? phone,
    Value<String?>? email,
    Value<String?>? category,
    Value<int?>? agentId,
    Value<int?>? branchId,
    Value<String?>? address,
    Value<String?>? gpsLocation,
    Value<List<String>?>? images,
    Value<String?>? profileImage,
    Value<String?>? importance,
    Value<String?>? province,
    Value<String?>? district,
    Value<String?>? notes,
    Value<bool>? isAgent,
    Value<DateTime?>? lastVisit,
    Value<String?>? loyaltyLevel,
    Value<bool>? isDraft,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
  }) {
    return ClientsCompanion(
      id: id ?? this.id,
      remoteId: remoteId ?? this.remoteId,
      name: name ?? this.name,
      phone: phone ?? this.phone,
      email: email ?? this.email,
      category: category ?? this.category,
      agentId: agentId ?? this.agentId,
      branchId: branchId ?? this.branchId,
      address: address ?? this.address,
      gpsLocation: gpsLocation ?? this.gpsLocation,
      images: images ?? this.images,
      profileImage: profileImage ?? this.profileImage,
      importance: importance ?? this.importance,
      province: province ?? this.province,
      district: district ?? this.district,
      notes: notes ?? this.notes,
      isAgent: isAgent ?? this.isAgent,
      lastVisit: lastVisit ?? this.lastVisit,
      loyaltyLevel: loyaltyLevel ?? this.loyaltyLevel,
      isDraft: isDraft ?? this.isDraft,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (remoteId.present) {
      map['remote_id'] = Variable<int>(remoteId.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (phone.present) {
      map['phone'] = Variable<String>(
        $ClientsTable.$converterphonen.toSql(phone.value),
      );
    }
    if (email.present) {
      map['email'] = Variable<String>(email.value);
    }
    if (category.present) {
      map['category'] = Variable<String>(category.value);
    }
    if (agentId.present) {
      map['agent_id'] = Variable<int>(agentId.value);
    }
    if (branchId.present) {
      map['branch_id'] = Variable<int>(branchId.value);
    }
    if (address.present) {
      map['address'] = Variable<String>(address.value);
    }
    if (gpsLocation.present) {
      map['gps_location'] = Variable<String>(gpsLocation.value);
    }
    if (images.present) {
      map['images'] = Variable<String>(
        $ClientsTable.$converterimagesn.toSql(images.value),
      );
    }
    if (profileImage.present) {
      map['profile_image'] = Variable<String>(profileImage.value);
    }
    if (importance.present) {
      map['importance'] = Variable<String>(importance.value);
    }
    if (province.present) {
      map['province'] = Variable<String>(province.value);
    }
    if (district.present) {
      map['district'] = Variable<String>(district.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    if (isAgent.present) {
      map['is_agent'] = Variable<bool>(isAgent.value);
    }
    if (lastVisit.present) {
      map['last_visit'] = Variable<DateTime>(lastVisit.value);
    }
    if (loyaltyLevel.present) {
      map['loyalty_level'] = Variable<String>(loyaltyLevel.value);
    }
    if (isDraft.present) {
      map['is_draft'] = Variable<bool>(isDraft.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ClientsCompanion(')
          ..write('id: $id, ')
          ..write('remoteId: $remoteId, ')
          ..write('name: $name, ')
          ..write('phone: $phone, ')
          ..write('email: $email, ')
          ..write('category: $category, ')
          ..write('agentId: $agentId, ')
          ..write('branchId: $branchId, ')
          ..write('address: $address, ')
          ..write('gpsLocation: $gpsLocation, ')
          ..write('images: $images, ')
          ..write('profileImage: $profileImage, ')
          ..write('importance: $importance, ')
          ..write('province: $province, ')
          ..write('district: $district, ')
          ..write('notes: $notes, ')
          ..write('isAgent: $isAgent, ')
          ..write('lastVisit: $lastVisit, ')
          ..write('loyaltyLevel: $loyaltyLevel, ')
          ..write('isDraft: $isDraft, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }
}

class $CampaignsTable extends Campaigns
    with TableInfo<$CampaignsTable, Campaign> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CampaignsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
    'title',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _descriptionMeta = const VerificationMeta(
    'description',
  );
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
    'description',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _campaignTypeMeta = const VerificationMeta(
    'campaignType',
  );
  @override
  late final GeneratedColumn<String> campaignType = GeneratedColumn<String>(
    'campaign_type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
    'status',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('draft'),
  );
  static const VerificationMeta _startDateMeta = const VerificationMeta(
    'startDate',
  );
  @override
  late final GeneratedColumn<DateTime> startDate = GeneratedColumn<DateTime>(
    'start_date',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _endDateMeta = const VerificationMeta(
    'endDate',
  );
  @override
  late final GeneratedColumn<DateTime> endDate = GeneratedColumn<DateTime>(
    'end_date',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _objectiveMeta = const VerificationMeta(
    'objective',
  );
  @override
  late final GeneratedColumn<String> objective = GeneratedColumn<String>(
    'objective',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _budgetMeta = const VerificationMeta('budget');
  @override
  late final GeneratedColumn<double> budget = GeneratedColumn<double>(
    'budget',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(0.0),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    title,
    description,
    campaignType,
    status,
    startDate,
    endDate,
    objective,
    budget,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'campaigns';
  @override
  VerificationContext validateIntegrity(
    Insertable<Campaign> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('title')) {
      context.handle(
        _titleMeta,
        title.isAcceptableOrUnknown(data['title']!, _titleMeta),
      );
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
        _descriptionMeta,
        description.isAcceptableOrUnknown(
          data['description']!,
          _descriptionMeta,
        ),
      );
    }
    if (data.containsKey('campaign_type')) {
      context.handle(
        _campaignTypeMeta,
        campaignType.isAcceptableOrUnknown(
          data['campaign_type']!,
          _campaignTypeMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_campaignTypeMeta);
    }
    if (data.containsKey('status')) {
      context.handle(
        _statusMeta,
        status.isAcceptableOrUnknown(data['status']!, _statusMeta),
      );
    }
    if (data.containsKey('start_date')) {
      context.handle(
        _startDateMeta,
        startDate.isAcceptableOrUnknown(data['start_date']!, _startDateMeta),
      );
    }
    if (data.containsKey('end_date')) {
      context.handle(
        _endDateMeta,
        endDate.isAcceptableOrUnknown(data['end_date']!, _endDateMeta),
      );
    }
    if (data.containsKey('objective')) {
      context.handle(
        _objectiveMeta,
        objective.isAcceptableOrUnknown(data['objective']!, _objectiveMeta),
      );
    }
    if (data.containsKey('budget')) {
      context.handle(
        _budgetMeta,
        budget.isAcceptableOrUnknown(data['budget']!, _budgetMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Campaign map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Campaign(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      title: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}title'],
      )!,
      description: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}description'],
      ),
      campaignType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}campaign_type'],
      )!,
      status: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}status'],
      )!,
      startDate: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}start_date'],
      ),
      endDate: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}end_date'],
      ),
      objective: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}objective'],
      ),
      budget: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}budget'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $CampaignsTable createAlias(String alias) {
    return $CampaignsTable(attachedDatabase, alias);
  }
}

class Campaign extends DataClass implements Insertable<Campaign> {
  final int id;
  final String title;
  final String? description;
  final String campaignType;
  final String status;
  final DateTime? startDate;
  final DateTime? endDate;
  final String? objective;
  final double budget;
  final DateTime createdAt;
  final DateTime updatedAt;
  const Campaign({
    required this.id,
    required this.title,
    this.description,
    required this.campaignType,
    required this.status,
    this.startDate,
    this.endDate,
    this.objective,
    required this.budget,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['title'] = Variable<String>(title);
    if (!nullToAbsent || description != null) {
      map['description'] = Variable<String>(description);
    }
    map['campaign_type'] = Variable<String>(campaignType);
    map['status'] = Variable<String>(status);
    if (!nullToAbsent || startDate != null) {
      map['start_date'] = Variable<DateTime>(startDate);
    }
    if (!nullToAbsent || endDate != null) {
      map['end_date'] = Variable<DateTime>(endDate);
    }
    if (!nullToAbsent || objective != null) {
      map['objective'] = Variable<String>(objective);
    }
    map['budget'] = Variable<double>(budget);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  CampaignsCompanion toCompanion(bool nullToAbsent) {
    return CampaignsCompanion(
      id: Value(id),
      title: Value(title),
      description: description == null && nullToAbsent
          ? const Value.absent()
          : Value(description),
      campaignType: Value(campaignType),
      status: Value(status),
      startDate: startDate == null && nullToAbsent
          ? const Value.absent()
          : Value(startDate),
      endDate: endDate == null && nullToAbsent
          ? const Value.absent()
          : Value(endDate),
      objective: objective == null && nullToAbsent
          ? const Value.absent()
          : Value(objective),
      budget: Value(budget),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory Campaign.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Campaign(
      id: serializer.fromJson<int>(json['id']),
      title: serializer.fromJson<String>(json['title']),
      description: serializer.fromJson<String?>(json['description']),
      campaignType: serializer.fromJson<String>(json['campaignType']),
      status: serializer.fromJson<String>(json['status']),
      startDate: serializer.fromJson<DateTime?>(json['startDate']),
      endDate: serializer.fromJson<DateTime?>(json['endDate']),
      objective: serializer.fromJson<String?>(json['objective']),
      budget: serializer.fromJson<double>(json['budget']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'title': serializer.toJson<String>(title),
      'description': serializer.toJson<String?>(description),
      'campaignType': serializer.toJson<String>(campaignType),
      'status': serializer.toJson<String>(status),
      'startDate': serializer.toJson<DateTime?>(startDate),
      'endDate': serializer.toJson<DateTime?>(endDate),
      'objective': serializer.toJson<String?>(objective),
      'budget': serializer.toJson<double>(budget),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  Campaign copyWith({
    int? id,
    String? title,
    Value<String?> description = const Value.absent(),
    String? campaignType,
    String? status,
    Value<DateTime?> startDate = const Value.absent(),
    Value<DateTime?> endDate = const Value.absent(),
    Value<String?> objective = const Value.absent(),
    double? budget,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => Campaign(
    id: id ?? this.id,
    title: title ?? this.title,
    description: description.present ? description.value : this.description,
    campaignType: campaignType ?? this.campaignType,
    status: status ?? this.status,
    startDate: startDate.present ? startDate.value : this.startDate,
    endDate: endDate.present ? endDate.value : this.endDate,
    objective: objective.present ? objective.value : this.objective,
    budget: budget ?? this.budget,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  Campaign copyWithCompanion(CampaignsCompanion data) {
    return Campaign(
      id: data.id.present ? data.id.value : this.id,
      title: data.title.present ? data.title.value : this.title,
      description: data.description.present
          ? data.description.value
          : this.description,
      campaignType: data.campaignType.present
          ? data.campaignType.value
          : this.campaignType,
      status: data.status.present ? data.status.value : this.status,
      startDate: data.startDate.present ? data.startDate.value : this.startDate,
      endDate: data.endDate.present ? data.endDate.value : this.endDate,
      objective: data.objective.present ? data.objective.value : this.objective,
      budget: data.budget.present ? data.budget.value : this.budget,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Campaign(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('description: $description, ')
          ..write('campaignType: $campaignType, ')
          ..write('status: $status, ')
          ..write('startDate: $startDate, ')
          ..write('endDate: $endDate, ')
          ..write('objective: $objective, ')
          ..write('budget: $budget, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    title,
    description,
    campaignType,
    status,
    startDate,
    endDate,
    objective,
    budget,
    createdAt,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Campaign &&
          other.id == this.id &&
          other.title == this.title &&
          other.description == this.description &&
          other.campaignType == this.campaignType &&
          other.status == this.status &&
          other.startDate == this.startDate &&
          other.endDate == this.endDate &&
          other.objective == this.objective &&
          other.budget == this.budget &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class CampaignsCompanion extends UpdateCompanion<Campaign> {
  final Value<int> id;
  final Value<String> title;
  final Value<String?> description;
  final Value<String> campaignType;
  final Value<String> status;
  final Value<DateTime?> startDate;
  final Value<DateTime?> endDate;
  final Value<String?> objective;
  final Value<double> budget;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  const CampaignsCompanion({
    this.id = const Value.absent(),
    this.title = const Value.absent(),
    this.description = const Value.absent(),
    this.campaignType = const Value.absent(),
    this.status = const Value.absent(),
    this.startDate = const Value.absent(),
    this.endDate = const Value.absent(),
    this.objective = const Value.absent(),
    this.budget = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  CampaignsCompanion.insert({
    this.id = const Value.absent(),
    required String title,
    this.description = const Value.absent(),
    required String campaignType,
    this.status = const Value.absent(),
    this.startDate = const Value.absent(),
    this.endDate = const Value.absent(),
    this.objective = const Value.absent(),
    this.budget = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  }) : title = Value(title),
       campaignType = Value(campaignType);
  static Insertable<Campaign> custom({
    Expression<int>? id,
    Expression<String>? title,
    Expression<String>? description,
    Expression<String>? campaignType,
    Expression<String>? status,
    Expression<DateTime>? startDate,
    Expression<DateTime>? endDate,
    Expression<String>? objective,
    Expression<double>? budget,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (title != null) 'title': title,
      if (description != null) 'description': description,
      if (campaignType != null) 'campaign_type': campaignType,
      if (status != null) 'status': status,
      if (startDate != null) 'start_date': startDate,
      if (endDate != null) 'end_date': endDate,
      if (objective != null) 'objective': objective,
      if (budget != null) 'budget': budget,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  CampaignsCompanion copyWith({
    Value<int>? id,
    Value<String>? title,
    Value<String?>? description,
    Value<String>? campaignType,
    Value<String>? status,
    Value<DateTime?>? startDate,
    Value<DateTime?>? endDate,
    Value<String?>? objective,
    Value<double>? budget,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
  }) {
    return CampaignsCompanion(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      campaignType: campaignType ?? this.campaignType,
      status: status ?? this.status,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      objective: objective ?? this.objective,
      budget: budget ?? this.budget,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (campaignType.present) {
      map['campaign_type'] = Variable<String>(campaignType.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (startDate.present) {
      map['start_date'] = Variable<DateTime>(startDate.value);
    }
    if (endDate.present) {
      map['end_date'] = Variable<DateTime>(endDate.value);
    }
    if (objective.present) {
      map['objective'] = Variable<String>(objective.value);
    }
    if (budget.present) {
      map['budget'] = Variable<double>(budget.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CampaignsCompanion(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('description: $description, ')
          ..write('campaignType: $campaignType, ')
          ..write('status: $status, ')
          ..write('startDate: $startDate, ')
          ..write('endDate: $endDate, ')
          ..write('objective: $objective, ')
          ..write('budget: $budget, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }
}

class $TasksTable extends Tasks with TableInfo<$TasksTable, Task> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TasksTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
    'title',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _descriptionMeta = const VerificationMeta(
    'description',
  );
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
    'description',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
    'status',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('todo'),
  );
  static const VerificationMeta _priorityMeta = const VerificationMeta(
    'priority',
  );
  @override
  late final GeneratedColumn<String> priority = GeneratedColumn<String>(
    'priority',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('medium'),
  );
  static const VerificationMeta _startAtMeta = const VerificationMeta(
    'startAt',
  );
  @override
  late final GeneratedColumn<DateTime> startAt = GeneratedColumn<DateTime>(
    'start_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _dueAtMeta = const VerificationMeta('dueAt');
  @override
  late final GeneratedColumn<DateTime> dueAt = GeneratedColumn<DateTime>(
    'due_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _locationMeta = const VerificationMeta(
    'location',
  );
  @override
  late final GeneratedColumn<String> location = GeneratedColumn<String>(
    'location',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _syncStatusMeta = const VerificationMeta(
    'syncStatus',
  );
  @override
  late final GeneratedColumn<String> syncStatus = GeneratedColumn<String>(
    'sync_status',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('synced'),
  );
  static const VerificationMeta _progressPercentageMeta =
      const VerificationMeta('progressPercentage');
  @override
  late final GeneratedColumn<int> progressPercentage = GeneratedColumn<int>(
    'progress_percentage',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _campaignIdMeta = const VerificationMeta(
    'campaignId',
  );
  @override
  late final GeneratedColumn<int> campaignId = GeneratedColumn<int>(
    'campaign_id',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _clientIdMeta = const VerificationMeta(
    'clientId',
  );
  @override
  late final GeneratedColumn<int> clientId = GeneratedColumn<int>(
    'client_id',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _assigneeIdMeta = const VerificationMeta(
    'assigneeId',
  );
  @override
  late final GeneratedColumn<int> assigneeId = GeneratedColumn<int>(
    'assignee_id',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    title,
    description,
    status,
    priority,
    startAt,
    dueAt,
    location,
    syncStatus,
    progressPercentage,
    campaignId,
    clientId,
    assigneeId,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'tasks';
  @override
  VerificationContext validateIntegrity(
    Insertable<Task> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('title')) {
      context.handle(
        _titleMeta,
        title.isAcceptableOrUnknown(data['title']!, _titleMeta),
      );
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
        _descriptionMeta,
        description.isAcceptableOrUnknown(
          data['description']!,
          _descriptionMeta,
        ),
      );
    }
    if (data.containsKey('status')) {
      context.handle(
        _statusMeta,
        status.isAcceptableOrUnknown(data['status']!, _statusMeta),
      );
    }
    if (data.containsKey('priority')) {
      context.handle(
        _priorityMeta,
        priority.isAcceptableOrUnknown(data['priority']!, _priorityMeta),
      );
    }
    if (data.containsKey('start_at')) {
      context.handle(
        _startAtMeta,
        startAt.isAcceptableOrUnknown(data['start_at']!, _startAtMeta),
      );
    }
    if (data.containsKey('due_at')) {
      context.handle(
        _dueAtMeta,
        dueAt.isAcceptableOrUnknown(data['due_at']!, _dueAtMeta),
      );
    }
    if (data.containsKey('location')) {
      context.handle(
        _locationMeta,
        location.isAcceptableOrUnknown(data['location']!, _locationMeta),
      );
    }
    if (data.containsKey('sync_status')) {
      context.handle(
        _syncStatusMeta,
        syncStatus.isAcceptableOrUnknown(data['sync_status']!, _syncStatusMeta),
      );
    }
    if (data.containsKey('progress_percentage')) {
      context.handle(
        _progressPercentageMeta,
        progressPercentage.isAcceptableOrUnknown(
          data['progress_percentage']!,
          _progressPercentageMeta,
        ),
      );
    }
    if (data.containsKey('campaign_id')) {
      context.handle(
        _campaignIdMeta,
        campaignId.isAcceptableOrUnknown(data['campaign_id']!, _campaignIdMeta),
      );
    }
    if (data.containsKey('client_id')) {
      context.handle(
        _clientIdMeta,
        clientId.isAcceptableOrUnknown(data['client_id']!, _clientIdMeta),
      );
    }
    if (data.containsKey('assignee_id')) {
      context.handle(
        _assigneeIdMeta,
        assigneeId.isAcceptableOrUnknown(data['assignee_id']!, _assigneeIdMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Task map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Task(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      title: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}title'],
      )!,
      description: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}description'],
      ),
      status: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}status'],
      )!,
      priority: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}priority'],
      )!,
      startAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}start_at'],
      ),
      dueAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}due_at'],
      ),
      location: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}location'],
      ),
      syncStatus: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}sync_status'],
      )!,
      progressPercentage: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}progress_percentage'],
      )!,
      campaignId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}campaign_id'],
      ),
      clientId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}client_id'],
      ),
      assigneeId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}assignee_id'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $TasksTable createAlias(String alias) {
    return $TasksTable(attachedDatabase, alias);
  }
}

class Task extends DataClass implements Insertable<Task> {
  final String id;
  final String title;
  final String? description;
  final String status;
  final String priority;
  final DateTime? startAt;
  final DateTime? dueAt;
  final String? location;
  final String syncStatus;
  final int progressPercentage;
  final int? campaignId;
  final int? clientId;
  final int? assigneeId;
  final DateTime createdAt;
  final DateTime updatedAt;
  const Task({
    required this.id,
    required this.title,
    this.description,
    required this.status,
    required this.priority,
    this.startAt,
    this.dueAt,
    this.location,
    required this.syncStatus,
    required this.progressPercentage,
    this.campaignId,
    this.clientId,
    this.assigneeId,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['title'] = Variable<String>(title);
    if (!nullToAbsent || description != null) {
      map['description'] = Variable<String>(description);
    }
    map['status'] = Variable<String>(status);
    map['priority'] = Variable<String>(priority);
    if (!nullToAbsent || startAt != null) {
      map['start_at'] = Variable<DateTime>(startAt);
    }
    if (!nullToAbsent || dueAt != null) {
      map['due_at'] = Variable<DateTime>(dueAt);
    }
    if (!nullToAbsent || location != null) {
      map['location'] = Variable<String>(location);
    }
    map['sync_status'] = Variable<String>(syncStatus);
    map['progress_percentage'] = Variable<int>(progressPercentage);
    if (!nullToAbsent || campaignId != null) {
      map['campaign_id'] = Variable<int>(campaignId);
    }
    if (!nullToAbsent || clientId != null) {
      map['client_id'] = Variable<int>(clientId);
    }
    if (!nullToAbsent || assigneeId != null) {
      map['assignee_id'] = Variable<int>(assigneeId);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  TasksCompanion toCompanion(bool nullToAbsent) {
    return TasksCompanion(
      id: Value(id),
      title: Value(title),
      description: description == null && nullToAbsent
          ? const Value.absent()
          : Value(description),
      status: Value(status),
      priority: Value(priority),
      startAt: startAt == null && nullToAbsent
          ? const Value.absent()
          : Value(startAt),
      dueAt: dueAt == null && nullToAbsent
          ? const Value.absent()
          : Value(dueAt),
      location: location == null && nullToAbsent
          ? const Value.absent()
          : Value(location),
      syncStatus: Value(syncStatus),
      progressPercentage: Value(progressPercentage),
      campaignId: campaignId == null && nullToAbsent
          ? const Value.absent()
          : Value(campaignId),
      clientId: clientId == null && nullToAbsent
          ? const Value.absent()
          : Value(clientId),
      assigneeId: assigneeId == null && nullToAbsent
          ? const Value.absent()
          : Value(assigneeId),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory Task.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Task(
      id: serializer.fromJson<String>(json['id']),
      title: serializer.fromJson<String>(json['title']),
      description: serializer.fromJson<String?>(json['description']),
      status: serializer.fromJson<String>(json['status']),
      priority: serializer.fromJson<String>(json['priority']),
      startAt: serializer.fromJson<DateTime?>(json['startAt']),
      dueAt: serializer.fromJson<DateTime?>(json['dueAt']),
      location: serializer.fromJson<String?>(json['location']),
      syncStatus: serializer.fromJson<String>(json['syncStatus']),
      progressPercentage: serializer.fromJson<int>(json['progressPercentage']),
      campaignId: serializer.fromJson<int?>(json['campaignId']),
      clientId: serializer.fromJson<int?>(json['clientId']),
      assigneeId: serializer.fromJson<int?>(json['assigneeId']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'title': serializer.toJson<String>(title),
      'description': serializer.toJson<String?>(description),
      'status': serializer.toJson<String>(status),
      'priority': serializer.toJson<String>(priority),
      'startAt': serializer.toJson<DateTime?>(startAt),
      'dueAt': serializer.toJson<DateTime?>(dueAt),
      'location': serializer.toJson<String?>(location),
      'syncStatus': serializer.toJson<String>(syncStatus),
      'progressPercentage': serializer.toJson<int>(progressPercentage),
      'campaignId': serializer.toJson<int?>(campaignId),
      'clientId': serializer.toJson<int?>(clientId),
      'assigneeId': serializer.toJson<int?>(assigneeId),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  Task copyWith({
    String? id,
    String? title,
    Value<String?> description = const Value.absent(),
    String? status,
    String? priority,
    Value<DateTime?> startAt = const Value.absent(),
    Value<DateTime?> dueAt = const Value.absent(),
    Value<String?> location = const Value.absent(),
    String? syncStatus,
    int? progressPercentage,
    Value<int?> campaignId = const Value.absent(),
    Value<int?> clientId = const Value.absent(),
    Value<int?> assigneeId = const Value.absent(),
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => Task(
    id: id ?? this.id,
    title: title ?? this.title,
    description: description.present ? description.value : this.description,
    status: status ?? this.status,
    priority: priority ?? this.priority,
    startAt: startAt.present ? startAt.value : this.startAt,
    dueAt: dueAt.present ? dueAt.value : this.dueAt,
    location: location.present ? location.value : this.location,
    syncStatus: syncStatus ?? this.syncStatus,
    progressPercentage: progressPercentage ?? this.progressPercentage,
    campaignId: campaignId.present ? campaignId.value : this.campaignId,
    clientId: clientId.present ? clientId.value : this.clientId,
    assigneeId: assigneeId.present ? assigneeId.value : this.assigneeId,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  Task copyWithCompanion(TasksCompanion data) {
    return Task(
      id: data.id.present ? data.id.value : this.id,
      title: data.title.present ? data.title.value : this.title,
      description: data.description.present
          ? data.description.value
          : this.description,
      status: data.status.present ? data.status.value : this.status,
      priority: data.priority.present ? data.priority.value : this.priority,
      startAt: data.startAt.present ? data.startAt.value : this.startAt,
      dueAt: data.dueAt.present ? data.dueAt.value : this.dueAt,
      location: data.location.present ? data.location.value : this.location,
      syncStatus: data.syncStatus.present
          ? data.syncStatus.value
          : this.syncStatus,
      progressPercentage: data.progressPercentage.present
          ? data.progressPercentage.value
          : this.progressPercentage,
      campaignId: data.campaignId.present
          ? data.campaignId.value
          : this.campaignId,
      clientId: data.clientId.present ? data.clientId.value : this.clientId,
      assigneeId: data.assigneeId.present
          ? data.assigneeId.value
          : this.assigneeId,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Task(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('description: $description, ')
          ..write('status: $status, ')
          ..write('priority: $priority, ')
          ..write('startAt: $startAt, ')
          ..write('dueAt: $dueAt, ')
          ..write('location: $location, ')
          ..write('syncStatus: $syncStatus, ')
          ..write('progressPercentage: $progressPercentage, ')
          ..write('campaignId: $campaignId, ')
          ..write('clientId: $clientId, ')
          ..write('assigneeId: $assigneeId, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    title,
    description,
    status,
    priority,
    startAt,
    dueAt,
    location,
    syncStatus,
    progressPercentage,
    campaignId,
    clientId,
    assigneeId,
    createdAt,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Task &&
          other.id == this.id &&
          other.title == this.title &&
          other.description == this.description &&
          other.status == this.status &&
          other.priority == this.priority &&
          other.startAt == this.startAt &&
          other.dueAt == this.dueAt &&
          other.location == this.location &&
          other.syncStatus == this.syncStatus &&
          other.progressPercentage == this.progressPercentage &&
          other.campaignId == this.campaignId &&
          other.clientId == this.clientId &&
          other.assigneeId == this.assigneeId &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class TasksCompanion extends UpdateCompanion<Task> {
  final Value<String> id;
  final Value<String> title;
  final Value<String?> description;
  final Value<String> status;
  final Value<String> priority;
  final Value<DateTime?> startAt;
  final Value<DateTime?> dueAt;
  final Value<String?> location;
  final Value<String> syncStatus;
  final Value<int> progressPercentage;
  final Value<int?> campaignId;
  final Value<int?> clientId;
  final Value<int?> assigneeId;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<int> rowid;
  const TasksCompanion({
    this.id = const Value.absent(),
    this.title = const Value.absent(),
    this.description = const Value.absent(),
    this.status = const Value.absent(),
    this.priority = const Value.absent(),
    this.startAt = const Value.absent(),
    this.dueAt = const Value.absent(),
    this.location = const Value.absent(),
    this.syncStatus = const Value.absent(),
    this.progressPercentage = const Value.absent(),
    this.campaignId = const Value.absent(),
    this.clientId = const Value.absent(),
    this.assigneeId = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  TasksCompanion.insert({
    required String id,
    required String title,
    this.description = const Value.absent(),
    this.status = const Value.absent(),
    this.priority = const Value.absent(),
    this.startAt = const Value.absent(),
    this.dueAt = const Value.absent(),
    this.location = const Value.absent(),
    this.syncStatus = const Value.absent(),
    this.progressPercentage = const Value.absent(),
    this.campaignId = const Value.absent(),
    this.clientId = const Value.absent(),
    this.assigneeId = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       title = Value(title);
  static Insertable<Task> custom({
    Expression<String>? id,
    Expression<String>? title,
    Expression<String>? description,
    Expression<String>? status,
    Expression<String>? priority,
    Expression<DateTime>? startAt,
    Expression<DateTime>? dueAt,
    Expression<String>? location,
    Expression<String>? syncStatus,
    Expression<int>? progressPercentage,
    Expression<int>? campaignId,
    Expression<int>? clientId,
    Expression<int>? assigneeId,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (title != null) 'title': title,
      if (description != null) 'description': description,
      if (status != null) 'status': status,
      if (priority != null) 'priority': priority,
      if (startAt != null) 'start_at': startAt,
      if (dueAt != null) 'due_at': dueAt,
      if (location != null) 'location': location,
      if (syncStatus != null) 'sync_status': syncStatus,
      if (progressPercentage != null) 'progress_percentage': progressPercentage,
      if (campaignId != null) 'campaign_id': campaignId,
      if (clientId != null) 'client_id': clientId,
      if (assigneeId != null) 'assignee_id': assigneeId,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  TasksCompanion copyWith({
    Value<String>? id,
    Value<String>? title,
    Value<String?>? description,
    Value<String>? status,
    Value<String>? priority,
    Value<DateTime?>? startAt,
    Value<DateTime?>? dueAt,
    Value<String?>? location,
    Value<String>? syncStatus,
    Value<int>? progressPercentage,
    Value<int?>? campaignId,
    Value<int?>? clientId,
    Value<int?>? assigneeId,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<int>? rowid,
  }) {
    return TasksCompanion(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      status: status ?? this.status,
      priority: priority ?? this.priority,
      startAt: startAt ?? this.startAt,
      dueAt: dueAt ?? this.dueAt,
      location: location ?? this.location,
      syncStatus: syncStatus ?? this.syncStatus,
      progressPercentage: progressPercentage ?? this.progressPercentage,
      campaignId: campaignId ?? this.campaignId,
      clientId: clientId ?? this.clientId,
      assigneeId: assigneeId ?? this.assigneeId,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (priority.present) {
      map['priority'] = Variable<String>(priority.value);
    }
    if (startAt.present) {
      map['start_at'] = Variable<DateTime>(startAt.value);
    }
    if (dueAt.present) {
      map['due_at'] = Variable<DateTime>(dueAt.value);
    }
    if (location.present) {
      map['location'] = Variable<String>(location.value);
    }
    if (syncStatus.present) {
      map['sync_status'] = Variable<String>(syncStatus.value);
    }
    if (progressPercentage.present) {
      map['progress_percentage'] = Variable<int>(progressPercentage.value);
    }
    if (campaignId.present) {
      map['campaign_id'] = Variable<int>(campaignId.value);
    }
    if (clientId.present) {
      map['client_id'] = Variable<int>(clientId.value);
    }
    if (assigneeId.present) {
      map['assignee_id'] = Variable<int>(assigneeId.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TasksCompanion(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('description: $description, ')
          ..write('status: $status, ')
          ..write('priority: $priority, ')
          ..write('startAt: $startAt, ')
          ..write('dueAt: $dueAt, ')
          ..write('location: $location, ')
          ..write('syncStatus: $syncStatus, ')
          ..write('progressPercentage: $progressPercentage, ')
          ..write('campaignId: $campaignId, ')
          ..write('clientId: $clientId, ')
          ..write('assigneeId: $assigneeId, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $FieldReportsTable extends FieldReports
    with TableInfo<$FieldReportsTable, FieldReport> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $FieldReportsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
    'notes',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  late final GeneratedColumnWithTypeConverter<List<String>?, String> photos =
      GeneratedColumn<String>(
        'photos',
        aliasedName,
        true,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
      ).withConverter<List<String>?>($FieldReportsTable.$converterphotosn);
  static const VerificationMeta _locationMeta = const VerificationMeta(
    'location',
  );
  @override
  late final GeneratedColumn<String> location = GeneratedColumn<String>(
    'location',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _syncStatusMeta = const VerificationMeta(
    'syncStatus',
  );
  @override
  late final GeneratedColumn<String> syncStatus = GeneratedColumn<String>(
    'sync_status',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('pending'),
  );
  static const VerificationMeta _taskIdMeta = const VerificationMeta('taskId');
  @override
  late final GeneratedColumn<String> taskId = GeneratedColumn<String>(
    'task_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _reporterIdMeta = const VerificationMeta(
    'reporterId',
  );
  @override
  late final GeneratedColumn<int> reporterId = GeneratedColumn<int>(
    'reporter_id',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    notes,
    photos,
    location,
    syncStatus,
    taskId,
    reporterId,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'field_reports';
  @override
  VerificationContext validateIntegrity(
    Insertable<FieldReport> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('notes')) {
      context.handle(
        _notesMeta,
        notes.isAcceptableOrUnknown(data['notes']!, _notesMeta),
      );
    }
    if (data.containsKey('location')) {
      context.handle(
        _locationMeta,
        location.isAcceptableOrUnknown(data['location']!, _locationMeta),
      );
    }
    if (data.containsKey('sync_status')) {
      context.handle(
        _syncStatusMeta,
        syncStatus.isAcceptableOrUnknown(data['sync_status']!, _syncStatusMeta),
      );
    }
    if (data.containsKey('task_id')) {
      context.handle(
        _taskIdMeta,
        taskId.isAcceptableOrUnknown(data['task_id']!, _taskIdMeta),
      );
    }
    if (data.containsKey('reporter_id')) {
      context.handle(
        _reporterIdMeta,
        reporterId.isAcceptableOrUnknown(data['reporter_id']!, _reporterIdMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  FieldReport map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return FieldReport(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      notes: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}notes'],
      ),
      photos: $FieldReportsTable.$converterphotosn.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}photos'],
        ),
      ),
      location: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}location'],
      ),
      syncStatus: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}sync_status'],
      )!,
      taskId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}task_id'],
      ),
      reporterId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}reporter_id'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $FieldReportsTable createAlias(String alias) {
    return $FieldReportsTable(attachedDatabase, alias);
  }

  static TypeConverter<List<String>, String> $converterphotos =
      const JsonConverter();
  static TypeConverter<List<String>?, String?> $converterphotosn =
      NullAwareTypeConverter.wrap($converterphotos);
}

class FieldReport extends DataClass implements Insertable<FieldReport> {
  final String id;
  final String? notes;
  final List<String>? photos;
  final String? location;
  final String syncStatus;
  final String? taskId;
  final int? reporterId;
  final DateTime createdAt;
  final DateTime updatedAt;
  const FieldReport({
    required this.id,
    this.notes,
    this.photos,
    this.location,
    required this.syncStatus,
    this.taskId,
    this.reporterId,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    if (!nullToAbsent || notes != null) {
      map['notes'] = Variable<String>(notes);
    }
    if (!nullToAbsent || photos != null) {
      map['photos'] = Variable<String>(
        $FieldReportsTable.$converterphotosn.toSql(photos),
      );
    }
    if (!nullToAbsent || location != null) {
      map['location'] = Variable<String>(location);
    }
    map['sync_status'] = Variable<String>(syncStatus);
    if (!nullToAbsent || taskId != null) {
      map['task_id'] = Variable<String>(taskId);
    }
    if (!nullToAbsent || reporterId != null) {
      map['reporter_id'] = Variable<int>(reporterId);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  FieldReportsCompanion toCompanion(bool nullToAbsent) {
    return FieldReportsCompanion(
      id: Value(id),
      notes: notes == null && nullToAbsent
          ? const Value.absent()
          : Value(notes),
      photos: photos == null && nullToAbsent
          ? const Value.absent()
          : Value(photos),
      location: location == null && nullToAbsent
          ? const Value.absent()
          : Value(location),
      syncStatus: Value(syncStatus),
      taskId: taskId == null && nullToAbsent
          ? const Value.absent()
          : Value(taskId),
      reporterId: reporterId == null && nullToAbsent
          ? const Value.absent()
          : Value(reporterId),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory FieldReport.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return FieldReport(
      id: serializer.fromJson<String>(json['id']),
      notes: serializer.fromJson<String?>(json['notes']),
      photos: serializer.fromJson<List<String>?>(json['photos']),
      location: serializer.fromJson<String?>(json['location']),
      syncStatus: serializer.fromJson<String>(json['syncStatus']),
      taskId: serializer.fromJson<String?>(json['taskId']),
      reporterId: serializer.fromJson<int?>(json['reporterId']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'notes': serializer.toJson<String?>(notes),
      'photos': serializer.toJson<List<String>?>(photos),
      'location': serializer.toJson<String?>(location),
      'syncStatus': serializer.toJson<String>(syncStatus),
      'taskId': serializer.toJson<String?>(taskId),
      'reporterId': serializer.toJson<int?>(reporterId),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  FieldReport copyWith({
    String? id,
    Value<String?> notes = const Value.absent(),
    Value<List<String>?> photos = const Value.absent(),
    Value<String?> location = const Value.absent(),
    String? syncStatus,
    Value<String?> taskId = const Value.absent(),
    Value<int?> reporterId = const Value.absent(),
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => FieldReport(
    id: id ?? this.id,
    notes: notes.present ? notes.value : this.notes,
    photos: photos.present ? photos.value : this.photos,
    location: location.present ? location.value : this.location,
    syncStatus: syncStatus ?? this.syncStatus,
    taskId: taskId.present ? taskId.value : this.taskId,
    reporterId: reporterId.present ? reporterId.value : this.reporterId,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  FieldReport copyWithCompanion(FieldReportsCompanion data) {
    return FieldReport(
      id: data.id.present ? data.id.value : this.id,
      notes: data.notes.present ? data.notes.value : this.notes,
      photos: data.photos.present ? data.photos.value : this.photos,
      location: data.location.present ? data.location.value : this.location,
      syncStatus: data.syncStatus.present
          ? data.syncStatus.value
          : this.syncStatus,
      taskId: data.taskId.present ? data.taskId.value : this.taskId,
      reporterId: data.reporterId.present
          ? data.reporterId.value
          : this.reporterId,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('FieldReport(')
          ..write('id: $id, ')
          ..write('notes: $notes, ')
          ..write('photos: $photos, ')
          ..write('location: $location, ')
          ..write('syncStatus: $syncStatus, ')
          ..write('taskId: $taskId, ')
          ..write('reporterId: $reporterId, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    notes,
    photos,
    location,
    syncStatus,
    taskId,
    reporterId,
    createdAt,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FieldReport &&
          other.id == this.id &&
          other.notes == this.notes &&
          other.photos == this.photos &&
          other.location == this.location &&
          other.syncStatus == this.syncStatus &&
          other.taskId == this.taskId &&
          other.reporterId == this.reporterId &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class FieldReportsCompanion extends UpdateCompanion<FieldReport> {
  final Value<String> id;
  final Value<String?> notes;
  final Value<List<String>?> photos;
  final Value<String?> location;
  final Value<String> syncStatus;
  final Value<String?> taskId;
  final Value<int?> reporterId;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<int> rowid;
  const FieldReportsCompanion({
    this.id = const Value.absent(),
    this.notes = const Value.absent(),
    this.photos = const Value.absent(),
    this.location = const Value.absent(),
    this.syncStatus = const Value.absent(),
    this.taskId = const Value.absent(),
    this.reporterId = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  FieldReportsCompanion.insert({
    required String id,
    this.notes = const Value.absent(),
    this.photos = const Value.absent(),
    this.location = const Value.absent(),
    this.syncStatus = const Value.absent(),
    this.taskId = const Value.absent(),
    this.reporterId = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id);
  static Insertable<FieldReport> custom({
    Expression<String>? id,
    Expression<String>? notes,
    Expression<String>? photos,
    Expression<String>? location,
    Expression<String>? syncStatus,
    Expression<String>? taskId,
    Expression<int>? reporterId,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (notes != null) 'notes': notes,
      if (photos != null) 'photos': photos,
      if (location != null) 'location': location,
      if (syncStatus != null) 'sync_status': syncStatus,
      if (taskId != null) 'task_id': taskId,
      if (reporterId != null) 'reporter_id': reporterId,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  FieldReportsCompanion copyWith({
    Value<String>? id,
    Value<String?>? notes,
    Value<List<String>?>? photos,
    Value<String?>? location,
    Value<String>? syncStatus,
    Value<String?>? taskId,
    Value<int?>? reporterId,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<int>? rowid,
  }) {
    return FieldReportsCompanion(
      id: id ?? this.id,
      notes: notes ?? this.notes,
      photos: photos ?? this.photos,
      location: location ?? this.location,
      syncStatus: syncStatus ?? this.syncStatus,
      taskId: taskId ?? this.taskId,
      reporterId: reporterId ?? this.reporterId,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    if (photos.present) {
      map['photos'] = Variable<String>(
        $FieldReportsTable.$converterphotosn.toSql(photos.value),
      );
    }
    if (location.present) {
      map['location'] = Variable<String>(location.value);
    }
    if (syncStatus.present) {
      map['sync_status'] = Variable<String>(syncStatus.value);
    }
    if (taskId.present) {
      map['task_id'] = Variable<String>(taskId.value);
    }
    if (reporterId.present) {
      map['reporter_id'] = Variable<int>(reporterId.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('FieldReportsCompanion(')
          ..write('id: $id, ')
          ..write('notes: $notes, ')
          ..write('photos: $photos, ')
          ..write('location: $location, ')
          ..write('syncStatus: $syncStatus, ')
          ..write('taskId: $taskId, ')
          ..write('reporterId: $reporterId, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $AdAssetsTable extends AdAssets with TableInfo<$AdAssetsTable, AdAsset> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $AdAssetsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _assetCodeMeta = const VerificationMeta(
    'assetCode',
  );
  @override
  late final GeneratedColumn<String> assetCode = GeneratedColumn<String>(
    'asset_code',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _typeMeta = const VerificationMeta('type');
  @override
  late final GeneratedColumn<String> type = GeneratedColumn<String>(
    'type',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
    'status',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('available'),
  );
  static const VerificationMeta _quantityMeta = const VerificationMeta(
    'quantity',
  );
  @override
  late final GeneratedColumn<int> quantity = GeneratedColumn<int>(
    'quantity',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _usedQuantityMeta = const VerificationMeta(
    'usedQuantity',
  );
  @override
  late final GeneratedColumn<int> usedQuantity = GeneratedColumn<int>(
    'used_quantity',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    assetCode,
    name,
    type,
    status,
    quantity,
    usedQuantity,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'ad_assets';
  @override
  VerificationContext validateIntegrity(
    Insertable<AdAsset> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('asset_code')) {
      context.handle(
        _assetCodeMeta,
        assetCode.isAcceptableOrUnknown(data['asset_code']!, _assetCodeMeta),
      );
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('type')) {
      context.handle(
        _typeMeta,
        type.isAcceptableOrUnknown(data['type']!, _typeMeta),
      );
    }
    if (data.containsKey('status')) {
      context.handle(
        _statusMeta,
        status.isAcceptableOrUnknown(data['status']!, _statusMeta),
      );
    }
    if (data.containsKey('quantity')) {
      context.handle(
        _quantityMeta,
        quantity.isAcceptableOrUnknown(data['quantity']!, _quantityMeta),
      );
    }
    if (data.containsKey('used_quantity')) {
      context.handle(
        _usedQuantityMeta,
        usedQuantity.isAcceptableOrUnknown(
          data['used_quantity']!,
          _usedQuantityMeta,
        ),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  AdAsset map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return AdAsset(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      assetCode: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}asset_code'],
      ),
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      type: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}type'],
      ),
      status: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}status'],
      )!,
      quantity: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}quantity'],
      )!,
      usedQuantity: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}used_quantity'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $AdAssetsTable createAlias(String alias) {
    return $AdAssetsTable(attachedDatabase, alias);
  }
}

class AdAsset extends DataClass implements Insertable<AdAsset> {
  final int id;
  final String? assetCode;
  final String name;
  final String? type;
  final String status;
  final int quantity;
  final int usedQuantity;
  final DateTime createdAt;
  final DateTime updatedAt;
  const AdAsset({
    required this.id,
    this.assetCode,
    required this.name,
    this.type,
    required this.status,
    required this.quantity,
    required this.usedQuantity,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    if (!nullToAbsent || assetCode != null) {
      map['asset_code'] = Variable<String>(assetCode);
    }
    map['name'] = Variable<String>(name);
    if (!nullToAbsent || type != null) {
      map['type'] = Variable<String>(type);
    }
    map['status'] = Variable<String>(status);
    map['quantity'] = Variable<int>(quantity);
    map['used_quantity'] = Variable<int>(usedQuantity);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  AdAssetsCompanion toCompanion(bool nullToAbsent) {
    return AdAssetsCompanion(
      id: Value(id),
      assetCode: assetCode == null && nullToAbsent
          ? const Value.absent()
          : Value(assetCode),
      name: Value(name),
      type: type == null && nullToAbsent ? const Value.absent() : Value(type),
      status: Value(status),
      quantity: Value(quantity),
      usedQuantity: Value(usedQuantity),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory AdAsset.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return AdAsset(
      id: serializer.fromJson<int>(json['id']),
      assetCode: serializer.fromJson<String?>(json['assetCode']),
      name: serializer.fromJson<String>(json['name']),
      type: serializer.fromJson<String?>(json['type']),
      status: serializer.fromJson<String>(json['status']),
      quantity: serializer.fromJson<int>(json['quantity']),
      usedQuantity: serializer.fromJson<int>(json['usedQuantity']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'assetCode': serializer.toJson<String?>(assetCode),
      'name': serializer.toJson<String>(name),
      'type': serializer.toJson<String?>(type),
      'status': serializer.toJson<String>(status),
      'quantity': serializer.toJson<int>(quantity),
      'usedQuantity': serializer.toJson<int>(usedQuantity),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  AdAsset copyWith({
    int? id,
    Value<String?> assetCode = const Value.absent(),
    String? name,
    Value<String?> type = const Value.absent(),
    String? status,
    int? quantity,
    int? usedQuantity,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => AdAsset(
    id: id ?? this.id,
    assetCode: assetCode.present ? assetCode.value : this.assetCode,
    name: name ?? this.name,
    type: type.present ? type.value : this.type,
    status: status ?? this.status,
    quantity: quantity ?? this.quantity,
    usedQuantity: usedQuantity ?? this.usedQuantity,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  AdAsset copyWithCompanion(AdAssetsCompanion data) {
    return AdAsset(
      id: data.id.present ? data.id.value : this.id,
      assetCode: data.assetCode.present ? data.assetCode.value : this.assetCode,
      name: data.name.present ? data.name.value : this.name,
      type: data.type.present ? data.type.value : this.type,
      status: data.status.present ? data.status.value : this.status,
      quantity: data.quantity.present ? data.quantity.value : this.quantity,
      usedQuantity: data.usedQuantity.present
          ? data.usedQuantity.value
          : this.usedQuantity,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('AdAsset(')
          ..write('id: $id, ')
          ..write('assetCode: $assetCode, ')
          ..write('name: $name, ')
          ..write('type: $type, ')
          ..write('status: $status, ')
          ..write('quantity: $quantity, ')
          ..write('usedQuantity: $usedQuantity, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    assetCode,
    name,
    type,
    status,
    quantity,
    usedQuantity,
    createdAt,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is AdAsset &&
          other.id == this.id &&
          other.assetCode == this.assetCode &&
          other.name == this.name &&
          other.type == this.type &&
          other.status == this.status &&
          other.quantity == this.quantity &&
          other.usedQuantity == this.usedQuantity &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class AdAssetsCompanion extends UpdateCompanion<AdAsset> {
  final Value<int> id;
  final Value<String?> assetCode;
  final Value<String> name;
  final Value<String?> type;
  final Value<String> status;
  final Value<int> quantity;
  final Value<int> usedQuantity;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  const AdAssetsCompanion({
    this.id = const Value.absent(),
    this.assetCode = const Value.absent(),
    this.name = const Value.absent(),
    this.type = const Value.absent(),
    this.status = const Value.absent(),
    this.quantity = const Value.absent(),
    this.usedQuantity = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  AdAssetsCompanion.insert({
    this.id = const Value.absent(),
    this.assetCode = const Value.absent(),
    required String name,
    this.type = const Value.absent(),
    this.status = const Value.absent(),
    this.quantity = const Value.absent(),
    this.usedQuantity = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  }) : name = Value(name);
  static Insertable<AdAsset> custom({
    Expression<int>? id,
    Expression<String>? assetCode,
    Expression<String>? name,
    Expression<String>? type,
    Expression<String>? status,
    Expression<int>? quantity,
    Expression<int>? usedQuantity,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (assetCode != null) 'asset_code': assetCode,
      if (name != null) 'name': name,
      if (type != null) 'type': type,
      if (status != null) 'status': status,
      if (quantity != null) 'quantity': quantity,
      if (usedQuantity != null) 'used_quantity': usedQuantity,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  AdAssetsCompanion copyWith({
    Value<int>? id,
    Value<String?>? assetCode,
    Value<String>? name,
    Value<String?>? type,
    Value<String>? status,
    Value<int>? quantity,
    Value<int>? usedQuantity,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
  }) {
    return AdAssetsCompanion(
      id: id ?? this.id,
      assetCode: assetCode ?? this.assetCode,
      name: name ?? this.name,
      type: type ?? this.type,
      status: status ?? this.status,
      quantity: quantity ?? this.quantity,
      usedQuantity: usedQuantity ?? this.usedQuantity,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (assetCode.present) {
      map['asset_code'] = Variable<String>(assetCode.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (type.present) {
      map['type'] = Variable<String>(type.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (quantity.present) {
      map['quantity'] = Variable<int>(quantity.value);
    }
    if (usedQuantity.present) {
      map['used_quantity'] = Variable<int>(usedQuantity.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AdAssetsCompanion(')
          ..write('id: $id, ')
          ..write('assetCode: $assetCode, ')
          ..write('name: $name, ')
          ..write('type: $type, ')
          ..write('status: $status, ')
          ..write('quantity: $quantity, ')
          ..write('usedQuantity: $usedQuantity, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }
}

class $SyncQueueTable extends SyncQueue
    with TableInfo<$SyncQueueTable, SyncQueueData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SyncQueueTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _entityMeta = const VerificationMeta('entity');
  @override
  late final GeneratedColumn<String> entity = GeneratedColumn<String>(
    'entity',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _operationMeta = const VerificationMeta(
    'operation',
  );
  @override
  late final GeneratedColumn<String> operation = GeneratedColumn<String>(
    'operation',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _payloadMeta = const VerificationMeta(
    'payload',
  );
  @override
  late final GeneratedColumn<String> payload = GeneratedColumn<String>(
    'payload',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
    'status',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('pending'),
  );
  static const VerificationMeta _retryCountMeta = const VerificationMeta(
    'retryCount',
  );
  @override
  late final GeneratedColumn<int> retryCount = GeneratedColumn<int>(
    'retry_count',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    entity,
    operation,
    payload,
    status,
    retryCount,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'sync_queue';
  @override
  VerificationContext validateIntegrity(
    Insertable<SyncQueueData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('entity')) {
      context.handle(
        _entityMeta,
        entity.isAcceptableOrUnknown(data['entity']!, _entityMeta),
      );
    } else if (isInserting) {
      context.missing(_entityMeta);
    }
    if (data.containsKey('operation')) {
      context.handle(
        _operationMeta,
        operation.isAcceptableOrUnknown(data['operation']!, _operationMeta),
      );
    } else if (isInserting) {
      context.missing(_operationMeta);
    }
    if (data.containsKey('payload')) {
      context.handle(
        _payloadMeta,
        payload.isAcceptableOrUnknown(data['payload']!, _payloadMeta),
      );
    }
    if (data.containsKey('status')) {
      context.handle(
        _statusMeta,
        status.isAcceptableOrUnknown(data['status']!, _statusMeta),
      );
    }
    if (data.containsKey('retry_count')) {
      context.handle(
        _retryCountMeta,
        retryCount.isAcceptableOrUnknown(data['retry_count']!, _retryCountMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  SyncQueueData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SyncQueueData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      entity: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}entity'],
      )!,
      operation: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}operation'],
      )!,
      payload: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}payload'],
      ),
      status: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}status'],
      )!,
      retryCount: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}retry_count'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $SyncQueueTable createAlias(String alias) {
    return $SyncQueueTable(attachedDatabase, alias);
  }
}

class SyncQueueData extends DataClass implements Insertable<SyncQueueData> {
  final String id;
  final String entity;
  final String operation;
  final String? payload;
  final String status;
  final int retryCount;
  final DateTime createdAt;
  const SyncQueueData({
    required this.id,
    required this.entity,
    required this.operation,
    this.payload,
    required this.status,
    required this.retryCount,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['entity'] = Variable<String>(entity);
    map['operation'] = Variable<String>(operation);
    if (!nullToAbsent || payload != null) {
      map['payload'] = Variable<String>(payload);
    }
    map['status'] = Variable<String>(status);
    map['retry_count'] = Variable<int>(retryCount);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  SyncQueueCompanion toCompanion(bool nullToAbsent) {
    return SyncQueueCompanion(
      id: Value(id),
      entity: Value(entity),
      operation: Value(operation),
      payload: payload == null && nullToAbsent
          ? const Value.absent()
          : Value(payload),
      status: Value(status),
      retryCount: Value(retryCount),
      createdAt: Value(createdAt),
    );
  }

  factory SyncQueueData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SyncQueueData(
      id: serializer.fromJson<String>(json['id']),
      entity: serializer.fromJson<String>(json['entity']),
      operation: serializer.fromJson<String>(json['operation']),
      payload: serializer.fromJson<String?>(json['payload']),
      status: serializer.fromJson<String>(json['status']),
      retryCount: serializer.fromJson<int>(json['retryCount']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'entity': serializer.toJson<String>(entity),
      'operation': serializer.toJson<String>(operation),
      'payload': serializer.toJson<String?>(payload),
      'status': serializer.toJson<String>(status),
      'retryCount': serializer.toJson<int>(retryCount),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  SyncQueueData copyWith({
    String? id,
    String? entity,
    String? operation,
    Value<String?> payload = const Value.absent(),
    String? status,
    int? retryCount,
    DateTime? createdAt,
  }) => SyncQueueData(
    id: id ?? this.id,
    entity: entity ?? this.entity,
    operation: operation ?? this.operation,
    payload: payload.present ? payload.value : this.payload,
    status: status ?? this.status,
    retryCount: retryCount ?? this.retryCount,
    createdAt: createdAt ?? this.createdAt,
  );
  SyncQueueData copyWithCompanion(SyncQueueCompanion data) {
    return SyncQueueData(
      id: data.id.present ? data.id.value : this.id,
      entity: data.entity.present ? data.entity.value : this.entity,
      operation: data.operation.present ? data.operation.value : this.operation,
      payload: data.payload.present ? data.payload.value : this.payload,
      status: data.status.present ? data.status.value : this.status,
      retryCount: data.retryCount.present
          ? data.retryCount.value
          : this.retryCount,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('SyncQueueData(')
          ..write('id: $id, ')
          ..write('entity: $entity, ')
          ..write('operation: $operation, ')
          ..write('payload: $payload, ')
          ..write('status: $status, ')
          ..write('retryCount: $retryCount, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    entity,
    operation,
    payload,
    status,
    retryCount,
    createdAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SyncQueueData &&
          other.id == this.id &&
          other.entity == this.entity &&
          other.operation == this.operation &&
          other.payload == this.payload &&
          other.status == this.status &&
          other.retryCount == this.retryCount &&
          other.createdAt == this.createdAt);
}

class SyncQueueCompanion extends UpdateCompanion<SyncQueueData> {
  final Value<String> id;
  final Value<String> entity;
  final Value<String> operation;
  final Value<String?> payload;
  final Value<String> status;
  final Value<int> retryCount;
  final Value<DateTime> createdAt;
  final Value<int> rowid;
  const SyncQueueCompanion({
    this.id = const Value.absent(),
    this.entity = const Value.absent(),
    this.operation = const Value.absent(),
    this.payload = const Value.absent(),
    this.status = const Value.absent(),
    this.retryCount = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  SyncQueueCompanion.insert({
    required String id,
    required String entity,
    required String operation,
    this.payload = const Value.absent(),
    this.status = const Value.absent(),
    this.retryCount = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       entity = Value(entity),
       operation = Value(operation);
  static Insertable<SyncQueueData> custom({
    Expression<String>? id,
    Expression<String>? entity,
    Expression<String>? operation,
    Expression<String>? payload,
    Expression<String>? status,
    Expression<int>? retryCount,
    Expression<DateTime>? createdAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (entity != null) 'entity': entity,
      if (operation != null) 'operation': operation,
      if (payload != null) 'payload': payload,
      if (status != null) 'status': status,
      if (retryCount != null) 'retry_count': retryCount,
      if (createdAt != null) 'created_at': createdAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  SyncQueueCompanion copyWith({
    Value<String>? id,
    Value<String>? entity,
    Value<String>? operation,
    Value<String?>? payload,
    Value<String>? status,
    Value<int>? retryCount,
    Value<DateTime>? createdAt,
    Value<int>? rowid,
  }) {
    return SyncQueueCompanion(
      id: id ?? this.id,
      entity: entity ?? this.entity,
      operation: operation ?? this.operation,
      payload: payload ?? this.payload,
      status: status ?? this.status,
      retryCount: retryCount ?? this.retryCount,
      createdAt: createdAt ?? this.createdAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (entity.present) {
      map['entity'] = Variable<String>(entity.value);
    }
    if (operation.present) {
      map['operation'] = Variable<String>(operation.value);
    }
    if (payload.present) {
      map['payload'] = Variable<String>(payload.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (retryCount.present) {
      map['retry_count'] = Variable<int>(retryCount.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SyncQueueCompanion(')
          ..write('id: $id, ')
          ..write('entity: $entity, ')
          ..write('operation: $operation, ')
          ..write('payload: $payload, ')
          ..write('status: $status, ')
          ..write('retryCount: $retryCount, ')
          ..write('createdAt: $createdAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $ClientEmployeesTable extends ClientEmployees
    with TableInfo<$ClientEmployeesTable, ClientEmployee> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ClientEmployeesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _remoteIdMeta = const VerificationMeta(
    'remoteId',
  );
  @override
  late final GeneratedColumn<int> remoteId = GeneratedColumn<int>(
    'remote_id',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _clientIdMeta = const VerificationMeta(
    'clientId',
  );
  @override
  late final GeneratedColumn<int> clientId = GeneratedColumn<int>(
    'client_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _previousClientIdMeta = const VerificationMeta(
    'previousClientId',
  );
  @override
  late final GeneratedColumn<int> previousClientId = GeneratedColumn<int>(
    'previous_client_id',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _phoneMeta = const VerificationMeta('phone');
  @override
  late final GeneratedColumn<String> phone = GeneratedColumn<String>(
    'phone',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _roleMeta = const VerificationMeta('role');
  @override
  late final GeneratedColumn<String> role = GeneratedColumn<String>(
    'role',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _isDecisionMakerMeta = const VerificationMeta(
    'isDecisionMaker',
  );
  @override
  late final GeneratedColumn<bool> isDecisionMaker = GeneratedColumn<bool>(
    'is_decision_maker',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_decision_maker" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
    'notes',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    remoteId,
    clientId,
    previousClientId,
    name,
    phone,
    role,
    isDecisionMaker,
    notes,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'client_employees';
  @override
  VerificationContext validateIntegrity(
    Insertable<ClientEmployee> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('remote_id')) {
      context.handle(
        _remoteIdMeta,
        remoteId.isAcceptableOrUnknown(data['remote_id']!, _remoteIdMeta),
      );
    }
    if (data.containsKey('client_id')) {
      context.handle(
        _clientIdMeta,
        clientId.isAcceptableOrUnknown(data['client_id']!, _clientIdMeta),
      );
    } else if (isInserting) {
      context.missing(_clientIdMeta);
    }
    if (data.containsKey('previous_client_id')) {
      context.handle(
        _previousClientIdMeta,
        previousClientId.isAcceptableOrUnknown(
          data['previous_client_id']!,
          _previousClientIdMeta,
        ),
      );
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('phone')) {
      context.handle(
        _phoneMeta,
        phone.isAcceptableOrUnknown(data['phone']!, _phoneMeta),
      );
    }
    if (data.containsKey('role')) {
      context.handle(
        _roleMeta,
        role.isAcceptableOrUnknown(data['role']!, _roleMeta),
      );
    }
    if (data.containsKey('is_decision_maker')) {
      context.handle(
        _isDecisionMakerMeta,
        isDecisionMaker.isAcceptableOrUnknown(
          data['is_decision_maker']!,
          _isDecisionMakerMeta,
        ),
      );
    }
    if (data.containsKey('notes')) {
      context.handle(
        _notesMeta,
        notes.isAcceptableOrUnknown(data['notes']!, _notesMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ClientEmployee map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ClientEmployee(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      remoteId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}remote_id'],
      ),
      clientId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}client_id'],
      )!,
      previousClientId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}previous_client_id'],
      ),
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      phone: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}phone'],
      ),
      role: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}role'],
      ),
      isDecisionMaker: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_decision_maker'],
      )!,
      notes: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}notes'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $ClientEmployeesTable createAlias(String alias) {
    return $ClientEmployeesTable(attachedDatabase, alias);
  }
}

class ClientEmployee extends DataClass implements Insertable<ClientEmployee> {
  final int id;
  final int? remoteId;
  final int clientId;
  final int? previousClientId;
  final String name;
  final String? phone;
  final String? role;
  final bool isDecisionMaker;
  final String? notes;
  final DateTime createdAt;
  final DateTime updatedAt;
  const ClientEmployee({
    required this.id,
    this.remoteId,
    required this.clientId,
    this.previousClientId,
    required this.name,
    this.phone,
    this.role,
    required this.isDecisionMaker,
    this.notes,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    if (!nullToAbsent || remoteId != null) {
      map['remote_id'] = Variable<int>(remoteId);
    }
    map['client_id'] = Variable<int>(clientId);
    if (!nullToAbsent || previousClientId != null) {
      map['previous_client_id'] = Variable<int>(previousClientId);
    }
    map['name'] = Variable<String>(name);
    if (!nullToAbsent || phone != null) {
      map['phone'] = Variable<String>(phone);
    }
    if (!nullToAbsent || role != null) {
      map['role'] = Variable<String>(role);
    }
    map['is_decision_maker'] = Variable<bool>(isDecisionMaker);
    if (!nullToAbsent || notes != null) {
      map['notes'] = Variable<String>(notes);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  ClientEmployeesCompanion toCompanion(bool nullToAbsent) {
    return ClientEmployeesCompanion(
      id: Value(id),
      remoteId: remoteId == null && nullToAbsent
          ? const Value.absent()
          : Value(remoteId),
      clientId: Value(clientId),
      previousClientId: previousClientId == null && nullToAbsent
          ? const Value.absent()
          : Value(previousClientId),
      name: Value(name),
      phone: phone == null && nullToAbsent
          ? const Value.absent()
          : Value(phone),
      role: role == null && nullToAbsent ? const Value.absent() : Value(role),
      isDecisionMaker: Value(isDecisionMaker),
      notes: notes == null && nullToAbsent
          ? const Value.absent()
          : Value(notes),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory ClientEmployee.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ClientEmployee(
      id: serializer.fromJson<int>(json['id']),
      remoteId: serializer.fromJson<int?>(json['remoteId']),
      clientId: serializer.fromJson<int>(json['clientId']),
      previousClientId: serializer.fromJson<int?>(json['previousClientId']),
      name: serializer.fromJson<String>(json['name']),
      phone: serializer.fromJson<String?>(json['phone']),
      role: serializer.fromJson<String?>(json['role']),
      isDecisionMaker: serializer.fromJson<bool>(json['isDecisionMaker']),
      notes: serializer.fromJson<String?>(json['notes']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'remoteId': serializer.toJson<int?>(remoteId),
      'clientId': serializer.toJson<int>(clientId),
      'previousClientId': serializer.toJson<int?>(previousClientId),
      'name': serializer.toJson<String>(name),
      'phone': serializer.toJson<String?>(phone),
      'role': serializer.toJson<String?>(role),
      'isDecisionMaker': serializer.toJson<bool>(isDecisionMaker),
      'notes': serializer.toJson<String?>(notes),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  ClientEmployee copyWith({
    int? id,
    Value<int?> remoteId = const Value.absent(),
    int? clientId,
    Value<int?> previousClientId = const Value.absent(),
    String? name,
    Value<String?> phone = const Value.absent(),
    Value<String?> role = const Value.absent(),
    bool? isDecisionMaker,
    Value<String?> notes = const Value.absent(),
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => ClientEmployee(
    id: id ?? this.id,
    remoteId: remoteId.present ? remoteId.value : this.remoteId,
    clientId: clientId ?? this.clientId,
    previousClientId: previousClientId.present
        ? previousClientId.value
        : this.previousClientId,
    name: name ?? this.name,
    phone: phone.present ? phone.value : this.phone,
    role: role.present ? role.value : this.role,
    isDecisionMaker: isDecisionMaker ?? this.isDecisionMaker,
    notes: notes.present ? notes.value : this.notes,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  ClientEmployee copyWithCompanion(ClientEmployeesCompanion data) {
    return ClientEmployee(
      id: data.id.present ? data.id.value : this.id,
      remoteId: data.remoteId.present ? data.remoteId.value : this.remoteId,
      clientId: data.clientId.present ? data.clientId.value : this.clientId,
      previousClientId: data.previousClientId.present
          ? data.previousClientId.value
          : this.previousClientId,
      name: data.name.present ? data.name.value : this.name,
      phone: data.phone.present ? data.phone.value : this.phone,
      role: data.role.present ? data.role.value : this.role,
      isDecisionMaker: data.isDecisionMaker.present
          ? data.isDecisionMaker.value
          : this.isDecisionMaker,
      notes: data.notes.present ? data.notes.value : this.notes,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ClientEmployee(')
          ..write('id: $id, ')
          ..write('remoteId: $remoteId, ')
          ..write('clientId: $clientId, ')
          ..write('previousClientId: $previousClientId, ')
          ..write('name: $name, ')
          ..write('phone: $phone, ')
          ..write('role: $role, ')
          ..write('isDecisionMaker: $isDecisionMaker, ')
          ..write('notes: $notes, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    remoteId,
    clientId,
    previousClientId,
    name,
    phone,
    role,
    isDecisionMaker,
    notes,
    createdAt,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ClientEmployee &&
          other.id == this.id &&
          other.remoteId == this.remoteId &&
          other.clientId == this.clientId &&
          other.previousClientId == this.previousClientId &&
          other.name == this.name &&
          other.phone == this.phone &&
          other.role == this.role &&
          other.isDecisionMaker == this.isDecisionMaker &&
          other.notes == this.notes &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class ClientEmployeesCompanion extends UpdateCompanion<ClientEmployee> {
  final Value<int> id;
  final Value<int?> remoteId;
  final Value<int> clientId;
  final Value<int?> previousClientId;
  final Value<String> name;
  final Value<String?> phone;
  final Value<String?> role;
  final Value<bool> isDecisionMaker;
  final Value<String?> notes;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  const ClientEmployeesCompanion({
    this.id = const Value.absent(),
    this.remoteId = const Value.absent(),
    this.clientId = const Value.absent(),
    this.previousClientId = const Value.absent(),
    this.name = const Value.absent(),
    this.phone = const Value.absent(),
    this.role = const Value.absent(),
    this.isDecisionMaker = const Value.absent(),
    this.notes = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  ClientEmployeesCompanion.insert({
    this.id = const Value.absent(),
    this.remoteId = const Value.absent(),
    required int clientId,
    this.previousClientId = const Value.absent(),
    required String name,
    this.phone = const Value.absent(),
    this.role = const Value.absent(),
    this.isDecisionMaker = const Value.absent(),
    this.notes = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  }) : clientId = Value(clientId),
       name = Value(name);
  static Insertable<ClientEmployee> custom({
    Expression<int>? id,
    Expression<int>? remoteId,
    Expression<int>? clientId,
    Expression<int>? previousClientId,
    Expression<String>? name,
    Expression<String>? phone,
    Expression<String>? role,
    Expression<bool>? isDecisionMaker,
    Expression<String>? notes,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (remoteId != null) 'remote_id': remoteId,
      if (clientId != null) 'client_id': clientId,
      if (previousClientId != null) 'previous_client_id': previousClientId,
      if (name != null) 'name': name,
      if (phone != null) 'phone': phone,
      if (role != null) 'role': role,
      if (isDecisionMaker != null) 'is_decision_maker': isDecisionMaker,
      if (notes != null) 'notes': notes,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  ClientEmployeesCompanion copyWith({
    Value<int>? id,
    Value<int?>? remoteId,
    Value<int>? clientId,
    Value<int?>? previousClientId,
    Value<String>? name,
    Value<String?>? phone,
    Value<String?>? role,
    Value<bool>? isDecisionMaker,
    Value<String?>? notes,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
  }) {
    return ClientEmployeesCompanion(
      id: id ?? this.id,
      remoteId: remoteId ?? this.remoteId,
      clientId: clientId ?? this.clientId,
      previousClientId: previousClientId ?? this.previousClientId,
      name: name ?? this.name,
      phone: phone ?? this.phone,
      role: role ?? this.role,
      isDecisionMaker: isDecisionMaker ?? this.isDecisionMaker,
      notes: notes ?? this.notes,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (remoteId.present) {
      map['remote_id'] = Variable<int>(remoteId.value);
    }
    if (clientId.present) {
      map['client_id'] = Variable<int>(clientId.value);
    }
    if (previousClientId.present) {
      map['previous_client_id'] = Variable<int>(previousClientId.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (phone.present) {
      map['phone'] = Variable<String>(phone.value);
    }
    if (role.present) {
      map['role'] = Variable<String>(role.value);
    }
    if (isDecisionMaker.present) {
      map['is_decision_maker'] = Variable<bool>(isDecisionMaker.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ClientEmployeesCompanion(')
          ..write('id: $id, ')
          ..write('remoteId: $remoteId, ')
          ..write('clientId: $clientId, ')
          ..write('previousClientId: $previousClientId, ')
          ..write('name: $name, ')
          ..write('phone: $phone, ')
          ..write('role: $role, ')
          ..write('isDecisionMaker: $isDecisionMaker, ')
          ..write('notes: $notes, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }
}

class $BranchesTable extends Branches with TableInfo<$BranchesTable, Branch> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $BranchesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _remoteIdMeta = const VerificationMeta(
    'remoteId',
  );
  @override
  late final GeneratedColumn<int> remoteId = GeneratedColumn<int>(
    'remote_id',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _addressMeta = const VerificationMeta(
    'address',
  );
  @override
  late final GeneratedColumn<String> address = GeneratedColumn<String>(
    'address',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _phoneMeta = const VerificationMeta('phone');
  @override
  late final GeneratedColumn<String> phone = GeneratedColumn<String>(
    'phone',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _managerNameMeta = const VerificationMeta(
    'managerName',
  );
  @override
  late final GeneratedColumn<String> managerName = GeneratedColumn<String>(
    'manager_name',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    remoteId,
    name,
    address,
    phone,
    managerName,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'branches';
  @override
  VerificationContext validateIntegrity(
    Insertable<Branch> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('remote_id')) {
      context.handle(
        _remoteIdMeta,
        remoteId.isAcceptableOrUnknown(data['remote_id']!, _remoteIdMeta),
      );
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('address')) {
      context.handle(
        _addressMeta,
        address.isAcceptableOrUnknown(data['address']!, _addressMeta),
      );
    }
    if (data.containsKey('phone')) {
      context.handle(
        _phoneMeta,
        phone.isAcceptableOrUnknown(data['phone']!, _phoneMeta),
      );
    }
    if (data.containsKey('manager_name')) {
      context.handle(
        _managerNameMeta,
        managerName.isAcceptableOrUnknown(
          data['manager_name']!,
          _managerNameMeta,
        ),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Branch map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Branch(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      remoteId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}remote_id'],
      ),
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      address: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}address'],
      ),
      phone: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}phone'],
      ),
      managerName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}manager_name'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $BranchesTable createAlias(String alias) {
    return $BranchesTable(attachedDatabase, alias);
  }
}

class Branch extends DataClass implements Insertable<Branch> {
  final int id;
  final int? remoteId;
  final String name;
  final String? address;
  final String? phone;
  final String? managerName;
  final DateTime createdAt;
  final DateTime updatedAt;
  const Branch({
    required this.id,
    this.remoteId,
    required this.name,
    this.address,
    this.phone,
    this.managerName,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    if (!nullToAbsent || remoteId != null) {
      map['remote_id'] = Variable<int>(remoteId);
    }
    map['name'] = Variable<String>(name);
    if (!nullToAbsent || address != null) {
      map['address'] = Variable<String>(address);
    }
    if (!nullToAbsent || phone != null) {
      map['phone'] = Variable<String>(phone);
    }
    if (!nullToAbsent || managerName != null) {
      map['manager_name'] = Variable<String>(managerName);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  BranchesCompanion toCompanion(bool nullToAbsent) {
    return BranchesCompanion(
      id: Value(id),
      remoteId: remoteId == null && nullToAbsent
          ? const Value.absent()
          : Value(remoteId),
      name: Value(name),
      address: address == null && nullToAbsent
          ? const Value.absent()
          : Value(address),
      phone: phone == null && nullToAbsent
          ? const Value.absent()
          : Value(phone),
      managerName: managerName == null && nullToAbsent
          ? const Value.absent()
          : Value(managerName),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory Branch.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Branch(
      id: serializer.fromJson<int>(json['id']),
      remoteId: serializer.fromJson<int?>(json['remoteId']),
      name: serializer.fromJson<String>(json['name']),
      address: serializer.fromJson<String?>(json['address']),
      phone: serializer.fromJson<String?>(json['phone']),
      managerName: serializer.fromJson<String?>(json['managerName']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'remoteId': serializer.toJson<int?>(remoteId),
      'name': serializer.toJson<String>(name),
      'address': serializer.toJson<String?>(address),
      'phone': serializer.toJson<String?>(phone),
      'managerName': serializer.toJson<String?>(managerName),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  Branch copyWith({
    int? id,
    Value<int?> remoteId = const Value.absent(),
    String? name,
    Value<String?> address = const Value.absent(),
    Value<String?> phone = const Value.absent(),
    Value<String?> managerName = const Value.absent(),
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => Branch(
    id: id ?? this.id,
    remoteId: remoteId.present ? remoteId.value : this.remoteId,
    name: name ?? this.name,
    address: address.present ? address.value : this.address,
    phone: phone.present ? phone.value : this.phone,
    managerName: managerName.present ? managerName.value : this.managerName,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  Branch copyWithCompanion(BranchesCompanion data) {
    return Branch(
      id: data.id.present ? data.id.value : this.id,
      remoteId: data.remoteId.present ? data.remoteId.value : this.remoteId,
      name: data.name.present ? data.name.value : this.name,
      address: data.address.present ? data.address.value : this.address,
      phone: data.phone.present ? data.phone.value : this.phone,
      managerName: data.managerName.present
          ? data.managerName.value
          : this.managerName,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Branch(')
          ..write('id: $id, ')
          ..write('remoteId: $remoteId, ')
          ..write('name: $name, ')
          ..write('address: $address, ')
          ..write('phone: $phone, ')
          ..write('managerName: $managerName, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    remoteId,
    name,
    address,
    phone,
    managerName,
    createdAt,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Branch &&
          other.id == this.id &&
          other.remoteId == this.remoteId &&
          other.name == this.name &&
          other.address == this.address &&
          other.phone == this.phone &&
          other.managerName == this.managerName &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class BranchesCompanion extends UpdateCompanion<Branch> {
  final Value<int> id;
  final Value<int?> remoteId;
  final Value<String> name;
  final Value<String?> address;
  final Value<String?> phone;
  final Value<String?> managerName;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  const BranchesCompanion({
    this.id = const Value.absent(),
    this.remoteId = const Value.absent(),
    this.name = const Value.absent(),
    this.address = const Value.absent(),
    this.phone = const Value.absent(),
    this.managerName = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  BranchesCompanion.insert({
    this.id = const Value.absent(),
    this.remoteId = const Value.absent(),
    required String name,
    this.address = const Value.absent(),
    this.phone = const Value.absent(),
    this.managerName = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  }) : name = Value(name);
  static Insertable<Branch> custom({
    Expression<int>? id,
    Expression<int>? remoteId,
    Expression<String>? name,
    Expression<String>? address,
    Expression<String>? phone,
    Expression<String>? managerName,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (remoteId != null) 'remote_id': remoteId,
      if (name != null) 'name': name,
      if (address != null) 'address': address,
      if (phone != null) 'phone': phone,
      if (managerName != null) 'manager_name': managerName,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  BranchesCompanion copyWith({
    Value<int>? id,
    Value<int?>? remoteId,
    Value<String>? name,
    Value<String?>? address,
    Value<String?>? phone,
    Value<String?>? managerName,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
  }) {
    return BranchesCompanion(
      id: id ?? this.id,
      remoteId: remoteId ?? this.remoteId,
      name: name ?? this.name,
      address: address ?? this.address,
      phone: phone ?? this.phone,
      managerName: managerName ?? this.managerName,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (remoteId.present) {
      map['remote_id'] = Variable<int>(remoteId.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (address.present) {
      map['address'] = Variable<String>(address.value);
    }
    if (phone.present) {
      map['phone'] = Variable<String>(phone.value);
    }
    if (managerName.present) {
      map['manager_name'] = Variable<String>(managerName.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('BranchesCompanion(')
          ..write('id: $id, ')
          ..write('remoteId: $remoteId, ')
          ..write('name: $name, ')
          ..write('address: $address, ')
          ..write('phone: $phone, ')
          ..write('managerName: $managerName, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }
}

class $CitiesTable extends Cities with TableInfo<$CitiesTable, City> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CitiesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _remoteIdMeta = const VerificationMeta(
    'remoteId',
  );
  @override
  late final GeneratedColumn<int> remoteId = GeneratedColumn<int>(
    'remote_id',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _governorateMeta = const VerificationMeta(
    'governorate',
  );
  @override
  late final GeneratedColumn<String> governorate = GeneratedColumn<String>(
    'governorate',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    remoteId,
    name,
    governorate,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'cities';
  @override
  VerificationContext validateIntegrity(
    Insertable<City> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('remote_id')) {
      context.handle(
        _remoteIdMeta,
        remoteId.isAcceptableOrUnknown(data['remote_id']!, _remoteIdMeta),
      );
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('governorate')) {
      context.handle(
        _governorateMeta,
        governorate.isAcceptableOrUnknown(
          data['governorate']!,
          _governorateMeta,
        ),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  City map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return City(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      remoteId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}remote_id'],
      ),
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      governorate: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}governorate'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $CitiesTable createAlias(String alias) {
    return $CitiesTable(attachedDatabase, alias);
  }
}

class City extends DataClass implements Insertable<City> {
  final int id;
  final int? remoteId;
  final String name;
  final String? governorate;
  final DateTime createdAt;
  final DateTime updatedAt;
  const City({
    required this.id,
    this.remoteId,
    required this.name,
    this.governorate,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    if (!nullToAbsent || remoteId != null) {
      map['remote_id'] = Variable<int>(remoteId);
    }
    map['name'] = Variable<String>(name);
    if (!nullToAbsent || governorate != null) {
      map['governorate'] = Variable<String>(governorate);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  CitiesCompanion toCompanion(bool nullToAbsent) {
    return CitiesCompanion(
      id: Value(id),
      remoteId: remoteId == null && nullToAbsent
          ? const Value.absent()
          : Value(remoteId),
      name: Value(name),
      governorate: governorate == null && nullToAbsent
          ? const Value.absent()
          : Value(governorate),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory City.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return City(
      id: serializer.fromJson<int>(json['id']),
      remoteId: serializer.fromJson<int?>(json['remoteId']),
      name: serializer.fromJson<String>(json['name']),
      governorate: serializer.fromJson<String?>(json['governorate']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'remoteId': serializer.toJson<int?>(remoteId),
      'name': serializer.toJson<String>(name),
      'governorate': serializer.toJson<String?>(governorate),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  City copyWith({
    int? id,
    Value<int?> remoteId = const Value.absent(),
    String? name,
    Value<String?> governorate = const Value.absent(),
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => City(
    id: id ?? this.id,
    remoteId: remoteId.present ? remoteId.value : this.remoteId,
    name: name ?? this.name,
    governorate: governorate.present ? governorate.value : this.governorate,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  City copyWithCompanion(CitiesCompanion data) {
    return City(
      id: data.id.present ? data.id.value : this.id,
      remoteId: data.remoteId.present ? data.remoteId.value : this.remoteId,
      name: data.name.present ? data.name.value : this.name,
      governorate: data.governorate.present
          ? data.governorate.value
          : this.governorate,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('City(')
          ..write('id: $id, ')
          ..write('remoteId: $remoteId, ')
          ..write('name: $name, ')
          ..write('governorate: $governorate, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, remoteId, name, governorate, createdAt, updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is City &&
          other.id == this.id &&
          other.remoteId == this.remoteId &&
          other.name == this.name &&
          other.governorate == this.governorate &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class CitiesCompanion extends UpdateCompanion<City> {
  final Value<int> id;
  final Value<int?> remoteId;
  final Value<String> name;
  final Value<String?> governorate;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  const CitiesCompanion({
    this.id = const Value.absent(),
    this.remoteId = const Value.absent(),
    this.name = const Value.absent(),
    this.governorate = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  CitiesCompanion.insert({
    this.id = const Value.absent(),
    this.remoteId = const Value.absent(),
    required String name,
    this.governorate = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  }) : name = Value(name);
  static Insertable<City> custom({
    Expression<int>? id,
    Expression<int>? remoteId,
    Expression<String>? name,
    Expression<String>? governorate,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (remoteId != null) 'remote_id': remoteId,
      if (name != null) 'name': name,
      if (governorate != null) 'governorate': governorate,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  CitiesCompanion copyWith({
    Value<int>? id,
    Value<int?>? remoteId,
    Value<String>? name,
    Value<String?>? governorate,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
  }) {
    return CitiesCompanion(
      id: id ?? this.id,
      remoteId: remoteId ?? this.remoteId,
      name: name ?? this.name,
      governorate: governorate ?? this.governorate,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (remoteId.present) {
      map['remote_id'] = Variable<int>(remoteId.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (governorate.present) {
      map['governorate'] = Variable<String>(governorate.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CitiesCompanion(')
          ..write('id: $id, ')
          ..write('remoteId: $remoteId, ')
          ..write('name: $name, ')
          ..write('governorate: $governorate, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }
}

class $ClassificationsTable extends Classifications
    with TableInfo<$ClassificationsTable, Classification> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ClassificationsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _remoteIdMeta = const VerificationMeta(
    'remoteId',
  );
  @override
  late final GeneratedColumn<int> remoteId = GeneratedColumn<int>(
    'remote_id',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _typeMeta = const VerificationMeta('type');
  @override
  late final GeneratedColumn<String> type = GeneratedColumn<String>(
    'type',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    remoteId,
    name,
    type,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'classifications';
  @override
  VerificationContext validateIntegrity(
    Insertable<Classification> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('remote_id')) {
      context.handle(
        _remoteIdMeta,
        remoteId.isAcceptableOrUnknown(data['remote_id']!, _remoteIdMeta),
      );
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('type')) {
      context.handle(
        _typeMeta,
        type.isAcceptableOrUnknown(data['type']!, _typeMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Classification map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Classification(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      remoteId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}remote_id'],
      ),
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      type: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}type'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $ClassificationsTable createAlias(String alias) {
    return $ClassificationsTable(attachedDatabase, alias);
  }
}

class Classification extends DataClass implements Insertable<Classification> {
  final int id;
  final int? remoteId;
  final String name;
  final String? type;
  final DateTime createdAt;
  final DateTime updatedAt;
  const Classification({
    required this.id,
    this.remoteId,
    required this.name,
    this.type,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    if (!nullToAbsent || remoteId != null) {
      map['remote_id'] = Variable<int>(remoteId);
    }
    map['name'] = Variable<String>(name);
    if (!nullToAbsent || type != null) {
      map['type'] = Variable<String>(type);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  ClassificationsCompanion toCompanion(bool nullToAbsent) {
    return ClassificationsCompanion(
      id: Value(id),
      remoteId: remoteId == null && nullToAbsent
          ? const Value.absent()
          : Value(remoteId),
      name: Value(name),
      type: type == null && nullToAbsent ? const Value.absent() : Value(type),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory Classification.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Classification(
      id: serializer.fromJson<int>(json['id']),
      remoteId: serializer.fromJson<int?>(json['remoteId']),
      name: serializer.fromJson<String>(json['name']),
      type: serializer.fromJson<String?>(json['type']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'remoteId': serializer.toJson<int?>(remoteId),
      'name': serializer.toJson<String>(name),
      'type': serializer.toJson<String?>(type),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  Classification copyWith({
    int? id,
    Value<int?> remoteId = const Value.absent(),
    String? name,
    Value<String?> type = const Value.absent(),
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => Classification(
    id: id ?? this.id,
    remoteId: remoteId.present ? remoteId.value : this.remoteId,
    name: name ?? this.name,
    type: type.present ? type.value : this.type,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  Classification copyWithCompanion(ClassificationsCompanion data) {
    return Classification(
      id: data.id.present ? data.id.value : this.id,
      remoteId: data.remoteId.present ? data.remoteId.value : this.remoteId,
      name: data.name.present ? data.name.value : this.name,
      type: data.type.present ? data.type.value : this.type,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Classification(')
          ..write('id: $id, ')
          ..write('remoteId: $remoteId, ')
          ..write('name: $name, ')
          ..write('type: $type, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, remoteId, name, type, createdAt, updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Classification &&
          other.id == this.id &&
          other.remoteId == this.remoteId &&
          other.name == this.name &&
          other.type == this.type &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class ClassificationsCompanion extends UpdateCompanion<Classification> {
  final Value<int> id;
  final Value<int?> remoteId;
  final Value<String> name;
  final Value<String?> type;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  const ClassificationsCompanion({
    this.id = const Value.absent(),
    this.remoteId = const Value.absent(),
    this.name = const Value.absent(),
    this.type = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  ClassificationsCompanion.insert({
    this.id = const Value.absent(),
    this.remoteId = const Value.absent(),
    required String name,
    this.type = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  }) : name = Value(name);
  static Insertable<Classification> custom({
    Expression<int>? id,
    Expression<int>? remoteId,
    Expression<String>? name,
    Expression<String>? type,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (remoteId != null) 'remote_id': remoteId,
      if (name != null) 'name': name,
      if (type != null) 'type': type,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  ClassificationsCompanion copyWith({
    Value<int>? id,
    Value<int?>? remoteId,
    Value<String>? name,
    Value<String?>? type,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
  }) {
    return ClassificationsCompanion(
      id: id ?? this.id,
      remoteId: remoteId ?? this.remoteId,
      name: name ?? this.name,
      type: type ?? this.type,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (remoteId.present) {
      map['remote_id'] = Variable<int>(remoteId.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (type.present) {
      map['type'] = Variable<String>(type.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ClassificationsCompanion(')
          ..write('id: $id, ')
          ..write('remoteId: $remoteId, ')
          ..write('name: $name, ')
          ..write('type: $type, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }
}

class $SubTasksTable extends SubTasks with TableInfo<$SubTasksTable, SubTask> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SubTasksTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _taskIdMeta = const VerificationMeta('taskId');
  @override
  late final GeneratedColumn<String> taskId = GeneratedColumn<String>(
    'task_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES tasks (id)',
    ),
  );
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
    'title',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _isCompletedMeta = const VerificationMeta(
    'isCompleted',
  );
  @override
  late final GeneratedColumn<bool> isCompleted = GeneratedColumn<bool>(
    'is_completed',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_completed" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    taskId,
    title,
    isCompleted,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'sub_tasks';
  @override
  VerificationContext validateIntegrity(
    Insertable<SubTask> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('task_id')) {
      context.handle(
        _taskIdMeta,
        taskId.isAcceptableOrUnknown(data['task_id']!, _taskIdMeta),
      );
    } else if (isInserting) {
      context.missing(_taskIdMeta);
    }
    if (data.containsKey('title')) {
      context.handle(
        _titleMeta,
        title.isAcceptableOrUnknown(data['title']!, _titleMeta),
      );
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('is_completed')) {
      context.handle(
        _isCompletedMeta,
        isCompleted.isAcceptableOrUnknown(
          data['is_completed']!,
          _isCompletedMeta,
        ),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  SubTask map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SubTask(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      taskId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}task_id'],
      )!,
      title: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}title'],
      )!,
      isCompleted: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_completed'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $SubTasksTable createAlias(String alias) {
    return $SubTasksTable(attachedDatabase, alias);
  }
}

class SubTask extends DataClass implements Insertable<SubTask> {
  final int id;
  final String taskId;
  final String title;
  final bool isCompleted;
  final DateTime createdAt;
  const SubTask({
    required this.id,
    required this.taskId,
    required this.title,
    required this.isCompleted,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['task_id'] = Variable<String>(taskId);
    map['title'] = Variable<String>(title);
    map['is_completed'] = Variable<bool>(isCompleted);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  SubTasksCompanion toCompanion(bool nullToAbsent) {
    return SubTasksCompanion(
      id: Value(id),
      taskId: Value(taskId),
      title: Value(title),
      isCompleted: Value(isCompleted),
      createdAt: Value(createdAt),
    );
  }

  factory SubTask.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SubTask(
      id: serializer.fromJson<int>(json['id']),
      taskId: serializer.fromJson<String>(json['taskId']),
      title: serializer.fromJson<String>(json['title']),
      isCompleted: serializer.fromJson<bool>(json['isCompleted']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'taskId': serializer.toJson<String>(taskId),
      'title': serializer.toJson<String>(title),
      'isCompleted': serializer.toJson<bool>(isCompleted),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  SubTask copyWith({
    int? id,
    String? taskId,
    String? title,
    bool? isCompleted,
    DateTime? createdAt,
  }) => SubTask(
    id: id ?? this.id,
    taskId: taskId ?? this.taskId,
    title: title ?? this.title,
    isCompleted: isCompleted ?? this.isCompleted,
    createdAt: createdAt ?? this.createdAt,
  );
  SubTask copyWithCompanion(SubTasksCompanion data) {
    return SubTask(
      id: data.id.present ? data.id.value : this.id,
      taskId: data.taskId.present ? data.taskId.value : this.taskId,
      title: data.title.present ? data.title.value : this.title,
      isCompleted: data.isCompleted.present
          ? data.isCompleted.value
          : this.isCompleted,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('SubTask(')
          ..write('id: $id, ')
          ..write('taskId: $taskId, ')
          ..write('title: $title, ')
          ..write('isCompleted: $isCompleted, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, taskId, title, isCompleted, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SubTask &&
          other.id == this.id &&
          other.taskId == this.taskId &&
          other.title == this.title &&
          other.isCompleted == this.isCompleted &&
          other.createdAt == this.createdAt);
}

class SubTasksCompanion extends UpdateCompanion<SubTask> {
  final Value<int> id;
  final Value<String> taskId;
  final Value<String> title;
  final Value<bool> isCompleted;
  final Value<DateTime> createdAt;
  const SubTasksCompanion({
    this.id = const Value.absent(),
    this.taskId = const Value.absent(),
    this.title = const Value.absent(),
    this.isCompleted = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  SubTasksCompanion.insert({
    this.id = const Value.absent(),
    required String taskId,
    required String title,
    this.isCompleted = const Value.absent(),
    this.createdAt = const Value.absent(),
  }) : taskId = Value(taskId),
       title = Value(title);
  static Insertable<SubTask> custom({
    Expression<int>? id,
    Expression<String>? taskId,
    Expression<String>? title,
    Expression<bool>? isCompleted,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (taskId != null) 'task_id': taskId,
      if (title != null) 'title': title,
      if (isCompleted != null) 'is_completed': isCompleted,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  SubTasksCompanion copyWith({
    Value<int>? id,
    Value<String>? taskId,
    Value<String>? title,
    Value<bool>? isCompleted,
    Value<DateTime>? createdAt,
  }) {
    return SubTasksCompanion(
      id: id ?? this.id,
      taskId: taskId ?? this.taskId,
      title: title ?? this.title,
      isCompleted: isCompleted ?? this.isCompleted,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (taskId.present) {
      map['task_id'] = Variable<String>(taskId.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (isCompleted.present) {
      map['is_completed'] = Variable<bool>(isCompleted.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SubTasksCompanion(')
          ..write('id: $id, ')
          ..write('taskId: $taskId, ')
          ..write('title: $title, ')
          ..write('isCompleted: $isCompleted, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $ClientsTable clients = $ClientsTable(this);
  late final $CampaignsTable campaigns = $CampaignsTable(this);
  late final $TasksTable tasks = $TasksTable(this);
  late final $FieldReportsTable fieldReports = $FieldReportsTable(this);
  late final $AdAssetsTable adAssets = $AdAssetsTable(this);
  late final $SyncQueueTable syncQueue = $SyncQueueTable(this);
  late final $ClientEmployeesTable clientEmployees = $ClientEmployeesTable(
    this,
  );
  late final $BranchesTable branches = $BranchesTable(this);
  late final $CitiesTable cities = $CitiesTable(this);
  late final $ClassificationsTable classifications = $ClassificationsTable(
    this,
  );
  late final $SubTasksTable subTasks = $SubTasksTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    clients,
    campaigns,
    tasks,
    fieldReports,
    adAssets,
    syncQueue,
    clientEmployees,
    branches,
    cities,
    classifications,
    subTasks,
  ];
}

typedef $$ClientsTableCreateCompanionBuilder =
    ClientsCompanion Function({
      Value<int> id,
      Value<int?> remoteId,
      required String name,
      Value<List<String>?> phone,
      Value<String?> email,
      Value<String?> category,
      Value<int?> agentId,
      Value<int?> branchId,
      Value<String?> address,
      Value<String?> gpsLocation,
      Value<List<String>?> images,
      Value<String?> profileImage,
      Value<String?> importance,
      Value<String?> province,
      Value<String?> district,
      Value<String?> notes,
      Value<bool> isAgent,
      Value<DateTime?> lastVisit,
      Value<String?> loyaltyLevel,
      Value<bool> isDraft,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
    });
typedef $$ClientsTableUpdateCompanionBuilder =
    ClientsCompanion Function({
      Value<int> id,
      Value<int?> remoteId,
      Value<String> name,
      Value<List<String>?> phone,
      Value<String?> email,
      Value<String?> category,
      Value<int?> agentId,
      Value<int?> branchId,
      Value<String?> address,
      Value<String?> gpsLocation,
      Value<List<String>?> images,
      Value<String?> profileImage,
      Value<String?> importance,
      Value<String?> province,
      Value<String?> district,
      Value<String?> notes,
      Value<bool> isAgent,
      Value<DateTime?> lastVisit,
      Value<String?> loyaltyLevel,
      Value<bool> isDraft,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
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
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get remoteId => $composableBuilder(
    column: $table.remoteId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<List<String>?, List<String>, String>
  get phone => $composableBuilder(
    column: $table.phone,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );

  ColumnFilters<String> get email => $composableBuilder(
    column: $table.email,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get category => $composableBuilder(
    column: $table.category,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get agentId => $composableBuilder(
    column: $table.agentId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get branchId => $composableBuilder(
    column: $table.branchId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get address => $composableBuilder(
    column: $table.address,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get gpsLocation => $composableBuilder(
    column: $table.gpsLocation,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<List<String>?, List<String>, String>
  get images => $composableBuilder(
    column: $table.images,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );

  ColumnFilters<String> get profileImage => $composableBuilder(
    column: $table.profileImage,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get importance => $composableBuilder(
    column: $table.importance,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get province => $composableBuilder(
    column: $table.province,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get district => $composableBuilder(
    column: $table.district,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isAgent => $composableBuilder(
    column: $table.isAgent,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get lastVisit => $composableBuilder(
    column: $table.lastVisit,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get loyaltyLevel => $composableBuilder(
    column: $table.loyaltyLevel,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isDraft => $composableBuilder(
    column: $table.isDraft,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );
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
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get remoteId => $composableBuilder(
    column: $table.remoteId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get phone => $composableBuilder(
    column: $table.phone,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get email => $composableBuilder(
    column: $table.email,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get category => $composableBuilder(
    column: $table.category,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get agentId => $composableBuilder(
    column: $table.agentId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get branchId => $composableBuilder(
    column: $table.branchId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get address => $composableBuilder(
    column: $table.address,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get gpsLocation => $composableBuilder(
    column: $table.gpsLocation,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get images => $composableBuilder(
    column: $table.images,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get profileImage => $composableBuilder(
    column: $table.profileImage,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get importance => $composableBuilder(
    column: $table.importance,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get province => $composableBuilder(
    column: $table.province,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get district => $composableBuilder(
    column: $table.district,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isAgent => $composableBuilder(
    column: $table.isAgent,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get lastVisit => $composableBuilder(
    column: $table.lastVisit,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get loyaltyLevel => $composableBuilder(
    column: $table.loyaltyLevel,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isDraft => $composableBuilder(
    column: $table.isDraft,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );
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

  GeneratedColumn<int> get remoteId =>
      $composableBuilder(column: $table.remoteId, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumnWithTypeConverter<List<String>?, String> get phone =>
      $composableBuilder(column: $table.phone, builder: (column) => column);

  GeneratedColumn<String> get email =>
      $composableBuilder(column: $table.email, builder: (column) => column);

  GeneratedColumn<String> get category =>
      $composableBuilder(column: $table.category, builder: (column) => column);

  GeneratedColumn<int> get agentId =>
      $composableBuilder(column: $table.agentId, builder: (column) => column);

  GeneratedColumn<int> get branchId =>
      $composableBuilder(column: $table.branchId, builder: (column) => column);

  GeneratedColumn<String> get address =>
      $composableBuilder(column: $table.address, builder: (column) => column);

  GeneratedColumn<String> get gpsLocation => $composableBuilder(
    column: $table.gpsLocation,
    builder: (column) => column,
  );

  GeneratedColumnWithTypeConverter<List<String>?, String> get images =>
      $composableBuilder(column: $table.images, builder: (column) => column);

  GeneratedColumn<String> get profileImage => $composableBuilder(
    column: $table.profileImage,
    builder: (column) => column,
  );

  GeneratedColumn<String> get importance => $composableBuilder(
    column: $table.importance,
    builder: (column) => column,
  );

  GeneratedColumn<String> get province =>
      $composableBuilder(column: $table.province, builder: (column) => column);

  GeneratedColumn<String> get district =>
      $composableBuilder(column: $table.district, builder: (column) => column);

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);

  GeneratedColumn<bool> get isAgent =>
      $composableBuilder(column: $table.isAgent, builder: (column) => column);

  GeneratedColumn<DateTime> get lastVisit =>
      $composableBuilder(column: $table.lastVisit, builder: (column) => column);

  GeneratedColumn<String> get loyaltyLevel => $composableBuilder(
    column: $table.loyaltyLevel,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get isDraft =>
      $composableBuilder(column: $table.isDraft, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$ClientsTableTableManager
    extends
        RootTableManager<
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
          PrefetchHooks Function()
        > {
  $$ClientsTableTableManager(_$AppDatabase db, $ClientsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ClientsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ClientsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ClientsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int?> remoteId = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<List<String>?> phone = const Value.absent(),
                Value<String?> email = const Value.absent(),
                Value<String?> category = const Value.absent(),
                Value<int?> agentId = const Value.absent(),
                Value<int?> branchId = const Value.absent(),
                Value<String?> address = const Value.absent(),
                Value<String?> gpsLocation = const Value.absent(),
                Value<List<String>?> images = const Value.absent(),
                Value<String?> profileImage = const Value.absent(),
                Value<String?> importance = const Value.absent(),
                Value<String?> province = const Value.absent(),
                Value<String?> district = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                Value<bool> isAgent = const Value.absent(),
                Value<DateTime?> lastVisit = const Value.absent(),
                Value<String?> loyaltyLevel = const Value.absent(),
                Value<bool> isDraft = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
              }) => ClientsCompanion(
                id: id,
                remoteId: remoteId,
                name: name,
                phone: phone,
                email: email,
                category: category,
                agentId: agentId,
                branchId: branchId,
                address: address,
                gpsLocation: gpsLocation,
                images: images,
                profileImage: profileImage,
                importance: importance,
                province: province,
                district: district,
                notes: notes,
                isAgent: isAgent,
                lastVisit: lastVisit,
                loyaltyLevel: loyaltyLevel,
                isDraft: isDraft,
                createdAt: createdAt,
                updatedAt: updatedAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int?> remoteId = const Value.absent(),
                required String name,
                Value<List<String>?> phone = const Value.absent(),
                Value<String?> email = const Value.absent(),
                Value<String?> category = const Value.absent(),
                Value<int?> agentId = const Value.absent(),
                Value<int?> branchId = const Value.absent(),
                Value<String?> address = const Value.absent(),
                Value<String?> gpsLocation = const Value.absent(),
                Value<List<String>?> images = const Value.absent(),
                Value<String?> profileImage = const Value.absent(),
                Value<String?> importance = const Value.absent(),
                Value<String?> province = const Value.absent(),
                Value<String?> district = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                Value<bool> isAgent = const Value.absent(),
                Value<DateTime?> lastVisit = const Value.absent(),
                Value<String?> loyaltyLevel = const Value.absent(),
                Value<bool> isDraft = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
              }) => ClientsCompanion.insert(
                id: id,
                remoteId: remoteId,
                name: name,
                phone: phone,
                email: email,
                category: category,
                agentId: agentId,
                branchId: branchId,
                address: address,
                gpsLocation: gpsLocation,
                images: images,
                profileImage: profileImage,
                importance: importance,
                province: province,
                district: district,
                notes: notes,
                isAgent: isAgent,
                lastVisit: lastVisit,
                loyaltyLevel: loyaltyLevel,
                isDraft: isDraft,
                createdAt: createdAt,
                updatedAt: updatedAt,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$ClientsTableProcessedTableManager =
    ProcessedTableManager<
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
      PrefetchHooks Function()
    >;
typedef $$CampaignsTableCreateCompanionBuilder =
    CampaignsCompanion Function({
      Value<int> id,
      required String title,
      Value<String?> description,
      required String campaignType,
      Value<String> status,
      Value<DateTime?> startDate,
      Value<DateTime?> endDate,
      Value<String?> objective,
      Value<double> budget,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
    });
typedef $$CampaignsTableUpdateCompanionBuilder =
    CampaignsCompanion Function({
      Value<int> id,
      Value<String> title,
      Value<String?> description,
      Value<String> campaignType,
      Value<String> status,
      Value<DateTime?> startDate,
      Value<DateTime?> endDate,
      Value<String?> objective,
      Value<double> budget,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
    });

class $$CampaignsTableFilterComposer
    extends Composer<_$AppDatabase, $CampaignsTable> {
  $$CampaignsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get campaignType => $composableBuilder(
    column: $table.campaignType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get startDate => $composableBuilder(
    column: $table.startDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get endDate => $composableBuilder(
    column: $table.endDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get objective => $composableBuilder(
    column: $table.objective,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get budget => $composableBuilder(
    column: $table.budget,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$CampaignsTableOrderingComposer
    extends Composer<_$AppDatabase, $CampaignsTable> {
  $$CampaignsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get campaignType => $composableBuilder(
    column: $table.campaignType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get startDate => $composableBuilder(
    column: $table.startDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get endDate => $composableBuilder(
    column: $table.endDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get objective => $composableBuilder(
    column: $table.objective,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get budget => $composableBuilder(
    column: $table.budget,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$CampaignsTableAnnotationComposer
    extends Composer<_$AppDatabase, $CampaignsTable> {
  $$CampaignsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => column,
  );

  GeneratedColumn<String> get campaignType => $composableBuilder(
    column: $table.campaignType,
    builder: (column) => column,
  );

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<DateTime> get startDate =>
      $composableBuilder(column: $table.startDate, builder: (column) => column);

  GeneratedColumn<DateTime> get endDate =>
      $composableBuilder(column: $table.endDate, builder: (column) => column);

  GeneratedColumn<String> get objective =>
      $composableBuilder(column: $table.objective, builder: (column) => column);

  GeneratedColumn<double> get budget =>
      $composableBuilder(column: $table.budget, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$CampaignsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $CampaignsTable,
          Campaign,
          $$CampaignsTableFilterComposer,
          $$CampaignsTableOrderingComposer,
          $$CampaignsTableAnnotationComposer,
          $$CampaignsTableCreateCompanionBuilder,
          $$CampaignsTableUpdateCompanionBuilder,
          (Campaign, BaseReferences<_$AppDatabase, $CampaignsTable, Campaign>),
          Campaign,
          PrefetchHooks Function()
        > {
  $$CampaignsTableTableManager(_$AppDatabase db, $CampaignsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$CampaignsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$CampaignsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$CampaignsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> title = const Value.absent(),
                Value<String?> description = const Value.absent(),
                Value<String> campaignType = const Value.absent(),
                Value<String> status = const Value.absent(),
                Value<DateTime?> startDate = const Value.absent(),
                Value<DateTime?> endDate = const Value.absent(),
                Value<String?> objective = const Value.absent(),
                Value<double> budget = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
              }) => CampaignsCompanion(
                id: id,
                title: title,
                description: description,
                campaignType: campaignType,
                status: status,
                startDate: startDate,
                endDate: endDate,
                objective: objective,
                budget: budget,
                createdAt: createdAt,
                updatedAt: updatedAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String title,
                Value<String?> description = const Value.absent(),
                required String campaignType,
                Value<String> status = const Value.absent(),
                Value<DateTime?> startDate = const Value.absent(),
                Value<DateTime?> endDate = const Value.absent(),
                Value<String?> objective = const Value.absent(),
                Value<double> budget = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
              }) => CampaignsCompanion.insert(
                id: id,
                title: title,
                description: description,
                campaignType: campaignType,
                status: status,
                startDate: startDate,
                endDate: endDate,
                objective: objective,
                budget: budget,
                createdAt: createdAt,
                updatedAt: updatedAt,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$CampaignsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $CampaignsTable,
      Campaign,
      $$CampaignsTableFilterComposer,
      $$CampaignsTableOrderingComposer,
      $$CampaignsTableAnnotationComposer,
      $$CampaignsTableCreateCompanionBuilder,
      $$CampaignsTableUpdateCompanionBuilder,
      (Campaign, BaseReferences<_$AppDatabase, $CampaignsTable, Campaign>),
      Campaign,
      PrefetchHooks Function()
    >;
typedef $$TasksTableCreateCompanionBuilder =
    TasksCompanion Function({
      required String id,
      required String title,
      Value<String?> description,
      Value<String> status,
      Value<String> priority,
      Value<DateTime?> startAt,
      Value<DateTime?> dueAt,
      Value<String?> location,
      Value<String> syncStatus,
      Value<int> progressPercentage,
      Value<int?> campaignId,
      Value<int?> clientId,
      Value<int?> assigneeId,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<int> rowid,
    });
typedef $$TasksTableUpdateCompanionBuilder =
    TasksCompanion Function({
      Value<String> id,
      Value<String> title,
      Value<String?> description,
      Value<String> status,
      Value<String> priority,
      Value<DateTime?> startAt,
      Value<DateTime?> dueAt,
      Value<String?> location,
      Value<String> syncStatus,
      Value<int> progressPercentage,
      Value<int?> campaignId,
      Value<int?> clientId,
      Value<int?> assigneeId,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<int> rowid,
    });

final class $$TasksTableReferences
    extends BaseReferences<_$AppDatabase, $TasksTable, Task> {
  $$TasksTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$SubTasksTable, List<SubTask>> _subTasksRefsTable(
    _$AppDatabase db,
  ) => MultiTypedResultKey.fromTable(
    db.subTasks,
    aliasName: $_aliasNameGenerator(db.tasks.id, db.subTasks.taskId),
  );

  $$SubTasksTableProcessedTableManager get subTasksRefs {
    final manager = $$SubTasksTableTableManager(
      $_db,
      $_db.subTasks,
    ).filter((f) => f.taskId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_subTasksRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$TasksTableFilterComposer extends Composer<_$AppDatabase, $TasksTable> {
  $$TasksTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get priority => $composableBuilder(
    column: $table.priority,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get startAt => $composableBuilder(
    column: $table.startAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get dueAt => $composableBuilder(
    column: $table.dueAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get location => $composableBuilder(
    column: $table.location,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get syncStatus => $composableBuilder(
    column: $table.syncStatus,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get progressPercentage => $composableBuilder(
    column: $table.progressPercentage,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get campaignId => $composableBuilder(
    column: $table.campaignId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get clientId => $composableBuilder(
    column: $table.clientId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get assigneeId => $composableBuilder(
    column: $table.assigneeId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> subTasksRefs(
    Expression<bool> Function($$SubTasksTableFilterComposer f) f,
  ) {
    final $$SubTasksTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.subTasks,
      getReferencedColumn: (t) => t.taskId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SubTasksTableFilterComposer(
            $db: $db,
            $table: $db.subTasks,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$TasksTableOrderingComposer
    extends Composer<_$AppDatabase, $TasksTable> {
  $$TasksTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get priority => $composableBuilder(
    column: $table.priority,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get startAt => $composableBuilder(
    column: $table.startAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get dueAt => $composableBuilder(
    column: $table.dueAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get location => $composableBuilder(
    column: $table.location,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get syncStatus => $composableBuilder(
    column: $table.syncStatus,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get progressPercentage => $composableBuilder(
    column: $table.progressPercentage,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get campaignId => $composableBuilder(
    column: $table.campaignId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get clientId => $composableBuilder(
    column: $table.clientId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get assigneeId => $composableBuilder(
    column: $table.assigneeId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$TasksTableAnnotationComposer
    extends Composer<_$AppDatabase, $TasksTable> {
  $$TasksTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => column,
  );

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<String> get priority =>
      $composableBuilder(column: $table.priority, builder: (column) => column);

  GeneratedColumn<DateTime> get startAt =>
      $composableBuilder(column: $table.startAt, builder: (column) => column);

  GeneratedColumn<DateTime> get dueAt =>
      $composableBuilder(column: $table.dueAt, builder: (column) => column);

  GeneratedColumn<String> get location =>
      $composableBuilder(column: $table.location, builder: (column) => column);

  GeneratedColumn<String> get syncStatus => $composableBuilder(
    column: $table.syncStatus,
    builder: (column) => column,
  );

  GeneratedColumn<int> get progressPercentage => $composableBuilder(
    column: $table.progressPercentage,
    builder: (column) => column,
  );

  GeneratedColumn<int> get campaignId => $composableBuilder(
    column: $table.campaignId,
    builder: (column) => column,
  );

  GeneratedColumn<int> get clientId =>
      $composableBuilder(column: $table.clientId, builder: (column) => column);

  GeneratedColumn<int> get assigneeId => $composableBuilder(
    column: $table.assigneeId,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  Expression<T> subTasksRefs<T extends Object>(
    Expression<T> Function($$SubTasksTableAnnotationComposer a) f,
  ) {
    final $$SubTasksTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.subTasks,
      getReferencedColumn: (t) => t.taskId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SubTasksTableAnnotationComposer(
            $db: $db,
            $table: $db.subTasks,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$TasksTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $TasksTable,
          Task,
          $$TasksTableFilterComposer,
          $$TasksTableOrderingComposer,
          $$TasksTableAnnotationComposer,
          $$TasksTableCreateCompanionBuilder,
          $$TasksTableUpdateCompanionBuilder,
          (Task, $$TasksTableReferences),
          Task,
          PrefetchHooks Function({bool subTasksRefs})
        > {
  $$TasksTableTableManager(_$AppDatabase db, $TasksTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$TasksTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$TasksTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$TasksTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> title = const Value.absent(),
                Value<String?> description = const Value.absent(),
                Value<String> status = const Value.absent(),
                Value<String> priority = const Value.absent(),
                Value<DateTime?> startAt = const Value.absent(),
                Value<DateTime?> dueAt = const Value.absent(),
                Value<String?> location = const Value.absent(),
                Value<String> syncStatus = const Value.absent(),
                Value<int> progressPercentage = const Value.absent(),
                Value<int?> campaignId = const Value.absent(),
                Value<int?> clientId = const Value.absent(),
                Value<int?> assigneeId = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => TasksCompanion(
                id: id,
                title: title,
                description: description,
                status: status,
                priority: priority,
                startAt: startAt,
                dueAt: dueAt,
                location: location,
                syncStatus: syncStatus,
                progressPercentage: progressPercentage,
                campaignId: campaignId,
                clientId: clientId,
                assigneeId: assigneeId,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String title,
                Value<String?> description = const Value.absent(),
                Value<String> status = const Value.absent(),
                Value<String> priority = const Value.absent(),
                Value<DateTime?> startAt = const Value.absent(),
                Value<DateTime?> dueAt = const Value.absent(),
                Value<String?> location = const Value.absent(),
                Value<String> syncStatus = const Value.absent(),
                Value<int> progressPercentage = const Value.absent(),
                Value<int?> campaignId = const Value.absent(),
                Value<int?> clientId = const Value.absent(),
                Value<int?> assigneeId = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => TasksCompanion.insert(
                id: id,
                title: title,
                description: description,
                status: status,
                priority: priority,
                startAt: startAt,
                dueAt: dueAt,
                location: location,
                syncStatus: syncStatus,
                progressPercentage: progressPercentage,
                campaignId: campaignId,
                clientId: clientId,
                assigneeId: assigneeId,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) =>
                    (e.readTable(table), $$TasksTableReferences(db, table, e)),
              )
              .toList(),
          prefetchHooksCallback: ({subTasksRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [if (subTasksRefs) db.subTasks],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (subTasksRefs)
                    await $_getPrefetchedData<Task, $TasksTable, SubTask>(
                      currentTable: table,
                      referencedTable: $$TasksTableReferences
                          ._subTasksRefsTable(db),
                      managerFromTypedResult: (p0) =>
                          $$TasksTableReferences(db, table, p0).subTasksRefs,
                      referencedItemsForCurrentItem: (item, referencedItems) =>
                          referencedItems.where((e) => e.taskId == item.id),
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$TasksTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $TasksTable,
      Task,
      $$TasksTableFilterComposer,
      $$TasksTableOrderingComposer,
      $$TasksTableAnnotationComposer,
      $$TasksTableCreateCompanionBuilder,
      $$TasksTableUpdateCompanionBuilder,
      (Task, $$TasksTableReferences),
      Task,
      PrefetchHooks Function({bool subTasksRefs})
    >;
typedef $$FieldReportsTableCreateCompanionBuilder =
    FieldReportsCompanion Function({
      required String id,
      Value<String?> notes,
      Value<List<String>?> photos,
      Value<String?> location,
      Value<String> syncStatus,
      Value<String?> taskId,
      Value<int?> reporterId,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<int> rowid,
    });
typedef $$FieldReportsTableUpdateCompanionBuilder =
    FieldReportsCompanion Function({
      Value<String> id,
      Value<String?> notes,
      Value<List<String>?> photos,
      Value<String?> location,
      Value<String> syncStatus,
      Value<String?> taskId,
      Value<int?> reporterId,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<int> rowid,
    });

class $$FieldReportsTableFilterComposer
    extends Composer<_$AppDatabase, $FieldReportsTable> {
  $$FieldReportsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<List<String>?, List<String>, String>
  get photos => $composableBuilder(
    column: $table.photos,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );

  ColumnFilters<String> get location => $composableBuilder(
    column: $table.location,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get syncStatus => $composableBuilder(
    column: $table.syncStatus,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get taskId => $composableBuilder(
    column: $table.taskId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get reporterId => $composableBuilder(
    column: $table.reporterId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$FieldReportsTableOrderingComposer
    extends Composer<_$AppDatabase, $FieldReportsTable> {
  $$FieldReportsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get photos => $composableBuilder(
    column: $table.photos,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get location => $composableBuilder(
    column: $table.location,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get syncStatus => $composableBuilder(
    column: $table.syncStatus,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get taskId => $composableBuilder(
    column: $table.taskId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get reporterId => $composableBuilder(
    column: $table.reporterId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$FieldReportsTableAnnotationComposer
    extends Composer<_$AppDatabase, $FieldReportsTable> {
  $$FieldReportsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);

  GeneratedColumnWithTypeConverter<List<String>?, String> get photos =>
      $composableBuilder(column: $table.photos, builder: (column) => column);

  GeneratedColumn<String> get location =>
      $composableBuilder(column: $table.location, builder: (column) => column);

  GeneratedColumn<String> get syncStatus => $composableBuilder(
    column: $table.syncStatus,
    builder: (column) => column,
  );

  GeneratedColumn<String> get taskId =>
      $composableBuilder(column: $table.taskId, builder: (column) => column);

  GeneratedColumn<int> get reporterId => $composableBuilder(
    column: $table.reporterId,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$FieldReportsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $FieldReportsTable,
          FieldReport,
          $$FieldReportsTableFilterComposer,
          $$FieldReportsTableOrderingComposer,
          $$FieldReportsTableAnnotationComposer,
          $$FieldReportsTableCreateCompanionBuilder,
          $$FieldReportsTableUpdateCompanionBuilder,
          (
            FieldReport,
            BaseReferences<_$AppDatabase, $FieldReportsTable, FieldReport>,
          ),
          FieldReport,
          PrefetchHooks Function()
        > {
  $$FieldReportsTableTableManager(_$AppDatabase db, $FieldReportsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$FieldReportsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$FieldReportsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$FieldReportsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                Value<List<String>?> photos = const Value.absent(),
                Value<String?> location = const Value.absent(),
                Value<String> syncStatus = const Value.absent(),
                Value<String?> taskId = const Value.absent(),
                Value<int?> reporterId = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => FieldReportsCompanion(
                id: id,
                notes: notes,
                photos: photos,
                location: location,
                syncStatus: syncStatus,
                taskId: taskId,
                reporterId: reporterId,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                Value<String?> notes = const Value.absent(),
                Value<List<String>?> photos = const Value.absent(),
                Value<String?> location = const Value.absent(),
                Value<String> syncStatus = const Value.absent(),
                Value<String?> taskId = const Value.absent(),
                Value<int?> reporterId = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => FieldReportsCompanion.insert(
                id: id,
                notes: notes,
                photos: photos,
                location: location,
                syncStatus: syncStatus,
                taskId: taskId,
                reporterId: reporterId,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$FieldReportsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $FieldReportsTable,
      FieldReport,
      $$FieldReportsTableFilterComposer,
      $$FieldReportsTableOrderingComposer,
      $$FieldReportsTableAnnotationComposer,
      $$FieldReportsTableCreateCompanionBuilder,
      $$FieldReportsTableUpdateCompanionBuilder,
      (
        FieldReport,
        BaseReferences<_$AppDatabase, $FieldReportsTable, FieldReport>,
      ),
      FieldReport,
      PrefetchHooks Function()
    >;
typedef $$AdAssetsTableCreateCompanionBuilder =
    AdAssetsCompanion Function({
      Value<int> id,
      Value<String?> assetCode,
      required String name,
      Value<String?> type,
      Value<String> status,
      Value<int> quantity,
      Value<int> usedQuantity,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
    });
typedef $$AdAssetsTableUpdateCompanionBuilder =
    AdAssetsCompanion Function({
      Value<int> id,
      Value<String?> assetCode,
      Value<String> name,
      Value<String?> type,
      Value<String> status,
      Value<int> quantity,
      Value<int> usedQuantity,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
    });

class $$AdAssetsTableFilterComposer
    extends Composer<_$AppDatabase, $AdAssetsTable> {
  $$AdAssetsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get assetCode => $composableBuilder(
    column: $table.assetCode,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get type => $composableBuilder(
    column: $table.type,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get quantity => $composableBuilder(
    column: $table.quantity,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get usedQuantity => $composableBuilder(
    column: $table.usedQuantity,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$AdAssetsTableOrderingComposer
    extends Composer<_$AppDatabase, $AdAssetsTable> {
  $$AdAssetsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get assetCode => $composableBuilder(
    column: $table.assetCode,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get type => $composableBuilder(
    column: $table.type,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get quantity => $composableBuilder(
    column: $table.quantity,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get usedQuantity => $composableBuilder(
    column: $table.usedQuantity,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$AdAssetsTableAnnotationComposer
    extends Composer<_$AppDatabase, $AdAssetsTable> {
  $$AdAssetsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get assetCode =>
      $composableBuilder(column: $table.assetCode, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get type =>
      $composableBuilder(column: $table.type, builder: (column) => column);

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<int> get quantity =>
      $composableBuilder(column: $table.quantity, builder: (column) => column);

  GeneratedColumn<int> get usedQuantity => $composableBuilder(
    column: $table.usedQuantity,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$AdAssetsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $AdAssetsTable,
          AdAsset,
          $$AdAssetsTableFilterComposer,
          $$AdAssetsTableOrderingComposer,
          $$AdAssetsTableAnnotationComposer,
          $$AdAssetsTableCreateCompanionBuilder,
          $$AdAssetsTableUpdateCompanionBuilder,
          (AdAsset, BaseReferences<_$AppDatabase, $AdAssetsTable, AdAsset>),
          AdAsset,
          PrefetchHooks Function()
        > {
  $$AdAssetsTableTableManager(_$AppDatabase db, $AdAssetsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$AdAssetsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$AdAssetsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$AdAssetsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String?> assetCode = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String?> type = const Value.absent(),
                Value<String> status = const Value.absent(),
                Value<int> quantity = const Value.absent(),
                Value<int> usedQuantity = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
              }) => AdAssetsCompanion(
                id: id,
                assetCode: assetCode,
                name: name,
                type: type,
                status: status,
                quantity: quantity,
                usedQuantity: usedQuantity,
                createdAt: createdAt,
                updatedAt: updatedAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String?> assetCode = const Value.absent(),
                required String name,
                Value<String?> type = const Value.absent(),
                Value<String> status = const Value.absent(),
                Value<int> quantity = const Value.absent(),
                Value<int> usedQuantity = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
              }) => AdAssetsCompanion.insert(
                id: id,
                assetCode: assetCode,
                name: name,
                type: type,
                status: status,
                quantity: quantity,
                usedQuantity: usedQuantity,
                createdAt: createdAt,
                updatedAt: updatedAt,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$AdAssetsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $AdAssetsTable,
      AdAsset,
      $$AdAssetsTableFilterComposer,
      $$AdAssetsTableOrderingComposer,
      $$AdAssetsTableAnnotationComposer,
      $$AdAssetsTableCreateCompanionBuilder,
      $$AdAssetsTableUpdateCompanionBuilder,
      (AdAsset, BaseReferences<_$AppDatabase, $AdAssetsTable, AdAsset>),
      AdAsset,
      PrefetchHooks Function()
    >;
typedef $$SyncQueueTableCreateCompanionBuilder =
    SyncQueueCompanion Function({
      required String id,
      required String entity,
      required String operation,
      Value<String?> payload,
      Value<String> status,
      Value<int> retryCount,
      Value<DateTime> createdAt,
      Value<int> rowid,
    });
typedef $$SyncQueueTableUpdateCompanionBuilder =
    SyncQueueCompanion Function({
      Value<String> id,
      Value<String> entity,
      Value<String> operation,
      Value<String?> payload,
      Value<String> status,
      Value<int> retryCount,
      Value<DateTime> createdAt,
      Value<int> rowid,
    });

class $$SyncQueueTableFilterComposer
    extends Composer<_$AppDatabase, $SyncQueueTable> {
  $$SyncQueueTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get entity => $composableBuilder(
    column: $table.entity,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get operation => $composableBuilder(
    column: $table.operation,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get payload => $composableBuilder(
    column: $table.payload,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get retryCount => $composableBuilder(
    column: $table.retryCount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$SyncQueueTableOrderingComposer
    extends Composer<_$AppDatabase, $SyncQueueTable> {
  $$SyncQueueTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get entity => $composableBuilder(
    column: $table.entity,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get operation => $composableBuilder(
    column: $table.operation,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get payload => $composableBuilder(
    column: $table.payload,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get retryCount => $composableBuilder(
    column: $table.retryCount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$SyncQueueTableAnnotationComposer
    extends Composer<_$AppDatabase, $SyncQueueTable> {
  $$SyncQueueTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get entity =>
      $composableBuilder(column: $table.entity, builder: (column) => column);

  GeneratedColumn<String> get operation =>
      $composableBuilder(column: $table.operation, builder: (column) => column);

  GeneratedColumn<String> get payload =>
      $composableBuilder(column: $table.payload, builder: (column) => column);

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<int> get retryCount => $composableBuilder(
    column: $table.retryCount,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);
}

class $$SyncQueueTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $SyncQueueTable,
          SyncQueueData,
          $$SyncQueueTableFilterComposer,
          $$SyncQueueTableOrderingComposer,
          $$SyncQueueTableAnnotationComposer,
          $$SyncQueueTableCreateCompanionBuilder,
          $$SyncQueueTableUpdateCompanionBuilder,
          (
            SyncQueueData,
            BaseReferences<_$AppDatabase, $SyncQueueTable, SyncQueueData>,
          ),
          SyncQueueData,
          PrefetchHooks Function()
        > {
  $$SyncQueueTableTableManager(_$AppDatabase db, $SyncQueueTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SyncQueueTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SyncQueueTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SyncQueueTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> entity = const Value.absent(),
                Value<String> operation = const Value.absent(),
                Value<String?> payload = const Value.absent(),
                Value<String> status = const Value.absent(),
                Value<int> retryCount = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => SyncQueueCompanion(
                id: id,
                entity: entity,
                operation: operation,
                payload: payload,
                status: status,
                retryCount: retryCount,
                createdAt: createdAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String entity,
                required String operation,
                Value<String?> payload = const Value.absent(),
                Value<String> status = const Value.absent(),
                Value<int> retryCount = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => SyncQueueCompanion.insert(
                id: id,
                entity: entity,
                operation: operation,
                payload: payload,
                status: status,
                retryCount: retryCount,
                createdAt: createdAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$SyncQueueTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $SyncQueueTable,
      SyncQueueData,
      $$SyncQueueTableFilterComposer,
      $$SyncQueueTableOrderingComposer,
      $$SyncQueueTableAnnotationComposer,
      $$SyncQueueTableCreateCompanionBuilder,
      $$SyncQueueTableUpdateCompanionBuilder,
      (
        SyncQueueData,
        BaseReferences<_$AppDatabase, $SyncQueueTable, SyncQueueData>,
      ),
      SyncQueueData,
      PrefetchHooks Function()
    >;
typedef $$ClientEmployeesTableCreateCompanionBuilder =
    ClientEmployeesCompanion Function({
      Value<int> id,
      Value<int?> remoteId,
      required int clientId,
      Value<int?> previousClientId,
      required String name,
      Value<String?> phone,
      Value<String?> role,
      Value<bool> isDecisionMaker,
      Value<String?> notes,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
    });
typedef $$ClientEmployeesTableUpdateCompanionBuilder =
    ClientEmployeesCompanion Function({
      Value<int> id,
      Value<int?> remoteId,
      Value<int> clientId,
      Value<int?> previousClientId,
      Value<String> name,
      Value<String?> phone,
      Value<String?> role,
      Value<bool> isDecisionMaker,
      Value<String?> notes,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
    });

class $$ClientEmployeesTableFilterComposer
    extends Composer<_$AppDatabase, $ClientEmployeesTable> {
  $$ClientEmployeesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get remoteId => $composableBuilder(
    column: $table.remoteId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get clientId => $composableBuilder(
    column: $table.clientId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get previousClientId => $composableBuilder(
    column: $table.previousClientId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get phone => $composableBuilder(
    column: $table.phone,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get role => $composableBuilder(
    column: $table.role,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isDecisionMaker => $composableBuilder(
    column: $table.isDecisionMaker,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$ClientEmployeesTableOrderingComposer
    extends Composer<_$AppDatabase, $ClientEmployeesTable> {
  $$ClientEmployeesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get remoteId => $composableBuilder(
    column: $table.remoteId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get clientId => $composableBuilder(
    column: $table.clientId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get previousClientId => $composableBuilder(
    column: $table.previousClientId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get phone => $composableBuilder(
    column: $table.phone,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get role => $composableBuilder(
    column: $table.role,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isDecisionMaker => $composableBuilder(
    column: $table.isDecisionMaker,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$ClientEmployeesTableAnnotationComposer
    extends Composer<_$AppDatabase, $ClientEmployeesTable> {
  $$ClientEmployeesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get remoteId =>
      $composableBuilder(column: $table.remoteId, builder: (column) => column);

  GeneratedColumn<int> get clientId =>
      $composableBuilder(column: $table.clientId, builder: (column) => column);

  GeneratedColumn<int> get previousClientId => $composableBuilder(
    column: $table.previousClientId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get phone =>
      $composableBuilder(column: $table.phone, builder: (column) => column);

  GeneratedColumn<String> get role =>
      $composableBuilder(column: $table.role, builder: (column) => column);

  GeneratedColumn<bool> get isDecisionMaker => $composableBuilder(
    column: $table.isDecisionMaker,
    builder: (column) => column,
  );

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$ClientEmployeesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ClientEmployeesTable,
          ClientEmployee,
          $$ClientEmployeesTableFilterComposer,
          $$ClientEmployeesTableOrderingComposer,
          $$ClientEmployeesTableAnnotationComposer,
          $$ClientEmployeesTableCreateCompanionBuilder,
          $$ClientEmployeesTableUpdateCompanionBuilder,
          (
            ClientEmployee,
            BaseReferences<
              _$AppDatabase,
              $ClientEmployeesTable,
              ClientEmployee
            >,
          ),
          ClientEmployee,
          PrefetchHooks Function()
        > {
  $$ClientEmployeesTableTableManager(
    _$AppDatabase db,
    $ClientEmployeesTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ClientEmployeesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ClientEmployeesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ClientEmployeesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int?> remoteId = const Value.absent(),
                Value<int> clientId = const Value.absent(),
                Value<int?> previousClientId = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String?> phone = const Value.absent(),
                Value<String?> role = const Value.absent(),
                Value<bool> isDecisionMaker = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
              }) => ClientEmployeesCompanion(
                id: id,
                remoteId: remoteId,
                clientId: clientId,
                previousClientId: previousClientId,
                name: name,
                phone: phone,
                role: role,
                isDecisionMaker: isDecisionMaker,
                notes: notes,
                createdAt: createdAt,
                updatedAt: updatedAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int?> remoteId = const Value.absent(),
                required int clientId,
                Value<int?> previousClientId = const Value.absent(),
                required String name,
                Value<String?> phone = const Value.absent(),
                Value<String?> role = const Value.absent(),
                Value<bool> isDecisionMaker = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
              }) => ClientEmployeesCompanion.insert(
                id: id,
                remoteId: remoteId,
                clientId: clientId,
                previousClientId: previousClientId,
                name: name,
                phone: phone,
                role: role,
                isDecisionMaker: isDecisionMaker,
                notes: notes,
                createdAt: createdAt,
                updatedAt: updatedAt,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$ClientEmployeesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ClientEmployeesTable,
      ClientEmployee,
      $$ClientEmployeesTableFilterComposer,
      $$ClientEmployeesTableOrderingComposer,
      $$ClientEmployeesTableAnnotationComposer,
      $$ClientEmployeesTableCreateCompanionBuilder,
      $$ClientEmployeesTableUpdateCompanionBuilder,
      (
        ClientEmployee,
        BaseReferences<_$AppDatabase, $ClientEmployeesTable, ClientEmployee>,
      ),
      ClientEmployee,
      PrefetchHooks Function()
    >;
typedef $$BranchesTableCreateCompanionBuilder =
    BranchesCompanion Function({
      Value<int> id,
      Value<int?> remoteId,
      required String name,
      Value<String?> address,
      Value<String?> phone,
      Value<String?> managerName,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
    });
typedef $$BranchesTableUpdateCompanionBuilder =
    BranchesCompanion Function({
      Value<int> id,
      Value<int?> remoteId,
      Value<String> name,
      Value<String?> address,
      Value<String?> phone,
      Value<String?> managerName,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
    });

class $$BranchesTableFilterComposer
    extends Composer<_$AppDatabase, $BranchesTable> {
  $$BranchesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get remoteId => $composableBuilder(
    column: $table.remoteId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get address => $composableBuilder(
    column: $table.address,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get phone => $composableBuilder(
    column: $table.phone,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get managerName => $composableBuilder(
    column: $table.managerName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$BranchesTableOrderingComposer
    extends Composer<_$AppDatabase, $BranchesTable> {
  $$BranchesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get remoteId => $composableBuilder(
    column: $table.remoteId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get address => $composableBuilder(
    column: $table.address,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get phone => $composableBuilder(
    column: $table.phone,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get managerName => $composableBuilder(
    column: $table.managerName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$BranchesTableAnnotationComposer
    extends Composer<_$AppDatabase, $BranchesTable> {
  $$BranchesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get remoteId =>
      $composableBuilder(column: $table.remoteId, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get address =>
      $composableBuilder(column: $table.address, builder: (column) => column);

  GeneratedColumn<String> get phone =>
      $composableBuilder(column: $table.phone, builder: (column) => column);

  GeneratedColumn<String> get managerName => $composableBuilder(
    column: $table.managerName,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$BranchesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $BranchesTable,
          Branch,
          $$BranchesTableFilterComposer,
          $$BranchesTableOrderingComposer,
          $$BranchesTableAnnotationComposer,
          $$BranchesTableCreateCompanionBuilder,
          $$BranchesTableUpdateCompanionBuilder,
          (Branch, BaseReferences<_$AppDatabase, $BranchesTable, Branch>),
          Branch,
          PrefetchHooks Function()
        > {
  $$BranchesTableTableManager(_$AppDatabase db, $BranchesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$BranchesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$BranchesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$BranchesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int?> remoteId = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String?> address = const Value.absent(),
                Value<String?> phone = const Value.absent(),
                Value<String?> managerName = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
              }) => BranchesCompanion(
                id: id,
                remoteId: remoteId,
                name: name,
                address: address,
                phone: phone,
                managerName: managerName,
                createdAt: createdAt,
                updatedAt: updatedAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int?> remoteId = const Value.absent(),
                required String name,
                Value<String?> address = const Value.absent(),
                Value<String?> phone = const Value.absent(),
                Value<String?> managerName = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
              }) => BranchesCompanion.insert(
                id: id,
                remoteId: remoteId,
                name: name,
                address: address,
                phone: phone,
                managerName: managerName,
                createdAt: createdAt,
                updatedAt: updatedAt,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$BranchesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $BranchesTable,
      Branch,
      $$BranchesTableFilterComposer,
      $$BranchesTableOrderingComposer,
      $$BranchesTableAnnotationComposer,
      $$BranchesTableCreateCompanionBuilder,
      $$BranchesTableUpdateCompanionBuilder,
      (Branch, BaseReferences<_$AppDatabase, $BranchesTable, Branch>),
      Branch,
      PrefetchHooks Function()
    >;
typedef $$CitiesTableCreateCompanionBuilder =
    CitiesCompanion Function({
      Value<int> id,
      Value<int?> remoteId,
      required String name,
      Value<String?> governorate,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
    });
typedef $$CitiesTableUpdateCompanionBuilder =
    CitiesCompanion Function({
      Value<int> id,
      Value<int?> remoteId,
      Value<String> name,
      Value<String?> governorate,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
    });

class $$CitiesTableFilterComposer
    extends Composer<_$AppDatabase, $CitiesTable> {
  $$CitiesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get remoteId => $composableBuilder(
    column: $table.remoteId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get governorate => $composableBuilder(
    column: $table.governorate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$CitiesTableOrderingComposer
    extends Composer<_$AppDatabase, $CitiesTable> {
  $$CitiesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get remoteId => $composableBuilder(
    column: $table.remoteId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get governorate => $composableBuilder(
    column: $table.governorate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$CitiesTableAnnotationComposer
    extends Composer<_$AppDatabase, $CitiesTable> {
  $$CitiesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get remoteId =>
      $composableBuilder(column: $table.remoteId, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get governorate => $composableBuilder(
    column: $table.governorate,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$CitiesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $CitiesTable,
          City,
          $$CitiesTableFilterComposer,
          $$CitiesTableOrderingComposer,
          $$CitiesTableAnnotationComposer,
          $$CitiesTableCreateCompanionBuilder,
          $$CitiesTableUpdateCompanionBuilder,
          (City, BaseReferences<_$AppDatabase, $CitiesTable, City>),
          City,
          PrefetchHooks Function()
        > {
  $$CitiesTableTableManager(_$AppDatabase db, $CitiesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$CitiesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$CitiesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$CitiesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int?> remoteId = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String?> governorate = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
              }) => CitiesCompanion(
                id: id,
                remoteId: remoteId,
                name: name,
                governorate: governorate,
                createdAt: createdAt,
                updatedAt: updatedAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int?> remoteId = const Value.absent(),
                required String name,
                Value<String?> governorate = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
              }) => CitiesCompanion.insert(
                id: id,
                remoteId: remoteId,
                name: name,
                governorate: governorate,
                createdAt: createdAt,
                updatedAt: updatedAt,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$CitiesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $CitiesTable,
      City,
      $$CitiesTableFilterComposer,
      $$CitiesTableOrderingComposer,
      $$CitiesTableAnnotationComposer,
      $$CitiesTableCreateCompanionBuilder,
      $$CitiesTableUpdateCompanionBuilder,
      (City, BaseReferences<_$AppDatabase, $CitiesTable, City>),
      City,
      PrefetchHooks Function()
    >;
typedef $$ClassificationsTableCreateCompanionBuilder =
    ClassificationsCompanion Function({
      Value<int> id,
      Value<int?> remoteId,
      required String name,
      Value<String?> type,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
    });
typedef $$ClassificationsTableUpdateCompanionBuilder =
    ClassificationsCompanion Function({
      Value<int> id,
      Value<int?> remoteId,
      Value<String> name,
      Value<String?> type,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
    });

class $$ClassificationsTableFilterComposer
    extends Composer<_$AppDatabase, $ClassificationsTable> {
  $$ClassificationsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get remoteId => $composableBuilder(
    column: $table.remoteId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get type => $composableBuilder(
    column: $table.type,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$ClassificationsTableOrderingComposer
    extends Composer<_$AppDatabase, $ClassificationsTable> {
  $$ClassificationsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get remoteId => $composableBuilder(
    column: $table.remoteId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get type => $composableBuilder(
    column: $table.type,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$ClassificationsTableAnnotationComposer
    extends Composer<_$AppDatabase, $ClassificationsTable> {
  $$ClassificationsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get remoteId =>
      $composableBuilder(column: $table.remoteId, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get type =>
      $composableBuilder(column: $table.type, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$ClassificationsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ClassificationsTable,
          Classification,
          $$ClassificationsTableFilterComposer,
          $$ClassificationsTableOrderingComposer,
          $$ClassificationsTableAnnotationComposer,
          $$ClassificationsTableCreateCompanionBuilder,
          $$ClassificationsTableUpdateCompanionBuilder,
          (
            Classification,
            BaseReferences<
              _$AppDatabase,
              $ClassificationsTable,
              Classification
            >,
          ),
          Classification,
          PrefetchHooks Function()
        > {
  $$ClassificationsTableTableManager(
    _$AppDatabase db,
    $ClassificationsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ClassificationsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ClassificationsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ClassificationsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int?> remoteId = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String?> type = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
              }) => ClassificationsCompanion(
                id: id,
                remoteId: remoteId,
                name: name,
                type: type,
                createdAt: createdAt,
                updatedAt: updatedAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int?> remoteId = const Value.absent(),
                required String name,
                Value<String?> type = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
              }) => ClassificationsCompanion.insert(
                id: id,
                remoteId: remoteId,
                name: name,
                type: type,
                createdAt: createdAt,
                updatedAt: updatedAt,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$ClassificationsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ClassificationsTable,
      Classification,
      $$ClassificationsTableFilterComposer,
      $$ClassificationsTableOrderingComposer,
      $$ClassificationsTableAnnotationComposer,
      $$ClassificationsTableCreateCompanionBuilder,
      $$ClassificationsTableUpdateCompanionBuilder,
      (
        Classification,
        BaseReferences<_$AppDatabase, $ClassificationsTable, Classification>,
      ),
      Classification,
      PrefetchHooks Function()
    >;
typedef $$SubTasksTableCreateCompanionBuilder =
    SubTasksCompanion Function({
      Value<int> id,
      required String taskId,
      required String title,
      Value<bool> isCompleted,
      Value<DateTime> createdAt,
    });
typedef $$SubTasksTableUpdateCompanionBuilder =
    SubTasksCompanion Function({
      Value<int> id,
      Value<String> taskId,
      Value<String> title,
      Value<bool> isCompleted,
      Value<DateTime> createdAt,
    });

final class $$SubTasksTableReferences
    extends BaseReferences<_$AppDatabase, $SubTasksTable, SubTask> {
  $$SubTasksTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $TasksTable _taskIdTable(_$AppDatabase db) => db.tasks.createAlias(
    $_aliasNameGenerator(db.subTasks.taskId, db.tasks.id),
  );

  $$TasksTableProcessedTableManager get taskId {
    final $_column = $_itemColumn<String>('task_id')!;

    final manager = $$TasksTableTableManager(
      $_db,
      $_db.tasks,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_taskIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$SubTasksTableFilterComposer
    extends Composer<_$AppDatabase, $SubTasksTable> {
  $$SubTasksTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isCompleted => $composableBuilder(
    column: $table.isCompleted,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  $$TasksTableFilterComposer get taskId {
    final $$TasksTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.taskId,
      referencedTable: $db.tasks,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TasksTableFilterComposer(
            $db: $db,
            $table: $db.tasks,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$SubTasksTableOrderingComposer
    extends Composer<_$AppDatabase, $SubTasksTable> {
  $$SubTasksTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isCompleted => $composableBuilder(
    column: $table.isCompleted,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$TasksTableOrderingComposer get taskId {
    final $$TasksTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.taskId,
      referencedTable: $db.tasks,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TasksTableOrderingComposer(
            $db: $db,
            $table: $db.tasks,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$SubTasksTableAnnotationComposer
    extends Composer<_$AppDatabase, $SubTasksTable> {
  $$SubTasksTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<bool> get isCompleted => $composableBuilder(
    column: $table.isCompleted,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  $$TasksTableAnnotationComposer get taskId {
    final $$TasksTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.taskId,
      referencedTable: $db.tasks,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TasksTableAnnotationComposer(
            $db: $db,
            $table: $db.tasks,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$SubTasksTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $SubTasksTable,
          SubTask,
          $$SubTasksTableFilterComposer,
          $$SubTasksTableOrderingComposer,
          $$SubTasksTableAnnotationComposer,
          $$SubTasksTableCreateCompanionBuilder,
          $$SubTasksTableUpdateCompanionBuilder,
          (SubTask, $$SubTasksTableReferences),
          SubTask,
          PrefetchHooks Function({bool taskId})
        > {
  $$SubTasksTableTableManager(_$AppDatabase db, $SubTasksTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SubTasksTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SubTasksTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SubTasksTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> taskId = const Value.absent(),
                Value<String> title = const Value.absent(),
                Value<bool> isCompleted = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => SubTasksCompanion(
                id: id,
                taskId: taskId,
                title: title,
                isCompleted: isCompleted,
                createdAt: createdAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String taskId,
                required String title,
                Value<bool> isCompleted = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => SubTasksCompanion.insert(
                id: id,
                taskId: taskId,
                title: title,
                isCompleted: isCompleted,
                createdAt: createdAt,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$SubTasksTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({taskId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (taskId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.taskId,
                                referencedTable: $$SubTasksTableReferences
                                    ._taskIdTable(db),
                                referencedColumn: $$SubTasksTableReferences
                                    ._taskIdTable(db)
                                    .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$SubTasksTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $SubTasksTable,
      SubTask,
      $$SubTasksTableFilterComposer,
      $$SubTasksTableOrderingComposer,
      $$SubTasksTableAnnotationComposer,
      $$SubTasksTableCreateCompanionBuilder,
      $$SubTasksTableUpdateCompanionBuilder,
      (SubTask, $$SubTasksTableReferences),
      SubTask,
      PrefetchHooks Function({bool taskId})
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$ClientsTableTableManager get clients =>
      $$ClientsTableTableManager(_db, _db.clients);
  $$CampaignsTableTableManager get campaigns =>
      $$CampaignsTableTableManager(_db, _db.campaigns);
  $$TasksTableTableManager get tasks =>
      $$TasksTableTableManager(_db, _db.tasks);
  $$FieldReportsTableTableManager get fieldReports =>
      $$FieldReportsTableTableManager(_db, _db.fieldReports);
  $$AdAssetsTableTableManager get adAssets =>
      $$AdAssetsTableTableManager(_db, _db.adAssets);
  $$SyncQueueTableTableManager get syncQueue =>
      $$SyncQueueTableTableManager(_db, _db.syncQueue);
  $$ClientEmployeesTableTableManager get clientEmployees =>
      $$ClientEmployeesTableTableManager(_db, _db.clientEmployees);
  $$BranchesTableTableManager get branches =>
      $$BranchesTableTableManager(_db, _db.branches);
  $$CitiesTableTableManager get cities =>
      $$CitiesTableTableManager(_db, _db.cities);
  $$ClassificationsTableTableManager get classifications =>
      $$ClassificationsTableTableManager(_db, _db.classifications);
  $$SubTasksTableTableManager get subTasks =>
      $$SubTasksTableTableManager(_db, _db.subTasks);
}
