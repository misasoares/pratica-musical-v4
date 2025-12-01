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
      tags:
          (json['tags'] as List<dynamic>?)?.map((e) => e as String).toList() ??
              const [],
      difficulty: (json['difficulty'] as num?)?.toInt() ?? 1,
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
      'tags': instance.tags,
      'difficulty': instance.difficulty,
      'warmupBpm': instance.warmupBpm,
      'warmupDuration': instance.warmupDuration,
      'startBpmCalibration': instance.startBpmCalibration,
    };
