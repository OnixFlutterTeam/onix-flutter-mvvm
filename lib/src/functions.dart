

import 'package:onix_flutter_mvvm/src/view_model/view_model.dart';

typedef ViewModelCondition<V extends ViewModel> = bool Function(
    V oldVm, V newVm);