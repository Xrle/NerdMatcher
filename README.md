# NerdMatcher

A simple dating app built using Ruby on Rails for COM2025 Web Applications Development

## Features:
- User profiles and authentication using encrypted passwords.
- See other users' profiles and like/dislike/match with them.
- Upload photos to your profile which are automatically resized and can be seen by other users viewing your profile.
- Chat in real time with users you match with using WebSockets.

## Setup:
- Install Ruby for your platform
- Install Bundler for dependancy management using `gem install bundler`
- Use `bundle install` to install the dependancies and then run the app with `rails s`.
- For photos to load correctly, delete the provided `/config/credentials.yml.enc` and then run `rails credentials:edit` and add `derivation_key: <YOUR KEY>` on a new line. This key is used to generate links to resized photos on-the-fly. 

