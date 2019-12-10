import 'package:flutter/material.dart';
import 'package:flutter_places/src/models/place_model.dart';
import 'package:flutter_places/src/repository/user_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MenuLateral extends StatelessWidget {
  UserRepository _userRepository = new UserRepository();


  @override
  Widget build(BuildContext context) {
    Future<void> _logout() async {
      try {
        await _userRepository.signOut();

        switch (_userRepository.status) {
          case Status.Uninitialized:
            return Navigator.pushReplacementNamed(context, 'login');
          case Status.Unauthenticated:
            return Navigator.pushReplacementNamed(context, 'home');
          case Status.Authenticating:
            return Navigator.pushReplacementNamed(context, 'home');
          case Status.Authenticated:
            return Navigator.pushReplacementNamed(context, 'home');
        }
      } catch (error) {
        print("No hay conexion con el servidor $error");
      }
    }

    return new Drawer(
      child: ListView(
        children: <Widget>[
          new UserAccountsDrawerHeader(
            accountName: null,
            accountEmail: Text((_userRepository.user != null)
                ? "${_userRepository.user}"
                : ""),
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: NetworkImage(
                        "https://ichef.bbci.co.uk/news/660/cpsprodpb/6AFE/production/_102809372_machu.jpg"),
                    fit: BoxFit.cover)),
          ),
          
          ListTile(
              title: Text("Leer QR"),
              onTap: () => Navigator.pushNamed(context, 'qrscan')),
          ListTile(
            title: Text((_userRepository.status == Status.Unauthenticated)
                ? "Inicio Sesión"
                : "Cerrar Sesión"),
            onTap: () {
              (_userRepository.status == Status.Unauthenticated)
                  ? Navigator.pushReplacementNamed(context, 'login')
                  : _logout();
            },
          ),
          ListTile(
              title: Text((_userRepository.status == Status.Unauthenticated)
                  ? ""
                  : "Favoritos"),
              onTap: () async {

                SharedPreferences prefs = await SharedPreferences.getInstance();
                String user = prefs.getString('userId');
                print('user');
                print(user);

                Navigator.pushNamed(context, "favorites", arguments: user);
              }),
        ],
      ),
    );
  }
}
