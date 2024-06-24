import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class CreditsDialog extends StatelessWidget {
  const CreditsDialog({Key? key}) : super(key: key);

  void _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      title: Image.asset(
        "assets/images/skull-wide.png",
        height: 60,
      ),
      backgroundColor: const Color(0xff1a1a1a),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(0)),
      ),
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                const Text(
                  'Super Earth Federation extends its gratitude to the following citizens \nfor their great contributions to the war effort:',
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.white),
                ),
                const SizedBox(height: 10),
                const Text(
                  'Developers of the Helldivers Companion for their amazing project',
                  style: TextStyle(color: Colors.white),
                ),
                GestureDetector(
                  onTap: () => _launchURL('https://helldiverscompanion.com'),
                  child: const Text(
                    '  helldiverscompanion.com',
                    style: TextStyle(
                        color: Color(0xffffe80a),
                        decoration: TextDecoration.underline),
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  'Nvigneux for sharing his Stratagems icons with the community',
                  style: TextStyle(color: Colors.white),
                ),
                GestureDetector(
                  onTap: () => _launchURL(
                      'https://github.com/nvigneux/Helldivers-2-Stratagems-icons-svg'),
                  child: const Text(
                    '  Repository: Helldivers 2 Stratagems Icons',
                    style: TextStyle(
                        color: Color(0xffffe80a),
                        decoration: TextDecoration.underline),
                  ),
                ),
                GestureDetector(
                  onTap: () =>
                      _launchURL('https://stratagem-hero-trainer.vercel.app/'),
                  child: const Text(
                    '  Check Strategem Hero Trainer!',
                    style: TextStyle(
                      color: Color(0xffffe80a),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  'Creators of Helldivers 2, Arrowhead Game Studios.',
                  style: TextStyle(color: Colors.white),
                ),
                const SizedBox(height: 10),
                const Text(
                  'To all the brave Helldivers who have fought and died for Super Earth!',
                  style: TextStyle(color: Colors.white),
                ),
                const SizedBox(height: 10),
                Image.asset(
                  "assets/images/diver_hug.gif",
                  width: 120.0,
                ),
                const Align(
                  alignment: Alignment.bottomRight,
                  child: Text(
                    'See you Space Cowboys!',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ),
        OverflowBar(
          alignment: MainAxisAlignment.end,
          children: <Widget>[
            TextButton(
              child: const Text('Close',
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold)),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        ),
      ],
    );
  }
}
