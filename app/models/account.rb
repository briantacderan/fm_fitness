class Account < ApplicationRecord
 
  # Users
  has_many :users, dependent: :destroy, :inverse_of => :account
  accepts_nested_attributes_for :users
 
  # Trainers
  has_many :trainers, dependent: :destroy, :inverse_of => :account
  accepts_nested_attributes_for :trainers
 
  has_many :schedules, dependent: :destroy, :inverse_of => :account
  accepts_nested_attributes_for :schedules
 
  # Clients
  has_many :clients, dependent: :destroy, :inverse_of => :account
  accepts_nested_attributes_for :clients
 
  # Lessons
  has_many :bookings, dependent: :destroy, :inverse_of => :account
  accepts_nested_attributes_for :bookings
 
  has_many :lesson_payments, dependent: :destroy, :inverse_of => :account
  accepts_nested_attributes_for :lesson_payments
    
end