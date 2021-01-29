import 'package:flutter/material.dart';
import 'package:unitrade_website/shared/constants.dart';
import 'package:url_launcher/url_launcher.dart';

class FooterWidget extends StatefulWidget {
  @override
  _FooterWidgetState createState() => _FooterWidgetState();
}

class _FooterWidgetState extends State<FooterWidget> {
  @override
  Widget build(BuildContext context) {
    return _buildPageFooter();
  }

  //build website footer
  Widget _buildPageFooter() {
    double _footerWidth = MediaQuery.of(context).size.width;
    double borderWidth = 2.0;
    double elevation = 1.0;
    return Container(
      child: Stack(alignment: Alignment.center, children: [
        Container(
          height: 300,
          width: _footerWidth,
          color: Colors.orange,
        ),
        Container(
          height: 280.0,
          width: _footerWidth,
          color: Colors.grey,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                children: [
                  Padding(
                    padding: EdgeInsets.all(15.0),
                    child: Stack(alignment: Alignment.center, children: [
                      Container(
                        height: 80.0,
                        width: 270.0,
                        color: Colors.black,
                      ),
                      Container(
                          height: 75.0,
                          child: Card(
                              elevation: 10.0,
                              color: Colors.transparent,
                              child:
                                  Image.asset('assets/images/small_logo.jpg'))),
                    ]),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        flex: 1,
                        child: Text(
                          'Al Khobar head office:',
                          textAlign: TextAlign.end,
                          style: textStyleParagraph5,
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Text(
                          'Al-Riyadh Branch:',
                          textAlign: TextAlign.end,
                          style: textStyleParagraph5,
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Text(
                          'Jeddah Branch:',
                          textAlign: TextAlign.end,
                          style: textStyleParagraph5,
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Text(
                          'Contact Us:',
                          textAlign: TextAlign.end,
                          style: textStyleParagraph5,
                        ),
                      ),
                    ]),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        flex: 1,
                        child: Container(
                          child: Material(
                            color: Colors.transparent,
                            child: InkWell(
                              hoverColor: Colors.red,
                              onTap: () {
                                print('tab');
                              },
                              onHover: (value) {
                                setState(() {
                                  borderWidth = 5.0;
                                  elevation = 5.0;
                                });
                              },
                              child: Text(
                                'Tel. +966 (13) 829 8370\nFax +966 (13) 829 8778\n' +
                                    'P. O. Box 70100\nAl-Khobar 31952 Saudi Arabia',
                                style: textStyleParagraph6,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Container(
                            child: Material(
                          color: Colors.transparent,
                          child: InkWell(
                            hoverColor: Colors.red,
                            onTap: () {
                              print('tab');
                            },
                            child: Text(
                              'Tel. +966 (01) 244 1956\n' +
                                  'P.O. Box 9891\nAl-Riyad 11513 Saudi Arabia',
                              style: textStyleParagraph6,
                            ),
                          ),
                        )),
                      ),
                      Expanded(
                        flex: 1,
                        child: Container(
                          child: Material(
                            color: Colors.transparent,
                            child: InkWell(
                              hoverColor: Colors.red,
                              onTap: () {
                                print('tab');
                              },
                              child: Text(
                                'Tel. +966 (12) 623 7701\n' +
                                    'P.O. Box 1400\nJeddah 21643 Saudi Arabia',
                                style: textStyleParagraph6,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Container(
                          child: Material(
                            color: Colors.transparent,
                            child: InkWell(
                              hoverColor: Colors.red,
                              onTap: () async {
                                if (await canLaunch('http://www.unitrade.com.sa'))
                                  await launch('http://www.unitrade.com.sa');
                              },
                              child: Text(
                                '+966 (50) 1999 051\n' +
                                    'sales@nesma.com\n\n' +
                                    'www.unitrade.com.sa',
                                style: textStyleParagraph6,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ]),
              ),
            ],
          ),
        ),
      ]),
    );
  }
}

