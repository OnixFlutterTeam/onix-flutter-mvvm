import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:onix_flutter_core_models/onix_flutter_core_models.dart';
import 'package:onix_flutter_mvvm/onix_flutter_mvvm.dart';

class CommandVMWidget extends StatefulWidget {
  const CommandVMWidget({super.key});

  @override
  State<CommandVMWidget> createState() => _CommandVMWidgetState();
}

class _CommandVMWidgetState
    extends ViewModelWidget<CommandVMWidget, BaseMainViewModelCommands> {
  @override
  BaseMainViewModelCommands createVm() => BaseMainViewModelCommands();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text('ViewModel with Command',
                style: TextStyle(fontSize: 24)),
            const SizedBox(height: 16),
            const Text(
              'You have pushed the button this many times:',
            ),
            commandConsumer(
              command: viewModel.increment,
              consumer: (context, command) {
                if (kDebugMode) {
                  print('Command consumed, result : ${command.result}');
                }
              },
            ),
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
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: viewModel.increment.execute,
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

class BaseMainViewModelCommands extends ViewModel {
  int counter = 0;

  late Command0<int> increment;

  BaseMainViewModelCommands() {
    increment = Command0<int>(_increment);
  }

  Future<Result<int>> _increment() async {
    await Future.delayed(const Duration(milliseconds: 500));
    counter++;
    return Result.ok(counter);
  }
}
