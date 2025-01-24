import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:onix_flutter_mvvm/src/action/action.dart';

abstract class ViewModel extends ChangeNotifier {
  @protected
  final StreamController<ViewModelAction> _actionController =
      StreamController.broadcast();

  @protected
  final StreamController<Exception> _errorController =
      StreamController.broadcast();

  Stream<ViewModelAction> get actionStream => _actionController.stream;

  Stream<Exception> get errorStream => _errorController.stream;

  bool _loading = false;

  bool get loading => _loading;

  void cleanInternalState() {
    _loading = false;
  }

  @protected
  void setError(Exception error) {
    if (!_errorController.isClosed) _errorController.add(error);
  }

  @protected
  void setLoading(
    bool loading, {
    bool autoNotify = true,
  }) {
    _loading = loading;
    if (autoNotify) {
      notifyListeners();
    }
  }

  @protected
  void setAction(ViewModelAction action) {
    if (!_actionController.isClosed) _actionController.add(action);
  }

  @override
  void dispose() {
    _actionController.close();
    return super.dispose();
  }
}
