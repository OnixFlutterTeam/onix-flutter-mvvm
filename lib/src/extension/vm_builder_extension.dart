import 'package:flutter/widgets.dart';
import 'package:onix_flutter_mvvm/src/extension/base_vm_builder_extension.dart';
import 'package:onix_flutter_mvvm/src/view_model/view_model.dart';
import 'package:onix_flutter_mvvm/src/view_model/view_model_widget.dart';

extension VmBuilderExtension on ViewModelWidget {
  Widget vmBuilder<V extends ViewModel>({
    required ViewModelBuilder<V> builder,
  }) =>
      baseVmBuilder(
        builder: builder,
        viewModel: viewModel,
      );

}
