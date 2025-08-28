import 'dart:async';
import 'package:get/get.dart';
import '../../../core/constants/enums.dart';
import '../viewModel/chat_message.dart';

class HelpBotController extends GetxController {
  final RxList<ChatMessage> messages = <ChatMessage>[].obs;
  final RxBool botTyping = false.obs;
  final RxList<String> quickReplies = <String>[].obs;

  // Dummy last order info for demos
  final String demoOrderId = "#MD-724913";
  final String demoETA = "35–45 mins";

  @override
  void onInit() {
    super.onInit();
    _sendWelcome();
  }

  void _sendWelcome() async {
    quickReplies.assignAll([
      "Track my order",
      "I want a refund",
      "Change delivery address",
      "Payment issue",
      "Talk to a human",
      "Account & login",
    ]);
    await _botSay(
      "Hey! I’m Maddy 🤖\nHow can I help you today?",
      delayMs: 300,
    );
  }

  Future<void> onUserSend(String text) async {
    if (text.trim().isEmpty) return;
    _pushUser(text.trim());
    await _routeIntent(text.trim());
  }

  Future<void> onQuickReplyTap(String text) async {
    _pushUser(text);
    await _routeIntent(text);
  }

  void _pushUser(String text) {
    messages.add(ChatMessage(
      id: DateTime.now().microsecondsSinceEpoch.toString(),
      text: text,
      sender: Sender.user,
      createdAt: DateTime.now(),
    ));
  }

  Future<void> _botSay(String text, {int delayMs = 600}) async {
    botTyping.value = true;
    await Future.delayed(Duration(milliseconds: delayMs));
    messages.add(ChatMessage(
      id: DateTime.now().microsecondsSinceEpoch.toString(),
      text: text,
      sender: Sender.bot,
      createdAt: DateTime.now(),
    ));
    botTyping.value = false;
  }

  // Simple intent router (replace with NLP/API later)
  Future<void> _routeIntent(String text) async {
    final q = text.toLowerCase();

    if (_matchAny(q, ["track", "status", "order"])) {
      quickReplies.assignAll(["Share live status", "Cancel order", "Back"]);
      await _botSay(
        "Your last order $demoOrderId is on the way 🚴‍♂️\nETA: $demoETA.\n"
            "What would you like to do?",
      );
      return;
    }

    if (_matchAny(q, ["refund", "cancel"])) {
      quickReplies.assignAll(["Cancel order", "Refund policy", "Back"]);
      await _botSay(
        "I can help with refunds. If your order qualifies, the amount is returned to the original payment method within 3–5 business days.\n"
            "Do you want to cancel $demoOrderId?",
      );
      return;
    }

    if (_matchAny(q, ["address", "change address", "wrong address"])) {
      quickReplies.assignAll(["Update address", "Delivery partner call", "Back"]);
      await _botSay(
        "If the order hasn’t been picked up, you can still change the address.\n"
            "Pick one:",
      );
      return;
    }

    if (_matchAny(q, ["payment", "failed", "upi", "card"])) {
      quickReplies.assignAll(["Payment failed", "Refund status", "Back"]);
      await _botSay(
        "Payment troubles happen 😅\nTell me more about the issue or pick an option.",
      );
      return;
    }

    if (_matchAny(q, ["human", "agent", "support"])) {
      quickReplies.assignAll(["Chat with agent", "Call me back", "Back"]);
      await _botSay(
        "Connecting you to a human agent… this may take a moment ⏳",
      );
      return;
    }

    if (_matchAny(q, ["account", "login", "password"])) {
      quickReplies.assignAll(["Reset password", "Change phone/email", "Back"]);
      await _botSay(
        "Account & login—what do you want to do?",
      );
      return;
    }

    // Sub-intents (examples)
    if (_matchAny(q, ["share live status"])) {
      quickReplies.assignAll(["Cancel order", "Back"]);
      await _botSay("Here’s the live tracking link for $demoOrderId:\nhttps://track.example/$demoOrderId");
      return;
    }

    if (_matchAny(q, ["cancel order"])) {
      quickReplies.assignAll(["Confirm cancel", "Keep order", "Back"]);
      await _botSay("Are you sure you want to cancel $demoOrderId?");
      return;
    }

    if (_matchAny(q, ["confirm cancel"])) {
      quickReplies.assignAll(["Refund policy", "Back"]);
      await _botSay("Done! $demoOrderId is cancelled. Refund will reflect in 3–5 business days 💸");
      return;
    }

    if (_matchAny(q, ["back"])) {
      _sendWelcome();
      return;
    }

    // Fallback
    quickReplies.assignAll([
      "Track my order",
      "Payment issue",
      "Talk to a human",
      "Back",
    ]);
    await _botSay(
      "I didn’t fully get that. Try a quick option below or ask in a different way 🙂",
    );
  }

  bool _matchAny(String text, List<String> keys) {
    return keys.any((k) => text.contains(k));
  }
}
