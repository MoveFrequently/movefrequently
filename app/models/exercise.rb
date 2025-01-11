class Exercise < ApplicationRecord
    def self.dump_fixture
        File.open("#{Rails.root}/test/fixtures/exercises.yml", "w") do |file|
            file.write self.all.to_a.map { |e| [ e.name.underscore, e.attributes ] }.to_h.to_yaml
        end
    end

    extend Inference

    validates :steps, presence: true, length: { minimum: 3 }
    validates :name, presence: true
    validates :description, presence: true

    def self.next
        NextExercise.record
    end

    def self.generate_and_save!
        previous_exercises = self.order(created_at: :desc).limit(50).select(:name)
        res = generate(previous_exercises)
        self.create!(res)
    end

    def self.generate(previous_exercises = [])
        output_schema = schema do
            string :name, description: "A name for the exercise, don't include the word desk or desk exercise, just the name of the exercise"
            string :description, description: "A description of the exercise, should be concise and to the point"
            array :steps, items: :string, description: "Key instructions for step-by-step performing of the exercise. Don't include numbers or any other formatting"
         end

        instructions = <<~MSG
            You are an expert trainer. Your task is to generate a physical exercise that must be:
                * require the person to stand up at some point of the exercise.
                * doable in front or close to a desk.
                * simple and can be done without any equipment.
                * safe and effective for the user.
                * easy to follow and understand.
                * fun and engaging.
                * short and able to be done in 1-3 minutes.
                * high-intensity.

            Exercises must be varied, they must improve strength, and mobility.

            Some examples of exercises are: Burpees, Squats, Jumping Jacks, Mountain Climbers, etc.

            You are also provided a list of previous exercises, so you must not generate an exercise that is too similar to any of them.

            When generating the exercise use a tone that is friendly, and cheerful, that motivates the user to do the exercise.
        MSG

        user_message = <<~MSG
            [previous_exercises]
             #{previous_exercises.any? ? previous_exercises.map(&:name).map { |name| "- #{name}" }.join("\n") : "None"}
            [/previous_exercises]

            Generate an exercise that is safe, effective, easy to follow, fun, and short.
        MSG

        Rails.logger.info("Generating exercise: #{user_message}")

        assist(user_message, instructions: instructions, model: "gpt-4o", temperature: 1, schema: output_schema)
    end
end
