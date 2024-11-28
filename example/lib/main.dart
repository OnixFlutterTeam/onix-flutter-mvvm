import 'package:flutter/material.dart';
import 'package:onix_flutter_mvvm/onix_flutter_mvvm.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends ViewModelWidget<MyHomePage, MainViewModel> {
  @override
  MainViewModel createVm() => MainViewModel();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            vmBuilder<MainViewModel>(builder: (context, vm) {
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
  void onError(failure) {
    // TODO: process error
  }

}

class MainModel {
  MainModel({int counter = 0}) : _counter = counter;

  final int _counter;

  int get counter => _counter;

  MainModel copyWith({
    int? counter,
  }) =>
      MainModel(counter: counter ?? _counter);
}

class MainViewModel extends ViewModel<MainModel> {
  MainViewModel() : super(MainModel());

  void increment() {
    final newValue = data.counter + 1;
    setData(data.copyWith(counter: newValue));
    notifyListeners();
  }
}
