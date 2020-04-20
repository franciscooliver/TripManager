import 'package:checked_list/controllers/details_controller.dart';
import 'package:checked_list/models/details.dart';
import 'package:checked_list/utils/consts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class TripDetails extends StatefulWidget {
  TripDetails({this.trip});

  final trip;

  @override
  _TripDetailsState createState() => _TripDetailsState();
}

class _TripDetailsState extends State<TripDetails> {
  Details appModel;
  String _nomePassageiro;
  DetailsController _detailController = DetailsController();
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _textController = TextEditingController();

  @override
  void initState() {
    appModel = new Details();
    super.initState();
    _detailController.setList(widget.trip.id);
  }

  _submit() {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      var details = Details(
          pnome: _nomePassageiro,
          // psobrenome: "Sobrenome teste",
          to_pay: 0,
          trip_id: widget.trip.id);
      _detailController.save(details);
      _textController.clear();
    }
  }

  Widget generateCard(
      {double widthScreen, String text1, String text2, Color badgeColor}) {
    return Padding(
      padding: const EdgeInsets.only(left: 2.0, right: 5.0),
      child: Container(
        width: widthScreen / 2 - 20,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
          color: Colors.white,
        ),
        child: Padding(
          padding: const EdgeInsets.only(top: 10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Text(text1),
              Container(
                alignment: Alignment.topCenter,
                margin:
                    const EdgeInsets.only(top: 10.0, left: 15.0, right: 15.0),
                padding: const EdgeInsets.only(
                    left: 10.0, right: 10.0, top: 5.0, bottom: 5.0),
                decoration: BoxDecoration(
                    color: Colors.orange,
                    borderRadius: BorderRadius.all(Radius.circular(5))),
                child: Text(
                  text2,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _removePassing(
      BuildContext ctx, DismissDirection direction, Details passageiro) async {
    if (direction == DismissDirection.startToEnd) {
      String passNome = passageiro.pnome;
      bool deleted = await _detailController.delete(passageiro.id);

      deleted
          ? Scaffold.of(ctx).showSnackBar(SnackBar(
              duration: Duration(seconds: 1),
              content: Text('$passNome removido(a) da lista'),
            ))
          : Text('Erro ao remover a viagem');
    }
  }

  _listaPassageiros() {
    var lastItem = _detailController.detailList.last;

    return _detailController.detailList != null
        ? ListView.builder(
            itemCount: _detailController.detailList.length,
            itemBuilder: (ctx, index) {
              var passageiro = _detailController.detailList[index];
              var toPay = passageiro.to_pay == 1 ? true : false;
              return Dismissible(
                key: Key(passageiro.id.toString()),
                background: Container(
                  padding: const EdgeInsets.only(left: 15.0),
                  alignment: Alignment.centerLeft,
                  color: themeColor,
                  child: Icon(
                    Icons.delete,
                    color: Colors.white,
                  ),
                ),
                direction: DismissDirection.startToEnd,
                onDismissed: (direction) {
                  _removePassing(ctx, direction, passageiro);
                },
                child: Container(
                  // constraints: BoxConstraints(maxHeight: 55.0),
                  child: Column(
                    children: <Widget>[
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            '${passageiro.pnome}',
                            style: TextStyle(fontSize: 18.0),
                          ),
                          Container(
                            child: Row(
                              children: <Widget>[
                                _statusToPay(passageiro),
                              ],
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          Expanded(
                            flex: 1,
                            child: Divider(
                              color: passageiro.id != lastItem.id
                                  ? Colors.grey
                                  : Colors.transparent,
                              height: 1.0,
                            ),
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
            child: CircularProgressIndicator(),
          );
  }

  _statusToPay(passageiro) {
    String textPgto = passageiro.to_pay == 1 ? "PAGO" : 'PENDENTE';
    Color textColor = passageiro.to_pay == 1 ? themeColor : Colors.red;
    return Row(
      children: <Widget>[
        Text(
          textPgto,
          style: TextStyle(color: textColor),
        ),
        Checkbox(
            activeColor: themeColor,
            value: passageiro.to_pay == 1 ? true : false,
            onChanged: (v) {
              int toPay = v ? 1 : 0;
              setState(() {
                passageiro.to_pay = toPay;
              });
            }),
      ],
    );
  }

  Widget _textFormField() => Form(
        // Campo de texto
        key: _formKey,
        child: Container(
          constraints: BoxConstraints(minHeight: 50.0),
          child: TextFormField(
            validator: (value) {
              if (value.isEmpty) {
                return 'Preencha esse campo';
              } else
                return null;
            },
            autovalidate: false,
            controller: _textController,
            textInputAction: TextInputAction.go,
            decoration: InputDecoration(
              hintText: 'Adicionar passageiro',
              border: InputBorder.none,
              errorStyle: TextStyle(height: 4.0),
            ),
            onSaved: (value) {
              _nomePassageiro = value;
            },
          ),
        ),
      );

  _body(BuildContext ctx) {
    double widthScreen = MediaQuery.of(ctx).size.width;

    return Column(
      children: <Widget>[
        Container(
          height:
              widthScreen >= 500 ? 100.0 : MediaQuery.of(ctx).size.height / 4,
          constraints: BoxConstraints(
              minHeight: widthScreen > 500
                  ? 100.0
                  : MediaQuery.of(ctx).size.height / 4),
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: [Colors.green, Colors.blueAccent])),
          width: widthScreen,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Expanded(
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: <Widget>[
                      generateCard(
                          widthScreen: widthScreen,
                          text1: "Nome da viagem",
                          text2: this.widget.trip.nome),
                      Observer(
                        builder: (BuildContext context) {
                          return generateCard(
                            widthScreen: widthScreen,
                            text1: "Número de passageiros",
                            text2: _detailController.countPassings.toString(),
                          );
                        },
                      ),
                      generateCard(
                          widthScreen: widthScreen,
                          text1: "Data da viagem",
                          text2: this.widget.trip.dataViagem)
                    ],
                    padding: const EdgeInsets.all(5.0),
                  ),
                ),
              ],
            ),
          ),
        ),
        Container(
          height: 40,
          width: MediaQuery.of(context).size.width,
          alignment: Alignment.center,
          margin: const EdgeInsets.only(left: 20.0, right: 20.0, top: 10.0),
          padding: const EdgeInsets.only(left: 10.0, bottom: 4.0),
          decoration: BoxDecoration(
            border: Border.all(width: 1.0, color: Colors.grey),
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Flexible(
                flex: 9,
                child: _textFormField(),
              ),
              Expanded(
                flex: 1,
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  alignment: Alignment.center,
                  margin: const EdgeInsets.only(top: 4.0, right: 5.0),
                  decoration: BoxDecoration(
                      shape: BoxShape.circle, color: Colors.redAccent),
                  child: FlatButton(
                    padding: EdgeInsets.only(right: 1.0),
                    splashColor: Colors.transparent,
                    child: Icon(
                      Icons.add,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      _submit();
                    },
                  ),
                ),
              )
            ],
          ),
        ),
        Expanded(
          child: Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
            child: Observer(
              builder: (_) {
                int sizeList = _detailController.detailList.length;
                return sizeList > 0
                    ? _listaPassageiros()
                    : Center(
                        child: Text(
                            'Nenhum passageiro cadastrado para essa viagem.'),
                      );
              },
            ),
          ),
        ),
      ],
    );
  }

  Future<void> _loadSavingList() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          content: Container(
            height: 100.0,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                CircularProgressIndicator(),
                Text('Salvando lista...')
              ],
            ),
          ),
        );
      },
    );
  }

  _appBar(BuildContext context) {
    double sizeIconAction = 30.0;

    final actions = [
      IconButton(
          icon: Icon(
            Icons.refresh,
            color: Colors.white,
            size: sizeIconAction,
          ),
          onPressed: () {
            print('Saving...');
          }),
      IconButton(
          icon: Icon(
            Icons.save,
            color: Colors.white,
            size: sizeIconAction,
          ),
          onPressed: () async {
            // print('Loading -> $loading');
            for (var details in _detailController.detailList) {
              _detailController.setPayment(details);
            }

            _loadSavingList();
            await Future.delayed(Duration(seconds: 3));
            Navigator.pop(context);
          }),
    ];
    return AppBar(
      elevation: 0,
      flexibleSpace: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            colors: <Color>[Colors.green, Colors.blueAccent],
          ),
        ),
      ),
      leading: IconButton(
        icon: Icon(
          Icons.arrow_back_ios,
        ),
        onPressed: () {
          Navigator.of(context).pop(context);
        },
      ),
      title: Text(
        "Detalhes da viagem",
      ),
      actions: <Widget>[...actions],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(context),
      body: _body(context),
    );
  }
}
