# Query to get requests by user
#
# + nic - email of the user
# + return - query string

public isolated function getPoliceReportsByNICQuery(string nic) returns string =>
    string `SELECT c.NIC, c.date, c.description FROM c  WHERE c.NIC = '${nic}'`;

public isolated function getIdentityByNICQuery(string nic) returns string =>
    string `SELECT c.NIC, c.name, c.address, c.gender, c.DoB, c.placeOfBirth, c.occupation FROM c  WHERE c.NIC = '${nic}'`;

public isolated function getResidentsByAddressQuery(string address) returns string =>
    string `SELECT c.NIC, c.name, c.address FROM c  WHERE c.address = '${address}'`;
