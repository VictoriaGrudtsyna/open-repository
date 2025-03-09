#include "database.hpp"
#include <string>
#include <boost/beast/http.hpp>

namespace http = boost::beast::http;

namespace Auth {
    std::string trim_Whitespace(const std::string &str);

    bool validate_Phone(const std::string &phone);
}

#endif  // AUTH_HPP_