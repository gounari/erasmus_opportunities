import 'package:erasmusopportunities/onboarding/helpers/color_helper.dart';
import 'package:erasmusopportunities/onboarding/providers/login_theme.dart';
import 'package:erasmusopportunities/screens/services/auth.dart';
import 'package:erasmusopportunities/screens/services/database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_progress_button/flutter_progress_button.dart';
import 'package:intl/intl.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  final AuthService _auth = AuthService();
  final GlobalKey<FormBuilderState> _fbKey = GlobalKey<FormBuilderState>();
  final DateTime startDate = DateTime.now();

  @override
  Widget build(BuildContext context) {

    final loginTheme = LoginTheme();
    final theme = _mergeTheme(theme: Theme.of(context), loginTheme: loginTheme);

    return Scaffold(
      backgroundColor: Color.fromRGBO(0, 68, 148, 1),
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
                      autovalidate: false,
                      child: Column(
                        children: <Widget>[
                          Theme(
                            data: theme,
                            child: Column(
                              children: <Widget>[
                                FormBuilderTextField(
                                  attribute: "title",
                                  decoration: InputDecoration(labelText: "Title"),
                                  validators: [
                                    FormBuilderValidators.required(),
                                  ],
                                ),

                                SizedBox(height: 20),

                                FormBuilderTextField(
                                  attribute: "venueLocation",
                                  decoration: InputDecoration(labelText: "Venue Location"),
                                  validators: [
                                    FormBuilderValidators.required(),
                                  ],
                                ),

                                SizedBox(height: 20),

                                FormBuilderDropdown(
                                  attribute: "type",
                                  hint: Text('Select Type'),
                                  validators: [FormBuilderValidators.required()],
                                  items: ['Youth Exchange', 'Training Course']
                                      .map((type) => DropdownMenuItem(
                                      value: type,
                                      child: Text("$type")
                                  )).toList(),
                                ),

                                SizedBox(height: 20),

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
                                        decoration: InputDecoration(labelText: "Start Date"),
                                        validators: [
                                          FormBuilderValidators.required()
                                        ],
                                      ),
                                    ),
                                    SizedBox(width: 20.0,),
                                    Expanded(
                                      child: FormBuilderDateTimePicker(
                                        attribute: "endDate",
                                        inputType: InputType.date,
                                        format: DateFormat("dd-MM-yyyy"),
                                        decoration:
                                        InputDecoration(labelText: "End Date"),
                                        validators: [FormBuilderValidators.required(),],
                                      ),
                                    ),
                                  ]
                                ),

                                SizedBox(height: 20),

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

                                SizedBox(height: 20),

                                FormBuilderDropdown(
                                  attribute: "Topic",
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

                                SizedBox(height: 20),

                                FormBuilderDateTimePicker(
                                  attribute: "deadline",
                                  inputType: InputType.date,
                                  format: DateFormat("yyyy-MM-dd"),
                                  decoration:
                                  InputDecoration(labelText: "Application Deadline"),
                                  validators: [FormBuilderValidators.required()],
                                ),

                                SizedBox(height: 20),

                                FormBuilderTextField(
                                  attribute: "participation_cost",
                                  decoration: InputDecoration(labelText: "Participation cost"),
                                  validators: [
                                    FormBuilderValidators.numeric(),
                                    FormBuilderValidators.required(),
                                  ],
                                ),

                                SizedBox(height: 20),

                                FormBuilderTextField(
                                  attribute: "reimbursement_limit",
                                  decoration: InputDecoration(labelText: "Reimbursement limit for travel costs"),
                                  validators: [
                                    FormBuilderValidators.numeric(),
                                    FormBuilderValidators.required(),
                                  ],
                                ),

                                SizedBox(height: 20),

                                FormBuilderTextField(
                                  attribute: "application_link",
                                  decoration: InputDecoration(labelText: "Application Link"),
                                  validators: [
                                    FormBuilderValidators.url(),
                                    FormBuilderValidators.required(),
                                  ],
                                ),

                                SizedBox(height: 20),
                              ],
                            ),
                          ),
                          FormBuilderCheckboxList(
                            decoration:
                            InputDecoration(
                              enabledBorder: const OutlineInputBorder(
                                // width: 0.0 produces a thin "hairline" border
                                borderSide: BorderSide(color: Colors.lightBlueAccent, width: 0.1),
                              ),
                              border: OutlineInputBorder(),
                              labelText: 'You can provide:',
                            ),
                            attribute: "disabilities",
                            options: [
                              FormBuilderFieldOption(value: "Additional mentoring or other support suitable for young people with obstacles, educational difficulties, cultural differences or similar."),
                              FormBuilderFieldOption(value: "A physical environment suitable for young people with physical, sensory or other disabilities (such as wheelchair access and similar)."),
                              FormBuilderFieldOption(value: "Support for young people who face situations that make their participation in the activities more difficult."),
                              FormBuilderFieldOption(value: "Other types of additional support for young people."),
                            ],
                          ),

                          SizedBox(height: 20),

                          Theme(
                            data: theme,
                            child: FormBuilderTextField(
                              attribute: "Description",
                              decoration: InputDecoration(labelText: "Description"),
                              validators: [
                                FormBuilderValidators.required(),
                              ],
                            ),
                          ),

                          SizedBox(height: 20),
                        ],
                      ),
                    ),
                    Row(
                      children: <Widget>[
                        ProgressButton(
                          defaultWidget:
                          const Text('Publish', style: TextStyle(color: Colors.white)),
                          progressWidget: const CircularProgressIndicator(
                              valueColor: AlwaysStoppedAnimation<Color>(Colors.white)),
                          color: Color.fromRGBO(0, 68, 148, 1),
                          width: 100,
                          height: 40,
                          borderRadius: 24,
                          animate: false,
                          onPressed: () async {

                            if (_fbKey.currentState.saveAndValidate()) {
                              print(_fbKey.currentState.value['startDate']);
                            }


                            try {
                              FormBuilderState currentState = _fbKey.currentState;

                              final FirebaseUser user = await _auth.currentUser();
                              print(user);

                              await DatabaseService(uid: user.uid)
                                  .updateOpportunity(
                                  currentState.value['title'],
                                  currentState.value['venueLocation'],
                                  currentState.value['type']);

                            } catch (error) {
                              print(error.toString());
                              return null;
                            }

                          },
                        ),
                        MaterialButton(
                          child: Text(
                            "Reset",
                            style: TextStyle(color: Color.fromRGBO(0, 68, 148, 1),),
                          ),
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

ThemeData _mergeTheme({ThemeData theme, LoginTheme loginTheme}) {
  final originalPrimaryColor = loginTheme.primaryColor ?? theme.primaryColor;
  final primaryDarkShades = getDarkShades(originalPrimaryColor);
  final primaryColor = primaryDarkShades.length == 1
      ? lighten(primaryDarkShades.first)
      : primaryDarkShades.first;
  final primaryColorDark = primaryDarkShades.length >= 3
      ? primaryDarkShades[2]
      : primaryDarkShades.last;
  final accentColor = loginTheme.accentColor ?? theme.accentColor;
  final errorColor = loginTheme.errorColor ?? theme.errorColor;
  // the background is a dark gradient, force to use white text if detect default black text color
  final isDefaultBlackText = theme.textTheme.display2.color ==
      Typography.blackMountainView.display2.color;
  final titleStyle = theme.textTheme.display2
      .copyWith(
    color: loginTheme.accentColor ??
        (isDefaultBlackText
            ? Colors.white
            : theme.textTheme.display2.color),
    fontSize: loginTheme.beforeHeroFontSize,
    fontWeight: FontWeight.w300,
  )
      .merge(loginTheme.titleStyle);
  final textStyle = theme.textTheme.body1
      .copyWith(color: Colors.black54)
      .merge(loginTheme.bodyStyle);
  final textFieldStyle = theme.textTheme.subhead
      .copyWith(color: Colors.black.withOpacity(.65), fontSize: 14)
      .merge(loginTheme.textFieldStyle);
  final buttonStyle = theme.textTheme.button
      .copyWith(color: Colors.white)
      .merge(loginTheme.buttonStyle);
  final cardTheme = loginTheme.cardTheme;
  final inputTheme = loginTheme.inputTheme;
  final buttonTheme = loginTheme.buttonTheme;
  final roundBorderRadius = BorderRadius.circular(100);

  return theme.copyWith(
    primaryColor: primaryColor,
    primaryColorDark: primaryColorDark,
    accentColor: accentColor,
    errorColor: errorColor,
    cardTheme: theme.cardTheme.copyWith(
      clipBehavior: cardTheme.clipBehavior,
      color: cardTheme.color ?? theme.cardColor,
      elevation: cardTheme.elevation ?? 12.0,
      margin: cardTheme.margin ?? const EdgeInsets.all(4.0),
      shape: cardTheme.shape ??
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
    ),
    inputDecorationTheme: theme.inputDecorationTheme.copyWith(
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
    floatingActionButtonTheme: theme.floatingActionButtonTheme.copyWith(
      backgroundColor: buttonTheme?.backgroundColor ?? primaryColor,
      splashColor: buttonTheme.splashColor ?? theme.accentColor,
      elevation: buttonTheme.elevation ?? 4.0,
      highlightElevation: buttonTheme.highlightElevation ?? 2.0,
      shape: buttonTheme.shape ?? StadiumBorder(),
    ),
    // put it here because floatingActionButtonTheme doesnt have highlightColor property
    highlightColor:
    loginTheme.buttonTheme.highlightColor ?? theme.highlightColor,
    textTheme: theme.textTheme.copyWith(
      display2: titleStyle,
      body1: textStyle,
      subhead: textFieldStyle,
      button: buttonStyle,
    ),
  );
}
