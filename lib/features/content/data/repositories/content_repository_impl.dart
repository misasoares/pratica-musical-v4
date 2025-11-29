import 'dart:convert';
import 'package:flutter/services.dart';
import '../../domain/repositories/i_content_repository.dart';
import '../../domain/entities/program.dart';
import '../../domain/entities/exercise.dart';
import '../../domain/entities/content_data.dart';

class ContentRepositoryImpl implements IContentRepository {
  ContentData? _cachedData;

  Future<ContentData> _loadData() async {
    if (_cachedData != null) return _cachedData!;

    final jsonString =
        await rootBundle.loadString('assets/data/initial_content.json');
    final jsonMap = json.decode(jsonString);
    _cachedData = ContentData.fromJson(jsonMap);
    return _cachedData!;
  }

  @override
  Future<List<Program>> getPrograms() async {
    final data = await _loadData();
    return data.programs;
  }

  @override
  Future<Program> getProgram(String programId) async {
    final data = await _loadData();
    try {
      return data.programs.firstWhere((p) => p.id == programId);
    } catch (e) {
      // Fallback to first program if not found, or rethrow
      if (data.programs.isNotEmpty) {
        return data.programs.first;
      }
      throw Exception('Program not found: $programId');
    }
  }

  @override
  Future<Exercise?> getExercise(String exerciseId) async {
    final data = await _loadData();
    try {
      return data.exercisesDb.firstWhere((e) => e.id == exerciseId);
    } catch (e) {
      return null;
    }
  }
}
