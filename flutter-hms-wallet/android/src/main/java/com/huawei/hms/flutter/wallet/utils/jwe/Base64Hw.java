/*
 * Copyright 2021-2023. Huawei Technologies Co., Ltd. All rights reserved.
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

package com.huawei.hms.flutter.wallet.utils.jwe;

public class Base64Hw {
    private static final int BASELENGTH = 128;

    private static final int LOOKUPLENGTH = 64;

    private static final int TWENTYFOURBITGROUP = 24;

    private static final int EIGHTBIT = 8;

    private static final int SIXTEENBIT = 16;

    private static final int FOURBYTE = 4;

    private static final int SIGN = -128;

    private static final char PAD = '=';

    private static final byte[] BASE64_ALPHABET = new byte[BASELENGTH];

    private static final char[] LOOK_UP_BASE64_ALPHABET = new char[LOOKUPLENGTH];

    static {
        for (int idx = 0; idx < BASELENGTH; ++idx) {
            BASE64_ALPHABET[idx] = -1;
        }
        for (int idx = 'Z'; idx >= 'A'; idx--) {
            BASE64_ALPHABET[idx] = (byte) (idx - 'A');
        }
        for (int idx = 'z'; idx >= 'a'; idx--) {
            BASE64_ALPHABET[idx] = (byte) (idx - 'a' + 26);
        }

        for (int idx = '9'; idx >= '0'; idx--) {
            BASE64_ALPHABET[idx] = (byte) (idx - '0' + 52);
        }

        BASE64_ALPHABET['+'] = 62;
        BASE64_ALPHABET['/'] = 63;

        for (int i = 0; i <= 25; i++) {
            LOOK_UP_BASE64_ALPHABET[i] = (char) ('A' + i);
        }

        for (int i = 26, j = 0; i <= 51; i++, j++) {
            LOOK_UP_BASE64_ALPHABET[i] = (char) ('a' + j);
        }

        for (int i = 52, j = 0; i <= 61; i++, j++) {
            LOOK_UP_BASE64_ALPHABET[i] = (char) ('0' + j);
        }
        LOOK_UP_BASE64_ALPHABET[62] = '+';
        LOOK_UP_BASE64_ALPHABET[63] = '/';
    }

    private static boolean isWhiteSpace(char octect) {
        return (octect == 0x20 || octect == 0xd || octect == 0xa || octect == 0x9);
    }

    private static boolean isPad(char octect) {
        return (octect == PAD);
    }

    private static boolean isData(char octect) {
        return (octect < BASELENGTH && BASE64_ALPHABET[octect] != -1);
    }

    /**
     * Encodes hex octects into Base64Hw
     *
     * @param binaryData Array containing binaryData
     * @return Encoded Base64Hw array
     */
    public static String encode(byte[] binaryData) {
        if (CommonUtil.isNull(binaryData)) {
            return null;
        }

        int lengthDataBits = binaryData.length * EIGHTBIT;
        if (lengthDataBits == 0) {
            return "";
        }

        int fewerThan24bits = lengthDataBits % TWENTYFOURBITGROUP;
        int numberTriplets = lengthDataBits / TWENTYFOURBITGROUP;
        int numberQuartet = fewerThan24bits != 0 ? numberTriplets + 1 : numberTriplets;
        char[] encodedData = new char[numberQuartet * 4];

        byte k1 = 0;
        byte l1 = 0;
        byte b1 = 0;
        byte b2 = 0;
        byte b3 = 0;

        int encodedIndex = 0;
        int dataIndex = 0;
        byte val1 = 0;
        byte val2 = 0;
        byte val3 = 0;
        for (int i = 0; i < numberTriplets; i++) {
            b1 = binaryData[dataIndex++];
            b2 = binaryData[dataIndex++];
            b3 = binaryData[dataIndex++];

            l1 = (byte) (b2 & 0x0f);
            k1 = (byte) (b1 & 0x03);

            val1 = ((b1 & SIGN) == 0) ? (byte) (b1 >> 2) : (byte) ((b1) >> 2 ^ 0xc0);
            val2 = ((b2 & SIGN) == 0) ? (byte) (b2 >> 4) : (byte) ((b2) >> 4 ^ 0xf0);
            val3 = ((b3 & SIGN) == 0) ? (byte) (b3 >> 6) : (byte) ((b3) >> 6 ^ 0xfc);

            encodedData[encodedIndex++] = LOOK_UP_BASE64_ALPHABET[val1];
            encodedData[encodedIndex++] = LOOK_UP_BASE64_ALPHABET[val2 | (k1 << 4)];
            encodedData[encodedIndex++] = LOOK_UP_BASE64_ALPHABET[(l1 << 2) | val3];
            encodedData[encodedIndex++] = LOOK_UP_BASE64_ALPHABET[b3 & 0x3f];
        }

        // form integral number of 6-bit groups
        assembleInteger(binaryData, fewerThan24bits, encodedData, encodedIndex, dataIndex);

        return new String(encodedData);
    }

    private static void assembleInteger(byte[] binaryData, int fewerThan24bits, char[] encodedData, int encodedIndex,
                                        int dataIndex) {
        byte b1;
        byte k1;
        byte b2;
        byte l1;
        byte val4 = 0;
        byte val5 = 0;
        if (fewerThan24bits == EIGHTBIT) {
            b1 = binaryData[dataIndex];
            k1 = (byte) (b1 & 0x03);

            val4 = ((b1 & SIGN) == 0) ? (byte) (b1 >> 2) : (byte) ((b1) >> 2 ^ 0xc0);
            encodedData[encodedIndex++] = LOOK_UP_BASE64_ALPHABET[val4];
            encodedData[encodedIndex++] = LOOK_UP_BASE64_ALPHABET[k1 << 4];
            encodedData[encodedIndex++] = PAD;
            encodedData[encodedIndex++] = PAD;
        } else if (fewerThan24bits == SIXTEENBIT) {
            b1 = binaryData[dataIndex];
            b2 = binaryData[dataIndex + 1];
            l1 = (byte) (b2 & 0x0f);
            k1 = (byte) (b1 & 0x03);

            val4 = ((b1 & SIGN) == 0) ? (byte) (b1 >> 2) : (byte) ((b1) >> 2 ^ 0xc0);
            val5 = ((b2 & SIGN) == 0) ? (byte) (b2 >> 4) : (byte) ((b2) >> 4 ^ 0xf0);

            encodedData[encodedIndex++] = LOOK_UP_BASE64_ALPHABET[val4];
            encodedData[encodedIndex++] = LOOK_UP_BASE64_ALPHABET[val5 | (k1 << 4)];
            encodedData[encodedIndex++] = LOOK_UP_BASE64_ALPHABET[l1 << 2];
            encodedData[encodedIndex++] = PAD;
        }
    }

    /**
     * Decodes Base64Hw data into octects
     *
     * @param encoded string containing Base64Hw data
     * @return Array containind decoded data.
     */
    public static byte[] decode(String encoded) {
        if (CommonUtil.isNull(encoded)) {
            return new byte[0];
        }

        char[] base64Data = encoded.toCharArray();
        // remove white spaces
        int len = removeWhiteSpace(base64Data);

        if (len % FOURBYTE != 0) {
            return new byte[0]; // should be divisible by four
        }

        int numberQuadruple = (len / FOURBYTE);

        if (numberQuadruple == 0) {
            return new byte[0];
        }

        return decode(base64Data, numberQuadruple);
    }

    private static byte[] decode(char[] base64Data, int numberQuadruple) {
        // byte decodedData[] = null;
        byte b1 = 0;
        byte b2 = 0;
        byte b3 = 0;
        byte b4 = 0;
        char d1 = 0;
        char d2 = 0;
        char d3 = 0;
        char d4 = 0;

        int idx = 0;
        int encodedIndex = 0;
        int dataIndex = 0;
        byte[] decodedData = new byte[(numberQuadruple) * 3];

        for (; idx < numberQuadruple - 1; idx++) {
            if (!isData((d1 = base64Data[dataIndex++])) || !isData((d2 = base64Data[dataIndex++]))
                    || !isData((d3 = base64Data[dataIndex++])) || !isData((d4 = base64Data[dataIndex++]))) {
                return new byte[0];
            } // if found "no data" just return null

            b1 = BASE64_ALPHABET[d1];
            b2 = BASE64_ALPHABET[d2];
            b3 = BASE64_ALPHABET[d3];
            b4 = BASE64_ALPHABET[d4];

            decodedData[encodedIndex++] = (byte) (b1 << 2 | b2 >> 4);
            decodedData[encodedIndex++] = (byte) (((b2 & 0xf) << 4) | ((b3 >> 2) & 0xf));
            decodedData[encodedIndex++] = (byte) (b3 << 6 | b4);
        }

        if (!isData((d1 = base64Data[dataIndex++])) || !isData((d2 = base64Data[dataIndex++]))) {
            return new byte[0]; // if found "no data" just return null
        }

        byte[] tmp = checkCharacters(base64Data, d1, d2, idx, encodedIndex, dataIndex, decodedData);
        if (tmp != null) {
            return tmp;
        }
        return decodedData;
    }

    private static byte[] checkCharacters(char[] base64Data, char d1, char d2, int idx, int encodedIndex, int dataIndex,
                                          byte[] decodedData) {
        byte b1;
        byte b2;
        char d3;
        char d4;
        byte b3;
        byte b4;
        b1 = BASE64_ALPHABET[d1];
        b2 = BASE64_ALPHABET[d2];

        d3 = base64Data[dataIndex++];
        d4 = base64Data[dataIndex++];
        if (isNotD3OrD4(d3, d4)) { // Check if they are PAD characters
            if (isPadD3AndD4(d3, d4)) {
                if ((b2 & 0xf) != 0) {
                    // last 4 bits should be zero
                    return new byte[0];
                }
                byte[] tmp = new byte[idx * 3 + 1];
                System.arraycopy(decodedData, 0, tmp, 0, idx * 3);
                tmp[encodedIndex] = (byte) (b1 << 2 | b2 >> 4);
                return tmp;
            } else if (isNotPadD3AndPadD4(d3, d4)) {
                b3 = BASE64_ALPHABET[d3];
                if ((b3 & 0x3) != 0) {
                    // last 2 bits should be zero
                    return new byte[0];
                }
                byte[] tmp = new byte[idx * 3 + 2];
                System.arraycopy(decodedData, 0, tmp, 0, idx * 3);
                tmp[encodedIndex++] = (byte) (b1 << 2 | b2 >> 4);
                tmp[encodedIndex] = (byte) (((b2 & 0xf) << 4) | ((b3 >> 2) & 0xf));
                return tmp;
            } else {
                return new byte[0];
            }
        } else { // No PAD e.g 3cQl
            b3 = BASE64_ALPHABET[d3];
            b4 = BASE64_ALPHABET[d4];
            decodedData[encodedIndex++] = (byte) (b1 << 2 | b2 >> 4);
            decodedData[encodedIndex++] = (byte) (((b2 & 0xf) << 4) | ((b3 >> 2) & 0xf));
            decodedData[encodedIndex++] = (byte) (b3 << 6 | b4);
        }
        return null;
    }

    private static boolean isNotD3OrD4(char d3, char d4) {
        return !isData((d3)) || !isData((d4));
    }

    private static boolean isNotPadD3AndPadD4(char d3, char d4) {
        return !isPad(d3) && isPad(d4);
    }

    private static boolean isPadD3AndD4(char d3, char d4) {
        return isPad(d3) && isPad(d4);
    }

    /**
     * remove WhiteSpace from MIME containing encoded Base64Hw data.
     *
     * @param data the byte array of base64 data (with WS)
     * @return the new length
     */
    private static int removeWhiteSpace(char[] data) {
        if (CommonUtil.isNull(data)) {
            return 0;
        }

        // count characters that's not whitespace
        int newSize = 0;
        int len = data.length;
        for (int i = 0; i < len; i++) {
            if (!isWhiteSpace(data[i])) {
                data[newSize++] = data[i];
            }
        }
        return newSize;
    }
}
