![Indie-Land API continuous integration](https://github.com/Lobarbon/Indie-Land-api/workflows/API%20continuous%20integration/badge.svg?branch=master)
# IndieLand
🍺 Indie-Land is a gorgeous place to discover Taiwan Indie Music activities immediately by just browsing our website. 

# I am worker!!

This worker can only run on heroku. The database for written is same as the database on  [heroku](https://indie-land-api.herokuapp.com/).

How to run a docker:
```bash=
$ rake docker:build
$ rake docker:run
```

Setup heroku:

    ```
    heroku git:remote -a indie-land-worker
    heroku container:login
    ```

Run on heroku:

    ```
    rake docker:build
    heroku container:push web
    heroku container:release web
    heroku run rake worker:run:production
    ```
