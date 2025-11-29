import 'package:mobx/mobx.dart';
import '../../../content/domain/entities/program.dart';
import '../../../content/domain/repositories/i_content_repository.dart';

part 'home_store.g.dart';

class HomeStore = HomeStoreBase with _$HomeStore;

abstract class HomeStoreBase with Store {
  final IContentRepository _contentRepository;

  HomeStoreBase(this._contentRepository);

  @observable
  List<Program> programs = [];

  @observable
  Program? program;

  @observable
  bool isLoading = false;

  @observable
  String? errorMessage;

  @action
  Future<void> loadPrograms() async {
    isLoading = true;
    errorMessage = null;
    try {
      programs = await _contentRepository.getPrograms();
    } catch (e) {
      errorMessage = 'Erro ao carregar cursos: $e';
    } finally {
      isLoading = false;
    }
  }

  @action
  Future<void> loadProgram(String programId) async {
    isLoading = true;
    errorMessage = null;
    try {
      program = await _contentRepository.getProgram(programId);
    } catch (e) {
      errorMessage = 'Erro ao carregar curso: $e';
    } finally {
      isLoading = false;
    }
  }
}
