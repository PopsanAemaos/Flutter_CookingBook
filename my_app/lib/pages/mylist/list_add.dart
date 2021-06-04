import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import "dart:convert";
import 'package:my_app/pages/mylist/mylist.dart';

class ListAdd extends StatefulWidget {
  ListAdd({
    Key key,
    this.user_id,
  }) : super(key: key);
  final String user_id;
  @override
  State<StatefulWidget> createState() => new _ListAddState();
}

class _ListAddState extends State<ListAdd> {
  final _formKey = new GlobalKey<FormState>();

  String _name;
  String _ingredient;
  String _method;
  String _images;
  String _descriotion;
  String _errorMessage;

  bool _isLoading;

  // Check if form is valid before perform login or signup
  bool validateAndSave() {
    final form = _formKey.currentState;
    print(form);
    print(form.validate());
    if (form.validate()) {
      form.save();
      return true;
    }
    return false;
  }

  // Widget _showCircularProgress() {
  //   print(_isLoading);
  //   if (_isLoading) {
  //     return Center(child: CircularProgressIndicator());
  //   }
  //   return Container(
  //     height: 0.0,
  //     width: 0.0,
  //   );
  // }

  @override
  void initState() {
    _errorMessage = "";
    _isLoading = false;
    super.initState();
  }

  void validateAndSubmit() async {
    if (validateAndSave()) {
      try {
        var headers = {'Content-Type': 'application/json'};
        var request =
            http.Request('POST', Uri.parse('http://localhost:30301/addRecipe'));
        request.body = jsonEncode({
          "title": _name,
          "ingredient": _ingredient,
          "method": _method,
          "descriotion": _descriotion,
          "images": _images,
          "user_id": widget.user_id
        });
        request.headers.addAll(headers);
        request.send();
        print(request.body);
        return Navigator.pop(context, 'Cratea success.');
      } catch (e) {
        print('Error: $e');
        resetForm();
      }
    }
  }

  void resetForm() {
    _formKey.currentState.reset();
    _errorMessage = "";
  }

