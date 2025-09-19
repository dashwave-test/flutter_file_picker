import 'package:flutter/material.dart';

class LiquidGlassButton extends StatefulWidget {
  final VoidCallback onPressed;
  final String label;
  final IconData? icon;
  final double width;
  final String? description;
  final bool showIconLeft;
  final bool showIconRight;

  const LiquidGlassButton({
    Key? key,
    required this.onPressed,
    required this.label,
    this.icon,
    this.width = 120,
    this.description,
    this.showIconLeft = false,
    this.showIconRight = false,
  }) : super(key: key);

  @override
  State<LiquidGlassButton> createState() => _LiquidGlassButtonState();
}

class _LiquidGlassButtonState extends State<LiquidGlassButton> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: SizedBox(
        width: widget.width,
        child: ElevatedButton(
          onPressed: widget.onPressed,
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.all(12),
            backgroundColor: _isHovered 
                ? const Color(0xFF007AFF) 
                : const Color(0xFF007AFF).withOpacity(0.8),
            foregroundColor: Colors.white,
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            shadowColor: Colors.transparent,
          ).copyWith(
            overlayColor: MaterialStateProperty.all(Colors.transparent),
            elevation: MaterialStateProperty.all(0),
            foregroundColor: MaterialStateProperty.all(Colors.white),
            backgroundColor: MaterialStateProperty.resolveWith((states) {
              if (states.contains(MaterialState.hovered)) {
                return const Color(0xFF007AFF);
              }
              return const Color(0xFF007AFF).withOpacity(0.8);
            }),
          ),
          child: Container(
            decoration: BoxDecoration(
              gradient: _isHovered
                ? const LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Color.fromRGBO(255, 255, 255, 0.3),
                      Color.fromRGBO(255, 255, 255, 0),
                    ],
                  )
                : null,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: const Color.fromRGBO(2, 2, 3, 0.1),
                  offset: const Offset(0, -1),
                  blurRadius: 1,
                  spreadRadius: 0,
                  blurStyle: BlurStyle.inner,
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (widget.showIconLeft && widget.icon != null) ...[
                  Icon(widget.icon, size: 24),
                  const SizedBox(width: 8),
                ],
                Flexible(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        widget.label,
                        style: const TextStyle(
                          fontFamily: 'Geist',
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
                          color: Colors.white,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      if (widget.description != null) ...[
                        const SizedBox(height: 4),
                        Text(
                          widget.description!,
                          style: const TextStyle(
                            fontFamily: 'Geist',
                            fontWeight: FontWeight.w400,
                            fontSize: 14,
                            color: Color.fromRGBO(255, 255, 255, 0.7),
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ],
                  ),
                ),
                if (widget.showIconRight && widget.icon != null) ...[
                  const SizedBox(width: 8),
                  Icon(widget.icon, size: 24),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}