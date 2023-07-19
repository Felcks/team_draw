enum GamePlayerStatus {
  CANCELLED("Cancelado"),
  NOT_CONFIRMED("Não confirmou"),
  CONFIRMED("Confirmado"),
  READY("Pronto");

  final String value;
  const GamePlayerStatus(this.value);
}