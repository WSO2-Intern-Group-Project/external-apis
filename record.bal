type config record {
    string baseUrl;
    string primaryKey;
};

type Person record {|
    string NIC;
    string name;
    string address;
    string gender;
    string DoB;
    string placeOfBirth;
    string occupation;
|};

type PoliceRecord record {|
    string NIC;
    string date;
    string description;
|};

type AddressRecord record {|
    string NIC;
    string name;
    string address;
|};