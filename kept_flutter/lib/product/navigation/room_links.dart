import 'dart:async';

import 'package:app_links/app_links.dart';
import 'package:flutter/material.dart';

/// A room someone else can open by tapping `kept://room/<id>`.
abstract final class RoomLinks {
  static final pendingRoomId = ValueNotifier<int?>(null);

  static Uri uri(int roomId) =>
      Uri(scheme: 'kept', host: 'room', path: '/$roomId');

  static int? idOf(Uri uri) {
    if (uri.scheme == 'kept' && uri.host == 'room') {
      final raw = uri.pathSegments.isEmpty ? '' : uri.pathSegments.first;
      return int.tryParse(raw);
    }
    final segments = uri.pathSegments;
    if (segments.length >= 2 && segments[segments.length - 2] == 'room') {
      return int.tryParse(segments.last);
    }
    return null;
  }

  static void remember(Uri uri) {
    final id = idOf(uri);
    if (id == null) return;
    pendingRoomId.value = id;
  }
}

/// Listens for the room link from a cold start and from a tap while the app is open.
class RoomLinkHost extends StatefulWidget {
  const RoomLinkHost({super.key, required this.child});

  final Widget child;

  @override
  State<RoomLinkHost> createState() => _RoomLinkHostState();
}

class _RoomLinkHostState extends State<RoomLinkHost> {
  final _links = AppLinks();
  StreamSubscription<Uri>? _subscription;

  @override
  void initState() {
    super.initState();
    _captureInitial();
    _subscription = _links.uriLinkStream.listen(RoomLinks.remember);
  }

  Future<void> _captureInitial() async {
    final uri = await _links.getInitialLink();
    if (uri != null) RoomLinks.remember(uri);
  }

  @override
  void dispose() {
    _subscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => widget.child;
}
