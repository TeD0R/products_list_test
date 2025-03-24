part of 'profile_page.dart';


class ProfileView extends StatelessWidget {
  final ProfilePageState state;

  const ProfileView({super.key, required this.state});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
      ),
      body: Center(
        child: Text(
          'No Profile yet!',
          style: Theme.of(context).textTheme.headlineMedium,
        ),
      ),
    );
  }
}