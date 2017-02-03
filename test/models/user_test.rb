# This file is intended to test User validations.
#
# Created At: 04-Feb-2015
# Author : Atharva System
# Copyright:: Copyright (c) 2012-2015 Atharva System.

require 'test_helper'

class UserTest < ActiveSupport::TestCase
  def valid_params
    { provider: "google_oauth2", email: "john@example.com", expires_at: Time.now.to_datetime }
  end

  def test_valid
    user = User.new valid_params

    assert user.valid?, "Can't create with valid params: #{user.errors.messages}"
  end

  def test_invalid_without_email
    params = valid_params.clone
    params.delete :email
    user = User.new params

    refute user.valid?, "Can't be valid without email"
    assert user.errors[:email], "Missing error when without email"
  end

  def test_invalid_wit_invalid_email
    params = valid_params.clone
    params[:email] = "xyz"
    user = User.create params

    refute user.valid?, "Can't be valid with invalid email"
    assert user.errors[:email], "Missing error when with invalid email"
  end
end
