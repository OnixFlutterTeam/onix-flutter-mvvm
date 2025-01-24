import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:onix_flutter_mvvm/src/action/action.dart';
import 'package:onix_flutter_mvvm/src/command/command.dart';
import 'package:onix_flutter_mvvm/src/view_model/view_model.dart';

typedef ViewModelBuilder<V extends ViewModel> = Widget Function(
  BuildContext context,
  V vm,
);

typedef ViewModelConsumer<V extends ViewModel> = void Function(
  BuildContext context,
  V vm,
);

typedef CommandBuilder<T> = Widget Function(
  BuildContext context,
  Command<T> command,
);

typedef CommandConsumer<T> = void Function(
  BuildContext context,
  Command<T> command,
);

abstract class ViewModelWidget<T extends StatefulWidget, V extends ViewModel>
    extends State<T> {
  late V viewModel;

  late StreamSubscription<ViewModelAction> _actionSubscription;

  late StreamSubscription<Exception> _errorSubscription;

  ViewModelWidget() {
    viewModel = createVm();
  }

  V createVm();

  void onError(Exception error) {
    //empty;
  }

  void onAction(ViewModelAction action) {
    //empty;
  }

  @override
  void initState() {
    super.initState();
    viewModel.addListener(_onViewModelChange);
    _actionSubscription = viewModel.actionStream.listen(onAction);
    _errorSubscription = viewModel.errorStream.listen(onError);
  }

  @override
  void dispose() {
    _actionSubscription.cancel();
    _errorSubscription.cancel();
    viewModel.removeListener(_onViewModelChange);
    viewModel.dispose();
    super.dispose();
  }

  void resetVm() {
    setState(() {
      viewModel = createVm();
    });
  }

  void onChanged(V vm) {}

  void _onViewModelChange() {
    onChanged(viewModel);
  }
}

extension VmBuilderExtension on ViewModelWidget {
  Widget vmBuilder<V extends ViewModel>({
    required ViewModelBuilder<V> builder,
  }) {
    return ListenableBuilder(
      listenable: viewModel,
      builder: (BuildContext context, Widget? child) {
        return builder(context, viewModel as V);
      },
    );
  }

  Widget vmConsumer<V extends ViewModel>({
    required ViewModelConsumer<V> consumer,
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
