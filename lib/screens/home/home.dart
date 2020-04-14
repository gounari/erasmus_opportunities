import 'package:erasmusopportunities/onboarding/helpers/color_helper.dart';
import 'package:erasmusopportunities/onboarding/providers/login_theme.dart';
import 'package:erasmusopportunities/screens/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:intl/intl.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  final AuthService _auth = AuthService();
  final GlobalKey<FormBuilderState> _fbKey = GlobalKey<FormBuilderState>();
  final DateTime startDate = DateTime.now();
  static final loginTheme = LoginTheme();
  final inputTheme = loginTheme.inputTheme;
  final roundBorderRadius = BorderRadius.circular(100);



  @override
  Widget build(BuildContext context) {

    final theme = Theme.of(context);
    final originalPrimaryColor = loginTheme.primaryColor ?? theme.primaryColor;
    final primaryDarkShades = getDarkShades(originalPrimaryColor);
    final primaryColor = primaryDarkShades.length == 1
        ? lighten(primaryDarkShades.first)
        : primaryDarkShades.first;
    final errorColor = loginTheme.errorColor ?? theme.errorColor;

    return Scaffold(
      backgroundColor: Colors.white70,
      appBar: AppBar(
        title: Image.asset('images/logo.png', fit: BoxFit.contain, height: 50),
        backgroundColor: Colors.white,
        elevation: 10.0,
        actions: <Widget>[
          FlatButton.icon(
              onPressed: () async {
                await _auth.signOut();
              },
              icon: Icon(
                Icons.exit_to_app,
                color: Color.fromRGBO(0, 68, 148, 1),
              ),
              label: Text(''),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Padding(
            padding: const EdgeInsets.all(30.0),
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              elevation: 5.0,
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(30.0),
                child: Column(
                  children: <Widget>[
                    FormBuilder(
                      key: _fbKey,
                      initialValue: {
                        'date': DateTime.now(),
                        'accept_terms': false,
                      },
                      autovalidate: true,
                      child: Column(
                        children: <Widget>[
                          FormBuilderTextField(
                            attribute: "Title",
                            decoration: InputDecoration(labelText: "Title"),
                            validators: [
                              FormBuilderValidators.required(),
                            ],
                          ),

                          SizedBox(height: 10),

                          FormBuilderTextField(
                            attribute: "Venue Location",
                            decoration: InputDecoration(labelText: "Venue Location"),
                            validators: [
                              FormBuilderValidators.required(),
                            ],
                          ),

                          SizedBox(height: 10),

                          FormBuilderDropdown(
                            attribute: "Type",
                            decoration: InputDecoration(labelText: "Type"),
                            hint: Text('Select Type'),
                            validators: [FormBuilderValidators.required()],
                            items: ['Youth Exchange', 'Training Course']
                                .map((type) => DropdownMenuItem(
                                value: type,
                                child: Text("$type")
                            )).toList(),
                          ),

                          SizedBox(height: 10),

                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              Expanded(
                                child: FormBuilderDateTimePicker(
                                  attribute: 'startDate',
                                  inputType: InputType.date,
                                  firstDate: startDate,
                                  lastDate: DateTime(
                                      startDate.year + 1, startDate.month, startDate.day),
                                  format: DateFormat('dd-MM-yyyy'),

                                  decoration: InputDecoration(
                                    labelText: 'Start Date',
                                    filled: inputTheme.filled,
                                    fillColor: inputTheme.fillColor ??
                                        Color.alphaBlend(
                                          primaryColor.withOpacity(.07),
                                          Colors.grey.withOpacity(.04),
                                        ),
                                    contentPadding: inputTheme.contentPadding ??
                                        const EdgeInsets.symmetric(horizontal: 20.0),
                                    errorStyle: inputTheme.errorStyle ?? TextStyle(color: errorColor),
                                    labelStyle: inputTheme.labelStyle,
                                    enabledBorder: inputTheme.enabledBorder ??
                                        inputTheme.border ??
                                        OutlineInputBorder(
                                          borderSide: BorderSide(color: Colors.transparent),
                                          borderRadius: roundBorderRadius,
                                        ),
                                    focusedBorder: inputTheme.focusedBorder ??
                                        inputTheme.border ??
                                        OutlineInputBorder(
                                          borderSide: BorderSide(color: primaryColor, width: 1.5),
                                          borderRadius: roundBorderRadius,
                                        ),
                                    errorBorder: inputTheme.errorBorder ??
                                        inputTheme.border ??
                                        OutlineInputBorder(
                                          borderSide: BorderSide(color: errorColor),
                                          borderRadius: roundBorderRadius,
                                        ),
                                    focusedErrorBorder: inputTheme.focusedErrorBorder ??
                                        inputTheme.border ??
                                        OutlineInputBorder(
                                          borderSide: BorderSide(color: errorColor, width: 1.5),
                                          borderRadius: roundBorderRadius,
                                        ),
                                    disabledBorder: inputTheme.disabledBorder ?? inputTheme.border,
                                  ),
                                  validators: [
                                    FormBuilderValidators.required()
                                  ],
                                ),
                              ),
                              SizedBox(width: 20.0,),
                              Expanded(
                                child: FormBuilderDateTimePicker(
                                  attribute: "to_date",
                                  inputType: InputType.date,
                                  format: DateFormat("yyyy-MM-dd"),
                                  decoration:
                                  InputDecoration(labelText: "To Date"),
                                  validators: [FormBuilderValidators.required(),],
                                ),
                              ),
                            ]
                          ),

                          SizedBox(height: 10),

                          Row(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                Expanded(
                                  child: FormBuilderTextField(
                                    attribute: "from_age",
                                    decoration: InputDecoration(labelText: "From age"),
                                    validators: [
                                      FormBuilderValidators.numeric(),
                                      FormBuilderValidators.min(0),
                                      FormBuilderValidators.required(),
                                    ],
                                  ),
                                ),
                                SizedBox(width: 20.0,),
                                Expanded(
                                  child: FormBuilderTextField(
                                    attribute: "to_age",
                                    decoration: InputDecoration(labelText: "To age"),
                                    validators: [
                                      FormBuilderValidators.numeric(),
                                      FormBuilderValidators.max(150),
                                      FormBuilderValidators.required(),
                                    ],
                                  ),
                                ),
                              ]
                          ),

                          SizedBox(height: 10),

                          FormBuilderDropdown(
                            attribute: "Topic",
                            decoration: InputDecoration(labelText: "Topic"),
                            hint: Text('Select Topic'),
                            validators: [FormBuilderValidators.required()],
                            items: ['Social Challenges',
                              'Reception and integration of refugees and migrants',
                            'Citizenship and democratic participation',
                            'Disaster prevention and recovery',
                            'Enviroment and natural protection',
                            'Health and wellbeing',
                            'Education and training',
                            'Employment and entrepreneurship',
                            'Creativity and culture',
                            'Physical education and sport']
                                .map((topic) => DropdownMenuItem(
                                value: topic,
                                child: Text("$topic")
                            )).toList(),
                          ),

                          SizedBox(height: 10),

                          FormBuilderDateTimePicker(
                            attribute: "deadline",
                            inputType: InputType.date,
                            format: DateFormat("yyyy-MM-dd"),
                            decoration:
                            InputDecoration(labelText: "Application Deadline"),
                            validators: [FormBuilderValidators.required()],
                          ),

                          SizedBox(height: 10),

                          FormBuilderTextField(
                            attribute: "participation_cost",
                            decoration: InputDecoration(labelText: "Participation cost"),
                            validators: [
                              FormBuilderValidators.numeric(),
                              FormBuilderValidators.required(),
                            ],
                          ),

                          SizedBox(height: 10),

                          FormBuilderTextField(
                            attribute: "reimbursement_limit",
                            decoration: InputDecoration(labelText: "Reimbursement limit for travel costs"),
                            validators: [
                              FormBuilderValidators.numeric(),
                              FormBuilderValidators.required(),
                            ],
                          ),

                          SizedBox(height: 10),

                          FormBuilderTextField(
                            attribute: "application_link",
                            decoration: InputDecoration(labelText: "Application Link"),
                            validators: [
                              FormBuilderValidators.url(),
                              FormBuilderValidators.required(),
                            ],
                          ),

                          SizedBox(height: 10),

                          FormBuilderCheckboxList(
                            decoration:
                            InputDecoration(labelText: "You can provide"),
                            attribute: "disabilities",
                            options: [
                              FormBuilderFieldOption(value: "Additional mentoring or other support suitable for young people with obstacles, educational difficulties, cultural differences or similar."),
                              FormBuilderFieldOption(value: "A physical environment suitable for young people with physical, sensory or other disabilities (such as wheelchair access and similar)."),
                              FormBuilderFieldOption(value: "Support for young people who face situations that make their participation in the activities more difficult."),
                              FormBuilderFieldOption(value: "Other types of additional support for young people."),
                            ],
                          ),

                          SizedBox(height: 10),

                          FormBuilderTextField(
                            attribute: "Description",
                            decoration: InputDecoration(labelText: "Description"),
                            validators: [
                              FormBuilderValidators.required(),
                            ],
                          ),

                          SizedBox(height: 10),
                        ],
                      ),
                    ),
                    Row(
                      children: <Widget>[
                        MaterialButton(
                          child: Text("Submit"),
                          onPressed: () {
                            if (_fbKey.currentState.saveAndValidate()) {
                              print(_fbKey.currentState.value);
                            }
                          },
                        ),
                        MaterialButton(
                          child: Text("Reset"),
                          onPressed: () {
                            _fbKey.currentState.reset();
                          },
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/// get the dark shades version of current color,
List<Color> getDarkShades(Color color,
    [ColorShade minShade = ColorShade.fifthLightest]) {
  final materialColor =
  color is MaterialColor ? color : getMaterialColor(color);
  final darkShades = <Color>[];

  for (final shade in shades.values) {
    if (shade < shades[minShade]) continue;

    final colorShade = materialColor[shade];
    if (estimateBrightnessForColor(colorShade) == Brightness.dark) {
      darkShades.add(colorShade);
    }
  }

  return darkShades.length > 0
      ? darkShades
      : [materialColor[shades[ColorShade.darkest]]];
}
