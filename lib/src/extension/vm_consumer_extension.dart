import 'package:flutter/widgets.dart';
import 'package:onix_flutter_mvvm/src/view_model/view_model.dart';
import 'package:onix_flutter_mvvm/src/view_model/view_model_widget.dart';

extension VmConsumerExtension on ViewModelWidget {
  Widget viewModelConsumer<V extends ViewModel>({
    required ViewModelConsumer<V> consumer,
    Widget? child,
  }) =>
      vmConsumer(
        consumer: consumer,
        viewModel: viewModel,
        child: child,
      );
}
