import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mygovernweb/Screens/requests/request_docs.dart';
import 'package:mygovernweb/Screens/requests/requests_list.dart';
import 'package:mygovernweb/models/request.dart';

class RequestsList extends StatefulWidget {
  const RequestsList({super.key});

  @override
  State<RequestsList> createState() => _RequestsListState();
}

class _RequestsListState extends State<RequestsList> {
  List<DocRequest> requests = [];
  List<DocRequest> selectedRequest = [];
  final String _selectedDoc = "";
  DocRequest? _selectedDetail;
  Future<List<DocRequest>> getRequests() async {
    final requestsDocs =
        await FirebaseFirestore.instance.collection("Requests").get();

    for (var document in requestsDocs.docs) {
      final requestCollectionRef = FirebaseFirestore.instance
          .collection("Requests")
          .doc(document.id)
          .collection("Documents");
      final requestsDoc = await requestCollectionRef.get();
      if (requestsDoc.docs.isNotEmpty) {
        for (var doc in requestsDoc.docs) {
          String name = doc.get("name");
          String dob = doc.get("dob");
          String aadhar = doc.get("aadhar");
          String pan = doc.get("pan");
          String passport = doc.get("passport");
          String? imageUrl = doc.get("profileimage");
          String message = doc.get("message");
          int status = doc.get("status");
          requests.add(DocRequest(
            doc.id,
            doc.get("requestId"),
            ProfileModel(
                aadhar, pan, name, dob, passport, imageUrl, document.id),
            message,
            REQUEST.values[status],
          ));
        }
      }
    }
    return requests;
  }

  String getStatus(REQUEST status) {
    switch (status) {
      case REQUEST.STATUS_APPROVE:
        return "Approve";
      case REQUEST.STATUS_DECLINED:
        return "Declined";
      default:
        return "Under Review";
    }
  }

  void changeState(String id, bool isDeclined) {
    setState(() {
      DocRequest req =
          requests.firstWhere((element) => element.requestId == id);
      req.status =
          isDeclined ? REQUEST.STATUS_DECLINED : REQUEST.STATUS_APPROVE;
      requests.removeWhere((element) => element.requestId == id);
      requests.add(req);
    });
  }

  void changeDoc(String request) {
    selectedRequest =
        requests.where((element) => element.request == request).toList();

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<DocRequest>>(
          future: requests.isEmpty ? getRequests() : Future.value(requests),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            return Row(
              children: [
                Expanded(
                  flex: 2,
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    decoration: const BoxDecoration(
                      color: Colors.black26,
                      boxShadow: [
                        BoxShadow(
                          blurRadius: 10,
                        ),
                      ],
                    ),
                    width: 250,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Documents',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const Divider(
                          color: Colors.white,
                        ),
                        RequestDocs(snapshot.data!, changeDoc),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  flex: 4,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListView.builder(
                        itemCount: selectedRequest.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ListTile(
                              onTap: () {
                                setState(() {
                                  _selectedDetail = selectedRequest[index];
                                });
                              },
                              title: Text(
                                  selectedRequest[index].profileModel.name ??
                                      "No name"),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                                side: const BorderSide(),
                              ),
                              trailing: Container(
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  color: Colors.grey,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Text(
                                    getStatus(selectedRequest[index].status)),
                              ),
                            ),
                          );
                        }),
                  ),
                ),
                const Flexible(
                  child: VerticalDivider(),
                ),
                Expanded(
                  flex: 2,
                  child: RequestDetails(_selectedDetail, changeState),
                ),
              ],
            );
          }),
    );
  }
}
