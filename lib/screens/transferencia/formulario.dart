import 'package:flutter/material.dart';
import 'package:bytebank/components/editor.dart';
import 'package:bytebank/models/transferencia.dart';

const _appBarTitle = '"Criando transferência"';

const _labelValor = 'Valor';
const _hintValor = '0.00';

const _labelNumeroConta = 'Número da conta';
const _hintNumeroConta = '0000';

const _btnSubmit = 'Confirmar';

class _FormularioTransferencia extends State<FormularioTransferencia> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Editor(
              controller: widget._controllerNumeroConta,
              label: _labelNumeroConta,
              hint: _hintNumeroConta,
            ),
            Editor(
              controller: widget._controllerValor,
              label: _labelValor,
              hint: _hintValor,
              icon: Icons.monetization_on,
            ),
            RaisedButton(
              onPressed: () => widget._doTransfer(context),
              child: const Text(_btnSubmit),
            ),
          ],
        ),
      ),
      appBar: AppBar(
        title: const Text(_appBarTitle),
      ),
    );
  }
}

class FormularioTransferencia extends StatefulWidget {
  final TextEditingController _controllerNumeroConta = TextEditingController();
  final TextEditingController _controllerValor = TextEditingController();

  _FormularioTransferencia createState() => _FormularioTransferencia();

  void _doTransfer(BuildContext context) {
    final int numeroConta = int.tryParse(_controllerNumeroConta.text);
    final double valor = double.tryParse(_controllerValor.text);

    if (numeroConta != null && valor != null) {
      final transferencia = Transferencia(valor, numeroConta);
      Navigator.pop(context, transferencia);
    }
  }
}
