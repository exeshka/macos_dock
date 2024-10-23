import 'package:flutter/material.dart';

/// Entrypoint of the application.
void main() {
  runApp(const MyApp());
}

/// [Widget] building the [MaterialApp].
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Scaffold(
        body: Center(
          child: Dock(),
        ),
      ),
    );
  }
}

class Dock extends StatefulWidget {
  const Dock({super.key});

  @override
  State<Dock> createState() => _DockState();
}

class _DockState extends State<Dock> {
  List<IconData> items = [
    Icons.person,
    Icons.message,
    Icons.call,
    Icons.camera,
    Icons.photo,
  ];

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Container(
        padding: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: Colors.black12,
        ),

        // Dock size animation
        child: AnimatedSize(
          // Duration
          duration: const Duration(milliseconds: 150),
          // Dock content (List Buttons)
          child: Row(
            // Настройка чтобы док занимал минимальный размер
            mainAxisSize: MainAxisSize.min,

            //  List.generate
            children: List.generate(items.length, (index) {
              // Виджет для перетаскивания элемента
              return DragTarget<IconData>(
                onAccept: (data) {
                  setState(() {
                    final oldIndex = items.indexOf(data);
                    // Обмен местами
                    items[oldIndex] = items[index];
                    items[index] = data;
                  });
                },
                builder: (context, candidateData, rejectedData) {
                  return Draggable<IconData>(
                    data: items[index],
                    feedback: DockButtonWidget(
                      icon: items[index],
                    ),

                    // Убрал элемент который будет отображать под выбранным, не получается сделать так же как в доке мак ос
                    // Сам удивлен что не смог сделать эту таску
                    childWhenDragging: SizedBox(),

                    child: DockButtonWidget(
                      icon: items[index],
                    ),
                  );
                },
              );
            }),
          ),
        ),
      ),
    );
  }
}

class DockButtonWidget extends StatelessWidget {
  final IconData icon;

  const DockButtonWidget({super.key, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 60,
      height: 60,
      margin: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Colors.primaries[icon.hashCode % Colors.primaries.length],
      ),
      child: Center(
        child: Icon(icon, color: Colors.white),
      ),
    );
  }
}
