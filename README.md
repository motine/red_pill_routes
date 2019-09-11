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


## Decisions

- I chose **minitest over rspec** to keep dependencies low
- I chose to use the provided **source data as fixtures** for the tests.
  My rationale is, that later when this program becomes production code, the sources would be acquired dynamically anyway.
  Hence, we would then put the static files under `sources` into the `test` folder, so they semantically belong to the tests.
- Depending on the stability of the input data, we could/should write much **more tests**.
- Also, we should add more validations in during parsing, so we **detect faulty data** files.
- Some of the parsing operations (such as joining/denormalizing) could be done with a helper library or a real database.
  Again, I decided to not do this.