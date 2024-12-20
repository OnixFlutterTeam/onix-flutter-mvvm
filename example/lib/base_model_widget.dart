import 'package:flutter/material.dart';
import 'package:onix_flutter_mvvm/onix_flutter_mvvm.dart';

class BaseModelWidget extends StatefulWidget {
  const BaseModelWidget({super.key});

  @override
  State<BaseModelWidget> createState() => _BaseModelWidgetState();
}

class _BaseModelWidgetState
    extends ViewModelWidget<BaseModelWidget, BaseMainViewModel> {
  @override
  BaseMainViewModel createVm() => BaseMainViewModel();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text('BaseModel', style: TextStyle(fontSize: 24)),
            const SizedBox(height: 16),
            const Text(
              'You have pushed the button this many times:',
            ),
            vmBuilder<BaseMainViewModel>(builder: (context, vm) {
              return Text(
                '${vm.counter}',
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

class BaseMainModel {
  int counter;

  BaseMainModel({this.counter = 0});
}

class BaseMainViewModel extends ViewModel {
  final BaseMainModel model = BaseMainModel();

  int get counter => model.counter;

  void increment() {
    model.counter++;
    notifyListeners();
  }
}
