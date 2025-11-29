// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'theory_content.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

TheoryContent _$TheoryContentFromJson(Map<String, dynamic> json) {
  return _TheoryContent.fromJson(json);
}

/// @nodoc
mixin _$TheoryContent {
  String get id => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String get videoUrl => throw _privateConstructorUsedError;
  String get type => throw _privateConstructorUsedError;

  /// Serializes this TheoryContent to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of TheoryContent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TheoryContentCopyWith<TheoryContent> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TheoryContentCopyWith<$Res> {
  factory $TheoryContentCopyWith(
          TheoryContent value, $Res Function(TheoryContent) then) =
      _$TheoryContentCopyWithImpl<$Res, TheoryContent>;
  @useResult
  $Res call({String id, String title, String videoUrl, String type});
}

/// @nodoc
class _$TheoryContentCopyWithImpl<$Res, $Val extends TheoryContent>
    implements $TheoryContentCopyWith<$Res> {
  _$TheoryContentCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TheoryContent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? videoUrl = null,
    Object? type = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      videoUrl: null == videoUrl
          ? _value.videoUrl
          : videoUrl // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$TheoryContentImplCopyWith<$Res>
    implements $TheoryContentCopyWith<$Res> {
  factory _$$TheoryContentImplCopyWith(
          _$TheoryContentImpl value, $Res Function(_$TheoryContentImpl) then) =
      __$$TheoryContentImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String id, String title, String videoUrl, String type});
}

/// @nodoc
class __$$TheoryContentImplCopyWithImpl<$Res>
    extends _$TheoryContentCopyWithImpl<$Res, _$TheoryContentImpl>
    implements _$$TheoryContentImplCopyWith<$Res> {
  __$$TheoryContentImplCopyWithImpl(
      _$TheoryContentImpl _value, $Res Function(_$TheoryContentImpl) _then)
      : super(_value, _then);

  /// Create a copy of TheoryContent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? videoUrl = null,
    Object? type = null,
  }) {
    return _then(_$TheoryContentImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      videoUrl: null == videoUrl
          ? _value.videoUrl
          : videoUrl // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$TheoryContentImpl implements _TheoryContent {
  const _$TheoryContentImpl(
      {required this.id,
      required this.title,
      required this.videoUrl,
      required this.type});

  factory _$TheoryContentImpl.fromJson(Map<String, dynamic> json) =>
      _$$TheoryContentImplFromJson(json);

  @override
  final String id;
  @override
  final String title;
  @override
  final String videoUrl;
  @override
  final String type;

  @override
  String toString() {
    return 'TheoryContent(id: $id, title: $title, videoUrl: $videoUrl, type: $type)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TheoryContentImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.videoUrl, videoUrl) ||
                other.videoUrl == videoUrl) &&
            (identical(other.type, type) || other.type == type));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, title, videoUrl, type);

  /// Create a copy of TheoryContent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TheoryContentImplCopyWith<_$TheoryContentImpl> get copyWith =>
      __$$TheoryContentImplCopyWithImpl<_$TheoryContentImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TheoryContentImplToJson(
      this,
    );
  }
}

abstract class _TheoryContent implements TheoryContent {
  const factory _TheoryContent(
      {required final String id,
      required final String title,
      required final String videoUrl,
      required final String type}) = _$TheoryContentImpl;

  factory _TheoryContent.fromJson(Map<String, dynamic> json) =
      _$TheoryContentImpl.fromJson;

  @override
  String get id;
  @override
  String get title;
  @override
  String get videoUrl;
  @override
  String get type;

  /// Create a copy of TheoryContent
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TheoryContentImplCopyWith<_$TheoryContentImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
