/// The viewer's local calendar day, as `YYYY-MM-DD`.
///
/// Vow check-ins close at local midnight, not UTC midnight.
abstract final class KeptDay {
  static String key([DateTime? localNow]) {
    final d = localNow ?? DateTime.now();
    final y = d.year.toString().padLeft(4, '0');
    final m = d.month.toString().padLeft(2, '0');
    final day = d.day.toString().padLeft(2, '0');
    return '$y-$m-$day';
  }
}
