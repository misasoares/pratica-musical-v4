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
  Program get program => throw _privateConstructorUsedError;
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
      {Program program,
      @JsonKey(name: 'exercises_db') List<Exercise> exercisesDb});

  $ProgramCopyWith<$Res> get program;
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
    Object? program = null,
    Object? exercisesDb = null,
  }) {
    return _then(_value.copyWith(
      program: null == program
          ? _value.program
          : program // ignore: cast_nullable_to_non_nullable
              as Program,
      exercisesDb: null == exercisesDb
          ? _value.exercisesDb
          : exercisesDb // ignore: cast_nullable_to_non_nullable
              as List<Exercise>,
    ) as $Val);
  }

  /// Create a copy of ContentData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ProgramCopyWith<$Res> get program {
    return $ProgramCopyWith<$Res>(_value.program, (value) {
      return _then(_value.copyWith(program: value) as $Val);
    });
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
      {Program program,
      @JsonKey(name: 'exercises_db') List<Exercise> exercisesDb});

  @override
  $ProgramCopyWith<$Res> get program;
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
    Object? program = null,
    Object? exercisesDb = null,
  }) {
    return _then(_$ContentDataImpl(
      program: null == program
          ? _value.program
          : program // ignore: cast_nullable_to_non_nullable
              as Program,
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
      {required this.program,
      @JsonKey(name: 'exercises_db') required final List<Exercise> exercisesDb})
      : _exercisesDb = exercisesDb;

  factory _$ContentDataImpl.fromJson(Map<String, dynamic> json) =>
      _$$ContentDataImplFromJson(json);

  @override
  final Program program;
  final List<Exercise> _exercisesDb;
  @override
  @JsonKey(name: 'exercises_db')
  List<Exercise> get exercisesDb {
    if (_exercisesDb is EqualUnmodifiableListView) return _exercisesDb;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_exercisesDb);
  }

  @override
  String toString() {
    return 'ContentData(program: $program, exercisesDb: $exercisesDb)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ContentDataImpl &&
            (identical(other.program, program) || other.program == program) &&
            const DeepCollectionEquality()
                .equals(other._exercisesDb, _exercisesDb));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, program, const DeepCollectionEquality().hash(_exercisesDb));

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
      {required final Program program,
      @JsonKey(name: 'exercises_db')
      required final List<Exercise> exercisesDb}) = _$ContentDataImpl;

  factory _ContentData.fromJson(Map<String, dynamic> json) =
      _$ContentDataImpl.fromJson;

  @override
  Program get program;
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
