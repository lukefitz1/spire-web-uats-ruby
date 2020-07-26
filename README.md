# spire-web-uats-ruby
Automated user acceptance tests for Spire web app

Run tests in a single feature file
cucumber api_testing.feature

Run tests with a tag
cucumber --tags @api_testing

Alter the format of the output of the results
cucumber --tags @artist --format json

Save the results to a file
cucumber --tags @artist --format json -o test.json

Run tests in docker container
From the root: 
docker build -t uat-tests . 
docker run uat-tests