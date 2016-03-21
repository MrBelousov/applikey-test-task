class Provider < ActiveRecord::Base

  enum type: {
           facebook: 0
       }

end
