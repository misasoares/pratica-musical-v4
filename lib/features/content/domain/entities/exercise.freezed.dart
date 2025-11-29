// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'exercise.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Exercise _$ExerciseFromJson(Map<String, dynamic> json) {
  return _Exercise.fromJson(json);
}

/// @nodoc
mixin _$Exercise {
  String get id => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String get videoUrl => throw _privateConstructorUsedError;
  String get tabUrl => throw _privateConstructorUsedError;
  int? get warmupBpm => throw _privateConstructorUsedError;
  int? get warmupDuration => throw _privateConstructorUsedError;
  int get startBpmCalibration => throw _privateConstructorUsedError;

  /// Serializes this Exercise to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Exercise
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ExerciseCopyWith<Exercise> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ExerciseCopyWith<$Res> {
  factory $ExerciseCopyWith(Exercise value, $Res Function(Exercise) then) =
      _$ExerciseCopyWithImpl<$Res, Exercise>;
  @useResult
  $Res call(
      {String id,
      String title,
      String videoUrl,
      String tabUrl,
      int? warmupBpm,
      int? warmupDuration,
      int startBpmCalibration});
}

/// @nodoc
class _$ExerciseCopyWithImpl<$Res, $Val extends Exercise>
    implements $ExerciseCopyWith<$Res> {
  _$ExerciseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Exercise
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? videoUrl = null,
    Object? tabUrl = null,
    Object? warmupBpm = freezed,
    Object? warmupDuration = freezed,
    Object? startBpmCalibration = null,
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
      tabUrl: null == tabUrl
          ? _value.tabUrl
          : tabUrl // ignore: cast_nullable_to_non_nullable
              as String,
      warmupBpm: freezed == warmupBpm
          ? _value.warmupBpm
          : warmupBpm // ignore: cast_nullable_to_non_nullable
              as int?,
      warmupDuration: freezed == warmupDuration
          ? _value.warmupDuration
          : warmupDuration // ignore: cast_nullable_to_non_nullable
              as int?,
      startBpmCalibration: null == startBpmCalibration
          ? _value.startBpmCalibration
          : startBpmCalibration // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ExerciseImplCopyWith<$Res>
    implements $ExerciseCopyWith<$Res> {
  factory _$$ExerciseImplCopyWith(
          _$ExerciseImpl value, $Res Function(_$ExerciseImpl) then) =
      __$$ExerciseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String title,
      String videoUrl,
      String tabUrl,
      int? warmupBpm,
      int? warmupDuration,
      int startBpmCalibration});
}

/// @nodoc
class __$$ExerciseImplCopyWithImpl<$Res>
    extends _$ExerciseCopyWithImpl<$Res, _$ExerciseImpl>
    implements _$$ExerciseImplCopyWith<$Res> {
  __$$ExerciseImplCopyWithImpl(
      _$ExerciseImpl _value, $Res Function(_$ExerciseImpl) _then)
      : super(_value, _then);

  /// Create a copy of Exercise
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? videoUrl = null,
    Object? tabUrl = null,
    Object? warmupBpm = freezed,
    Object? warmupDuration = freezed,
    Object? startBpmCalibration = null,
  }) {
    return _then(_$ExerciseImpl(
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
      tabUrl: null == tabUrl
          ? _value.tabUrl
          : tabUrl // ignore: cast_nullable_to_non_nullable
              as String,
      warmupBpm: freezed == warmupBpm
          ? _value.warmupBpm
          : warmupBpm // ignore: cast_nullable_to_non_nullable
              as int?,
      warmupDuration: freezed == warmupDuration
          ? _value.warmupDuration
          : warmupDuration // ignore: cast_nullable_to_non_nullable
              as int?,
      startBpmCalibration: null == startBpmCalibration
          ? _value.startBpmCalibration
          : startBpmCalibration // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ExerciseImpl implements _Exercise {
  const _$ExerciseImpl(
      {required this.id,
      required this.title,
      required this.videoUrl,
      required this.tabUrl,
      this.warmupBpm,
      this.warmupDuration,
      this.startBpmCalibration = 60});

  factory _$ExerciseImpl.fromJson(Map<String, dynamic> json) =>
      _$$ExerciseImplFromJson(json);

  @override
  final String id;
  @override
  final String title;
  @override
  final String videoUrl;
  @override
  final String tabUrl;
  @override
  final int? warmupBpm;
  @override
  final int? warmupDuration;
  @override
  @JsonKey()
  final int startBpmCalibration;

  @override
  String toString() {
    return 'Exercise(id: $id, title: $title, videoUrl: $videoUrl, tabUrl: $tabUrl, warmupBpm: $warmupBpm, warmupDuration: $warmupDuration, startBpmCalibration: $startBpmCalibration)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ExerciseImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.videoUrl, videoUrl) ||
                other.videoUrl == videoUrl) &&
            (identical(other.tabUrl, tabUrl) || other.tabUrl == tabUrl) &&
            (identical(other.warmupBpm, warmupBpm) ||
                other.warmupBpm == warmupBpm) &&
            (identical(other.warmupDuration, warmupDuration) ||
                other.warmupDuration == warmupDuration) &&
            (identical(other.startBpmCalibration, startBpmCalibration) ||
                other.startBpmCalibration == startBpmCalibration));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, title, videoUrl, tabUrl,
      warmupBpm, warmupDuration, startBpmCalibration);

  /// Create a copy of Exercise
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ExerciseImplCopyWith<_$ExerciseImpl> get copyWith =>
      __$$ExerciseImplCopyWithImpl<_$ExerciseImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ExerciseImplToJson(
      this,
    );
  }
}

abstract class _Exercise implements Exercise {
  const factory _Exercise(
      {required final String id,
      required final String title,
      required final String videoUrl,
      required final String tabUrl,
      final int? warmupBpm,
      final int? warmupDuration,
      final int startBpmCalibration}) = _$ExerciseImpl;

  factory _Exercise.fromJson(Map<String, dynamic> json) =
      _$ExerciseImpl.fromJson;

  @override
  String get id;
  @override
  String get title;
  @override
  String get videoUrl;
  @override
  String get tabUrl;
  @override
  int? get warmupBpm;
  @override
  int? get warmupDuration;
  @override
  int get startBpmCalibration;

  /// Create a copy of Exercise
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ExerciseImplCopyWith<_$ExerciseImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
