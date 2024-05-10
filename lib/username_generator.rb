class UsernameGenerator
  FAKER_METHODS = [
    :game_title,
    :finance_ticker,
    :fantasy_character,
    :animal,
    :coffee_blend,
    :big_bang_theory,
    :breaking_bad,
    :family_guy,
    :game_of_thrones,
    :simpsons,
    :star_trek,
    :south_park,
    :spongebob,
    :parks_and_rec
  ]

  class << self
    def generate
      (send(FAKER_METHODS.sample)[0..15] + rand(9999).to_s).squish.parameterize.underscore
    end

    def game_title
      Faker::Game.title
    end

    def finance_ticker
      Faker::Finance.ticker
    end

    def fantasy_character
      Faker::Fantasy::Tolkien.character
    end

    def animal
      Faker::Creature::Animal.name
    end

    def coffee_blend
      Faker::Coffee.blend_name
    end

    def big_bang_theory
      Faker::TvShows::BigBangTheory.character
    end

    def breaking_bad
      Faker::TvShows::BreakingBad.character
    end

    def family_guy
      Faker::TvShows::FamilyGuy.character
    end

    def game_of_thrones
      Faker::TvShows::GameOfThrones.character
    end

    def simpsons
      Faker::TvShows::Simpsons.character
    end

    def star_trek
      Faker::TvShows::StarTrek.character
    end

    def south_park
      Faker::TvShows::SouthPark.character
    end

    def spongebob
      Faker::TvShows::Spongebob.character
    end

    def parks_and_rec
      Faker::TvShows::ParksAndRec.character
    end
  end
end
