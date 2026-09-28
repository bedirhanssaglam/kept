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

/// Invite code for invite-only vow rooms.
abstract class VowInvite
    implements _is.TableRow<int?>, _is.ProtocolSerialization {
  VowInvite._({
    this.id,
    required this.roomId,
    required this.code,
    required this.createdBy,
    required this.createdAt,
    int? maxUses,
    int? useCount,
  }) : maxUses = maxUses ?? 0,
       useCount = useCount ?? 0;

  factory VowInvite({
    int? id,
    required int roomId,
    required String code,
    required String createdBy,
    required DateTime createdAt,
    int? maxUses,
    int? useCount,
  }) = _VowInviteImpl;

  factory VowInvite.fromJson(Map<String, dynamic> jsonSerialization) {
    return VowInvite(
      id: jsonSerialization['id'] as int?,
      roomId: jsonSerialization['roomId'] as int,
      code: jsonSerialization['code'] as String,
      createdBy: jsonSerialization['createdBy'] as String,
      createdAt: _is.DateTimeJsonExtension.fromJson(
        jsonSerialization['createdAt'],
      ),
      maxUses: jsonSerialization['maxUses'] as int?,
      useCount: jsonSerialization['useCount'] as int?,
    );
  }

  static final t = VowInviteTable();

  static const db = VowInviteRepository._();

  @override
  int? id;

  int roomId;

  String code;

  String createdBy;

  DateTime createdAt;

  /// 0 = unlimited
  int maxUses;

  int useCount;

  @override
  _is.Table<int?> get table => t;

  /// Returns a shallow copy of this [VowInvite]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  VowInvite copyWith({
    int? id,
    int? roomId,
    String? code,
    String? createdBy,
    DateTime? createdAt,
    int? maxUses,
    int? useCount,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'VowInvite',
      if (id != null) 'id': id,
      'roomId': roomId,
      'code': code,
      'createdBy': createdBy,
      'createdAt': createdAt.toJson(),
      'maxUses': maxUses,
      'useCount': useCount,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'VowInvite',
      if (id != null) 'id': id,
      'roomId': roomId,
      'code': code,
      'createdBy': createdBy,
      'createdAt': createdAt.toJson(),
      'maxUses': maxUses,
      'useCount': useCount,
    };
  }

  static VowInviteInclude include() {
    return VowInviteInclude._();
  }

  static VowInviteIncludeList includeList({
    _is.WhereExpressionBuilder<VowInviteTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<VowInviteTable>? orderBy,
    _is.OrderByListBuilder<VowInviteTable>? orderByList,
    VowInviteInclude? include,
  }) {
    return VowInviteIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(VowInvite.t),
      orderByList: orderByList?.call(VowInvite.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _VowInviteImpl extends VowInvite {
  _VowInviteImpl({
    int? id,
    required int roomId,
    required String code,
    required String createdBy,
    required DateTime createdAt,
    int? maxUses,
    int? useCount,
  }) : super._(
         id: id,
         roomId: roomId,
         code: code,
         createdBy: createdBy,
         createdAt: createdAt,
         maxUses: maxUses,
         useCount: useCount,
       );

  /// Returns a shallow copy of this [VowInvite]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  VowInvite copyWith({
    Object? id = _Undefined,
    int? roomId,
    String? code,
    String? createdBy,
    DateTime? createdAt,
    int? maxUses,
    int? useCount,
  }) {
    return VowInvite(
      id: id is int? ? id : this.id,
      roomId: roomId ?? this.roomId,
      code: code ?? this.code,
      createdBy: createdBy ?? this.createdBy,
      createdAt: createdAt ?? this.createdAt,
      maxUses: maxUses ?? this.maxUses,
      useCount: useCount ?? this.useCount,
    );
  }
}

class VowInviteUpdateTable extends _is.UpdateTable<VowInviteTable> {
  VowInviteUpdateTable(super.table);

  _is.ColumnValue<int, int> roomId(int value) => _is.ColumnValue(
    table.roomId,
    value,
  );

  _is.ColumnValue<String, String> code(String value) => _is.ColumnValue(
    table.code,
    value,
  );

  _is.ColumnValue<String, String> createdBy(String value) => _is.ColumnValue(
    table.createdBy,
    value,
  );

