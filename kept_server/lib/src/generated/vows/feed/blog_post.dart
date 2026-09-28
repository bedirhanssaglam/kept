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

/// Editorial habit article shown in the home feed.
abstract class BlogPost
    implements _is.TableRow<int?>, _is.ProtocolSerialization {
  BlogPost._({
    this.id,
    required this.slug,
    required this.title,
    required this.excerpt,
    required this.body,
    required this.topic,
    required this.publishedAt,
  });

  factory BlogPost({
    int? id,
    required String slug,
    required String title,
    required String excerpt,
    required String body,
    required String topic,
    required DateTime publishedAt,
  }) = _BlogPostImpl;

  factory BlogPost.fromJson(Map<String, dynamic> jsonSerialization) {
    return BlogPost(
      id: jsonSerialization['id'] as int?,
      slug: jsonSerialization['slug'] as String,
      title: jsonSerialization['title'] as String,
      excerpt: jsonSerialization['excerpt'] as String,
      body: jsonSerialization['body'] as String,
      topic: jsonSerialization['topic'] as String,
      publishedAt: _is.DateTimeJsonExtension.fromJson(
        jsonSerialization['publishedAt'],
      ),
    );
  }

  static final t = BlogPostTable();

  static const db = BlogPostRepository._();

  @override
  int? id;

  String slug;

  String title;

  String excerpt;

  String body;

  /// water | habits | focus | sleep | move
  String topic;

  DateTime publishedAt;

  @override
  _is.Table<int?> get table => t;

  /// Returns a shallow copy of this [BlogPost]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  BlogPost copyWith({
    int? id,
    String? slug,
    String? title,
    String? excerpt,
    String? body,
    String? topic,
    DateTime? publishedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'BlogPost',
      if (id != null) 'id': id,
      'slug': slug,
      'title': title,
      'excerpt': excerpt,
      'body': body,
      'topic': topic,
      'publishedAt': publishedAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'BlogPost',
      if (id != null) 'id': id,
      'slug': slug,
      'title': title,
      'excerpt': excerpt,
      'body': body,
      'topic': topic,
      'publishedAt': publishedAt.toJson(),
    };
  }

  static BlogPostInclude include() {
    return BlogPostInclude._();
  }

  static BlogPostIncludeList includeList({
    _is.WhereExpressionBuilder<BlogPostTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<BlogPostTable>? orderBy,
    _is.OrderByListBuilder<BlogPostTable>? orderByList,
    BlogPostInclude? include,
  }) {
    return BlogPostIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(BlogPost.t),
      orderByList: orderByList?.call(BlogPost.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _BlogPostImpl extends BlogPost {
  _BlogPostImpl({
    int? id,
    required String slug,
    required String title,
    required String excerpt,
    required String body,
    required String topic,
    required DateTime publishedAt,
  }) : super._(
         id: id,
         slug: slug,
         title: title,
         excerpt: excerpt,
         body: body,
         topic: topic,
         publishedAt: publishedAt,
       );

  /// Returns a shallow copy of this [BlogPost]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  BlogPost copyWith({
    Object? id = _Undefined,
    String? slug,
    String? title,
    String? excerpt,
    String? body,
    String? topic,
    DateTime? publishedAt,
  }) {
    return BlogPost(
      id: id is int? ? id : this.id,
      slug: slug ?? this.slug,
      title: title ?? this.title,
      excerpt: excerpt ?? this.excerpt,
      body: body ?? this.body,
      topic: topic ?? this.topic,
      publishedAt: publishedAt ?? this.publishedAt,
    );
  }
}

class BlogPostUpdateTable extends _is.UpdateTable<BlogPostTable> {
  BlogPostUpdateTable(super.table);

  _is.ColumnValue<String, String> slug(String value) => _is.ColumnValue(
    table.slug,
    value,
  );

  _is.ColumnValue<String, String> title(String value) => _is.ColumnValue(
    table.title,
    value,
  );

  _is.ColumnValue<String, String> excerpt(String value) => _is.ColumnValue(
    table.excerpt,
    value,
  );

  _is.ColumnValue<String, String> body(String value) => _is.ColumnValue(
    table.body,
    value,
  );

