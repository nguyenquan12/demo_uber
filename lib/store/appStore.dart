import 'package:mobx/mobx.dart';
// Để tạo code tự động, cần khai báo phần này
part 'appStore.g.dart';

// This is the class used by rest of your codebase
class AppStore = _AppStore with _$AppStore;

abstract class _AppStore with Store {
  @observable
  bool isLoading = false;

  @action
  Future<void> setLoading(bool value) async {
    isLoading = value;
  }
}