  _is.ColumnValue<DateTime, DateTime> createdAt(DateTime value) =>
      _is.ColumnValue(
        table.createdAt,
        value,
      );

  _is.ColumnValue<int, int> maxUses(int value) => _is.ColumnValue(
    table.maxUses,
    value,
  );

  _is.ColumnValue<int, int> useCount(int value) => _is.ColumnValue(
    table.useCount,
    value,
  );
}

class VowInviteTable extends _is.Table<int?> {
  VowInviteTable({super.tableRelation}) : super(tableName: 'vow_invite') {
    updateTable = VowInviteUpdateTable(this);
    roomId = _is.ColumnInt(
      'roomId',
      this,
    );
    code = _is.ColumnString(
      'code',
      this,
    );
    createdBy = _is.ColumnString(
      'createdBy',
      this,
    );
    createdAt = _is.ColumnDateTime(
      'createdAt',
      this,
    );
    maxUses = _is.ColumnInt(
      'maxUses',
      this,
      hasDefault: true,
    );
    useCount = _is.ColumnInt(
      'useCount',
      this,
      hasDefault: true,
    );
  }

  late final VowInviteUpdateTable updateTable;

  late final _is.ColumnInt roomId;

  late final _is.ColumnString code;

  late final _is.ColumnString createdBy;

  late final _is.ColumnDateTime createdAt;

  /// 0 = unlimited
  late final _is.ColumnInt maxUses;

  late final _is.ColumnInt useCount;

  @override
  List<_is.Column> get columns => [
    id,
    roomId,
    code,
    createdBy,
    createdAt,
    maxUses,
    useCount,
  ];
}

class VowInviteInclude extends _is.IncludeObject {
  VowInviteInclude._();

  @override
  Map<String, _is.Include?> get includes => {};

  @override
  _is.Table<int?> get table => VowInvite.t;
}

class VowInviteIncludeList extends _is.IncludeList {
  VowInviteIncludeList._({
    _is.WhereExpressionBuilder<VowInviteTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(VowInvite.t);
  }

  @override
  Map<String, _is.Include?> get includes => include?.includes ?? {};

  @override
  _is.Table<int?> get table => VowInvite.t;
}

class VowInviteRepository {
  const VowInviteRepository._();

