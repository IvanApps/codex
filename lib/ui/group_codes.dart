class GroupCode {
  String fileCode(int codeId) {
    String newCode = '0';
    if (codeId >= 200 && codeId <= 299) {
      newCode = '2xx';
    }
    if (codeId >= 300 && codeId <= 399) {
      newCode = '3xx';
    }
    if (codeId >= 500 && codeId <= 501) {
      newCode = '50x';
    }
    if (codeId >= 502 && codeId <= 599) {
      newCode = '5xx';
    }
    if (codeId >= 600 && codeId <= 699) {
      newCode = '6xx';
    }
    if (codeId >= 700 && codeId <= 799) {
      newCode = '7xx';
    }
    if (codeId == 800) {
      newCode = '800';
    }
    if (codeId >= 801 && codeId <= 802) {
      newCode = '80x';
    }
    if (codeId >= 803 && codeId <= 804) {
      newCode = '800x';
    }
    return newCode;
  }
}
