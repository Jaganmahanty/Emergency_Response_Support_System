//import 'package:fff/Utils/constants.dart';
//import 'constants.dart';
import 'package:flutter/material.dart';

import '../../constants.dart';

class AboutUsScreen extends StatefulWidget {
  const AboutUsScreen({super.key});

  @override
  State<AboutUsScreen> createState() => _AboutUsScreenState();
}

class _AboutUsScreenState extends State<AboutUsScreen> {
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 1650)).then((value) {
      setState(() {
        isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 50,
        backgroundColor: color_AppBar,
        centerTitle: true,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(25),
                bottomLeft: Radius.circular(25))),
        title: const Text("About Us"),
      ),
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : SingleChildScrollView(
              child: Container(
                padding: const EdgeInsets.only(
                    left: 22, top: 5, right: 22, bottom: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 25),
                          child: Container(
                            height: 130,
                            width: 130,
                            color: Colors.transparent,
                            margin: const EdgeInsets.all(16),
                            child: FutureBuilder(
                              future: _loadImage(),
                              builder: (BuildContext context,
                                  AsyncSnapshot<Image> snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return const Center(
                                    child:
                                        CircularProgressIndicator(),
                                  );
                                } else if (snapshot.hasError) {
                                  return const Center(
                                    child: Text(
                                        'Error loading image'),
                                  );
                                } else {
                                  return snapshot.data!;
                                }
                              },
                            ),
                          ),
                        ),
                        Container(
                          alignment: Alignment.center,
                          height: 80,
                          width: 80,
                          color: Colors.transparent,
                          margin: const EdgeInsets.all(18),
                          child: const Text(
                            'Safety\nAssistant',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                              color: Color(0xff7871db),
                              //decoration: TextDecoration.underline,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const Text(
                      'Emergency Response Support System',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 30.0),
                    const Text(
                      'The application is designed to help citizen in any disasters or emergency situations. ',
                      textAlign: TextAlign.justify,
                      softWrap: true,
                      style: TextStyle(fontSize: 14.0, wordSpacing: 0.0),
                    ),
                    const SizedBox(height: 10.0),
                    const Text(
                      'Disaster Response',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontSize: 15.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10.0),
                    const Text(
                      'If there is any disaster occurs in Nation, then we are sure to help every '
                      'citizen who are going to affect with it. We had collaborated with NGOs '
                      'and different Government Agencies who works on disaster response field. '
                      'These agencies are committed to work on response support with their '
                      'full efficiency. May this can help to minimize the impact of the disaster.',
                      textAlign: TextAlign.justify,
                      softWrap: true,
                      style: TextStyle(fontSize: 14.0, wordSpacing: 0.0),
                    ),
                    const SizedBox(height: 10.0),
                    const Text(
                      'Emergency Response',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontSize: 15.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10.0),
                    const Text(
                      'Apart from disaster, there can be emergency situation (like accidents, '
                      'fire broke out, etc) nearby you, here also you can request for the help to '
                      'NGOs and Government Agencies. And surely, they will come nearby you '
                      'to help in this emergency.',
                      textAlign: TextAlign.justify,
                      softWrap: true,
                      style: TextStyle(fontSize: 14.0, wordSpacing: 0.0),
                    ),
                    const SizedBox(height: 15.0),
                    const Divider(
                      height: 1,
                    ),
                    const SizedBox(height: 15.0),
                    const Text(
                      'Our Mission',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontSize: 15.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10.0),
                    const Text(
                      'Our mission is helping people before, during and after disasters, and our '
                      'core values and goals help us achieve it. Our Objective is helping people '
                      'achieve coherent warning alerts, without major disruption and minimal '
                      'expense. The better people are informed about a hazard threat or  '
                      'emergency, the more lives can be saved and resources preserved.',
                      textAlign: TextAlign.justify,
                      softWrap: true,
                      style: TextStyle(fontSize: 14.0, wordSpacing: 0.0),
                    ),
                    const SizedBox(height: 15.0),
                    const Divider(
                      height: 1,
                    ),
                    const SizedBox(height: 15.0),
                    const Text(
                      'Our Vision',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontSize: 15.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10.0),
                    const Text(
                      '"To build a safer and disaster resilient India by a holistic, pro-active, technology '
                      'driven and sustainable development strategy that involves all stakeholders and '
                      'fosters a culture of prevention, preparedness and mitigation."',
                      textAlign: TextAlign.justify,
                      softWrap: true,
                      style: TextStyle(fontSize: 14.0, wordSpacing: 0.1),
                    ),
                    const SizedBox(height: 15.0),
                    const Divider(
                      height: 1,
                    ),
                    const SizedBox(height: 15.0),
                    const Text(
                      'Acknowledgments',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontSize: 15.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10.0),
                    const Text(
                      'First and foremost, we express our appreciation to the developers '
                      'and engineers whose tireless efforts have brought this application to '
                      'fruition. Their technical prowess, innovative thinking, and unwavering '
                      'commitment have been instrumental in creating a platform that can potentially '
                      'save lives and mitigate the impact of disasters.',
                      textAlign: TextAlign.justify,
                      softWrap: true,
                      style: TextStyle(fontSize: 14.0, wordSpacing: 0.1),
                    ),
                    const SizedBox(height: 6.0),
                    const Text(
                      'Last but not least,'
                      'we thank the users of the CAS for their trust and engagement. It is their willingness '
                      'to embrace new technologies and adopt proactive measures that ultimately drive the success '
                      'and effectiveness of this initiative.',
                      textAlign: TextAlign.justify,
                      softWrap: true,
                      style: TextStyle(fontSize: 14.0, wordSpacing: 0.1),
                    ),
                    const SizedBox(height: 15.0),
                    const Divider(
                      height: 1,
                    ),
                    const SizedBox(height: 15.0),
                    const Text(
                      'Our Logo',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontSize: 15.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10.0),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          alignment: Alignment.topLeft,
                          height: 160,
                          width: 160,
                          color: Colors.transparent,
                          //margin: const EdgeInsets.all(18),
                          child: const Text(
                            'Our Logo reflects the aspirations of '
                            'this National Vision, of empowering all '
                            'stakeholders to improve the effectiveness '
                            'of Disaster Management in India. ',
                            textAlign: TextAlign.justify,
                            softWrap: true,
                            style: TextStyle(fontSize: 14.0, wordSpacing: 0.1),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 20, right: 10, bottom: 25, top: 10),
                          child: Container(
                            alignment: Alignment.centerRight,
                            height: 120,
                            width: 120,
                            color: Colors.transparent,
                            //margin: const EdgeInsets.all(16),
                            child: Image.asset(
                              'assets/images/logo.png',
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const Text(
                      'The Map of India, embossed in gold, in the middle of the logo, circumscribed by  '
                      'the National Tricolor of Saffron, White and Green represents the aspiration to contain '
                      'the potential threat of natural and man-made disasters through Capacity Development '
                      'of all stakeholders. The outer circle is a Golden Ring of Partnership of all Stakeholders, '
                      'whose hand holding is an expression of their solidarity to supplement the efforts of the '
                      'Government. ERSS in the inner circle in tranquil Blue integrates the entire process by '
                      'empowering all stakeholders at the local, district, state and national levels. we will catalyze '
                      'this Community Empowerment through institutional capacity development, strengthened '
                      'public awareness and community resilience by mainstreaming disaster management in India.',
                      textAlign: TextAlign.justify,
                      softWrap: true,
                      style: TextStyle(fontSize: 14.0, wordSpacing: 0.1),
                    ),
                    const SizedBox(height: 15.0),
                    const Divider(
                      height: 1,
                    ),
                    const SizedBox(height: 15.0),
                    const Text(
                      'Contact Us',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontSize: 15.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10.0),
                    const Text(
                      'Postal Address : NDMA Bhawan\n'
                      '                             A-1, Safdarjung Enclave\n'
                      '                             New Delhi - 110029',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontSize: 15.0,
                      ),
                    ),
                    const SizedBox(height: 10.0),
                    const Text(
                      'Telephones : +91-11-26701700\n'
                      '                       (Mon-Fri - 9:30AM-6:00PM)\n'
                      'Control Room: +91-11-26701728 \n'
                      '                           (Mon-Fri 24X7)',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontSize: 15.0,
                      ),
                    ),
                    const SizedBox(height: 10.0),
                    const Text(
                      'Fax : +91-11-26701729',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontSize: 15.0,
                      ),
                    ),
                    const SizedBox(height: 10.0),
                    const Text(
                      'E-mail : controlroom@ndma.gov.in',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontSize: 15.0,
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }

  Future<Image> _loadImage() async {
    final image = Image.asset(
      'assets/images/logo.png',
      fit: BoxFit.cover,
    );
    await Future.delayed(const Duration(milliseconds: 800));
    return image;
  }
}
