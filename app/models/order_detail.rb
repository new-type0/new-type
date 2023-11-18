class OrderDetail < ApplicationRecord

  enum production_status: {not_possible: 0, waiting: 1, production: 2, completed: 3 }

end
