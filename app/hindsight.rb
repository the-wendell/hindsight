require_relative '../config/dependencies'

loop do
  input = gets.chomp
  command, date, stock = input.split /\s/
  case command
  when 'eod-history-for'
    puts Services::StockHistoryMeme.call(date, stock)
  when 'exit'
    return
  else
    puts 'Invalid command'
  end
end