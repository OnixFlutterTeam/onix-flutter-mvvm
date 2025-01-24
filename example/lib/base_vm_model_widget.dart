import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:onix_flutter_mvvm/onix_flutter_mvvm.dart';

class BaseVMWidget extends StatefulWidget {
  const BaseVMWidget({super.key});

  @override
  State<BaseVMWidget> createState() => _BaseVMWidgetState();
}

class _BaseVMWidgetState
    extends ViewModelWidget<BaseVMWidget, BaseMainViewModel> {
  @override
  BaseMainViewModel createVm() => BaseMainViewModel();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text('Basic ViewModel', style: TextStyle(fontSize: 24)),
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
    if (kDebugMode) {
      print('Error: ${error.toString()}');
    }
    super.onError(error);
  }

  @override
  void onAction(ViewModelAction action) {
    showAboutDialog(context: context);
    super.onAction(action);
  }
}

class BaseMainViewModel extends ViewModel {
  int counter = 0;

  void increment() {
    counter++;
    notifyListeners();
  }
}
