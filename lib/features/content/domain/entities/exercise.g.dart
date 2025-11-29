// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'exercise.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ExerciseImpl _$$ExerciseImplFromJson(Map<String, dynamic> json) =>
    _$ExerciseImpl(
      id: json['id'] as String,
      title: json['title'] as String,
      videoUrl: json['videoUrl'] as String,
      tabUrl: json['tabUrl'] as String,
      warmupBpm: (json['warmupBpm'] as num?)?.toInt(),
      warmupDuration: (json['warmupDuration'] as num?)?.toInt(),
      startBpmCalibration: (json['startBpmCalibration'] as num?)?.toInt() ?? 60,
    );

Map<String, dynamic> _$$ExerciseImplToJson(_$ExerciseImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'videoUrl': instance.videoUrl,
      'tabUrl': instance.tabUrl,
      'warmupBpm': instance.warmupBpm,
      'warmupDuration': instance.warmupDuration,
      'startBpmCalibration': instance.startBpmCalibration,
    };
