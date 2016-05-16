# Patches Redmine's RolesController.
require 'redmine_gdrive/tracker_helper'

module RedmineGdrive
  module RolesControllerPatch
    def self.included(base)
      base.send(:include, InstanceMethods)
      base.class_eval do
        unloadable
        before_filter :store_translations_gdrive
      end
    end

    module InstanceMethods
      def store_translations_gdrive
        Tracker.all.each do |t|
          permission_key = ('permission_' + RedmineGdrive::TrackerHelper.permission(t, 'view_gdrive').to_s).to_sym
          I18n.backend.store_translations(:en, permission_key => l(:view_gdrive, t.name))
        end
      end
    end
  end
end
