import ballerina/http;
import external_apis.database;
import external_apis.types;
import external_apis.constants;

service / on new http:Listener(9090) {

    isolated resource function get policeRecordsByNIC(string nic) returns json[]|types:AppServerError {
        json[]|error  outputs = database:getPoliceReportsByNIC(nic);
        if outputs is error {
            return <types:AppServerError>{
                body: {message: constants:INTERNAL_ERROR}
            };
        }
        return outputs;
    }

    isolated resource function get identityRecordByNIC(string nic) returns json|types:AppServerError|types:AppBadRequestError|error {
        json|error  output = database:getIdentityByNIC(nic);
        if output is error {
            return <types:AppServerError>{
                body: {message: constants:INTERNAL_ERROR}
            };
        }
        else if output == () {
            return <types:AppBadRequestError>{
                body: {message: constants:ID_NOT_FOUND}
            };
        }
        return output;
    }
    isolated resource function post residentsByAddress(@http:Header {name: "Content-Type"} string fileType, @http:Payload json data) returns json[]|types:AppServerError|types:AppBadRequestError|error {
        json payload = check data.cloneWithType();
        string address =  <string> check payload.address;
        json[]|error outputs = database:getResidentsByAddress(address);
        if outputs is error {
            return <types:AppServerError>{
                body: {message: constants:INTERNAL_ERROR}
            };
        }
        else if outputs == [] {
            return <types:AppBadRequestError>{
                body: {message: constants:ADDRESS_NOT_FOUND}
            };
        }
        return outputs;
    }
}
