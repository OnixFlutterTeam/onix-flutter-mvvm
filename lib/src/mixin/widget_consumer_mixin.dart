import 'package:flutter/widgets.dart';
import 'package:onix_flutter_mvvm/src/command/command.dart';
import 'package:onix_flutter_mvvm/src/view_model/view_model.dart';
import 'package:onix_flutter_mvvm/src/view_model/view_model_widget.dart';

extension WidgetConsumerMixin on Widget {
  Widget vmConsumer<V extends ViewModel>({
    required ViewModelConsumer<V> consumer,
    required ViewModel viewModel,
    Widget? child,
  }) {
    return ListenableBuilder(
      listenable: viewModel,
      child: child,
      builder: (BuildContext context, Widget? child) {
        consumer(context, viewModel as V);
        return child ?? const SizedBox.shrink();
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
