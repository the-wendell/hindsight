require_relative '../config/dependencies'

def calculations(date, stock)
  ApiUtils::Services::QuandiApi.call(date, stock)
    .yield_self { |response| ApiUtils::Services::ParseResponse.call(response) }
    .yield_self { |parsed_response| StockMetrics::Services::Calculator.call(parsed_response) }
end

loop do
  input = gets.chomp
  command, date, stock = input.split /\s/
  case command
  when 'data_for'
    puts calculations(date, stock)
  else
    puts 'Invalid command'
  end
end