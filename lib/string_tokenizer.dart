/*
 *  Licensed to the Apache Software Foundation (ASF) under one or more
 *  contributor license agreements.  See the NOTICE file distributed with
 *  this work for additional information regarding copyright ownership.
 *  The ASF licenses this file to You under the Apache License, Version 2.0
 *  (the "License"); you may not use this file except in compliance with
 *  the License.  You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 *  Unless required by applicable law or agreed to in writing, software
 *  distributed under the License is distributed on an "AS IS" BASIS,
 *  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 *  See the License for the specific language governing permissions and
 *  limitations under the License.
 */

/*
 * This file is based on code from the Apache Harmony Project.
 * http://svn.apache.org/repos/asf/harmony/enhanced/classlib/trunk/modules/luni/src/main/java/java/util/StringTokenizer.java
 */

/**
 * String tokenizer is used to break a string apart into tokens.
 */
library string_tokenizer;

/**
 * String tokenizer is used to break a string apart into tokens.
 *
 * If returnDelimiters is false, successive calls to [nextToken] return maximal
 * blocks of characters that do not contain a delimiter.
 *
 * If returnDelimiters is true, delimiters are considered to be tokens, and
 * successive calls to nextToken() return either a one character delimiter, or a
 * maximal block of text between delimiters.
 */
class StringTokenizer {

  String string;

  String delimiters;

  bool returnDelimiters;

  int position;

  /**
   * Constructs a new StringTokenizer for string using the specified
   * delimiters and returning delimiters as tokens when specified.
   *
   * @param string
   *            the string to be tokenized
   * @param delimiters
   *            the delimiters to use, defaults to whitespace
   * @param returnDelimiters
   *            true to return each delimiter as a token
   */
  StringTokenizer(String string, [String delimiters = " \t\n\r\f", bool returnDelimiters = false]) {
    if (string != null) {
      this.string = string;
      this.delimiters = delimiters;
      this.returnDelimiters = returnDelimiters;
      this.position = 0;
    } else {
      throw new ArgumentError();
    }
  }

  /**
   * Returns the number of unprocessed tokens remaining in the string.
   *
   * @return number of tokens that can be retreived before an exception will
   *         result
   */
  int countTokens() {
    int count = 0;
    bool inToken = false;
    for (int i = position,
        length = string.length; i < length; i++) {
      if (delimiters.indexOf(string[i], 0) >= 0) {
        if (returnDelimiters) count++;
        if (inToken) {
          count++;
          inToken = false;
        }
      } else {
        inToken = true;
      }
    }
    if (inToken) {
      count++;
    }
    return count;
  }

  /**
   * Returns true if unprocessed tokens remain.
   *
   * @return true if unprocessed tokens remain
   */
  bool hasMoreElements() {
    return hasMoreTokens();
  }

  /**
   * Returns true if unprocessed tokens remain.
   *
   * @return true if unprocessed tokens remain
   */
  bool hasMoreTokens() {
    int length = string.length;
    if (position < length) {
      if (returnDelimiters) {
        // there is at least one character and even if
        // it is a delimiter it is a token
        return true;
      }

      // otherwise find a character which is not a delimiter
      for (int i = position; i < length; i++) {
        if (delimiters.indexOf(string[i], 0) == -1) {
          return true;
        }
      }
    }
    return false;
  }

  /**
   * Returns the next token in the string as an Object.
   *
   * @return next token in the string as an Object
   * @exception NoSuchElementException
   *                if no tokens remain
   */
  Object nextElement() {
    return nextToken();
  }

  /**
   * Returns the next token in the string as a String. The delimiters used may be
   * changed to the specified [delims].
   *
   * @return next token in the string as a String
   * @exception NoSuchElementException
   *                if no tokens remain
   */
  String nextToken([String delims = null]) {
    if (delims != null) {
      this.delimiters = delims;
    }
    int i = position;
    int length = string.length;

    if (i < length) {
      if (returnDelimiters) {
        if (delimiters.indexOf(string[position], 0) >= 0) {
          return string[position++];
        }
        for (position++; position < length; position++) {
          if (delimiters.indexOf(string[position], 0) >= 0) {
            return string.substring(i, position);
          }
        }
        return string.substring(i);
      }

      while (i < length && delimiters.indexOf(string[i], 0) >= 0) {
        i++;
      }
      position = i;
      if (i < length) {
        for (position++; position < length; position++) {
          if (delimiters.indexOf(string[position], 0) >= 0) {
            return string.substring(i, position);
          }
        }
        return string.substring(i);
      }
    }
    throw new NoSuchElementException();
  }

}

class NoSuchElementException extends Error {
}
