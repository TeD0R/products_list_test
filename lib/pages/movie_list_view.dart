part of 'movie_list_page.dart';

class MovieListView extends StatelessWidget {
  final MovieListPageState pageState;

  const MovieListView({super.key, required this.pageState});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Movies'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: BlocBuilder<MovieBloc, MovieState>(
          builder: (context, state) {
            if (state is Initial) {
              return Center(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: ElevatedButton(
                    onPressed: () {
                      context.read<MovieBloc>().add(const FetchMovies());
                    },
                    child: const Text('Get Movies'),
                  ),
                ),
              );
            } else if (state is Loading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is Loaded) {
              return ListView.builder(
                itemCount: state.movies.length,
                shrinkWrap: true,
                physics: const BouncingScrollPhysics(),
                itemBuilder: (context, index) {
                  final movie = state.movies[index];

                  return Card(
                    elevation: 4,
                    margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Image.network(
                              movie.posterUrl.toString(),
                              width: 90,
                              height: 130,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) =>
                              const Icon(Icons.image_not_supported, size: 90),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  movie.title,
                                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  'Released: ${movie.releaseDate?.year ?? 'N/A'}',
                                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                    color: Colors.grey.shade600,
                                  ),
                                ),
                                const SizedBox(height: 6),
                                Wrap(
                                  spacing: 6,
                                  children: movie.genres
                                      .map((genre) => Chip(
                                    label: Text(genre, style: const TextStyle(fontSize: 12)),
                                    backgroundColor: Colors.blue.shade100,
                                  ))
                                      .toList(),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  movie.storyline ?? 'No description available.',
                                  maxLines: 3,
                                  overflow: TextOverflow.ellipsis,
                                  style: Theme.of(context).textTheme.bodySmall,
                                ),
                                const SizedBox(height: 8),
                                Row(
                                  children: [
                                    const Icon(Icons.star, color: Colors.amber, size: 16),
                                    const SizedBox(width: 4),
                                    Text(
                                      movie.imdbRating,
                                      style: Theme.of(context).textTheme.bodyMedium,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            } else if (state is Error) {
              return Center(
                child: Text(
                  state.error,
                  style: const TextStyle(color: Colors.red),
                ),
              );
            } else {
              return const Center(child: Text('Press the button to fetch movies'));
            }
          },
        ),
      ),
    );
  }
}
