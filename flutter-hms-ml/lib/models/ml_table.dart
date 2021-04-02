/*
    Copyright 2020-2021. Huawei Technologies Co., Ltd. All rights reserved.

    Licensed under the Apache License, Version 2.0 (the "License")
    you may not use this file except in compliance with the License.
    You may obtain a copy of the License at

        https://www.apache.org/licenses/LICENSE-2.0

    Unless required by applicable law or agreed to in writing, software
    distributed under the License is distributed on an "AS IS" BASIS,
    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
    See the License for the specific language governing permissions and
    limitations under the License.
*/

class MLTable {
  int retCode;
  MLTableContent tableContent;

  MLTable({this.retCode, this.tableContent});

  MLTable.fromJson(Map<String, dynamic> json) {
    retCode = json['retCode'];
    tableContent = json['tableContent'] != null
        ? new MLTableContent.fromJson(json['tableContent'])
        : null;
  }
}

class MLTableContent {
  int tableCount;
  List<MLTables> tables;

  MLTableContent({this.tableCount, this.tables});

  MLTableContent.fromJson(Map<String, dynamic> json) {
    tableCount = json['tableCount'];
    if (json['tables'] != null) {
      tables = new List<MLTables>();
      json['tables'].forEach((v) {
        tables.add(new MLTables.fromJson(v));
      });
    }
  }
}

class MLTables {
  int tableID;
  String headerInfo;
  String footerInfo;
  List<MLTableBody> tableBody;

  MLTables({this.tableID, this.headerInfo, this.footerInfo, this.tableBody});

  MLTables.fromJson(Map<String, dynamic> json) {
    tableID = json['tableID'];
    headerInfo = json['headerInfo'];
    footerInfo = json['footerInfo'];
    if (json['tableBody'] != null) {
      tableBody = new List<MLTableBody>();
      json['tableBody'].forEach((v) {
        tableBody.add(new MLTableBody.fromJson(v));
      });
    }
  }
}

class MLTableBody {
  int startRow;
  int endRow;
  int startCol;
  int endCol;
  MLCellCoordinate cellCoordinate;
  String textInfo;

  MLTableBody(
      {this.startRow,
      this.endRow,
      this.startCol,
      this.endCol,
      this.cellCoordinate,
      this.textInfo});

  MLTableBody.fromJson(Map<String, dynamic> json) {
    startRow = json['startRow'];
    endRow = json['endRow'];
    startCol = json['startCol'];
    endCol = json['endCol'];
    cellCoordinate = json['cellCoordinate'] != null
        ? new MLCellCoordinate.fromJson(json['cellCoordinate'])
        : null;
    textInfo = json['textInfo'];
  }
}

class MLCellCoordinate {
  dynamic topLeftX;
  dynamic topLeftY;
  dynamic topRightX;
  dynamic topRightY;
  dynamic bottomLeftX;
  dynamic bottomLeftY;
  dynamic bottomRightX;
  dynamic bottomRightY;

  MLCellCoordinate(
      {this.topLeftX,
      this.topLeftY,
      this.topRightX,
      this.topRightY,
      this.bottomLeftX,
      this.bottomLeftY,
      this.bottomRightX,
      this.bottomRightY});

  MLCellCoordinate.fromJson(Map<String, dynamic> json) {
    topLeftX = json['topLeft_x'];
    topLeftY = json['topLeft_y'];
    topRightX = json['topRight_x'];
    topRightY = json['topRight_y'];
    bottomLeftX = json['bottomLeft_x'];
    bottomLeftY = json['bottomLeft_y'];
    bottomRightX = json['bottomRight_x'];
    bottomRightY = json['bottomRight_y'];
  }
}
