import 'package:flutter/widgets.dart';
import 'package:onix_flutter_mvvm/src/view_model/view_model.dart';
import 'package:onix_flutter_mvvm/src/view_model/view_model_widget.dart';
import 'package:onix_flutter_mvvm/src/extension/base_vm_consumer_extension.dart';

extension VmConsumerExtension on ViewModelWidget {
  Widget vmConsumer<V extends ViewModel>({
    required ViewModelConsumer<V> consumer,
    Widget? child,
  }) =>
      baseVmConsumer(
        consumer: consumer,
        viewModel: viewModel,
        child: child,
      );
}
