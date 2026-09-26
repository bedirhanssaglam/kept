/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: implementation_imports
// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: public_member_api_docs
// ignore_for_file: type_literal_in_constant_pattern
// ignore_for_file: use_super_parameters
// ignore_for_file: invalid_use_of_internal_member

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:serverpod/serverpod.dart' as _is;

/// A public or private vow room people can join.
abstract class VowRoom
    implements _is.TableRow<int?>, _is.ProtocolSerialization {
  VowRoom._({
    this.id,
    required this.title,
    required this.rule,
    required this.category,
    required this.isPublic,
    String? joinPolicy,
    bool? isOfficial,
    required this.creatorId,
    required this.memberCount,
    required this.createdAt,
  }) : joinPolicy = joinPolicy ?? 'open',
       isOfficial = isOfficial ?? false;

  factory VowRoom({
    int? id,
    required String title,
    required String rule,
    required String category,
    required bool isPublic,
    String? joinPolicy,
    bool? isOfficial,
    required String creatorId,
    required int memberCount,
    required DateTime createdAt,
  }) = _VowRoomImpl;

  factory VowRoom.fromJson(Map<String, dynamic> jsonSerialization) {
    return VowRoom(
      id: jsonSerialization['id'] as int?,
      title: jsonSerialization['title'] as String,
      rule: jsonSerialization['rule'] as String,
      category: jsonSerialization['category'] as String,
      isPublic: _is.BoolJsonExtension.fromJson(jsonSerialization['isPublic']),
      joinPolicy: jsonSerialization['joinPolicy'] as String?,
      isOfficial: jsonSerialization['isOfficial'] == null
          ? null
          : _is.BoolJsonExtension.fromJson(jsonSerialization['isOfficial']),
      creatorId: jsonSerialization['creatorId'] as String,
      memberCount: jsonSerialization['memberCount'] as int,
      createdAt: _is.DateTimeJsonExtension.fromJson(
        jsonSerialization['createdAt'],
      ),
    );
  }

  static final t = VowRoomTable();

  static const db = VowRoomRepository._();

  @override
  int? id;

  /// Short vow title, e.g. "Drink 1L of water".
  String title;

  /// What "kept" means today.
  String rule;

  /// Category slug: health | quit | move | focus | custom
  String category;

  /// Whether the room appears on Discover / Home stories.
  bool isPublic;

  /// open | approval | invite | closed
  String joinPolicy;

  /// Curated default vows (system).
  bool isOfficial;

  /// Auth user id of the creator / owner.
  String creatorId;

  /// Cached member count for Discover cards.
  int memberCount;

  /// UTC creation time.
  DateTime createdAt;

  @override
  _is.Table<int?> get table => t;

  /// Returns a shallow copy of this [VowRoom]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  VowRoom copyWith({
    int? id,
    String? title,
    String? rule,
    String? category,
    bool? isPublic,
    String? joinPolicy,
    bool? isOfficial,
    String? creatorId,
    int? memberCount,
    DateTime? createdAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'VowRoom',
      if (id != null) 'id': id,
      'title': title,
      'rule': rule,
      'category': category,
      'isPublic': isPublic,
      'joinPolicy': joinPolicy,
      'isOfficial': isOfficial,
      'creatorId': creatorId,
      'memberCount': memberCount,
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'VowRoom',
      if (id != null) 'id': id,
      'title': title,
      'rule': rule,
      'category': category,
      'isPublic': isPublic,
      'joinPolicy': joinPolicy,
      'isOfficial': isOfficial,
      'creatorId': creatorId,
      'memberCount': memberCount,
      'createdAt': createdAt.toJson(),
    };
  }

  static VowRoomInclude include() {
    return VowRoomInclude._();
  }

  static VowRoomIncludeList includeList({
    _is.WhereExpressionBuilder<VowRoomTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<VowRoomTable>? orderBy,
    _is.OrderByListBuilder<VowRoomTable>? orderByList,
    VowRoomInclude? include,
  }) {
    return VowRoomIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(VowRoom.t),
      orderByList: orderByList?.call(VowRoom.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _VowRoomImpl extends VowRoom {
  _VowRoomImpl({
    int? id,
    required String title,
    required String rule,
    required String category,
    required bool isPublic,
    String? joinPolicy,
    bool? isOfficial,
    required String creatorId,
    required int memberCount,
    required DateTime createdAt,
  }) : super._(
         id: id,
         title: title,
         rule: rule,
         category: category,
         isPublic: isPublic,
         joinPolicy: joinPolicy,
         isOfficial: isOfficial,
         creatorId: creatorId,
         memberCount: memberCount,
         createdAt: createdAt,
       );

  /// Returns a shallow copy of this [VowRoom]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  VowRoom copyWith({
    Object? id = _Undefined,
    String? title,
    String? rule,
    String? category,
    bool? isPublic,
    String? joinPolicy,
    bool? isOfficial,
    String? creatorId,
    int? memberCount,
    DateTime? createdAt,
  }) {
    return VowRoom(
      id: id is int? ? id : this.id,
      title: title ?? this.title,
      rule: rule ?? this.rule,
      category: category ?? this.category,
      isPublic: isPublic ?? this.isPublic,
      joinPolicy: joinPolicy ?? this.joinPolicy,
      isOfficial: isOfficial ?? this.isOfficial,
      creatorId: creatorId ?? this.creatorId,
      memberCount: memberCount ?? this.memberCount,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}

class VowRoomUpdateTable extends _is.UpdateTable<VowRoomTable> {
  VowRoomUpdateTable(super.table);

  _is.ColumnValue<String, String> title(String value) => _is.ColumnValue(
    table.title,
    value,
  );

  _is.ColumnValue<String, String> rule(String value) => _is.ColumnValue(
    table.rule,
    value,
  );

  _is.ColumnValue<String, String> category(String value) => _is.ColumnValue(
    table.category,
    value,
  );

  _is.ColumnValue<bool, bool> isPublic(bool value) => _is.ColumnValue(
    table.isPublic,
    value,
  );

  _is.ColumnValue<String, String> joinPolicy(String value) => _is.ColumnValue(
    table.joinPolicy,
    value,
  );

  _is.ColumnValue<bool, bool> isOfficial(bool value) => _is.ColumnValue(
    table.isOfficial,
    value,
  );

  _is.ColumnValue<String, String> creatorId(String value) => _is.ColumnValue(
    table.creatorId,
    value,
  );

  _is.ColumnValue<int, int> memberCount(int value) => _is.ColumnValue(
    table.memberCount,
    value,
  );

  _is.ColumnValue<DateTime, DateTime> createdAt(DateTime value) =>
      _is.ColumnValue(
        table.createdAt,
        value,
      );
}

class VowRoomTable extends _is.Table<int?> {
  VowRoomTable({super.tableRelation}) : super(tableName: 'vow_room') {
    updateTable = VowRoomUpdateTable(this);
    title = _is.ColumnString(
      'title',
      this,
    );
    rule = _is.ColumnString(
      'rule',
      this,
    );
    category = _is.ColumnString(
      'category',
      this,
    );
    isPublic = _is.ColumnBool(
      'isPublic',
      this,
    );
    joinPolicy = _is.ColumnString(
      'joinPolicy',
      this,
      hasDefault: true,
    );
    isOfficial = _is.ColumnBool(
      'isOfficial',
      this,
      hasDefault: true,
    );
    creatorId = _is.ColumnString(
      'creatorId',
      this,
    );
    memberCount = _is.ColumnInt(
      'memberCount',
      this,
    );
    createdAt = _is.ColumnDateTime(
      'createdAt',
      this,
    );
  }

  late final VowRoomUpdateTable updateTable;

  /// Short vow title, e.g. "Drink 1L of water".
  late final _is.ColumnString title;

  /// What "kept" means today.
  late final _is.ColumnString rule;

  /// Category slug: health | quit | move | focus | custom
  late final _is.ColumnString category;

  /// Whether the room appears on Discover / Home stories.
  late final _is.ColumnBool isPublic;

  /// open | approval | invite | closed
  late final _is.ColumnString joinPolicy;

  /// Curated default vows (system).
  late final _is.ColumnBool isOfficial;

  /// Auth user id of the creator / owner.
  late final _is.ColumnString creatorId;

  /// Cached member count for Discover cards.
  late final _is.ColumnInt memberCount;

  /// UTC creation time.
  late final _is.ColumnDateTime createdAt;

  @override
  List<_is.Column> get columns => [
    id,
    title,
    rule,
    category,
    isPublic,
    joinPolicy,
    isOfficial,
    creatorId,
    memberCount,
    createdAt,
  ];
}

class VowRoomInclude extends _is.IncludeObject {
  VowRoomInclude._();

  @override
  Map<String, _is.Include?> get includes => {};

  @override
  _is.Table<int?> get table => VowRoom.t;
}

class VowRoomIncludeList extends _is.IncludeList {
  VowRoomIncludeList._({
    _is.WhereExpressionBuilder<VowRoomTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(VowRoom.t);
  }

  @override
  Map<String, _is.Include?> get includes => include?.includes ?? {};

  @override
  _is.Table<int?> get table => VowRoom.t;
}

class VowRoomRepository {
  const VowRoomRepository._();

  /// Returns a list of [VowRoom]s matching the given query parameters.
  ///
  /// Use [where] to specify which items to include in the return value.
  /// If none is specified, all items will be returned.
  ///
  /// To specify the order of the items use [orderBy] or [orderByList]
  /// when sorting by multiple columns.
  ///
  /// The maximum number of items can be set by [limit]. If no limit is set,
  /// all items matching the query will be returned.
  ///
  /// [offset] defines how many items to skip, after which [limit] (or all)
  /// items are read from the database.
  ///
  /// ```dart
  /// var persons = await Persons.db.find(
  ///   session,
  ///   where: (t) => t.lastName.equals('Jones'),
  ///   orderBy: (t) => t.firstName,
  ///   limit: 100,
  /// );
  /// ```
  Future<List<VowRoom>> find(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<VowRoomTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<VowRoomTable>? orderBy,
    _is.OrderByListBuilder<VowRoomTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<VowRoom>(
      where: where?.call(VowRoom.t),
      orderBy: orderBy?.call(VowRoom.t),
      orderByList: orderByList?.call(VowRoom.t),
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [VowRoom] matching the given query parameters.
  ///
  /// Use [where] to specify which items to include in the return value.
  /// If none is specified, all items will be returned.
  ///
  /// To specify the order use [orderBy] or [orderByList]
  /// when sorting by multiple columns.
  ///
  /// [offset] defines how many items to skip, after which the next one will be picked.
  ///
  /// ```dart
  /// var youngestPerson = await Persons.db.findFirstRow(
  ///   session,
  ///   where: (t) => t.lastName.equals('Jones'),
  ///   orderBy: (t) => t.age,
  /// );
  /// ```
  Future<VowRoom?> findFirstRow(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<VowRoomTable>? where,
    int? offset,
    _is.OrderByBuilder<VowRoomTable>? orderBy,
    _is.OrderByListBuilder<VowRoomTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<VowRoom>(
      where: where?.call(VowRoom.t),
      orderBy: orderBy?.call(VowRoom.t),
      orderByList: orderByList?.call(VowRoom.t),
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [VowRoom] by its [id] or null if no such row exists.
  Future<VowRoom?> findById(
    _is.DatabaseSession session,
    int id, {
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<VowRoom>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [VowRoom]s in the list and returns the inserted rows.
  ///
  /// The returned [VowRoom]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  ///
  /// If [ignoreConflicts] is set to `true`, rows that conflict with existing
  /// rows are silently skipped, and only the successfully inserted rows are
  /// returned.
  ///
  /// If [noReturn] is set to `true`, the inserted rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<VowRoom>> insert(
    _is.DatabaseSession session,
    List<VowRoom> rows, {
    _is.Transaction? transaction,
    bool ignoreConflicts = false,
    bool noReturn = false,
  }) async {
    return session.db.insert<VowRoom>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
      noReturn: noReturn,
    );
  }

  /// Inserts a single [VowRoom] and returns the inserted row.
  ///
  /// The returned [VowRoom] will have its `id` field set.
  Future<VowRoom> insertRow(
    _is.DatabaseSession session,
    VowRoom row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.insertRow<VowRoom>(
      row,
      transaction: transaction,
    );
  }

  /// Upserts all [VowRoom]s in the list and returns the resulting rows.
  ///
  /// If a row conflicts on the given [conflictColumns], the existing row is
  /// updated with the new values. Otherwise, a new row is inserted.
  ///
  /// If [updateColumns] is provided, only those columns will be updated on
  /// conflict. If null, all non-conflict, non-id columns are updated.
  ///
  /// If [updateWhere] is provided, the update only applies to rows matching the
  /// given expression. Conflicting rows that don't match are skipped and not
  /// returned, so the resulting list may be shorter than [rows].
  ///
  /// The returned [VowRoom]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails,
  /// none of the rows will be affected.
  ///
  /// If [noReturn] is set to `true`, the resulting rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<VowRoom>> upsert(
    _is.DatabaseSession session,
    List<VowRoom> rows, {
    required _is.ColumnSelections<VowRoomTable> conflictColumns,
    _is.ColumnSelections<VowRoomTable>? updateColumns,
    _is.WhereExpressionBuilder<VowRoomTable>? updateWhere,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.upsert<VowRoom>(
      rows,
      conflictColumns: conflictColumns(VowRoom.t),
      updateColumns: updateColumns?.call(VowRoom.t),
      updateWhere: updateWhere?.call(VowRoom.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Upserts a single [VowRoom] and returns the resulting row.
  ///
  /// If the row conflicts on the given [conflictColumns], the existing row is
  /// updated. Otherwise, a new row is inserted.
  ///
  /// If [updateColumns] is provided, only those columns will be updated on
  /// conflict. If null, all non-conflict, non-id columns are updated.
  ///
  /// If [updateWhere] is provided, the update only applies when the existing
  /// row matches the expression. Returns `null` if no row was affected — for
  /// example when [updateWhere] does not match the conflicting row.
  ///
  /// The returned [VowRoom] will have its `id` field set.
  Future<VowRoom?> upsertRow(
    _is.DatabaseSession session,
    VowRoom row, {
    required _is.ColumnSelections<VowRoomTable> conflictColumns,
    _is.ColumnSelections<VowRoomTable>? updateColumns,
    _is.WhereExpressionBuilder<VowRoomTable>? updateWhere,
    _is.Transaction? transaction,
  }) async {
    return session.db.upsertRow<VowRoom>(
      row,
      conflictColumns: conflictColumns(VowRoom.t),
      updateColumns: updateColumns?.call(VowRoom.t),
      updateWhere: updateWhere?.call(VowRoom.t),
      transaction: transaction,
    );
  }

  /// Updates all [VowRoom]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<VowRoom>> update(
    _is.DatabaseSession session,
    List<VowRoom> rows, {
    _is.ColumnSelections<VowRoomTable>? columns,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.update<VowRoom>(
      rows,
      columns: columns?.call(VowRoom.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Updates a single [VowRoom]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<VowRoom> updateRow(
    _is.DatabaseSession session,
    VowRoom row, {
    _is.ColumnSelections<VowRoomTable>? columns,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateRow<VowRoom>(
      row,
      columns: columns?.call(VowRoom.t),
      transaction: transaction,
    );
  }

  /// Updates a single [VowRoom] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<VowRoom?> updateById(
    _is.DatabaseSession session,
    int id, {
    required _is.ColumnValueListBuilder<VowRoomUpdateTable> columnValues,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateById<VowRoom>(
      id,
      columnValues: columnValues(VowRoom.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [VowRoom]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<VowRoom>> updateWhere(
    _is.DatabaseSession session, {
    required _is.ColumnValueListBuilder<VowRoomUpdateTable> columnValues,
    required _is.WhereExpressionBuilder<VowRoomTable> where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<VowRoomTable>? orderBy,
    _is.OrderByListBuilder<VowRoomTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.updateWhere<VowRoom>(
      columnValues: columnValues(VowRoom.t.updateTable),
      where: where(VowRoom.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(VowRoom.t),
      orderByList: orderByList?.call(VowRoom.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes all [VowRoom]s in the list and returns the deleted rows.
  ///
  /// To specify the order of the returned rows use [orderBy] or [orderByList]
  /// when sorting by multiple columns.
  ///
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  ///
  /// If [noReturn] is set to `true`, the deleted rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<VowRoom>> delete(
    _is.DatabaseSession session,
    List<VowRoom> rows, {
    _is.OrderByBuilder<VowRoomTable>? orderBy,
    _is.OrderByListBuilder<VowRoomTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.delete<VowRoom>(
      rows,
      orderBy: orderBy?.call(VowRoom.t),
      orderByList: orderByList?.call(VowRoom.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes a single [VowRoom].
  Future<VowRoom> deleteRow(
    _is.DatabaseSession session,
    VowRoom row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.deleteRow<VowRoom>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  ///
  /// To specify the order of the returned rows use [orderBy] or [orderByList]
  /// when sorting by multiple columns.
  ///
  /// If [noReturn] is set to `true`, the deleted rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<VowRoom>> deleteWhere(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<VowRoomTable> where,
    _is.OrderByBuilder<VowRoomTable>? orderBy,
    _is.OrderByListBuilder<VowRoomTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.deleteWhere<VowRoom>(
      where: where(VowRoom.t),
      orderBy: orderBy?.call(VowRoom.t),
      orderByList: orderByList?.call(VowRoom.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<VowRoomTable>? where,
    int? limit,
    _is.Transaction? transaction,
  }) async {
    return session.db.count<VowRoom>(
      where: where?.call(VowRoom.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [VowRoom] rows matching the [where] expression.
  Future<void> lockRows(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<VowRoomTable> where,
    required _is.LockMode lockMode,
    required _is.Transaction transaction,
    _is.LockBehavior lockBehavior = _is.LockBehavior.wait,
  }) async {
    return session.db.lockRows<VowRoom>(
      where: where(VowRoom.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
