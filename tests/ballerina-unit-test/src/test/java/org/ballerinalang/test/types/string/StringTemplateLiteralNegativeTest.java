/*
 * Copyright (c) 2017, WSO2 Inc. (http://www.wso2.org) All Rights Reserved.
 *
 * WSO2 Inc. licenses this file to you under the Apache License,
 * Version 2.0 (the "License"); you may not use this file except
 * in compliance with the License.
 * You may obtain a copy of the License at
 *
 * http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing,
 * software distributed under the License is distributed on an
 * "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
 * KIND, either express or implied. See the License for the
 * specific language governing permissions and limitations
 * under the License.
 */
package org.ballerinalang.test.types.string;

import org.ballerinalang.launcher.util.BAssertUtil;
import org.ballerinalang.launcher.util.BCompileUtil;
import org.ballerinalang.launcher.util.CompileResult;
import org.testng.Assert;
import org.testng.annotations.Test;

/**
 * Test class for String Template Literal negative tests.
 */
public class StringTemplateLiteralNegativeTest {

    private CompileResult resultNegative;

    @Test(description = "Test string template literal with errors")
    public void testStringTemplateLiteralNegativeCases() {
        resultNegative = BCompileUtil.compile("test-src/types/string/string-template-literal-negative.bal");
        Assert.assertEquals(resultNegative.getErrorCount(), 2);
        //testUndefinedSymbol
        BAssertUtil.validateError(resultNegative, 0, "undefined symbol 'name'", 2, 32);
        //testIncompatibleTypes
        BAssertUtil.validateError(resultNegative, 1,
                "incompatible types: expected 'string', found 'json'", 8, 32);
    }

    @Test(description = "Test string template literal syntax errors")
    public void testStringTemplateLiteralSyntaxNegativeCases() {
        resultNegative = BCompileUtil.compile("test-src/types/string/string-template-literal-syntax-negative.bal");
        Assert.assertEquals(resultNegative.getErrorCount(), 9);
        int index = 0;
        BAssertUtil.validateError(resultNegative, index++,
                "mismatched input '}'. expecting {'is', '?', '+', '-', '*', '/', '%', '==', '!=', '>', '<', '>=', " +
                        "'<=', '&&', '||', '===', '!==', '&', '^', '...', '|', '?:', '->>', '..<', ExpressionEnd}",
                                  4, 71);
        BAssertUtil.validateError(resultNegative, index++, "extraneous input '}'", 4, 72);
        BAssertUtil.validateError(resultNegative, index++,
                "mismatched input ';'. expecting {'[', '?', '|', Identifier}", 5, 13);
        BAssertUtil.validateError(resultNegative, index++, "missing token ';' before '('", 8, 33);
        BAssertUtil.validateError(resultNegative, index++, "mismatched input 'returns'. expecting {'[', '?', '|', " +
                "Identifier}", 8, 36);
        BAssertUtil.validateError(resultNegative, index++, "mismatched input '{'. expecting {'[', '?', '|', " +
                                          "Identifier}",
                8, 53);
        BAssertUtil.validateError(resultNegative, index++, "invalid token '}'", 10, 36);
        BAssertUtil.validateError(resultNegative, index++, "mismatched input '}'. expecting {'[', '?', '|', " +
                                          "Identifier}",
                10, 36);
        BAssertUtil.validateError(resultNegative, index, "extraneous input '}'", 12, 1);
    }
}
