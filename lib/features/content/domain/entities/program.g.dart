// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'program.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ProgramImpl _$$ProgramImplFromJson(Map<String, dynamic> json) =>
    _$ProgramImpl(
      id: json['id'] as String,
      title: json['title'] as String,
      modules: (json['modules'] as List<dynamic>)
          .map((e) => Module.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$ProgramImplToJson(_$ProgramImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'modules': instance.modules,
    };
