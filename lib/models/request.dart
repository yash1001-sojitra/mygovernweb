enum REQUEST {
  STATUS_PENDING,
  STATUS_APPROVE,
  STATUS_DECLINED,
}

class DocRequest {
  final String request;
  final String requestId;
  final ProfileModel profileModel;
  final String message;
  REQUEST status;

  DocRequest(this.request, this.requestId, this.profileModel, this.message,
      this.status);
}

class ProfileModel {
  final String? aadhar;
  final String? pan;
  final String? name;
  final String? dob;
  final String? passport;
  final String? imageUrl;
  final String uid;

  ProfileModel(this.aadhar, this.pan, this.name, this.dob, this.passport,
      this.imageUrl, this.uid);
}
