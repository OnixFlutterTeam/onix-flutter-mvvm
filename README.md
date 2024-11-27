
This package contains base classes for MVVM implementation in Flutter. 



## Usage

Create MVVM model class:

```
class MainModel {
  MainModel({int counter = 0}) : _counter = counter;

  final int _counter;

  int get counter => _counter;

  MainModel copyWith({
    int? counter,
  }) =>
      MainModel(counter: counter ?? _counter);
}
```

Create ViewModel class:

```
class MainViewModel extends ViewModel<MainModel> {
  MainViewModel() : super(MainModel());

  void increment() {
    final newValue = data.counter + 1;
    setData(data.copyWith(counter: newValue));
    notifyListeners();
  }
}
```

Specify your ViewModel in your widget state:

```
class _MyHomePageState extends 
ViewModelWidget<MyHomePage, MainViewModel>
```

Create you ViewModel instance in overiden `createVm` function:

```
@override
  MainViewModel createVm() => MainViewModel();
```

Handle errors in overriden `onError` function:

```
@override
  void onError(failure) {
    // TODO: process error
  }
```

Use additional builder to handle ViewModel changes in your widget:

```
vmBuilder<MainViewModel>(builder: (context, vm) {
              return Text(
                '${vm.data.counter}',
              );
            }),
```



