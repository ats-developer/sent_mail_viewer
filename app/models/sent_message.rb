# This file is intended to handle sent messages of user.
# Search Sent Message
#
# Created At: 04-Feb-2015
# Author : Atharva System
# Copyright:: Copyright (c) 2012-2015 Atharva System.

class SentMessage < ActiveRecord::Base
  belongs_to :user

  validates :message_id, :uniqueness => true

  def self.search(search)
    if search
      where('subject LIKE ?', "%#{search}%")
    else
      where('1=1')
    end
  end

  def to_name_or_email
    to_name || to_email
  end
end
