require 'minitest/autorun'
require_relative 'script'

class TestCSVtoJSON < Minitest::Test
  def test_read_csv_success
    puts "Running test_read_csv_success..."
    products = read_csv('sample.csv')
    refute_nil products, "Returned value should not be nil"
    assert_equal '1', products[0]['Product ID']
    assert_equal 700.00, products[0]['Price'].to_f
    puts "test_read_csv_success passed."
  end

  def test_read_csv_empty_file
    puts "Running test_read_csv_empty_file..."
    products = read_csv('empty.csv')
    assert_nil products, "Returned value should be nil for an empty CSV"
    puts "test_read_csv_empty_file passed."
  end

  def test_read_csv_file_not_found
    puts "Running test_read_csv_file_not_found..."
    products = read_csv('non_existent.csv')
    assert_nil products, "Returned value should be nil for a non-existent CSV"
    puts "test_read_csv_file_not_found passed."
  end

  def test_read_csv_malformed_file
    puts "Running test_read_csv_malformed_file..."
    products = read_csv('malformed.csv')
    assert_nil products, "Returned value should be nil for a malformed CSV"
    puts "test_read_csv_malformed_file passed."
  end

  def test_generate_json
    puts "Running test_generate_json..."
    products = [
        {'Product ID' => '1', 'Price' => 10.0}, 
        {'Product ID' => '2', 'Price' => 20.0},
        {'Product ID' => '3', 'Price' => 30.0},
        {'Product ID' => '4', 'Price' => 40.0}
    ]

    json_output = generate_json(products)
    assert_equal '[{"Product ID":"1","Price":10.0},{"Product ID":"2","Price":20.0},{"Product ID":"3","Price":30.0},{"Product ID":"4","Price":40.0}]', json_output
    puts "test_generate_json passed."
  end

  def test_read_csv_missing_headers
    puts "Running test_read_csv_missing_headers..."
    # Capture the standard output
    output = capture_io do
      read_csv('missing_headers.csv')
    end.first.strip

    assert_equal "Error: Missing headers in the CSV file: Availability", output
    puts "test_read_csv_missing_headers passed."
  end

  def test_read_csv_no_headers
    puts "Running test_read_csv_no_headers..."
    # Capture the standard output
    output = capture_io do
      read_csv('no_headers.csv')
    end.first.strip

    expected_missing_headers = "Product ID, Product Name, Description, Price, Availability"
    assert_equal "Error: Missing headers in the CSV file: #{expected_missing_headers}", output
    puts "test_read_csv_no_headers passed."
  end

end