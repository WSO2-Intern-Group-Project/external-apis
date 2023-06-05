import ballerina/http;

# Response body with a message.
#
# + message - error message
# + lastInsertId - last inserted id from the database if any
# + data - data values
public type ResponseBody record {|
    string message;
    string|int? lastInsertId?;
    json data?;
|};

# 500 Internal server error response.
#
# + body - error message
public type AppServerError record {|
    *http:InternalServerError;
    ResponseBody body;
|};

# 400 Bad Request Error response.
#
# + body - error message
public type AppBadRequestError record {|
    *http:BadRequest;
    ResponseBody body;
|};
