import 'package:flutter/material.dart';
import 'location_presenter.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final LocationPresenter _presenter = LocationPresenter();

  @override
  void dispose() {
    _presenter.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: StreamBuilder<String?>(
          stream: _presenter.locationStream,
          builder: (context, snapshot) {
            if (snapshot.hasData && snapshot.data != null) {
              return Text(snapshot.data!);
            } else {
              return const Text('Press start');
            }
          },
        ),
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          ElevatedButton(
            onPressed: () => _presenter.getLocationPermission(),
            child: const Text('Start location'),
          ),
          const SizedBox(height: 10),
          ElevatedButton(
            onPressed: () => _presenter.stopLocationStream(),
            child: const Text('Stop location'),
          ),
        ],
      ),
    );
  }
}
