class ExtramularSubject < ApplicationRecord
  belongs_to :user, optional: true
end
