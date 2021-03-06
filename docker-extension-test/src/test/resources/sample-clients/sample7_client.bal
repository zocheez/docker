// Copyright (c) 2019 WSO2 Inc. (http://www.wso2.org) All Rights Reserved.
//
// WSO2 Inc. licenses this file to you under the Apache License,
// Version 2.0 (the "License"); you may not use this file except
// in compliance with the License.
// You may obtain a copy of the License at
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing,
// software distributed under the License is distributed on an
// "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
// KIND, either express or implied.  See the License for the
// specific language governing permissions and limitations
// under the License.

import ballerina/io;
import ballerina/http;

http:Client helloWorldEP;
http:Client helloWorldSecuredEP;

public function main(string... args) {
    args = untaint args;

    helloWorldEP = new("http://" + args[0] + ":9090");
    helloWorldSecuredEP = new("https://" + args[0] + ":9696", config = {
            secureSocket: {
                trustStore: {
                    path: "${ballerina.home}/bre/security/ballerinaTruststore.p12",
                    password: "ballerina"
                },
                verifyHostname: false
            }
        });
    
    var response = helloWorldEP->get("/helloWorld/sayHello");
    if (response is http:Response) {
        io:println(response.getTextPayload());
    } else {
        io:println(response);
    }

    response = helloWorldSecuredEP->get("/helloWorld/sayHello");
    if (response is http:Response) {
        io:println(response.getTextPayload());
    } else {
        io:println(response);
    }
}