  _is.ColumnValue<String, String> topic(String value) => _is.ColumnValue(
    table.topic,
    value,
  );

  _is.ColumnValue<DateTime, DateTime> publishedAt(DateTime value) =>
      _is.ColumnValue(
        table.publishedAt,
        value,
      );
}

class BlogPostTable extends _is.Table<int?> {
  BlogPostTable({super.tableRelation}) : super(tableName: 'blog_post') {
    updateTable = BlogPostUpdateTable(this);
    slug = _is.ColumnString(
      'slug',
      this,
    );
    title = _is.ColumnString(
      'title',
      this,
    );
    excerpt = _is.ColumnString(
      'excerpt',
      this,
    );
    body = _is.ColumnString(
      'body',
      this,
    );
    topic = _is.ColumnString(
      'topic',
      this,
    );
    publishedAt = _is.ColumnDateTime(
      'publishedAt',
      this,
    );
  }

  late final BlogPostUpdateTable updateTable;

  late final _is.ColumnString slug;

  late final _is.ColumnString title;

  late final _is.ColumnString excerpt;

  late final _is.ColumnString body;

  /// water | habits | focus | sleep | move
  late final _is.ColumnString topic;

  late final _is.ColumnDateTime publishedAt;

  @override
  List<_is.Column> get columns => [
    id,
    slug,
    title,
    excerpt,
    body,
    topic,
    publishedAt,
  ];
}

class BlogPostInclude extends _is.IncludeObject {
  BlogPostInclude._();

  @override
  Map<String, _is.Include?> get includes => {};

  @override
  _is.Table<int?> get table => BlogPost.t;
}

class BlogPostIncludeList extends _is.IncludeList {
  BlogPostIncludeList._({
    _is.WhereExpressionBuilder<BlogPostTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(BlogPost.t);
  }

  @override
  Map<String, _is.Include?> get includes => include?.includes ?? {};

  @override
  _is.Table<int?> get table => BlogPost.t;
}

class BlogPostRepository {
  const BlogPostRepository._();

