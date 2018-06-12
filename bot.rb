require 'telegram_bot'
require 'rubygems'
require 'open-uri'
require 'nokogiri'
token = 'Your own api token'
bot = TelegramBot.new(token: token)

bot.get_updates(fail_silently: true) do |message|
  puts "@#{message.from.username}: #{message.text}"
  command = message.get_command_for(bot)

  message.reply do |reply|
    case command
    when /start/i
      reply.text = "All I can do is say hello. Try the /greet command."
    when /hello/i
      greetings = ['bonjour', 'hola', 'hallo', 'sveiki', 'namaste', 'salaam', 'szia', 'halo', 'ciao']
      reply.text = "#{greetings.sample.capitalize}, #{message.from.first_name}!"
    when /cc/i
      # url = "https://www.codechef.com/users/vjcool30"
      # doc = Nokogiri::HTML(open(url))
      # reply.text = doc.css(sidebar-right).css(content).css(ns-content).css(row).inner_html
    else
      reply.text = "I have no idea what #{command.inspect} means."
    end
    puts "sending #{reply.text.inspect} to @#{message.from.username}"
    reply.send_with(bot)
  end
end
