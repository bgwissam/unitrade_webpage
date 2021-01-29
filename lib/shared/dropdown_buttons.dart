import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class contactUsCategories {
  static List<String> targetList() {
    return [
      'Customer Service',
      'Sales Team',
      'Finance Team',
    ];
  }
}

class sisterCompaniesList {
  static List<String> companiesList() {
    return [
      'DOW Co.',
      'EMAAR Co.',
    ];
  }
}

class DropDown extends StatelessWidget {
  final double itemHeight;
  DropDown({this.itemHeight});

  @override
  Widget build(BuildContext context) {
    List<String> listOfCompanies = sisterCompaniesList.companiesList();
    return Column(
      children: [
        SizedBox(
          height: 30.0,
        ),
        Material(
          borderRadius: BorderRadius.circular(10),
          color: Colors.blueGrey[300],
          elevation: 20.0,
          child: Container(
              height: 4 * itemHeight,
              child: ListView.builder(
                itemCount: listOfCompanies.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    child: ListTile(
                      title: Text(listOfCompanies[index]),
                      hoverColor: Colors.red,
                      onTap: () {
                        print(index);
                      },
                    ),
                  );
                },
              )),
        )
      ],
    );
  }
}

class ArrowClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.moveTo(0, size.height);
    path.lineTo(size.width / 2, 0);
    path.lineTo(size.width, size.height);

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => true;
}
