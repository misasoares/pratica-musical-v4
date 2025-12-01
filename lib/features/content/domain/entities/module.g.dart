// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'module.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ModuleImpl _$$ModuleImplFromJson(Map<String, dynamic> json) => _$ModuleImpl(
      id: json['id'] as String,
      title: json['title'] as String,
      type: json['type'] as String,
      order: (json['order'] as num).toInt(),
      schedules: (json['schedules'] as List<dynamic>?)
          ?.map((e) => Schedule.fromJson(e as Map<String, dynamic>))
          .toList(),
      contents: (json['contents'] as List<dynamic>?)
          ?.map((e) => TheoryContent.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$ModuleImplToJson(_$ModuleImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'type': instance.type,
      'order': instance.order,
      'schedules': instance.schedules,
      'contents': instance.contents,
    };
