import 'package:flutter/widgets.dart';
import 'package:onix_flutter_mvvm/src/command/command.dart';
import 'package:onix_flutter_mvvm/src/view_model/view_model.dart';
import 'package:onix_flutter_mvvm/src/view_model/view_model_widget.dart';

extension WidgetVmBuilderExtension on Widget {
  Widget baseVmBuilder<V extends ViewModel>({
    required ViewModelBuilder<V> builder,
    required ViewModel viewModel,
  }) {
    return ListenableBuilder(
      listenable: viewModel,
      builder: (BuildContext context, Widget? child) {
        return builder(context, viewModel as V);
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
}


extension StateVmBuilderExtension on State {
  Widget baseVmBuilder<V extends ViewModel>({
    required ViewModelBuilder<V> builder,
    required ViewModel viewModel,
  }) {
    return ListenableBuilder(
      listenable: viewModel,
      builder: (BuildContext context, Widget? child) {
        return builder(context, viewModel as V);
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
}
