require '../config/environment'


if __FILE__ == $0
    if ARGV.empty?
    puts "Please provide the number of exercises to generate"
    puts "Usage: ruby generate_exercises.rb NUMBER"
    exit 1
    end

    num_exercises = ARGV[0].to_i

    if num_exercises <= 0
        puts "Please provide a positive number of exercises to generate"
        exit 1
    end

    num_exercises.times do |i|
        Exercise.generate_and_save!
    end
end
