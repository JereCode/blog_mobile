import 'package:blog_mobile/pages/login/loginCtrl.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
class Login extends ConsumerStatefulWidget {
  @override
  ConsumerState<Login> createState() => _LoginState();
}

class _LoginState extends ConsumerState<Login> {
  @override
  Widget build(BuildContext context) {
    var state = ref.watch(loginCtrlProvider);
    return Scaffold(
      appBar: AppBar(title: Text('Connexion')),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextField(
                decoration: InputDecoration(
                  hintText: 'Adresse Mail',
                  border: OutlineInputBorder(),
                ),
                onChanged: (newEmail) {},
              ),
              SizedBox(height: 10),
              TextField(
                decoration: InputDecoration(
                  labelText: "Mot de passe",
                  hintText: 'Mot de Passe',
                  border: OutlineInputBorder(),
                ),
                obscureText: true,
              ),
              SizedBox(height: 20),




              ElevatedButton(
                onPressed: () {
                  var ctrl = ref.read(loginCtrlProvider.notifier);
                  ctrl.soumettreFormulaire();
                },
                child: Text(
                  state.isLoading==true? "Chargement..." : 'Se connecter'
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}