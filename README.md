# Wagster

A full stack web application that allows dog owners to find potential dog buddies for their dogs.

Hosted live on Heroku - [https://wagster.herokuapp.com](https://wagster.herokuapp.com/). 
- Built using React.js on the frontend - [GitHub Repo](https://github.com/ben-zeng/wagster_frontend/)
- Built using Rails API on the backend - [GitHub Repo](https://github.com/ben-zeng/wagster-api/)

Please Note:
 
- Heroku instance might be idle, it may take 10-15 seconds to load the app whilst the frontend server wakes up, and another 10-15 seconds on the first login or registration form submit whilst the backend server wakes up.
- Currently only optimised for mobile, images will appear stretched on desktop.

### Demo

![Demo 1](./readme_images/wagster_demo_1.gif ) ![Demo 2](./readme_images/wagster_demo_2v2.gif)


### Stack used

- React v16 for frontend, bootstrapped with [Create React App](https://github.com/facebook/create-react-app)
- Jest + Enzyme for frontend testing
- Rails 6 for API based backend
- Minitest for backend testing
- CircleCI for CI/CD
- Heroku for server and database hosting
- Amazon S3 for Image Hosting
- JWT for authentication
- Material-UI for frontend theming

### To run backend server in development mode

- Clone this repo
- `$ cd wagster-api`
- `$ bundle install`
- `$ rails db:create` or `$ rails db:migrate:reset`
- `$ rails start`


### Features
- Signing up and logging in / logging out
- Protected routes
- Profile creation and editing 
- Accepting and rejecting profiles
- Viewing profile matches, which releases e-mail address of the match

