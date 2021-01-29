import 'package:flutter/material.dart';
import 'package:unitrade_website/shared/constants.dart';
import 'package:unitrade_website/shared/dropdown_buttons.dart';
import 'package:unitrade_website/shared/string.dart';

class ContactUs extends StatefulWidget {
  @override
  _ContactUsState createState() => _ContactUsState();
}

class _ContactUsState extends State<ContactUs> {
  final _formKey = new GlobalKey<FormState>();
  double columnSizedBox = 25.0;

  String contactName,
      contactNumber,
      contactEmail,
      categoryRequest,
      messageTitle,
      subject;
  List<String> category = contactUsCategories.targetList();
  String headDesc_1 = 'At Nesma Unitrade we care about providing a complete service that stands to our client\'s standards.\nDrop us a message so we can assist you in any matter you\'re currently facing.';
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(25.0),
      child: Material(
        elevation: 5.0,
        shadowColor: Colors.black,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
            side: BorderSide(width: 2.0, color: Colors.grey)),
        child: Container(
          child: Form(
            key: _formKey,
            child: _buildContactUsForm(),
          ),
        ),
      ),
    );
  }

  Widget _buildContactUsForm() {
    double containerWidth = MediaQuery.of(context).size.width / 3;

    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 75.0, horizontal: 45.0),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start, children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: Container(
                  width: containerWidth,
                  child: Text(
                    headDesc_1,
                    textAlign: TextAlign.left,
                    softWrap: true,
                    style: textStyleParagraph9,
                  ),
                ),
              ),
              SizedBox(
                height: columnSizedBox,
              ),
              Container(
                width: containerWidth,
                child: TextFormField(
                  initialValue: '',
                  decoration:
                      textInputDecoration.copyWith(labelText: CONTACT_NAME),
                  validator: (val) =>
                      val.isEmpty ? '$CONTACT_NAME $EMPTY_VALIDATION' : null,
                  onChanged: (val) {
                    if (val != null) {
                      contactName = val;
                    }
                  },
                ),
              ),
              SizedBox(
                height: columnSizedBox,
              ),
              Container(
                width: containerWidth,
                child: TextFormField(
                  initialValue: '',
                  decoration:
                      textInputDecoration.copyWith(labelText: CONTACT_NUMBER),
                  validator: (val) {
                    if (val.isEmpty) {
                      return '$CONTACT_NUMBER $EMPTY_VALIDATION';
                    }
                    if (val.length < 10) {
                      return '$CONTACT_NUMBER_VALIDATION_LENGTH';
                    }
                    return null;
                  },
                  onChanged: (val) {
                    if (val != null) {
                      contactNumber = val;
                    }
                  },
                ),
              ),
              SizedBox(
                height: columnSizedBox,
              ),
              Container(
                width: containerWidth,
                child: TextFormField(
                  initialValue: '',
                  decoration:
                      textInputDecoration.copyWith(labelText: CONTACT_EMAIL),
                  validator: (val) =>
                      val.isEmpty ? '$CONTACT_EMAIL $EMPTY_VALIDATION' : null,
                  onChanged: (val) {
                    if (val != null) {
                      contactEmail = val;
                    }
                  },
                ),
              ),
              SizedBox(
                height: columnSizedBox,
              ),
              Container(
                width: containerWidth,
                child: DropdownButton<String>(
                  isExpanded: true,
                  isDense: true,
                  value: categoryRequest,
                  hint: Text(SELECT_TARGET),
                  onChanged: (String val) {
                    setState(() {
                      categoryRequest = val;
                    });
                  },
                  selectedItemBuilder: (BuildContext context) {
                    return category.map<Widget>((String item) {
                      return Text(item);
                    }).toList();
                  },
                  items: category.map((String item) {
                    return DropdownMenuItem<String>(
                      child: Text(item),
                      value: item,
                    );
                  }).toList(),
                ),
              ),
              SizedBox(
                height: columnSizedBox,
              ),
              Container(
                width: containerWidth,
                child: TextFormField(
                  initialValue: '',
                  decoration:
                      textInputDecoration.copyWith(labelText: MESSAGE_TITLE),
                  validator: (val) =>
                      val.isEmpty ? '$MESSAGE_TITLE $EMPTY_VALIDATION' : null,
                  onChanged: (val) {
                    if (val != null) {
                      messageTitle = val;
                    }
                  },
                ),
              ),
              SizedBox(
                height: columnSizedBox,
              ),
              Container(
                width: containerWidth,
                child: TextFormField(
                  maxLines: 8,
                  initialValue: '',
                  decoration:
                      textInputDecoration.copyWith(labelText: MESSAGE_SUBJECT),
                  validator: (val) =>
                      val.isEmpty ? '$MESSAGE_SUBJECT $EMPTY_VALIDATION' : null,
                  onChanged: (val) {
                    if (val != null) {
                      subject = val;
                    }
                  },
                ),
              ),
              SizedBox(
                height: columnSizedBox,
              ),
              Container(
                width: containerWidth,
                child: RaisedButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0)),
                  color: Colors.blue,
                  child: Text(SUBMIT),
                  onPressed: () {
                    if (_formKey.currentState.validate()) {
                      print('send the message to the admin');
                    }
                  },
                ),
              )
            ],
          ),
          SizedBox(
            width: containerWidth -200,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: containerWidth,
                child: Text(
                  'General Manager\nMr. Wael Gholmeye',
                ),
              ),
              SizedBox(
                height: columnSizedBox,
              ),
              Container(
                width: containerWidth,
                child: Text(
                  'Operation Manager\nMr. Rabih Khaled',
                ),
              ),
              SizedBox(
                height: columnSizedBox,
              ),
              Container(
                width: containerWidth,
                child: Text(
                  'Finance Manager\nMr. Charbel Mocled',
                ),
              ),
            ],
          ),
        ]),
      ),
    );
  }
}
