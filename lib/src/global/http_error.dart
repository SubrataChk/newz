import 'package:flutter/material.dart';
import 'package:newz/src/widget/error_show.dart';

class HttpException implements Exception {
  final String codeMessage;
  BuildContext context;
  HttpException({required this.codeMessage, required this.context});

  String get getNewsApiErrorMSG {
    if (codeMessage.contains("apiKeyDisabled")) {
      showMessage("Your API Key has been disabled", context);
    } else if (codeMessage.contains("apiKeyExhausted")) {
      showMessage("Your API key has no more request", context);
    } else if (codeMessage.contains("apiKeyInvalid")) {
      showMessage(
          "Your API key hasn't been entered correctly. Double check it and try again",
          context);
    } else if (codeMessage.contains("apiKeyMissing")) {
      showMessage("Your API key is missing from the request.", context);
    } else if (codeMessage.contains("parameterInvalid")) {
      showMessage(
          "You've include a parameter in your request which is currently not support",
          context);
    } else if (codeMessage.contains("parametersMissing")) {
      showMessage("Required parameter are missing", context);
    } else if (codeMessage.contains("rateLimited")) {
      showMessage("You have been rate limited", context);
    } else if (codeMessage.contains("sourcesTooMany")) {
      showMessage(
          "You have requested too many sources in a single request. Try splitting the request into 2 smaller requests.",
          context);
    } else if (codeMessage.contains("sourceDoesNotExist")) {
      showMessage("You have requested a source which does not exist.", context);
    } else if (codeMessage.contains("unexpectedError")) {
      showMessage(
          "This shouldn't happen, and if it does then it's our fault, not yours. Try the request again shortly.",
          context);
    }
    return "";
  }

  @override
  String toString() {
    return codeMessage;
  }
}
