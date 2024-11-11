import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:mi_reclamo/core/core.dart';
import 'package:mi_reclamo/features/data/data_sources/google/google_service.dart';
import 'package:mi_reclamo/features/data/data_sources/local/storage_service.dart';
import 'package:mi_reclamo/features/presentation/pages/login/login_page.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  ProfilePageState createState() => ProfilePageState();
}

class ProfilePageState extends State<ProfilePage> {
  static final Logger _logger = Logger();

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        Card(
          color: Theme.of(context).canvasColor,
          elevation: 0,
          margin: EdgeInsets.zero,
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(
                  children: [
                    FutureBuilder<String>(
                      future: StorageService.getValue('image'),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.done) {
                          final String photoUrl = snapshot.data ?? '';
                          if (photoUrl.isNotEmpty) {
                            return CircleAvatar(
                              radius: 40,
                              backgroundImage:
                                  CachedNetworkImageProvider(photoUrl),
                            );
                          } else {
                            return const CircleAvatar(
                                radius: 40, child: Icon(Icons.person_2));
                          }
                        } else if (snapshot.hasError) {
                          return const CircleAvatar(
                              radius: 40, child: Icon(Icons.person));
                        } else {
                          return const CircleAvatar(
                              radius: 40, child: CircularProgressIndicator());
                        }
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                FutureBuilder<String>(
                  future: StorageService.getValue('name'),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      final String name = snapshot.data ?? '';
                      return Text(name,
                          style: StyleText.headlineSmall,
                          textAlign: TextAlign.center);
                    } else {
                      return const Text('Usuario');
                    }
                  },
                ),
                const SizedBox(height: 10),
                FutureBuilder<String>(
                  future: StorageService.getValue('email'),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      final String email = snapshot.data ?? '';
                      return Text(email, style: StyleText.descriptionBold);
                    } else {
                      return const Text('usuario@gmail.com');
                    }
                  },
                ),
              ],
            ),
          ),
        ),
        ListTile(
          leading: const Icon(AppIcons.close),
          title: const Text('Cerrar Sesión'),
          onTap: () {
            _logger.d('Voy a cerrar sesión');
            GoogleService.disconnect();
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const LoginPage()));
          },
        ),
      ],
    );
  }
}
