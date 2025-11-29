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
  Future<Program> getProgram(String programId) async {
    final data = await _loadData();
    // For now, we only have one program in the JSON, so we return it.
    // In a real scenario, we would filter by ID if the JSON had multiple programs.
    if (data.program.id == programId) {
      return data.program;
    }
    // Fallback or error if ID doesn't match, but for this phase we assume it matches
    return data.program;
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