  /// Returns a list of [BlogPost]s matching the given query parameters.
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
  Future<List<BlogPost>> find(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<BlogPostTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<BlogPostTable>? orderBy,
    _is.OrderByListBuilder<BlogPostTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<BlogPost>(
      where: where?.call(BlogPost.t),
      orderBy: orderBy?.call(BlogPost.t),
      orderByList: orderByList?.call(BlogPost.t),
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [BlogPost] matching the given query parameters.
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
  Future<BlogPost?> findFirstRow(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<BlogPostTable>? where,
    int? offset,
    _is.OrderByBuilder<BlogPostTable>? orderBy,
    _is.OrderByListBuilder<BlogPostTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<BlogPost>(
      where: where?.call(BlogPost.t),
      orderBy: orderBy?.call(BlogPost.t),
      orderByList: orderByList?.call(BlogPost.t),
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [BlogPost] by its [id] or null if no such row exists.
  Future<BlogPost?> findById(
    _is.DatabaseSession session,
    int id, {
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<BlogPost>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [BlogPost]s in the list and returns the inserted rows.
  ///
  /// The returned [BlogPost]s will have their `id` fields set.
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
  Future<List<BlogPost>> insert(
    _is.DatabaseSession session,
    List<BlogPost> rows, {
    _is.Transaction? transaction,
    bool ignoreConflicts = false,
    bool noReturn = false,
  }) async {
    return session.db.insert<BlogPost>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
      noReturn: noReturn,
    );
  }

  /// Inserts a single [BlogPost] and returns the inserted row.
  ///
  /// The returned [BlogPost] will have its `id` field set.
  Future<BlogPost> insertRow(
    _is.DatabaseSession session,
    BlogPost row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.insertRow<BlogPost>(
      row,
      transaction: transaction,
    );
  }

  /// Upserts all [BlogPost]s in the list and returns the resulting rows.
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
  /// The returned [BlogPost]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails,
  /// none of the rows will be affected.
  ///
  /// If [noReturn] is set to `true`, the resulting rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<BlogPost>> upsert(
    _is.DatabaseSession session,
    List<BlogPost> rows, {
    required _is.ColumnSelections<BlogPostTable> conflictColumns,
    _is.ColumnSelections<BlogPostTable>? updateColumns,
    _is.WhereExpressionBuilder<BlogPostTable>? updateWhere,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.upsert<BlogPost>(
      rows,
      conflictColumns: conflictColumns(BlogPost.t),
      updateColumns: updateColumns?.call(BlogPost.t),
      updateWhere: updateWhere?.call(BlogPost.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Upserts a single [BlogPost] and returns the resulting row.
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
  /// The returned [BlogPost] will have its `id` field set.
  Future<BlogPost?> upsertRow(
    _is.DatabaseSession session,
    BlogPost row, {
    required _is.ColumnSelections<BlogPostTable> conflictColumns,
    _is.ColumnSelections<BlogPostTable>? updateColumns,
    _is.WhereExpressionBuilder<BlogPostTable>? updateWhere,
    _is.Transaction? transaction,
  }) async {
    return session.db.upsertRow<BlogPost>(
      row,
      conflictColumns: conflictColumns(BlogPost.t),
      updateColumns: updateColumns?.call(BlogPost.t),
      updateWhere: updateWhere?.call(BlogPost.t),
      transaction: transaction,
    );
  }

  /// Updates all [BlogPost]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<BlogPost>> update(
    _is.DatabaseSession session,
    List<BlogPost> rows, {
    _is.ColumnSelections<BlogPostTable>? columns,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.update<BlogPost>(
      rows,
      columns: columns?.call(BlogPost.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Updates a single [BlogPost]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<BlogPost> updateRow(
    _is.DatabaseSession session,
    BlogPost row, {
    _is.ColumnSelections<BlogPostTable>? columns,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateRow<BlogPost>(
      row,
      columns: columns?.call(BlogPost.t),
      transaction: transaction,
    );
  }

  /// Updates a single [BlogPost] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<BlogPost?> updateById(
    _is.DatabaseSession session,
    int id, {
    required _is.ColumnValueListBuilder<BlogPostUpdateTable> columnValues,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateById<BlogPost>(
      id,
      columnValues: columnValues(BlogPost.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [BlogPost]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<BlogPost>> updateWhere(
    _is.DatabaseSession session, {
    required _is.ColumnValueListBuilder<BlogPostUpdateTable> columnValues,
    required _is.WhereExpressionBuilder<BlogPostTable> where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<BlogPostTable>? orderBy,
    _is.OrderByListBuilder<BlogPostTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.updateWhere<BlogPost>(
      columnValues: columnValues(BlogPost.t.updateTable),
      where: where(BlogPost.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(BlogPost.t),
      orderByList: orderByList?.call(BlogPost.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes all [BlogPost]s in the list and returns the deleted rows.
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
  Future<List<BlogPost>> delete(
    _is.DatabaseSession session,
    List<BlogPost> rows, {
    _is.OrderByBuilder<BlogPostTable>? orderBy,
    _is.OrderByListBuilder<BlogPostTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.delete<BlogPost>(
      rows,
      orderBy: orderBy?.call(BlogPost.t),
      orderByList: orderByList?.call(BlogPost.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes a single [BlogPost].
  Future<BlogPost> deleteRow(
    _is.DatabaseSession session,
    BlogPost row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.deleteRow<BlogPost>(
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
  Future<List<BlogPost>> deleteWhere(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<BlogPostTable> where,
    _is.OrderByBuilder<BlogPostTable>? orderBy,
    _is.OrderByListBuilder<BlogPostTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.deleteWhere<BlogPost>(
      where: where(BlogPost.t),
      orderBy: orderBy?.call(BlogPost.t),
      orderByList: orderByList?.call(BlogPost.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<BlogPostTable>? where,
    int? limit,
    _is.Transaction? transaction,
  }) async {
    return session.db.count<BlogPost>(
      where: where?.call(BlogPost.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [BlogPost] rows matching the [where] expression.
  Future<void> lockRows(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<BlogPostTable> where,
    required _is.LockMode lockMode,
    required _is.Transaction transaction,
    _is.LockBehavior lockBehavior = _is.LockBehavior.wait,
  }) async {
    return session.db.lockRows<BlogPost>(
      where: where(BlogPost.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
