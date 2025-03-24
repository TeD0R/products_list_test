part of 'favorites_page.dart';


class FavoritesView extends StatelessWidget {
  final FavoritesPageState state;

  const FavoritesView({super.key, required this.state});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Favorites'),
      ),
      body: Center(
        child: Text(
          'No favorites yet!',
          style: Theme.of(context).textTheme.headlineMedium,
        ),
      ),
    );
  }
}