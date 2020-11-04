import 'package:flutter/material.dart';

void main() => runApp(BytebankApp());

class BytebankApp extends StatelessWidget {
  Widget build(BuildContext context) {
    return MaterialApp(
      home: FormularioTransferencia(),
      // home: ListaTransferencias(),
    );
  }
}

class FormularioTransferencia extends StatelessWidget {
  final TextEditingController _controllerNumeroConta = TextEditingController();
  final TextEditingController _controllerValor = TextEditingController();

  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Editor(
            controller: _controllerNumeroConta,
            label: 'Número da Conta',
            hint: '0000',
          ),
          Editor(
            controller: _controllerValor,
            label: 'Valor',
            hint: '0.00',
            icon: Icons.monetization_on,
          ),
          RaisedButton(
            onPressed: () {
              final int numeroConta = int.tryParse(_controllerNumeroConta.text);
              final double valor = double.tryParse(_controllerValor.text);

              if (numeroConta != null && valor != null) {
                final transferencia = Transferencia(valor, numeroConta);
                print(transferencia);
              }
            },
            child: Text('Confirmar'),
          ),
        ],
      ),
      appBar: AppBar(
        title: const Text("Criando transferência"),
      ),
    );
  }
}

class Editor extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final String hint;
  final IconData icon;

  Editor({this.controller, this.label, this.hint, this.icon});

  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        controller: controller,
        keyboardType: TextInputType.number,
        style: TextStyle(
          fontSize: 16,
        ),
        decoration: InputDecoration(
          icon: icon != null ? Icon(icon) : null,
          labelText: label,
          hintText: hint,
        ),
      ),
    );
  }
}

class ListaTransferencias extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          ItemTransferencia(Transferencia(100.0, 0895)),
          ItemTransferencia(Transferencia(99.99, 1812)),
          ItemTransferencia(Transferencia(6565.55, 1812)),
          ItemTransferencia(Transferencia(4646.68, 0895)),
        ],
      ),
      appBar: AppBar(
        title: const Text('Transferências'),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {},
      ),
    );
  }
}

class ItemTransferencia extends StatelessWidget {
  final Transferencia _transferencia;

  ItemTransferencia(this._transferencia);

  final Icon _moneyIcon = Icon(
    Icons.monetization_on,
    color: Colors.green[900],
  );
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: _moneyIcon,
        title: Text('R\$ ${_transferencia.valor.toString()}'),
        subtitle: Text(_transferencia.numeroConta.toString()),
      ),
    );
  }
}

class Transferencia {
  final double valor;
  final int numeroConta;

  Transferencia(this.valor, this.numeroConta);

  String toString() {
    return 'Transferencia{valor: $valor, numeroConta: $numeroConta}';
  }
}
