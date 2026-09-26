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

/// A comment on a home-feed target (activity message or article).
abstract class FeedComment
    implements _is.TableRow<int?>, _is.ProtocolSerialization {
  FeedComment._({
    this.id,
    required this.userId,
    required this.displayName,
    required this.targetType,
    required this.targetId,
    required this.body,
    required this.createdAt,
  });

  factory FeedComment({
    int? id,
    required String userId,
    required String displayName,
    required String targetType,
    required int targetId,
    required String body,
    required DateTime createdAt,
  }) = _FeedCommentImpl;

  factory FeedComment.fromJson(Map<String, dynamic> jsonSerialization) {
    return FeedComment(
      id: jsonSerialization['id'] as int?,
      userId: jsonSerialization['userId'] as String,
      displayName: jsonSerialization['displayName'] as String,
      targetType: jsonSerialization['targetType'] as String,
      targetId: jsonSerialization['targetId'] as int,
      body: jsonSerialization['body'] as String,
      createdAt: _is.DateTimeJsonExtension.fromJson(
        jsonSerialization['createdAt'],
      ),
    );
  }

  static final t = FeedCommentTable();

  static const db = FeedCommentRepository._();

  @override
  int? id;

  String userId;

  String displayName;

  /// message | article
  String targetType;

  int targetId;

  String body;

  DateTime createdAt;

  @override
  _is.Table<int?> get table => t;

  /// Returns a shallow copy of this [FeedComment]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  FeedComment copyWith({
    int? id,
    String? userId,
    String? displayName,
    String? targetType,
    int? targetId,
    String? body,
    DateTime? createdAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'FeedComment',
      if (id != null) 'id': id,
      'userId': userId,
      'displayName': displayName,
      'targetType': targetType,
      'targetId': targetId,
      'body': body,
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'FeedComment',
      if (id != null) 'id': id,
      'userId': userId,
      'displayName': displayName,
      'targetType': targetType,
      'targetId': targetId,
      'body': body,
      'createdAt': createdAt.toJson(),
    };
  }

  static FeedCommentInclude include() {
    return FeedCommentInclude._();
  }

  static FeedCommentIncludeList includeList({
    _is.WhereExpressionBuilder<FeedCommentTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<FeedCommentTable>? orderBy,
    _is.OrderByListBuilder<FeedCommentTable>? orderByList,
    FeedCommentInclude? include,
  }) {
    return FeedCommentIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(FeedComment.t),
      orderByList: orderByList?.call(FeedComment.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _FeedCommentImpl extends FeedComment {
  _FeedCommentImpl({
    int? id,
    required String userId,
    required String displayName,
    required String targetType,
    required int targetId,
    required String body,
    required DateTime createdAt,
  }) : super._(
         id: id,
         userId: userId,
         displayName: displayName,
         targetType: targetType,
         targetId: targetId,
         body: body,
         createdAt: createdAt,
       );

  /// Returns a shallow copy of this [FeedComment]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  FeedComment copyWith({
    Object? id = _Undefined,
    String? userId,
    String? displayName,
    String? targetType,
    int? targetId,
    String? body,
    DateTime? createdAt,
  }) {
    return FeedComment(
      id: id is int? ? id : this.id,
      userId: userId ?? this.userId,
      displayName: displayName ?? this.displayName,
      targetType: targetType ?? this.targetType,
      targetId: targetId ?? this.targetId,
      body: body ?? this.body,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}

class FeedCommentUpdateTable extends _is.UpdateTable<FeedCommentTable> {
  FeedCommentUpdateTable(super.table);

  _is.ColumnValue<String, String> userId(String value) => _is.ColumnValue(
    table.userId,
    value,
  );

  _is.ColumnValue<String, String> displayName(String value) => _is.ColumnValue(
    table.displayName,
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

  _is.ColumnValue<String, String> body(String value) => _is.ColumnValue(
    table.body,
    value,
  );

  _is.ColumnValue<DateTime, DateTime> createdAt(DateTime value) =>
      _is.ColumnValue(
        table.createdAt,
        value,
      );
}

class FeedCommentTable extends _is.Table<int?> {
  FeedCommentTable({super.tableRelation}) : super(tableName: 'feed_comment') {
    updateTable = FeedCommentUpdateTable(this);
    userId = _is.ColumnString(
      'userId',
      this,
    );
    displayName = _is.ColumnString(
      'displayName',
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
    body = _is.ColumnString(
      'body',
      this,
    );
    createdAt = _is.ColumnDateTime(
      'createdAt',
      this,
    );
  }

  late final FeedCommentUpdateTable updateTable;

  late final _is.ColumnString userId;

  late final _is.ColumnString displayName;

  /// message | article
  late final _is.ColumnString targetType;

  late final _is.ColumnInt targetId;

  late final _is.ColumnString body;

  late final _is.ColumnDateTime createdAt;

  @override
  List<_is.Column> get columns => [
    id,
    userId,
    displayName,
    targetType,
    targetId,
    body,
    createdAt,
  ];
}

class FeedCommentInclude extends _is.IncludeObject {
  FeedCommentInclude._();

  @override
  Map<String, _is.Include?> get includes => {};

  @override
  _is.Table<int?> get table => FeedComment.t;
}

class FeedCommentIncludeList extends _is.IncludeList {
  FeedCommentIncludeList._({
    _is.WhereExpressionBuilder<FeedCommentTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(FeedComment.t);
  }

  @override
  Map<String, _is.Include?> get includes => include?.includes ?? {};

  @override
  _is.Table<int?> get table => FeedComment.t;
}

class FeedCommentRepository {
  const FeedCommentRepository._();

  /// Returns a list of [FeedComment]s matching the given query parameters.
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
  Future<List<FeedComment>> find(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<FeedCommentTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<FeedCommentTable>? orderBy,
    _is.OrderByListBuilder<FeedCommentTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<FeedComment>(
      where: where?.call(FeedComment.t),
      orderBy: orderBy?.call(FeedComment.t),
      orderByList: orderByList?.call(FeedComment.t),
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [FeedComment] matching the given query parameters.
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
  Future<FeedComment?> findFirstRow(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<FeedCommentTable>? where,
    int? offset,
    _is.OrderByBuilder<FeedCommentTable>? orderBy,
    _is.OrderByListBuilder<FeedCommentTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<FeedComment>(
      where: where?.call(FeedComment.t),
      orderBy: orderBy?.call(FeedComment.t),
      orderByList: orderByList?.call(FeedComment.t),
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [FeedComment] by its [id] or null if no such row exists.
  Future<FeedComment?> findById(
    _is.DatabaseSession session,
    int id, {
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<FeedComment>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [FeedComment]s in the list and returns the inserted rows.
  ///
  /// The returned [FeedComment]s will have their `id` fields set.
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
  Future<List<FeedComment>> insert(
    _is.DatabaseSession session,
    List<FeedComment> rows, {
    _is.Transaction? transaction,
    bool ignoreConflicts = false,
    bool noReturn = false,
  }) async {
    return session.db.insert<FeedComment>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
      noReturn: noReturn,
    );
  }

  /// Inserts a single [FeedComment] and returns the inserted row.
  ///
  /// The returned [FeedComment] will have its `id` field set.
  Future<FeedComment> insertRow(
    _is.DatabaseSession session,
    FeedComment row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.insertRow<FeedComment>(
      row,
      transaction: transaction,
    );
  }

  /// Upserts all [FeedComment]s in the list and returns the resulting rows.
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
  /// The returned [FeedComment]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails,
  /// none of the rows will be affected.
  ///
  /// If [noReturn] is set to `true`, the resulting rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<FeedComment>> upsert(
    _is.DatabaseSession session,
    List<FeedComment> rows, {
    required _is.ColumnSelections<FeedCommentTable> conflictColumns,
    _is.ColumnSelections<FeedCommentTable>? updateColumns,
    _is.WhereExpressionBuilder<FeedCommentTable>? updateWhere,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.upsert<FeedComment>(
      rows,
      conflictColumns: conflictColumns(FeedComment.t),
      updateColumns: updateColumns?.call(FeedComment.t),
      updateWhere: updateWhere?.call(FeedComment.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Upserts a single [FeedComment] and returns the resulting row.
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
  /// The returned [FeedComment] will have its `id` field set.
  Future<FeedComment?> upsertRow(
    _is.DatabaseSession session,
    FeedComment row, {
    required _is.ColumnSelections<FeedCommentTable> conflictColumns,
    _is.ColumnSelections<FeedCommentTable>? updateColumns,
    _is.WhereExpressionBuilder<FeedCommentTable>? updateWhere,
    _is.Transaction? transaction,
  }) async {
    return session.db.upsertRow<FeedComment>(
      row,
      conflictColumns: conflictColumns(FeedComment.t),
      updateColumns: updateColumns?.call(FeedComment.t),
      updateWhere: updateWhere?.call(FeedComment.t),
      transaction: transaction,
    );
  }

  /// Updates all [FeedComment]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<FeedComment>> update(
    _is.DatabaseSession session,
    List<FeedComment> rows, {
    _is.ColumnSelections<FeedCommentTable>? columns,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.update<FeedComment>(
      rows,
      columns: columns?.call(FeedComment.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Updates a single [FeedComment]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<FeedComment> updateRow(
    _is.DatabaseSession session,
    FeedComment row, {
    _is.ColumnSelections<FeedCommentTable>? columns,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateRow<FeedComment>(
      row,
      columns: columns?.call(FeedComment.t),
      transaction: transaction,
    );
  }

  /// Updates a single [FeedComment] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<FeedComment?> updateById(
    _is.DatabaseSession session,
    int id, {
    required _is.ColumnValueListBuilder<FeedCommentUpdateTable> columnValues,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateById<FeedComment>(
      id,
      columnValues: columnValues(FeedComment.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [FeedComment]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<FeedComment>> updateWhere(
    _is.DatabaseSession session, {
    required _is.ColumnValueListBuilder<FeedCommentUpdateTable> columnValues,
    required _is.WhereExpressionBuilder<FeedCommentTable> where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<FeedCommentTable>? orderBy,
    _is.OrderByListBuilder<FeedCommentTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.updateWhere<FeedComment>(
      columnValues: columnValues(FeedComment.t.updateTable),
      where: where(FeedComment.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(FeedComment.t),
      orderByList: orderByList?.call(FeedComment.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes all [FeedComment]s in the list and returns the deleted rows.
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
  Future<List<FeedComment>> delete(
    _is.DatabaseSession session,
    List<FeedComment> rows, {
    _is.OrderByBuilder<FeedCommentTable>? orderBy,
    _is.OrderByListBuilder<FeedCommentTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.delete<FeedComment>(
      rows,
      orderBy: orderBy?.call(FeedComment.t),
      orderByList: orderByList?.call(FeedComment.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes a single [FeedComment].
  Future<FeedComment> deleteRow(
    _is.DatabaseSession session,
    FeedComment row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.deleteRow<FeedComment>(
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
  Future<List<FeedComment>> deleteWhere(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<FeedCommentTable> where,
    _is.OrderByBuilder<FeedCommentTable>? orderBy,
    _is.OrderByListBuilder<FeedCommentTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.deleteWhere<FeedComment>(
      where: where(FeedComment.t),
      orderBy: orderBy?.call(FeedComment.t),
      orderByList: orderByList?.call(FeedComment.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<FeedCommentTable>? where,
    int? limit,
    _is.Transaction? transaction,
  }) async {
    return session.db.count<FeedComment>(
      where: where?.call(FeedComment.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [FeedComment] rows matching the [where] expression.
  Future<void> lockRows(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<FeedCommentTable> where,
    required _is.LockMode lockMode,
    required _is.Transaction transaction,
    _is.LockBehavior lockBehavior = _is.LockBehavior.wait,
  }) async {
    return session.db.lockRows<FeedComment>(
      where: where(FeedComment.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
