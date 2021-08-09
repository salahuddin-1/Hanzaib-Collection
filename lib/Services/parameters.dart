class UserParameters {
  late final String toName;
  late final String toPhoneNo;
  late final String toAddress;
  late final String toPincode;
  late final String fromName;
  late final String fromPhoneNo;

  UserParameters(
    String toName,
    String toPhoneNo,
    String toAddress,
    String toPincode,
    String fromName,
    String fromPhoneNo,
  ) {
    this.toName = toName;
    this.toPhoneNo = toPhoneNo;
    this.toAddress = toAddress;
    this.toPincode = toPincode;
    this.fromPhoneNo = fromPhoneNo;
    this.fromName = fromName;
  }
}
