/// Wire values stored by the server. UI labels live in localization.
abstract final class VowPolicy {
  static const open = 'open';
  static const approval = 'approval';
  static const invite = 'invite';
  static const closed = 'closed';
}

abstract final class VowRole {
  static const owner = 'owner';
  static const admin = 'admin';
  static const member = 'member';
}

abstract final class VowLength {
  static const week = 7;
  static const threeWeeks = 21;
  static const open = 0;
}

abstract final class VowCategory {
  static const health = 'health';
  static const quit = 'quit';
  static const move = 'move';
  static const focus = 'focus';
  static const custom = 'custom';
}

abstract final class BlogTopic {
  static const water = 'water';
  static const habits = 'habits';
}

abstract final class VowActivityKind {
  static const kept = 'kept';
  static const broke = 'broke';
  static const joined = 'joined';
  static const chat = 'chat';
}
