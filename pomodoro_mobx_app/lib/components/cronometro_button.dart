import 'package:flutter/material.dart';

class CronometroButton extends StatelessWidget {
  const CronometroButton({
    super.key,
    required this.icon,
    required this.title,
    required this.color,
    this.onTap,
  });

  final IconData icon;
  final String title;
  final Color color;
  final void Function()? onTap;

  const CronometroButton.start({super.key, this.onTap})
    : icon = Icons.play_arrow_sharp,
      title = 'Iniciar',
      color = Colors.green;

  const CronometroButton.pause({super.key, this.onTap})
    : icon = Icons.pause_sharp,
      title = 'Pausar',
      color = Colors.amber;

  const CronometroButton.restart({super.key, this.onTap})
    : icon = Icons.restart_alt_sharp,
      title = 'Reiniciar',
      color = Colors.red;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: onTap,
      icon: Icon(icon, color: color, size: 25.0),
      label: Text(title.toUpperCase()),
    );
  }
}
