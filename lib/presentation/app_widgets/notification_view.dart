import 'package:e_comerce_app/common/base/base_app_bar.dart';
import 'package:e_comerce_app/common/extensions/theme_extensions.dart';
import 'package:e_comerce_app/common/gen/assets.gen.dart';
import 'package:flutter/material.dart';

enum NotificationType { success, error, info }

extension NotificationExtension on BuildContext {

  void showElegantNotification({
    required String title,
    required NotificationType type,
    int durationInSeconds = 3,
  }) {
    Color backgroundColor;
    Widget icon;
    Color borderColor;

    switch (type) {
      case NotificationType.success:
        backgroundColor = colors.primary01 ;
        icon = Assets.icons.success.svg();
        borderColor=colors.primary;
        break;
      case NotificationType.error:
        backgroundColor =  colors.primary01;
        icon = Assets.icons.warning.svg();
        borderColor=colors.warningDark;
        break;
      case NotificationType.info:
        backgroundColor =  colors.primary01;
        icon = Assets.icons.info.svg();
        borderColor=colors.lightBlue;
        break;
    }

    final overlay = Overlay.of(this);
    final overlayEntry = OverlayEntry(
      builder: (context) {
        return Positioned(
          top: 50,
          right: 16,
          child: _NotificationWidget(
            title: title,
            backgroundColor: backgroundColor,
            borderColor: borderColor,
            icon: icon,
            durationInSeconds: durationInSeconds,
          ),
        );
      },
    );

    overlay?.insert(overlayEntry);

    Future.delayed(Duration(seconds: durationInSeconds), () {
      overlayEntry.remove();
    });
  }
}

class _NotificationWidget extends StatefulWidget {
  final String title;
  final Color backgroundColor;
  final Color borderColor;

  final Widget icon;
  final int durationInSeconds;

  const _NotificationWidget({
    required this.title,
    required this.backgroundColor,
    required this.borderColor,
    required this.icon,
    required this.durationInSeconds,
  });

  @override
  State<_NotificationWidget> createState() => _NotificationWidgetState();
}

class _NotificationWidgetState extends State<_NotificationWidget>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _offsetAnimation;
  late AnimationController _progressController;
  late Animation<double> _progressAnimation;


  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 300),
    );

    _offsetAnimation = Tween<Offset>(
      begin: Offset(1, 0), // Start outside the screen (right)
      end: Offset(0, 0), // Slide into position
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));

    _controller.forward(); // Start animation on show
    _progressController = AnimationController(
      vsync: this,
      duration: Duration(seconds: widget.durationInSeconds),
    );

    _progressAnimation = Tween<double>(
      begin: 1.0,
      end: 0.0,
    ).animate(CurvedAnimation(
      parent: _progressController,
      curve: Curves.linear,
    ));

    _progressController.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: _offsetAnimation,
      child: Material(
        color: Colors.transparent,
        child: Container(
          width: MediaQuery.of(context).size.width*0.8,
          margin: EdgeInsets.symmetric(vertical: 8),
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 8),
          decoration: BoxDecoration(
            color: widget.backgroundColor,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: widget.borderColor),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 6,
                offset: Offset(0, 3),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  widget.icon,
                  SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      widget.title,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 8),
              ClipRRect(
                borderRadius: BorderRadius.circular(4),
                child: AnimatedBuilder(
                  animation: _progressAnimation,
                  builder: (context, child) {
                    return LinearProgressIndicator(
                      value: _progressAnimation.value,
                      valueColor:
                      AlwaysStoppedAnimation<Color>(widget.borderColor),
                      backgroundColor: Colors.white.withOpacity(0.3),
                      minHeight: 4,
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
