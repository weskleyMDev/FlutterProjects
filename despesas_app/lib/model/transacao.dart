class Transacao {
  Transacao({
    required this.id,
    required this.titulo,
    required this.valor,
    required this.date,
  });

  final DateTime date;
  final String id;
  final String titulo;
  final double valor;
}
