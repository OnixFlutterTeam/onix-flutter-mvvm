import 'package:flutter/foundation.dart';
import 'package:onix_flutter_mvvm/src/view_model/base_view_model.dart';

abstract class ViewModelStateful<T> extends BaseViewModel {
  ViewModelStateful(T defaultModel) {
    _data = defaultModel;
  }

  late T _data;

  T get data => _data;

  @protected
  void setData(T data) {
    _data = data;
  }
}
