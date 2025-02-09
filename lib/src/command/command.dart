import 'package:flutter/foundation.dart';
import 'package:onix_flutter_core_models/onix_flutter_core_models.dart';

typedef CommandAction0<T> = Future<Result<T>> Function();
typedef CommandAction1<T, A> = Future<Result<T>> Function(A);
typedef CommandAction2<T, A, B> = Future<Result<T>> Function(A, B);
typedef CommandAction3<T, A, B, C> = Future<Result<T>> Function(A, B, C);

abstract class Command<T> extends ChangeNotifier {
  Command({
    ValueChanged<Exception>? errorHandler,
  }) : _errorHandler = errorHandler;

  final ValueChanged<Exception>? _errorHandler;

  bool _running = false;

  /// True when the action is running.
  bool get running => _running;

  Result<T>? _result;

  /// true if action completed with error
  bool get error => _result is Error;

  /// true if action completed successfully
  bool get completed => _result is Ok;

  /// Get last action result
  Result<T>? get result => _result;

  /// Clear last action result
  void clearResult() {
    _result = null;
    notifyListeners();
  }

  /// Internal execute implementation
  Future<void> _execute(CommandAction0<T> action) async {
    // Ensure the action can't launch multiple times.
    // e.g. avoid multiple taps on button
    if (_running) return;

    // Notify listeners.
    // e.g. button shows loading state
    _running = true;
    _result = null;
    notifyListeners();

    try {
      final result = await action();
      if (_errorHandler != null && result.isError) {
        _errorHandler(result.asError.error);
      }
      _result = result;
    } finally {
      _running = false;
      notifyListeners();
    }
  }
}

/// [Command] without arguments.
/// Takes a [CommandAction0] as action.
class Command0<T> extends Command<T> {
  Command0(this._action, {super.errorHandler});

  final CommandAction0<T> _action;

  /// Executes the action.
  Future<void> execute() async {
    await _execute(() => _action());
  }
}

/// [Command] with one argument.
/// Takes a [CommandAction1] as action.
class Command1<T, A> extends Command<T> {
  Command1(this._action, {super.errorHandler});

  final CommandAction1<T, A> _action;

  /// Executes the action with the argument.
  Future<void> execute(A argument) async {
    await _execute(() => _action(argument));
  }
}

/// [Command] with two arguments.
/// Takes a [CommandAction2] as action.
class Command2<T, A, B> extends Command<T> {
  Command2(this._action, {super.errorHandler});

  final CommandAction2<T, A, B> _action;

  /// Executes the action with the argument.
  Future<void> execute(A argument1, B argument2) async {
    await _execute(() => _action(argument1, argument2));
  }
}

/// [Command] with three arguments.
/// Takes a [CommandAction3] as action.
class Command3<T, A, B, C> extends Command<T> {
  Command3(this._action, {super.errorHandler});

  final CommandAction3<T, A, B, C> _action;

  /// Executes the action with the argument.
  Future<void> execute(A argument1, B argument2, C argument3) async {
    await _execute(() => _action(argument1, argument2, argument3));
  }
}
