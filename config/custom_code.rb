module CustomCode
  CODES = {
    # 2xxx: Success
    success:             { code: 2000, message: "Success" },
    contact_created:             { code: 2010, message: "Contact created successfully" },
    user_created:             { code: 2020, message: "User created successfully" },
    accepted:            { code: 2030, message: "Request accepted and processing" },
    user_retrieved:           { code: 2040, message: "User successfuly retrieved" },
    users_retrieved:           { code: 2050, message: "Users successfuly retrieved" },
    contacts_retrieved:           { code: 2060, message: "Contacts successfuly retrieved" },
    contact_retrieved:           { code: 2070, message: "Contact successfuly retrieved" },
    contact_updated:  {code: 2080, message: "Contact updated successfully"},
    user_updated:   {code: 2090, message: "User updated successfully"},
    contact_deleted:  {code: 2100, message: "Contact deleted successfully"},
    user_deleted:   {code: 2101, message: "User deleted successfully"},
    no_content:          { code: 2102, message: "No resource found" },

    # 1xxx: Client Errors
    bad_request:         { code: 1001, message: "Bad request" },
    unauthorized:        { code: 1002, message: "Unauthorized access" },
    forbidden:           { code: 1003, message: "Forbidden" },
    not_found:           { code: 1004, message: "Resource not found" },
    method_not_allowed:  { code: 1005, message: "Method not allowed" },
    conflict:            { code: 1006, message: "Conflict: resource already exists" },
    unprocessable:       { code: 1007, message: "Unprocessable entity" },
    too_many_requests:   { code: 1008, message: "Rate limit exceeded" },

    # 15xx: Server Errors
    internal_error:      { code: 1500, message: "Internal server error" },
    not_implemented:     { code: 1501, message: "Not implemented" },
    bad_gateway:         { code: 1502, message: "Bad gateway" },
    service_unavailable: { code: 1503, message: "Service temporarily unavailable" },

    # 3xxx: Auth-Specific
    login_success:       { code: 3000, message: "Login successful" },
    login_failed:        { code: 3001, message: "Invalid email or password" },
    registration_success: { code: 3002, message: "Registration successful" },
    registration_failed: { code: 3003, message: "Registration unsuccessful" },
    token_expired:       { code: 3004, message: "Authentication token expired" },
    token_invalid:       { code: 3005, message: "Invalid authentication token" },

    # 4xxx: User-Specific
    user_exists:         { code: 4001, message: "User already exists" },
    user_not_found:      { code: 4002, message: "User not found" },
    contact_not_found:   { code: 2060, message: "Contact not found" },
    invalid_user_data:   { code: 4003, message: "Invalid user data provided" },
    invalid_contact_data:   { code: 4004, message: "Invalid contact data provided" },
    unauthorized_route_access:        { code: 4005, message: "You are not authorized to access this route" },

    # 5xxx: Contact-Specific
    contact_exists:         { code: 5001, message: "Contact already exists" },
  }.freeze
end