
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

Call `setError` in ViewModel when error happened:

```
setError(Exception());
```

Call `setAction` in ViewModel to trigger single time event (like show dialog, call navigation, etc.):

```
setAction(MyAction());
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

Use `onError` function to handle erorrs from ViewModel (when `setError` has been called):

```
@override
  void onError(failure) {
    // TODO: process error
  }
```

Use `onAction` function to handle actions from ViewModel (when `setAction` has been called):

```
 @override
  void onAction(action) {
    if(action == MyAction){
    	context.goNamed('detailsScreen');
    }
    super.onAction(action);
  }
```

Use `viewModelBuilder` builder to handle ViewModel changes in your widget:

```
viewModelBuilder<MainViewModel>(builder: (context, vm) {
              return Text(
                '${vm.data.counter}',
              );
            }),
```

Use `viewModelConsumer` builder to handle ViewModel changes in your widget:

```
viewModelConsumer<MainViewModel>(
              consumer: (context, vm) {
                //do what you need
              },
              child: MyWidget(),
            )
```

Set `buildWhen` parameter if you need restrict rebuilds:

``
 buildWhen: (oldVm, newVm) {
                return oldVm.value > newVm.value;
              },
``

### Stateful View Model

This options designed to use ViewModel but with all variables inside additional model class. All usage remains the same, except:

Create model class:

```
class MainModel {
  final int counter;

  MainModel({this.counter = 0});

  MainModel copyWith({int? counter}) =>
      MainModel(counter: counter ?? this.counter);
}
```

Extend your ViewModel class from `ViewModelStateful<Model>`:

```
class MainViewModel extends ViewModelStateful<MainModel> {
  MainViewModel() : super(MainModel());

  void increment() {
    final newValue = data.counter + 1;
    setData(data.copyWith(counter: newValue));
    notifyListeners();
  }
}
```

Specify your model type in ViewModelWidget in your widget state:

```
class _MyHomePageState extends 
ViewModelWidget<MyHomePage, MainViewModel>
```

### Usage out of ViewModel based Widget

Add corresponding mixin to your widget:

* `StateCommandMixin` - State mixin to get access to Command builder and consumer (`commandBuilder` and `commandConsumer`);
* `StateViewModelMixin` - State mixin to get access to ViewModel builder and consumer (`vmBuilder` and `vmConsumer`);
* `WidgetCommandMixin` - Widget mixin to get access to Command builder and consumer (`commandBuilder` and `commandConsumer`);
* `WidgetViewModelMixin` - Widget mixin to get access to ViewModel builder and consumer (`vmBuilder` and `vmConsumer`);

Usage example:

```
vmBuilder<MyViewModel>(
      builder: (context, vm) {
        return MyWidget();
      },
      viewModel: myViewModel,
    )
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

Execute Command where you need:

```
void _onPressed(){
	 viewModel.increment.execute();
}
```

Found a bug or have a suggestion? Report it [here](https://github.com/OnixFlutterTeam/onix-flutter-mvvm/issues).



