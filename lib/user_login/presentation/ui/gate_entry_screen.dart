
import 'package:flutter/material.dart';
import 'package:example/user_login/data/user_login_repo_impl.dart';

class GateEntryScreen extends StatefulWidget {
  const GateEntryScreen({super.key});

  @override
  State<GateEntryScreen> createState() => _GateEntryScreenState();
}

class _GateEntryScreenState extends State<GateEntryScreen> {
  final UserLoginRepoImpl repo = UserLoginRepoImpl();

  List<dynamic> entries = [];
  bool isLoading = true;
  String? errorMessage;

  @override
  void initState() {
    super.initState();
    fetchEntries();
  }

  Future<void> fetchEntries() async {
    setState(() {
      isLoading = true;
      errorMessage = null;
    });

    try {
      final result = await repo.getEntries();

      if (!mounted) return;

      setState(() {
        entries = result;
        isLoading = false;
      });
    } catch (e) {
      if (!mounted) return;

      setState(() {
        errorMessage = e.toString();
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Gate Entries'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            onPressed: fetchEntries,
            icon: const Icon(Icons.refresh),
          ),
        ],
      ),
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : errorMessage != null
              ? Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        errorMessage!,
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 12),
                      ElevatedButton(
                        onPressed: fetchEntries,
                        child: const Text('Retry'),
                      ),
                    ],
                  ),
                )
              : entries.isEmpty
                  ? const Center(
                      child: Text('No Gate Entries found'),
                    )
                  : RefreshIndicator(
                      onRefresh: fetchEntries,
                      child: ListView.builder(
                        padding: const EdgeInsets.all(12),
                        itemCount: entries.length,
                        itemBuilder: (context, index) {
                          final entry =
                              entries[index] as Map<String, dynamic>;

                          final status = entry['docstatus'];

                          return Card(
                            margin: const EdgeInsets.only(bottom: 12),
                            elevation: 3,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(16),
                              child: Column(
                                crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      const Icon(
                                        Icons.local_shipping,
                                        color: Colors.blue,
                                        size: 28,
                                      ),
                                      const SizedBox(width: 10),
                                      Expanded(
                                        child: Text(
                                          entry['name']?.toString() ??
                                              'N/A',
                                          style: const TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                      Chip(
                                        label: Text(
                                          status == 1
                                              ? 'Submitted'
                                              : status == 0
                                                  ? 'Draft'
                                                  : 'Cancelled',
                                        ),
                                      ),
                                    ],
                                  ),
                                  const Divider(height: 24),
                                  detailRow(
                                    'Vehicle Number',
                                    entry['vehicle_no'],
                                  ),
                                  detailRow(
                                    'Invoice Number',
                                    entry['vendor_invoice_no'],
                                  ),
                                  detailRow(
                                    'Plant',
                                    entry['plant_name'],
                                  ),
                                  detailRow(
                                    'Entry Date',
                                    entry['gate_entry_date'],
                                  ),
                                  detailRow(
                                    'Entry Time',
                                    entry['gate_entry_time'],
                                  ),
                                  detailRow(
                                    'Gate Number',
                                    entry['gate_number'],
                                  ),
                                  detailRow(
                                    'Invoice Quantity',
                                    entry['vendor_invoice_quantity'],
                                  ),
                                  detailRow(
                                    'Invoice Amount',
                                    entry['invoice_amount'],
                                  ),
                                  if (entry['remarks'] != null &&
                                      entry['remarks']
                                          .toString()
                                          .isNotEmpty)
                                    detailRow(
                                      'Remarks',
                                      entry['remarks'],
                                    ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
    );
  }

  Widget detailRow(String label, dynamic value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 125,
            child: Text(
              label,
              style: const TextStyle(
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Expanded(
            child: Text(value?.toString() ?? 'N/A'),
          ),
        ],
      ),
    );
  }
}
