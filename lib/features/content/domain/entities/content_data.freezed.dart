// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'content_data.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

ContentData _$ContentDataFromJson(Map<String, dynamic> json) {
  return _ContentData.fromJson(json);
}

/// @nodoc
mixin _$ContentData {
  List<Program> get programs => throw _privateConstructorUsedError;
  @JsonKey(name: 'exercises_db')
  List<Exercise> get exercisesDb => throw _privateConstructorUsedError;

  /// Serializes this ContentData to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ContentData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ContentDataCopyWith<ContentData> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ContentDataCopyWith<$Res> {
  factory $ContentDataCopyWith(
          ContentData value, $Res Function(ContentData) then) =
      _$ContentDataCopyWithImpl<$Res, ContentData>;
  @useResult
  $Res call(
      {List<Program> programs,
      @JsonKey(name: 'exercises_db') List<Exercise> exercisesDb});
}

/// @nodoc
class _$ContentDataCopyWithImpl<$Res, $Val extends ContentData>
    implements $ContentDataCopyWith<$Res> {
  _$ContentDataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ContentData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? programs = null,
    Object? exercisesDb = null,
  }) {
    return _then(_value.copyWith(
      programs: null == programs
          ? _value.programs
          : programs // ignore: cast_nullable_to_non_nullable
              as List<Program>,
      exercisesDb: null == exercisesDb
          ? _value.exercisesDb
          : exercisesDb // ignore: cast_nullable_to_non_nullable
              as List<Exercise>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ContentDataImplCopyWith<$Res>
    implements $ContentDataCopyWith<$Res> {
  factory _$$ContentDataImplCopyWith(
          _$ContentDataImpl value, $Res Function(_$ContentDataImpl) then) =
      __$$ContentDataImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {List<Program> programs,
      @JsonKey(name: 'exercises_db') List<Exercise> exercisesDb});
}

/// @nodoc
class __$$ContentDataImplCopyWithImpl<$Res>
    extends _$ContentDataCopyWithImpl<$Res, _$ContentDataImpl>
    implements _$$ContentDataImplCopyWith<$Res> {
  __$$ContentDataImplCopyWithImpl(
      _$ContentDataImpl _value, $Res Function(_$ContentDataImpl) _then)
      : super(_value, _then);

  /// Create a copy of ContentData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? programs = null,
    Object? exercisesDb = null,
  }) {
    return _then(_$ContentDataImpl(
      programs: null == programs
          ? _value._programs
          : programs // ignore: cast_nullable_to_non_nullable
              as List<Program>,
      exercisesDb: null == exercisesDb
          ? _value._exercisesDb
          : exercisesDb // ignore: cast_nullable_to_non_nullable
              as List<Exercise>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ContentDataImpl implements _ContentData {
  const _$ContentDataImpl(
      {required final List<Program> programs,
      @JsonKey(name: 'exercises_db') required final List<Exercise> exercisesDb})
      : _programs = programs,
        _exercisesDb = exercisesDb;

  factory _$ContentDataImpl.fromJson(Map<String, dynamic> json) =>
      _$$ContentDataImplFromJson(json);

  final List<Program> _programs;
  @override
  List<Program> get programs {
    if (_programs is EqualUnmodifiableListView) return _programs;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_programs);
  }

  final List<Exercise> _exercisesDb;

  @override
  @JsonKey(name: 'exercises_db')
  List<Exercise> get exercisesDb {
    if (_exercisesDb is EqualUnmodifiableListView) return _exercisesDb;
    return EqualUnmodifiableListView(_exercisesDb);
  }

  @override
  String toString() {
    return 'ContentData(programs: $programs, exercisesDb: $exercisesDb)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ContentDataImpl &&
            const DeepCollectionEquality().equals(other._programs, _programs) &&
            const DeepCollectionEquality()
                .equals(other._exercisesDb, _exercisesDb));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_programs),
      const DeepCollectionEquality().hash(_exercisesDb));

  /// Create a copy of ContentData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ContentDataImplCopyWith<_$ContentDataImpl> get copyWith =>
      __$$ContentDataImplCopyWithImpl<_$ContentDataImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ContentDataImplToJson(
      this,
    );
  }
}

abstract class _ContentData implements ContentData {
  const factory _ContentData(
      {required final List<Program> programs,
      @JsonKey(name: 'exercises_db')
      required final List<Exercise> exercisesDb}) = _$ContentDataImpl;

  factory _ContentData.fromJson(Map<String, dynamic> json) =
      _$ContentDataImpl.fromJson;

  @override
  List<Program> get programs;
  @override
  @JsonKey(name: 'exercises_db')
  List<Exercise> get exercisesDb;

  /// Create a copy of ContentData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ContentDataImplCopyWith<_$ContentDataImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
