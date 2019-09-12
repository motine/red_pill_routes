# Red Pill Routes

This program helps Tank and Cypher to parse the data from the red_pill challenge and get it into their system.

## Getting started

```bash
docker build -f Dockerfile -t red_pill_routes .
# run the parser
docker run -v (pwd):/app red_pill_routes:latest

# or get a shell for development
docker run -it --rm -v (pwd):/app red_pill_routes:latest /bin/bash
# then you can run the script
./parser.rb
# or run an individual test
ruby test/route_test.rb
# or run all tests
rake test
```

## Notes

### Overview

A `Loader` is responsible to fetch data from a source (e.g. getting and unpacking the ZIP from the server).  
A `Database` uses such a loader to retrieve the files and then uses this content to calculate the routes.  
The `Database::Aggregator` merges multiple databases into one while fulfilling the same interface as `Database::Base`.  
The `Transmitter` is responsible for sending a database's content to the Distribusion server.

### Timezones

We assume every timezone to be UTC (+00:00) unless specified differently.
In `lib/lib.rb`, we set the environment variable for Ruby's default timezone, so using `Time.new` uses UTC.

### Stretches

`Stretch` represents a part of a route.
In the data retrieved from the sources, the connections between a route start and end node were always sorted.
Yet, one would assume, that the order might get scrambled up eventually.  
For example in `loopholes` we have stretches in the following order: ["gamma -> theta", "theta -> lambda"] for the first route.
To also allow to find these stretches in reverse order, one can use `Stretch::order` to bring them in the right sequence.
This algorithm is very limited at the moment, but can be extended.

## Decisions & Future work

- I chose **minitest over rspec** to keep dependencies low
- I chose to use downloaded versions of the **source data as fixtures** for the tests.
- We could/should write much **more tests**.
- Depending on the stability of the input data, we should add more validations during parsing, so we **detect faulty data** files (e.g. we are only checking for the correct node name in Sentinel).
- Some of the parsing operations (such as joining/denormalizing) could be done with a helper library or a real database.
- We should **not store credentials** in the code (as seen in Transmitter). Here we should add a secret storage.
