import 'package:flutter/material.dart';

import '../../models/request.dart';

class RequestDocs extends StatelessWidget {
  final List<DocRequest> data;
  final Function(String request) funnction;
  const RequestDocs(this.data, this.funnction, {super.key});

  @override
  Widget build(BuildContext context) {
    final ids = data.map((e) => e.request).toSet().toList();
    return ListView.builder(
        shrinkWrap: true,
        itemCount: ids.length,
        itemBuilder: (context, index) {
          return ListTile(
            onTap: () {
              funnction(ids[index]);
            },
            title: Text(
              data[index].request,
              style: const TextStyle(color: Colors.white),
            ),
            trailing: const Icon(
              Icons.arrow_forward_ios_outlined,
              color: Colors.white,
            ),
          );
        });
  }
}
