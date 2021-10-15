import 'package:flutter/material.dart';
import 'package:movies_app/providers/localization_provider.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import 'package:movies_app/helpers/token.dart';
import 'package:movies_app/providers/auth_provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
    final localizationProvider = Provider.of<LocalizationProvider>(
      context,
      listen: false,
    );
    final localization = AppLocalizations.of(context);

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
          SizedBox(
            height: windowsHeight * 0.1,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              InkWell(
                onTap: () {
                  if (localizationProvider.locale != const Locale("bs")) {
                    localizationProvider.setLocale(
                      const Locale('bs'),
                    );
                  }
                },
                child: Stack(
                  children: [
                    SvgPicture.asset(
                      'assets/images/ba.svg',
                      height: 30,
                    ),
                    if (localizationProvider.locale == const Locale("bs"))
                      Positioned(
                        top: -10,
                        left: -3,
                        child: Container(
                          color: const Color.fromRGBO(255, 255, 255, 0.6),
                          child: const Icon(
                            Icons.check,
                            size: 50,
                            color: Colors.green,
                          ),
                        ),
                      ),
                  ],
                ),
              ),
              const SizedBox(
                width: 20,
              ),
              InkWell(
                onTap: () {
                  if (localizationProvider.locale != const Locale("en")) {
                    localizationProvider.setLocale(
                      const Locale('en'),
                    );
                  }
                },
                child: Stack(
                  children: [
                    SvgPicture.asset(
                      'assets/images/en.svg',
                      height: 30,
                    ),
                    if (localizationProvider.locale == const Locale("en"))
                      Positioned(
                        top: -10,
                        left: -3,
                        child: Container(
                          color: const Color.fromRGBO(255, 255, 255, 0.6),
                          child: const Icon(
                            Icons.check,
                            size: 50,
                            color: Colors.green,
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ],
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
                            Navigator.of(context).pushReplacementNamed("login"),
                      );
                },
                child: Text(localization!.logout),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
