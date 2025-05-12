import 'package:flutter/material.dart';

// Stateless widget for the account page
class AccountPage extends StatelessWidget {
  const AccountPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Mock user data
    const String username = "Group 2";
    const String email = "Group2@tlu.ee";
    const String phone = "+372 1234 5678";
    const String profilePictureUrl =
        "https://www.tlu.ee/public/esindustrykis-2018/files/mobile/1.jpg";

    return Scaffold(
      appBar: AppBar(
        title: const Text("Account"),
        centerTitle: true,
        backgroundColor: Colors.lightBlue,
        foregroundColor: Colors.white,
      ),
      backgroundColor: Colors.lightBlue,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Profile Picture and Username Section
            Center(
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundImage: NetworkImage(profilePictureUrl),
                    backgroundColor: Colors.grey[200],
                  ),
                  const SizedBox(height: 12),
                  Text(
                    username,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    email,
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),

            // Account Information Section
            const Text(
              "Account Details",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 12),
            _InfoCard(icon: Icons.email, label: "Email", value: email),
            const SizedBox(height: 12),
            _InfoCard(icon: Icons.phone, label: "Phone", value: phone),

            const SizedBox(height: 32),

            // Actions Section
            const Text(
              "Actions",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 12),
            _ActionButton(
              icon: Icons.edit,
              text: "Edit Profile",
              onPressed: () {
                // TODO: Implement profile editing functionality
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    backgroundColor: Colors.black45,
                    content: Text("Profile editing is not yet available"),
                  ),
                );
              },
            ),
            const SizedBox(height: 8),
            _ActionButton(
              icon: Icons.lock,
              text: "Change Password",
              onPressed: () {
                // TODO: Implement password change functionality
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    backgroundColor: Colors.black45,
                    content: Text("Password change is not yet available"),
                  ),
                );
              },
            ),
            const SizedBox(height: 8),
            _ActionButton(
              icon: Icons.logout,
              text: "Log Out",
              onPressed: () {
                // TODO: Implement logout functionality
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    backgroundColor: Colors.black45,
                    content: Text("Logout is not yet available"),
                  ),
                );
              },
              color: Colors.redAccent,
            ),
          ],
        ),
      ),
    );
  }
}

// Widget for displaying account information cards
class _InfoCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const _InfoCard({
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Icon(icon, color: Colors.blue, size: 24),
          const SizedBox(width: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: TextStyle(fontSize: 14, color: Colors.grey[600]),
              ),
              Text(
                value,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// Widget for action buttons
class _ActionButton extends StatelessWidget {
  final IconData icon;
  final String text;
  final VoidCallback onPressed;
  final Color? color;

  const _ActionButton({
    required this.icon,
    required this.text,
    required this.onPressed,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: onPressed,
      icon: Icon(icon, size: 20),
      label: Text(text),
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.white,
        foregroundColor: color ?? Colors.black87,
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: BorderSide(color: Colors.grey[200]!),
        ),
        minimumSize: const Size(double.infinity, 50),
        alignment: Alignment.centerLeft,
      ),
    );
  }
}