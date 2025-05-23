# API Documentation for Address Book Application

address-book-api/
├── app.rb                    # The entry point of the app
├── config/                   # Configuration files (e.g., DB, env)
│   ├── environment.rb        # Loads gems, sets up DB and autoloads
│   └── database.yml          # ActiveRecord database settings
├── controllers/             # Sinatra route handlers
│   ├── base_controller.rb    # Parent controller (auth, CORS, json, etc.)
│   └── users_controller.rb   # Business logic related to users
├── helpers/                 # Utility methods shared across controllers
│   ├── auth_helper.rb        # JWT-based authentication logic
│   ├── cors_helper.rb        # Adds CORS headers to every request
│   └── response_helper.rb    # Common error/response utilities
├── middleware/              # Rack middleware for logging or other concerns
│   └── logger.rb             # Logs incoming HTTP requests
├── models/                  # ActiveRecord models (business data)
│   └── user.rb               # Represents the User table
├── .env                     # Environment variables like JWT_SECRET
└── Gemfile                  # Dependencies
