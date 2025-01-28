import 'package:flutter/widgets.dart';
import 'package:onix_flutter_mvvm/src/view_model/view_model.dart';
import 'package:onix_flutter_mvvm/src/view_model/view_model_widget.dart';

mixin WidgetViewModelMixin on Widget {
  Widget vmBuilder<V extends ViewModel>({
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
}
