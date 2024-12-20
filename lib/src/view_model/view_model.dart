import 'package:flutter/foundation.dart';

abstract class ViewModel extends ChangeNotifier {

  Exception? _error;

  bool _loading = false;

  dynamic get error => _error;

  bool get hasError => _error != null;

  bool get loading => _loading;

  void cleanInternalState() {
    _error = null;
    _loading = false;
  }

  @protected
  void setError(Exception error) {
    _error = error;
  }

  @protected
  void setLoading(bool loading) {
    _loading = loading;
  }

}
