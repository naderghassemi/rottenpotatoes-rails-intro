
class Movie < ActiveRecord::Base
    def self.all_ratings
        # Return a list of unique ratings from the database
        return self.uniq.pluck(:rating).sort
        #return ['G', 'PG', 'PG-13', 'R']
    end
end
