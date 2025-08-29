abstract class ApplicationDetailEvent {}

class ApplicationDetailStarted extends ApplicationDetailEvent {
  final String id;
  ApplicationDetailStarted(this.id);
}
