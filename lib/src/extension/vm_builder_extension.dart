import 'package:flutter/widgets.dart';

import 'package:onix_flutter_mvvm/src/view_model/view_model.dart';
import 'package:onix_flutter_mvvm/src/view_model/view_model_widget.dart';

extension VmBuilderExtension on ViewModelWidget {
  Widget viewModelBuilder<V extends ViewModel>({
    required ViewModelBuilder<V> builder,
  }) =>
      vmBuilder(
        builder: builder,
        viewModel: viewModel,
      );
}
