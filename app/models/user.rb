# This file is intended to handle users authenticated using omniauth.
# Validates user's access token
# Sent Messages Synchronization
#
# Created At: 04-Feb-2015
# Author : Atharva System
# Copyright:: Copyright (c) 2012-2015 Atharva System.

class User < ActiveRecord::Base
  has_many :sent_messages

  validates :email, presence: true, format: {:with => /\A[^@]+@([^@\.]+\.)+[^@\.]+\z/}, uniqueness: true
  validates :provider, presence: true
  validates :expires_at, presence: true

  def self.create_using_omniauth(auth)
    user = User.where(uid: auth['uid']).first_or_initialize
    user.provider = auth['provider']
    user.email = auth['extra']['raw_info']['email']
    user.access_token = auth['credentials']['token']
    user.expires_at = Time.at(auth['credentials']['expires_at']).to_datetime
    user.save
    return user
  end

  def token_expired?
    expires_at < Time.now
  end

  def sync_sent_messages
    if self.token_expired?
      Rails.logger.info "-- %s --" % [I18n.t(:token_expired, :user => self.email)]
      return false
    end
    last_sent_message = self.sent_messages.last
    imap = Net::IMAP.new('imap.gmail.com', 993, usessl = true, certs = nil, verify = false)
    imap.authenticate('XOAUTH2', self.email, self.access_token)

    mailbox_all_mail = imap.list('', '*').find{|mb| mb.attr.include?(:Sent)}
    imap.examine(mailbox_all_mail.name)

    imap.search(["FROM", "me"]).reverse[0,10].reverse.each do |message_id|
      next if last_sent_message and message_id <= last_sent_message.message_id
      envelope = imap.fetch(message_id, "ENVELOPE")[0].attr["ENVELOPE"]
      sent_message = self.sent_messages.create() do |sent|
        sent.message_id = message_id
        sent.to_name = envelope.to[0].name
        sent.to_email = "#{envelope.to[0].mailbox}@#{envelope.to[0].host}"
        sent.subject = envelope.subject
        sent.sent_date = envelope.date.to_datetime
      end
    end
  rescue Net::IMAP::NoResponseError => e
    p e.message
    return false
  end
end
