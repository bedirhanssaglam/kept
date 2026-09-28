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

/// A like on a home-feed target (activity message or article).
abstract class FeedLike
    implements _is.TableRow<int?>, _is.ProtocolSerialization {
  FeedLike._({
    this.id,
    required this.userId,
    required this.targetType,
    required this.targetId,
    required this.createdAt,
  });

  factory FeedLike({
    int? id,
    required String userId,
    required String targetType,
    required int targetId,
    required DateTime createdAt,
  }) = _FeedLikeImpl;

  factory FeedLike.fromJson(Map<String, dynamic> jsonSerialization) {
    return FeedLike(
      id: jsonSerialization['id'] as int?,
      userId: jsonSerialization['userId'] as String,
      targetType: jsonSerialization['targetType'] as String,
      targetId: jsonSerialization['targetId'] as int,
      createdAt: _is.DateTimeJsonExtension.fromJson(
        jsonSerialization['createdAt'],
      ),
    );
  }

  static final t = FeedLikeTable();

  static const db = FeedLikeRepository._();

  @override
  int? id;

  String userId;

  /// message | article
  String targetType;

  int targetId;

  DateTime createdAt;

  @override
  _is.Table<int?> get table => t;

  /// Returns a shallow copy of this [FeedLike]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  FeedLike copyWith({
    int? id,
    String? userId,
    String? targetType,
    int? targetId,
    DateTime? createdAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'FeedLike',
      if (id != null) 'id': id,
      'userId': userId,
      'targetType': targetType,
      'targetId': targetId,
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'FeedLike',
      if (id != null) 'id': id,
      'userId': userId,
      'targetType': targetType,
      'targetId': targetId,
      'createdAt': createdAt.toJson(),
    };
  }

  static FeedLikeInclude include() {
    return FeedLikeInclude._();
  }

  static FeedLikeIncludeList includeList({
    _is.WhereExpressionBuilder<FeedLikeTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<FeedLikeTable>? orderBy,
    _is.OrderByListBuilder<FeedLikeTable>? orderByList,
    FeedLikeInclude? include,
  }) {
    return FeedLikeIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(FeedLike.t),
      orderByList: orderByList?.call(FeedLike.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _FeedLikeImpl extends FeedLike {
  _FeedLikeImpl({
    int? id,
    required String userId,
    required String targetType,
    required int targetId,
    required DateTime createdAt,
  }) : super._(
         id: id,
         userId: userId,
         targetType: targetType,
         targetId: targetId,
         createdAt: createdAt,
       );

  /// Returns a shallow copy of this [FeedLike]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  FeedLike copyWith({
    Object? id = _Undefined,
    String? userId,
    String? targetType,
    int? targetId,
    DateTime? createdAt,
  }) {
    return FeedLike(
      id: id is int? ? id : this.id,
      userId: userId ?? this.userId,
      targetType: targetType ?? this.targetType,
      targetId: targetId ?? this.targetId,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}

class FeedLikeUpdateTable extends _is.UpdateTable<FeedLikeTable> {
  FeedLikeUpdateTable(super.table);

  _is.ColumnValue<String, String> userId(String value) => _is.ColumnValue(
    table.userId,
    value,
  );

  _is.ColumnValue<String, String> targetType(String value) => _is.ColumnValue(
    table.targetType,
    value,
  );

  _is.ColumnValue<int, int> targetId(int value) => _is.ColumnValue(
    table.targetId,
    value,
  );

  _is.ColumnValue<DateTime, DateTime> createdAt(DateTime value) =>
      _is.ColumnValue(
        table.createdAt,
        value,
      );
}

class FeedLikeTable extends _is.Table<int?> {
  FeedLikeTable({super.tableRelation}) : super(tableName: 'feed_like') {
    updateTable = FeedLikeUpdateTable(this);
    userId = _is.ColumnString(
      'userId',
      this,
    );
    targetType = _is.ColumnString(
      'targetType',
      this,
    );
    targetId = _is.ColumnInt(
      'targetId',
      this,
    );
    createdAt = _is.ColumnDateTime(
      'createdAt',
      this,
    );
  }

  late final FeedLikeUpdateTable updateTable;

  late final _is.ColumnString userId;

  /// message | article
  late final _is.ColumnString targetType;

  late final _is.ColumnInt targetId;

  late final _is.ColumnDateTime createdAt;

  @override
  List<_is.Column> get columns => [
    id,
    userId,
    targetType,
    targetId,
    createdAt,
  ];
}

class FeedLikeInclude extends _is.IncludeObject {
  FeedLikeInclude._();

  @override
  Map<String, _is.Include?> get includes => {};

  @override
  _is.Table<int?> get table => FeedLike.t;
}

class FeedLikeIncludeList extends _is.IncludeList {
  FeedLikeIncludeList._({
    _is.WhereExpressionBuilder<FeedLikeTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(FeedLike.t);
  }

  @override
  Map<String, _is.Include?> get includes => include?.includes ?? {};

  @override
  _is.Table<int?> get table => FeedLike.t;
}

class FeedLikeRepository {
  const FeedLikeRepository._();

  /// Returns a list of [FeedLike]s matching the given query parameters.
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
  Future<List<FeedLike>> find(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<FeedLikeTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<FeedLikeTable>? orderBy,
    _is.OrderByListBuilder<FeedLikeTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<FeedLike>(
      where: where?.call(FeedLike.t),
      orderBy: orderBy?.call(FeedLike.t),
      orderByList: orderByList?.call(FeedLike.t),
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [FeedLike] matching the given query parameters.
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
  Future<FeedLike?> findFirstRow(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<FeedLikeTable>? where,
    int? offset,
    _is.OrderByBuilder<FeedLikeTable>? orderBy,
    _is.OrderByListBuilder<FeedLikeTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<FeedLike>(
      where: where?.call(FeedLike.t),
      orderBy: orderBy?.call(FeedLike.t),
      orderByList: orderByList?.call(FeedLike.t),
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [FeedLike] by its [id] or null if no such row exists.
  Future<FeedLike?> findById(
    _is.DatabaseSession session,
    int id, {
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<FeedLike>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [FeedLike]s in the list and returns the inserted rows.
  ///
  /// The returned [FeedLike]s will have their `id` fields set.
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
  Future<List<FeedLike>> insert(
    _is.DatabaseSession session,
    List<FeedLike> rows, {
    _is.Transaction? transaction,
    bool ignoreConflicts = false,
    bool noReturn = false,
  }) async {
    return session.db.insert<FeedLike>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
      noReturn: noReturn,
    );
  }

  /// Inserts a single [FeedLike] and returns the inserted row.
  ///
  /// The returned [FeedLike] will have its `id` field set.
  Future<FeedLike> insertRow(
    _is.DatabaseSession session,
    FeedLike row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.insertRow<FeedLike>(
      row,
      transaction: transaction,
    );
  }

  /// Upserts all [FeedLike]s in the list and returns the resulting rows.
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
  /// The returned [FeedLike]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails,
  /// none of the rows will be affected.
  ///
  /// If [noReturn] is set to `true`, the resulting rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<FeedLike>> upsert(
    _is.DatabaseSession session,
    List<FeedLike> rows, {
    required _is.ColumnSelections<FeedLikeTable> conflictColumns,
    _is.ColumnSelections<FeedLikeTable>? updateColumns,
    _is.WhereExpressionBuilder<FeedLikeTable>? updateWhere,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.upsert<FeedLike>(
      rows,
      conflictColumns: conflictColumns(FeedLike.t),
      updateColumns: updateColumns?.call(FeedLike.t),
      updateWhere: updateWhere?.call(FeedLike.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Upserts a single [FeedLike] and returns the resulting row.
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
  /// The returned [FeedLike] will have its `id` field set.
  Future<FeedLike?> upsertRow(
    _is.DatabaseSession session,
    FeedLike row, {
    required _is.ColumnSelections<FeedLikeTable> conflictColumns,
    _is.ColumnSelections<FeedLikeTable>? updateColumns,
    _is.WhereExpressionBuilder<FeedLikeTable>? updateWhere,
    _is.Transaction? transaction,
  }) async {
    return session.db.upsertRow<FeedLike>(
      row,
      conflictColumns: conflictColumns(FeedLike.t),
      updateColumns: updateColumns?.call(FeedLike.t),
      updateWhere: updateWhere?.call(FeedLike.t),
      transaction: transaction,
    );
  }

  /// Updates all [FeedLike]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<FeedLike>> update(
    _is.DatabaseSession session,
    List<FeedLike> rows, {
    _is.ColumnSelections<FeedLikeTable>? columns,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.update<FeedLike>(
      rows,
      columns: columns?.call(FeedLike.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Updates a single [FeedLike]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<FeedLike> updateRow(
    _is.DatabaseSession session,
    FeedLike row, {
    _is.ColumnSelections<FeedLikeTable>? columns,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateRow<FeedLike>(
      row,
      columns: columns?.call(FeedLike.t),
      transaction: transaction,
    );
  }

  /// Updates a single [FeedLike] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<FeedLike?> updateById(
    _is.DatabaseSession session,
    int id, {
    required _is.ColumnValueListBuilder<FeedLikeUpdateTable> columnValues,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateById<FeedLike>(
      id,
      columnValues: columnValues(FeedLike.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [FeedLike]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<FeedLike>> updateWhere(
    _is.DatabaseSession session, {
    required _is.ColumnValueListBuilder<FeedLikeUpdateTable> columnValues,
    required _is.WhereExpressionBuilder<FeedLikeTable> where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<FeedLikeTable>? orderBy,
    _is.OrderByListBuilder<FeedLikeTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.updateWhere<FeedLike>(
      columnValues: columnValues(FeedLike.t.updateTable),
      where: where(FeedLike.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(FeedLike.t),
      orderByList: orderByList?.call(FeedLike.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes all [FeedLike]s in the list and returns the deleted rows.
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
  Future<List<FeedLike>> delete(
    _is.DatabaseSession session,
    List<FeedLike> rows, {
    _is.OrderByBuilder<FeedLikeTable>? orderBy,
    _is.OrderByListBuilder<FeedLikeTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.delete<FeedLike>(
      rows,
      orderBy: orderBy?.call(FeedLike.t),
      orderByList: orderByList?.call(FeedLike.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes a single [FeedLike].
  Future<FeedLike> deleteRow(
    _is.DatabaseSession session,
    FeedLike row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.deleteRow<FeedLike>(
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
  Future<List<FeedLike>> deleteWhere(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<FeedLikeTable> where,
    _is.OrderByBuilder<FeedLikeTable>? orderBy,
    _is.OrderByListBuilder<FeedLikeTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.deleteWhere<FeedLike>(
      where: where(FeedLike.t),
      orderBy: orderBy?.call(FeedLike.t),
      orderByList: orderByList?.call(FeedLike.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<FeedLikeTable>? where,
    int? limit,
    _is.Transaction? transaction,
  }) async {
    return session.db.count<FeedLike>(
      where: where?.call(FeedLike.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [FeedLike] rows matching the [where] expression.
  Future<void> lockRows(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<FeedLikeTable> where,
    required _is.LockMode lockMode,
    required _is.Transaction transaction,
    _is.LockBehavior lockBehavior = _is.LockBehavior.wait,
  }) async {
    return session.db.lockRows<FeedLike>(
      where: where(FeedLike.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
