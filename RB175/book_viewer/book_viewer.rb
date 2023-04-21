require "sinatra"
require "sinatra/reloader"
require "tilt/erubis"

def toc
  File.readlines("data/toc.txt")
end

helpers do
  def in_paragraphs(text)
    text.join.split("\n\n").map.with_index do |paragraph, number|
      "<p id=#{number + 1}>#{paragraph}</p>"
    end.join
  end

  def bolden_query(text, query)
    text.gsub(query, "<strong>#{query}</strong>")
  end
end

not_found do
  redirect "/"
end

before do
  @table_of_contents = File.readlines("data/toc.txt")
end

get "/" do
  @title = "The Adventures of Sherlock Holmes"
  erb :home
end

toc.each.with_index(1) do |title, number|
  get "/chapter/#{number}" do
    @chapter_title = "Chapter #{number}: #{title}"
    @chapter = File.readlines("data/chp#{number}.txt")
    redirect "/" unless (1..toc.size).cover?(number)
    erb :chapter
  end
end

def get_nums(str)
  str.gsub(/[^0-9]/, '').to_i
end

def find_matches(query)
  results = {}
  ch_names = File.readlines("data/toc.txt").map(&:chop)
  ch_file_names = Dir.new("data").children.keep_if do |name|
                    name.start_with?('chp') && name.end_with?('.txt')
                  end
  ch_file_names.sort_by! { |name| get_nums(name) }
  ch_file_names.each_with_index do |filename, num|
    paragraphs = File.read("data/#{filename}").split("\n\n")
    paragraphs.each_with_index do |paragraph, id|
      if paragraph.include?(query)
        chapter_exists = results.keys.include?(ch_names[num])
        data = [num + 1, id + 1, paragraph]

        results[ch_names[num]].push(data) if chapter_exists
        results[ch_names[num]] = data if !chapter_exists
      end
    end
  end

  results
end

get "/search" do
  @results = params[:query] ? find_matches(params[:query]) : {}
  erb :search
end
