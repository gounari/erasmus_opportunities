import 'package:erasmusopportunities/widgets/selection.dart';
import 'package:flutter/material.dart';

class MultiSelect extends FormField<dynamic> {
  final String titleText;
  final String hintText;
  final bool required;
  final dynamic value;
  final bool filterable;
  final List dataSource;
  final String textField;
  final String valueField;
  final Function change;
  final Function open;
  final Function close;
  final Widget leading;
  final Widget trailing;
  final int maxLength;

  MultiSelect(
      {FormFieldSetter<dynamic> onSaved,
        FormFieldValidator<dynamic> validator,
        dynamic initialValue,
        bool autovalidate = false,
        this.titleText = 'Title',
        this.hintText = 'Tap to select location',
        this.required = false,
        this.value,
        this.leading,
        this.filterable = true,
        this.dataSource,
        this.textField,
        this.valueField,
        this.change,
        this.open,
        this.close,
        this.trailing,
        this.maxLength})
      : super(
      onSaved: onSaved,
      validator: validator,
      initialValue: initialValue,
      autovalidate: autovalidate,
      builder: (FormFieldState<dynamic> state) {
        List<Widget> _buildSelectedOptions(dynamic values, state) {
          List<Widget> selectedOptions = [];

          if (values != null) {
            values.forEach((item) {
              var existingItem = dataSource.singleWhere(
                      (itm) => itm[valueField] == item,
                  orElse: () => null);
              if (existingItem != null) {
                selectedOptions.add(Text(existingItem[textField],
                    overflow: TextOverflow.ellipsis,),
                );
              }
            });
          }

          return selectedOptions;
        }

        return InkWell(
            onTap: () async {
              var results = await showDialog(
                context: state.context,
                builder: (BuildContext context) => SelectionModal(
                    title: titleText,
                    filterable: filterable,
                    valueField: valueField,
                    textField: textField,
                    dataSource: dataSource,
                    values: state.value ?? [],
                    maxLength: maxLength ?? dataSource?.length
                ),
                barrierDismissible: true,
              );

              if (results != null) {
                dynamic newValue;
                if (results.length > 0) {
                  newValue = results;
                }
                state.didChange(newValue);
                if (change != null) {
                  change(newValue);
                }
              }
            },
            child: InputDecorator(
              decoration: InputDecoration(
                filled: false,
                fillColor: Colors.white,
                contentPadding: EdgeInsets.only(left: 0.0, top: 0.0, right: 0.0),
                errorBorder: InputBorder.none,
                enabledBorder: InputBorder.none,
                errorText: state.hasError ? state.errorText : null,
                errorMaxLines: 50,
              ),
              isEmpty: (state.value == null || state.value == '' || (state.value != null &&  state.value.length == 0)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  (state.value == null || state.value == '' || (state.value != null &&  state.value.length == 0))
                      ? new Container(
                    child: Text(
                      hintText,
                      style: TextStyle(
                        color: Colors.grey.shade600,
                        fontSize: 14.0,
                      ),
                    ),
                  ):
                  Wrap(
                    spacing: 8.0, // gap between adjacent chips
                    runSpacing: 1.0, // gap between lines
                    children:
                    _buildSelectedOptions(state.value, state),
                  )

                ],
              ),
            ));
      });

}