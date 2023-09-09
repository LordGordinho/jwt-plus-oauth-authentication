# Hybrid Ruby on Rails Application with Devise and devise_auth_token

![imagem cover](https://raw.githubusercontent.com/LordGordinho/jwt-plus-oauth-authentication/master/app/assets/images/image_cover.png)

This project is a hybrid application built in Ruby on Rails, utilizing the Devise and devise_auth_token gems for authentication management. The application is designed to provide a hybrid experience to users, offering authentication via both web interface and API. The primary goal is to showcase the integration of these gems and the flexibility of Rails in handling authentication across different contexts.

## Features

- User authentication via web interface and API.
- Support for login and registration via GitHub OAuth.
- Authentication management through Devise and devise_auth_token gems.
- Use of either email and password or username and password for login.
- Implementation of security practices, including token expiration and strong password standards.

## How It Works

This project leverages the powerful combination of the Devise and devise_auth_token gems to provide authentication in hybrid environments. Web interface authentication is handled by the Devise gem, allowing users to register and log in using their email and password. Additionally, API authentication is managed by devise_auth_token, which provides secure and expirable authentication tokens for accessing API resources.

The project also demonstrates the flexibility of Rails by allowing users to choose between using their email or username for login, providing a more personalized experience.

## Technologies Used

- Ruby on Rails
- Devise
- devise_auth_token
- GitHub OAuth

## Contribution

Contributions are welcome! Feel free to open issues or send pull requests.

## License

This project is licensed under the [MIT License](LICENSE).
