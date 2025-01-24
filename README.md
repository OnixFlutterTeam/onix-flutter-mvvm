
This package contains base classes for MVVM implementation in Flutter. 



## Usage

### View Model

Create ViewModel class:

```
class MainViewModel extends ViewModel {
  int counter = 0;

  void increment() {
    counter++;
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

Use `vmBuilder` builder to handle ViewModel changes in your widget:

```
viewModelBuilder<MainViewModel>(builder: (context, vm) {
              return Text(
                '${vm.data.counter}',
              );
            }),
```


### Stateful View Model

Create MVVM model class:

```
class MainModel {
  final int counter;

  MainModel({this.counter = 0});

  MainModel copyWith({int? counter}) =>
      MainModel(counter: counter ?? this.counter);
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

Use `vmBuilder` builder to handle ViewModel changes in your widget:

```
vmBuilder<MainViewModel>(builder: (context, vm) {
              return Text(
                '${vm.data.counter}',
              );
            }),
```

### Commands

Add Command to your ViewModel, for example:

```
class MainViewModelCommands extends ViewModel {
  int counter = 0;

  late Command0<int> increment;

  MainViewModelCommands() {
    increment = Command0<int>(_increment);
  }

  Future<Result<int>> _increment() async {
    await Future.delayed(const Duration(milliseconds: 500));
    counter++;
    return Result.ok(counter);
  }
}
```

Use `commandBuilder` to listen to your Command state:

```
commandBuilder<int>(
                command: viewModel.increment,
                builder: (context, command) {
                  if (command.running) {
                    return const CircularProgressIndicator();
                  }
                  if (command.error) {
                    return const Text('Error');
                  }
                  return Text(
                    '${command.result?.data ?? 0}',
                    style: Theme.of(context).textTheme.headlineMedium,
                  );
                }),
```


Found a bug or have a suggestion? Report it [here](https://github.com/OnixFlutterTeam/onix-flutter-mvvm/issues).



