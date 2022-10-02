import 'package:mobx/mobx.dart';

import 'audio_store.dart';

part 'queue_page_store.g.dart';

class QueuePageStore extends _QueuePageStore with _$QueuePageStore {
  QueuePageStore({
    required AudioStore audioStore,
  }) : super(audioStore);
}

abstract class _QueuePageStore with Store {
  _QueuePageStore(
    this._audioStore,
  ) {
    reset();
  }

  final AudioStore _audioStore;

  @observable
  bool isMultiSelectEnabled = false;

  @observable
  ObservableList<bool> isSelected = ObservableList();

  @computed
  bool get isAllSelected => isSelected.every((e) => e);

  @action
  void reset() {
    isSelected = List.generate(_audioStore.queue.length, (index) => false).asObservable();
    isMultiSelectEnabled = false;
  }

  @action
  void toggleMultiSelect() {
    if (!isMultiSelectEnabled) {
      isSelected = List.generate(_audioStore.queue.length, (index) => false).asObservable();
    }
    isMultiSelectEnabled = !isMultiSelectEnabled;
  }

  @action
  void setSelected(bool selected, int index) {
    isSelected[index] = selected;
  }

  @action
  void selectAll() {
    isSelected = List.generate(_audioStore.queue.length, (index) => true).asObservable();
  }

  @action
  void deselectAll() {
    isSelected = List.generate(_audioStore.queue.length, (index) => false).asObservable();
  }

  void dispose() {}
}
