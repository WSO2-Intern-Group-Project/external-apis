import ballerinax/azure_cosmosdb as cosmosdb;
import external_apis.constants;
import external_apis.types;

final cosmosdb:DataPlaneClient azureCosmosClient = check initializeDbClient();
final string dbName = cosmosConfig.dbName;

# Get police reports by nic
#
# + nic - user nic
# + return - requests json array or error

public isolated function getPoliceReportsByNIC(string nic) returns json[]|error {
        stream<types:PoliceReport, error?> result = check azureCosmosClient->queryDocuments(dbName, constants:POLICE_REPORT_CONTAINER, getPoliceReportsByNICQuery(nic));
        return from types:PoliceReport policeReport in result
            select policeReport.toJson();
}

public isolated function getIdentityByNIC(string nic) returns json|error {
        stream<types:Person, error?> result = check azureCosmosClient->queryDocuments(dbName, constants:IDENTITY_CONTAINER, getIdentityByNICQuery(nic));
        json[] outputs = check from types:Person person in result
            select person.toJson();
        if (outputs.length() == 1) {
            return outputs[0];
        }
        return;
}

public isolated function getResidentsByAddress(string address) returns json[]|error {
        stream<types:AddressReport, error?> result = check azureCosmosClient->queryDocuments(dbName, constants:ADDRESS_CONTAINER, getResidentsByAddressQuery(address));
        return from types:AddressReport addressReport in result
            select addressReport.toJson();
}
