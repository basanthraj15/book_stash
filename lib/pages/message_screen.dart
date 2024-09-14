import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class MessageScreen extends StatefulWidget {
  const MessageScreen({super.key});

  @override
  State<MessageScreen> createState() => _MessageScreenState();
}

Map payloadContent = {};

class _MessageScreenState extends State<MessageScreen> {
  @override
  Widget build(BuildContext context) {
    //to get routes info
    final data = ModalRoute.of(context)!.settings.arguments;

    //check notification background and terminated state

    //background terminated
    if (data is RemoteMessage) {
      payloadContent = data.data;
    }

    //foreground state
    if (data is NotificationResponse) {
      //decode to json
      payloadContent = jsonDecode(data.payload!);
    }

    //access using key

    String firstKey = payloadContent.keys.first;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Notifications",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(8),
          child: Column(
            children: [
              SizedBox(height: 10),
              SizedBox(
                width: double.infinity,
                height: 100,
                child: Card(
                  color: Colors.amber,
                  elevation: 10,
                  child: Padding(
                    padding: EdgeInsets.all(8),
                    child: Text(
                      "BookName : $firstKey",
                      style: TextStyle(fontSize: 21, color: Colors.white),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              SizedBox(
                width: double.infinity,
                height: 100,
                child: Card(
                  color: Colors.amber,
                  elevation: 10,
                  child: Padding(
                    padding: EdgeInsets.all(8),
                    child: Text(
                      "Price : ${payloadContent[firstKey]}",
                      style: TextStyle(fontSize: 21, color: Colors.white),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
