#include "server.hpp"
#include "database.hpp"
#include <boost/asio.hpp>
#include <iostream>
#include <mutex>
#include <string>

std::mutex mutex;

int main() {
    try {
        // Инициализация базы данных PostgreSQL
        std::string connect_info = "dbname=mydb user=myuser password=mypassword hostaddr=127.0.0.1 port=5432";
        Database_Handler db_handler(connect_info);

        if (!db_handler.connect()) {
            std::cerr << "Failed to connect to PostgreSQL database." << std::endl;
            return EXIT_FAILURE;
        }

        // Инициализация Boost.Asio и запуск сервера
        boost::asio::io_context io_context;
        Server server(io_context, 8080); // Сервер слушает порт 8080

        std::cout << "Server listening on port 8080..." << std::endl;

        io_context.run();
    } catch (const std::exception& e) {
        std::cerr << "Error: " << e.what() << std::endl;
        return EXIT_FAILURE;
    }

    return 0;
}