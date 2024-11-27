import 'package:flutter/foundation.dart';

abstract class ViewModel<T> extends ChangeNotifier {
  ViewModel(T defaultModel) {
    _data = defaultModel;
  }

  late T _data;
  dynamic _error;

  bool _loading = false;

  T get data => _data;

  dynamic get error => _error;

  bool get hasError => _error != null;

  bool get loading => _loading;

  void cleanInternalState() {
    _error = null;
    _loading = false;
  }

  @protected
  void setError(dynamic error) {
    _error = error;
  }

  @protected
  void setLoading(bool loading) {
    _loading = loading;
  }

  @protected
  void setData(T data) {
    _data = data;
  }


}
