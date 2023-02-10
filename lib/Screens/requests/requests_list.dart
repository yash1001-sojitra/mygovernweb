import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mygovernweb/models/request.dart';

class RequestDetails extends StatelessWidget {
  final DocRequest? request;
  final Function(String reqId, bool isDeclined) changeState;
  const RequestDetails(this.request, this.changeState, {super.key});

  @override
  Widget build(BuildContext context) {
    return request == null
        ? const Center(
            child: Text('Empty'),
          )
        : Container(
            padding: const EdgeInsets.all(10),
            margin: const EdgeInsets.all(5),
            decoration: BoxDecoration(
              /* border: Border.all(), */
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    const Expanded(child: Text('Name : ')),
                    Expanded(
                      child: Text(request!.profileModel.name ?? "No name"),
                    ),
                  ],
                ),
                const Divider(),
                Row(
                  children: [
                    const Expanded(child: Text('Request : ')),
                    Expanded(
                      child: Text(request!.request),
                    ),
                  ],
                ),
                const Divider(),
                Row(
                  children: [
                    const Expanded(child: Text('Request Id : ')),
                    Expanded(
                      child: Text(request!.requestId),
                    ),
                  ],
                ),
                const Divider(),
                Row(
                  children: [
                    const Expanded(child: Text('Aadhar : ')),
                    Expanded(
                      child: Text(request!.profileModel.aadhar ?? ""),
                    ),
                  ],
                ),
                const Divider(),
                Row(
                  children: [
                    const Expanded(child: Text('Passport : ')),
                    Expanded(
                      child: Text(request!.profileModel.passport ?? ""),
                    ),
                  ],
                ),
                const Divider(),
                Row(
                  children: [
                    const Expanded(child: Text('Pan : ')),
                    Expanded(
                      child: Text(request!.profileModel.pan ?? ""),
                    ),
                  ],
                ),
                const Divider(),
                Row(
                  children: [
                    const Expanded(child: Text('DOB : ')),
                    Expanded(
                      child: Text(request!.profileModel.dob ?? ""),
                    ),
                  ],
                ),
                const Divider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(Colors.green),
                      ),
                      onPressed: () async {
                        await FirebaseFirestore.instance
                            .collection("Requests")
                            .doc(request?.profileModel.uid)
                            .collection("Documents")
                            .doc(request?.request)
                            .update({'status': 1});
                        changeState(request!.requestId, false);
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                backgroundColor: Colors.green,
                                content: Text('Approved Sucessfully!')));
                      },
                      child: const Text('Approve'),
                    ),
                    ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(Colors.red),
                      ),
                      onPressed: () async {
                        await FirebaseFirestore.instance
                            .collection("Requests")
                            .doc(request?.profileModel.uid)
                            .collection("Documents")
                            .doc(request?.request)
                            .update({'status': 2});
                        changeState(request!.requestId, true);
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                backgroundColor: Colors.red,
                                content: Text('Declined Sucessfully!')));
                      },
                      child: const Text('Declined'),
                    ),
                  ],
                ),
              ],
            ),
          );
  }
}
