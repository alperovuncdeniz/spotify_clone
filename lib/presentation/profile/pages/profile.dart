import 'package:flutter/material.dart';
import 'package:spotify_clone/common/helper/is_dark_mode.dart';
import 'package:spotify_clone/common/widgets/appbar/app_bar.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BasicAppbar(
        backgroundColor: const Color(0xff2C2B2B),
        title: Text(
          "Profile",
        ),
      ),
      body: Column(
        children: [
          _profileInfo(context),
        ],
      ),
    );
  }

  Widget _profileInfo(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height / 3.5,
      decoration: BoxDecoration(
          color: context.isDarkMode ? const Color(0xff2C2B2B) : Colors.white,
          borderRadius: const BorderRadius.only(
            bottomRight: Radius.circular(30),
            bottomLeft: Radius.circular(30),
          )),
    );
  }
}
