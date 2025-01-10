module ApplicationHelper
    DONE_TEXTS = [
          "I'm done!", "Nailed it!", "Feeling great!", "Mission accomplished!", "Exercise complete!",
          "Crushed it!", "Way to go!", "That felt good!", "Another one down!", "Staying healthy!",
          "Moving forward!", "Getting stronger!", "Health points +1!", "Level up!", "Achievement unlocked!",
          "Fighting sedentarism!", "Body thanking me!", "Energy boost!", "Feeling alive!", "Progress made!",
          "Victory dance!", "Success!", "Wellness win!", "Health hero!", "Movement master!",
          "Exercise champion!", "Desk warrior!", "Health streak!", "Moving mountains!", "Power move!",
          "Fitness win!", "Body boost!", "Health hack!", "Movement magic!", "Exercise excellence!",
          "Wellness warrior!", "Health hero mode!", "Movement maven!", "Exercise expert!", "Fitness fantastic!",
          "Health happening!", "Movement matters!", "Exercise engaged!", "Wellness achieved!", "Power player!",
          "Health hustler!", "Movement made!", "Exercise executed!", "Wellness win secured!", "Body blessed!",
          "Health heightened!", "Movement mastered!", "Exercise elevated!", "Vitality victory!", "Strength secured!"
        ].freeze

    BACKGROUND_COLORS = [ "bg-blue-100", "bg-cyan-100", "bg-teal-100", "bg-green-100", "bg-yellow-100", "bg-orange-100", "bg-red-100", "bg-pink-100", "bg-purple-100", "bg-indigo-100" ].freeze


    def done_text(id)
        DONE_TEXTS[id % DONE_TEXTS.length]
    end

    def bg_color(id)
        BACKGROUND_COLORS[id % BACKGROUND_COLORS.length]
    end
end
