// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'content_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ContentDataImpl _$$ContentDataImplFromJson(Map<String, dynamic> json) =>
    _$ContentDataImpl(
      programs: (json['programs'] as List<dynamic>)
          .map((e) => Program.fromJson(e as Map<String, dynamic>))
          .toList(),
      exercisesDb: (json['exercises_db'] as List<dynamic>)
          .map((e) => Exercise.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$ContentDataImplToJson(_$ContentDataImpl instance) =>
    <String, dynamic>{
      'programs': instance.programs,
      'exercises_db': instance.exercisesDb,
    };
