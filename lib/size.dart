//TODO bad bakhti asli haminjast :D
//list az size haye dast ha ke che ghadr az chap va bala fasele dashte bashan
class size {
  int playerNo;

  size(this.playerNo);

  List<double> tops() {
    if (playerNo == 10) {
      return [135, 225, 58, 245, 32, 245, 32, 225, 58, 135];
    } else if (playerNo == 9) {
      return [113, 113, 150, 240, 245, 145, 286, 284, 115];
    } else if (playerNo == 8) {
      return [113, 113, 150, 240, 245, 145, 286, 284];
    } else if (playerNo == 7) {
      return [113, 113, 150, 240, 245, 145, 286];
    } else if (playerNo == 6) {
      return [113, 113, 150, 240, 245, 145];
    } else if (playerNo == 5) {
      return [113, 150, 240, 245, 145];
    } else if (playerNo == 4) {
      return [150, 240, 245, 145];
    } else if (playerNo == 3) {
      return [145, 150, 240];
    } else if (playerNo == 2) {
      return [150, 240,];
    }
  }

  List<double> lefts() {
    if (playerNo == 10) {
      return [45, 140, 140, 258, 258, 372, 372, 490, 490, 585];
    } else if (playerNo == 9) {
      return [270, 460, 185, 545, 185, 545, 270, 460, 365];
    } else if (playerNo == 8) {
      return [270, 460, 185, 545, 185, 545, 270, 460];
    } else if (playerNo == 7) {
      return [270, 460, 185, 545, 185, 545, 270];
    } else if (playerNo == 6) {
      return [270, 460, 185, 545, 185, 545];
    } else if (playerNo == 5) {
      return [270, 185, 545, 185, 545];
    } else if (playerNo == 4) {
      return [185, 545, 185, 545];
    } else if (playerNo == 3) {
      return [545, 185, 545];
    } else if (playerNo == 2) {
      return [185, 545];
    }
  }
}