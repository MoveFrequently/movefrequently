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
        "%d person"
      ],
      plural: [
        "%d people"
      ]
    }.freeze

    def people_text(id, count)
        text = PEOPLE_TEXTS[count == 1 ? :singular : :plural][id % PEOPLE_TEXTS[count == 1 ? :singular : :plural].length]
        text.gsub("%d", count.to_s)
    end

    def done_text(id)
        DONE_TEXTS[id % DONE_TEXTS.length]
    end
end
