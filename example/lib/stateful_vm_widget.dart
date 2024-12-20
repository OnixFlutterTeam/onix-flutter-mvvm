import 'package:flutter/material.dart';
import 'package:onix_flutter_mvvm/onix_flutter_mvvm.dart';

class StatefulVMWidget extends StatefulWidget {
  const StatefulVMWidget({super.key});

  @override
  State<StatefulVMWidget> createState() => _StatefulVMWidgetState();
}

class _StatefulVMWidgetState
    extends ViewModelWidget<StatefulVMWidget, StatefulMainViewModel> {
  @override
  StatefulMainViewModel createVm() => StatefulMainViewModel();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text('Stateful ViewModel', style: TextStyle(fontSize: 24)),
            const SizedBox(height: 16),
            const Text(
              'You have pushed the button this many times:',
            ),
            vmBuilder<StatefulMainViewModel>(builder: (context, vm) {
              return Text(
                '${vm.data.counter}',
                style: Theme.of(context).textTheme.headlineMedium,
              );
            }),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: viewModel.increment,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  @override
  void onError(Exception error) {
    // TODO: process error
  }
}

class StatefulMainModel {
  final int counter;

  StatefulMainModel({this.counter = 0});

  StatefulMainModel copyWith({int? counter}) =>
      StatefulMainModel(counter: counter ?? this.counter);
}

class StatefulMainViewModel extends ViewModelStateful<StatefulMainModel> {
  StatefulMainViewModel() : super(StatefulMainModel());

  void increment() {
    final newValue = data.counter + 1;
    setData(data.copyWith(counter: newValue));
    notifyListeners();
  }
}
