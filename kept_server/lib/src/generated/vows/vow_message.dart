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

/// A chat or activity line inside a vow room.
abstract class VowMessage
    implements _is.TableRow<int?>, _is.ProtocolSerialization {
  VowMessage._({
    this.id,
    required this.roomId,
    required this.userId,
    required this.displayName,
    required this.kind,
    required this.body,
    bool? sharedToFeed,
    required this.createdAt,
  }) : sharedToFeed = sharedToFeed ?? false;

  factory VowMessage({
    int? id,
    required int roomId,
    required String userId,
    required String displayName,
    required String kind,
    required String body,
    bool? sharedToFeed,
    required DateTime createdAt,
  }) = _VowMessageImpl;

  factory VowMessage.fromJson(Map<String, dynamic> jsonSerialization) {
    return VowMessage(
      id: jsonSerialization['id'] as int?,
      roomId: jsonSerialization['roomId'] as int,
      userId: jsonSerialization['userId'] as String,
      displayName: jsonSerialization['displayName'] as String,
      kind: jsonSerialization['kind'] as String,
      body: jsonSerialization['body'] as String,
      sharedToFeed: jsonSerialization['sharedToFeed'] == null
          ? null
          : _is.BoolJsonExtension.fromJson(jsonSerialization['sharedToFeed']),
      createdAt: _is.DateTimeJsonExtension.fromJson(
        jsonSerialization['createdAt'],
      ),
    );
  }

  static final t = VowMessageTable();

  static const db = VowMessageRepository._();

  @override
  int? id;

  int roomId;

  String userId;

  String displayName;

  /// chat | kept | broke | joined
  String kind;

  String body;

  /// Only true posts appear on the public home feed.
  bool sharedToFeed;

  DateTime createdAt;

  @override
  _is.Table<int?> get table => t;

  /// Returns a shallow copy of this [VowMessage]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  VowMessage copyWith({
    int? id,
    int? roomId,
    String? userId,
    String? displayName,
    String? kind,
    String? body,
    bool? sharedToFeed,
    DateTime? createdAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'VowMessage',
      if (id != null) 'id': id,
      'roomId': roomId,
      'userId': userId,
      'displayName': displayName,
      'kind': kind,
      'body': body,
      'sharedToFeed': sharedToFeed,
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'VowMessage',
      if (id != null) 'id': id,
      'roomId': roomId,
      'userId': userId,
      'displayName': displayName,
      'kind': kind,
      'body': body,
      'sharedToFeed': sharedToFeed,
      'createdAt': createdAt.toJson(),
    };
  }

  static VowMessageInclude include() {
    return VowMessageInclude._();
  }

  static VowMessageIncludeList includeList({
    _is.WhereExpressionBuilder<VowMessageTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<VowMessageTable>? orderBy,
    _is.OrderByListBuilder<VowMessageTable>? orderByList,
    VowMessageInclude? include,
  }) {
    return VowMessageIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(VowMessage.t),
      orderByList: orderByList?.call(VowMessage.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _VowMessageImpl extends VowMessage {
  _VowMessageImpl({
    int? id,
    required int roomId,
    required String userId,
    required String displayName,
    required String kind,
    required String body,
    bool? sharedToFeed,
    required DateTime createdAt,
  }) : super._(
         id: id,
         roomId: roomId,
         userId: userId,
         displayName: displayName,
         kind: kind,
         body: body,
         sharedToFeed: sharedToFeed,
         createdAt: createdAt,
       );

  /// Returns a shallow copy of this [VowMessage]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  VowMessage copyWith({
    Object? id = _Undefined,
    int? roomId,
    String? userId,
    String? displayName,
    String? kind,
    String? body,
    bool? sharedToFeed,
    DateTime? createdAt,
  }) {
    return VowMessage(
      id: id is int? ? id : this.id,
      roomId: roomId ?? this.roomId,
      userId: userId ?? this.userId,
      displayName: displayName ?? this.displayName,
      kind: kind ?? this.kind,
      body: body ?? this.body,
      sharedToFeed: sharedToFeed ?? this.sharedToFeed,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}

class VowMessageUpdateTable extends _is.UpdateTable<VowMessageTable> {
  VowMessageUpdateTable(super.table);

  _is.ColumnValue<int, int> roomId(int value) => _is.ColumnValue(
    table.roomId,
    value,
  );

  _is.ColumnValue<String, String> userId(String value) => _is.ColumnValue(
    table.userId,
    value,
  );

  _is.ColumnValue<String, String> displayName(String value) => _is.ColumnValue(
    table.displayName,
    value,
  );

  _is.ColumnValue<String, String> kind(String value) => _is.ColumnValue(
    table.kind,
    value,
  );

  _is.ColumnValue<String, String> body(String value) => _is.ColumnValue(
    table.body,
    value,
  );

  _is.ColumnValue<bool, bool> sharedToFeed(bool value) => _is.ColumnValue(
    table.sharedToFeed,
    value,
  );

  _is.ColumnValue<DateTime, DateTime> createdAt(DateTime value) =>
      _is.ColumnValue(
        table.createdAt,
        value,
      );
}

class VowMessageTable extends _is.Table<int?> {
  VowMessageTable({super.tableRelation}) : super(tableName: 'vow_message') {
    updateTable = VowMessageUpdateTable(this);
    roomId = _is.ColumnInt(
      'roomId',
      this,
    );
    userId = _is.ColumnString(
      'userId',
      this,
    );
    displayName = _is.ColumnString(
      'displayName',
      this,
    );
    kind = _is.ColumnString(
      'kind',
      this,
    );
    body = _is.ColumnString(
      'body',
      this,
    );
    sharedToFeed = _is.ColumnBool(
      'sharedToFeed',
      this,
      hasDefault: true,
    );
    createdAt = _is.ColumnDateTime(
      'createdAt',
      this,
    );
  }

  late final VowMessageUpdateTable updateTable;

  late final _is.ColumnInt roomId;

  late final _is.ColumnString userId;

  late final _is.ColumnString displayName;

  /// chat | kept | broke | joined
  late final _is.ColumnString kind;

  late final _is.ColumnString body;

  /// Only true posts appear on the public home feed.
  late final _is.ColumnBool sharedToFeed;

  late final _is.ColumnDateTime createdAt;

  @override
  List<_is.Column> get columns => [
    id,
    roomId,
    userId,
    displayName,
    kind,
    body,
    sharedToFeed,
    createdAt,
  ];
}

class VowMessageInclude extends _is.IncludeObject {
  VowMessageInclude._();

  @override
  Map<String, _is.Include?> get includes => {};

  @override
  _is.Table<int?> get table => VowMessage.t;
}

class VowMessageIncludeList extends _is.IncludeList {
  VowMessageIncludeList._({
    _is.WhereExpressionBuilder<VowMessageTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(VowMessage.t);
  }

  @override
  Map<String, _is.Include?> get includes => include?.includes ?? {};

  @override
  _is.Table<int?> get table => VowMessage.t;
}

class VowMessageRepository {
  const VowMessageRepository._();

  /// Returns a list of [VowMessage]s matching the given query parameters.
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
  Future<List<VowMessage>> find(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<VowMessageTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<VowMessageTable>? orderBy,
    _is.OrderByListBuilder<VowMessageTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<VowMessage>(
      where: where?.call(VowMessage.t),
      orderBy: orderBy?.call(VowMessage.t),
      orderByList: orderByList?.call(VowMessage.t),
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [VowMessage] matching the given query parameters.
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
  Future<VowMessage?> findFirstRow(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<VowMessageTable>? where,
    int? offset,
    _is.OrderByBuilder<VowMessageTable>? orderBy,
    _is.OrderByListBuilder<VowMessageTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<VowMessage>(
      where: where?.call(VowMessage.t),
      orderBy: orderBy?.call(VowMessage.t),
      orderByList: orderByList?.call(VowMessage.t),
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [VowMessage] by its [id] or null if no such row exists.
  Future<VowMessage?> findById(
    _is.DatabaseSession session,
    int id, {
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<VowMessage>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [VowMessage]s in the list and returns the inserted rows.
  ///
  /// The returned [VowMessage]s will have their `id` fields set.
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
  Future<List<VowMessage>> insert(
    _is.DatabaseSession session,
    List<VowMessage> rows, {
    _is.Transaction? transaction,
    bool ignoreConflicts = false,
    bool noReturn = false,
  }) async {
    return session.db.insert<VowMessage>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
      noReturn: noReturn,
    );
  }

  /// Inserts a single [VowMessage] and returns the inserted row.
  ///
  /// The returned [VowMessage] will have its `id` field set.
  Future<VowMessage> insertRow(
    _is.DatabaseSession session,
    VowMessage row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.insertRow<VowMessage>(
      row,
      transaction: transaction,
    );
  }

  /// Upserts all [VowMessage]s in the list and returns the resulting rows.
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
  /// The returned [VowMessage]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails,
  /// none of the rows will be affected.
  ///
  /// If [noReturn] is set to `true`, the resulting rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<VowMessage>> upsert(
    _is.DatabaseSession session,
    List<VowMessage> rows, {
    required _is.ColumnSelections<VowMessageTable> conflictColumns,
    _is.ColumnSelections<VowMessageTable>? updateColumns,
    _is.WhereExpressionBuilder<VowMessageTable>? updateWhere,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.upsert<VowMessage>(
      rows,
      conflictColumns: conflictColumns(VowMessage.t),
      updateColumns: updateColumns?.call(VowMessage.t),
      updateWhere: updateWhere?.call(VowMessage.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Upserts a single [VowMessage] and returns the resulting row.
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
  /// The returned [VowMessage] will have its `id` field set.
  Future<VowMessage?> upsertRow(
    _is.DatabaseSession session,
    VowMessage row, {
    required _is.ColumnSelections<VowMessageTable> conflictColumns,
    _is.ColumnSelections<VowMessageTable>? updateColumns,
    _is.WhereExpressionBuilder<VowMessageTable>? updateWhere,
    _is.Transaction? transaction,
  }) async {
    return session.db.upsertRow<VowMessage>(
      row,
      conflictColumns: conflictColumns(VowMessage.t),
      updateColumns: updateColumns?.call(VowMessage.t),
      updateWhere: updateWhere?.call(VowMessage.t),
      transaction: transaction,
    );
  }

  /// Updates all [VowMessage]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<VowMessage>> update(
    _is.DatabaseSession session,
    List<VowMessage> rows, {
    _is.ColumnSelections<VowMessageTable>? columns,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.update<VowMessage>(
      rows,
      columns: columns?.call(VowMessage.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Updates a single [VowMessage]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<VowMessage> updateRow(
    _is.DatabaseSession session,
    VowMessage row, {
    _is.ColumnSelections<VowMessageTable>? columns,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateRow<VowMessage>(
      row,
      columns: columns?.call(VowMessage.t),
      transaction: transaction,
    );
  }

  /// Updates a single [VowMessage] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<VowMessage?> updateById(
    _is.DatabaseSession session,
    int id, {
    required _is.ColumnValueListBuilder<VowMessageUpdateTable> columnValues,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateById<VowMessage>(
      id,
      columnValues: columnValues(VowMessage.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [VowMessage]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<VowMessage>> updateWhere(
    _is.DatabaseSession session, {
    required _is.ColumnValueListBuilder<VowMessageUpdateTable> columnValues,
    required _is.WhereExpressionBuilder<VowMessageTable> where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<VowMessageTable>? orderBy,
    _is.OrderByListBuilder<VowMessageTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.updateWhere<VowMessage>(
      columnValues: columnValues(VowMessage.t.updateTable),
      where: where(VowMessage.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(VowMessage.t),
      orderByList: orderByList?.call(VowMessage.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes all [VowMessage]s in the list and returns the deleted rows.
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
  Future<List<VowMessage>> delete(
    _is.DatabaseSession session,
    List<VowMessage> rows, {
    _is.OrderByBuilder<VowMessageTable>? orderBy,
    _is.OrderByListBuilder<VowMessageTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.delete<VowMessage>(
      rows,
      orderBy: orderBy?.call(VowMessage.t),
      orderByList: orderByList?.call(VowMessage.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes a single [VowMessage].
  Future<VowMessage> deleteRow(
    _is.DatabaseSession session,
    VowMessage row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.deleteRow<VowMessage>(
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
  Future<List<VowMessage>> deleteWhere(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<VowMessageTable> where,
    _is.OrderByBuilder<VowMessageTable>? orderBy,
    _is.OrderByListBuilder<VowMessageTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.deleteWhere<VowMessage>(
      where: where(VowMessage.t),
      orderBy: orderBy?.call(VowMessage.t),
      orderByList: orderByList?.call(VowMessage.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<VowMessageTable>? where,
    int? limit,
    _is.Transaction? transaction,
  }) async {
    return session.db.count<VowMessage>(
      where: where?.call(VowMessage.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [VowMessage] rows matching the [where] expression.
  Future<void> lockRows(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<VowMessageTable> where,
    required _is.LockMode lockMode,
    required _is.Transaction transaction,
    _is.LockBehavior lockBehavior = _is.LockBehavior.wait,
  }) async {
    return session.db.lockRows<VowMessage>(
      where: where(VowMessage.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
