import 'package:flutter/material.dart';
import 'package:kipps_chatbot/kipps_chatbot.dart';

class JobsPortalScreen extends StatelessWidget {
  const JobsPortalScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const Center(
        child: Text('Job Portal'),
      ),
      floatingActionButton: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: const ChatbotIntegration(
          chatbotId: 'c948d814-9f8c-43e9-a244-ff19b6b4404f',
        ),
      ),
    );
  }
}
