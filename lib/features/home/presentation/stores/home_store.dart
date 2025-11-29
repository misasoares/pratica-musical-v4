import 'package:mobx/mobx.dart';
import '../../../content/domain/entities/program.dart';
import '../../../content/domain/repositories/i_content_repository.dart';

part 'home_store.g.dart';

class HomeStore = HomeStoreBase with _$HomeStore;

abstract class HomeStoreBase with Store {
  final IContentRepository _contentRepository;

  HomeStoreBase(this._contentRepository);

  @observable
  Program? program;

  @observable
  bool isLoading = false;

  @observable
  String? errorMessage;

  @action
  Future<void> loadProgram() async {
    isLoading = true;
    errorMessage = null;
    try {
      // Hardcoded ID for now as per instructions
      program = await _contentRepository.getProgram('prog_palhetada_mestre');
    } catch (e) {
      errorMessage = 'Erro ao carregar curso: $e';
    } finally {
      isLoading = false;
    }
  }
}
