import ballerina/http;
import ballerinax/azure_cosmosdb as cosmosdb;
configurable config cosmosConfig = ?;

final cosmosdb:ConnectionConfig configuration = {
            baseUrl: cosmosConfig.baseUrl,
            primaryKeyOrResourceToken:cosmosConfig.primaryKey
        };
final cosmosdb:DataPlaneClient azureCosmosClient = check new (configuration);

service / on new http:Listener(9090) {

    resource function get policeRecordsByNIC(string NIC) returns json[]|error {
        string query = string `SELECT c.NIC, c.date, c.description FROM c  WHERE c.NIC = '${NIC}'`;
        stream<PoliceRecord, error?> result = check azureCosmosClient->queryDocuments("grama-db", "policeReportContainer", query);
        json[] outputs = check from PoliceRecord policeRecord in result  select policeRecord;
        return outputs;
    }
    resource function get residentsByAddress(string address) returns json[]|error {
        string query = string `SELECT c.NIC, c.name FROM c  WHERE c.address = '${address}'`;
        stream<AddressRecord, error?> result = check azureCosmosClient->queryDocuments("grama-db", "addressContainer", query);
        json[] outputs = check from AddressRecord addressRecord in result  select addressRecord;
        return outputs;
    }
    resource function get identityRecordByNIC(string NIC) returns json|error {
        string query = string `SELECT c.NIC, c.name, c.address, c.gender, c.DoB, c.placeOfBirth, c.occupation FROM c  WHERE c.NIC = '${NIC}'`;
        stream<Person, error?> result = check azureCosmosClient->queryDocuments("grama-db", "identityContainer", query);
        json[] outputs = check from Person person in result  select person;
        if(outputs.length() == 1){
            return outputs[0];
        }
        else{
            return {};
        }
    }
}