  // void toggleFormMode() {
  //   resetForm();
  //   setState(() {
  //     _isLoginForm = !_isLoginForm;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
          title: new Text('Yummy Trick'),
        ),
        body: Stack(
          children: <Widget>[
            _showForm(),
            // _showCircularProgress()
          ],
        ));
  }

  Widget _showForm() {
    return new Container(
        padding: EdgeInsets.all(16.0),
        child: new Form(
          key: _formKey,
          child: new ListView(
            shrinkWrap: true,
            children: <Widget>[
              showNameInput(),
              showDescriptionInput(),
              showIngredientInput(),
              showMethodInput(),
              showImagesInput(),
              showSaveButton(),
            ],
          ),
        ));
  }

  Widget showErrorMessage() {
    if (_errorMessage.length > 0 && _errorMessage != null) {
      return new Text(
        _errorMessage,
        style: TextStyle(
            fontSize: 13.0,
            color: Colors.red,
            height: 1.0,
            fontWeight: FontWeight.w300),
      );
    } else {
      return new Container(
        height: 0.0,
      );
    }
  }

  Widget showNameInput() {
    return Padding(
        padding: const EdgeInsets.fromLTRB(15.0, 15.0, 15.0, 15.0),
        child: Column(children: <Widget>[
          Text(
            "ชื่อ อาหาร",
            textAlign: TextAlign.left,
            style: TextStyle(
                color: Colors.black,
                fontFamily: 'Quicksand',
                fontSize: 15.0,
                fontWeight: FontWeight.bold),
          ),
          Card(
              child: Padding(
            padding: const EdgeInsets.fromLTRB(15.0, 5.0, 15.0, 5.0),
            child: TextFormField(
              maxLines: 1,
              autofocus: false,
              validator: (value) =>
                  value.isEmpty ? 'Name can\'t be empty' : null,
              onSaved: (value) => _name = value.trim(),
            ),
          ))
        ]));
  }

  Widget showDescriptionInput() {
    return Padding(
        padding: const EdgeInsets.fromLTRB(15.0, 15.0, 15.0, 15.0),
        child: Column(children: <Widget>[
          Text(
            "คำอธิบาย สั้นๆ",
            textAlign: TextAlign.left,
            style: TextStyle(
                color: Colors.black,
                fontFamily: 'Quicksand',
                fontSize: 15.0,
                fontWeight: FontWeight.bold),
          ),
          Card(
              child: Padding(
            padding: const EdgeInsets.fromLTRB(15.0, 5.0, 15.0, 5.0),
            child: TextFormField(
              maxLines: null,
              autofocus: false,
              validator: (value) =>
                  value.isEmpty ? 'คำอธิบาย สั้นๆ ไม่ได้กรอก' : null,
              onSaved: (value) => _descriotion = value.trim(),
            ),
          ))
        ]));
  }

  Widget showIngredientInput() {
    return Padding(
        padding: const EdgeInsets.fromLTRB(15.0, 15.0, 15.0, 15.0),
        child: Column(children: <Widget>[
          Text(
            "ส่วนประกอบ",
            textAlign: TextAlign.left,
            style: TextStyle(
                color: Colors.black,
                fontFamily: 'Quicksand',
                fontSize: 15.0,
                fontWeight: FontWeight.bold),
          ),
          Card(
              child: Padding(
            padding: const EdgeInsets.fromLTRB(15.0, 5.0, 15.0, 5.0),
            child: TextFormField(
              maxLines: null,
              autofocus: false,
              validator: (value) =>
                  value.isEmpty ? 'ส่วนประกอบ ไม่ได้กรอก' : null,
              onSaved: (value) => _ingredient = value.trim(),
            ),
          ))
        ]));
  }

  Widget showMethodInput() {
    return Padding(
        padding: const EdgeInsets.fromLTRB(15.0, 15.0, 15.0, 15.0),
        child: Column(children: <Widget>[
          Text(
            "ขั้นตอนการทำ",
            textAlign: TextAlign.left,
            style: TextStyle(
                color: Colors.black,
                fontFamily: 'Quicksand',
                fontSize: 15.0,
                fontWeight: FontWeight.bold),
          ),
          Card(
              child: Padding(
            padding: const EdgeInsets.fromLTRB(15.0, 5.0, 15.0, 5.0),
            child: TextFormField(
              maxLines: null,
              autofocus: false,
              validator: (value) =>
                  value.isEmpty ? 'ขั้นตอนการทำ ไม่ได้กรอก' : null,
              onSaved: (value) => _method = value.trim(),
            ),
          ))
        ]));
  }

  Widget showImagesInput() {
    return Padding(
        padding: const EdgeInsets.fromLTRB(15.0, 15.0, 15.0, 15.0),
        child: Column(children: <Widget>[
          Text(
            "link รูปภาพ",
            textAlign: TextAlign.left,
            style: TextStyle(
                color: Colors.black,
                fontFamily: 'Quicksand',
                fontSize: 15.0,
                fontWeight: FontWeight.bold),
          ),
          Card(
              child: Padding(
            padding: const EdgeInsets.fromLTRB(15.0, 5.0, 15.0, 5.0),
            child: TextFormField(
              maxLines: null,
              autofocus: false,
              validator: (value) =>
                  value.isEmpty ? 'link รูปภาพ ไม่ได้กรอก' : null,
              onSaved: (value) => _images = value.trim(),
            ),
          ))
        ]));
  }

  Widget showSaveButton() {
    return new Padding(
        padding: EdgeInsets.fromLTRB(0.0, 45.0, 0.0, 0.0),
        child: SizedBox(
          height: 40.0,
          child: new RaisedButton(
              elevation: 5.0,
              shape: new RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(30.0)),
              color: Colors.red,
              child: new Text("Save",
                  style: new TextStyle(fontSize: 20.0, color: Colors.white)),
              onPressed: validateAndSubmit
              ),
        ));
  }
}
