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

/// Request to join an approval-gated vow room.
abstract class JoinRequest
    implements _is.TableRow<int?>, _is.ProtocolSerialization {
  JoinRequest._({
    this.id,
    required this.roomId,
    required this.userId,
    required this.displayName,
    required this.status,
    required this.createdAt,
  });

  factory JoinRequest({
    int? id,
    required int roomId,
    required String userId,
    required String displayName,
    required String status,
    required DateTime createdAt,
  }) = _JoinRequestImpl;

  factory JoinRequest.fromJson(Map<String, dynamic> jsonSerialization) {
    return JoinRequest(
      id: jsonSerialization['id'] as int?,
      roomId: jsonSerialization['roomId'] as int,
      userId: jsonSerialization['userId'] as String,
      displayName: jsonSerialization['displayName'] as String,
      status: jsonSerialization['status'] as String,
      createdAt: _is.DateTimeJsonExtension.fromJson(
        jsonSerialization['createdAt'],
      ),
    );
  }

  static final t = JoinRequestTable();

  static const db = JoinRequestRepository._();

  @override
  int? id;

  int roomId;

  String userId;

  String displayName;

  /// pending | approved | rejected
  String status;

  DateTime createdAt;

  @override
  _is.Table<int?> get table => t;

  /// Returns a shallow copy of this [JoinRequest]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  JoinRequest copyWith({
    int? id,
    int? roomId,
    String? userId,
    String? displayName,
    String? status,
    DateTime? createdAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'JoinRequest',
      if (id != null) 'id': id,
      'roomId': roomId,
      'userId': userId,
      'displayName': displayName,
      'status': status,
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'JoinRequest',
      if (id != null) 'id': id,
      'roomId': roomId,
      'userId': userId,
      'displayName': displayName,
      'status': status,
      'createdAt': createdAt.toJson(),
    };
  }

  static JoinRequestInclude include() {
    return JoinRequestInclude._();
  }

  static JoinRequestIncludeList includeList({
    _is.WhereExpressionBuilder<JoinRequestTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<JoinRequestTable>? orderBy,
    _is.OrderByListBuilder<JoinRequestTable>? orderByList,
    JoinRequestInclude? include,
  }) {
    return JoinRequestIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(JoinRequest.t),
      orderByList: orderByList?.call(JoinRequest.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _JoinRequestImpl extends JoinRequest {
  _JoinRequestImpl({
    int? id,
    required int roomId,
    required String userId,
    required String displayName,
    required String status,
    required DateTime createdAt,
  }) : super._(
         id: id,
         roomId: roomId,
         userId: userId,
         displayName: displayName,
         status: status,
         createdAt: createdAt,
       );

  /// Returns a shallow copy of this [JoinRequest]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  JoinRequest copyWith({
    Object? id = _Undefined,
    int? roomId,
    String? userId,
    String? displayName,
    String? status,
    DateTime? createdAt,
  }) {
    return JoinRequest(
      id: id is int? ? id : this.id,
      roomId: roomId ?? this.roomId,
      userId: userId ?? this.userId,
      displayName: displayName ?? this.displayName,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}

class JoinRequestUpdateTable extends _is.UpdateTable<JoinRequestTable> {
  JoinRequestUpdateTable(super.table);

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

  _is.ColumnValue<String, String> status(String value) => _is.ColumnValue(
    table.status,
    value,
  );

  _is.ColumnValue<DateTime, DateTime> createdAt(DateTime value) =>
      _is.ColumnValue(
        table.createdAt,
        value,
      );
}

class JoinRequestTable extends _is.Table<int?> {
  JoinRequestTable({super.tableRelation}) : super(tableName: 'join_request') {
    updateTable = JoinRequestUpdateTable(this);
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
    status = _is.ColumnString(
      'status',
      this,
    );
    createdAt = _is.ColumnDateTime(
      'createdAt',
      this,
    );
  }

  late final JoinRequestUpdateTable updateTable;

  late final _is.ColumnInt roomId;

  late final _is.ColumnString userId;

  late final _is.ColumnString displayName;

  /// pending | approved | rejected
  late final _is.ColumnString status;

  late final _is.ColumnDateTime createdAt;

  @override
  List<_is.Column> get columns => [
    id,
    roomId,
    userId,
    displayName,
    status,
    createdAt,
  ];
}

class JoinRequestInclude extends _is.IncludeObject {
  JoinRequestInclude._();

  @override
  Map<String, _is.Include?> get includes => {};

  @override
  _is.Table<int?> get table => JoinRequest.t;
}

class JoinRequestIncludeList extends _is.IncludeList {
  JoinRequestIncludeList._({
    _is.WhereExpressionBuilder<JoinRequestTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(JoinRequest.t);
  }

  @override
  Map<String, _is.Include?> get includes => include?.includes ?? {};

  @override
  _is.Table<int?> get table => JoinRequest.t;
}

class JoinRequestRepository {
  const JoinRequestRepository._();

  /// Returns a list of [JoinRequest]s matching the given query parameters.
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
  Future<List<JoinRequest>> find(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<JoinRequestTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<JoinRequestTable>? orderBy,
    _is.OrderByListBuilder<JoinRequestTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<JoinRequest>(
      where: where?.call(JoinRequest.t),
      orderBy: orderBy?.call(JoinRequest.t),
      orderByList: orderByList?.call(JoinRequest.t),
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [JoinRequest] matching the given query parameters.
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
  Future<JoinRequest?> findFirstRow(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<JoinRequestTable>? where,
    int? offset,
    _is.OrderByBuilder<JoinRequestTable>? orderBy,
    _is.OrderByListBuilder<JoinRequestTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<JoinRequest>(
      where: where?.call(JoinRequest.t),
      orderBy: orderBy?.call(JoinRequest.t),
      orderByList: orderByList?.call(JoinRequest.t),
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [JoinRequest] by its [id] or null if no such row exists.
  Future<JoinRequest?> findById(
    _is.DatabaseSession session,
    int id, {
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<JoinRequest>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [JoinRequest]s in the list and returns the inserted rows.
  ///
  /// The returned [JoinRequest]s will have their `id` fields set.
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
  Future<List<JoinRequest>> insert(
    _is.DatabaseSession session,
    List<JoinRequest> rows, {
    _is.Transaction? transaction,
    bool ignoreConflicts = false,
    bool noReturn = false,
  }) async {
    return session.db.insert<JoinRequest>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
      noReturn: noReturn,
    );
  }

  /// Inserts a single [JoinRequest] and returns the inserted row.
  ///
  /// The returned [JoinRequest] will have its `id` field set.
  Future<JoinRequest> insertRow(
    _is.DatabaseSession session,
    JoinRequest row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.insertRow<JoinRequest>(
      row,
      transaction: transaction,
    );
  }

  /// Upserts all [JoinRequest]s in the list and returns the resulting rows.
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
  /// The returned [JoinRequest]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails,
  /// none of the rows will be affected.
  ///
  /// If [noReturn] is set to `true`, the resulting rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<JoinRequest>> upsert(
    _is.DatabaseSession session,
    List<JoinRequest> rows, {
    required _is.ColumnSelections<JoinRequestTable> conflictColumns,
    _is.ColumnSelections<JoinRequestTable>? updateColumns,
    _is.WhereExpressionBuilder<JoinRequestTable>? updateWhere,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.upsert<JoinRequest>(
      rows,
      conflictColumns: conflictColumns(JoinRequest.t),
      updateColumns: updateColumns?.call(JoinRequest.t),
      updateWhere: updateWhere?.call(JoinRequest.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Upserts a single [JoinRequest] and returns the resulting row.
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
  /// The returned [JoinRequest] will have its `id` field set.
  Future<JoinRequest?> upsertRow(
    _is.DatabaseSession session,
    JoinRequest row, {
    required _is.ColumnSelections<JoinRequestTable> conflictColumns,
    _is.ColumnSelections<JoinRequestTable>? updateColumns,
    _is.WhereExpressionBuilder<JoinRequestTable>? updateWhere,
    _is.Transaction? transaction,
  }) async {
    return session.db.upsertRow<JoinRequest>(
      row,
      conflictColumns: conflictColumns(JoinRequest.t),
      updateColumns: updateColumns?.call(JoinRequest.t),
      updateWhere: updateWhere?.call(JoinRequest.t),
      transaction: transaction,
    );
  }

  /// Updates all [JoinRequest]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<JoinRequest>> update(
    _is.DatabaseSession session,
    List<JoinRequest> rows, {
    _is.ColumnSelections<JoinRequestTable>? columns,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.update<JoinRequest>(
      rows,
      columns: columns?.call(JoinRequest.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Updates a single [JoinRequest]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<JoinRequest> updateRow(
    _is.DatabaseSession session,
    JoinRequest row, {
    _is.ColumnSelections<JoinRequestTable>? columns,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateRow<JoinRequest>(
      row,
      columns: columns?.call(JoinRequest.t),
      transaction: transaction,
    );
  }

  /// Updates a single [JoinRequest] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<JoinRequest?> updateById(
    _is.DatabaseSession session,
    int id, {
    required _is.ColumnValueListBuilder<JoinRequestUpdateTable> columnValues,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateById<JoinRequest>(
      id,
      columnValues: columnValues(JoinRequest.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [JoinRequest]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<JoinRequest>> updateWhere(
    _is.DatabaseSession session, {
    required _is.ColumnValueListBuilder<JoinRequestUpdateTable> columnValues,
    required _is.WhereExpressionBuilder<JoinRequestTable> where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<JoinRequestTable>? orderBy,
    _is.OrderByListBuilder<JoinRequestTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.updateWhere<JoinRequest>(
      columnValues: columnValues(JoinRequest.t.updateTable),
      where: where(JoinRequest.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(JoinRequest.t),
      orderByList: orderByList?.call(JoinRequest.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes all [JoinRequest]s in the list and returns the deleted rows.
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
  Future<List<JoinRequest>> delete(
    _is.DatabaseSession session,
    List<JoinRequest> rows, {
    _is.OrderByBuilder<JoinRequestTable>? orderBy,
    _is.OrderByListBuilder<JoinRequestTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.delete<JoinRequest>(
      rows,
      orderBy: orderBy?.call(JoinRequest.t),
      orderByList: orderByList?.call(JoinRequest.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes a single [JoinRequest].
  Future<JoinRequest> deleteRow(
    _is.DatabaseSession session,
    JoinRequest row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.deleteRow<JoinRequest>(
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
  Future<List<JoinRequest>> deleteWhere(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<JoinRequestTable> where,
    _is.OrderByBuilder<JoinRequestTable>? orderBy,
    _is.OrderByListBuilder<JoinRequestTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.deleteWhere<JoinRequest>(
      where: where(JoinRequest.t),
      orderBy: orderBy?.call(JoinRequest.t),
      orderByList: orderByList?.call(JoinRequest.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<JoinRequestTable>? where,
    int? limit,
    _is.Transaction? transaction,
  }) async {
    return session.db.count<JoinRequest>(
      where: where?.call(JoinRequest.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [JoinRequest] rows matching the [where] expression.
  Future<void> lockRows(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<JoinRequestTable> where,
    required _is.LockMode lockMode,
    required _is.Transaction transaction,
    _is.LockBehavior lockBehavior = _is.LockBehavior.wait,
  }) async {
    return session.db.lockRows<JoinRequest>(
      where: where(JoinRequest.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
