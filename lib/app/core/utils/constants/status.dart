String statusCodeToString(int statusCode) {
  switch (statusCode) {
    case 0:
      return "All";
    case 1:
      return "New";
    case 2:
      return "Confirm";
    case 3:
      return "Waiting for ship";
    case 4:
      return "Complete";
    case 5:
      return "Cancel";
    default:
      return "";
  }
}
