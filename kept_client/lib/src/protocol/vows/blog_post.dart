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
import 'package:serverpod_client/serverpod_client.dart' as _isc;

/// Editorial habit article shown in the home feed.
abstract class BlogPost
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
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
      publishedAt: _isc.DateTimeJsonExtension.fromJson(
        jsonSerialization['publishedAt'],
      ),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  String slug;

  String title;

  String excerpt;

  String body;

  /// water | habits | focus | sleep | move
  String topic;

  DateTime publishedAt;

  /// Returns a shallow copy of this [BlogPost]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
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

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
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
  @_isc.useResult
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
