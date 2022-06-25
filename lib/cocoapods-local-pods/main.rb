
require_relative 'private_api_hooks'

module Pod
  class Podfile
    module DSL
      @@enable_local_pod_override = false
      def self.enable_local_pod_override
        @@enable_local_pod_override
      end

      def enable_local_pod_override!
        @@enable_local_pod_override = true
      end
    end
  end
end

module CocoapodsLocalPods
  PLUGIN_NAME = 'cocoapods-local-pods'

  Pod::HooksManager.register(PLUGIN_NAME, :pre_install) do |installer_context|
    if Pod::Podfile::DSL.enable_local_pod_override
      @@plugin_enabled = true
    else
      Pod::UI.warn "#{PLUGIN_NAME} is installed but the enable_local_pod_override! was not found in the Podfile."
    end
  end
end
