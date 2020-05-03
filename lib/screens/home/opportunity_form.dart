import 'dart:typed_data';
import 'package:erasmusopportunities/helpers/countries.dart';
import 'package:erasmusopportunities/helpers/firebase_constants.dart';
import 'package:erasmusopportunities/helpers/theme.dart';
import 'package:erasmusopportunities/helpers/topics.dart';
import 'package:erasmusopportunities/onboarding/providers/login_theme.dart';
import 'package:erasmusopportunities/screens/services/auth.dart';
import 'package:erasmusopportunities/screens/services/database.dart';
import 'package:erasmusopportunities/widgets/multiselect.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_progress_button/flutter_progress_button.dart';
import 'package:intl/intl.dart';
import 'package:image_picker_web/image_picker_web.dart';

class OpportunityCard extends StatefulWidget {
  final AuthService auth;

  const OpportunityCard({Key key, this.auth}) : super(key: key);

  @override
  _OpportunityCardState createState() => _OpportunityCardState();
}

class _OpportunityCardState extends State<OpportunityCard> {


  Uint8List pickedCoverImage;
  var _addCoverImageComplete = false;
  pickCoverImage() async {

    Uint8List fromPicker = await ImagePickerWeb.getImage(outputType: ImageType.bytes);

    if (fromPicker != null) {
      setState(() {
        pickedCoverImage = fromPicker;
        _addCoverImageComplete = true;
      });
    }
  }

  Uint8List pickedPostImage;
  var _addPostImageComplete = false;
  pickPostImage() async {

    Uint8List fromPicker = await ImagePickerWeb.getImage(outputType: ImageType.bytes);

    if (fromPicker != null) {
      setState(() {
        pickedPostImage = fromPicker;
        _addPostImageComplete = true;
      });
    }
  }

  Uint8List pickedVideo;
  var _addVideoComplete = false;
  pickVideo() async {
    Uint8List videoMetaData = await ImagePickerWeb.getVideo(outputType: VideoType.bytes);

    if (videoMetaData != null) {
      setState(() {
        pickedVideo = videoMetaData;
        _addVideoComplete = true;
      });
    }
  }

  final GlobalKey<FormBuilderState> _fbKey = GlobalKey<FormBuilderState>();
  final opportunity = FirebaseOpportunityConstants();
  final DateTime startDate = DateTime.now();
  var _venueCountryLabel = '';
  var _participatingCountriesLabel = '';
  List<String> participatingCountriesList = [];
  var _typeLabel = '';
  var _topicsLabel = '';
  List<String> topicsList = [];
  var _opportunityPublished = false;

  @override
  Widget build(BuildContext context) {
    final loginTheme = LoginTheme();
    final theme = mergeTheme(theme: Theme.of(context), loginTheme: loginTheme);

    return Container(
      width: 700,
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
                            attribute: opportunity.title,
                            decoration: InputDecoration(labelText: "Title"),
                            validators: [
                              FormBuilderValidators.required(),
                            ],
                            initialValue: '',
                          ),

                          SizedBox(height: 20),

                          FormBuilderTextField(
                            attribute: opportunity.venueAddress,
                            decoration: InputDecoration(labelText: "Venue Address"),
                            validators: [
                              FormBuilderValidators.required(),
                            ],
                            initialValue: '',
                          ),

                          SizedBox(height: 20),

                          FormBuilderDropdown(
                            attribute: opportunity.venueCountry,
                            hint: Text('Venue Country'),
                            decoration: InputDecoration(labelText: _venueCountryLabel),
                            validators: [FormBuilderValidators.required()],
                            items: countries
                                .map((country) => DropdownMenuItem(
                                value: country['name'],
                                child: Text(country['name'])
                            )).toList(),
                            onChanged: (value) {
                              setState(() {
                                if (value != null && value.isNotEmpty) {
                                  _venueCountryLabel = 'Venue Country';
                                } else {
                                  _venueCountryLabel = '';
                                }
                              });
                            },
                          ),

                          SizedBox(height: 20),

                          FormBuilderCustomField(
                            attribute: opportunity.participatingCountries,
                            formField: FormField(
                              enabled: true,
                              builder: (FormFieldState<dynamic> field) {
                                return InputDecorator(
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    errorText: field.errorText,
                                    labelText: _participatingCountriesLabel,
                                  ),
                                  child: MultiSelect(
                                    hintText: 'Participating Countries',
                                    autovalidate: false,
                                    dataSource: countriesWithAll,
                                    textField: 'name',
                                    valueField: 'name',
                                    filterable: true,
                                    required: true,
                                    onSaved: (value) {
                                      setState(() {
                                        participatingCountriesList = [];
                                        for (var location in value) {
                                          participatingCountriesList.add(location.toString());
                                        }
                                      });
                                    },
                                    change: (List value) {
                                      setState(() {
                                        if (value != null && value.isNotEmpty) {
                                          _participatingCountriesLabel = 'Participating Countries';
                                        } else {
                                          _participatingCountriesLabel = '';
                                        }
                                      });
                                    },
                                  ),
                                );
                              },
                            ),
                          ),

