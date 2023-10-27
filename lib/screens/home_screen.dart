import 'package:flutter/material.dart';
import 'package:flutter_provider_app/providers/movie_provider.dart';
import 'package:flutter_provider_app/screens/fav_movies.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    var movies = context.watch<MovieProvider>().movies;
    var myList = context.watch<MovieProvider>().myList;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Provider'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            ElevatedButton.icon(
              onPressed: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => MyListScreen()));
              },
              icon: const Icon(Icons.favorite),
              label: Text(
                "Go to my favourite list (${myList.length})",
                style: const TextStyle(fontSize: 24),
              ),
              style: ElevatedButton.styleFrom(
                  primary: Colors.red,
                  padding: const EdgeInsets.symmetric(vertical: 20)),
            ),
            SizedBox(
              height: 20.0,
            ),
            Expanded(
                child: ListView.builder(
              itemBuilder: (_, index) {
                final currentMovie = movies[index];
                return Card(
                  key: ValueKey(currentMovie.title),
                  color: Colors.blue,
                  elevation: 4,
                  child: ListTile(
                    title: Text(
                      currentMovie.title,
                      style: const TextStyle(color: Colors.white),
                    ),
                    subtitle: Text(
                      currentMovie.duration ?? 'No Information',
                      style: const TextStyle(color: Colors.white),
                    ),
                    trailing: IconButton(
                      icon: Icon(
                        Icons.favorite,
                        size: 30,
                        color: myList.contains(currentMovie)
                            ? Colors.red
                            : Colors.white,
                      ),
                      onPressed: () {
                        if (!myList.contains(currentMovie)) {
                          context.read<MovieProvider>().addToList(currentMovie);
                        } else {
                          context
                              .read<MovieProvider>()
                              .removeFromList(currentMovie);
                        }
                      },
                    ),
                  ),
                );
              },
              itemCount: movies.length,
            ))
          ],
        ),
      ),
    );
  }
}
