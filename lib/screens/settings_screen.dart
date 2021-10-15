import 'package:flutter/material.dart';
import 'package:movies_app/helpers/token.dart';
import 'package:movies_app/providers/auth_provider.dart';
import 'package:provider/provider.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    final double windowsHeight = MediaQuery.of(context).size.height;
    final theme = Theme.of(context).textTheme;

    return Padding(
      padding: const EdgeInsets.only(left: 22.0, right: 22.0, top: 30.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const Align(
            alignment: Alignment.center,
            child: CircleAvatar(
              backgroundColor: Colors.brown,
              radius: 100,
              child: Icon(
                Icons.person,
                size: 150,
                color: Colors.white,
              ),
            ),
          ),
          SizedBox(
            height: windowsHeight * 0.05,
          ),
          FutureBuilder(
            future: Token.decodeJWT(),
            builder: (context, AsyncSnapshot<Map<String, dynamic>?> snapshot) =>
                snapshot.connectionState == ConnectionState.waiting
                    ? const Center()
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            snapshot.data!['firstName'],
                            style: theme.bodyText1,
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Text(
                            snapshot.data!['lastName'],
                            style: theme.bodyText1,
                          ),
                        ],
                      ),
          ),
          Expanded(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: TextButton(
                onPressed: () async {
                  Provider.of<AuthProvider>(context, listen: false)
                      .logOut()
                      .then(
                        (value) =>
                            Navigator.of(context).pushReplacementNamed("/"),
                      );
                },
                child: Text("Odjavi me"),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
