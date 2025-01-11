module ApplicationHelper
    DONE_TEXTS = [
          "I'm done!", "Nailed it!", "Exercise complete!",
          "Crushed it!", "That felt good!", "Another one down!", "Staying healthy!",
          "Getting stronger!", "Health points +1!", "Level up!", "Achievement unlocked!",
          "Energy boost!", "Progress made!", "Victory dance!", "Exercise champion!",
          "Health streak!", "Power move!"
        ].freeze

    PEOPLE_TEXTS = {
      singular: [
        "health enthusiast", "wellness warrior", "desk warrior", "wellness seeker", "health advocate"
      ],
      plural: [
        "health enthusiasts", "wellness warriors", "desk warriors", "wellness seekers", "health advocates"
      ]
    }.freeze

    def people_text(id, count)
        text = PEOPLE_TEXTS[count == 1 ? :singular : :plural][id % PEOPLE_TEXTS[count == 1 ? :singular : :plural].length]
        if count == 1
            "one more #{text}"
        else
            "another #{count} #{text}"
        end
    end

    def done_text(id)
        DONE_TEXTS[id % DONE_TEXTS.length]
    end
end
