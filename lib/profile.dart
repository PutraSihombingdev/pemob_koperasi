import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.black,
        title: const Text('Profile Saya'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // Profile Picture
            CircleAvatar(
              radius: 60,
              backgroundImage: NetworkImage(
                'https://i.pravatar.cc/300',
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'Putra Sihombing',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 4),
            const Text(
              'Software Developer',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 24),

            // About Card
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      'About Me',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'I am passionate about building beautiful and functional mobile applications using Flutter. I enjoy learning new technologies and solving complex problems.',
                      style: TextStyle(fontSize: 14),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Contact Info Card
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    ListTile(
                      leading: const Icon(Icons.email, color: Colors.blue),
                      title: const Text('Email'),
                      subtitle: const Text('putra@example.com'),
                      onTap: () {
                        // Add action
                      },
                    ),
                    const Divider(),
                    ListTile(
                      leading: const Icon(Icons.phone, color: Colors.green),
                      title: const Text('Phone'),
                      subtitle: const Text('+62 812-3456-7890'),
                      onTap: () {
                        // Add action
                      },
                    ),
                    const Divider(),
                    ListTile(
                      leading: const Icon(Icons.location_on, color: Colors.red),
                      title: const Text('Location'),
                      subtitle: const Text('Bali, Indonesia'),
                      onTap: () {
                        // Add action
                      },
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 24),

            // Action Buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton.icon(
                  onPressed: () {
                    // Add edit profile action
                  },
                  icon: const Icon(Icons.edit),
                  label: const Text('Edit Profile'),
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 24, vertical: 12),
                  ),
                ),
                OutlinedButton.icon(
                  onPressed: () {
                    // Add logout action
                  },
                  icon: const Icon(Icons.logout),
                  label: const Text('Log Out'),
                  style: OutlinedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    side: const BorderSide(color: Colors.red),
                    foregroundColor: Colors.red,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 24, vertical: 12),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
