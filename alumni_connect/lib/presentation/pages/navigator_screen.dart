import 'package:alumni_connect/presentation/pages/home_page.dart';
import 'package:alumni_connect/presentation/pages/jobs_portal_screen.dart';
import 'package:alumni_connect/presentation/pages/network_screen.dart';
import 'package:alumni_connect/presentation/pages/profile_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NavigatorScreen extends StatefulWidget {
  const NavigatorScreen({super.key, required this.user});

  final Map<String, dynamic> user;

  static Route getRoute(Map<String, dynamic> user) {
    return MaterialPageRoute(
      builder: (context) => NavigatorScreen(
        user: user,
      ),
    );
  }

  @override
  State<NavigatorScreen> createState() => _NavigatorScreenState();
}

class _NavigatorScreenState extends State<NavigatorScreen> {
  int _index = 0;
  late final List<Widget> screens;
  @override
  void initState() {
    super.initState();
    screens = [
      const HomePage(),
      const NetworkScreen(),
      const JobsPortalScreen(),
      ProfileScreen(user: widget.user),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(80),
        child: Column(
          children: [
            const SizedBox(
              height: 12,
            ),
            AppBar(
              title: Row(
                children: [
                  Image.asset('assets/images/image_logo.png', height: 30),
                  const SizedBox(width: 8),
                  Text(
                    'Welcome! ${widget.user['first name']}',
                  ),
                ],
              ),
              actions: [
                IconButton(
                  icon: const Icon(
                    CupertinoIcons.money_dollar_circle,
                    size: 30,
                  ),
                  onPressed: () {},
                ),
                const SizedBox(
                  width: 10,
                ),
                IconButton(
                    icon: const Icon(
                      Icons.notifications_outlined,
                      size: 30,
                    ),
                    onPressed: () {}),
                const SizedBox(
                  width: 20,
                )
              ],
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _index,
        onTap: (value) {
          setState(() {
            _index = value;
          });
        },
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Network'),
          BottomNavigationBarItem(icon: Icon(Icons.work), label: 'Jobs'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
      body: LayoutBuilder(builder: (context, constraints) {
        return Container(
          height: constraints.maxHeight,
          width: constraints.maxWidth,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [
                Color(0xFF666B73),
                Color(0xFF232426),
              ],
            ),
          ),
          child: screens[_index],
        );
      }),
    );
  }
}
