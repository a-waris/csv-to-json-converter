# CSV to JSON Converter

## How to Run

### Using Docker
1. Build the Docker image: `docker build -t csv_to_json_converter .`
2. Run the tests: `docker run csv_to_json_converter`

### Without Docker
1. Install Bundler if you haven't: `gem install bundler`
2. Install required gems: `bundle install`
3. Run the tests: `ruby test_script.rb`
4. Run the script: `ruby script.rb sample.csv`

## Design Choices
- Used Ruby's standard CSV and JSON libraries for simplicity.
- Added a Gemfile for easier dependency management.
- Added error handling for file not found and malformed CSV scenarios.
