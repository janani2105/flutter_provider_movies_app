import 'package:flutter/material.dart';
import 'package:flutter_provider_app/providers/movie_provider.dart';
import 'package:provider/provider.dart';

class MyListScreen extends StatefulWidget {
  const MyListScreen({Key? key}) : super(key: key);

  @override
  State<MyListScreen> createState() => _MyListScreenState();
}

class _MyListScreenState extends State<MyListScreen> {
  @override
  Widget build(BuildContext context) {
    var _myList = context.watch<MovieProvider>().myList;
    return Scaffold(
      appBar: AppBar(
        title: Text("My List (${_myList.length})"),
      ),
      body: ListView.builder(
        itemBuilder: (_, index) {
          final currentMovie = _myList[index];

          return Card(
            key: ValueKey(currentMovie.title),
            elevation: 4,
            child: ListTile(
              title: Text(currentMovie.title),
              subtitle: Text(currentMovie.duration ?? ''),
              trailing: TextButton(
                onPressed: () {
                  context.read<MovieProvider>().removeFromList(currentMovie);
                },
                child: Text(
                  'Remove',
                  style: TextStyle(color: Colors.red),
                ),
              ),
            ),
          );
        },
        itemCount: _myList.length,
      ),
    );
  }
}
