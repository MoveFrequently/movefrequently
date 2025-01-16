class Admin::Exercise < Exercise
  def unwrap
    Exercise.new(self.attributes)
  end
end
