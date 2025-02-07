# Load exercises from fixture
fixture_path = Rails.root.join('test/fixtures/exercises.yml')
exercises = YAML.safe_load(File.read(fixture_path), permitted_classes: [ Time, ActiveSupport::TimeZone, ActiveSupport::TimeWithZone ], aliases: true)

# Add active exercises if the database is empty
new_exercises_active_at = Exercise.none? ? Time.now.utc : nil

exercises.each do |_, exercise_data|
    existing = Exercise.find_by(name: exercise_data['name'])

    if existing
        # Update existing exercise
        existing.update!(
            description: exercise_data['description'],
            steps: exercise_data['steps']
        )
        puts "Updated exercise: #{exercise_data['name']}"
    else
        # Create new exercise
        Exercise.create!(
            name: exercise_data['name'],
            description: exercise_data['description'],
            steps: exercise_data['steps'],
            active_at: new_exercises_active_at
        )
        puts "Created exercise: #{exercise_data['name']}"
    end
end
