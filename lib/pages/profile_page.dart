import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  final String name;
  final String group;
  final String phone;
  final String email;
  final String profileImage;
  final Function(String, String, String, String, String) onProfileSave;

  const ProfilePage({
    super.key,
    required this.name,
    required this.group,
    required this.phone,
    required this.email,
    required this.profileImage,
    required this.onProfileSave,
  });

  @override
  Widget build(BuildContext context) {
    final nameController = TextEditingController(text: name);
    final groupController = TextEditingController(text: group);
    final phoneController = TextEditingController(text: phone);
    final emailController = TextEditingController(text: email);
    final imageController = TextEditingController(text: profileImage);

    return Scaffold(
      appBar: AppBar(title: const Text('Профиль')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            CircleAvatar(
              backgroundImage: NetworkImage(profileImage),
              radius: 50,
            ),
            const SizedBox(height: 16),
            TextField(
              controller: nameController,
              decoration: const InputDecoration(labelText: 'Имя'),
            ),
            TextField(
              controller: groupController,
              decoration: const InputDecoration(labelText: 'Группа'),
            ),
            TextField(
              controller: phoneController,
              decoration: const InputDecoration(labelText: 'Телефон'),
            ),
            TextField(
              controller: emailController,
              decoration: const InputDecoration(labelText: 'Электронная почта'),
            ),
            TextField(
              controller: imageController,
              decoration: const InputDecoration(labelText: 'Ссылка на фото профиля'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                onProfileSave(
                  nameController.text,
                  groupController.text,
                  phoneController.text,
                  emailController.text,
                  imageController.text,
                );
              },
              child: const Text('Сохранить'),
            ),
          ],
        ),
      ),
    );
  }
}