  /// Returns a list of [VowInvite]s matching the given query parameters.
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
  Future<List<VowInvite>> find(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<VowInviteTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<VowInviteTable>? orderBy,
    _is.OrderByListBuilder<VowInviteTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<VowInvite>(
      where: where?.call(VowInvite.t),
      orderBy: orderBy?.call(VowInvite.t),
      orderByList: orderByList?.call(VowInvite.t),
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [VowInvite] matching the given query parameters.
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
  Future<VowInvite?> findFirstRow(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<VowInviteTable>? where,
    int? offset,
    _is.OrderByBuilder<VowInviteTable>? orderBy,
    _is.OrderByListBuilder<VowInviteTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<VowInvite>(
      where: where?.call(VowInvite.t),
      orderBy: orderBy?.call(VowInvite.t),
      orderByList: orderByList?.call(VowInvite.t),
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [VowInvite] by its [id] or null if no such row exists.
  Future<VowInvite?> findById(
    _is.DatabaseSession session,
    int id, {
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<VowInvite>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [VowInvite]s in the list and returns the inserted rows.
  ///
  /// The returned [VowInvite]s will have their `id` fields set.
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
  Future<List<VowInvite>> insert(
    _is.DatabaseSession session,
    List<VowInvite> rows, {
    _is.Transaction? transaction,
    bool ignoreConflicts = false,
    bool noReturn = false,
  }) async {
    return session.db.insert<VowInvite>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
      noReturn: noReturn,
    );
  }

  /// Inserts a single [VowInvite] and returns the inserted row.
  ///
  /// The returned [VowInvite] will have its `id` field set.
  Future<VowInvite> insertRow(
    _is.DatabaseSession session,
    VowInvite row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.insertRow<VowInvite>(
      row,
      transaction: transaction,
    );
  }

  /// Upserts all [VowInvite]s in the list and returns the resulting rows.
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
  /// The returned [VowInvite]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails,
  /// none of the rows will be affected.
  ///
  /// If [noReturn] is set to `true`, the resulting rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<VowInvite>> upsert(
    _is.DatabaseSession session,
    List<VowInvite> rows, {
    required _is.ColumnSelections<VowInviteTable> conflictColumns,
    _is.ColumnSelections<VowInviteTable>? updateColumns,
    _is.WhereExpressionBuilder<VowInviteTable>? updateWhere,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.upsert<VowInvite>(
      rows,
      conflictColumns: conflictColumns(VowInvite.t),
      updateColumns: updateColumns?.call(VowInvite.t),
      updateWhere: updateWhere?.call(VowInvite.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Upserts a single [VowInvite] and returns the resulting row.
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
  /// The returned [VowInvite] will have its `id` field set.
  Future<VowInvite?> upsertRow(
    _is.DatabaseSession session,
    VowInvite row, {
    required _is.ColumnSelections<VowInviteTable> conflictColumns,
    _is.ColumnSelections<VowInviteTable>? updateColumns,
    _is.WhereExpressionBuilder<VowInviteTable>? updateWhere,
    _is.Transaction? transaction,
  }) async {
    return session.db.upsertRow<VowInvite>(
      row,
      conflictColumns: conflictColumns(VowInvite.t),
      updateColumns: updateColumns?.call(VowInvite.t),
      updateWhere: updateWhere?.call(VowInvite.t),
      transaction: transaction,
    );
  }

  /// Updates all [VowInvite]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<VowInvite>> update(
    _is.DatabaseSession session,
    List<VowInvite> rows, {
    _is.ColumnSelections<VowInviteTable>? columns,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.update<VowInvite>(
      rows,
      columns: columns?.call(VowInvite.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Updates a single [VowInvite]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<VowInvite> updateRow(
    _is.DatabaseSession session,
    VowInvite row, {
    _is.ColumnSelections<VowInviteTable>? columns,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateRow<VowInvite>(
      row,
      columns: columns?.call(VowInvite.t),
      transaction: transaction,
    );
  }

  /// Updates a single [VowInvite] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<VowInvite?> updateById(
    _is.DatabaseSession session,
    int id, {
    required _is.ColumnValueListBuilder<VowInviteUpdateTable> columnValues,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateById<VowInvite>(
      id,
      columnValues: columnValues(VowInvite.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [VowInvite]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<VowInvite>> updateWhere(
    _is.DatabaseSession session, {
    required _is.ColumnValueListBuilder<VowInviteUpdateTable> columnValues,
    required _is.WhereExpressionBuilder<VowInviteTable> where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<VowInviteTable>? orderBy,
    _is.OrderByListBuilder<VowInviteTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.updateWhere<VowInvite>(
      columnValues: columnValues(VowInvite.t.updateTable),
      where: where(VowInvite.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(VowInvite.t),
      orderByList: orderByList?.call(VowInvite.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes all [VowInvite]s in the list and returns the deleted rows.
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
  Future<List<VowInvite>> delete(
    _is.DatabaseSession session,
    List<VowInvite> rows, {
    _is.OrderByBuilder<VowInviteTable>? orderBy,
    _is.OrderByListBuilder<VowInviteTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.delete<VowInvite>(
      rows,
      orderBy: orderBy?.call(VowInvite.t),
      orderByList: orderByList?.call(VowInvite.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes a single [VowInvite].
  Future<VowInvite> deleteRow(
    _is.DatabaseSession session,
    VowInvite row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.deleteRow<VowInvite>(
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
  Future<List<VowInvite>> deleteWhere(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<VowInviteTable> where,
    _is.OrderByBuilder<VowInviteTable>? orderBy,
    _is.OrderByListBuilder<VowInviteTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.deleteWhere<VowInvite>(
      where: where(VowInvite.t),
      orderBy: orderBy?.call(VowInvite.t),
      orderByList: orderByList?.call(VowInvite.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<VowInviteTable>? where,
    int? limit,
    _is.Transaction? transaction,
  }) async {
    return session.db.count<VowInvite>(
      where: where?.call(VowInvite.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [VowInvite] rows matching the [where] expression.
  Future<void> lockRows(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<VowInviteTable> where,
    required _is.LockMode lockMode,
    required _is.Transaction transaction,
    _is.LockBehavior lockBehavior = _is.LockBehavior.wait,
  }) async {
    return session.db.lockRows<VowInvite>(
      where: where(VowInvite.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
