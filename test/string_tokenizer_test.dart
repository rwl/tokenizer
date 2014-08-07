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

import 'package:unittest/unittest.dart';
import 'package:string_tokenizer/string_tokenizer.dart';

main() {

  test('delimiters', () {
    StringTokenizer st = new StringTokenizer("This:is:a:test:String", ":");
    expect(st.countTokens() == 5 && (st.nextElement() == "This"), isTrue, reason: "Created incorrect tokenizer");
  });

  test('returnDelimiters', () {
    StringTokenizer st = new StringTokenizer("This:is:a:test:String", ":", true);
    st.nextElement();
    expect(st.countTokens() == 8 && (st.nextElement() == ":"), isTrue, reason: "Created incorrect tokenizer");
  });

  test('countTokens', () {
    StringTokenizer st = new StringTokenizer("This is a test String");

    expect(st.countTokens(), equals(5), reason: "Incorrect token count returned");
  });

  test('hasMoreElements', () {
    StringTokenizer st = new StringTokenizer("This is a test String");
    st.nextElement();
    expect(st.hasMoreElements(), isTrue, reason: "hasMoreElements returned incorrect value");
    st.nextElement();
    st.nextElement();
    st.nextElement();
    st.nextElement();
    expect(!st.hasMoreElements(), isTrue, reason: "hasMoreElements returned incorrect value");
  });

  test('hasMoreTokens', () {
    StringTokenizer st = new StringTokenizer("This is a test String");
    for (int counter = 0; counter < 5; counter++) {
      expect(st.hasMoreTokens(), isTrue, reason: "StringTokenizer incorrectly reports it has no more tokens");
      st.nextToken();
    }
    expect(!st.hasMoreTokens(), isTrue, reason: "StringTokenizer incorrectly reports it has more tokens");
  });

  test('nextElement', () {
    StringTokenizer st = new StringTokenizer("This is a test String");
    expect(st.nextElement() as String, equals("This"), reason: "nextElement returned incorrect value");
    expect(st.nextElement() as String, equals("is"), reason: "nextElement returned incorrect value");
    expect(st.nextElement() as String, equals("a"), reason: "nextElement returned incorrect value");
    expect(st.nextElement() as String, equals("test"), reason: "nextElement returned incorrect value");
    expect(st.nextElement() as String, equals("String"), reason: "nextElement returned incorrect value");
    expect(() => st.nextElement(), throwsA(new isInstanceOf<NoSuchElementException>()), reason: "nextElement failed to throw a NoSuchElementException when it should have been out of elements");
  });

  test('nextToken', () {
    StringTokenizer st = new StringTokenizer("This is a test String");
    expect(st.nextToken(), equals("This"), reason: "nextToken returned incorrect value");
    expect(st.nextToken(), equals("is"), reason: "nextToken returned incorrect value");
    expect(st.nextToken(), equals("a"), reason: "nextToken returned incorrect value");
    expect(st.nextToken(), equals("test"), reason: "nextToken returned incorrect value");
    expect(st.nextToken(), equals("String"), reason: "nextToken returned incorrect value");
    expect(() => st.nextToken(), throwsA(new isInstanceOf<NoSuchElementException>()), reason: "nextToken failed to throw a NoSuchElementException when it should have been out of elements");
  });

  test('nextToken_String', () {
    StringTokenizer st = new StringTokenizer("This is a test String");
    expect(st.nextToken(" "), equals("This"), reason: "nextToken(String) returned incorrect value with normal token String");
    expect(st.nextToken("tr"), equals(" is a "), reason: "nextToken(String) returned incorrect value with custom token String");
    expect(st.nextToken(), equals("es"), reason: "calling nextToken() did not use the new default delimiter list");
  });

  /*test('hasMoreElements_NPE', () {
    StringTokenizer stringTokenizer = new StringTokenizer("", null, true);
    expect(() => stringTokenizer.hasMoreElements(), throwsNoSuchMethodError, reason: "should throw NoSuchMethodError");

    stringTokenizer = new StringTokenizer("", null);
    expect(() => stringTokenizer.hasMoreElements(), throwsNoSuchMethodError, reason: "should throw NoSuchMethodError");
  });

  test('hasMoreTokens_NPE', () {
    StringTokenizer stringTokenizer = new StringTokenizer("", null, true);
    expect(() => stringTokenizer.hasMoreTokens(), throwsNoSuchMethodError, reason: "should throw NoSuchMethodError");

    stringTokenizer = new StringTokenizer("", null);
    expect(() => stringTokenizer.hasMoreTokens(), throwsNoSuchMethodError, reason: "should throw NoSuchMethodError");
  });

  test('nextElement_NPE', () {
    StringTokenizer stringTokenizer = new StringTokenizer("", null, true);
    expect(() => stringTokenizer.nextElement(), throwsNoSuchMethodError, reason: "should throw NoSuchMethodError");

    stringTokenizer = new StringTokenizer("", null);
    expect(() => stringTokenizer.nextElement(), throwsNoSuchMethodError, reason: "should throw NoSuchMethodError");
  });

  test('nextToken_NPE', () {
    StringTokenizer stringTokenizer = new StringTokenizer("", null, true);
    expect(() => stringTokenizer.nextToken(), throwsNoSuchMethodError, reason: "should throw NoSuchMethodError");

    stringTokenizer = new StringTokenizer("", null);
    expect(() => stringTokenizer.nextToken(), throwsNoSuchMethodError, reason: "should throw NoSuchMethodError");
  });

  test('nextToken_String_NPE', () {
    StringTokenizer stringTokenizer = new StringTokenizer("");
    expect(() => stringTokenizer.nextToken(null), throwsNoSuchMethodError, reason: "should throw NoSuchMethodError");
  });*/
}
