import 'dart:ffi';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:logger/logger.dart';
import 'package:mi_reclamo/core/core.dart';
import 'package:mi_reclamo/features/data/data_sources/google/google_service.dart';
import 'package:mi_reclamo/features/data/data_sources/local/storage_service.dart';
import 'package:mi_reclamo/features/presentation/pages/login/login_page.dart';
import 'package:mi_reclamo/features/presentation/pages/test/test_page.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  ProfilePageState createState() => ProfilePageState();
}

class ProfilePageState extends State<ProfilePage> {
  static final Logger _logger = Logger();

  String capitalize(String input) {
    if (input.isEmpty) return input;
    return input
        .split(' ')
        .map((str) => str[0].toUpperCase() + str.substring(1).toLowerCase())
        .join(' ');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const TopNavigation(title: 'Perfil', isMainScreen: true),
      body: ListView(
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
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        'assets/large-logo-app.svg',
                        height: 70,
                      ),
                      const SizedBox(height: 12),
                      const SizedBox(width: 12),
                      FutureBuilder<String>(
                        future: StorageService.getValue('image'),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.done) {
                            final String photoUrl = snapshot.data ?? '';
                            if (photoUrl.isNotEmpty) {
                              return Column(
                                children: [
                                  const SizedBox(width: 12),
                                  CircleAvatar(
                                    radius: 60,
                                    backgroundImage:
                                        CachedNetworkImageProvider(photoUrl),
                                  ),
                                ],
                              );
                            } else {
                              return const Column(
                                children: [
                                  SizedBox(width: 12),
                                  CircleAvatar(
                                      radius: 60, child: Icon(Icons.person_2)),
                                ],
                              );
                            }
                          } else if (snapshot.hasError) {
                            return const Column(
                              children: [
                                SizedBox(width: 12),
                                CircleAvatar(
                                    radius: 60, child: Icon(Icons.person)),
                              ],
                            );
                          } else {
                            return const Column(
                              children: [
                                SizedBox(width: 12),
                                CircleAvatar(
                                    radius: 60,
                                    child: CircularProgressIndicator()),
                              ],
                            );
                          }
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  FutureBuilder<String>(
                    future: StorageService.getValue('name'),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.done) {
                        final String name = snapshot.data ?? '';
                        return Text(capitalize(name),
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
            leading: const Icon(AppIcons.info),
            title: const Text('Cargar Modelos de Prueba'),
            onTap: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => TestPage()));
            },
          ),
          ListTile(
            leading: const Icon(AppIcons.close),
            title: const Text('Cerrar Sesión'),
            onTap: () {
              _logger.d('Cerrando Sesión');
              GoogleService.disconnect();
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const LoginPage()));
            },
          ),
        ],
      ),
    );
  }
}
