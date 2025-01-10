#! /usr/bin/env ruby
require_relative '../config/environment'

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

    num_batches = (num_exercises / 20.0).ceil
    num_batches.times do |batch|
      remaining = num_exercises - (batch * 20)
      batch_size = [ 20, remaining ].min

      puts "Generating batch #{batch + 1}/#{num_batches} (#{batch_size} exercises)..."

      pool = Concurrent::FixedThreadPool.new(batch_size)
      futures = []

      batch_size.times do |i|
        futures << Concurrent::Future.execute(executor: pool) do
          puts "Starting exercise #{batch * 20 + i + 1}/#{num_exercises}..."
          Exercise.generate_and_save!
          puts "Completed exercise #{batch * 20 + i + 1}/#{num_exercises}"
        end
      end

      futures.each(&:value)
      pool.shutdown
      pool.wait_for_termination

      puts "Completed batch #{batch + 1}/#{num_batches}"
    end

    Exercise.dump_fixture
end
