// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:url_shortner_flutter/models/url_shortener_state.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    //?? controller ->
    final urlController = TextEditingController();

    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(30.0),
        width: double.infinity,
        child: Column(
          children: [
            const Spacer(),
            const Text(
              'URL Shortener',
              style: TextStyle(
                fontSize: 36.0,
                color: Colors.tealAccent,
                fontFamily: 'poppins_bold',
              ),
            ),
            const Text(
              'Shorten any long URL',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 60.0),

            //?? textfield ->
            TextField(
              controller: urlController,
              style: const TextStyle(
                color: Colors.white,
                fontFamily: 'poppins_bold',
              ),
              decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25.0),
                  borderSide: const BorderSide(
                    color: Colors.transparent,
                  ),
                ),
                filled: true,
                fillColor: Colors.blueGrey,
                hintText: 'Paste your URL here',
                hintStyle: const TextStyle(
                  color: Colors.white,
                  fontFamily: 'poppins',
                ),
              ),
            ),
            const Spacer(),

            //*** button ->
            ElevatedButton(
              onPressed: () async {
                final shortenedUrl = await shortenUrl(
                  url: urlController.text,
                );
                //*** showing the link in alert dialog box */
                if (shortenedUrl != null) {
                  showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: const Text('url shortened'),
                          content: SizedBox(
                            height: 100.0,
                            child: Column(
                              
                              children: [
                                Row(
                                  
                                  children: [
                                    GestureDetector(
                                      onTap: () async {
                                        if (await canLaunchUrl(
                                            Uri.parse(shortenedUrl))) {
                                          await launchUrl(
                                              Uri.parse(shortenedUrl));
                                        } else {
                                          throw 'Could not launch $shortenedUrl';
                                        }
                                      },
                                      child: Text(shortenedUrl),
                                    ),
                                    IconButton(
                                      onPressed: () {
                                        Clipboard.setData(
                                          ClipboardData(
                                            text: shortenedUrl,
                                          ),
                                        ).then(
                                          (_) => ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            const SnackBar(
                                              content: Text(
                                                'copied',
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                      icon: const Icon(
                                        Icons.copy,
                                      ),
                                    ),
                                  ],
                                ),
                                ElevatedButton.icon(
                                  onPressed: () {
                                    urlController.clear();
                                    Navigator.pop(context);
                                  },
                                  icon: const Icon(Icons.close),
                                  label: const Text(
                                    'closed',
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      });
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.deepPurpleAccent,
                padding: const EdgeInsets.symmetric(
                  horizontal: 16.0,
                  vertical: 16.0,
                ),
                textStyle: const TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              child: const Text(
                'GET LINK',
              ),
            ),
            const SizedBox(height: 20.0),
          ],
        ),
      ),
    );
  }
}
