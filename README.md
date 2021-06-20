# Mi bodega App

## Introduction

This project allows to manage storage units, creating boxes and items.

The main functionalities are users registration, (email, password, account, plan subscription), signin, signout, invite users to account, switching account, create boxes (limited/unlimited according to plan subscription), QR Code generation to created box url, add items (description, picture, "in use" state) to a box, or move item to another box of the same account, see billing information. This app was made using Ruby on Rails (RoR) framework with focus mostly on backend functionalities but it includes a basic view to use.


## Demo

Check the demo version at: https://mi-bodega-app-ror.herokuapp.com/


## How users can get started with?

### Pre-requisites

Before starting, it is necessary to have already installed and configured in your system:
  - Git ver. 2.11+
  - Ruby ver. 2.7.2+
  - Ruby on rails ver. 6.1.3+ (running on port 3000)
  - SQLite3 ver. 3.31.1+
  - NodeJS ver. 14.16.0+
  - Yarn 1.22.10+

It is also necessary an Stripe account and setup a few components like:
  - Configure a customer portal in stripe dashboard (for billing portal integration with the app)
  - Having 3 products (related to plans: Free, Moderate, Unlimited)
  - Having 3 prices attached to the previous products
  - Stripe keys configured in environment variables example:
      STRIPE_PUBLISHABLE_KEY=xxxxxxx
      STRIPE_SECRET_KEY=xxxxxxx

See Stripe documentation for more information https://stripe.com/docs

### Considerations

Currently it is necessary to have the three plans with name Free, Moderate, Unlimited in the DB and the prices associated with each, check the seed file in db directory for guidance. 

Stripe is used as a payment gateway in test mode.

### Start

Clone the repository to have the local project:
``` sh
git clone git@github.com:SneyderHOL/mi_bodega.git
```

Get inside the path of the project:
``` sh
cd mi_bodega
```

Installing dependecies:
``` sh
yarn install
```
``` sh
bundle install
```

Create database tables:
``` sh
rails db:migrate
```

Configure Stripe keys in environment variables, example:
``` sh
STRIPE_PUBLISHABLE_KEY=xxxxxxx
STRIPE_SECRET_KEY=xxxxxxx
```

Add plans and prices to db, update the seed file, replace the stripe's fields with your own, and you could replace the box_limit value in the free and moderate plan if you like
``` sh
rails db:seed
```

Run app:
``` sh
rails s
```

Checking app from browser at:

localhost:3000

Check Stripe documentation on test credit card so you can use in the registration/signup feature
