// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'content_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ContentDataImpl _$$ContentDataImplFromJson(Map<String, dynamic> json) =>
    _$ContentDataImpl(
      program: Program.fromJson(json['program'] as Map<String, dynamic>),
      exercisesDb: (json['exercises_db'] as List<dynamic>)
          .map((e) => Exercise.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$ContentDataImplToJson(_$ContentDataImpl instance) =>
    <String, dynamic>{
      'program': instance.program,
      'exercises_db': instance.exercisesDb,
    };
