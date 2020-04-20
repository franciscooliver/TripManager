import 'dart:math';
import 'dart:ui';

import 'package:checked_list/controllers/trip_controller.dart';
import 'package:checked_list/dao/db-helper.dart';
import 'package:checked_list/global_widgets/remove_button.dart';
import 'package:checked_list/models/trip.dart';
import 'package:checked_list/utils/alert_dialog.dart';
import 'package:checked_list/utils/consts.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GlobalKey<FormState> _formKeyName = GlobalKey<FormState>();
  final GlobalKey<FormState> _formKeyDate = GlobalKey<FormState>();
  TextEditingController _textNameController;
  TextEditingController _textDateController;
  String _valueText;
  String _valueDate;

  TripController _tripController = TripController();

  @override
  void initState() {
    super.initState();
    DatabaseHelper.getInstance().db;
    _tripController.getTrips();
    // Inicializando instância dos controllers dos campos do formulário
    _textNameController = TextEditingController();
    _textDateController = TextEditingController();
  }

  void _submit(BuildContext ctx) {
    if (_formKeyName.currentState.validate() &&
        _formKeyDate.currentState.validate()) {
      // Salva o valor digitado no campo de texto
      _formKeyName.currentState.save();
      _formKeyDate.currentState.save();

      // int id = Random().nextInt(1000);
      var trip = Trip(nome: _valueText, dataViagem: _valueDate);
      _tripController.addTrip(trip);

      // Limpa os campos
      _textNameController.clear();
      _textDateController.clear();

      // Exibe toast depois de salvar os dados
      Scaffold.of(ctx).showSnackBar(SnackBar(
        duration: Duration(seconds: 1),
        content: Text('$_valueText foi adionado à lista'),
      ));
    }
  }

  _body() {
    return Stack(
      alignment: Alignment.topCenter,
      overflow: Overflow.visible,
      children: <Widget>[
        Positioned(
          top: 0.0,
          child: Container(
            alignment: Alignment.centerLeft,
            height: MediaQuery.of(context).size.height / 3,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                    colors: [Colors.green, Colors.blueAccent])),
            child: Padding(
              padding: const EdgeInsets.only(top: 25.0, left: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Lista de viagens',
                    style: TextStyle(
                        fontSize: 30.0,
                        color: Colors.white,
                        fontFamily: 'Google',
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ),
        ),
        Positioned(
          top: MediaQuery.of(context).size.height * 0.07,
          right: -5.0,
          child: Builder(
            builder: (BuildContext ctx) => FlatButton(
              child: ClipOval(
                child: Material(
                  color: Colors.blue.shade200.withOpacity(0.3), // button color
                  child: InkWell(
                    splashColor:
                        Color.fromRGBO(45, 105, 192, 1.0), // inkwell color
                    child: SizedBox(
                      width: 56,
                      height: 56,
                      child: Icon(Icons.add, color: Colors.white,),
                    ),
                    onTap: () {
                      _submit(ctx);
                    },
                  ),
                ),
              ),
              onPressed: () {},
            ),
          ),
        ),
        Positioned(
          top: 160,
          child: Column(
            children: <Widget>[
              Container(
                height: MediaQuery.of(context).size.height - 175,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(25.0),
                    topRight: Radius.circular(25.0),
                  ),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Expanded(
                          flex: 1,
                          child: Padding(
                            padding: const EdgeInsets.only(
                                top: 25.0,
                                left: 20.0,
                                right: 20.0,
                                bottom: 15.0),
                            child: _formField(
                                type: 'name',
                                formKey: _formKeyName,
                                hintText: 'Nome da viagem',
                                textEditingController: _textNameController,
                                errorText: 'Preencha esse campo'),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Padding(
                            padding: const EdgeInsets.only(
                                top: 25.0,
                                left: 2.0,
                                right: 20.0,
                                bottom: 15.0),
                            child: _formField(
                                type: 'date',
                                formKey: _formKeyDate,
                                textEditingController: _textDateController,
                                hintText: 'Digite a data',
                                errorText: 'Vazio'),
                          ),
                        ),
                      ],
                    ),
                    Expanded(
                      flex: 3,
                      child: Padding(
                        padding: const EdgeInsets.only(
                          left: 20.0,
                          right: 20.0,
                          top: 5.0,
                        ),
                        child: Container(
                          height: 200,
                          child: Observer(builder: (_) {
                            return _tripsList();
                          }),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  _formField({
    hintText,
    type,
    TextEditingController textEditingController,
    dynamic formKey,
    errorText,
  }) {
    var maskFormatter = new MaskTextInputFormatter(mask: '##/##/####', filter: {
      "#": RegExp(r'[0-9]'),
    });
    return Form(
      key: formKey,
      child: TextFormField(
        decoration: InputDecoration(
            hintText: hintText,
            labelStyle: TextStyle(fontSize: 18),
            hintStyle: TextStyle(height: 1),
            errorStyle: TextStyle(fontSize: 18, height: 0.5)),
        validator: (value) {
          if (value.isEmpty) {
            return errorText;
          } else
            return null;
        },
        controller: textEditingController,
        inputFormatters: type == 'date' ? [maskFormatter] : null,
        autovalidate: false,
        keyboardType: TextInputType.text,
        onSaved: (valueText) {
          type == 'date' ? _valueDate = valueText : _valueText = valueText;
        },
      ),
    );
  }

  _tripsList() {
    return _tripController.trips.length > 0
        ? ListView.builder(
            scrollDirection: Axis.vertical,
            itemCount: _tripController.trips.length,
            itemBuilder: (_, index) {
              var trip = _tripController.trips[index];
              return Card(
                elevation: 3,
                child: Padding(
                  padding: const EdgeInsets.only(
                    top: 10.0,
                    bottom: 10.0,
                    left: 5.0,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        '${trip.nome}',
                        style: TextStyle(
                          fontSize: 15.0,
                          fontFamily: 'Google',
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Builder(
                              builder: (BuildContext ctx) => RemoveButton(
                                    icon: Icon(
                                      Icons.close,
                                      color: Colors.redAccent,
                                    ),
                                    onPressed: () {
                                      List<DialogButton> buttons = [
                                        DialogButton(
                                            color: themeColor,
                                            child: Text(
                                              "Sim",
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ),
                                            onPressed: () async {
                                              String tripName = _tripController
                                                  .trips[index].nome;
                                              int idDelete = _tripController
                                                  .trips[index].id;

                                              bool deleted =
                                                  await _tripController
                                                      .delete(idDelete);

                                              Navigator.pop(context);

                                              deleted
                                                  ? Scaffold.of(ctx)
                                                      .showSnackBar(
                                                      SnackBar(
                                                        content: Text(
                                                            '$tripName removido da lista'),
                                                      ),
                                                    )
                                                  : Text(
                                                      'Erro ao remover a viagem');
                                            }),
                                      ];

                                      MyAlertDialog.showAlert(
                                        ctx: context,
                                        type: AlertType.warning,
                                        title: "Remover viagem",
                                        desc:
                                            "Realmente deseja remover esse item?",
                                        buttons: buttons,
                                      );
                                    },
                                  )),
                          IconButton(
                            icon: Icon(
                              Icons.visibility,
                              color: Colors.grey,
                            ),
                            onPressed: () {
                              Navigator.of(context).pushNamed('/tripDetails',
                                  arguments: _tripController.trips[index]);
                            },
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          )
        : Center(
            child: Text("Nenhuma viagem cadastrada até o momento."),
          );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: _body(),
      // floatingActionButton: Stack(
      //   children: <Widget>[
      //     Builder(
      //       builder: (BuildContext ctx) => Positioned(
      //         top: MediaQuery.of(context).size.height * 0.03,
      //         right: MediaQuery.of(context).size.width * 0.02,
      //         child: FloatingActionButton(
      //           onPressed: () {
      //             _submit(ctx);
      //           },
      //           elevation: 8.0,
      //           backgroundColor: Colors.green,
      //           child: Icon(Icons.add),
      //         ),
      //       ),
      //     ),
      //   ],
      // ),
    );
  }
}
