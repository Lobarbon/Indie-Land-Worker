![Indie-Land API continuous integration](https://github.com/Lobarbon/Indie-Land-api/workflows/API%20continuous%20integration/badge.svg?branch=master)
# IndieLand
🍺 Indie-Land is a gorgeous place to discover Taiwan Indie Music activities immediately by just browsing our website. 

# I am worker!!
How to run on heroku:
    `heroku git:remote -a indie-land-worker`
    `heroku container:login`
    `heroku container:push web`
    `heroku container:release web`
    `heroku run worker:run:production`

[Ruby]: https://www.ruby-lang.org/en/
[Bootstrap]: https://getbootstrap.com/
[http://localhost:9292]: http://localhost:9292
[Indie-Land]: https://github.com/Lobarbon/Indie-Land.git
[ER-Diagram]: https://github.com/Lobarbon/Indie-Land/blob/database/png/ER_Diagram.png
