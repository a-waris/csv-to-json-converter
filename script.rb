require 'csv'
require 'json'

def read_csv(file_path)
  products = []
  begin
    headers = CSV.open(file_path, 'r', headers: true) { |csv| csv.first.headers }
    expected_headers = ['Product ID', 'Product Name', 'Description', 'Price', 'Availability']

    missing_headers = expected_headers - headers

    if headers.nil? || !missing_headers.empty?
        puts "Error: Missing headers in the CSV file: #{missing_headers.join(', ')}"
        return nil
    end

    CSV.foreach(file_path, headers: true) do |row|
      next if row.nil? || row.empty?

      product = {
        'Product ID' => row.fetch('Product ID', nil),
        'Product Name' => row.fetch('Product Name', nil),
        'Description' => row.fetch('Description', nil),
        'Price' => row.fetch('Price', nil)&.to_f,  # Convert to float only if not nil
        'Availability' => row.fetch('Availability', nil)
      }
      products << product
    end

    return nil if products.empty?
  rescue Errno::ENOENT
    puts "File not found."
    return nil
  rescue CSV::MalformedCSVError
    puts "Malformed CSV file."
    return nil
  end
  products
end

def generate_json(products)
  products.to_json
end

if __FILE__ == $0
  file_path = ARGV[0] || 'sample.csv'
  products = read_csv(file_path)
  if products
    json_output = generate_json(products)
    puts json_output
  end
end
