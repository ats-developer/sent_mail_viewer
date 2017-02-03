# This file is intended to handle helper methods.
# For alert flash messages
# For datetime format
#
# Created At: 04-Feb-2015
# Author : Atharva System
# Copyright:: Copyright (c) 2012-2015 Atharva System.

module ApplicationHelper
  def alert_class_for(flash_type)
    {
        :success => 'alert-success',
        :error => 'alert-danger',
        :alert => 'alert-warning',
        :notice => 'alert-info'
    }[flash_type.to_sym] || flash_type.to_s
  end

  def datetime_format(date)
    date.strftime("%b %d")
  end
end
