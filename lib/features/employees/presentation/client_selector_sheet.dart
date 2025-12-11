import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/database/app_database.dart';

class ClientSelectorSheet extends StatefulWidget {
  final List<Client> clients;
  final Function(Client) onSelect;

  const ClientSelectorSheet({
    super.key,
    required this.clients,
    required this.onSelect,
  });

  @override
  State<ClientSelectorSheet> createState() => _ClientSelectorSheetState();
}

class _ClientSelectorSheetState extends State<ClientSelectorSheet> {
  late List<Client> _filteredClients;

  @override
  void initState() {
    super.initState();
    _filteredClients = widget.clients;
  }

  void _filterClients(String query) {
    setState(() {
      if (query.isEmpty) {
        _filteredClients = widget.clients;
      } else {
        _filteredClients = widget.clients
            .where(
              (c) =>
                  c.name.toLowerCase().contains(query.toLowerCase()) ||
                  (c.address?.toLowerCase().contains(query.toLowerCase()) ??
                      false),
            )
            .toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(16),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          ),
          child: Column(
            children: [
              Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                'اختر جهة العمل',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              TextField(
                onChanged: _filterClients,
                decoration: InputDecoration(
                  hintText: 'بحث باسم العميل...',
                  prefixIcon: const Icon(Icons.search),
                  filled: true,
                  fillColor: Colors.grey.shade100,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: _filteredClients.isEmpty
              ? const Center(child: Text('لا توجد نتائج'))
              : ListView.separated(
                  padding: const EdgeInsets.all(16),
                  itemCount: _filteredClients.length,
                  separatorBuilder: (context, index) => const Divider(),
                  itemBuilder: (context, index) {
                    final client = _filteredClients[index];
                    return ListTile(
                      leading: CircleAvatar(
                        backgroundColor: AppColors.jabaliBlue.withValues(
                          alpha: 0.1,
                        ),
                        child: const Icon(
                          Icons.store,
                          color: AppColors.jabaliBlue,
                        ),
                      ),
                      title: Text(
                        client.name,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text(
                        client.address ?? 'لا يوجد عنوان',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      onTap: () => widget.onSelect(client),
                    );
                  },
                ),
        ),
      ],
    );
  }
}
