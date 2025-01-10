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
    STEP_COLORS = [ "bg-blue-100", "bg-cyan-100", "bg-teal-100", "bg-green-100", "bg-yellow-100", "bg-orange-100", "bg-red-100", "bg-pink-100", "bg-purple-100", "bg-indigo-100" ].freeze

    PEOPLE_TEXTS = {
      singular: [
        "motivated person", "health enthusiast", "wellness warrior", "active professional", "desk warrior",
        "person who fights sedentarism", "movement champion", "health-conscious person", "vitality seeker", "wellness achiever",
        "person who will live healthier", "fitness enthusiast", "health hero", "movement master", "wellness pioneer",
        "active achiever", "health advocate", "movement motivator", "wellness seeker", "fitness warrior",
        "health champion", "active adventurer", "wellness wanderer", "movement maker", "vitality veteran",
        "health hustler", "active ambassador", "wellness walker", "movement mentor", "fitness follower",
        "health helper", "active ally", "wellness winner", "movement maven", "vitality voyager",
        "health hopeful", "active aspirant", "wellness watcher", "movement mover", "fitness friend",
        "health harmonizer", "active advocate", "wellness worker", "movement missionary", "vitality visionary"
      ],
      plural: [
        "motivated people", "health enthusiasts", "wellness warriors", "active professionals", "desk warriors",
        "people who fight sedentarism", "movement champions", "health-conscious folks", "vitality seekers", "wellness achievers",
        "people who will live healthier", "fitness enthusiasts", "health heroes", "movement masters", "wellness pioneers",
        "active achievers", "health advocates", "movement motivators", "wellness seekers", "fitness warriors",
        "health champions", "active adventurers", "wellness wanderers", "movement makers", "vitality veterans",
        "health hustlers", "active ambassadors", "wellness walkers", "movement mentors", "fitness followers",
        "health helpers", "active allies", "wellness winners", "movement mavens", "vitality voyagers",
        "health hopefuls", "active aspirants", "wellness watchers", "movement movers", "fitness friends",
        "health harmonizers", "active advocates", "wellness workers", "movement missionaries", "vitality visionaries"
      ]
    }.freeze

    def people_text(id, count)
        text = PEOPLE_TEXTS[count == 1 ? :singular : :plural][id % PEOPLE_TEXTS[count == 1 ? :singular : :plural].length]
        "#{count} #{text}"
    end

    def done_text(id)
        DONE_TEXTS[id % DONE_TEXTS.length]
    end

    def bg_color(id)
        BACKGROUND_COLORS[id % BACKGROUND_COLORS.length]
    end

    def step_color(id)
        STEP_COLORS[id % STEP_COLORS.length]
    end
end
