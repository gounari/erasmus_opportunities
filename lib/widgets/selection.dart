import 'package:flutter/material.dart';

class SelectionModal extends StatefulWidget {
  @override
  _SelectionModalState createState() => _SelectionModalState();

  final List dataSource;
  final List values;
  final bool filterable;
  final String textField;
  final String valueField;
  final String title;
  final int maxLength;

  SelectionModal(
      {this.filterable,
        this.dataSource,
        this.title = 'Please select one or more option(s)',
        this.values,
        this.textField,
        this.valueField,
        this.maxLength})
      : super();
}

class _SelectionModalState extends State<SelectionModal> {
  Icon icon = new Icon(
    Icons.search,
    color: Colors.white,
  );
  final globalKey = new GlobalKey<ScaffoldState>();
  final TextEditingController _controller = new TextEditingController();
  bool _isSearching;

  List _localDataSourceWithState = [];
  List _searchresult = [];

  _SelectionModalState() {
    _controller.addListener(() {
      if (_controller.text.isEmpty) {
        setState(() {
          _isSearching = false;
        });
      } else {
        setState(() {
          _isSearching = true;
        });
      }
    });
  }

  @override
  void initState() {
    super.initState();
    widget.dataSource.forEach((item) {
      var newItem = {
        'value': item[widget.valueField],
        'text': item[widget.textField],
        'checked': widget.values.contains(item[widget.valueField])
      };
      _localDataSourceWithState.add(newItem);
    });

    _searchresult = List.from(_localDataSourceWithState);
    _isSearching = false;
  }

  Widget _buildAppBar(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          FlatButton(
            onPressed: () {
              Navigator.pop(context, null);
            },
            child: Text(
              "Cancel",
              style: TextStyle(
                fontSize: 18.0,
                color: Theme.of(context).primaryColor,
              ),
            ),
          ),
          FlatButton(
            onPressed: _localDataSourceWithState.where((item) => item['checked']).length > widget.maxLength ? null :
                (){
              var selectedValuesObjectList = _localDataSourceWithState
                  .where((item) => item['checked'])
                  .toList();
              var selectedValues = [];
              selectedValuesObjectList.forEach((item) {
                selectedValues.add(item['value']);
              });
              Navigator.pop(context, selectedValues);
            },
            child: Text(
              "Save",
              style: TextStyle(
                fontSize: 18.0,
                color: Theme.of(context).primaryColor,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    return SafeArea(
      child: Column(
        children: <Widget>[
          widget.filterable ? _buildSearchText() : new SizedBox(),
          Expanded(
            child: _optionsList(),
          ),
          _currentlySelectedOptions(),
          _buildAppBar(context),
        ],
      ),
    );
  }

  Widget _currentlySelectedOptions() {
    List<Widget> selectedOptions = [];

    var selectedValuesObjectList =
    _localDataSourceWithState.where((item) => item['checked']).toList();
    var selectedValues = [];
    selectedValuesObjectList.forEach((item) {
      selectedValues.add(item['value']);
    });
    selectedValues.forEach((item) {
      var existingItem = _localDataSourceWithState
          .singleWhere((itm) => itm['value'] == item, orElse: () => null);
      selectedOptions.add(Chip(
        label: new Container(
          constraints: new BoxConstraints(
              maxWidth: MediaQuery.of(context).size.width - 80.0),
          child: Text(existingItem['text'], overflow: TextOverflow.ellipsis),
        ),
        deleteButtonTooltipMessage: 'Tap to delete this item',
        deleteIcon: Icon(Icons.cancel),
        deleteIconColor: Colors.grey,
        onDeleted: () {
          existingItem['checked'] = false;
          setState(() {});
        },
      ));
    });
    return selectedOptions.length > 0
        ? Container(
      padding: EdgeInsets.all(20.0),
      color: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Text(
            'Currently selected ${selectedOptions.length} items (tap to remove)', // use languageService here
            style: TextStyle(
                color: Colors.black
            ),
          ),
          SizedBox(height: 10.0,),
          ConstrainedBox(
              constraints: BoxConstraints(
                maxHeight: MediaQuery.of(context).size.height / 8,
              ),
              child: Scrollbar(
                child: SingleChildScrollView(
                    child: Wrap(
                      spacing: 8.0, // gap between adjacent chips
                      runSpacing: 0.4, // gap between lines
                      alignment: WrapAlignment.start,
                      children: selectedOptions,
                    )),
              )),
        ],
      ),
    )
        : new Container();
  }

  ListView _optionsList() {
    List<Widget> options = [];
    _searchresult.forEach((item) {
      options.add(ListTile(
          title: Text(item['text'] ?? ''),
          leading: Transform.scale(
            child: Icon(
                item['checked']
                    ? Icons.check_box
                    : Icons.check_box_outline_blank,
                color: Theme.of(context).primaryColor),
            scale: 1.5,
          ),
          onTap: () {
            item['checked'] = !item['checked'];
            setState(() {});
          }));
      options.add(new Divider(height: 1.0));
    });
    return ListView(children: options);
  }

  Widget _buildSearchText() {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Container(
            child: TextField(
              controller: _controller,
              keyboardAppearance: Brightness.dark,
              onChanged: searchOperation,
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(30.0),
                    ),
                  ),
                  filled: true,
                  hintText: "Search...",
                  fillColor: Colors.blue[50],
                  suffix: SizedBox(
                      height: 15.0,
                      child: IconButton(
                        icon: Icon(Icons.clear),
                        onPressed: () {
                          _controller.clear();
                          searchOperation('');
                        },
                        padding: EdgeInsets.all(0.0),
                        tooltip: 'Clear',
                      ))),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Center(child: Text('Select countries')),
      content: Container(
        height: MediaQuery.of(context).size.height * 0.8,
        width: MediaQuery.of(context).size.width * 0.4,
        key: globalKey,
        child: _buildBody(context),
      ),
    );
  }

  void searchOperation(String searchText) {
    _searchresult.clear();
    if (_isSearching != null &&
        searchText != null &&
        searchText.toString().trim() != '') {
      for (int i = 0; i < _localDataSourceWithState.length; i++) {
        String data =
            '${_localDataSourceWithState[i]['value']} ${_localDataSourceWithState[i]['text']}';
        if (data.toLowerCase().contains(searchText.toLowerCase())) {
          _searchresult.add(_localDataSourceWithState[i]);
        }
      }
    } else {
      _searchresult = List.from(_localDataSourceWithState);
    }
  }
}