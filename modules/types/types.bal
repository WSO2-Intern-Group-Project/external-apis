# Configuration values 
#
# + baseUrl - cosmos db url  
# + primaryKey - key of the cosmos db 
# + dbName - cosmos db name
public type Config record {
    string baseUrl;
    string primaryKey;
    string dbName;
};

# Type related to Identity container in cosmos db
#
# + name - first name of the user
# + DoB - birth date of the user 
# + NIC - nic of the user  
# + gender - gender of the user 
# + address - address of the user  
# + placeOfBirth - grama niladari domain of the user  
# + occupation - email of the user
public type Person record {|
    string NIC;
    string name;
    string address;
    string gender;
    string DoB;
    string placeOfBirth;
    string occupation;
|};

# Type related to Police report container in cosmos db
#
# + NIC - Nic of the uesr
# + date - date of the police report
# + description - description of the police report
public type PoliceReport record {|
    string NIC;
    string date;
    string description;
|};

# Type related to address container in cosmos db
#
# + NIC - Nic of the uesr
# + name - name of the user
# + address - address of the user
public type AddressReport record {|
    string NIC;
    string name;
    string address;
|};