                          SizedBox(height: 20),

                          FormBuilderDropdown(
                            attribute: opportunity.type,
                            hint: Text('Type'),
                            decoration: InputDecoration(labelText: _typeLabel),
                            validators: [FormBuilderValidators.required()],
                            items: ['Youth Exchange', 'Training Course']
                                .map((type) => DropdownMenuItem(
                                value: type,
                                child: Text("$type")
                            )).toList(),
                            onChanged: (value) {
                              setState(() {
                                if (value != null && value.isNotEmpty) {
                                  _typeLabel = 'Type';
                                } else {
                                  _typeLabel = '';
                                }
                              });
                            },
                          ),

                          SizedBox(height: 20),

                          Row(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                Expanded(
                                  child: FormBuilderDateTimePicker(
                                    attribute: opportunity.startDate,
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
                                    attribute: opportunity.endDate,
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
                                    attribute: opportunity.lowAge,
                                    decoration: InputDecoration(labelText: "From age"),
                                    validators: [
                                      FormBuilderValidators.numeric(),
                                      FormBuilderValidators.min(0),
                                      FormBuilderValidators.required(),
                                    ],
                                    initialValue: '',
                                  ),
                                ),
                                SizedBox(width: 20.0,),
                                Expanded(
                                  child: FormBuilderTextField(
                                    attribute: opportunity.highAge,
                                    decoration: InputDecoration(labelText: "To age"),
                                    validators: [
                                      FormBuilderValidators.numeric(),
                                      FormBuilderValidators.max(150),
                                      FormBuilderValidators.required(),
                                    ],
                                    initialValue: '',
                                  ),
                                ),
                              ]
                          ),

                          SizedBox(height: 20),

                          FormBuilderCustomField(
                            attribute: opportunity.topics,
                            formField: FormField(
                              enabled: true,
                              builder: (FormFieldState<dynamic> field) {
                                return InputDecorator(
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    errorText: field.errorText,
                                    labelText: _topicsLabel,
                                  ),
                                  child: MultiSelect(
                                    hintText: 'Topics',
                                    autovalidate: false,
                                    dataSource: topics,
                                    textField: 'topic',
                                    valueField: 'topic',
                                    filterable: true,
                                    required: true,
                                    onSaved: (value) {
                                      setState(() {
                                        topicsList = [];
                                        for (var topic in value) {
                                          topicsList.add(topic.toString());
                                        }
                                      });
                                    },
                                    change: (List value) {
                                      setState(() {
                                        if (value != null && value.isNotEmpty) {
                                          _topicsLabel = 'Topics';
                                        } else {
                                          _topicsLabel = '';
                                        }
                                      });

                                    },
                                  ),
                                );
                              },
                            ),
                          ),

                          SizedBox(height: 20),

                          FormBuilderDateTimePicker(
                            attribute: opportunity.applicationDeadline,
                            inputType: InputType.date,
                            format: DateFormat("yyyy-MM-dd"),
                            decoration:
                            InputDecoration(labelText: "Application Deadline"),
                            validators: [FormBuilderValidators.required()],
                          ),

                          SizedBox(height: 20),

                          FormBuilderTextField(
                            attribute: opportunity.participationCost,
                            decoration: InputDecoration(labelText: "Participation cost"),
                            validators: [
                              FormBuilderValidators.numeric(),
                              FormBuilderValidators.required(),
                            ],
                            initialValue: '',
                          ),

                          SizedBox(height: 20),

                          FormBuilderTextField(
                            attribute: opportunity.reimbursementLimit,
                            decoration: InputDecoration(labelText: "Reimbursement limit for travel costs"),
                            validators: [
                              FormBuilderValidators.numeric(),
                              FormBuilderValidators.required(),
                            ],
                            initialValue: '',
                          ),

                          SizedBox(height: 20),

                          FormBuilderTextField(
                            attribute: opportunity.applicationLink,
                            decoration: InputDecoration(labelText: "Application Link"),
                            validators: [
                              FormBuilderValidators.url(),
                              FormBuilderValidators.required(),
                            ],
                            initialValue: '',
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
                      activeColor: Color.fromRGBO(0, 68, 148, 1),
                      attribute: opportunity.provideForDisabilities,
                      options: [
                        FormBuilderFieldOption(value: "Additional mentoring or other support suitable for young people with obstacles, educational difficulties, cultural differences or similar."),
                        FormBuilderFieldOption(value: "A physical environment suitable for young people with physical, sensory or other disabilities (such as wheelchair access and similar)."),
                        FormBuilderFieldOption(value: "Support for young people who face situations that make their participation in the activities more difficult."),
                        FormBuilderFieldOption(value: "Support peope with special dietary requirements."),
                        FormBuilderFieldOption(value: "Other types of additional support for young people."),
                      ],
                    ),

                    SizedBox(height: 20),

                    Theme(
                      data: theme,
                      child: FormBuilderTextField(
                        attribute: opportunity.description,
                        decoration: InputDecoration(labelText: "Description"),
                        validators: [
                          FormBuilderValidators.required(),
                        ],
                        initialValue: '',
                      ),
                    ),

                    SizedBox(height: 20),

                    Row(
                      children: <Widget>[
                        GestureDetector(
                          onTap: () async {
                            pickCoverImage();
                          },
                          child: Padding(
                            padding: EdgeInsets.all(10.0),
                            child: Text(
                              _addCoverImageComplete? 'Change cover image' : 'Upload cover image',
                              style: TextStyle(color: Colors.black),
                              textAlign: TextAlign.start,
                            ),
                          ),
                        ),
                        SizedBox(width: 20.0,),
                        AnimatedSwitcher(
                          duration: Duration(milliseconds: 300),
                          switchInCurve: Curves.easeIn,
                          child: SizedBox(
                            width: 50,
                            height: 50,
                            child: pickedCoverImage != null ? Image.memory(pickedCoverImage) : Text(''),
                          ) ??
                              Container(),
                        ),
                        SizedBox(width: 10.0,),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              _addCoverImageComplete = false;
                              pickedCoverImage = null;
                            });
                          },
                          child: Padding(
                            padding: EdgeInsets.all(10.0),
                            child: Icon(
                              Icons.cancel,
                              size: 20.0,
                              color: _addCoverImageComplete? Colors.black : Colors.transparent,
                            ),
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: 10.0,),

                    Row(
                      children: <Widget>[
                        GestureDetector(
                          onTap: () {
                            pickPostImage();
                          },
                          child: Padding(
                            padding: EdgeInsets.all(10.0),
                            child: Text(
                              _addPostImageComplete? 'Change post image' : 'Upload post image',
                              style: TextStyle(color: Colors.black),
                              textAlign: TextAlign.start,
                            ),
                          ),
                        ),
                        SizedBox(width: 20.0,),
                        AnimatedSwitcher(
                          duration: Duration(milliseconds: 300),
                          switchInCurve: Curves.easeIn,
                          child: SizedBox(
                            width: 50,
                            height: 50,
                            child: pickedPostImage != null ? Image.memory(pickedPostImage) : Text(''),
                          ) ??
                              Container(),
                        ),
                        SizedBox(width: 10.0,),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              _addPostImageComplete = false;
                              pickedPostImage = null;
                            });
                          },
                          child: Padding(
                            padding: EdgeInsets.all(10.0),
                            child: Icon(
                              Icons.cancel,
                              size: 20.0,
                              color: _addPostImageComplete? Colors.black : Colors.transparent,
                            ),
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: 10.0,),

                    Row(
                      children: <Widget>[
                        GestureDetector(
                          onTap: () async {
                            await pickVideo();
                            setState(() {
                              _addVideoComplete = true;
                            });
                          },
                          child: Padding(
                            padding: EdgeInsets.all(10.0),
                            child: Text(
                              _addVideoComplete? "Change video" : "Upload video",
                              style: TextStyle(color: Colors.black),
                              textAlign: TextAlign.start,
                            ),
                          ),
                        ),
                        SizedBox(width: 10.0,),
                        Icon(
                          Icons.check,
                          color: _addVideoComplete? Colors.green : Colors.transparent,
                        ),
                        SizedBox(width: 10.0,),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              _addVideoComplete = false;
                              pickedVideo = null;
                            });
                          },
                          child: Padding(
                            padding: EdgeInsets.all(10.0),
                            child: Icon(
                              Icons.cancel,
                              size: 20.0,
                              color: _addVideoComplete? Colors.black : Colors.transparent,
                            ),
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: 20),

                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Builder(
                    builder: (BuildContext context) {
                      return ProgressButton(
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

                          try {
                            if (_fbKey.currentState.saveAndValidate()) {
                              FormBuilderState currentState = _fbKey.currentState;

                              final FirebaseUser user = await widget.auth.currentUser();
                              await DatabaseService(uid: user.uid)
                                  .updateOpportunity(
                                currentState.value[opportunity.title],
                                currentState.value[opportunity.venueAddress],
                                currentState.value[opportunity.venueCountry],
                                participatingCountriesList,
                                currentState.value[opportunity.type],
                                currentState.value[opportunity.startDate],
                                currentState.value[opportunity.endDate],
                                currentState.value[opportunity.lowAge],
                                currentState.value[opportunity.highAge],
                                topicsList,
                                currentState.value[opportunity.applicationDeadline],
                                currentState.value[opportunity.participationCost],
                                currentState.value[opportunity.reimbursementLimit],
                                currentState.value[opportunity.applicationLink],
                                currentState.value[opportunity.provideForDisabilities],
                                currentState.value[opportunity.description],
                                pickedCoverImage,
                                pickedPostImage,
                                pickedVideo,
                              );

                              setState(() {
                                _opportunityPublished = true;
                              });

                              final snackBar = SnackBar(
                                content: Text('Opportunity succesfully published!'),
                                backgroundColor: Colors.green,
                              );
                              Scaffold.of(context).showSnackBar(snackBar);

                            }

                          } catch (error) {
                            print(error.toString());
                            final snackBar = SnackBar(
                              content: Text('An error accured! Please try again.'),
                              backgroundColor: Colors.red,
                            );
                            Scaffold.of(context).showSnackBar(snackBar);
                            return null;
                          }
                        },
                      );
                    },
                  ),
                  SizedBox(height: 20.0,),
                  Text(_opportunityPublished? 'Your opportunity is now live 🙌 🎉' : ''),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
