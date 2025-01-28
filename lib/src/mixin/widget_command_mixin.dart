import 'package:flutter/widgets.dart';
import 'package:onix_flutter_mvvm/src/command/command.dart';
import 'package:onix_flutter_mvvm/src/view_model/view_model_widget.dart';

extension WidgetCommandMixin on Widget {
  Widget commandBuilder<T>({
    required Command<T> command,
    required CommandBuilder<T> builder,
  }) {
    return ListenableBuilder(
      listenable: command,
      builder: (BuildContext context, Widget? child) {
        return builder(context, command);
      },
    );
  }

  Widget commandConsumer<T>({
    required Command<T> command,
    required CommandConsumer<T> consumer,
    Widget? child,
    bool consumeOnCompleted = true,
  }) {
    return ListenableBuilder(
      listenable: command,
      child: child,
      builder: (BuildContext context, Widget? child) {
        if (consumeOnCompleted) {
          if (command.completed) {
            consumer(context, command);
          }
        } else {
          consumer(context, command);
        }
        return child ?? const SizedBox.shrink();
      },
    );
  }
}
