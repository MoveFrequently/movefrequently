module ApplicationHelper
    def done_texts
        [
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
        ]
    end

    def done_text(id)
        done_texts[id % done_texts.length]
    end
end
