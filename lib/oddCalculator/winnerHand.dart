import 'package:bustem2/main.dart';
import 'package:bustem2/oddCalculator/handRanking.dart';
import 'package:bustem2/oddCalculator/modifiedHand.dart';

import '../cards.dart';
import '../main.dart';

class winnerHand {
  int min = 11;
  int minI;
  List<int> equals = [];

  List<modifideHand> winner(List<Cards> list) {
    List<int> frequencies = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0];
    List<Cards> center = [
      list[list.length - 5],
      list[list.length - 4],
      list[list.length - 3],
      list[list.length - 2],
      list[list.length - 1],
    ];
    for (int a = 0; a < 5; a++) {
      frequencies[center[a].rank - 1]++;
    }

    List<Cards> sortById = List.from(center);
    sortById.sort((b, a) => a.id.compareTo(b.id));

    List<int> sortByRank = [
      center[0].rank,
      center[1].rank,
      center[2].rank,
      center[3].rank,
      center[4].rank
    ];
    sortByRank.sort((b, a) => a.compareTo(b));

    rank r = new rank(sortById, sortByRank, frequencies);
    List<modifideHand> H = [];

    for (int i = 0; i < staticValues.getPlayerNo(); i++) {
      modifideHand m = new modifideHand();
      modifideHand n = new modifideHand();

      n = r.ranking(list[2 * i], list[(2 * i) + 1], m);
      H.add(n);
    }

