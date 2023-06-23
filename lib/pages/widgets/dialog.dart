import 'package:fluent_ui/fluent_ui.dart';

void showContentDialog(BuildContext context) {
  showDialog<String>(
    context: context,
    builder: (context) => ContentDialog(
      title: const Text('Upload Now?'),
      content: const Text(
        'REMEMBER NOT TO CALL THE API FREQUENTLY',
      ),
      actions: [
        Button(
          child: const Text('Yes'),
          onPressed: () {
            Navigator.pop(context, 'User deleted file');
            // Delete file here
          },
        ),
        FilledButton(
          child: const Text('Cancel'),
          onPressed: () => Navigator.pop(context, 'User canceled dialog'),
        ),
      ],
    ),
  );
}
