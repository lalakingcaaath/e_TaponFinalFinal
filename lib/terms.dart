import 'package:flutter/material.dart';

class Terms extends StatelessWidget {
  const Terms({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Terms and Condition"),
        backgroundColor: Colors.green,
      ),
      body: Container(
        margin: const EdgeInsets.only(top: 20, left: 20, right: 20, bottom: 20),
        child: SingleChildScrollView(
          child: Column(
            children: const <Widget>[
              Text(
                "Thank you for using E-Tapon!"
                    "\n \n"
                    "These terms and conditions outline the rules and regulations for the use of E-Tapon's Mobile Application "
                    "By accessing this application we assume you accept these terms and conditions. "
                    "Do not continue to use E-Tapon if you do not agree to take all of the "
                    "terms and conditions stated on this page. \n"
                    "\n"
                    "The following terminology applies to these Terms and Conditions, "
                    "Privacy Statement and Disclaimer Notice and all Agreements: “Client”, "
                    "“You” and “Your” refers to you, the person log on this website and "
                    "compliant to the Company's terms and conditions. “The Company”, "
                    "“Ourselves”, “We”, “Our” and “Us”, refers to our Company. “Party”, "
                    "“Parties”, or “Us”, refers to both the Client and ourselves. All "
                    "terms refer to the offer, acceptance and consideration of payment "
                    "necessary to undertake the process of our assistance to the Client in "
                    "the most appropriate manner for the express purpose of meeting the "
                    "Client's needs in respect of provision of the Company's stated services, "
                    "Any use of the above terminology or other words in the singular, "
                    "plural, capitalization and/or he/she or they, are taken as interchangeable "
                    "and therefore as referring to same.",
                style: TextStyle(fontSize: 20),
              ),
            ],
          ),
        ),
      ),
    );
  }
}