enum MatchPlayerStatus {
  CANCELLED("Cancelado"),
  NOT_CONFIRMED("Não confirmou"),
  CONFIRMED("Confirmado"),
  READY("Pronto");

  final String value;
  const MatchPlayerStatus(this.value);
}