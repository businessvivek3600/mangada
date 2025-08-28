
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../routes/route_name.dart';


class DeleteAccountScreen extends StatelessWidget {
  const DeleteAccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final reasons = [
      "I don’t want to use Zomato anymore",
      "I’m using another account",
      "I’m worried about my privacy",
      "You’re sending me too many notifications",
      "The app is not working properly",
      "Other",
    ];

    return Scaffold(
      appBar: AppBar(title: const Text("Delete Account"), centerTitle: true),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: ListView.separated(
          itemCount: reasons.length,
          separatorBuilder: (_, __) => Column(
            children: [
              SizedBox(height: 10,),
              const Divider(height: 1),
              SizedBox(height: 10,),
            ],
          ),
          itemBuilder: (context, index) {
            return ListTile(
              contentPadding: EdgeInsets.zero,
              title: Text(reasons[index]),
              onTap: () {
                context.pushNamed(
                  Routes.deleteReason,
                  extra: reasons[index],
                );
              },
            );
          },
        ),
      ),
    );
  }
}
class DeleteReasonScreen extends StatelessWidget {
  final String reason;
  const DeleteReasonScreen({super.key, required this.reason});

  @override
  Widget build(BuildContext context) {
    final controller = TextEditingController(text: reason);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Delete Account"),
        centerTitle: true,
        actions: [
          TextButton(
            onPressed: () {
              // TODO: Handle deletion API
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("Delete request submitted")),
              );
              Navigator.pop(context);
            },
            child: const Text("Next"),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: TextField(
          controller: controller,
          maxLines: null,
          decoration: const InputDecoration(border: InputBorder.none),
        ),
      ),
    );
  }
}