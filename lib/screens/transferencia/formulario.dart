import 'package:flutter/material.dart';
import 'package:flutter_bytebank/components/editor.dart';
import 'package:flutter_bytebank/models/transferencia.dart';

const _tituloAppBar = 'Criando Transferência';

const _rotuloCampoNumeroConta = 'Número da Conta';
const _dicaCampoNumeroConta = '0000';

const _rotuloCampoValor = 'Valor';
const _dicaCampoValor = '0.00';

const _textoBotao = 'Confirmar';

class FormularioTransferencia extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return FormularioTransferenciaState();
  }
}

class FormularioTransferenciaState extends State<FormularioTransferencia> {
  final TextEditingController _controladorCampoNumeroConta =
      TextEditingController();
  final TextEditingController _controladorCampoValor = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text(_tituloAppBar),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Editor(
                controlador: _controladorCampoNumeroConta,
                rotulo: _rotuloCampoNumeroConta,
                dica: _dicaCampoNumeroConta),
            Editor(
                controlador: _controladorCampoValor,
                rotulo: _rotuloCampoValor,
                dica: _dicaCampoValor,
                icone: (Icons.monetization_on)),
            ElevatedButton(
              child: Text(_textoBotao),
              onPressed: () {
                criaTransferencia(_controladorCampoNumeroConta,
                    _controladorCampoValor, context);
              },
            )
          ],
        ),
      ),
    );
  }
}

void criaTransferencia(campoNumeroConta, campoValor, BuildContext context) {
  final int? numeroConta = int.tryParse(campoNumeroConta.text);
  final double? valor = double.tryParse(campoValor.text);

  if (numeroConta != null && valor != null) {
    final transferenciaCriada = Transferencia(numeroConta, valor);

    Navigator.pop(context,
        transferenciaCriada); // o pop que vai notificar a nossa lista, onde estamos usando o future e quando cair no then ele vai executar a função
  }
}
