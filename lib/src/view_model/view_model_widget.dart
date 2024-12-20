import 'package:flutter/widgets.dart';
import 'package:onix_flutter_mvvm/src/command/command.dart';
import 'package:onix_flutter_mvvm/src/view_model/view_model.dart';

typedef ViewModelBuilder<V extends ViewModel> = Widget Function(
  BuildContext context,
  V vm,
);

typedef CommandBuilder<T> = Widget Function(
  BuildContext context,
  Command<T> vm,
);

abstract class ViewModelWidget<T extends StatefulWidget, V extends ViewModel>
    extends State<T> {
  late V viewModel;

  ViewModelWidget() {
    viewModel = createVm();
  }

  V createVm();

  void onError(Exception error);

  @override
  void initState() {
    super.initState();
    viewModel.addListener(_onViewModelChange);
  }

  @override
  void dispose() {
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
    if (viewModel.hasError) {
      onError(viewModel.error!);
      viewModel.cleanInternalState();
    }
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
