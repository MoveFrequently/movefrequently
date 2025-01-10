class Exercise < ApplicationRecord
    def self.generate_and_save!
        Exercise.create!(description: "Exercise #{i + 1}", see_also: "See also #{i + 1}")
    end
end
