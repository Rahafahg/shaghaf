import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:shaghaf/constants/constants.dart';
import 'package:shaghaf/data_layer/auth_layer.dart';
import 'package:shaghaf/extensions/screen_nav.dart';
import 'package:shaghaf/extensions/screen_size.dart';
import 'package:shaghaf/screens/auth_screens/login_screen.dart';
import 'package:shaghaf/widgets/cards/profile_card.dart';
import 'package:shaghaf/widgets/chapes/profile_shape.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final user = GetIt.I.get<AuthLayer>().user;
    return Scaffold(
      backgroundColor: Constants.backgroundColor,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: context.getWidth(),
            height: context.getHeight(divideBy: 3.5),
            child: Stack(
              children: [
                CustomPaint(
                  size: Size(context.getWidth(), 200),
                  painter: RPSCustomPainter(width: context.getWidth()),
                ),
                //--> profile image Avatar for orgnazire
                // Positioned(
                //     bottom: 0,
                //     left: 10,
                //     right: 10,
                //     child: CircleAvatar(
                //         backgroundColor: Colors.black,
                //         radius: 46,
                //         child: Image.asset(
                //             "assets/images/default_organizer_image.png")))
              ],
            ),
          ),
          Text(
            "${user?.firstName}${user?.lastName}",
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w500,
              color: Constants.textColor,
              fontFamily: "Poppins",
            ),
          ),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ProfileCard(text: user?.phoneNumber ?? "", icon: Icons.phone),
                ProfileCard(text: user?.email ?? "", icon: Icons.mail),
                const SizedBox(height: 10),
                const Text("Settings",
                    style: TextStyle(
                      fontSize: 18,
                      color: Color(0xff666666),
                      fontFamily: "Poppins",
                    )),
                const SizedBox(height: 30),
                const ProfileCard(
                    text: "Switch to Arabic", icon: Icons.translate),
                const ProfileCard(text: "Mode", icon: Icons.dark_mode),
              ],
            ),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
              style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5)),
                  shadowColor: const Color.fromARGB(104, 222, 101, 49),
                  foregroundColor: Constants.appRedColor,
                  backgroundColor: Constants.profileColor,
                  elevation: 8,
                  fixedSize: const Size(130, 34)),
              onPressed: () {
                GetIt.I.get<AuthLayer>().user = null;
                GetIt.I.get<AuthLayer>().box.erase();
                context.pushRemove(screen: const LoginScreen());
              },
              child: const Row(
                children: [
                  Icon(HugeIcons.strokeRoundedLogout01),
                  SizedBox(width: 5),
                  Text("Logout"),
                ],
              ))
        ],
      ),
    );
  }
}
