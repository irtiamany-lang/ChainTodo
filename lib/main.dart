
import 'package:flutter/material.dart';

void main() {
  runApp(const ChainTodoApp());
}

const Color purple = Color(0xFF7357E8);
const Color darkPurple = Color(0xFF30215F);
const Color background = Color(0xFFF7F6FC);

class ChainTodoApp extends StatelessWidget {
  const ChainTodoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'ChainTodo',
      theme: ThemeData(
        useMaterial3: true,
        fontFamily: 'Arial',
        scaffoldBackgroundColor: background,
        colorScheme: ColorScheme.fromSeed(seedColor: purple),
      ),
      home: const DashboardPage(),
    );
  }
}

class Task {
  String title;
  bool completed;

  Task(this.title, {this.completed = false});
}

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  final TextEditingController controller = TextEditingController();

  final List<Task> tasks = [
    Task('Menyelesaikan proyek ChainTodo'),
    Task('Mempelajari Smart Contract'),
    Task('Menghubungkan Flutter dengan Blockchain'),
    Task('Menguji transaksi di Sepolia', completed: true),
  ];

  String filter = 'Semua';

  int get completedCount =>
      tasks.where((task) => task.completed).length;

  List<Task> get filteredTasks {
    if (filter == 'Belum selesai') {
      return tasks.where((task) => !task.completed).toList();
    }
    if (filter == 'Selesai') {
      return tasks.where((task) => task.completed).toList();
    }
    return tasks;
  }

  void addTask() {
    final value = controller.text.trim();

    if (value.isEmpty) return;

    setState(() {
      tasks.insert(0, Task(value));
      controller.clear();
      filter = 'Semua';
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isWide = constraints.maxWidth >= 850;

        return Scaffold(
          body: Row(
            children: [
              if (isWide) _sidebar(),
              Expanded(
                child: Column(
                  children: [
                    _topBar(isWide),
                    Expanded(
                      child: SingleChildScrollView(
                        padding: EdgeInsets.all(isWide ? 32 : 18),
                        child: Center(
                          child: ConstrainedBox(
                            constraints: const BoxConstraints(
                              maxWidth: 1150,
                            ),
                            child: Column(
                              crossAxisAlignment:
                                  CrossAxisAlignment.start,
                              children: [
                                _welcome(),
                                const SizedBox(height: 28),
                                _statistics(),
                                const SizedBox(height: 28),
                                _progressCard(),
                                const SizedBox(height: 32),
                                _taskSection(),
                                const SizedBox(height: 30),
                                _footer(),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _sidebar() {
    return Container(
      width: 245,
      color: Colors.white,
      padding: const EdgeInsets.symmetric(
        horizontal: 22,
        vertical: 30,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 42,
                height: 42,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [purple, darkPurple],
                  ),
                  borderRadius: BorderRadius.circular(13),
                ),
                child: const Icon(
                  Icons.check_circle_outline,
                  color: Colors.white,
                ),
              ),
              const SizedBox(width: 12),
              const Text(
                'ChainTodo',
                style: TextStyle(
                  fontSize: 21,
                  fontWeight: FontWeight.bold,
                  color: darkPurple,
                ),
              ),
            ],
          ),
          const SizedBox(height: 55),
          const Text(
            'MENU UTAMA',
            style: TextStyle(
              fontSize: 11,
              color: Colors.grey,
              letterSpacing: 1.3,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 18),
          _menuItem(Icons.dashboard_rounded, 'Dashboard', true),
          _menuItem(Icons.checklist_rounded, 'Daftar Tugas', false),
          _menuItem(Icons.bar_chart_rounded, 'Statistik', false),
          const Spacer(),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: const Color(0xFFF2EFFF),
              borderRadius: BorderRadius.circular(16),
            ),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(Icons.link, color: purple, size: 25),
                SizedBox(height: 12),
                Text(
                  'Blockchain Connected',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: darkPurple,
                  ),
                ),
                SizedBox(height: 5),
                Text(
                  'Integrasi Sepolia akan tersedia setelah konfigurasi.',
                  style: TextStyle(
                    fontSize: 11,
                    color: Colors.black54,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          const Text(
            'ChainTodo v1.0',
            style: TextStyle(color: Colors.grey, fontSize: 11),
          ),
        ],
      ),
    );
  }

  Widget _menuItem(IconData icon, String title, bool active) {
    return Container(
      margin: const EdgeInsets.only(bottom: 9),
      decoration: BoxDecoration(
        color: active ? const Color(0xFFF0ECFF) : Colors.transparent,
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        dense: true,
        leading: Icon(
          icon,
          color: active ? purple : Colors.grey,
        ),
        title: Text(
          title,
          style: TextStyle(
            fontSize: 13,
            fontWeight: active ? FontWeight.bold : FontWeight.normal,
            color: active ? purple : Colors.black54,
          ),
        ),
      ),
    );
  }

  Widget _topBar(bool isWide) {
    return Container(
      height: 75,
      padding: EdgeInsets.symmetric(horizontal: isWide ? 32 : 18),
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(
          bottom: BorderSide(color: Color(0xFFEEEEF2)),
        ),
      ),
      child: Row(
        children: [
          if (!isWide) ...[
            const Icon(Icons.check_circle, color: purple),
            const SizedBox(width: 8),
            const Text(
              'ChainTodo',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ] else
            const Text(
              'Dashboard',
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w600,
              ),
            ),
          const Spacer(),
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 13,
              vertical: 9,
            ),
            decoration: BoxDecoration(
              color: const Color(0xFFF0ECFF),
              borderRadius: BorderRadius.circular(30),
            ),
            child: const Row(
              children: [
                Icon(Icons.circle, color: Colors.orange, size: 9),
                SizedBox(width: 7),
                Text(
                  'Sepolia Testnet',
                  style: TextStyle(
                    color: darkPurple,
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 15),
          const CircleAvatar(
            radius: 19,
            backgroundColor: Color(0xFFE8E0FF),
            child: Icon(Icons.person, color: purple),
          ),
        ],
      ),
    );
  }

  Widget _welcome() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Halo, Selamat Datang! 👋',
          style: TextStyle(
            fontSize: 27,
            fontWeight: FontWeight.bold,
            color: darkPurple,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'Atur aktivitasmu dan selesaikan semua tugas hari ini.',
          style: TextStyle(
            color: Colors.grey.shade600,
            fontSize: 14,
          ),
        ),
      ],
    );
  }

  Widget _statistics() {
    return LayoutBuilder(
      builder: (context, constraints) {
        final items = [
          _statCard(
            'Total Tugas',
            '${tasks.length}',
            Icons.assignment_outlined,
            purple,
          ),
          _statCard(
            'Selesai',
            '$completedCount',
            Icons.task_alt,
            Colors.green,
          ),
          _statCard(
            'Belum Selesai',
            '${tasks.length - completedCount}',
            Icons.pending_actions,
            Colors.orange,
          ),
        ];

        if (constraints.maxWidth < 550) {
          return Column(
            children: items.map((item) => Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: item,
            )).toList(),
          );
        }

        return Row(
          children: [
            for (int i = 0; i < items.length; i++) ...[
              Expanded(child: items[i]),
              if (i != items.length - 1)
                const SizedBox(width: 16),
            ],
          ],
        );
      },
    );
  }

  Widget _statCard(
    String title,
    String value,
    IconData icon,
    Color color,
  ) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: const Color(0xFFEFEDF5)),
      ),
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Icon(icon, color: color),
          ),
          const SizedBox(width: 13),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 12,
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: darkPurple,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _progressCard() {
    final progress = tasks.isEmpty
        ? 0.0
        : completedCount / tasks.length;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(25),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [purple, darkPurple],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            children: [
              Icon(Icons.auto_awesome, color: Colors.white),
              SizedBox(width: 10),
              Text(
                'Progress Aktivitasmu',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 17),
          Text(
            '${(progress * 100).toStringAsFixed(0)}% selesai',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 13),
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: LinearProgressIndicator(
              value: progress,
              minHeight: 10,
              backgroundColor: Colors.white24,
              valueColor: const AlwaysStoppedAnimation(Colors.white),
            ),
          ),
          const SizedBox(height: 10),
          Text(
            '$completedCount dari ${tasks.length} tugas telah diselesaikan.',
            style: const TextStyle(
              color: Colors.white70,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }

  Widget _taskSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Daftar Tugas',
          style: TextStyle(
            fontSize: 21,
            fontWeight: FontWeight.bold,
            color: darkPurple,
          ),
        ),
        const SizedBox(height: 7),
        const Text(
          'Kelola dan pantau semua aktivitasmu.',
          style: TextStyle(color: Colors.grey, fontSize: 13),
        ),
        const SizedBox(height: 20),
        Row(
          children: [
            Expanded(
              child: TextField(
                controller: controller,
                onSubmitted: (_) => addTask(),
                decoration: InputDecoration(
                  hintText: 'Tuliskan tugas baru...',
                  filled: true,
                  fillColor: Colors.white,
                  prefixIcon: const Icon(
                    Icons.edit_note,
                    color: purple,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                    borderSide: const BorderSide(
                      color: Color(0xFFE9E5F1),
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                    borderSide: const BorderSide(
                      color: Color(0xFFE9E5F1),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 10),
            SizedBox(
              height: 55,
              child: ElevatedButton.icon(
                onPressed: addTask,
                icon: const Icon(Icons.add),
                label: const Text('Tambah'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: purple,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(13),
                  ),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 18),
        Wrap(
          spacing: 9,
          children: ['Semua', 'Belum selesai', 'Selesai'].map((item) {
            final selected = filter == item;
            return ChoiceChip(
              label: Text(item),
              selected: selected,
              onSelected: (_) {
                setState(() => filter = item);
              },
              selectedColor: const Color(0xFFE9E2FF),
              labelStyle: TextStyle(
                color: selected ? purple : Colors.black54,
                fontWeight:
                    selected ? FontWeight.bold : FontWeight.normal,
                fontSize: 12,
              ),
              side: BorderSide.none,
            );
          }).toList(),
        ),
        const SizedBox(height: 15),
        if (filteredTasks.isEmpty)
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(35),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
            ),
            child: const Column(
              children: [
                Icon(Icons.inbox_outlined, size: 40, color: Colors.grey),
                SizedBox(height: 10),
                Text(
                  'Tidak ada tugas di sini.',
                  style: TextStyle(color: Colors.grey),
                ),
              ],
            ),
          ),
        ...filteredTasks.map((task) {
          return Container(
            margin: const EdgeInsets.only(bottom: 11),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
              border: Border.all(color: const Color(0xFFEFEDF5)),
            ),
            child: ListTile(
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 15,
                vertical: 6,
              ),
              leading: Checkbox(
                value: task.completed,
                activeColor: purple,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
                onChanged: (value) {
                  setState(() => task.completed = value ?? false);
                },
              ),
              title: Text(
                task.title,
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  decoration: task.completed
                      ? TextDecoration.lineThrough
                      : null,
                  color: task.completed ? Colors.grey : darkPurple,
                ),
              ),
              subtitle: Text(
                task.completed ? 'Selesai' : 'Sedang dikerjakan',
                style: TextStyle(
                  fontSize: 11,
                  color: task.completed ? Colors.green : Colors.orange,
                ),
              ),
              trailing: IconButton(
                icon: const Icon(
                  Icons.delete_outline,
                  color: Colors.redAccent,
                ),
                onPressed: () {
                  setState(() => tasks.remove(task));
                },
              ),
            ),
          );
        }),
      ],
    );
  }

  Widget _footer() {
    return const Center(
      child: Text(
        'ChainTodo • Manage your tasks, build your future.',
        style: TextStyle(color: Colors.grey, fontSize: 11),
      ),
    );
  }
}
