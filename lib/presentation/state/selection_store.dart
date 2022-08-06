import 'package:mobx/mobx.dart';

part 'selection_store.g.dart';

class SelectionStore extends _SelectionStore with _$SelectionStore {
  SelectionStore() : super();
}

abstract class _SelectionStore with Store {
  _SelectionStore();

  @observable
  int itemCount = 0;
  @action
  void setItemCount(int value) {
    itemCount = value;
  }

  @observable
  bool isMultiSelectEnabled = false;

  @observable
  ObservableList<bool> isSelected = ObservableList();

  @computed
  bool get isAllSelected => isSelected.every((e) => e);

  @action
  void toggleMultiSelect() {
    if (!isMultiSelectEnabled) {
      isSelected = List.generate(itemCount, (index) => false).asObservable();
    }
    isMultiSelectEnabled = !isMultiSelectEnabled;
  }

  @action
  void setSelected(bool selected, int index) {
    isSelected[index] = selected;
  }

  @action
  void selectAll() {
    isSelected = List.generate(itemCount, (index) => true).asObservable();
  }

  @action
  void deselectAll() {
    isSelected = List.generate(itemCount, (index) => false).asObservable();
  }

  void dispose() {}
}
