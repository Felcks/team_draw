enum MatchPlayerStatus {
  CANCELLED("Cancelou"),
  NOT_CONFIRMED("Não confirmou"),
  CONFIRMED("Confirmado"),
  READY("Pronto / Em campo");

  final String value;
  const MatchPlayerStatus(this.value);
}