    findWinner(H);
    return H;
  }

  void findWinner(List<modifideHand> H) {
    int maxState = 0;
    for (int x = 0; x < staticValues.getPlayerNo(); x++) {
      if (maxState < H[x].status) {
        maxState = H[x].status;
      }
    }
    //royal flush
    if (maxState == 10) {
      int counter = 0;
      int index = -1;
      for (int x = 0; x < staticValues.getPlayerNo(); x++) {
        if (H[x].status == maxState) {
          counter++;
          //behine na n+1
          index = x;
        }
      }
      if (counter == 1) {
        H[index].winLose = 1;
        staticValues.setTotalwins(index, 1);
        //behine khodesh default 0 ee
        for (int y = 0; y < staticValues.getPlayerNo(); y++) {
          if (y != index) {
            H[y].winLose = 0;
          }
        }
        return;
      }
      for (int y = 0; y < staticValues.getPlayerNo(); y++) {
        H[y].winLose = (1 / counter);
        staticValues.setTotalwins(y, 1 / counter);
      }
      return;
    }

    //straight flush
    if (maxState == 9) {
      int counter = 0;
      int index = -1;
      int maxCard = 0;
      for (int x = 0; x < staticValues.getPlayerNo(); x++) {
        if (H[x].status == maxState) {
          if (maxCard < H[x].modifiedCard[0]) {
            maxCard = H[x].modifiedCard[0];
          }
        }
      }
      for (int x = 0; x < staticValues.getPlayerNo(); x++) {
        if (H[x].status == maxState) {
          if (maxCard == H[x].modifiedCard[0]) {
            counter++;
            index = x;
          }
        }
      }
      if (counter == 1) {
        H[index].winLose = 1;
        staticValues.setTotalwins(index, 1);
        for (int y = 0; y < staticValues.getPlayerNo(); y++) {
          if (y != index) {
            H[y].winLose = 0;
          }
        }
        return;
      }
      for (int y = 0; y < staticValues.getPlayerNo(); y++) {
        H[y].winLose = (1 / counter);
        staticValues.setTotalwins(y, 1 / counter);
      }
      return;
    }

    //Four of a kind
    if (maxState == 8) {
      int counter = 0;
      int index = -1;
      int maxCard = 0;
      for (int x = 0; x < staticValues.getPlayerNo(); x++) {
        if (H[x].status == maxState) {
          if (maxCard < H[x].modifiedCard[0]) {
            maxCard = H[x].modifiedCard[0];
          }
        }
      }
      for (int x = 0; x < staticValues.getPlayerNo(); x++) {
        if (H[x].status == maxState) {
          if (maxCard == H[x].modifiedCard[0]) {
            counter++;
            index = x;
          }
        }
      }
      if (counter == 1) {
        H[index].winLose = 1;
        staticValues.setTotalwins(index, 1);
        for (int y = 0; y < staticValues.getPlayerNo(); y++) {
          if (y != index) {
            H[y].winLose = 0;
          }
        }
        return;
      }
      counter = 0;
      index = -1;
      maxCard = 0;
      for (int x = 0; x < staticValues.getPlayerNo(); x++) {
        if (maxCard < H[x].modifiedCard[1]) {
          maxCard = H[x].modifiedCard[1];
        }
      }
      for (int x = 0; x < staticValues.getPlayerNo(); x++) {
        if (H[x].modifiedCard[1] == maxCard) {
          counter++;
          index = x;
        }
      }
      if (counter == 1) {
        H[index].winLose = 1;
        staticValues.setTotalwins(index, 1);
        for (int y = 0; y < staticValues.getPlayerNo(); y++) {
          if (y != index) {
            H[y].winLose = 0;
          }
        }
        return;
      }
      for (int x = 0; x < staticValues.getPlayerNo(); x++) {
        if (H[x].modifiedCard[1] == maxCard) {
          H[x].winLose = (1 / counter);
          staticValues.setTotalwins(x, 1 / counter);
        } else {
          H[x].winLose = 0;
        }
      }
      return;
    }
    //full house
    if (maxState == 7) {
      int counter = 0;
      int index = -1;
      int maxCard = 0;
      for (int x = 0; x < staticValues.getPlayerNo(); x++) {
        if (H[x].status == maxState) {
          if (H[x].modifiedCard[0] > maxCard) {
            maxCard = H[x].modifiedCard[0];
          }
        }
      }
      for (int x = 0; x < staticValues.getPlayerNo(); x++) {
        if (H[x].status == maxState) {
          if (maxCard == H[x].modifiedCard[0]) {
            counter++;
            index = x;
          }
        }
      }
      if (counter == 1) {
        H[index].winLose = 1;
        staticValues.setTotalwins(index, 1);
        for (int y = 0; y < staticValues.getPlayerNo(); y++) {
          if (y != index) {
            H[y].winLose = 0;
          }
        }
        return;
      }
      counter = 0;
      index = -1;
      int maxCard2 = 0;
      for (int x = 0; x < staticValues.getPlayerNo(); x++) {
        if (H[x].status == maxState) {
          if (H[x].modifiedCard[0] == maxCard) {
            if (maxCard2 < H[x].modifiedCard[1]) {
              maxCard2 = H[x].modifiedCard[1];
            }
          }
        }
      }
      for (int x = 0; x < staticValues.getPlayerNo(); x++) {
        if (H[x].status == maxState) {
          if (H[x].modifiedCard[0] == maxCard) {
            if (H[x].modifiedCard[1] == maxCard2) {
              counter++;
              index = x;
            }
          }
        }
      }
      if (counter == 1) {
        H[index].winLose = 1;
        staticValues.setTotalwins(index, 1);
        for (int y = 0; y < staticValues.getPlayerNo(); y++) {
          if (y != index) {
            H[y].winLose = 0;
          }
        }
        return;
      }
      for (int x = 0; x < staticValues.getPlayerNo(); x++) {
        if (H[x].modifiedCard[0] == maxCard) {
          if (H[x].modifiedCard[1] == maxCard2) {
            H[x].winLose = (1 / counter);
            staticValues.setTotalwins(x, 1 / counter);
          } else {
            H[x].winLose = 0;
          }
        } else {
          H[x].winLose = 0;
        }
      }
      return;
    }
    //flush
    if (maxState == 6) {
      int counter = 0;
      int index = 0;
      while (
          index < staticValues.getPlayerNo() && H[index].status != maxState) {
        index++;
      }
      for (int x = 0; x < staticValues.getPlayerNo(); x++) {
        if (H[x].status == maxState) {
          if (isLower(H[index].modifiedCard, H[x].modifiedCard, 5)) {
            index = x;
          }
        }
      }
      for (int x = 0; x < staticValues.getPlayerNo(); x++) {
        if (H[x].status == maxState) {
          if (isEquals(H[index].modifiedCard, H[x].modifiedCard, 5)) {
            counter++;
          }
        }
      }
      if (counter == 1) {
        H[index].winLose = 1;
        staticValues.setTotalwins(index, 1);
        for (int y = 0; y < staticValues.getPlayerNo(); y++) {
          if (y != index) {
            H[y].winLose = 0;
          }
        }
        return;
      }
      for (int x = 0; x < staticValues.getPlayerNo(); x++) {
        if (H[x].status == maxState) {
          if (isEquals(H[index].modifiedCard, H[x].modifiedCard, 5)) {
            H[x].winLose = (1 / counter);
            staticValues.setTotalwins(x, 1 / counter);
          } else {
            H[x].winLose = 0;
          }
        } else {
          H[x].winLose = 0;
        }
      }
      return;
    }
    //straight
    if (maxState == 5) {
      int counter = 0;
      int maxCard = 0;
      int index = -1;
      for (int x = 0; x < staticValues.getPlayerNo(); x++) {
        if (H[x].status == maxState) {
          if (H[x].modifiedCard[0] > maxState) {
            maxCard = H[x].modifiedCard[0];
          }
        }
      }
      for (int x = 0; x < staticValues.getPlayerNo(); x++) {
        if (H[x].status == maxState) {
          if (H[x].modifiedCard[0] == maxCard) {
            counter++;
            index = x;
          }
        }
      }
      if (counter == 1) {
        H[index].winLose = 1;
        staticValues.setTotalwins(index, 1);
        for (int y = 0; y < staticValues.getPlayerNo(); y++) {
          if (y != index) {
            H[y].winLose = 0;
          }
        }
        return;
      }
      for (int x = 0; x < staticValues.getPlayerNo(); x++) {
        if (H[x].status == maxState) {
          if (H[x].modifiedCard[0] == maxCard) {
            H[x].winLose = (1 / counter);
            staticValues.setTotalwins(x, 1 / counter);
          } else {
            H[x].winLose = 0;
          }
        } else {
          H[x].winLose = 0;
        }
      }
      return;
    }
    //three of a kind
    if (maxState == 4) {
      int counter = 0;
      int index = 0;
      while (
          index < staticValues.getPlayerNo() && H[index].status != maxState) {
        index++;
      }
      for (int x = 0; x < staticValues.getPlayerNo(); x++) {
        if (H[x].status == maxState) {
          if (isLower(H[index].modifiedCard, H[x].modifiedCard, 3)) {
            index = x;
          }
        }
      }
      for (int x = 0; x < staticValues.getPlayerNo(); x++) {
        if (H[x].status == maxState) {
          if (isEquals(H[index].modifiedCard, H[x].modifiedCard, 3)) {
            counter++;
          }
        }
      }
      if (counter == 1) {
        H[index].winLose = 1;
        staticValues.setTotalwins(index, 1);
        for (int y = 0; y < staticValues.getPlayerNo(); y++) {
          if (y != index) {
            H[y].winLose = 0;
          }
        }
        return;
      }
      for (int x = 0; x < staticValues.getPlayerNo(); x++) {
        if (H[x].status == maxState) {
          if (isEquals(H[index].modifiedCard, H[x].modifiedCard, 3)) {
            H[x].winLose = (1 / counter);
            staticValues.setTotalwins(x, 1 / counter);
          } else {
            H[x].winLose = 0;
          }
        } else {
          H[x].winLose = 0;
        }
      }
      return;
    }
    //two pair
    if (maxState == 3) {
      int counter = 0;
      int index = 0;
      while (
          index < staticValues.getPlayerNo() && H[index].status != maxState) {
        index++;
      }
      for (int x = 0; x < staticValues.getPlayerNo(); x++) {
        if (H[x].status == maxState) {
          if (isLower(H[index].modifiedCard, H[x].modifiedCard, 3)) {
            index = x;
          }
        }
      }
      for (int x = 0; x < staticValues.getPlayerNo(); x++) {
        if (H[x].status == maxState) {
          if (isEquals(H[index].modifiedCard, H[x].modifiedCard, 3)) {
            counter++;
          }
        }
      }
      if (counter == 1) {
        H[index].winLose = 1;
        staticValues.setTotalwins(index, 1);
        for (int y = 0; y < staticValues.getPlayerNo(); y++) {
          if (y != index) {
            H[y].winLose = 0;
          }
        }
        return;
      }
      for (int x = 0; x < staticValues.getPlayerNo(); x++) {
        if (H[x].status == maxState) {
          if (isEquals(H[index].modifiedCard, H[x].modifiedCard, 3)) {
            H[x].winLose = (1 / counter);
            staticValues.setTotalwins(x, 1 / counter);
          } else {
            H[x].winLose = 0;
          }
        } else {
          H[x].winLose = 0;
        }
      }
      return;
    }
    //pair
    if (maxState == 2) {
      int counter = 0;
      int index = 0;
      while (
          index < staticValues.getPlayerNo() && H[index].status != maxState) {
        index++;
      }
      for (int x = 0; x < staticValues.getPlayerNo(); x++) {
        if (H[x].status == maxState) {
          if (isLower(H[index].modifiedCard, H[x].modifiedCard, 4)) {
            index = x;
          }
        }
      }
      for (int x = 0; x < staticValues.getPlayerNo(); x++) {
        if (H[x].status == maxState) {
          if (isEquals(H[index].modifiedCard, H[x].modifiedCard, 4)) {
            counter++;
          }
        }
      }
      if (counter == 1) {
        H[index].winLose = 1;
        staticValues.setTotalwins(index, 1);
        for (int y = 0; y < staticValues.getPlayerNo(); y++) {
          if (y != index) {
            H[y].winLose = 0;
          }
        }
        return;
      }
      for (int x = 0; x < staticValues.getPlayerNo(); x++) {
        if (H[x].status == maxState) {
          if (isEquals(H[index].modifiedCard, H[x].modifiedCard, 4)) {
            H[x].winLose = (1 / counter);
            staticValues.setTotalwins(x, 1 / counter);
          } else {
            H[x].winLose = 0;
          }
        } else {
          H[x].winLose = 0;
        }
      }
      return;
    }
    //highcard
    if (maxState == 1) {
      int counter = 0;
      int index = 0;
      while (
          index < staticValues.getPlayerNo() && H[index].status != maxState) {
        index++;
      }
      for (int x = 0; x < staticValues.getPlayerNo(); x++) {
        if (H[x].status == maxState) {
          if (isLower(H[index].modifiedCard, H[x].modifiedCard, 5)) {
            index = x;
          }
        }
      }
      for (int x = 0; x < staticValues.getPlayerNo(); x++) {
        if (H[x].status == maxState) {
          if (isEquals(H[index].modifiedCard, H[x].modifiedCard, 5)) {
            counter++;
          }
        }
      }
      if (counter == 1) {
        H[index].winLose = 1;
        staticValues.setTotalwins(index, 1);
        for (int y = 0; y < staticValues.getPlayerNo(); y++) {
          if (y != index) {
            H[y].winLose = 0;
          }
        }
        return;
      }
      for (int x = 0; x < staticValues.getPlayerNo(); x++) {
        if (H[x].status == maxState) {
          if (isEquals(H[index].modifiedCard, H[x].modifiedCard, 5)) {
            H[x].winLose = (1 / counter);
            staticValues.setTotalwins(x, 1 / counter);
          } else {
            H[x].winLose = 0;
          }
        } else {
          H[x].winLose = 0;
        }
      }
      return;
    }
  }

  bool isEquals(List<int> a, List<int> b, int m) {
    int i = 0;
    while (a[i] == b[i]) {
      i++;
      if (i == m) {
        break;
      }
    }
    if (i == m) {
      return true;
    }

    return false;
  }

  bool isLower(List<int> a, List<int> b, int m) {
    int i = 0;
    while (a[i] == b[i]) {
      i++;
      if (i == m) break;
    }
    if (i < m) if (a[i] < b[i]) {
      return true;
    }
    return false;
  }
}
