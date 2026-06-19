import 'package:flutter/material.dart';

import '../../game/models/positions.dart';

class JoinRoomPlate extends StatefulWidget {
  final Positions positions;
  final Future<void> Function(String roomId) onJoin;

  const JoinRoomPlate({
    super.key,
    required this.positions,
    required this.onJoin,
  });

  @override
  State<JoinRoomPlate> createState() => _JoinRoomPlateState();
}

class _JoinRoomPlateState extends State<JoinRoomPlate> {
  final TextEditingController _controller = TextEditingController();

  bool _isJoining = false;

  @override
  void initState() {
    super.initState();

  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _joinRoom() async {
    if (_isJoining) return;

    final roomId = _controller.text.trim();

    if (roomId.isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Enter a Room ID')));
      return;
    }

    setState(() {
      _isJoining = true;
    });

    try {
      await widget.onJoin(roomId);
    } finally {
      if (mounted) {
        setState(() {
          _isJoining = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = widget.positions.screenSize.width;
    final screenHeight = widget.positions.screenSize.height;

    return Container(
      width: screenWidth * 0.42,
      height: screenHeight * 0.13,
      padding: const EdgeInsets.all(3),
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          children: [
            Expanded(
              child: TextField(
                controller: _controller,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Enter Room ID',
                ),
                style: TextStyle(
                  color: Colors.black,
                  fontSize: screenWidth * 0.03,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.2,
                ),
                textInputAction: TextInputAction.done,
                onSubmitted: (_) => _joinRoom(),
              ),
            ),
            Material(
              color: Colors.transparent,
              child: InkWell(
                borderRadius: BorderRadius.circular(8),
                onTap: _isJoining ? null : _joinRoom,
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: _isJoining
                      ? const SizedBox(
                          width: 24,
                          height: 24,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                      : const Icon(Icons.login_rounded, size: 24),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
