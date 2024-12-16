import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfilePage extends StatefulWidget {
  final String initialName;
  final String initialEmail;
  final String initialPhone;
  final String initialImage;

  const ProfilePage({
    super.key,
    required this.initialName,
    required this.initialEmail,
    required this.initialPhone,
    required this.initialImage,
  });

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late TextEditingController _nameController;
  late TextEditingController _emailController;
  late TextEditingController _phoneController;
  late String _profileImage;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.initialName);
    _emailController = TextEditingController(text: widget.initialEmail);
    _phoneController = TextEditingController(text: widget.initialPhone);
    _profileImage = widget.initialImage;
    _loadProfile(); // Загрузить данные из shared_preferences
  }

  Future<void> _loadProfile() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _nameController.text = prefs.getString('profile_name') ?? widget.initialName;
      _emailController.text = prefs.getString('profile_email') ?? widget.initialEmail;
      _phoneController.text = prefs.getString('profile_phone') ?? widget.initialPhone;
      _profileImage = prefs.getString('profile_image') ?? widget.initialImage;
    });
  }

  Future<void> _saveProfile() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('profile_name', _nameController.text);
    await prefs.setString('profile_email', _emailController.text);
    await prefs.setString('profile_phone', _phoneController.text);
    await prefs.setString('profile_image', _profileImage);

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Профиль успешно сохранён!')),
    );
  }

  void _updateImage() {
    setState(() {
      _profileImage = 'https://example.com/new_image.png'; // Статическая ссылка для демонстрации
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Фото профиля обновлено!')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Редактирование профиля')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: _updateImage,
                child: CircleAvatar(
                  radius: 50,
                  backgroundImage: NetworkImage(_profileImage),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: 'Имя'),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: _emailController,
                decoration: const InputDecoration(labelText: 'Email'),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: _phoneController,
                decoration: const InputDecoration(labelText: 'Телефон'),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _saveProfile,
                child: const Text('Сохранить изменения'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    super.dispose();
  }
}
