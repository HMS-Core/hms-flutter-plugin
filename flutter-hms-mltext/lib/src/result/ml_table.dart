/*
 * Copyright 2021-2024. Huawei Technologies Co., Ltd. All rights reserved.
 *
 * Licensed under the Apache License, Version 2.0 (the "License")
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      https://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

part of '../../huawei_ml_text.dart';

class MLFormRecognitionTablesAttribute {
  int? retCode;
  TablesContent? tablesContent;

  MLFormRecognitionTablesAttribute({
    this.retCode,
    this.tablesContent,
  });

  factory MLFormRecognitionTablesAttribute.fromJson(Map<String, dynamic> json) {
    return MLFormRecognitionTablesAttribute(
      retCode: json['retCode'],
      tablesContent: json['tableContent'] != null
          ? TablesContent.fromJson(json['tableContent'])
          : null,
    );
  }
}

class TablesContent {
  List<TableAttribute?> tableAttributes;
  int? tableCount;

  TablesContent({
    required this.tableAttributes,
    this.tableCount,
  });

  factory TablesContent.fromJson(Map<String, dynamic> json) {
    final List<TableAttribute> attributes = <TableAttribute>[];

    if (json['tables'] != null) {
      json['tables'].forEach((dynamic v) {
        attributes.add(TableAttribute.fromJson(v));
      });
    }
    return TablesContent(
      tableAttributes: attributes,
      tableCount: json['tableCount'],
    );
  }
}

class TableAttribute {
  List<TableCellAttribute?> tableCellAttributes;
  int? id;

  TableAttribute({
    required this.tableCellAttributes,
    this.id,
  });

  factory TableAttribute.fromJson(Map<String, dynamic> json) {
    final List<TableCellAttribute> attributes = <TableCellAttribute>[];

    if (json['tableBody'] != null) {
      json['tableBody'].forEach((dynamic v) {
        attributes.add(TableCellAttribute.fromJson(v));
      });
    }
    return TableAttribute(
      tableCellAttributes: attributes,
      id: json['tableID'],
    );
  }
}

class TableCellAttribute {
  int? endCol;
  int? endRow;
  int? startCol;
  int? startRow;
  String? textInfo;
  TableCellCoordinateAttribute? tableCellCoordinateAttribute;

  TableCellAttribute({
    this.endCol,
    this.tableCellCoordinateAttribute,
    this.endRow,
    this.startCol,
    this.startRow,
    this.textInfo,
  });

  factory TableCellAttribute.fromJson(Map<String, dynamic> json) {
    return TableCellAttribute(
      endCol: json['endCol'],
      endRow: json['endRow'],
      startCol: json['startCol'],
      startRow: json['startRow'],
      textInfo: json['textInfo'],
      tableCellCoordinateAttribute: json['cellCoordinate'] != null
          ? TableCellCoordinateAttribute.fromJson(json['cellCoordinate'])
          : null,
    );
  }
}

class TableCellCoordinateAttribute {
  double? bottomLeftX;
  double? bottomLeftY;
  double? bottomRightX;
  double? bottomRightY;
  double? topLeftX;
  double? topLeftY;
  double? topRightX;
  double? topRightY;

  TableCellCoordinateAttribute({
    this.bottomLeftX,
    this.bottomLeftY,
    this.bottomRightX,
    this.bottomRightY,
    this.topLeftX,
    this.topLeftY,
    this.topRightX,
    this.topRightY,
  });

  factory TableCellCoordinateAttribute.fromJson(Map<String, dynamic> json) {
    return TableCellCoordinateAttribute(
      bottomLeftX: json['bottomLeft_x'],
      bottomLeftY: json['bottomLeft_y'],
      bottomRightX: json['bottomRight_x'],
      bottomRightY: json['bottomRight_y'],
      topLeftX: json['topLeft_x'],
      topLeftY: json['topLeft_y'],
      topRightX: json['topRight_x'],
      topRightY: json['topRight_y'],
    );
  }
}
